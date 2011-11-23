require 'open-uri'

module CycleHire
  ROOT = File.expand_path(File.dirname(__FILE__))

  autoload :Session, "#{ROOT}/cycle_hire/session"
  autoload :JourneyParser, "#{ROOT}/cycle_hire/journey_parser"
  autoload :Journey, "#{ROOT}/cycle_hire/journey"
  autoload :StationParser, "#{ROOT}/cycle_hire/station_parser"
  autoload :Station, "#{ROOT}/cycle_hire/station"

  # raises CycleHire::Session::AuthenticationError
  def self.authenticate(email, password)
    session = Session.new email, password
    session.authenticate!
  end

  def self.stations
    data = open("https://web.barclayscyclehire.tfl.gov.uk/maps").read
    parser = StationParser.new data
    parser.parse
  end
end
