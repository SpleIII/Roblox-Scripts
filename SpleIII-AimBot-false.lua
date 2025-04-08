local teamCheck = false
local fov = 90
local smoothing = 1
local predictionFactor = 0.08  -- Adjust this factor to improve prediction accuracy
local highlightEnabled = false  -- Variable to enable or disable target highlighting. Change to False if using an ESP script.
local lockPart = "HumanoidRootPart"  -- Choose what part it locks onto. Ex. HumanoidRootPart or Head

local Toggle = true  -- Enable or disable toggle mode
local ToggleKey = Enum.KeyCode.MouseButton4  -- Choose the key for toggling aimbot lock

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

getgenv().AddNotification = function(title, text) game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) end
    AddNotification('Читы','AimBot - Включён')

local FOVring = Drawing.new("Circle")
FOVring.Visible = false
FOVring.Thickness = 1
FOVring.Radius = fov
FOVring.Transparency = 0.8
FOVring.Color = Color3.fromRGB(255, 128, 128)
FOVring.Position = workspace.CurrentCamera.ViewportSize / 2

local currentTarget = nil
local aimbotEnabled = true
local toggleState = false  -- Variable to keep track of toggle state
local debounce = false  -- Debounce variable

local function getClosest(cframe)
    local ray = Ray.new(cframe.Position, cframe.LookVector).Unit
    local target = nil
    local mag = math.huge
    local screenCenter = workspace.CurrentCamera.ViewportSize / 2

    for i, v in pairs(Players:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild(lockPart) and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and v ~= Players.LocalPlayer and (v.Team ~= Players.LocalPlayer.Team or (not teamCheck)) then
            local screenPoint, onScreen = workspace.CurrentCamera:WorldToViewportPoint(v.Character[lockPart].Position)
            local distanceFromCenter = (Vector2.new(screenPoint.X, screenPoint.Y) - screenCenter).Magnitude

            if onScreen and distanceFromCenter <= fov then
                local magBuf = (v.Character[lockPart].Position - ray:ClosestPoint(v.Character[lockPart].Position)).Magnitude

                if magBuf < mag then
                    mag = magBuf
                    target = v
                end
            end
        end
    end

    return target
end

local function updateFOVRing()
    FOVring.Position = workspace.CurrentCamera.ViewportSize / 2
end

local function highlightTarget(target)
    if highlightEnabled and target and target.Character then
        local highlight = Instance.new("Highlight")
        highlight.Adornee = target.Character
        highlight.FillColor = Color3.fromRGB(255, 128, 128)
        highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
        highlight.Parent = target.Character
    end
end

local function removeHighlight(target)
    if highlightEnabled and target and target.Character and target.Character:FindFirstChildOfClass("Highlight") then
        target.Character:FindFirstChildOfClass("Highlight"):Destroy()
    end
end

local function predictPosition(target)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local velocity = target.Character.HumanoidRootPart.Velocity
        local position = target.Character[lockPart].Position
        local predictedPosition = position + (velocity * predictionFactor)
        return predictedPosition
    end
    return nil
end

local function handleToggle()
    if debounce then return end
    debounce = true
    toggleState = not toggleState
    wait(0.3)  -- Debounce time to prevent multiple toggles
    debounce = false
end

loop = RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        updateFOVRing()

        local localPlayer = Players.LocalPlayer.Character
        local cam = workspace.CurrentCamera
        local screenCenter = workspace.CurrentCamera.ViewportSize / 2

        if Toggle then
            if UserInputService:IsKeyDown(ToggleKey) then
                handleToggle()
            end
        else
            toggleState = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
        end

        if toggleState then
            if not currentTarget then
                currentTarget = getClosest(cam.CFrame)
                highlightTarget(currentTarget)  -- Highlight the new target if enabled
            end

            if currentTarget and currentTarget.Character and currentTarget.Character:FindFirstChild(lockPart) then
                local predictedPosition = predictPosition(currentTarget)
                if predictedPosition then
                    workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(cam.CFrame.Position, predictedPosition), smoothing)
                end
                FOVring.Color = Color3.fromRGB(0, 255, 0)  -- Change FOV ring color to green when locked onto a target
            else
                FOVring.Color = Color3.fromRGB(255, 128, 128)  -- Revert FOV ring color to original when not locked onto a target
            end
        else
            if currentTarget and highlightEnabled then
                removeHighlight(currentTarget)  -- Remove highlight from the old target
            end
            currentTarget = nil
            FOVring.Color = Color3.fromRGB(255, 128, 128)  -- Revert FOV ring color to original when not locked onto a target
        end
    end
end)
