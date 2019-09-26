require 'journey'

describe Journey do

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  
  describe '#initialize' do

    it 'journeys list exists and is empty' do
      expect(subject.journeys).to be_empty
    end

  end

  describe '#save_journey' do

    it  { is_expected.to respond_to(:save_journey) }


    it 'saves the last journey made on the oystercard on touch out' do
    subject.save_journey( {entry: entry_station, exit: exit_station} )
    expect(subject.journeys).to include(entry: entry_station, exit: exit_station)
    end

  end

end
