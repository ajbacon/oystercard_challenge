class Journey
  attr_reader :entry_station, :exit_station, :fare
  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
    @fare = PENALTY_FARE
  end


  def end_journey(exit_station = nil)
    @exit_station = exit_station
    @fare = MINIMUM_FARE unless entry_station == nil || exit_station == nil
  end

  def in_journey?
    !!@entry_station && !@exit_station
  end
end
