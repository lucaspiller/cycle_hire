require 'open-uri'

module CycleHire
  ROOT = File.expand_path(File.dirname(__FILE__))

  autoload :Session, "#{ROOT}/cycle_hire/session"
  autoload :HistoryParser, "#{ROOT}/cycle_hire/history_parser"
  autoload :StatusParser, "#{ROOT}/cycle_hire/status_parser"

  # raises CycleHire::Session::AuthenticationError
  def self.authenticate(username, password)
    session = Session.new username, password
    session.authenticate!
  end

  def self.stations
    body = open("https://web.barclayscyclehire.tfl.gov.uk/maps").read
    parser = StatusParser.new
    parser.parse(body)
  end
end
