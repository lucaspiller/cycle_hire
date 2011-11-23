class CycleHire::Station
  attr_reader :name, :area, :id, :latitude, :longitude, :bikes, :empty_docks, :installed, :locked, :temporary, :timestamp

  def initialize(name, id = nil, latitude = nil, longitude = nil, bikes = nil, empty_docks = nil, installed = nil, locked = nil, temporary = nil, timestamp = nil)
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

  def to_s
    @name + ', ' + @area
  end

  protected

  def parse_name!(name)
    @name = (name.split(',').first || '').strip
    @area = (name.split(',').last || '').strip
  end
end
