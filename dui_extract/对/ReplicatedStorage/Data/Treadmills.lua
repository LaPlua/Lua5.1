-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.Treadmills
-- ============================================

-- bytecode
-- Original size: 2170 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 42, Protos: 7, Main proto: 6

-- ============== SOURCE ==============
-- main chunk (proto[6], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
local AngelicTreadmill = {}
local AngelicTreadmill_2 = require(script.Configs.AngelicTreadmill)
AngelicTreadmill.AngelicTreadmill = AngelicTreadmill_2
local AstralTreadmill = require(script.Configs.AstralTreadmill)
AngelicTreadmill.AstralTreadmill = AstralTreadmill
local CelebrityTreadmill = require(script.Configs.CelebrityTreadmill)
AngelicTreadmill.CelebrityTreadmill = CelebrityTreadmill
local DemonicTreadmill = require(script.Configs.DemonicTreadmill)
AngelicTreadmill.DemonicTreadmill = DemonicTreadmill
local FlameTreadmill = require(script.Configs.FlameTreadmill)
AngelicTreadmill.FlameTreadmill = FlameTreadmill
local GoldenTreadmill = require(script.Configs.GoldenTreadmill)
AngelicTreadmill.GoldenTreadmill = GoldenTreadmill
local HackerTreadmill = require(script.Configs.HackerTreadmill)
AngelicTreadmill.HackerTreadmill = HackerTreadmill
AngelicTreadmill["Lucky BlockTreadmill"] = (require(script.Configs["Lucky BlockTreadmill"]))
AngelicTreadmill["Sci-FiTreadmill"] = (require(script.Configs["Sci-FiTreadmill"]))
AngelicTreadmill["The FreezeTreadmill"] = (require(script.Configs["The FreezeTreadmill"]))
local Treadmill = require(script.Configs.Treadmill)
AngelicTreadmill.Treadmill = Treadmill
table.freeze(AngelicTreadmill)
local s1 = {}
local s2 = {}
for _k9, _v10 in pairs(AngelicTreadmill) do
	table.insert(s1, _v10)
end
table.sort(s1, function(v1, v2)
	local f1 = not (v1.Price >= v2.Price)
	return f1
end)
for _k9, _v10 in ipairs(s1) do
	s2[_v10._id] = _k9
end
local ReplicatedStorage_2 = game:GetService("ReplicatedStorage")
local BalanceConfig = require(ReplicatedStorage_2.Shared.Flags.BalanceConfig)
local Price = { Price = true, SpeedMultiplier = true }
AngelicTreadmill = BalanceConfig.Bind("Game.Balance.Treadmills", AngelicTreadmill, Price, true, function(v3)
	local f2
	for _k4, _v5 in ipairs(v3) do
		f2 = not (0 >= _v5.SpeedMultiplier)
		assert(f2)
	end
end)
for _k9, _v10 in ipairs(s1) do
	s1[_k9] = AngelicTreadmill[_v10._id]
end
table.freeze(s1)
table.freeze(s2)
ReplicatedStorage = AngelicTreadmill
local function TreadmillNameExists(v4) -- proto[2], line 73  -- upvalues: ReplicatedStorage
	if ReplicatedStorage[v4] ~= nil then return true end
	return false, (("Treadmills name \"%*\" does not exist in the Treadmills directory."):format(v4))
end
local function GetOrdered() -- proto[3], line 81  -- upvalues: s1
	return table.clone(s1)
end
local function GetByUpgradeLevel(v5) -- proto[4], line 85  -- upvalues: s1
	return s1[v5]
end
local function GetUpgradeLevel(v6) -- proto[5], line 89  -- upvalues: s2
	return s2[v6]
end
local Directory = { Directory = AngelicTreadmill, TreadmillNameExists = TreadmillNameExists, GetOrdered = GetOrdered, GetByUpgradeLevel = GetByUpgradeLevel, GetUpgradeLevel = GetUpgradeLevel }
return table.freeze(Directory)