# frozen_string_literal: true

require_relative 'journey'

class OysterCard
  attr_reader :balance, :entry_station
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @journey = Journey.new
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
    @journey.save_journey(@entry_station, exit_station)
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
