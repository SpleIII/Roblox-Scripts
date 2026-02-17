    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/SpleIII/Roblox-Scripts/refs/heads/main/SpleIII-UI.lua"))()
    local Window = Library.CreateLib("SpleIII Tools", "Serpent")
    local sound = Instance.new("Sound", game.Workspace)

    -- Вкладки
    local Section = Window:NewTab("Функции (Шанс бана)")
    local Cheats = Window:NewTab("Для шутеров")
    local Rost = Window:NewTab("Rost Alpha")
    local MultiplierSimulatorX = Window:NewTab("Multiplier Simulator X (Шанс бана)")
    local OneStatPointEveryClick = Window:NewTab("🎃 +1 Stat Point Every Click 👻 (Шанс бана)")
    local Clicker = Window:NewTab("Кликер")
	local World = Window:NewTab("Мир")
    local Misc = Window:NewTab("Прочее")
    local Settings = Window:NewTab("Настройки")
    local Socials = Window:NewTab("Ссылки")
    local Screamer = Window:NewTab("Н̷̛͚̤Е̴̛͉͖ ̷̝̣̄З̸͉̎͘А̵͕̃̍Х̶̝̌̉О̵̭͝Д̷̨͎̇И̶̡̿ ̷̦̊С̷̱͈́͝Ю̵̭̊̈́Д̷̬̣́А̴̫́̈")

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
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SpleIII/Roblox-Scripts/refs/heads/main/SpleIII-Noclip.lua"))()
    end)

    Section:NewButton("Включить свободную камеру (Shift + P)", "Включить/Выключить режим свободной камеры (Shift + P)", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SpleIII/Roblox-Scripts/refs/heads/main/Freecam.lua"))()
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

-- Скрипт для шутеров

local Cheats = Cheats:NewSection("Скрипты для шутеров")

local wallhackESP = nil
local aimbotLoop = nil
local aimbotEnabled = false
local fov = 120

-- Инициализация ESP только когда это нужно
local function initializeESP()
    if not wallhackESP then
        wallhackESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/SpleIII/Roblox-Scripts/refs/heads/main/ESP/library.lua"))()
    end
    return wallhackESP
end

Cheats:NewLabel("Валлхак")

Cheats:NewToggle("ВаллХак", "Включить/выключить ESP для игроков", function(state)
    if state then
        getgenv().AddNotification = function(title, text) 
            game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) 
        end

        -- Инициализируем ESP
        local esp = initializeESP()
        
        -- Настройки ESP
        esp.Enabled = true
        
        AddNotification('Читы','WallHack - Включён')
    else
        if wallhackESP then
            wallhackESP.Enabled = false
            -- Не обнуляем wallhackESP, чтобы можно было снова включить
        end
        getgenv().AddNotification = function(title, text) 
            game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) 
        end
        AddNotification('Читы','WallHack - Выключён')
    end
end)

Cheats:NewToggle("Показывать Бокс", "Включить/выключить Бокс для игроков", function(state)
    local esp = initializeESP()
    if state then
        esp.ShowBox = true
    else
        esp.ShowBox = false
    end
end)

Cheats:NewToggle("Показывать Никнейм", "Включить/выключить Никнейм игроков", function(state)
    local esp = initializeESP()
    if state then
        esp.ShowName = true
    else
        esp.ShowName = false
    end
end)

Cheats:NewToggle("Показывать Здоровье", "Включить/выключить показ здоровья игроков", function(state)
    local esp = initializeESP()
    if state then   
        esp.ShowHealth = true
    else
        esp.ShowHealth = false
    end
end)

Cheats:NewToggle("Показывать Трасера", "Включить/выключить показ трасеров до игрока", function(state)
    local esp = initializeESP()
    if state then
        esp.ShowTracer = true
    else
        esp.ShowTracer = false
    end
end)

Cheats:NewToggle("Показывать Расстояние", "Включить/выключить показ дистанции до игрока", function(state)
    local esp = initializeESP()
    if state then
        esp.ShowDistance = true
    else
        esp.ShowDistance = false
    end
end)



-- Функция для получения ближайшего игрока в FOV
local function getClosestPlayer()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Camera = workspace.CurrentCamera
    
    local closestPlayer = nil
    local closestDistance = fov
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local character = player.Character
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            
            if humanoidRootPart then
                local screenPoint, onScreen = Camera:WorldToViewportPoint(humanoidRootPart.Position)
                
                if onScreen then
                    local mouse = game:GetService("UserInputService"):GetMouseLocation()
                    local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                    
                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
    end
    
    return closestPlayer
end


-- Обычный аимбот (ваш существующий код)
local function startAimbot()
    local teamCheck = false
    local currentFov = fov
    local smoothing = 1
    local predictionFactor = 0
    local highlightEnabled = true
    local lockPart = "Head"

    local Toggle = true
    local ToggleKey = Enum.KeyCode.H

    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local Players = game:GetService("Players")

    getgenv().AddNotification = function(title, text) game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) end
    AddNotification('Читы','AimBot - Включён')

    local FOVring = Drawing.new("Circle")
    FOVring.Visible = true
    FOVring.Thickness = 1
    FOVring.Radius = fov
    FOVring.Transparency = 0.8
    FOVring.Color = Color3.fromRGB(255, 128, 128)
    FOVring.Position = workspace.CurrentCamera.ViewportSize / 2

    local currentTarget = nil
    local toggleState = false
    local debounce = false

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
        FOVring.Radius = fov
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
        wait(0.3)
        debounce = false
    end

    aimbotLoop = RunService.RenderStepped:Connect(function()
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
                    highlightTarget(currentTarget)
                end

                if currentTarget and currentTarget.Character and currentTarget.Character:FindFirstChild(lockPart) then
                    local predictedPosition = predictPosition(currentTarget)
                    if predictedPosition then
                        workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(cam.CFrame.Position, predictedPosition), smoothing)
                    end
                    FOVring.Color = Color3.fromRGB(0, 255, 0)
                else
                    FOVring.Color = Color3.fromRGB(255, 128, 128)
                end
            else
                if currentTarget and highlightEnabled then
                    removeHighlight(currentTarget)
                end
                currentTarget = nil
                FOVring.Color = Color3.fromRGB(255, 128, 128)
            end
        end
    end)
end

local function stopAimbot()
    if aimbotLoop then
        aimbotLoop:Disconnect()
        aimbotLoop = nil
    end
    for _, drawing in pairs(getgenv() or {}) do
        if typeof(drawing) == "table" and drawing.ClassName == "Circle" then
            drawing:Remove()
        end
    end
    getgenv().AddNotification = function(title, text) 
        game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) 
    end
    AddNotification('Читы','AimBot - Выключён')
end

Cheats:NewLabel("АимБот")

-- Тогглы для аимбота
Cheats:NewToggle("АимБот", "Включить/выключить аимбот (H)", function(state)
    if state then
        aimbotEnabled = true
        startAimbot()
    else
        aimbotEnabled = false
        stopAimbot()
    end
end)

Cheats:NewSlider("Размер FOV", "Изменить размер FOV для AimBot", 360, 0, function(fovrange)
    fov = fovrange
end)


    -- Скрипт для режима Rost Alpha

    local Rost = Rost:NewSection("ВХ")

    Rost:NewButton("Коптер ЕСП", "", function()
    local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/SpleIII/Roblox-Scripts/refs/heads/main/Rost-Alpha/Esp.lua"))()
    ESP.Players = false
    ESP.Boxes = false
    ESP.Names = true
    ESP:Toggle(true)
    ESP:AddObjectListener(Workspace.Minicopter, { -- Object Path, For example: Workspace.ThisFolder
        Name = "Base", --Object name inside of the path, for example: Workspace.ThisFolder.Item_1
        CustomName = "copter", -- Name you want to be displayed
        Color = Color3.fromRGB(140, 0, 10), -- Color
        IsEnabled = "whatever" -- Any name, has to be the same as the last line: ESP.TheNameYouWant
    })
    ESP.whatever = true
    end)

    Rost:NewButton("Шкафы", "", function()
    local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/SpleIII/Roblox-Scripts/refs/heads/main/Rost-Alpha/Esp.lua"))()
    ESP.Players = false
    ESP.Boxes = false
    ESP.Names = true
    ESP:Toggle(true)
    ESP:AddObjectListener(Workspace.Builds, { -- Object Path, For example: Workspace.ThisFolder
        Name = "ToolCupboardModel", --Object name inside of the path, for example: Workspace.ThisFolder.Item_1
        CustomName = "Wardrobe", -- Name you want to be displayed
        Color = Color3.fromRGB(0, 200, 150), -- Color
        IsEnabled = "whatever" -- Any name, has to be the same as the last line: ESP.TheNameYouWant
    })
    ESP.whatever = true
    end)

    Rost:NewButton("Конопля", "", function()
    local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/SpleIII/Roblox-Scripts/refs/heads/main/Rost-Alpha/Esp.lua"))()
    ESP.Players = false
    ESP.Boxes = false
    ESP.Names = true
    ESP:Toggle(true)
    ESP:AddObjectListener(Workspace.Hemp, { -- Object Path, For example: Workspace.ThisFolder
        Name = "Hemp", --Object name inside of the path, for example: Workspace.ThisFolder.Item_1
        CustomName = "Hemp", -- Name you want to be displayed
        Color = Color3.fromRGB(0, 200, 150), -- Color
        IsEnabled = "whatever" -- Any name, has to be the same as the last line: ESP.TheNameYouWant
    })
    ESP.whatever = true
    end)

    Rost:NewButton("Серная руда", "", function()
    local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/SpleIII/Roblox-Scripts/refs/heads/main/Rost-Alpha/Esp.lua"))()
    ESP.Players = false
    ESP.Boxes = false
    ESP.Names = true
    ESP:Toggle(true)
    ESP:AddObjectListener(Workspace.ores, { -- Object Path, For example: Workspace.ThisFolder
        Name = "Sulfur", --Object name inside of the path, for example: Workspace.ThisFolder.Item_1
        CustomName = "Sulfur", -- Name you want to be displayed
        Color = Color3.fromRGB(0, 200, 150), -- Color
        IsEnabled = "whatever" -- Any name, has to be the same as the last line: ESP.TheNameYouWant
    })
    ESP.whatever = true
    end)

    Rost:NewButton("Камень", "", function()
    local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/SpleIII/Roblox-Scripts/refs/heads/main/Rost-Alpha/Esp.lua"))()
    ESP.Players = false
    ESP.Boxes = false
    ESP.Names = true
    ESP:Toggle(true)
    ESP:AddObjectListener(Workspace.ores, { -- Object Path, For example: Workspace.ThisFolder
        Name = "stone", --Object name inside of the path, for example: Workspace.ThisFolder.Item_1
        CustomName = "stone", -- Name you want to be displayed
        Color = Color3.fromRGB(0, 200, 150), -- Color
        IsEnabled = "whatever" -- Any name, has to be the same as the last line: ESP.TheNameYouWant
    })
    ESP.whatever = true
    end)

    Rost:NewButton("Железная руда", "", function()
    local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/SpleIII/Roblox-Scripts/refs/heads/main/Rost-Alpha/Esp.lua"))()
    ESP.Players = false
    ESP.Boxes = false
    ESP.Names = true
    ESP:Toggle(true)
    ESP:AddObjectListener(Workspace.ores, { -- Object Path, For example: Workspace.ThisFolder
        Name = "iron", --Object name inside of the path, for example: Workspace.ThisFolder.Item_1
        CustomName = "iron", -- Name you want to be displayed
        Color = Color3.fromRGB(0, 200, 150), -- Color
        IsEnabled = "whatever" -- Any name, has to be the same as the last line: ESP.TheNameYouWant
    })
    ESP.whatever = true
    end)

    Rost:NewButton("Военный ящик (Может вызвать лаги)", "", function()
    loadstring(game:HttpGet('https://pastebin.com/raw/txZYECdu'))()
    end)

    Rost:NewButton("loot crate (Может вызвать лаги)", "", function()
    loadstring(game:HttpGet('https://pastebin.com/raw/U12AvQcB'))()
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

    -- Скрипт для 🎃 +1 Stat Point Every Click 👻
    
    local OneStatPointEveryClick = OneStatPointEveryClick:NewSection("🎃 +1 Stat Point Every Click 👻")

    local rebith = false

    local farmwins = false

    task.spawn(function()
        while true do
            if rebith then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28.096077, 1, 423.349548, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                task.wait(0.25)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0.0960712433, 3.7575314, -18.5569649, 1, -1.02093793e-07, 5.27248926e-13, 1.02093793e-07, 1, -1.50088528e-08, -5.25716623e-13, 1.50088528e-08, 1)
            else
                task.wait(0.1)
            end
        end
    end)

    task.spawn(function()
        while true do
            if farmwins then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-70.7499847, 15.75, 335.75, -1, 0, 0, 0, 1, 0, 0, 0, -1)
                task.wait(0.05)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-151.500031, 0.49999994, 367.747986, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                task.wait(0.05)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(144.000015, 0.5, 352.25, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                task.wait(0.05)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0.0960712433, 3.7575314, -18.5569649, 1, -1.02093793e-07, 5.27248926e-13, 1.02093793e-07, 1, -1.50088528e-08, -5.25716623e-13, 1.50088528e-08, 1)
            else
                task.wait(0.1)
            end
        end
    end)

    OneStatPointEveryClick:NewToggle("Авто-ребитх", "Включить/выключить аимбот (H)", function(state)
        if state then
            rebith = true
            getgenv().AddNotification = function(title, text) game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) end
            AddNotification('Авто-ребитх: ', 'Включен')
        else
            rebith = false
            getgenv().AddNotification = function(title, text) game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) end
            AddNotification('Авто-ребитх: ', 'Выключен')
        end
    end)

    OneStatPointEveryClick:NewToggle("Авто-фарм побед", "Включить/выключить аимбот (H)", function(state)
        if state then
            farmwins = true
            getgenv().AddNotification = function(title, text) game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) end
            AddNotification('Авто-фарм побед: ', 'Включен')
        else
            farmwins = false
            getgenv().AddNotification = function(title, text) game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) end
            AddNotification('Авто-фарм побед: ', 'Выключен')
        end
    end)

    -- Скрипты для кликер игр

    local Clicker = Clicker:NewSection("Кликер игры")

    -- ПЕРЕМЕННЫЕ ДЛЯ АВТО-КЛИКЕРА
    local autoClicking = false
    local clickSpeed = 0.1
    local toggleKey = Enum.KeyCode.F
    local UserInputService = game:GetService("UserInputService")
    local VirtualInputManager = game:GetService("VirtualInputManager")

    -- ФУНКЦИЯ АВТО-КЛИКЕРА
    task.spawn(function()
        while true do
            if autoClicking then
                local mouseLocation = UserInputService:GetMouseLocation()
                VirtualInputManager:SendMouseButtonEvent(mouseLocation.X, mouseLocation.Y, 0, true, game, 0)
                task.wait()
                VirtualInputManager:SendMouseButtonEvent(mouseLocation.X, mouseLocation.Y, 0, false, game, 0)
                task.wait(clickSpeed)
            else
                task.wait(0.1)
            end
        end
    end)

    Clicker:NewToggle("Включить авто-кликер", "Автоматически кликает", function(state)
        autoClicking = state
        getgenv().AddNotification = function(title, text) game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) end
        AddNotification('Авто-кликер: ', '' .. (state and "Включен" or "Выключен"))
    end)

    Clicker:NewTextBox("Скорость кликов (сек)", "Установите скорость кликов в секундах", function(txt)
        local speed = tonumber(txt)
        if speed and speed > 0 then
            clickSpeed = speed
            getgenv().AddNotification = function(title, text) game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) end
            AddNotification('Авто-Кликер', 'Скорость кликов установлена: ' .. speed .. ' секунд')
        else
            AddNotification('Авто-Кликер', 'Неверная скорость')
        end
    end)  

    Clicker:NewKeybind("Клавиша переключения", "Клавиша для включения/выключения авто-кликера", Enum.KeyCode.F, function()
    end)

    -- Настройки мира

    local WorldSection = World:NewSection("Настройки мира")

    -- Переменные для времени
    local lighting = game:GetService("Lighting")
    local originalClockTime = lighting.ClockTime
    local timeEnabled = false
    local customTime = 12 -- Полдень по умолчанию
    local timeLoop = nil

    -- Функция для уведомлений
    local function showNotification(title, text)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = 3
        })
    end

    -- Функция остановки цикла
    local function stopTimeLoop()
        if timeLoop then
            timeLoop:Disconnect()
            timeLoop = nil
        end
    end

    -- Функция запуска цикла
    local function startTimeLoop()
        stopTimeLoop() -- Останавливаем старый цикл если был
        timeLoop = game:GetService("RunService").RenderStepped:Connect(function()
            if timeEnabled then
                lighting.ClockTime = customTime
            end
        end)
    end

    -- Переключатель изменения времени
    WorldSection:NewToggle("Изменить время", "Включить/выключить настройку игрового времени (с защитой от сброса)", function(state)
        timeEnabled = state
        if state then
            startTimeLoop()
        else
            stopTimeLoop()
            lighting.ClockTime = originalClockTime
            showNotification("Мир", "Время восстановлено")
        end
    end)

    -- Слайдер для выбора времени
    WorldSection:NewSlider("Время суток", "Выберите час (0-24)", 24, 0, function(hour)
        customTime = hour
        if timeEnabled then
        end
    end, 12) -- 12 значение по умолчанию (полдень)

    -- Кнопка для сброса времени
    WorldSection:NewButton("Сбросить время", "Вернуть оригинальное время и отключить защиту", function()
        timeEnabled = false
        stopTimeLoop()
        lighting.ClockTime = originalClockTime
        showNotification("Мир", "Время сброшено")
    end)

    -- Прочие скрипты

    -- Зум (Добавлено)
    local Zoom = Misc:NewSection("Зум")
    
    -- Переменные для зума
    local zoomEnabled = false
    local UserInputService = game:GetService("UserInputService")
    local camera = workspace.CurrentCamera
    
    -- Отслеживание нажатий клавиш
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if not zoomEnabled then return end
        
        if input.KeyCode == Enum.KeyCode.Z then
            camera.FieldOfView = 20
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if not zoomEnabled then return end
        
        if input.KeyCode == Enum.KeyCode.Z then
            camera.FieldOfView = 70
        end
    end)
    
    -- Функция для уведомлений
    local function showNotification(title, text)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = 3
        })
    end
    
    -- Простой переключатель зума
    Zoom:NewToggle("Включить зум", "Вкл/Выкл функцию зума", function(state)
        zoomEnabled = state
        if not state then
            camera.FieldOfView = 70
        end
        showNotification("Зум", state and "Включен" or "Выключен")
    end)

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


    -- Настройки
    local Settings = Settings:NewSection("Настройки скрипта")
    Settings:NewKeybind("Переключатель UI", "Переключает видимочть UI", Enum.KeyCode.RightShift, function()
        Library:ToggleUI()
    end)
    Settings:NewButton("Перезайти в режим (Шанс вылета)", " ", function()
        local sound = Instance.new("Sound", game.Workspace)
    sound.Volume = 1
    sound.SoundId = "rbxassetid://123821894082707" 
    sound.Looped = false
    sound:Play()
    wait(0.75)
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
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

    -- Скример
    local Screamer = Screamer:NewSection("Т̷̞͎͠Е̶̗̄Б̸͎̂̌Е̷̱̾ͅ ̴̞̬̇Н̵̩̱̓̉Е̷̡̲̉͘ ̷̬͆С̷̙̮̑Т̷̯͒̋О̴̩̊̑И̸͍̼̏̚Л̵̧̂О̷̧̣̃ ̴̫͌̿З̶̪͕̓̚А̵̙͆Х̷̣̑О̵͑̔͜Д̴̭̫̚И̸́͜Т̶̜̰̀͝Ь̴̰̯̀ ̶͔̙̚С̸̼̤̽Ю̷̲̽Д̷͍̑А̸̘̣̂͘")
    Screamer:NewButton("Н̷̰̓͝Е̸̮́̌ ̷̪̺̎̊Н̸̦̣́́Ӓ̸̯̀Ж̸̮̀̑И̸̩̂̈М̴͓̅͋А̷͍͎̊̕Й̵̺̄", "", function()
        Library:ToggleUI()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SpleIII/Roblox-Scripts/refs/heads/main/SpleIII-do-not-use-this-script."))()
    end)
