require 'oystercard'
describe Oystercard do

  let(:station1) { double(:station1) }
  let(:station2) { double(:station2) }
  let(:journey) { double(:journey, entry_station: nil, exit_station: nil, fare: nil)}
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
        allow(journey).to receive(:in_journey) {false}
        allow(journey).to receive(:entry_station) {station1}
      end

      it "should log a new journey instance" do
        p journey
        subject.touch_in(station1)
        expect(subject.journeys).to include(journey)
      end

    end
  end

  

  context "using the card" do

    before do
      subject.top_up(Oystercard::DEFAULT_LIMIT)
    end

    let(:station) { double(:station) }
    let(:station1) { double(:station1) }
    let(:journey) { double(:journey) }

    describe "#touch_in" do
      it "should be in journey after touching in" do
        subject.touch_in(station)
        expect( subject.in_journey).to eq(true)
      end

    end

    describe "#touch_out" do
      it "should not be in a journey after touching out" do
        subject.touch_in(station)
        subject.touch_out(station1)
        expect( subject.in_journey ).to eq(false)
      end

      it "should deduct the fare from the balance" do
        expect{ subject.touch_out(Oystercard::MINIMUM_FARE) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_FARE)
      end

      it "should check that a journey has been created after touching in then out" do
        subject.touch_in(station)
        subject.touch_out(station1)
        expect(subject.journeys).to include({entry_station: station, exit_station: station1})
      end
    end

    describe "#in_journey?" do
      it "should true after touching in" do
        subject.touch_in(station)
        expect(subject).to be_in_journey
      end
    end
  end
end
