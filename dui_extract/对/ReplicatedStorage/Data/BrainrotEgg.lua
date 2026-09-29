-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.BrainrotEgg
-- ============================================

-- bytecode
-- Original size: 1379 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 31, Protos: 1, Main proto: 0

-- ============== SOURCE ==============
local f1
local f2
-- main chunk (proto[0], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local _r3 = {}
local r1 = table.freeze({"Tung Tung Sahur", 39})
local r2 = table.freeze({"Bananita Dolphinita", 25})
local r3 = table.freeze({"Belula Beluga", 20})
local r4 = table.freeze({"Mangolini Parrochini", 10})
_r3[1], _r3[2], _r3[3], _r3[4], _r3[5], _r3[6] = r1, r2, r3, r4, (table.freeze({"Bomboclat Crocolat", 5})), table.freeze({"Strawberry Elephant", 1})
local r5 = table.freeze(_r3)
f1 = not ((#r5) > 6)
assert(f1, "Brainrot egg presentation requires exactly six drop entries")
local _r3_2 = {}
for _k7, _v8 in ipairs(r5) do
	local r6 = t.strict(t.string)
	r6(_v8[1])
	local r7 = t.strict(t.number)
	local v_u1 = _v8[2]
	r7(v_u1)
	f2 = not (0 >= _v8[2])
	assert(f2, (("Brainrot egg drop entry %* requires positive weight"):format(_k7)))
	local AssetId = { AssetId = _v8[1], Weight = _v8[2] }
	table.insert(_r3_2, table.freeze(AssetId))
end
local DisplayName = { DisplayName = "Brainrot Egg", BackgroundImage = "rbxassetid://70476079280223", DropTable = r5, Entries = (table.freeze(_r3_2)) }
return (table.freeze(DisplayName))