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

    it 'to save journey on completed journey' do
      subject.start(entry_station)
      subject.finish(exit_station)
      puts subject.journeys
      # expect(subject.journeys).to eq
    end

    it 'journeys list exists and is empty' do
      expect(subject.journeys).to be_empty
    end


  end

end
