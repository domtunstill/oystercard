
class Oystercard

  attr_reader :balance
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
  end

  def top_up(money)
    if @balance + money > MAXIMUM_BALANCE
      raise "Balance limit exceeded. Please top up #{MAXIMUM_BALANCE - @balance} or less"
    else
      "Card balance: #{@balance += money}"
    end
  end

  def deduct(fare)
    "Card balance: #{@balance -= fare}"
  end

  def touch_in
    raise "Not enough money on your card. Your balance is: £#{@balance}" unless enough_money?
    @in_journey = true
  end

  def enough_money?
    @balance >= MINIMUM_BALANCE
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

end
