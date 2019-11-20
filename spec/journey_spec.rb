require "journey"

describe Journey do


  it "Should have an entry station" do
    journey = Journey.new('Aldgate bleast')
    expect(journey).to respond_to(:entry_station)
    expect(journey.entry_station).to eq('Aldgate bleast')

  end

  it "Should have an exit station" do
    expect(journey).to respond_to(:exit_station)
  end

end
