# frozen_string_literal: true

require 'station'
describe Station do
  subject { described_class.new('Bank') }

  it 'initializes with a station name' do
    expect(subject.name).to eq 'Bank'
  end

  it 'initializes with a station zone' do
    expect(subject.zone).to eq 1
  end
end
