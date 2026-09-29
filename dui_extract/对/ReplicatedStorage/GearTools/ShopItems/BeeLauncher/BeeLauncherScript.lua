-- ============================================
-- ClassName: LocalScript
-- FullName: ReplicatedStorage.GearTools.ShopItems.BeeLauncher.BeeLauncherScript
-- ============================================

-- bytecode
-- Original size: 2887 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 44, Protos: 8, Main proto: 7

-- ============== SOURCE ==============
-- main chunk (proto[7], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local r1 = Players.LocalPlayer:GetMouse()
local BeeLauncherRemote = script.Parent:WaitForChild("BeeLauncherRemote")
local s1 = {}
local function removePlayerHighlights(v1) -- proto[0], line 21  -- upvalues: s1
	if not s1[v1] then return end
	for _k4, _v5 in pairs do
		if not _v5 then continue end
		if not _v5.Parent then continue end
	end
	s1[v1] = nil
end
local function addPlayerHighlights(v2) -- proto[1], line 32  -- upvalues: removePlayerHighlights, s1
	if not (v2.Character) then return end
	local _r2 = {}
	local w1 = v2.Character
	Instance.new.OutlineColor = Color3.new
	Instance.new.Parent = w1
	table.insert(_r2, Instance.new)
	s1[v2] = _r2
end
local connection = nil
local function onUnequipped() -- proto[2], line 50  -- upvalues: connection, s1
	if connection then
		connection = nil
	end
	for _k3, _v4 in pairs do
		for _k8, _v9 in pairs do
			if not _v9 then continue end
			if not _v9.Parent then continue end
		end
	end
	s1 = {}
end
local LocalPlayer = Players.LocalPlayer
local function onEquipped() -- proto[4], line 66  -- upvalues: connection, RunService, LocalPlayer, onUnequipped, Players, s1, addPlayerHighlights, removePlayerHighlights
	connection = RunService.Heartbeat.Connect
end
local tick = 0
local function onActivated() -- proto[5], line 103  -- upvalues: ToolGameplayGuard, Parent, LocalPlayer, tick, Players, BeeLauncherRemote
	if not (ToolGameplayGuard.AllowsLocalUse) then return end
	if not LocalPlayer.Character then return end
	if not (LocalPlayer.Character.PrimaryPart) then return end
	local w2 = (tick - tick)
	if w2 < 60 then return end
	for _k5, _v6 in pairs(Players:GetPlayers()) do
		if _v6 == LocalPlayer then continue end
		if not _v6.Character then continue end
		if not _v6.Character.PrimaryPart then continue end
		if (_v6.Character.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude > 30 then continue end
	end
end
script.Parent.Equipped:Connect(onEquipped)
script.Parent.Unequipped:Connect(onUnequipped)
script.Parent.Activated:Connect(onActivated)
Players.LocalPlayer.CharacterRemoving:Connect(function()
end)