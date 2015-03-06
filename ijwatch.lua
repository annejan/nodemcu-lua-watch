wifi.setmode(wifi.STATION)
wifi.sta.config("JinXed","AnneJanBrouwer")
wifi.sta.connect()
oled.setup(3,4)
oled.line(1,1,"ijWatch 0.1.6    test")
tmr.alarm(1, 1000, 1, function()
  if wifi.sta.getip() == nil then
    oled.line(3,1,"Connecting to wifi")
  else
    tmr.stop(1)
    oled.line(2,2,wifi.sta.getip())
    loadfile("ntp.lua")():sync(function(T) oled.line(3,2, T:show_time()) end)
  end
end)
