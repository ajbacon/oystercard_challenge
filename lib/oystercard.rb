

class Oystercard
  attr_reader :balance, :journeys, :in_journey

  MAX_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(journey_class = Journey)
    @balance = 0
    @journeys = []
    @journey_class = journey_class
  end

  def top_up(amount)
    fail "Exceed maximum balance #{MAX_LIMIT}" if @balance >= MAX_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINIMUM_FARE

    deduct(@journeys[-1].fare) unless @journeys == [] || !@journeys[-1].in_journey?
    @journeys << @journey_class.new(station)
  end

  def touch_out(station)
    @journeys << @journey_class.new if @journeys == [] || !@journeys[-1].in_journey?
    @journeys[-1].end_journey(station)
    deduct(@journeys[-1].fare)
  end

  private

  def deduct(amount)
    fail "Insufficient funds" if @balance - amount < 0
    @balance -= amount
  end
end

