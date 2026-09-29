-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.LuminousEgg
-- ============================================

-- bytecode
-- Original size: 2081 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 40, Protos: 2, Main proto: 1

-- ============== SOURCE ==============
local f1
-- main chunk (proto[1], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local _r3 = {}
local r1 = table.freeze({"Spike", 39})
local r2 = table.freeze({"Manta Ray", 24})
local r3 = table.freeze({"Megalodon", 18})
local r4 = table.freeze({"Electric Eel", 11})
_r3[1], _r3[2], _r3[3], _r3[4], _r3[5], _r3[6] = r1, r2, r3, r4, (table.freeze({"Terra Snapper", 6.5})), table.freeze({"Cthulhu", 0.5})
local r5 = table.freeze(_r3)
local _r4 = {}
local r6 = table.freeze({"Depths Spike", 39})
local r7 = table.freeze({"Depths Manta Ray", 24})
local r8 = table.freeze({"Depths Megalodon", 18})
local r9 = table.freeze({"Depths Electric Eel", 11})
_r4[1], _r4[2], _r4[3], _r4[4], _r4[5], _r4[6] = r6, r7, r8, r9, (table.freeze({"Depths Terra Snapper", 6.5})), table.freeze({"Depths Cthulhu", 0.5})
local r10 = table.freeze(_r4)
f1 = not ((#r5) > 6)
assert(f1, "Luminous egg presentation requires exactly six drop entries")
f1 = not ((#r10) > 6)
assert(f1, "Luminous egg presentation requires exactly six mecha drop entries")
local function buildEntries(v1) -- proto[0], line 42  -- upvalues: t
	local f2
	local _r1 = {}
	for _k5, _v6 in ipairs do
		local v_u1 = _v6[2]
		f2 = not (0 >= _v6[2])
		assert(f2, (("Luminous egg drop entry %* requires positive weight"):format(_k5)))
		local AssetId = { AssetId = _v6[1], Weight = _v6[2] }
		table.insert(_r1, table.freeze(AssetId))
	end
	return table.freeze(_r1)
end
local DisplayName = { DisplayName = "Luminous Egg", BackgroundImage = "rbxassetid://108209625322017", DropTable = r5, Entries = (buildEntries(r5)), MechaEntries = (buildEntries(r10)) }
return (table.freeze(DisplayName))