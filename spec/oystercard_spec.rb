require 'oystercard'

describe OysterCard do
  subject(:card) {described_class.new}

  it 'adds top-up to balance' do
    card.top_up(0)
    expect(card.balance).to eq 0
  end

  it 'raises an error if balance is more than 90' do
    card.top_up(90)
    expect {card.top_up(5)}.to raise_error "balance cannot exceed #{OysterCard::MAX_LIMIT} pounds"
  end

  it 'deducts value from the balance' do
    expect {card.deduct(1)}.to raise_error "do not have enough money"
  end

  it 'returns false for in_journey' do
  expect(card.in_journey?).to eq false
  end

  it 'touch_in to change in_journey' do
    expect{card.touch_in}.to change{card.in_journey?}.from(false).to(true)
  end

end
