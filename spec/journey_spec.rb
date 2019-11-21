require "journey"

describe Journey do

  let(:station) {double(:station)}
  subject {Journey.new(station)}

  context "at start of the journey" do
    describe "#entry_station" do   
      it "Should have an entry station" do
        expect(subject).to respond_to(:entry_station)
        expect(subject.entry_station).to eq(station)
      end  
    end

    it "exit station should be empty" do
      expect(subject.exit_station).to eq(nil)
    end

    it "should default to the penalty fare" do
      expect(subject.fare).to eq(Journey::PENALTY_FARE)
    end

  end

  context "at the end of the journey" do
    describe "#exit_station" do

      before do
        subject.end_journey(station)
      end

      it "Should have an exit station" do
        expect(subject).to respond_to(:exit_station)
        expect(subject.exit_station).to eq(station)
      end 

      it "should charge the minimum for a sucessful journey" do
        expect(subject.fare).to eq(Journey::MINIMUM_FARE)
      end
    end
  end




  
end
