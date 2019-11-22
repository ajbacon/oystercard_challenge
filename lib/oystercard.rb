

class Oystercard
  attr_reader :balance, :journeys, :in_journey

  MAX_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(journeylog_class = JourneyLog)
    @balance = 0
    # @journeys = []
    @journeylog = journeylog_class.new
  end

  def top_up(amount)
    fail "Exceed maximum balance #{MAX_LIMIT}" if @balance >= MAX_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINIMUM_FARE

    fare = @journeylog.start(station)
    deduct(fare)
  end

  def touch_out(station)
    fare = @journeylog.end(station)
    deduct(fare)
  end

  def show_journeys
    @journeylog.journeys
  end

  private

  def deduct(amount)
    fail "Insufficient funds" if @balance - amount < 0
    @balance -= amount
  end
end

