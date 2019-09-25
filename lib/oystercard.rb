
class OysterCard

  attr_reader :balance, :entry_station, :journeys
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @journeys = []
    @last_journey = {entry: nil, exit: nil}
  end

  def top_up(money)
    if @balance + money > MAXIMUM_BALANCE
      raise "Balance limit exceeded. Please top up #{MAXIMUM_BALANCE - @balance} or less"
    else
      "Card balance: #{@balance += money}"
    end
  end

  def touch_in(entry_station)
    raise "Not enough money on your card. Your balance is: £#{@balance}" unless enough_money?
    @entry_station = entry_station
  end

  def enough_money?
    @balance >= MINIMUM_BALANCE
  end

  def touch_out(exit_station)
    deduct(MINIMUM_BALANCE)
    @last_journey[:entry] = @entry_station
    @last_journey[:exit] = exit_station
    @journeys << @last_journey
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def deduct(fare)
    "Card balance: #{@balance -= fare}"
  end

end
