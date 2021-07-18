-- An event handler;

local class = require("./Class") 

local EventHandler = {} 

function EventHandler.READY(bot, gateway, prop, http) 
    
    table.insert(bot, prop) -- full collection. you may obtain this with bot[1]
    
    bot.user = prop.user 
    
    gateway.READY()
    
end     

function EventHandler.MESSAGE_CREATE(bot, gateway, prop, http)
    
    local messageRebuild = {}
    
    messageRebuild.content = prop.content
    messageRebuild.id = prop.id 
    
    messageRebuild.channel = class:TextChannel(prop, http)
    
    messageRebuild.author = prop.author 
    
    gateway.MESSAGE_CREATE(messageRebuild)
    
end     

return EventHandler