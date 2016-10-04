class OysterCard
  MAX_LIMIT = 90
  BALANCE = 0
  MINIMUM_FARE = 1

attr_reader :balance, :max_limit, :entry_station, :journey_history, :exit_station

  def initialize(balance = BALANCE)
    @max_limit = MAX_LIMIT
    @balance = balance
    @journey_history = {}
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
    current_journey
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @exit_station = exit_station
    current_journey
    @entry_station = nil
  end

  def current_journey
    @journey_history[@entry_station] = @exit_station
  end

  private
  def deduct(value)
    raise "do not have enough money" if @balance < value
    @balance -= value
  end
end
