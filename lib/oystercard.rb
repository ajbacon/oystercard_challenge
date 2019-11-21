require_relative "journey"
require_relative "station"

class Oystercard
  attr_reader :balance, :journeys

  DEFAULT_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @journeys = []
    @journey = nil
  end

  def top_up(amount)
    fail "Exceed maximum balance #{DEFAULT_LIMIT}" if @balance >= DEFAULT_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINIMUM_FARE

    
    @journey = Journey.new(station)

  end

  def touch_out(station)

    @journey.end_journey(station)
    deduct(@journey.fare)
    @journeys << @journey
    @journey = nil

  end

  def in_journey?
    !!@journey[:entry_station]
  end

  private

  def deduct(amount)
    fail "Insufficient funds" if @balance - amount < 0
    @balance -= amount
  end
end
