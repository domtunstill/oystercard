class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station
  #
  # def initialize
  #   # @last_journey = { entry: nil, exit: nil }
  # end

  def start(entry_station)
    @entry_station = entry_station
    @exit_station = nil
  end

  def finish(exit_station)
    return @exit_station = exit_station unless @entry_station == nil
    @entry_station = nil
    @exit_station = exit_station
  end

  def complete?
    @entry_station != nil && @exit_station != nil
  end

  def fare
    @fare = complete? ? MINIMUM_FARE : PENALTY_FARE
  end

end
