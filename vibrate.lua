n = 0
vibrate = false

gpio.mode(5,gpio.OUTPUT)

vibrate = function (state) 
	if state == true then 
		tmr.alarm(3, 500, 1, function() 
			if n % 2 == 0 then
				gpio.write(5,gpio.HIGH)
			else
				gpio.write(5,gpio.LOW)
			end
			n = n + 1
		end)
	else 
		tmr.stop(3)
		gpio.write(5,gpio.LOW)
	end
end
