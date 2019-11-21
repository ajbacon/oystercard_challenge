require_relative "journey"
require_relative "station"

class Oystercard
  attr_reader :balance, :journeys, :in_journey

  DEFAULT_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(journey_class = Journey)
    @balance = 0
    @in_journey = false
    @journeys = []
    @journey = nil
    @journey_class = journey_class
  end

  def top_up(amount)
    fail "Exceed maximum balance #{DEFAULT_LIMIT}" if @balance >= DEFAULT_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINIMUM_FARE
    if @in_journey == true
      @journey.end_journey
      deduct(@journey.fare)
    end

    @in_journey = true
    @journey = @journey_class.new(station)

  end

  def touch_out(station)
    if @in_journey == false
      @journey = @journey_class.new
      @journey.end_journey(station)
      deduct(@journey.fare)
    else
     @journey.end_journey(station)
     deduct(@journey.fare)
    end
    @in_journey = false
    @journeys << @journey
    @journey = nil
  end

  private

  def deduct(amount)
    fail "Insufficient funds" if @balance - amount < 0
    @balance -= amount
  end
end
