local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robojini/Tuturial_UI_Library/main/UI_Template_1"))()
local Window = Library.CreateLib("SpleIII Tools", "RJTheme7")

-- Вкладки
local Functions = Window:NewTab("Функции")
local MultiplierSimulatorX = Window:NewTab("Multiplier Simulator X")
local Socials = Window:NewTab("Ссылки")
local Esp = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/x114/RobloxScripts/main/OpenSourceEsp"))()

-- Скрипт для всех режимов
local Section = Functions:NewSection("Простые функции")

Section:NewButton("Включить флай (B)", "Включить\Выключить режим полёта (B)", function()
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
        flying = not flying
        if flying then
            workspace.Gravity = 0 
            fly() 
            AddNotification('Флай','Флай - Выключен')
        else
            flySpeed = 100 
            HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            workspace.Gravity = originalGravity
            AddNotification('Флай','Флай - Включён')
        end
    end
end)
end)

Section:NewButton("Включить Ноуклип (N)", "Включить\Выключить режим ноуклипа (N)", function()
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
Section:NewButton("Сбросить силу прыжка", "Устанавливается сила прыжка на стартовое значение 50", function()
    getgenv().AddNotification = function(title, text) game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) end
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    AddNotification('Сброс','Текущая сила прыжка - 50')
end)
Section:NewButton("Сбросить силу прыжка", "Устанавливается сила прыжка на стартовое значение 50", function()

end)
Section:NewButton("Сбросить гравитацию", "Устанавливается гравитация на стартовое значение 300", function()
    getgenv().AddNotification = function(title, text) game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) end
    game.Workspace.Gravity = 300
    AddNotification('Сброс','Текущая гравитация - 300')
end)
Section:NewButton("Включить WallHack", "", function()
    getgenv().AddNotification = function(title, text) game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) end
    local Esp = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/x114/RobloxScripts/main/OpenSourceEsp"))()
	Esp.Box = true
	Esp.BoxColor = Color3.fromRGB(0,255,0)
	Esp.BoxOutline = true
	Esp.BoxOutlineColor = Color3.fromRGB(0,0,0)
	Esp.HealthBar = true
	Esp.HealthBarSide = "Left" -- Left,Bottom,Right
	Esp.Names = true
	Esp.NamesColor = Color3.fromRGB(255,255,255)
	Esp.NamesOutline = true
	Esp.NamesFont = 2
	Esp.NamesSize = 13
    AddNotification('WallHack','Wallhack - Включён')
end)

-- Скрипт для режима [🔥39M] Multiplier Simulator X

local MultiplierSimulatorX = MultiplierSimulatorX:NewSection("Телепорт на кнопки")
MultiplierSimulatorX:NewDropdown("Rebirth", "", {"1 Rebirth", "3 Rebirth", "10 Rebirth", "20 Rebirth", "50 Rebirth", "100 Rebirth", "200 Rebirth", "450 Rebirth", "800 Rebirth", "1500 Rebirth", "3000 Rebirth", "5000 Rebirth", "7500 Rebirth"}, function(drop)
    if drop == "1 Rebirth" then
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(476.328491, 3.48207605, -9.50658226, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3 Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(483.328522, 3.48207605, -9.50658512, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10 Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(490.328522, 3.48207605, -9.50658703, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "20 Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(497.328522, 3.48207605, -9.50658989, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "50 Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(504.328522, 3.48207605, -9.50659275, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "100 Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(511.328522, 3.48207605, -9.50659275, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "200 Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(518.328522, 3.48207605, -9.50659275, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "450 Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(525.328522, 3.48207605, -9.50659275, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "800 Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(532.328522, 3.48207605, -9.50659275, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "1500 Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(539.328522, 3.48207605, -9.50659275, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3000 Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(546.328522, 3.48207605, -9.50659275, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "5000 Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(553.328522, 3.48207605, -9.50659275, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "7500 Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(560.328522, 3.48207605, -9.50659275, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end
end)
MultiplierSimulatorX:NewDropdown("Ultra Rebirth", "", {"1 Ultra Rebirth", "3 Ultra Rebirth", "10 Ultra Rebirth", "25 Ultra Rebirth", "50 Ultra Rebirth", "100 Ultra Rebirth", "250 Ultra RebirthUltra Rebirth", "500 Ultra RebirthUltra Rebirth", "1000 Ultra RebirthUltra Rebirth", "2500 Ultra RebirthUltra Rebirth", "5000 Ultra RebirthUltra Rebirth", "10000 Ultra RebirthUltra Rebirth", "35000 Ultra RebirthUltra Rebirth"}, function(drop)
    if drop == "1 Ultra Rebirth" then
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(446.85965, 3.6661948, 11.0857506, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(439.85965, 3.6661948, 11.0857544, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(432.85965, 3.6661948, 11.0857544, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "20 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(425.85965, 3.6661948, 11.0857544, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "50 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(425.85965, 3.6661948, 11.0857544, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "100 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(511.328522, 3.48207605, -9.50659275, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "200 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(518.328522, 3.48207605, -9.50659275, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "450 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(525.328522, 3.48207605, -9.50659275, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "800 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(532.328522, 3.48207605, -9.50659275, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "1500 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(539.328522, 3.48207605, -9.50659275, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3000 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(546.328522, 3.48207605, -9.50659275, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "5000 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(553.328522, 3.48207605, -9.50659275, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "7500 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(560.328522, 3.48207605, -9.50659275, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end
end)

-- Ссылки для помощи
local Socials = Socials:NewSection("Вспомогательные ссылки")
Socials:NewButton("Дискорд Сервер", "", function()
    setclipboard("https://dsc.gg/cosmods")
end)
Socials:NewButton("Дискорд Студия", "", function()
    setclipboard("https://dsc.gg/cosmostd")
end)
Socials:NewButton("Телеграм канал", "", function()
    setclipboard("https://t.me/cosmowrd")
end)
