require 'journey'

describe Journey do
  subject(:journey) {described_class.new}
  let (:card) {double :card}

  it 'instantiates a journey' do
    expect(journey).to eq(journey)
  end

  it 'initializes with a start value' do
    expect(journey.start).to eq nil
  end

  it 'initializes with a end value' do
    expect(journey.finish).to eq nil
  end

  it 'starts journey and stores entry station' do
    journey.start_journey('station')
    expect(journey.start).to eq('station')
  end

  it 'finishes journey and stores exit station' do
    journey.finish_journey('station')
    expect(journey.finish).to eq('station')
  end

  xit 'touches in and logs the entry station in @start' do
    expect(journey.start).to eq(station)
  end




end
