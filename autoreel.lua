args = {
    [1] = 100,
    [2] = false
}

if _G.autoreel then
    game:GetService("ReplicatedStorage"):WaitForChild("events"):WaitForChild("reelfinished"):FireServer(unpack(args))
end
