
local gateway = require("./gateway")
local format = string.format 

local Bot = {} 

function Bot:login(token) 
    
    if token == nil then return error("Nil token.") end 
    
    gateway:pack({token = token, first_heartbeat = true,
        reconnecting = true, 
        session_id = nil, 
        sequence = 0, 
        bot = Bot 
    }) 
    
    gateway:start()
        
end     

function Bot:on(fn, callback)
    fn = fn:upper()
    gateway[fn] = callback 
end     

return Bot 