module CycleHire
  ROOT = File.expand_path(File.dirname(__FILE__))
  VERSION = '1.0.2'

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
    StationParser.get_stations
  end
end
