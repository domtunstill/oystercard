class Journey

  attr_reader :journeys, :last_journey

  def initialize
    @journeys = []
    @last_journey = { entry: nil, exit: nil }
  end

  def save_journey(entry_station, exit_station)
    @last_journey[:entry] = entry_station
    @last_journey[:exit] = exit_station
    @journeys << @last_journey
  end

end
