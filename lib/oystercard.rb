# frozen_string_literal: true

require_relative 'journeylog'

class OysterCard

  attr_reader :balance, :journey_log

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize(journey_log = JourneyLog.new)
    @balance = 0
    @journey_log = journey_log
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
    # return @journey_log.start(entry_station) unless in_journey?
    # @journey_log.save_journey
    # deduct(@journey.fare)
    # @journey.start(entry_station)
  end

  def touch_out(exit_station)
    @journey_log.finish(exit_station)
    deduct(@journey_log.return_fare)
  end

  # def in_journey?
  #   !@journey_log.last_journey_complete
  # end

  private

  def enough_money?
    @balance >= MINIMUM_BALANCE
  end

  def deduct(fare)
    "Card balance: #{@balance -= fare}"
  end
end
