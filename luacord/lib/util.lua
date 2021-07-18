
local uv = require("uv") 

function setInterval(fms, lms, callback, tbl)
    local timer = uv.new_timer() 
    timer:start(fms, lms, function()
        coroutine.wrap(callback)(tbl)
    end)
end     

function rawInsert(tbl, dict, exception) 
    -- i'd add later;lol
end     

return {
    setInterval = setInterval 
}