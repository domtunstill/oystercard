require_relative 'station'

class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  ZONE_FARE = 1

  attr_reader :entry_station, :exit_station, :complete

  def start(entry_station)
    @entry_station = entry_station
    @exit_station = nil
  end

  def finish(exit_station)
    return @exit_station = exit_station if @entry_station != nil
    @entry_station = nil
    @exit_station = exit_station
  end

  def complete?
    @complete = @entry_station != nil && @exit_station != nil
  end

  def fare
    if complete?
      distance = @entry_station.zone - @exit_station.zone
      @fare = (distance * MINIMUM_FARE).abs + MINIMUM_FARE
    else
      @fare = PENALTY_FARE
    end
  end

end
