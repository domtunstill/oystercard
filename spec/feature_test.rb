# frozen_string_literal: true

require './lib/station'
st = Station.new('Bank', 'zone 1')

os = OysterCard.new
os.top_up(20)
os.touch_in(station)
# os.touch_out
# os.balance
