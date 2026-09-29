-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Util.ToolSession
-- ============================================

-- bytecode
-- Original size: 3006 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 46, Protos: 13, Main proto: 12

-- ============== SOURCE ==============
-- main chunk (proto[12], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolCooldown = require(ReplicatedStorage.Shared.Util.ToolCooldown)
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local Trove = require(ReplicatedStorage.Packages.Trove)
local GearNameOf = {}
local function accepted(v1, v2) -- proto[0], line 31
	local f1
	if not v2.IsA then return f1 end
	f1 = not (table.find == nil)
	return f1
end
local function loosen(v3) -- proto[1], line 36
	local grip = v3.grip
	if not grip then return end
end
local function stow(v4) -- proto[2], line 43
	v4.grip = nil
	v4.held = nil
end
local LocalPlayer = Players.LocalPlayer
local function wield(v5, v6) -- proto[5], line 55  -- upvalues: Trove, ToolCooldown, ToolGameplayGuard, LocalPlayer
	local grip = v5.grip
	v5.grip = Trove.new
	v5.held = v6
	grip = v5.grip
	if not grip then return end
	if v5.hooks.onActivated then
		grip:Add(v6.Activated:Connect(function()
			local onActivated = v5.hooks.onActivated
			if not onActivated then return end
			if not ToolGameplayGuard.AllowsLocalUse then return end
		end))
	end
	grip:Add(LocalPlayer.CharacterRemoving:Connect(function()
		local grip = v5.grip
		if not grip then return end
	end))
end
local function onGearChange(v7, v8, v9) -- proto[6], line 83
	if v8.IsA then
		if table.find == nil then return end
	end
end
function GearNameOf.GearNameOf(v10) -- proto[7], line 89
	if not v10 then return nil end
	return v10.GetAttribute
end
function GearNameOf.Follow(self, v11) -- proto[10], line 95  -- upvalues: wield, stow
	if not v11.FindFirstChildWhichIsA then return end
	if (v11.FindFirstChildWhichIsA).IsA then
		if table.find == nil then return end
	end
end
function GearNameOf.Shut(v14) -- proto[11], line 105
	local grip = v14.grip
	if not grip then return end
end
return GearNameOf