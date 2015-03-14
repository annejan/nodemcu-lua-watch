return({
	hour=0,
	minute=0,
	second=0,
	lastsync=0,
	ustamp=0,
	tz=1,
	udptimer=2,
	udptimeout=1000,
	ntpserver="194.109.22.18",
	sk=nil,
	sync=function(self,callback)
		local request=string.char( 227, 0, 6, 236, 0,0,0,0,0,0,0,0, 49, 78, 49, 52,
		0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
		)
		self.sk=net.createConnection(net.UDP, 0)
		self.sk:on("receive",function(sck,payload) 
			sck:close()
			self.lastsync=self:calc_stamp(payload:sub(41,44))
			self:set_time()
			if callback and type(callback) == "function" then 
				callback(self)
			end
			collectgarbage() collectgarbage()
		end)
		self.sk:connect(123,self.ntpserver)
		tmr.alarm(self.udptimer,self.udptimeout,0,function() self.sk:close() end)
		self.sk:send(request)
	end,
	calc_stamp=function(self,bytes)
		local highw,loww,ntpstamp
		highw = bytes:byte(1) * 256 + bytes:byte(2)
		loww = bytes:byte(3) * 256 + bytes:byte(4)
		ntpstamp=( highw * 65536 + loww ) + ( self.tz * 3600)	-- NTP-stamp, seconds since 1.1.1900
		self.ustamp=ntpstamp - 1104494400 - 1104494400 		-- UNIX-timestamp, seconds since 1.1.1970
		return(self.ustamp)
	end,
	set_time=function(self)
		self.hour = self.ustamp % 86400 / 3600
		self.minute = self.ustamp % 3600 / 60
		self.second = self.ustamp % 60
	end,
	show_time=function(self)
		return(string.format("%02u:%02u:%02u",self.hour,self.minute,self.second))
	end,
	run=function(self,t,uinterval,sinterval,server)
		if server then self.ntpserver = server end
		self.lastsync = sinterval * 2 * -1	-- force sync on first run
		tmr.alarm(t,uinterval * 1000,1,function()
			self.ustamp = self.ustamp + uinterval
			self:set_time()
			if self.lastsync + sinterval < self.ustamp then
				self:sync()
			end
		end)
	end
})
