local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local function highlightPlayers()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local highlight = Instance.new("Highlight")
            highlight.Parent = player.Character
            highlight.FillColor = Color3.fromRGB(0, 255, 0)
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
            highlight.OutlineTransparency = 0
        end
    end
end

RunService.Heartbeat:Connect(function()
    highlightPlayers()
end)
