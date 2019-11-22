require 'oystercard'
describe Oystercard do

  let(:station1) { double(:station1) }
  let(:station2) { double(:station2) }
  let(:journey) { double(:journey, entry_station: nil, exit_station: nil, fare: nil, in_journey?: false)}
  #thanks to Alastair G for the double syntax below :)
  let(:journey_class) { double :journey_class, new: journey}
  subject { Oystercard.new journey_class }

  context "on initialization" do 
    describe '#balance' do
      it 'should be 0' do
        expect(subject.balance).to eq(0)
      end
    end

    describe "#journeys" do
      it "should be an empty list" do
        expect(subject.journeys).to be_empty
      end
    end

  end

  context "to be able to use the card" do 
    it "can top up tp a maximum limit" do
      expect { subject.top_up(Oystercard::MAX_LIMIT) }.to change {subject.balance}.by (Oystercard::MAX_LIMIT)
    end
  end

  context "to protect the users money" do 
    it "should prevent topping up above the default limit" do
      subject.top_up(Oystercard::MAX_LIMIT)
      expect{ subject.top_up(10) }.to raise_error("Exceed maximum balance #{Oystercard::MAX_LIMIT}" )
    end
  end


  describe "#touch_in" do

    context "when trying to touch in" do
      it "should raise and error when the balance is less than the minimum fare" do
        expect { subject.touch_in(station1) }.to raise_error("Insufficient funds")
      end
    end

    context "if not on a previous journey" do
      before do
        subject.top_up(Oystercard::MAX_LIMIT)
        allow(journey).to receive(:in_journey?) {false}
        allow(journey).to receive(:entry_station) {station1}

      end

      it "should log a new journey instance" do
        subject.touch_in(station1)
        p journey.in_journey?
        expect(subject.journeys).to include(journey)
      end

      it "should not deduct any money" do
        expect { subject.touch_in(station1) }.to change {subject.balance}.by (0)
      end
    end

    context "if on a previous journey" do
      before do
        subject.top_up(Oystercard::MAX_LIMIT)
        allow(journey).to receive(:in_journey?) {true}
        allow(journey).to receive(:entry_station) {station1}
        allow(journey).to receive(:fare) {6}
      end

      it "should log a new journey instance" do
        subject.touch_in(station1)
        expect(subject.journeys).to include(journey)
      end

      it "should deduct the penalty fare" do
        subject.touch_in(station1)
        expect { subject.touch_in(station1) }.to change {subject.balance}.by (-6)
      end
    end
  end

  describe "#touch out" do 

    context "if a journey is in progress" do 

      before do
        subject.top_up(Oystercard::MAX_LIMIT)
        allow(journey).to receive(:in_journey?) {true}
        allow(journey).to receive(:entry_station) {station1}
        allow(journey).to receive(:end_journey) {journey}
        allow(journey).to receive(:fare) {1}
      end

      it "will deduct a standard fare" do
        expect { subject.touch_out(station2) }.to change {subject.balance}.by (-1)
      end
    end
    

    context "if a journey is not in progress" do 

      before do
        subject.top_up(Oystercard::MAX_LIMIT)
        allow(journey).to receive(:in_journey?) {false}
        allow(journey).to receive(:entry_station) {nil}
        allow(journey).to receive(:end_journey) {journey}
        allow(journey).to receive(:fare) {6}
      end

      it "will create a new journey" do 
        subject.touch_out(station2)
        expect(subject.journeys).to include(journey)
      end

      it "will deduct a standard fare" do
        expect { subject.touch_out(station2) }.to change {subject.balance}.by (-6)
      end
    end
  end
end
