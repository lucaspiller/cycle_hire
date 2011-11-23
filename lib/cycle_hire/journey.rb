class CycleHire::Journey
  attr_reader :start_time, :start_station, :end_time, :end_station, :cost

  def initialize(start_time, start_station, end_time, end_station, cost)
    @start_time = start_time
    @start_station = start_station
    @end_time = end_time
    @end_station = end_station
    @cost = cost
  end

  def duration
    ((@end_time - @start_time) / 60).to_i
  end

  def to_h
    {
      :start_time => @start_time,
      :start_station => @start_station.to_s,
      :end_time => @end_time,
      :end_station => @end_station.to_s,
      :cost => @cost,
      :duration => duration
    }
  end
end
