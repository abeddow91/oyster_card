class OysterCard
  MAX_LIMIT = 90
  BALANCE = 0
  MINIMUM_FARE = 1

attr_reader :balance, :max_limit, :entry_station, :journey_history, :exit_station, :current_journey

  def initialize(balance = BALANCE)
    @max_limit = MAX_LIMIT
    @balance = balance
    @journey_history = []
    @current_journey = []
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
    entry_record
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @exit_station = exit_station
    exit_record
    @entry_station = nil
  end

  def entry_record
    @current_journey << @entry_station
  end

  def exit_record
    @current_journey << @exit_station
    journey_history_update
  end

  def journey_history_update
    @journey_history << @current_journey
  end

  private
  def deduct(value)
    raise "do not have enough money" if @balance < value
    @balance -= value
  end
end
