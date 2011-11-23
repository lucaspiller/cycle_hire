class CycleHire::Station
  attr_reader :name, :area, :id, :latitude, :longitude, :bikes, :empty_docks, :installed, :locked, :temporary, :timestamp

  def initialize(name)
    parse_name!(name)
  end

  def initialize(name, id, latitude, longitude, bikes, empty_docks, installed, locked, temporary, timestamp)
    parse_name!(name)
    @id = id
    @latitude = latitude
    @longitude = longitude

    @bikes = bikes
    @empty_docks = empty_docks

    @installed = installed
    @locked = locked
    @temporary = temporary
    @timestamp = timestamp
  end

  def to_h
    {
      :id => @id,
      :name => @name,
      :area => @area,
      :latitude => @latitude,
      :longitude => @longitude,
      :bikes => @bikes,
      :empty_docks => @empty_docks,
      :installed => @installed,
      :locked => @locked,
      :temporary => @temporary,
      :timestamp => @timestamp
    }
  end

  protected

  def parse_name!(name)
    @name = (name.split(',').first || '').strip
    @area = (name.split(',').last || '').strip
  end
end
