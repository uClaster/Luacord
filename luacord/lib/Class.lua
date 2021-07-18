
local class = {} 

function class:MessageAble(ctx, http) 
    
    local Messageable = {} 
    
    function Messageable:send(message) 
        
        local msg = {
            content = message, 
            tts = false 
        }
        
        http:Route("POST", msg, ctx)
        
    end     
    
    return Messageable 
    
end     

function class:TextChannel(prop, http) 
    
    local channel = {} 
    channel.id = prop.channel_id or nil
    
    local context = "/channels/"..channel.id.."/messages" 
    
    local messageable = self:MessageAble(context, http) 
    
    channel.send = messageable.send 
    
    return channel 
    
end     

return class 