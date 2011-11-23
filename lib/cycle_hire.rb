require 'open-uri'

module CycleHire
  ROOT = File.expand_path(File.dirname(__FILE__))

  autoload :Session, "#{ROOT}/cycle_hire/session"
  autoload :JourneyParser, "#{ROOT}/cycle_hire/journey_parser"
  autoload :Journey, "#{ROOT}/cycle_hire/journey"
  autoload :StatusParser, "#{ROOT}/cycle_hire/status_parser"

  # raises CycleHire::Session::AuthenticationError
  def self.authenticate(username, password)
    session = Session.new username, password
    session.authenticate!
  end

  def self.stations
    data = open("https://web.barclayscyclehire.tfl.gov.uk/maps").read
    parser = StatusParser.new data
    parser.parse
  end
end
