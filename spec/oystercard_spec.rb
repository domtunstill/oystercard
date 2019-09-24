require 'oystercard'

describe OysterCard do

  it 'initialises a new card with balance: 0' do
    expect(subject.balance).to eq 0
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

    it 'when oystercard is touched in at the start of the journey, the card should be set to in journey' do
      subject.top_up(1)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'when oystercard is touched in at the start of the journey, check minimum balance is £1' do
      expect { subject.touch_in }.to raise_error ("Not enough money on your card. Your balance is: £#{subject.balance}")
    end

  end

  describe '#touch_out' do

    it 'when oystercard is touched out at the end of the journey, in journey should be set to false' do
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it 'reduces the balance on the card when touching out' do
      subject.top_up(20)
      subject.touch_in
      expect{subject.touch_out}.to change{subject.balance}.by(-OysterCard::MINIMUM_BALANCE)
    end
  end

end
