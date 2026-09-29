-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.DragonEgg
-- ============================================

-- bytecode
-- Original size: 3245 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 49, Protos: 10, Main proto: 9

-- ============== SOURCE ==============
-- main chunk (proto[9], line 1)
local _r1 = {}
local _r2 = {"Baby Aurora Dragon", 85, -8.5}
local _r3 = {"Shadow Dragon", 13.5, 1.25}
_r1[1], _r1[2], _r1[3], _r1[4] = _r2, _r3, {"Ember Dragon", 1, 6.5}, {"Void Dragon", 0.5, 0.75}
local _r1_2 = {}
local _r2_2 = {"Baby Aurora Dragon", 45}
local _r3_2 = {"Shadow Dragon", 35}
_r1_2[1], _r1_2[2], _r1_2[3], _r1_2[4] = _r2_2, _r3_2, {"Ember Dragon", 15}, {"Void Dragon", 5}
local EggDisplayName = { EggDisplayName = "Dragon Egg", RewardEggDisplayName = "Dragon's Egg", MaxCountedReturns = 10, BaseAssetScale = 0.3, AssetScalePerReturn = 0.42, NestBaseScale = 0.3, NestScalePerReturn = 0.42, DropTable = _r1, RestoreDropTable = _r1_2, RewardCategory = "ScorchedDragon", CarryCategory = "Baby Aurora Dragon" }
local s1 = EggDisplayName
function EggDisplayName.GetCountedReturns(v1) -- proto[0], line 37  -- upvalues: s1
	return (math.clamp((math.floor(v1)), 0, s1.MaxCountedReturns))
end
function EggDisplayName.GetEntryWeight(v2, v3) -- proto[1], line 41  -- upvalues: s1
	return (math.max((v2[2] + (v2[3] * s1.GetCountedReturns)), 0))
end
function EggDisplayName.GetTotalWeight(v4) -- proto[2], line 48  -- upvalues: s1
	for _k5, _v6 in ipairs(s1.DropTable) do
	end
	return (0 + s1.GetEntryWeight)
end
function EggDisplayName.RollRestore() -- proto[3], line 63  -- upvalues: s1
	for _k5, _v6 in ipairs(s1.RestoreDropTable) do
	end
	for _k7, _v8 in ipairs(s1.DropTable) do
		if (Random.new.NextNumber * (0 + _v6[2])) <= (0 + _v8[2]) then return _v8[1] end
	end
	local r1 = ("[%*] Roll out of bounds exception"):format(script.Name)
end
function EggDisplayName.Roll(v5, v6) -- proto[4], line 85  -- upvalues: s1
	local f1 = not (0 >= (#s1.DropTable))
	assert(f1, "DragonEgg.DropTable is empty")
	if s1.GetTotalWeight <= 0 then return s1.DropTable[1][1] end
	for _k9, _v10 in ipairs(s1.DropTable) do
		if (Random.new.NextNumber * s1.GetTotalWeight) <= (0 + s1.GetEntryWeight) then return _v10[1] end
	end
	return s1.DropTable[(#s1.DropTable)][1]
end
function EggDisplayName.GetAssetScale(v7) -- proto[5], line 109  -- upvalues: s1
	return (s1.BaseAssetScale + (s1.AssetScalePerReturn * s1.GetCountedReturns))
end
function EggDisplayName.GetNestVisualScale(v8) -- proto[6], line 114  -- upvalues: s1
	return (s1.NestBaseScale + (s1.NestScalePerReturn * s1.GetCountedReturns))
end
function EggDisplayName.IsEventCategory(v9) -- proto[7], line 119  -- upvalues: s1
	if v9 == nil then return false end
	if v9 == s1.RewardCategory then return true end
	for _k4, _v5 in ipairs(s1.DropTable) do
		if _v5[1] == v9 then return true end
	end
	return false
end
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BalanceConfig = require(ReplicatedStorage.Shared.Flags.BalanceConfig)
local MaxCountedReturns = { MaxCountedReturns = true, BaseAssetScale = true, AssetScalePerReturn = true, DropTable = true, RestoreDropTable = true }
EggDisplayName = BalanceConfig.Bind("Game.Balance.DragonEgg", EggDisplayName, MaxCountedReturns, false, function(v10)
	local f2
	if (v10.MaxCountedReturns % 1) <= 0 then
		f2 = not (0 >= v10.BaseAssetScale)
	end
	assert(f2)
end)
return EggDisplayName