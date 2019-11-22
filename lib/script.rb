require './lib/oystercard.rb'
require './lib/journey.rb'
require './lib/journey_log.rb'
require './lib/station.rb'

oc = Oystercard.new
oc.top_up(90)
s1 = Station.new("s1",1)
s2 = Station.new("s2",1)
oc.touch_in(s1)
oc.touch_out(s2)
# balance should = 89
oc.touch_in(s1)
oc.touch_in(s1)
# balance should = 83
oc.touch_out(s2) 
# balance should = 82
oc.touch_out(s2) 
# balance should = 76
oc.balance




# balance should equal 76 after script