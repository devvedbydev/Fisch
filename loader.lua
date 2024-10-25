_G.autosell = false --// Auto sell variable (true / false)
_G.autoshake = true --// Auto shake variable (true / false)
_G.autoreel = true --// Auto reel variable (true / false)

local function loadScripts()
    if _G.autoshake then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/devvedbydev/Fisch/refs/heads/main/autoshake.lua"))()
    end
    
    if _G.autosell then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/devvedbydev/Fisch/refs/heads/main/autosell.lua"))()
    end
    
    if _G.autoreel then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/devvedbydev/Fisch/refs/heads/main/autoreel.lua"))()
    end
end

loadScripts()

while true do
    wait(5) 
    loadScripts()
end
