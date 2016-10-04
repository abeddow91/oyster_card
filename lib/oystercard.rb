class OysterCard
  MAX_LIMIT = 90
  BALANCE = 0
attr_reader :balance, :max_limit

  def initialize(max_limit = MAX_LIMIT, balance = BALANCE)
    @max_limit = max_limit
    @balance = balance
    @in_journey = false
  end

  def top_up(value)
    raise "balance cannot exceed #{@max_limit} pounds" if @balance + value > 90
    @balance += value
  end

  def deduct(value)
    raise "do not have enough money" if @balance < value
    @balance -= value
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

end
