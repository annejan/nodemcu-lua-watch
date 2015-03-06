ds3231=require("ds3231")
ds3231.init(3, 4)

-- Get date and time
second, minute, hour, day, date, month, year = ds3231.getTime();

-- Print date and time
print(string.format("Time & Date: %s:%s:%s %s/%s/%s", 
    hour, minute, second, date, month, year))

-- Don't forget to release it after use
ds3231 = nil
package.loaded["ds3231"]=nil
