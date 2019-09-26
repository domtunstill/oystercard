require 'journey'

describe Journey do

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  describe '#initialize' do

    it 'journeys list exists and is empty' do
      expect(subject.journeys).to be_empty
    end

    it 'knows if a journey is not complete' do
      expect(subject).not_to be_complete
    end

    it 'last journey exists and stations are equal to nil' do
      expect(subject.last_journey).to eq ({ entry: nil, exit: nil })
    end

  end

  describe '#save_journey' do

    it  { is_expected.to respond_to(:save_journey) }

    it 'saves the last journey made on the oystercard on touch out' do
    subject.save_journey(entry_station, exit_station)
    expect(subject.journeys).to include(entry: entry_station, exit: exit_station)
    end

  end

  describe '#fare' do

    it 'check journey is complete and return MINIMUM_FARE' do
      subject.save_journey(entry_station, exit_station)
      expect(subject.fare).to eq (Journey::MINIMUM_FARE)
    end

    it 'penalty fare by default' do
      expect(subject.fare).to eq (Journey::PENALTY_FARE)
    end

    it 'returns PENALTY_FARE if exit or entry station is nil' do
      subject.save_journey(nil, exit_station)
      expect(subject.fare).to eq (Journey::PENALTY_FARE)
    end

  end

end
