require 'journeylog'

describe JourneyLog do

  describe '#initialize' do

    it 'journeys list exists and is empty' do
      expect(subject.journey.class).to eq Journey
    end
    #
    # it 'knows if a journey is not complete' do
    #   expect(subject).not_to be_complete
    # end
    #
    # it 'last journey exists and stations are equal to nil' do
    #   expect(subject.last_journey).to eq ({ entry: nil, exit: nil })
    # end

  end
  
end
