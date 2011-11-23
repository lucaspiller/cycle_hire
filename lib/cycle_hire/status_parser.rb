class CycleHire::StatusParser
  STATION_REGEX = /\{id:"(\d+)".+?name:"(.+?)".+?lat:"(.+?)".+?long:"(.+?)".+?nbBikes:"(\d+)".+?nbEmptyDocks:"(\d+)".+?installed:"(.+?)".+?locked:"(.+?)".+?temporary:"(.+?)"\}/

  def initialize(data)
    @data = data
  end

  def parse
    @data.scan(STATION_REGEX).map do |station|
      parse_station(station)
    end
  end

  protected

  def parse_station(st)
    {
      :id => st[0],
      :name => (st[1].split(',')[0] || '').strip,
      :area => (st[1].split(',')[1] || '').strip,
      :lat => st[2].to_f,
      :long => st[3].to_f,
      :bikes => st[4].to_i,
      :empty_docks => st[5].to_i,
      :installed => (st[6] == 'true'),
      :locked => (st[7] == 'true'),
      :temporary => (st[8] == 'true')
    }
  end
end
