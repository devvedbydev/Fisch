local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ContextActionService = game:GetService('ContextActionService')
local VirtualInputManager = game:GetService('VirtualInputManager')
local LocalPlayer = Players.LocalPlayer

local Enabled = false
local Rod = nil
local Progress = false

local Keybind = Enum.KeyCode.Q

function ShowNotification(String)
    game.StarterGui:SetCore('SendNotification', {
        Title = 'Notification',
        Text = String,
        Duration = 5
    })
end

function ToggleFarm(Name, State, Input)
    if State == Enum.UserInputState.Begin then
        Enabled = not Enabled
        LocalPlayer.Character.HumanoidRootPart.Anchored = Enabled
        
        if not Enabled and Rod then
            Rod.events.reset:FireServer()
        end
        
        ShowNotification(Enabled and 'Autofarm Enabled' or 'Autofarm Disabled')
    end
end

LocalPlayer.Character.ChildAdded:Connect(function(Child)
    if Child:IsA('Tool') and Child.Name:lower():find('rod') then
        Rod = Child
    end
end)

LocalPlayer.Character.ChildRemoved:Connect(function(Child)
    if Child == Rod then
        Enabled = false
        Rod = nil
    end
end)

LocalPlayer.PlayerGui.DescendantAdded:Connect(function(Descendant)
    if Descendant.Name == 'button' and Descendant.Parent.Name == 'safezone' then
        task.wait(0.1)
        local ButtonPosition, ButtonSize = Descendant.AbsolutePosition, Descendant.AbsoluteSize
        VirtualInputManager:SendMouseButtonEvent(ButtonPosition.X + (ButtonSize.X / 2), ButtonPosition.Y + (ButtonSize.Y / 2), Enum.UserInputType.MouseButton1.Value, true, LocalPlayer.PlayerGui, 1)
        VirtualInputManager:SendMouseButtonEvent(ButtonPosition.X + (ButtonSize.X / 2), ButtonPosition.Y + (ButtonSize.Y / 2), Enum.UserInputType.MouseButton1.Value, false, LocalPlayer.PlayerGui, 1)
    elseif Descendant.Name == 'playerbar' and Descendant.Parent.Name == 'bar' then
        Descendant:GetPropertyChangedSignal('Position'):Wait()
        ReplicatedStorage.events.reelfinished:FireServer(100, true)
    end
end)

LocalPlayer.PlayerGui.DescendantRemoving:Connect(function(Descendant)
    if Descendant.Name == 'reel' then
        Progress = false
    end
end)

coroutine.wrap(function()
    while true do
        if Enabled and not Progress and Rod then
            Progress = true
            task.wait(0.5)
            Rod.events.reset:FireServer()
            Rod.events.cast:FireServer(100.5)
        end
        task.wait()
    end
end)()

ContextActionService:BindAction('ToggleFarm', ToggleFarm, false, Keybind)
ShowNotification('Press Q to toggle autofarm, You must manually equip your fishing rod first.')
