require 'open-uri'

class CycleHire::StationParser
  STATION_REGEX = /\{id:"(\d+)".+?name:"(.+?)".+?lat:"(.+?)".+?long:"(.+?)".+?nbBikes:"(\d+)".+?nbEmptyDocks:"(\d+)".+?installed:"(.+?)".+?locked:"(.+?)".+?temporary:"(.+?)"\}/
  TIME_REGEX = /var hour='(\d\d:\d\d)'/
  ENDPOINT = "https://web.barclayscyclehire.tfl.gov.uk/maps"

  def self.get_stations
    data = open(ENDPOINT).read
    parser = self.new data
    parser.parse
  end

  def initialize(data)
    @data = data
  end

  def parse
    @data.scan(STATION_REGEX).map do |station|
      parse_station(station)
    end
  end

  def timestamp
    @timestamp ||= Time.parse(TIME_REGEX.match(@data).to_s)
  end

  protected

  def parse_station(st)
    installed = (st[6] == 'true')
    locked = (st[7] == 'true')
    temporary = (st[8] == 'true')

    CycleHire::Station.new(
      st[1],
      st[0],
      st[2].to_f,
      st[3].to_f,
      st[4].to_i,
      st[5].to_i,
      installed,
      locked,
      temporary,
      timestamp
    )
  end
end
