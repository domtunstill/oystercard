require_relative 'journey'

class JourneyLog

  attr_reader :journey, :journeys, :entry_station

  def initialize
    @journeys = []
  end

  def start(entry_station, journey = Journey)
    save_journey if @journey && @journey.complete? != true
    @journey = journey.new
    @journey.start(entry_station)
  end

  def finish(exit_station, journey = Journey)
    if @journey
      @journey.finish(exit_station)
      save_journey
    else
      @journey = journey.new
      @journey.finish(exit_station)
      save_journey
    end
  end

  def save_journey
    @journey.fare
    @journeys << @journey
  end

  def return_fare
    @journey.fare
  end

  def complete?
    return @journey.complete? if @journey != nil
    true
  end

end
