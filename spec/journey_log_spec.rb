require 'journey_log'

describe JourneyLog do

  let(:station1) { double(:station1) }
  let(:journey) { double(:journey) }
  let(:journey_class) { double(:journey_class, new: journey) }
  subject { described_class.new(journey_class) }

  
  describe "#start" do


    it "starts a journey" do
      expect(journey_class).to receive(:new).with(station1)
      # subject.start(station1) 
    end


  end
end