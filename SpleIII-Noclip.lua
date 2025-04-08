noclip = false
getgenv().AddNotification = function(title, text) game:GetService'StarterGui':SetCore("SendNotification", {Title = title; Text = text;}) end
game:GetService('RunService').Stepped:connect(function()
if noclip then
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
end
end)
AddNotification('Читы','Ноуклип - Включён')
plr = game.Players.LocalPlayer
mouse = plr:GetMouse()
mouse.KeyDown:connect(function(key)

if key == "n" then
noclip = not noclip
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
end
end)
AddNotification('Читы','Ноуклип - Выключен')
