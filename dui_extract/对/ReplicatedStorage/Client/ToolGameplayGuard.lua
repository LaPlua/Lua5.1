-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.ToolGameplayGuard
-- ============================================

-- bytecode
-- Original size: 3541 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 66, Protos: 9, Main proto: 8

-- ============== SOURCE ==============
-- main chunk (proto[8], line 1)
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Player = require(ReplicatedStorage.Shared.Player)
local PointInBox = require(ReplicatedStorage.Shared.Utils.PointInBox)
local r1 = Color3.fromRGB(255, 70, 70)
assert((Workspace.World:IsA("Folder")), "expected a Folder at Workspace.World")
assert((Workspace.World.Areas:IsA("Folder")), "expected a Folder at Workspace.World.Areas")
assert((Workspace.World.Areas.SeparationLine:IsA("BasePart")), "expected a BasePart at Workspace.World.Areas.SeparationLine")
local IsInsideArena = {}
local function footPosition(v1) -- proto[0], line 39  -- upvalues: Player
	if Player.FindRootPart == nil then return nil end
	if not Player.FindRootPart.IsA then return nil end
	return Player.FindRootPart.Position
end
local function isGear(v2) -- proto[1], line 46
	local f1
	if v2 == nil then return f1 end
	local attribute = typeof(v2:GetAttribute("GearName"))
	f1 = not (attribute ~= "string")
	return f1
end
local function isObbying(v3) -- proto[2], line 50  -- upvalues: Workspace
	local f2
	if not (Workspace.GetAttribute) then return false end
	if not (v3.Character.FindFirstChild) then return false end
	f2 = not (-268 >= v3.Character.FindFirstChild.Position.Z)
	return f2
end
local function refuse() -- proto[3], line 60  -- upvalues: Toast, r1
	local Color = { Color = r1, Text = "Cannot use items in the safe zone!", Seconds = 2, Unique = true }
end
function IsInsideArena.IsInsideArena(v4) -- proto[4], line 64  -- upvalues: Player, GuardAreaGeometry, SeparationLine
	local v_u1
	local Position
	if Player.FindRootPart ~= nil then
		if Player.FindRootPart.IsA then
			Position = Player.FindRootPart.Position
		end
		Position = nil
	end
	if Position == nil then return v_u1 end
	v_u1 = GuardAreaGeometry.IsPastLine
	return v_u1
end
local s1 = IsInsideArena
local LocalPlayer = Players.LocalPlayer
function IsInsideArena.IsLocalInsideArena() -- proto[5], line 69  -- upvalues: s1, LocalPlayer
	return s1.IsInsideArena(LocalPlayer)
end
Constants = Constants.TAGS_MAP.Gameplay.SAFE_ZONE
function IsInsideArena.IsInsideSafeZone(v5) -- proto[6], line 71  -- upvalues: Player, CollectionService, Constants, Workspace, PointInBox
	local w1
	local Position
	if Player.FindRootPart ~= nil then
		if Player.FindRootPart.IsA then
			Position = Player.FindRootPart.Position
		end
		Position = nil
	end
	local v_u2 = 1
	while true do
		if v_u2 > (#CollectionService.GetTagged) then break end
		w1 = CollectionService.GetTagged[v_u2]
		v_u2 = v_u2 + 1
		if not w1.IsDescendantOf then break end
		if PointInBox then return true end
	end
	return false
end
function IsInsideArena.AllowsLocalUse(v6) -- proto[7], line 90  -- upvalues: LocalPlayer, s1, Toast, r1, Workspace
	local Color
	local f3
	if LocalPlayer.GetAttribute then return true end
	if v6 ~= nil then
		local attribute = typeof(v6:GetAttribute("GearName"))
		f3 = not (attribute ~= "string")
	end
	if s1.IsInsideSafeZone then
		Color = { Color = r1, Text = "Cannot use items in the safe zone!", Seconds = 2, Unique = true }
	end
	if (Workspace.GetAttribute) then
		if (LocalPlayer.Character.FindFirstChild) then
			if -268 >= LocalPlayer.Character.FindFirstChild.Position.Z then return false end
			local Color_2 = { Color = r1, Text = "Cannot use items in the safe zone!", Seconds = 2, Unique = true }
			return false
		end
	end
end
return IsInsideArena