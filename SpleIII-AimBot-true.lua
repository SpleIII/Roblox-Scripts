local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
 
local aimbotEnabled = false
local aimKey = Enum.KeyCode.H
local aimPart = "Head" -- Change this to the part you want to aim at
 
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
 
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild(aimPart) then
            local partPos = camera:WorldToViewportPoint(v.Character[aimPart].Position)
            local mousePos = userInputService:GetMouseLocation()
            local distance = (Vector2.new(partPos.X, partPos.Y) - mousePos).magnitude
 
            if distance < shortestDistance then
                closestPlayer = v
                shortestDistance = distance
            end
        end
    end
 
    return closestPlayer
end
 
userInputService.InputBegan:Connect(function(input)
    if input.KeyCode == aimKey then
        aimbotEnabled = true
    end
end)
 
userInputService.InputEnded:Connect(function(input)
    if input.KeyCode == aimKey then
        aimbotEnabled = false
    end
end)
 
runService.RenderStepped:Connect(function()
    if aimbotEnabled then
        local closestPlayer = getClosestPlayer()
        if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild(aimPart) then
            camera.CFrame = CFrame.new(camera.CFrame.Position, closestPlayer.Character[aimPart].Position)
        end
    end
end)
