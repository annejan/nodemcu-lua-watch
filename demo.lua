oled = require("oled")

oled.init(0, 2)

oled.set_pos(75, 3) -- set cursor to 75, 3

we = {"H","e","l","l","o","(","l","o","l",")"}

oled.write_word(we) -- write Hello(lol)

oled.scroll(0x00, 0x0f) -- start scroll

state = 0

tmr.alarm(3, 500, 1, function() -- invert every 0.5s
     oled.invert(state)
     state = bit.bxor(state, 1)
end)

tmr.alarm(4, 3000, 0, function() -- stop scroll and clear after 4 sec
     tmr.stop(3)
     oled.scroll_stop()
     oled.clear()
     oled.invert(0)
end)
