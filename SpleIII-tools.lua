local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robojini/Tuturial_UI_Library/main/UI_Template_1"))()
local Window = Library.CreateLib("SpleIII Tools", "RJTheme7")

local Tab = Window:NewTab("Функции")

local Section = Tab:NewSection("Простые функции")

Section:NewButton("Включить флай (B)", "Включить\Выключить режии полёта (B)", function()
    local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
getgenv().AddNotification = function(title, text) game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) end

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local flying = false
local flySpeed = 100 --Set up it to for yourself
local maxFlySpeed = 1000 --Set up it to for yourself
local speedIncrement = 0.4 --Set up it to for yourself
local originalGravity = workspace.Gravity

LocalPlayer.CharacterAdded:Connect(function(newCharacter) 
    Character = newCharacter
    Humanoid = Character:WaitForChild("Humanoid")
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
end)

local function randomizeValue(value, range)
    return value + (value * (math.random(-range, range) / 100))
end

local function fly()
    while flying do
        local MoveDirection = Vector3.new()
        local cameraCFrame = workspace.CurrentCamera.CFrame

        MoveDirection = MoveDirection + (UserInputService:IsKeyDown(Enum.KeyCode.W) and cameraCFrame.LookVector or Vector3.new())
        MoveDirection = MoveDirection - (UserInputService:IsKeyDown(Enum.KeyCode.S) and cameraCFrame.LookVector or Vector3.new())
        MoveDirection = MoveDirection - (UserInputService:IsKeyDown(Enum.KeyCode.A) and cameraCFrame.RightVector or Vector3.new())
        MoveDirection = MoveDirection + (UserInputService:IsKeyDown(Enum.KeyCode.D) and cameraCFrame.RightVector or Vector3.new())
        MoveDirection = MoveDirection + (UserInputService:IsKeyDown(Enum.KeyCode.Space) and Vector3.new(0, 1, 0) or Vector3.new())
        MoveDirection = MoveDirection - (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) and Vector3.new(0, 1, 0) or Vector3.new())

        if MoveDirection.Magnitude > 0 then
            flySpeed = math.min(flySpeed + speedIncrement, maxFlySpeed) 
            MoveDirection = MoveDirection.Unit * math.min(randomizeValue(flySpeed, 10), maxFlySpeed)
            HumanoidRootPart.Velocity = MoveDirection * 0.5
        else
            HumanoidRootPart.Velocity = Vector3.new(0, 0, 0) 
        end

        RunService.RenderStepped:Wait() 
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.B then
        AddNotification('Флай','Флай - '..tostring(flying))
        flying = not flying
        if flying then
            workspace.Gravity = 0 
            fly() 
        else
            AddNotification('Флай','Флай - '..tostring(flying))
            flySpeed = 100 
            HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            workspace.Gravity = originalGravity
        end
    end
end)
end)

Section:NewButton("Включить Ноуклип (N)", "Включить\Выключить режии ноуклипа (N)", function()
	getgenv().Players = game:GetService'Players'
getgenv().Host = Players.LocalPlayer
getgenv().AddNotification = function(title, text) game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) end
getgenv().RunService = game:GetService'RunService';
getgenv().ContextActionService = game:GetService'ContextActionService';

local Noclip = true;
local NoclipKey = 'N';

RunService.RenderStepped:Connect(function()
    if Noclip then
        for _,v in pairs(Host.Character:GetDescendants()) do
            if v:IsA'BasePart' and v.CanCollide then
                v.CanCollide = false
            end
        end
    else
        for _,v in pairs(Host.Character:GetDescendants()) do
            if v:IsA'BasePart' and not v.CanCollide then
                v.CanCollide = true
            end
        end
    end
end)

function Noclipping(ActionName:string, Properties:EnumItem)
    if ActionName == 'Ноуклип' then
        if not Properties or Properties == Enum.UserInputState.Begin then
            Noclip = not Noclip
            AddNotification('Ноуклип','Ноуклип - '..tostring(Noclip))
        end
    end
end

ContextActionService:BindAction('Ноуклип', Noclipping, true, Enum.KeyCode[NoclipKey])
end)

Section:NewSlider("Скорость бега", "Изменить скорость бега", 250, 0, function(s) -- 500 (Макс. значение) | 0 (Мин. значение)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

Section:NewButton("Сбросить скорость бега", "Устанавливается скорость бега на стартовое значение 16", function()
    getgenv().AddNotification = function(title, text) game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) end
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    AddNotification('Сброс','Текущая скорость бега - 16')
end)

Section:NewSlider("Сила прыжка", "Изменить силу прыжка", 500, 0, function(j) -- 500 (Макс. значение) | 0 (Мин. значение)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = j
end)

Section:NewButton("Сбросить силу прыжка", "Устанавливается сила прыжка на стартовое значение 50", function()
    getgenv().AddNotification = function(title, text) game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) end
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    AddNotification('Сброс','Текущая сила прыжка - 50')
end)

Section:NewSlider("Гравитация", "Изменить гравитацию", 1000, 0, function(g) -- 500 (Макс. значение) | 0 (Мин. значение)
    game.Workspace.Gravity = g
end)

Section:NewButton("Сбросить гравитацию", "Устанавливается гравитация на стартовое значение 300", function()
    getgenv().AddNotification = function(title, text) game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) end
    game.Workspace.Gravity = 300
    AddNotification('Сброс','Текущая гравитация - 300')
end)
