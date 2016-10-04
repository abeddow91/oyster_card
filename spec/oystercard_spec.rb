require 'oystercard'

describe OysterCard do

  subject(:card) {described_class.new}
  let (:station) {double :station}

  before do
    @top_up_value = 5
    @max_top_up = 90
    @deduct_value = 1
  end

  it 'returns false for in_journey' do
  expect(card.in_journey?).to eq false
  end

  it 'touch_in raises an error if minimum fare not met' do
    expect{card.touch_in(station)}.to raise_error "insufficient funds to complete journey"
  end

  # it 'changes the hash key to entry station' do
  #   card.top_up(@top_up_value)
  #   expect{card.touch_in("banana")}.to change{card.current_journey}.from(nil).to(["banana", nil])
  # end

  context 'card is topped up' do
    before do
      card.top_up(@top_up_value)
    end

    it 'adds top-up to balance' do
      expect(card.balance).to eq @top_up_value
    end

    it 'deducts minimum fare from balance' do
      expect{card.touch_out(station)}.to change{card.balance}.by( 0 - OysterCard::MINIMUM_FARE)
    end

    it 'raises an error if balance is more than 90' do
      expect {card.top_up(@max_top_up)}.to raise_error "balance cannot exceed #{OysterCard::MAX_LIMIT} pounds"
    end

    it 'touch_in to change in_journey to true' do
      expect{card.touch_in(station)}.to change{card.in_journey?}.from(false).to(true)
    end

    it "sets the exit station" do
      card.touch_out(station)
      expect(card.exit_station).to eq station
    end

    it 'updates the journey history with entry station' do
      expect{card.touch_in(station)}.to change{card.current_journey}.from([]).to([station])
    end

    context 'card has been topped up and touched in' do
      before do
        card.touch_in(station)
      end
      it 'touch_out to change in_journey to false' do
        expect{card.touch_out(station)}.to change{card.in_journey?}.from(true).to(false)
      end

      it "sets the entry station" do
        expect(card.entry_station).to eq station
      end

      it 'sets the entry station to nil' do
        expect{card.touch_out(station)}.to change{card.entry_station}.from(station).to(nil)
      end

      it 'updates the journey history with exit station' do
        expect{card.touch_out(station)}.to change{card.current_journey}.from([station]).to([station, station])
      end

      it 'updates journey history with entry and exit stations' do
        card.touch_out(station)
        expect(card.journey_history).to eq([[station, station]])
      end
    end
  end

end
