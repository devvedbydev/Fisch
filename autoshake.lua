local PlayerGUI = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = game.Players.LocalPlayer

local function shakeButton(button)
    if _G.autoShake then
        task.wait(0.1)
        local pos = button.AbsolutePosition
        local size = button.AbsoluteSize
        VirtualInputManager:SendMouseButtonEvent(pos.X + size.X / 2, pos.Y + size.Y / 2, 0, true, LocalPlayer, 0)
        VirtualInputManager:SendMouseButtonEvent(pos.X + size.X / 2, pos.Y + size.Y / 2, 0, false, LocalPlayer, 0)
    end
end

local function onChildAdded(GUI)
    if GUI:IsA("ScreenGui") and GUI.Name == "shakeui" then
        local safezone = GUI:FindFirstChild("safezone")
        if safezone then
            safezone.ChildAdded:Connect(function(child)
                if child:IsA("ImageButton") and child.Name == "button" then
                    shakeButton(child)
                end
            end)
        end
    end
end

local shakeUI = PlayerGUI:FindFirstChild("shakeui")
if shakeUI then onChildAdded(shakeUI) end

PlayerGUI.ChildAdded:Connect(onChildAdded)
