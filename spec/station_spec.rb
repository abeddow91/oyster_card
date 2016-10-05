require 'station'

describe Station do
  subject(:station) {described_class.new('angel', 1)}

  #it 'initializes with 2 arguments' do
  #   expect(station).to eq(station)with(2)arguments
  # end

  it 'initializes with a name' do
    expect(station.name).to eq 'angel'
  end

  it 'initializes with a zone' do
    expect(station.zone).to eq 1
  end
end
