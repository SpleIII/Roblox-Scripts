local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/SpleIII/Roblox-Scripts/refs/heads/main/SpleIII-UI.lua"))()
local Window = Library.CreateLib("SpleIII Tools", "Serpent")

-- Вкладки
local Section = Window:NewTab("Функции")
local Cheats = Window:NewTab("Читерские штучки")
local Misc = Window:NewTab("Прочее")
local MultiplierSimulatorX = Window:NewTab("Multiplier Simulator X")
local Socials = Window:NewTab("Ссылки")

-- Скрипт для всех режимов
local Section = Section:NewSection("Простые функции")

Section:NewButton("Включить флай (B)", "Включить/Выключить режим полёта (B)", function()
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
		AddNotification('Читы','Флай - Включён')
        if flying then
            workspace.Gravity = 0 
            fly() 
			AddNotification('Читы','Флай - Выключён')
        else
            flySpeed = 100 
            HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            workspace.Gravity = originalGravity
        end
    end
end)
end)

Section:NewButton("Включить Ноуклип (N)", "Включить/Выключить режим ноуклипа (N)", function()
	getgenv().AddNotification = function(title, text) game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) end
        noclip = false
game:GetService('RunService').Stepped:connect(function()
if noclip then
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
end
end)
plr = game.Players.LocalPlayer
mouse = plr:GetMouse()
mouse.KeyDown:connect(function(key)
 
if key == "n" then
noclip = not noclip
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
end
end)
print('Loaded')
print('Press "E" to noclip')
		AddNotification('Ноуклип','Ноуклип - '..tostring(Noclip))
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

Section:NewButton("Сбросить гравитацию", "Устанавливается гравитация на стартовое значение 300", function()
    getgenv().AddNotification = function(title, text) game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) end
    game.Workspace.Gravity = 300
    AddNotification('Сброс','Текущая гравитация - 300')
end)

-- Скрипт для шутеров

local Cheats = Cheats:NewSection("Скрипты для шутеров")
Cheats:NewButton("ВХ", "", function(state)
    getgenv().AddNotification = function(title, text) game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) end
    loadstring(game:HttpGet("https://raw.githubusercontent.com/SpleIII/Roblox-Scripts/refs/heads/main/SpleIII-ESP-True.lua"))()
    AddNotification('Читы','WallHack - Включён')
end)

Cheats:NewButton("АимБот (H)", "", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/SpleIII/Roblox-Scripts/refs/heads/main/SpleIII-AimBot-true.lua"))()
end)

-- Прочие скрипты

local Misc = Misc:NewSection("Телепорт к игрокам")

players = {}

for i,v in pairs(game:GetService("Players"):GetChildren()) do
   table.insert(players,v.Name)
end

Misc:NewDropdown("Выбрать игрока для телепортации", " ", players, function(abc)
    Select = abc
end)


Misc:NewButton("Обновить список", " ", function()
    table.clear(players)
for i,v in pairs(game:GetService("Players"):GetChildren()) do
   table.insert(players,v.Name)
end
end)

Misc:NewButton("Телепортироваться к игроку", " ", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[Select].Character.HumanoidRootPart.CFrame
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
MultiplierSimulatorX:NewDropdown("Ultra Rebirth", "", {"1 Ultra Rebirth", "3 Ultra Rebirth", "10 Ultra Rebirth", "25 Ultra Rebirth", "50 Ultra Rebirth", "100 Ultra Rebirth", "250 Ultra Rebirth", "500 Ultra Rebirth", "1000 Ultra Rebirth", "2500 Ultra Rebirth", "5000 Ultra Rebirth", "10000 Ultra Rebirth", "35000 Ultra Rebirth"}, function(drop)
    if drop == "1 Ultra Rebirth" then
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(446.85965, 3.6661948, 11.0857506, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(439.85965, 3.6661948, 11.0857544, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(432.85965, 3.6661948, 11.0857544, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "25 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(425.85965, 3.6661948, 11.0857544, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "50 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(418.85965, 3.6661948, 11.0857544, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "100 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(411.328522, 3.48207605, 11.0857544, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "250 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(404.328522, 3.48207605, 11.0857544, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "500 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(397.328522, 3.48207605, 11.0857544, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "1000 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(390.328522, 3.48207605, 11.0857544, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "2500 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(383.328522, 3.48207605, 11.0857544, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "5000 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(376.328522, 3.48207605, 11.0857544, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10000 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(369.328522, 3.48207605, 11.0857544, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "35000 Ultra Rebirth" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(362.328522, 3.48207605, 11.0857544, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end
end)
MultiplierSimulatorX:NewDropdown("Prestige", "", {"1 Prestige", "3 Prestige", "10 Prestige", "25 Prestige", "50 Prestige", "100 Prestige", "200 Prestige", "500 Prestige", "1000 Prestige", "2500 Prestige", "5000 Prestige", "10000 Prestige", "20000 Prestige"}, function(drop)
    if drop == "1 Prestige" then
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(476.357727, 3.66619503, 30.5769463, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3 Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(483.357727, 3.56619513, 30.5769424, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10 Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(490.85965, 3.6661948, 30.5769424, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "25 Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(497.85965, 3.6661948, 30.5769424, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "50 Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(504.85965, 3.6661948, 30.5769424, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "100 Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(511.328522, 3.48207605, 30.5769424, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "200 Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(518.328522, 3.48207605, 30.5769424, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "500 Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(525.328522, 3.48207605, 30.5769424, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "1000 Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(532.328522, 3.48207605, 30.5769424, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "2500 Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(539.328522, 3.48207605, 30.5769424, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "5000 Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(546.328522, 3.48207605, 30.5769424, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10000 Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(553.328522, 3.48207605, 30.5769424, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "20000 Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(560.328522, 3.48207605, 30.5769424, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end
end)
MultiplierSimulatorX:NewDropdown("Ultra Prestige", "", {"1 Ultra Prestige", "3 Ultra Prestige", "10 Ultra Prestige", "25 Ultra Prestige", "50 Ultra Prestige", "100 Ultra Prestige", "250 Ultra Prestige", "400 Ultra Prestige", "800 Ultra Prestige", "1400 Ultra Prestige", "3000 Ultra Prestige", "5000 Ultra Prestige", "10000 Ultra Prestige"}, function(drop)
    if drop == "1 Ultra Prestige" then
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(446.85965, 3.6661948, 61.0858421, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3 Ultra Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(439.85965, 3.6661948, 61.0858421, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10 Ultra Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(432.85965, 3.6661948, 61.0858421, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "25 Ultra Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(425.85965, 3.6661948, 61.0858421, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "50 Ultra Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(418.85965, 3.6661948, 61.0858421, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "100 Ultra Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(411.328522, 3.48207605, 61.0858421, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "250 Ultra Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(404.328522, 3.48207605, 61.0858421, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "400 Ultra Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(397.328522, 3.48207605, 61.0858421, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "800 Ultra Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(390.328522, 3.48207605, 61.0858421, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "1400 Ultra Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(383.328522, 3.48207605, 61.0858421, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3000 Ultra Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(376.328522, 3.48207605, 61.0858421, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "5000 Ultra Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(369.328522, 3.48207605, 61.0858421, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10000 Ultra Prestige" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(362.328522, 3.48207605, 61.0858421, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end
end)
MultiplierSimulatorX:NewDropdown("Power", "", {"1 Power", "3 Power", "10 Power", "25 Power", "50 Power", "100 Power", "250 Power", "400 Power", "800 Power", "1400 Power", "3000 Power", "5000 Power", "10000 Power"}, function(drop)
    if drop == "1 Power" then
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(753.863037, 3.66619503, -5.91956329, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3 Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(753.863037, 3.66619503, 1.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10 Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(753.863037, 3.66619503, 8.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "25 Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(753.863037, 3.66619503, 15.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "50 Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(753.863037, 3.66619503, 22.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "100 Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(753.863037, 3.66619503, 29.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "250 Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(753.863037, 3.66619503, 36.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "400 Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(753.863037, 3.66619503, 43.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "800 Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(753.863037, 3.66619503, 50.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "1400 Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(753.863037, 3.66619503, 57.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3000 Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(753.863037, 3.66619503, 64.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "5000 Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(753.863037, 3.66619503, 71.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10000 Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(753.863037, 3.66619503, 78.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end
end)
MultiplierSimulatorX:NewDropdown("Super Power", "", {"1 Super Power", "3 Super Power", "10 Super Power", "25 Super Power", "50 Super Power", "100 Super Power", "250 Super Power", "400 Super Power", "800 Super Power", "1400 Super Power", "3000 Super Power", "5000 Super Power", "10000 Super Power"}, function(drop)
    if drop == "1 Super Power" then
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(803.863159, 3.66619503, -5.91956329, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3 Super Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(803.863159, 3.66619503, 1.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10 Super Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(803.863159, 3.66619503, 8.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "25 Super Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(803.863159, 3.66619503, 15.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "50 Super Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(803.863159, 3.66619503, 22.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "100 Super Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(803.863159, 3.66619503, 29.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "250 Super Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(803.863159, 3.66619503, 36.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "400 Super Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(803.863159, 3.66619503, 43.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "800 Super Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(803.863159, 3.66619503, 50.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "1400 Super Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(803.863159, 3.66619503, 57.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3000 Super Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(803.863159, 3.66619503, 64.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "5000 Super Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(803.863159, 3.66619503, 71.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10000 Super Power" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(803.863159, 3.66619503, 78.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end
end)
MultiplierSimulatorX:NewDropdown("Dark Matter", "", {"1 Dark Matter", "3 Dark Matter", "10 Dark Matter", "25 Dark Matter", "50 Dark Matter", "100 Dark Matter", "250 Dark Matter", "400 Dark Matter", "800 Dark Matter", "1400 Dark Matter", "3000 Dark Matter", "5000 Dark Matter", "10000 Dark Matter"}, function(drop)
    if drop == "1 Dark Matter" then
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(853.863281, 3.66619503, -5.91956329, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3 Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(853.863281, 3.66619503, 1.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10 Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(853.863281, 3.66619503, 8.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "25 Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(853.863281, 3.66619503, 15.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "50 Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(853.863281, 3.66619503, 22.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "100 Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(853.863281, 3.66619503, 29.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "250 Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(853.863281, 3.66619503, 36.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "400 Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(853.863281, 3.66619503, 43.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "800 Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(853.863281, 3.66619503, 50.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "1400 Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(853.863281, 3.66619503, 57.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3000 Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(853.863281, 3.66619503, 64.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "5000 Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(853.863281, 3.66619503, 71.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10000 Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(853.863281, 3.66619503, 78.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end
end)
MultiplierSimulatorX:NewDropdown("Ultra Dark Matter", "", {"1 Ultra Dark Matter", "3 Ultra Dark Matter", "10 Ultra Dark Matter", "25 Ultra Dark Matter", "50 Ultra Dark Matter", "100 Ultra Dark Matter", "250 Ultra Dark Matter", "400 Ultra Dark Matter", "800 Ultra Dark Matter", "1400 Ultra Dark Matter", "3000 Ultra Dark Matter", "5000 Ultra Dark Matter", "10000 Ultra Dark Matter"}, function(drop)
    if drop == "1 Ultra Dark Matter" then
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(903.363403, 3.66619503, -5.91956329, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3 Ultra Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(903.363403, 3.66619503, 1.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10 Ultra Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(903.363403, 3.66619503, 8.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "25 Ultra Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(903.363403, 3.66619503, 15.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "50 Ultra Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(903.363403, 3.66619503, 22.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "100 Ultra Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(903.363403, 3.66619503, 29.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "250 Ultra Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(903.363403, 3.66619503, 36.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "400 Ultra Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(903.363403, 3.66619503, 43.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "800 Ultra Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(903.363403, 3.66619503, 50.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "1400 Ultra Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(903.363403, 3.66619503, 57.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3000 Ultra Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(903.363403, 3.66619503, 64.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "5000 Ultra Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(903.363403, 3.66619503, 71.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10000 Ultra Dark Matter" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(903.363403, 3.66619503, 78.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end
end)
MultiplierSimulatorX:NewDropdown("Unknown", "", {"1 Unknown", "3 Unknown", "10 Unknown", "25 Unknown", "50 Unknown", "100 Unknown", "250 Unknown", "400 Unknown", "800 Unknown", "1400 Unknown", "3000 Unknown", "5000 Unknown", "10000 Unknown"}, function(drop)
    if drop == "1 Unknown" then
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1141.86389, 3.66619503, 21.0805149, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3 Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1141.86389, 3.66619503, 28.0805149, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10 Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1141.86389, 3.66619503, 35.0805149, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "25 Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1141.86389, 3.66619503, 42.0805149, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "50 Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1141.86389, 3.66619503, 49.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "100 Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1141.86389, 3.66619503, 56.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "250 Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1141.86389, 3.66619503, 63.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "400 Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1141.86389, 3.66619503, 70.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "800 Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1141.86389, 3.66619503, 77.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "1400 Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1141.86389, 3.66619503, 84.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3000 Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1141.86389, 3.66619503, 91.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "5000 Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1141.86389, 3.66619503, 98.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10000 Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1141.86389, 3.66619503, 105.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end
end)
MultiplierSimulatorX:NewDropdown("Omega Unknown", "", {"1 Omega Unknown", "3 Omega Unknown", "10 Omega Unknown", "25 Omega Unknown", "50 Omega Unknown", "100 Omega Unknown", "250 Omega Unknown", "400 Omega Unknown", "800 Omega Unknown", "1400 Omega Unknown", "3000 Omega Unknown", "5000 Omega Unknown", "10000 Omega Unknown"}, function(drop)
    if drop == "1 Omega Unknown" then
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1191.86401, 3.66619503, 21.0805149, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3 Omega Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1191.86401, 3.66619503, 28.0805149, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10 Omega Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1191.86401, 3.66619503, 35.0805149, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "25 Omega Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1191.86401, 3.66619503, 42.0805149, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "50 Omega Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1191.86401, 3.66619503, 49.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "100 Omega Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1191.86401, 3.66619503, 56.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "250 Omega Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1191.86401, 3.66619503, 63.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "400 Omega Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1191.86401, 3.66619503, 70.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "800 Omega Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1191.86401, 3.66619503, 77.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "1400 Omega Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1191.86401, 3.66619503, 84.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3000 Omega Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1191.86401, 3.66619503, 91.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "5000 Omega Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1191.86401, 3.66619503, 98.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10000 Omega Unknown" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1191.86401, 3.66619503, 105.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end
end)
MultiplierSimulatorX:NewDropdown("Sweets", "", {"1 Sweets", "3 Sweets", "10 Sweets", "25 Sweets", "50 Sweets", "100 Sweets", "250 Sweets", "400 Sweets", "800 Sweets", "1400 Sweets", "3000 Sweets", "5000 Sweets", "10000 Sweets"}, function(drop)
    if drop == "1 Sweets" then
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1241.87, 3.66619503, 21.0805149, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3 Sweets" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1241.87, 3.66619503, 28.0805149, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10 Sweets" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1241.87, 3.66619503, 35.0805149, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "25 Sweets" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1241.87, 3.66619503, 42.0805149, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "50 Sweets" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1241.87, 3.66619503, 49.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "100 Sweets" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1241.87, 3.66619503, 56.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "250 Sweets" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1241.87, 3.66619503, 63.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "400 Sweets" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1241.87, 3.66619503, 70.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "800 Sweets" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1241.87, 3.66619503, 77.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "1400 Sweets" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1241.87, 3.66619503, 84.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "3000 Sweets" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1241.87, 3.66619503, 91.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "5000 Sweets" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1241.87, 3.66619503, 98.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10000 Sweets" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1241.87, 3.66619503, 105.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
end
end)
MultiplierSimulatorX:NewDropdown("Chocolate", "", {"1 Chocolate", "4 Chocolate", "10 Chocolate", "25 Chocolate", "75 Chocolate", "125 Chocolate", "300 Chocolate", "500 Chocolate", "1000 Chocolate", "1700 Chocolate", "4000 Chocolate", "7000 Chocolate", "15000 Chocolate"}, function(drop)
    if drop == "1 Chocolate" then
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1291.87, 3.66619503, 21.0805149, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "4 Chocolate" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1291.87, 3.66619503, 28.0805149, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "10 Chocolate" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1291.87, 3.66619503, 35.0805149, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "25 Chocolate" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1291.87, 3.66619503, 42.0805149, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "75 Chocolate" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1291.87, 3.66619503, 49.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "125 Chocolate" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1291.87, 3.66619503, 56.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "300 Chocolate" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1291.87, 3.66619503, 63.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "500 Chocolate" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1291.87, 3.66619503, 70.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "1000 Chocolate" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1291.87, 3.66619503, 77.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "1700 Chocolate" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1291.87, 3.66619503, 84.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "4000 Chocolate" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1291.87, 3.66619503, 91.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "7000 Chocolate" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1291.87, 3.66619503, 98.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
elseif drop == "15000 Chocolate" then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1291.87, 3.66619503, 105.08043694, 1, 0, 0, 0, 1, 0, 0, 0, 1)
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
