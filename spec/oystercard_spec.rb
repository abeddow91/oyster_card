require 'oystercard'

describe OysterCard do

  subject(:card) {described_class.new}
  let (:station) {double :station}

  before do
    @top_up_value = 5
    @max_top_up = 90
    @deduct_value = 1
  end

  it 'adds top-up to balance' do
    card.top_up(0)
    expect(card.balance).to eq 0
  end

  it 'raises an error if balance is more than 90' do
    card.top_up(@max_top_up)
    expect {card.top_up(@top_up_value)}.to raise_error "balance cannot exceed #{OysterCard::MAX_LIMIT} pounds"
  end

  it 'returns false for in_journey' do
  expect(card.in_journey?).to eq false
  end

  it 'touch_in to change in_journey to true' do
    card.top_up(@top_up_value)
    expect{card.touch_in(station)}.to change{card.in_journey?}.from(false).to(true)
  end

  it 'touch_out to change in_journey to false' do
    card.top_up(@top_up_value)
    card.touch_in(station)
    expect{card.touch_out(station)}.to change{card.in_journey?}.from(true).to(false)
  end

  it 'touch_in raises an error if minimum fare not met' do
    expect{card.touch_in(station)}.to raise_error "insufficient funds to complete journey"
  end

  it 'deducts minimum fare from balance' do
    card.top_up(@top_up_value)
    expect{card.touch_out(station)}.to change{card.balance}.by( 0 - OysterCard::MINIMUM_FARE)
  end

  it "sets the entry station" do
    card.top_up(@top_up_value)
    card.touch_in(station)
    expect(card.entry_station).to eq station
  end

  it 'sets the entry station to nil' do
    card.top_up(@top_up_value)
    card.touch_in(station)
    expect{card.touch_out(station)}.to change{card.entry_station}.from(station).to(nil)
  end

  it 'responds to journey history' do
    expect(card).to respond_to(:journey_history)
  end

  it "sets the exit station" do
    card.top_up(@top_up_value)
    card.touch_out(station)
    expect(card.exit_station).to eq station
  end

  it 'responds to current_journey' do
  expect(card).to respond_to(:current_journey)
  end

  it 'changes the hash key to entry station' do
    card.top_up(@top_up_value)
    expect{card.touch_in(station)}.to change{card.journey_history}.from({}).to({station => nil})
  end

  it 'changes the hash value to exit station' do
    card.top_up(@top_up_value)
    card.touch_in(station)
    expect{card.touch_out(station)}.to change{card.journey_history}.from({station => nil}).to({station => station})
  end



end
