id=0  -- need this to identify (software) IC2 bus?
sda=3 -- connect to pin GPIO0
scl=4 -- connect to pin GPIO2
addr=0x3C -- the I2C address of our device

i2c.setup(id,sda,scl,i2c.SLOW)

function read_reg(dev_addr, reg_addr)
     i2c.start(id)
     i2c.address(id, dev_addr ,i2c.TRANSMITTER)
     i2c.write(id,reg_addr)
     i2c.stop(id)
     i2c.start(id)
     i2c.address(id, dev_addr,i2c.RECEIVER)
     c=i2c.read(id,1)
     i2c.stop(id)
     return c
end

function write_reg(dev_addr, reg_addr, reg_val)
     i2c.start(id)
     i2c.address(id, dev_addr, i2c.TRANSMITTER)
     i2c.write(id, reg_addr)
     i2c.write(id, reg_val)
     i2c.stop(id)
end

function oled_command(cmd)
     write_reg(addr,0x00,cmd)
end

function display()
oled_command(0x21) -- set column addresses
oled_command(0x00) -- reset column start address
oled_command(0x7F) -- reset column end address
oled_command(0x22) -- set page addresses
oled_command(0x00) -- reset page start address
oled_command(0x07) -- reset page end address
end

function init_oled() -- Initialises the 128x64 oled
print("starting")
oled_command(0xAE) -- turn off oled panel
oled_command(0xA8) -- set multiplex ratio to 1 byte following
oled_command(0x3F) -- 1/64 duty (N+1 MUX: 1-64))
oled_command(0xD3) -- set display offset to 1 byte following
oled_command(0x00) -- no offset

oled_command(0x40) -- set start line address
oled_command(0xA0) -- set segment remap
oled_command(0xC0) -- set COM output scan direction
oled_command(0xDA) -- set com pins hardware configuration to 1 byte following
oled_command(0x12) -- set pins

oled_command(0x81) -- set contrast control register
oled_command(0x7f) -- reset contrast to default value

oled_command(0xA4) -- set display on
oled_command(0xA6) -- set normal display
oled_command(0xD5) -- set display clock divide ratio/oscillator frequency
oled_command(0x80) -- set divide ratio

oled_command(0x8D) -- set Charge Pump enable/disable
oled_command(0x14) -- set(0x10) disable

oled_command(0xAF) -- turn on oled panel
print("Init done")
end

function fill()
     for m=0,7 do
          oled_command(0xb0+m)
          oled_command(0x00)
          oled_command(0x10)
          for n=0,131 do
               write_reg(addr,0x40,0x00)                
          end
         
     end
end

function OLED_ShowChar()
     x=2
     y=60
          OLED_SetPos(x,y)
          write_reg(addr,0x40,0x7C)
          write_reg(addr,0x40,0x12)
          write_reg(addr,0x40,0x11)
          write_reg(addr,0x40,0x12)
          write_reg(addr,0x40,0x7C)
      
end
function OLED_SetPos(x,y)
     oled_command(0xb0+y)
     oled_command(0x10)
     oled_command(0x01)
end

init_oled()
fill()
OLED_ShowChar()
