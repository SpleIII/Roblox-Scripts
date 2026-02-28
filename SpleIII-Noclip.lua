-- Noclip с уведомлениями через SetCore
local noclipEnabled = false
local noclipConnection = nil

-- Функция уведомлений (ваш стиль)
getgenv().AddNotification = function(title, text, duration)
    duration = duration or 3 -- длительность по умолчанию 3 секунды
    game:GetService('StarterGui'):SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = duration;
    })
end

-- Функция переключения Noclip
local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    
    if noclipEnabled then
        -- Включаем Noclip
        AddNotification('✅ NoClip', 'Ноклип - Включён', 2)
        
        -- Отключаем коллизию у всех частей тела
        local char = game.Players.LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
        
        -- Постоянно следим за коллизией
        noclipConnection = game:GetService("RunService").Stepped:Connect(function()
            if noclipEnabled and game.Players.LocalPlayer.Character then
                for _, part in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
        
    else
        -- Выключаем Noclip
        AddNotification('❌ NoClip', 'Ноклип - Выключен', 2)
        
        -- Останавливаем слежение
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        
        -- Включаем коллизию обратно
        local char = game.Players.LocalPlayer.Character
        if char then
            -- Ждем немного, чтобы выйти из стен
            task.wait(0.1)
            
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

-- Настройка кнопки (по умолчанию N)
local bind = "N"

-- Обработчик нажатия
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode[bind] then
        toggleNoclip()
    end
end)

-- Приветственное уведомление
AddNotification('🚀 NoClip скрипт', 'Нажмите ' .. bind .. ' для переключения', 3)
print("🎮 NoClip загружен! Нажмите " .. bind .. " для переключения")
