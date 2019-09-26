class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :journeys, :last_journey, :entry_station, :exit_station

  def initialize
    @journeys = []
    @last_journey = { entry: nil, exit: nil }
  end

  def start(entry_station)
    @entry_station = entry_station
    @exit_station = nil
  end

  def finish(exit_station)
    @exit_station = exit_station
    save_journey
    @entry_station = nil
  end

  def save_journey
    @last_journey[:entry] = @entry_station
    @last_journey[:exit] = @exit_station
    @journeys << { :entry => @entry_station, :exit => @exit_station }
  end

  def complete?
    @last_journey[:entry] != nil && @last_journey[:exit] != nil
  end

  def fare
    if complete?
      MINIMUM_FARE
    else
      PENALTY_FARE
    end
  end

end
