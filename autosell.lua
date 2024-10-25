local ReplicatedStorage=game:GetService("ReplicatedStorage")
local function log(message) print("[AutoSell] " .. message) end

local function startAutoSell()
    log("Auto-sell started.")
    while _G.autosell do
        local success, errorMessage=pcall(function()
            local sellFunction=workspace:WaitForChild("world"):WaitForChild("npcs"):WaitForChild("Marc Merchant"):WaitForChild("merchant"):WaitForChild("sell")
            if sellFunction then
                sellFunction:InvokeServer()
            else
                log("Sell function not found.")
            end
        end)
        if not success then log("Error: " .. errorMessage) end
        task.wait(0.2)
    end
    log("Auto-sell stopped.")
end

if _G.autoSell then startAutoSell() end
