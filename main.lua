local bot = require("./luacord/bot") 
local format = string.format

bot:on("ready", function()
    print(format("%s is ready!", bot.user.username))
end) 

bot:on("message_create", function(message)
    
    if message.content == "!ping" then 
        
        message.channel:send(format("%s, Pong!", message.author.username))
        
    end     
    
end)

bot:login(token)