require 'journey'

describe Journey do

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  describe '#initialize' do

    it 'knows if a journey is not complete' do
      expect(subject).not_to be_complete
    end

  end

  describe '#fare' do

    it 'check journey is complete and return MINIMUM_FARE' do
      allow(subject).to receive(:complete?).and_return true
      expect(subject.fare).to eq (Journey::MINIMUM_FARE)
    end

    it 'penalty fare by default' do
      expect(subject.fare).to eq (Journey::PENALTY_FARE)
    end

    it 'returns PENALTY_FARE if exit or entry station is nil' do
      allow(subject).to receive(:complete?).and_return false
      expect(subject.fare).to eq (Journey::PENALTY_FARE)
    end

  end

  describe '#complete?' do

    it 'checks that entry and exit station are != nil' do
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject.complete?).to eq true
    end

  end

  describe '#start' do

    it 'records entry station' do
      subject.start(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
  end

  describe '#finish' do

    it 'records exit station' do
      subject.finish(exit_station)
      expect(subject.exit_station).to eq exit_station
    end
  end

end
