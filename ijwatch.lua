sda = 3
scl = 4
sla = 0x3c

i2c.setup(0, sda, scl, i2c.SLOW)
disp = u8g.ssd1306_128x64_i2c(sla)

disp:setFont(u8g.font_6x10)
disp:setFontRefHeightExtendedText()
disp:setDefaultForegroundColor()
disp:setFontPosTop()

function drawWatch()
  disp:drawCircle(96, 32, 32)
  disp:drawStr(0, 0, "ijWatch")
end

function drawTime(tijd)
  disp:firstPage()
  repeat
    drawWatch()
    disp:setFont(u8g.font_9x15)
    disp:drawStr(0, 32, tijd)
    disp:setFont(u8g.font_6x10)
  until disp:nextPage() == false
end

disp:firstPage()
repeat
  drawWatch()
until disp:nextPage() == false

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
    else
      tmr.stop(1)
      disp:firstPage()
      repeat
        drawWatch()	
        disp:drawStr(0, 11, wifi.sta.getip())
      until disp:nextPage() == false
      
      loadfile("ntp.lua")():sync(function(T) drawTime(T:show_time()) end) 
    end
  end
end)

-- dsleep(60000000)
