-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.LightVsDarkness
-- ============================================

-- bytecode
-- Original size: 5425 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 111, Protos: 13, Main proto: 12

-- ============== SOURCE ==============
local f2
local f3
local r1
-- main chunk (proto[12], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Assets = require(ReplicatedStorage.Data.Assets)
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local LightVsDarknessEventFlags = require(ReplicatedStorage.Shared.Flags.LightVsDarknessEventFlags)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Rings = ReplicatedStorage.Assets.Models:WaitForChild("Rings")
local World = Workspace:WaitForChild("World")
local Areas = World:WaitForChild("Areas")
local GuardAreas = Areas:WaitForChild("GuardAreas")
local RARITIES = {}
local Weight = { Id = "Normal", Weight = 53, Points = 10, Model = "NormalRing", Radius = 0, SpinSpeed = 2.4 }
RARITIES.RARITIES = {Weight, { Id = "Charged", Weight = 30, Points = 50, Model = "ChargedRing", Radius = 0, SpinSpeed = 2 }, { Id = "Secret", Weight = 12, Points = 250, Model = "SecretRing", Radius = 0, SpinSpeed = 1.7 }, { Id = "Rainbow", Weight = 3, Points = 1000, Model = "RainbowRing", Radius = 0, SpinSpeed = 1.4 }}
for _k14, _v15 in ipairs(RARITIES.RARITIES) do
	local child = Rings:FindFirstChild(_v15.Model)
	if child then
		child = child:IsA("BasePart")
	end
	local r2 = ("Rings.%* must be a BasePart"):format(_v15.Model)
	assert(child, r2)
	_v15.Radius = (child.Size.Y / 2)
end
local Frame = { Frame = "Milestone1", Rings = 100, Reward = "SpeedBoost15" }
local Frame_2 = { Frame = "Milestone2", Rings = 800, Reward = "TeamEgg", Mutation = "Silver", TeamEggCategories = { Light = "Jellyfish", Darkness = "Dark Gargoyle" } }
local Frame_3 = { Frame = "Milestone3", Rings = 1500, Reward = "Egg", EggCategory = "Ringlord" }
_r11[1], _r11[2], _r11[3] = Frame, Frame_2, Frame_3
RARITIES.MILESTONES = _r11
for _k14, _v15 in {} do
	if _v15.EggCategory ~= nil then
		f2 = not (Assets.Directory[_v15.EggCategory] == nil)
	end
	assert(f2, (("unknown milestone egg %*"):format(_v15.EggCategory)))
	for _k20, _v21 in {} do
		f3 = not (Assets.Directory[_v21] == nil)
		assert(f3, (("unknown milestone egg %*"):format(_v21)))
	end
	if _v15.Mutation ~= nil then
		r1 = Mutations.IsKnown(_v15.Mutation)
	end
	assert(r1, (("unknown milestone mutation %*"):format(_v15.Mutation)))
end
local s1 = RARITIES
function RARITIES.MilestoneEggCategory(v3, v4) -- proto[0], line 110  -- upvalues: s1
	if s1.MILESTONES[v3].TeamEggCategories == nil then return s1.MILESTONES[v3].EggCategory end
	if v4 == nil then return nil end
	return s1.MILESTONES[v3].TeamEggCategories[v4]
end
function RARITIES.MilestoneIcon(v5, v6) -- proto[1], line 120  -- upvalues: s1, Assets
	if s1.MILESTONES[v5].Reward.match then return "rbxassetid://78137530993637" end
	if s1.MilestoneEggCategory == nil then
		return nil
	end
	if Assets.Directory[s1.MilestoneEggCategory].Egg.Icon == "" then return Assets.BaseConfig.Egg.Icon end
	return Assets.Directory[s1.MilestoneEggCategory].Egg.Icon
end
function RARITIES.MilestoneQuantity(v7) -- proto[2], line 135  -- upvalues: s1, LightVsDarknessEventFlags
	if s1.MILESTONES[v7].Reward ~= "SpeedBoost" then return nil end
	return (("%* %*"):format((math.max((math.floor(((LightVsDarknessEventFlags.MilestoneSpeedBoostSeconds.Get / 60) + 0.5))), 1)), "mins"))
end
function RARITIES.MilestoneKey(v8) -- proto[3], line 145
	return (("Milestone%*"):format(v8))
end
function RARITIES.MilestoneAttribute(v9) -- proto[4], line 149  -- upvalues: s1
	return (("Lvd%*"):format(s1.MilestoneKey))
end
function RARITIES.Template(v10) -- proto[5], line 153  -- upvalues: Rings, s1
	assert((Rings.FindFirstChild).IsA, (("Ring template %* missing"):format(v10)))
	return Rings.FindFirstChild
end
local index = (0 + _v15.Weight)
function RARITIES.RollRarity(v11) -- proto[6], line 159  -- upvalues: index, s1
	local w1 = v11.NextNumber
	for _k5, _v6 in ipairs(s1.RARITIES) do
		if (w1 - _v6.Weight) <= 0 then return _k5 end
	end
	return (#s1.RARITIES)
end
local f4 = nil
function RARITIES.Zones() -- proto[8], line 171  -- upvalues: f4, GuardAreaGeometry, GuardAreas
	if f4 then return f4 end
	-- anon7 captures:
	f4 = GuardAreaGeometry.ReadAreaBounds
	return GuardAreaGeometry.ReadAreaBounds
end
function RARITIES.ZoneIndexAt(v12) -- proto[9], line 185  -- upvalues: s1, GuardAreaGeometry
	local v_u1
	for _k7, _v8 in ipairs(s1.Zones) do
		if GuardAreaGeometry.IsWithinFootprint then return _k7 end
		if (math.abs(_v8.Bounds.Position.X - v12.X)) >= inf then continue end
		v_u1 = _k7
	end
	return v_u1
end
function RARITIES.EncodeRings(v13) -- proto[10], line 202
	for _k6, _v7 in ipairs(v13) do
		buffer.writef32(buffer.create, 0, _v7.X)
		buffer.writef32(buffer.create, (0 + 4), _v7.Y)
		buffer.writef32(buffer.create, (0 + 8), _v7.Z)
		buffer.writeu8(buffer.create, (0 + 12), _v7.Rarity)
	end
	return buffer.create
end
function RARITIES.DecodeRings(v14) -- proto[11], line 215
	local v_u2
	local _r1 = {}
	for _i = 1, R2 do
		v_u2 = ((_i - 1) * 13) + 4
		v_u2 = ((_i - 1) * 13) + 8
		v_u2 = ((_i - 1) * 13) + 12
		local X = { X = (buffer.readf32(v14, ((_i - 1) * 13))), Y = (buffer.readf32(v14, v_u2)), Z = (buffer.readf32(v14, v_u2)), Rarity = (buffer.readu8(v14, v_u2)) }
		_r1[_i] = X
	end
	return _r1
end
return RARITIES