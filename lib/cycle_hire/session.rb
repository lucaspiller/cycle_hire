require 'httparty'
require 'nokogiri'

class CycleHire::Session
  include HTTParty

  base_uri 'https://web.barclayscyclehire.tfl.gov.uk/'

  def initialize(email, password)
    @email = email
    @password = password
  end

  def authenticate!
    # initial request to get csrf
    csrf_response = make_request(:get, '/')
    doc = Nokogiri::HTML(csrf_response.body)
    csrf = doc.xpath("//input[@id='login__csrf_token']").first.attribute('value').value

    # authentication request
    options = {
      :query => {
        'login[Email]' => @email,
        'login[Password]' => @password,
        'login[_csrf_token]' => csrf
      },
      :headers => {
        'Content-Type' => 'application/x-www-form-urlencoded',
      }
    }
    authentication_response = make_request(:post, '/', options)
    raise AuthenticationError unless authentication_response.body =~ /Account Summary/
    self
  end

  def journeys
    response = make_request(:get, '/account/activity')
    parser = CycleHire::JourneyParser.new(response.body)
    parser.parse
  end

  class AuthenticationError < Exception
  end

  protected

  def make_request(method, path, options = {})
    options[:headers] ||= {}
    options[:headers]['Cookie'] = @cookies if @cookies
    response = self.class.send(method, path, options)
    set_cookies_from_response(response)
    response
  end

  def set_cookies_from_response(httparty_response)
    # TODO there must be a better way to do this
    headers = httparty_response.response.to_hash
    if headers['set-cookie']
      @cookies = headers['set-cookie'].map do |cookie|
        cookie.split(';').first
      end.join('; ')
    end
  end
end
