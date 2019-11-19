require 'oystercard'
describe Oystercard do
  
  describe '#balance' do
    it 'should show 0 balance' do
      expect(subject.balance).to eq(0)
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
      subject.top_up(90)
      expect{ subject.top_up(10) }.to raise_error("Exceed maximum balance #{Oystercard::DEFAULT_LIMIT}" )
    end
  end
  end

  describe '#deduct' do
    it 'should deduct given quantitiy from balance' do
      subject.top_up(10)
      expect { subject.deduct(3) }.to change { subject.balance }.by (-3)
    end

    it 'should deduct given quantity from balance' do
      subject.top_up(10)
      expect { subject.deduct(5) }.to change { subject.balance }.by (-5)
    end

    it 'should raise error when the balance goes negative' do
      subject.top_up(5)
      expect { subject.deduct(10) }.to raise_error("Insufficient funds")
    end
  end


end