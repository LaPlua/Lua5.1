-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.AdminAbuseEgg
-- ============================================

-- bytecode
-- Original size: 1236 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 20, Protos: 5, Main proto: 4

-- ============== SOURCE ==============
-- main chunk (proto[4], line 1)
local _r1 = {}
_r1[1] = {"Demon Imp", 42}
local EggDisplayName = { EggDisplayName = "Demonic Egg", DropTable = _r1 }
local s1 = EggDisplayName
function EggDisplayName.IsEventCategory(v1) -- proto[0], line 12  -- upvalues: s1
	if v1 == nil then return false end
	for _k4, _v5 in ipairs(s1.DropTable) do
		if _v5[1] == v1 then return true end
	end
	return false
end
function EggDisplayName.GetTotalWeight() -- proto[1], line 26  -- upvalues: s1
	for _k4, _v5 in ipairs(s1.DropTable) do
	end
	return (0 + _v5[2])
end
function EggDisplayName.Roll(v2) -- proto[2], line 36  -- upvalues: s1
	if s1.GetTotalWeight <= 0 then return s1.DropTable[1][1] end
	for _k8, _v9 in ipairs(s1.DropTable) do
		if (Random.new.NextNumber * s1.GetTotalWeight) <= (0 + _v9[2]) then return _v9[1] end
	end
	return s1.DropTable[(#s1.DropTable)][1]
end
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BalanceConfig = require(ReplicatedStorage.Shared.Flags.BalanceConfig)
local DropTable = { DropTable = true }
EggDisplayName = BalanceConfig.Bind("Game.Balance.AdminAbuseEgg", EggDisplayName, DropTable, false, function(v3)
	local f1
	for _k5, _v6 in ipairs(v3.DropTable) do
	end
	f1 = not (0 >= (0 + _v6[2]))
	assert(f1)
end)
return EggDisplayName