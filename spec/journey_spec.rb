require "journey"

describe Journey do

  describe "#entry_station" do
    
    it "Should have an entry station" do
      journey = Journey.new('Aldgate bleast')
      expect(journey).to respond_to(:entry_station)
      expect(journey.entry_station).to eq('Aldgate bleast')
    end

  end
  
  describe "#exit_station" do
  
    it "Should have an exit station" do
      journey = Journey.new('Aldgate bleast')
      expect(journey).to respond_to(:exit_station)
    end
  
  end
  
end
