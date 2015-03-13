sda = 3
scl = 4
sla = 0x3c

i2c.setup(0, sda, scl, i2c.SLOW)
disp = u8g.ssd1306_128x64_i2c(sla)

disp:setFont(u8g.font_6x10)
disp:setFontRefHeightExtendedText()
disp:setDefaultForegroundColor()
disp:setFontPosTop()

function drawAnus()
	disp:drawStr(0, 0, "ijWatch")
end

function drawCircle()
     disp:drawStr(0, 0, "ijWatch 0.1.8")
     disp:drawCircle(10, 18+30, 9)
     disp:drawCircle(24, 16+30, 7)
end

disp:firstPage()
repeat
	drawAnus()
until disp:nextPage() == false

disp:firstPage()
repeat
	drawCircle()
until disp:nextPage() == false
