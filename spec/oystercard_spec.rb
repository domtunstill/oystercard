require 'oystercard'

describe OysterCard do

describe '#initialize' do

    it 'initialises a new card with balance: 0' do
      expect(subject.balance).to eq 0
    end

    it 'journeys list exists and is empty' do
      expect(subject.journeys).to be_empty
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

    it 'when oystercard is touched in at the start of the journey, the card should be set to in journey' do
      subject.top_up(1)
      subject.touch_in(:station)
      expect(subject).to be_in_journey
    end

    it 'when oystercard is touched in at the start of the journey, check minimum balance is £1' do
      expect { subject.touch_in(:station) }.to raise_error ("Not enough money on your card. Your balance is: £#{subject.balance}")
    end

    it 'records the station that the user touches in at' do
      subject.top_up(20)
      subject.touch_in("Aldgate East")
      expect(subject.entry_station).to eq "Aldgate East"
    end
  end

  describe '#touch_out' do

    it 'when oystercard is touched out at the end of the journey, in journey should be set to false' do
      subject.touch_out(:station)
      expect(subject).not_to be_in_journey
    end

    it 'reduces the balance on the card when touching out' do
      subject.top_up(20)
      subject.touch_in(:station)
      expect{subject.touch_out(:station)}.to change{subject.balance}.by(-OysterCard::MINIMUM_BALANCE)
    end

    it 'forgets the entry_station at touch out' do
      subject.top_up(20)
      subject.touch_in(:station)
      subject.touch_out(:station)
      expect(subject.entry_station).to eq nil
    end

    # it 'records the station that the user touches out at' do
    #   subject.top_up(20)
    #   subject.touch_in("Aldgate East")
    #   subject.touch_out("Upminster")
    #   expect(subject.exit_station).to eq "Upminster"
    # end

  end

  it "records a single journey's stations" do
    subject.top_up(20)
    subject.touch_in("Aldgate East")
    subject.touch_out("Upminster")
    expect(subject.journeys).to include("Entry" => "Aldgate East", "Exit" => "Upminster")
  end

end
