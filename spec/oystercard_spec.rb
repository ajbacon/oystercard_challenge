require 'oystercard'
describe Oystercard do
  
  describe '#balance' do
    it 'should show 0 balance' do
      expect(subject.balance).to eq(0)
    end
  end
end