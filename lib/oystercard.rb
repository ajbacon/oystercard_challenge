class Oystercard 
  attr_reader :balance

  DEFAULT_LIMIT = 90
  
  def initialize
  @balance = 0
  end
  
  def top_up(amount)
    fail "Exceed maximum balance #{DEFAULT_LIMIT}" if @balance >= DEFAULT_LIMIT
    @balance += amount
  end
end