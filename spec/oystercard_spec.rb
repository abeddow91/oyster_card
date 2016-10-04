require 'oystercard'

describe OysterCard do

  subject(:card) {described_class.new}

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

  it 'deducts value from the balance' do
    expect {card.deduct(@deduct_value)}.to raise_error "do not have enough money"
  end

  it 'returns false for in_journey' do
  expect(card.in_journey?).to eq false
  end

  it 'touch_in to change in_journey to true' do
    card.top_up(@top_up_value)
    expect{card.touch_in}.to change{card.in_journey?}.from(false).to(true)
  end

  it 'touch_out to change in_journey to false' do
    card.top_up(@top_up_value)
    card.touch_in
    expect{card.touch_out}.to change{card.in_journey?}.from(true).to(false)
  end

  it 'touch_in rais an error if minimum fare not met' do
    expect{card.touch_in}.to raise_error "insufficient funds to complete journey"
  end

end
