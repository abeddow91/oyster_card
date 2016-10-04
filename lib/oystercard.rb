class OysterCard
  MAX_LIMIT = 90
  BALANCE = 0
  MINIMUM_FARE = 1

attr_reader :balance, :max_limit, :entry_station

  def initialize(max_limit = MAX_LIMIT, balance = BALANCE)
    @max_limit = max_limit
    @balance = balance
  end

  def top_up(value)
    raise "balance cannot exceed #{@max_limit} pounds" if @balance + value > MAX_LIMIT
    @balance += value
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(entry_station)
    raise "insufficient funds to complete journey" if @balance < MINIMUM_FARE
    @entry_station = entry_station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  private
  def deduct(value)
    raise "do not have enough money" if @balance < value
    @balance -= value
  end
end
