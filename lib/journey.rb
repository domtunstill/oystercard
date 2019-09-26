
class Journey

  attr_reader :journeys

  def initialize
    @journeys = []
  end

  def save_journey(last_journey)
    @journeys << last_journey
  end

end
