
local uv = require("uv") 
local ws = require("coro-websocket") 
local json = require("json") 
local util = require("./lib/util")
local EventHandler = require("./lib/EventHandler") 
local HTTP = require("./lib/HTTP")

local encode, decode = json.encode, json.decode 

TEXT, BINARY, CLOSE = 1, 2, 8

local gateway = {} 

gateway.wss = "wss://gateway.discord.gg/?v=9&encoding=json"

function gateway:pack(kwargs)
    
    for i, v in pairs(kwargs) do 
        self[i] = v 
    end     
    
end     

function gateway:performHandshake() 
    
    local host = ws.parseUrl(self.wss)
    
    local options = {
        path = host.path, 
        host = host.host, 
        port = host.port, 
        tls = host.tls 
    }
    
    local res, read, write = ws.connect(options)
    
    self:pack({
        _read = read, 
        _write = write 
    })
    
end   

function gateway.heartbeat(self) 
    
    op1 = {
        op = 1, 
        d = 251 
    }
    
    self._write({opcode = TEXT, payload = encode(op1)})
    
end     

function gateway:identify() 
    
    IDENTIFY = {
        op = 2, 
        d = {
            token = self.token, 
            intents = 513,
            properties = {}
        }
    }
    
    local props = IDENTIFY.d.properties
    props["$os"] = "linux" 
    props["$browser"] = "luacord"
    props["$device"] = "luacord"
    
    local success, err = self._write({opcode = TEXT, payload = encode(IDENTIFY)})
    
    HTTP:init({
        token = self.token 
        })
    
end     

function gateway:start() 
    
    self:performHandshake() 
    
    coroutine.wrap(function()
        
        for chunk in self._read do 
            
            payload = decode(chunk.payload)
            
            if payload == nil and self.reconnecting == true then error("Improper token has been passed.") end 
            
            if payload ~= nil then 
                
                if payload.op == 10 then 
                
                    util.setInterval(5000, 41000, self.heartbeat, gateway)
            
                elseif payload.op == 11 then 
                
                    -- Successful ACK
                
                    self.reconnecting = false 
                
                    gateway:identify()
                
                elseif payload.op == 0 then
                
                    if self[payload.t] ~= nil then 
                    
                        EventHandler[payload.t](self.bot, self, payload.d, HTTP)
                    
                    end     
                
                self.sequence = self.sequence + 1
                
                end 
                
            end      
            
        end     
        
    end)()
    
end     

return gateway 

--./package/luvit main.lua 