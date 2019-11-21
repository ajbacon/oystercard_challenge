oc = Oystercard.new
oc.top_up(90)
s1 = Station.new("s1",1)
s2 = Station.new("s2",1)
oc.touch_in(s1)
oc.touch_out(s2)