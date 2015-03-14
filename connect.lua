wifi.sta.connect()
tmr.alarm(1, 1000, 1, function()
  drawn = false
  if wifi.sta.getip() == nil then
    if not drawn then
      disp:firstPage()
      repeat
        drawWatch()	
        disp:drawStr(0, 11, "connecting")
      until disp:nextPage() == false
      drawn = true
    end
  else
    tmr.stop(1)
    disp:firstPage()
    repeat
      drawWatch()	
      disp:drawStr(0, 54, wifi.sta.getip())
    until disp:nextPage() == false
    loadfile("ntp.lua")():sync(function(T) drawTime(T:show_time()) end) 
  end
end)
