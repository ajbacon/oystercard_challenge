class Oystercard
  attr_reader :balance, :entry_station, :journeys

  DEFAULT_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @journeys = []
    @journey = {entry_station: nil, exit_station: nil}
  end

  def top_up(amount)
    fail "Exceed maximum balance #{DEFAULT_LIMIT}" if @balance >= DEFAULT_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient funds" if @balance < MINIMUM_FARE
    @journey[:entry_station] = station
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journey[:exit_station] = station
    @journeys << @journey
    @journey = {entry_station: nil, exit_station: nil}
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

def
