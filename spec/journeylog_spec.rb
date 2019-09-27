require 'journeylog'
require 'journey'

describe JourneyLog do

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { double :journey }

  describe '#initialize' do

    # it 'journeys list exists and is a instance of the journey class' do
    #   expect(subject.journey.class).to eq Journey
    # end

    it 'journeys list exists and is empty' do
      expect(subject.journeys).to be_empty
    end

  end

  describe '#start' do
    it 'saves journey if previous journey not complete' do
      allow(journey).to receive(:new)
      allow(journey).to receive(:start).and_return(journey)
      subject.start(entry_station, journey)
      subject.start(entry_station, journey)
      expect(subject.journeys).not_to be_empty
    end
  end

  describe '#finish' do
    it 'saves journey if touch out without touching in' do
      subject.finish(exit_station)
      expect(subject.journeys).not_to be_empty
    end
  end

  describe '#save_journey' do
    it 'to save journey on completed journey' do
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject.save_journey).to include(subject.journey)
    end
  end

  describe '#return_fare' do
    it 'responds to the fare method' do
      expect(subject).to respond_to(:return_fare)
    end

    it 'returns journey fare for complete journey' do
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject.return_fare).to eq(1)
    end
  end

  describe '#complete?' do
    it 'returns true' do
      expect(subject.complete?).to eq true
    end
  end


end
