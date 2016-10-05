require_relative 'station'
require_relative 'journey'

class OysterCard
  MAX_LIMIT = 90
  BALANCE = 0
  MINIMUM_FARE = 1

attr_reader :balance, :max_limit, :journey_history, :exit_station, :journey

  def initialize(balance = BALANCE)
    @max_limit = MAX_LIMIT
    @balance = balance
    @journey_history = []
  end

  def top_up(value)
    raise "balance cannot exceed #{@max_limit} pounds" if @balance + value > MAX_LIMIT
    @balance += value
  end

  def in_journey?
    @journey != nil
  end

  def touch_in(entry_station)
    raise "insufficient funds to complete journey" if @balance < MINIMUM_FARE
    @journey = Journey.new
    @journey.start_journey(entry_station)
    # @entry_station = entry_station
  end

  def touch_out(exit_station)
    @journey = Journey.new if @journey == nil
    @journey.finish_jouney(exit_station)
    deduct(MINIMUM_FARE)
    # @exit_station = exit_station
    # # current_journey
    # @exit_station = nil
    # @entry_station =nil
  end


  private
  def deduct(value)
    raise "do not have enough money" if @balance < value
    @balance -= value
  end

  # def current_journey
  #   @journey_history << {@entry_station => @exit_station}
  # end

end
