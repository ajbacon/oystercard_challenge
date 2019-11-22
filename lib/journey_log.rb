class JourneyLog

  attr_reader :journey_class, :journeys

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journeys = []
  end

  def start(station = nil)
    @journeys == [] || !@journeys[-1].in_journey? ? fare = 0 : fare = @journeys[-1].fare
    new_journey(station)
    return fare
  end

  def end(station = nil)
    new_journey if !@journeys[-1].in_journey?
    @journeys[-1].end_journey(station)
    fare = @journeys[-1].fare
  end

  
  private
  def new_journey(station = nil)
    @journeys << @journey_class.new(station)
  end
end

