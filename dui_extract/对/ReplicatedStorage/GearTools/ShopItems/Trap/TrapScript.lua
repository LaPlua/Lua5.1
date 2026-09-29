-- ============================================
-- ClassName: LocalScript
-- FullName: ReplicatedStorage.GearTools.ShopItems.Trap.TrapScript
-- ============================================

-- bytecode
-- Original size: 1588 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 45, Protos: 2, Main proto: 1

-- ============== SOURCE ==============
-- main chunk (proto[1], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local Parent = script.Parent
local tick = 0
local LocalPlayer = Players.LocalPlayer
local function onActivated() -- proto[0], line 14  -- upvalues: ToolGameplayGuard, Parent, tick, LocalPlayer, Remotes
	local Position
	if not (ToolGameplayGuard.AllowsLocalUse) then return end
	local w1 = (tick - tick)
	if w1 < 1 then return end
	if not LocalPlayer.Character then return end
	if not (LocalPlayer.Character.PrimaryPart) then return end
	RaycastParams.new.FilterType = Enum.RaycastFilterType.Exclude
	RaycastParams.new.FilterDescendantsInstances = {LocalPlayer.Character}
	if workspace.Raycast then return end
	local r1 = Vector3.new((LocalPlayer.Character.PrimaryPart.Position + (LocalPlayer.Character.PrimaryPart.CFrame.LookVector * 4)).X, ((LocalPlayer.Character.PrimaryPart.Position + (LocalPlayer.Character.PrimaryPart.CFrame.LookVector * 4)).Y + 5), (LocalPlayer.Character.PrimaryPart.Position + (LocalPlayer.Character.PrimaryPart.CFrame.LookVector * 4)).Z)
	local v_u1 = nil
	if (workspace.Raycast) then
		Position = workspace.Raycast.Position
	else
		local w2 = (LocalPlayer.Character.PrimaryPart.Position + (LocalPlayer.Character.PrimaryPart.CFrame.LookVector * 4))
		v_u1 = w2
	end
	local r2 = typeof(Parent.GetAttribute)
end
script.Parent.Activated:Connect(onActivated)