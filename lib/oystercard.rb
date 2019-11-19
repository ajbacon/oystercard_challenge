class Oystercard 
  attr_reader :balance

  DEFAULT_LIMIT = 90
  MINIMUM_FARE = 1
  
  def initialize
    @balance = 0
    @in_journey = false
  end
  
  def top_up(amount)
    fail "Exceed maximum balance #{DEFAULT_LIMIT}" if @balance >= DEFAULT_LIMIT
    @balance += amount
  end

  def deduct(amount)
    fail "Insufficient funds" if @balance - amount < 0
    @balance -= amount
  end

  def touch_in
    fail "Insufficient funds" if @balance < MINIMUM_FARE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end
end