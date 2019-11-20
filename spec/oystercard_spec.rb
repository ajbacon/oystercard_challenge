require 'oystercard'
describe Oystercard do

  describe '#balance' do
    it 'should show 0 balance' do
      expect(subject.balance).to eq(0)
    end
  end

  describe "#journeys" do
    it "should initialize an empty list" do
      expect(subject.journeys).to be_empty
    end

  end

  describe '#top_up' do

  context "top up within max capacity" do

    it 'should increase the balance by 10' do
      expect{ subject.top_up(10) }.to change{ subject.balance }.by (10)
    end
    it 'should increase the balance by 5 twice' do
      expect{ 2.times{subject.top_up(5)} }.to change{ subject.balance }.by (10)
    end
  end

  context "top up over the max capacity" do
    it 'should raise an error when we pass the max capacity' do
      subject.top_up(Oystercard::DEFAULT_LIMIT)
      expect{ subject.top_up(10) }.to raise_error("Exceed maximum balance #{Oystercard::DEFAULT_LIMIT}" )
    end
  end
  end

  # describe '#deduct' do
  #   before do
  #     subject.top_up(Oystercard::DEFAULT_LIMIT)
  #   end

  #   it 'should deduct given quantitiy from balance' do
  #     expect { subject.deduct(Oystercard::DEFAULT_LIMIT*0.9) }.to change { subject.balance }.by (-Oystercard::DEFAULT_LIMIT*0.9)
  #   end

  #   it 'should raise error when the balance goes negative' do
  #     expect { subject.deduct(Oystercard::DEFAULT_LIMIT*1.1) }.to raise_error("Insufficient funds")
  #   end
  # end

  context "using the card" do

    before do
      subject.top_up(Oystercard::DEFAULT_LIMIT)
    end

    let(:station) { double(:station) }
    let(:station1) { double(:station1) }
    # let(:journey) { double(:journey) }

    describe "#touch_in" do
      it "should be in journey after touching in" do
        subject.touch_in(station)
        expect( subject.in_journey?).to eq(true)
      end

      it "should raise and error when the balance is less than the minimum fare" do
        (Oystercard::DEFAULT_LIMIT/Oystercard::MINIMUM_FARE).times {subject.touch_out(station1) }
        expect { subject.touch_in(station) }.to raise_error("Insufficient funds")
      end

      # it 'should store the entry location' do
      #   subject.touch_in(station)
      #   expect(subject.entry_station).to eq(station)
      # end
    end

    describe "#touch_out" do
      it "should not be in a journey after touching out" do
        subject.touch_in(station)
        subject.touch_out(station1)
        expect( subject.in_journey? ).to eq(false)
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
