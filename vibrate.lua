n = 0
vibrate = false

gpio.mode(5,gpio.OUTPUT)

tmr.alarm(3, 500, 1, function() 

	if vibrate then
		if n % 2 == 0 then
			gpio.write(5,gpio.HIGH)
		else
			gpio.write(5,gpio.LOW)
		end
		n = n + 1
	else
		n = 0
	end
end)
