-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Util.AssetOddsDisplay
-- ============================================

-- bytecode
-- Original size: 2694 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 47, Protos: 7, Main proto: 6

-- ============== SOURCE ==============
-- main chunk (proto[6], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local t = require(ReplicatedStorage.Packages.t)
local r1 = t.intersection((t.numberMinExclusive(-inf)), t.numberMaxExclusive(inf))
local r2 = t.strict(t.table)
local r3 = t.strict(r1)
local Resolve = {}
local function skeletonFor(v1) -- proto[0], line 33
	if v1 < 1000 then return "." end
	local r4 = math.floor(((math.log10(v1)) / 3))
	if (v1 / R2) < 10 then return ".##" end
	if (v1 / R2) >= 100 then return "." end
	return ".#"
end
local function compactOdds(v2) -- proto[1], line 46  -- upvalues: Simple
	local r5 = math.max(1, v2)
	local r4 = math.floor((math.log10(r5)))
	local w1 = ((math.floor(r5 / 1)) * 1)
	if w1 < 1000 then return string.lower(Simple.FormatCompact(w1, ".")) end
	local r6 = math.floor(((math.log10(w1)) / 3))
	if (w1 / R9) < 10 then return string.lower(Simple.FormatCompact(w1, ".")) end
	if (w1 / R9) >= 100 then return string.lower(Simple.FormatCompact(w1, ".")) end
	return string.lower(Simple.FormatCompact(w1, "."))
end
local table = r2
function Resolve.Resolve(v3, v4) -- proto[2], line 54  -- upvalues: table, Mutations
	local v_u1 = nil
	if (typeof(v3.VisualOdds)) == "number" then
		if 0 < v3.VisualOdds then
			v_u1 = v3.VisualOdds
		end
	end
	if (1 / v3.DropWeight) == nil then return (1 / v3.DropWeight) end
	if v4 == nil then return (1 / v3.DropWeight) end
	return ((1 / v3.DropWeight) * Mutations.RarityFactorFor)
end
local s1 = Resolve
function Resolve.Describe(v5, v6, v7) -- proto[3], line 75  -- upvalues: table, s1, Simple
	if s1.Resolve == nil then return "1/?" end
	local r5 = math.max(1, s1.Resolve)
	local r4 = math.floor((math.log10(r5)))
	local w1 = ((math.floor(r5 / 1)) * 1)
	if not ((w1 < 1000)) then
		local r6 = math.floor(((math.log10(w1)) / 3))
	end
	return (("%*%*"):format("1/", (string.lower(Simple.FormatCompact(w1, ".")))))
end
function Resolve.DescribeItem(v8, v9, v10) -- proto[4], line 90  -- upvalues: AssetItem, s1
	assert(AssetItem.AssetItemData(v9))
	local Mutations = {}
	Mutations.Mutations = v9.Mutations
	Mutations.BaseMutation = v9.BaseMutation
	return s1.Describe(v8, v10, Mutations)
end
ReplicatedStorage = r3
function Resolve.Compact(v11) -- proto[5], line 97  -- upvalues: ReplicatedStorage, compactOdds
	return compactOdds(v11)
end
return Resolve