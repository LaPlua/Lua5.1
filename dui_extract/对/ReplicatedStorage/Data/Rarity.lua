-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.Rarity
-- ============================================

-- bytecode
-- Original size: 2133 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 57, Protos: 5, Main proto: 4

-- ============== SOURCE ==============
-- main chunk (proto[4], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local s1 = {"BrainrotGod", "Common", "Cosmic", "Divine", "Epic", "Eternal", "Legendary", "LightDark", "Limited", "Mythic", "Rainbow", "Rare", "Secret", "SuperRare", "Titan", "Transcendent"}
s1[17] = "Uncommon"
local Prismatic = { Prismatic = "Rainbow" }
local _id = { _id = t.string, DisplayName = t.string, Rank = t.integer, Color = t.Color3, RarityGradient = (t.instanceIsA("UIGradient")), ItemTemplate = (t.instanceIsA("TextButton")) }
local r1 = t.interface(_id)
local function byName(v1, v2) -- proto[0], line 75
	local f1 = not (v1.Name >= v2.Name)
	return f1
end
ReplicatedStorage = r1
local s2 = Prismatic
local function loadTiers(v3) -- proto[1], line 79  -- upvalues: byName, ReplicatedStorage, s1, s2
	local v_u1
	local w1 = v3.GetChildren
	local _r2 = {}
	for _k6, _v7 in ipairs(w1) do
		if not _v7.IsA then continue end
		v_u1 = require
		if not (ReplicatedStorage) then
			local r2 = ("rarity config %* is malformed: %*"):format(_v7.Name, v_u1)
		end
		if require._id ~= _v7.Name then
			local r3 = ("rarity config %* declares _id \"%*\""):format(_v7.Name, require._id)
		end
		_r2[_v7.Name] = require
	end
	for _k6, _v7 in ipairs(s1) do
		if _r2[_v7] ~= nil then continue end
		local r4 = ("rarity tier \"%*\" has no config module"):format(_v7)
	end
	for _k6, _v7 in ipairs(s2) do
		_r2[_k6] = _r2[_v7]
	end
	return table.freeze(_r2)
end
local r5 = loadTiers(script.Configs)
local function Get(v4) -- proto[2], line 117  -- upvalues: r5
	if r5[v4] ~= nil then return r5[v4] end
	local r2 = ("\"%*\" is not a registered rarity tier"):format(v4)
	return r5[v4]
end
local function RarityNameExists(v5) -- proto[3], line 125  -- upvalues: r5
	if r5[v5] ~= nil then return true end
	return false, (("\"%*\" is not a registered rarity tier"):format(v5))
end
local Rarities = { Rarities = r5, Get = Get, RarityNameExists = RarityNameExists }
return table.freeze(Rarities)