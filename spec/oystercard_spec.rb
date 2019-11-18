require 'oystercard'
describe Oystercard do
  
  describe '#balance' do
    it 'should show 0 balance' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'should increase the balance by 10' do
      expect{ subject.top_up(10) }.to change{ subject.balance }.by (10)
    end
    it 'should increase the balance by 5 twice' do
      expect{ 2.times{subject.top_up(5)} }.to change{ subject.balance }.by (10)
    end
  end
end