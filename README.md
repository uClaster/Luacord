# Luacord

# • Depedencies 
• Luvit 
• coro-http 
• coro-websocket 

# Installation 

Install [luvit](https://luvit.io/) and follow the instruction. 
Install the needed package in terminal:
• lit install creationix/coro-websocket 
• lit install creationix/coro-http

• Link: https://github.com/uClaster/Luacord.git 
• Write git clone and paste link above 
• Locate the module. 
• Run your code in terminal with **luvit name_file.lua**

# Code example 
• In **main.lua** 
```lua 
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

bot:login(config.token)
```