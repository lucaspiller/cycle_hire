#!/usr/bin/env ruby

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
end

api = CycleHireApi.new
api.authenticate($username, $password)
