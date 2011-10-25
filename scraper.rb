#!/usr/bin/env ruby
# encoding: utf-8

require 'httparty'
require 'nokogiri'

unless ARGV.size == 2
  abort "Usage: #{$0} username password"
end

$username = ARGV[0]
$password = ARGV[1]

class CycleHireApi
  include HTTParty

  base_uri 'https://web.barclayscyclehire.tfl.gov.uk/'

  def authenticate(username, password)
    # initial request to get csrf
    response1 = self.class.get('/')
    @cookies = get_cookies_from_response(response1)

    # get csrf
    doc = Nokogiri::HTML(response1.body)
    csrf = doc.xpath("//input[@id='login__csrf_token']").first.attribute('value').value

    # authentication request
    options = {
      :query => {
        'login[Email]' => username,
        'login[Password]' => password,
        'login[_csrf_token]' => csrf
      },
      :headers => {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Cookie' => @cookies
      }
    }
    response2 = self.class.post('/', options)
    @cookies = get_cookies_from_response(response1)
    raise AuthenticateError unless response2.body =~ /Account Summary/
    true
  end

  def fetch_history
    options = {
      :headers => {
        'Cookie' => @cookies
      }
    }
    response = self.class.get('/account/activity', options)

    # get table
    doc = Nokogiri::HTML(response.body)
    rows = doc.xpath("//table[@summary='My Account - Activity log']/tbody/tr")
    rows.collect do |row|
      # get column text from rows
      columns = row.xpath('td').collect do |column|
        column.inner_text.strip
      end

      # ignore the header and other column types
      if columns[4] == 'Hire'
        start_time = parse_time(columns[0])
        end_time = parse_time(columns[1])
        cost = parse_cost(columns[5])
        duration = ((end_time - start_time) / 60).to_i
        {
          :start_time => start_time,
          :start_station => columns[2],
          :end_time => end_time,
          :end_station => columns[3],
          :cost => cost,
          :duration => duration
        }
      else
        nil
      end
    end.compact
  end

  class AuthenticateError < Exception
  end

  protected

  def get_cookies_from_response(httparty_response)
    # TODO there must be a better way to do this
    cookies_array = httparty_response.response.to_hash['set-cookie']

    cookies_array.map do |cookie|
      cookie.split(';').first
    end.join('; ')
  end

  # the data in the tables is seperated by a br, which the inner_text
  # method strips, as such dates come in as "11 Oct 201109:15"
  def parse_time(string)
    if string =~ /(.*)([0-9]{2}:[0-9]{2})/
      Time.parse($1 + " " + $2 + " BST")
    end
  end

  def parse_cost(string)
    if string =~ /£([0-9]+\.[0-9]{2})/
      $1.to_f
    end
  end
end

api = CycleHireApi.new
api.authenticate($username, $password)
data = api.fetch_history
puts data.to_yaml
