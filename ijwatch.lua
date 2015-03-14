dofile("oled.lua") 
function drawWatch()
  disp:drawCircle(96, 31, 31)
  disp:drawStr(0, 0, "ijWatch 0.2")
end
function drawTime(tijd)
  disp:firstPage()
  repeat
    drawWatch()
    disp:setFont(u8g.font_chikita)
    disp:drawStr(0, 25, tijd)
    disp:setFont(u8g.font_6x10)
    disp:drawStr(0, 54, wifi.sta.getip())
  until disp:nextPage() == false
end
disp:firstPage()
repeat
  drawWatch()
until disp:nextPage() == false
dofile("connect.lua")
