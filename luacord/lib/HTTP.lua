local http = require("coro-http") 
local json = require("json")
local format = string.format 

local HTTP  = {} 
HTTP.API = "https://discord.com/api/v6"

function HTTP:init(kwargs) 
    self.token = kwargs.token 
    self.header = {
            {"Authorization", format("Bot %s", self.token)}, 
            {"Content-Type", "application/json"}
        }
end     

function HTTP:Route(method, req, ctx) 
    
    context = HTTP.API..ctx 
    req = json.encode(req)
    
    if method:lower() == "post" then 
        
        local res = http.request("POST", context, self.header, req)
        
    end     
    
end     

return HTTP