# frozen_string_literal: true

require_relative 'journeylog'

class OysterCard

  attr_reader :balance, :journey_log

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize(journey_log = JourneyLog)
    @balance = 0
    @journey_log = journey_log.new
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
    deduct(@journey_log.return_fare) unless @journey_log.complete?
    @journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    @journey_log.finish(exit_station)
    deduct(@journey_log.return_fare)
  end

  private

  def enough_money?
    @balance >= MINIMUM_BALANCE
  end

  def deduct(fare)
    "Card balance: #{@balance -= fare}"
  end
end
