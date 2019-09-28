# frozen_string_literal: true

require 'oystercard'

describe OysterCard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey_log) { double :journey_log }
  let(:journey_log_class) { double 'JourneyLog class', new: journey_log }
  subject { described_class.new(journey_log_class) }

  describe '#initialize' do
    it 'initialises a new card with balance: 0' do
      expect(subject.balance).to eq 0
    end

  end

  describe '#top_up' do
    it 'expect oystercard to respond to top_up method' do
      expect(subject).to respond_to(:top_up)
    end

    it 'expect oystercard to respond to top_up method' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it 'returns card balance after topping up' do
      expect(subject.top_up(20)).to match("Card balance: #{subject.balance}")
    end

    it 'expect oystercard balance to change by 5' do
      expect { subject.top_up(5) }.to change { subject.balance }.by(5)
    end

    it 'tells user balance limit exceeded' do
      expect { subject.top_up(95) }.to raise_error("Balance limit exceeded. Please top up #{OysterCard::MAXIMUM_BALANCE - subject.balance} or less")
    end
  end

  describe '#touch_in' do

    it 'touch in twice charge penalty fare edge case' do
      subject.top_up(10)
      allow(journey_log).to receive(:start)
      allow(journey_log).to receive(:complete?).and_return(true)
      subject.touch_in(entry_station)
      allow(journey_log).to receive(:complete?).and_return(false)
      allow(journey_log).to receive(:return_fare).and_return(6)
      expect{ subject.touch_in(entry_station) }.to change { subject.balance }.by(-6)
    end

    it 'when oystercard is touched in at the start of the journey, check minimum balance is £1' do
      expect { subject.touch_in(entry_station) }.to raise_error "Not enough money on your card. Your balance is: £#{subject.balance}"
    end
  end

  describe '#touch_out' do

    it 'reduces the balance on the card when touching out' do
      subject.top_up(20)
      allow(journey_log).to receive(:entry_station).and_return(nil)
      allow(journey_log).to receive(:start)
      allow(journey_log).to receive(:complete?).and_return(true)
      allow(journey_log).to receive(:finish)
      subject.touch_in(entry_station)
      allow(journey_log).to receive(:return_fare).and_return(1)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-OysterCard::MINIMUM_BALANCE)
    end

    it 'touch out without touching in penalty fare edge case' do
      subject.top_up(10)
      allow(journey_log).to receive(:finish)
      allow(journey_log).to receive(:return_fare).and_return(6)
      expect{ subject.touch_out(exit_station) }.to change { subject.balance }.by(-6)
    end

  end

end
