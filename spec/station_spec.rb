require 'station'

describe Station do
  
    it "should have a name" do
      station = Station.new('Aldgate East', 'zone 2')
      expect(station).to respond_to(:name)
    end

    it "should have a zone" do
      station = Station.new('Aldgate East', 'zone 2')
      expect(station).to respond_to(:zone)
    end


end