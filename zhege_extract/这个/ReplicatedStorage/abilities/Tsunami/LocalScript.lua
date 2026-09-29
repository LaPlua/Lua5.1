-- ============================================
-- ClassName: LocalScript
-- FullName: ReplicatedStorage.abilities.Tsunami.LocalScript
-- ============================================

-- bytecode
-- Original size: 1092 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 28, Protos: 2, Main proto: 1

-- ============== SOURCE ==============
-- main chunk (proto[1], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local modules = ReplicatedStorage:WaitForChild("modules")
local animationCache = require(modules:WaitForChild("animationCache"))
local spellAnim = script.Parent:WaitForChild("spellAnim")
local localEvent = script.Parent:WaitForChild("localEvent")
local Parent = script.Parent
local LocalPlayer = game.Players.LocalPlayer
local f1 = true
localEvent.Event:Connect(function()
	if Parent.cooldown.Value <= 0 and f1 and LocalPlayer.Character.busyCasting.Value == false then
		LocalPlayer.Character.busyCasting.Value = true
		f1 = false
		f1 = true
	end
end)