-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.Currency
-- ============================================

-- bytecode
-- Original size: 2039 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 44, Protos: 5, Main proto: 4

-- ============== SOURCE ==============
-- main chunk (proto[4], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
local t = require(ReplicatedStorage.Packages.t)
local Single = {}
local Speed = { Speed = (t.array(t.number)), Volume = t.number }
local Ids = { Ids = (t.array(t.string)), Data = (t.interface(Speed)) }
Single.Single = (t.interface(Ids))
local DisplayName = { DisplayName = t.string, Rarity = (t.optional(t.table)), Desc = (t.optional(t.string)), Icon = (t.optional(t.string)), Sounds = (t.optional((t.interface(Single)))), CollectDistanceOverride = (t.optional(t.numberPositive)), PickupDistanceOverride = (t.optional(t.numberPositive)), _id = t.string }
local r1 = t.interface(DisplayName)
local function byName(v1, v2) -- proto[0], line 52
	local f1 = not (v1.Name >= v2.Name)
	return f1
end
ReplicatedStorage = r1
local function collectCurrencies(v3) -- proto[1], line 56  -- upvalues: byName, ReplicatedStorage
	local w1 = v3.GetChildren
	local _r2 = {}
	for _k6, _v7 in ipairs(w1) do
		if not _v7.IsA then continue end
		if not (ReplicatedStorage) then
			local r2 = ("currency config %* is malformed: %*"):format(_v7.Name, require)
		end
		if require._id ~= _v7.Name then
			local r3 = ("currency config %* declares _id \"%*\""):format(_v7.Name, require._id)
		end
		_r2[_v7.Name] = require
	end
	return table.freeze(_r2)
end
local r4 = collectCurrencies(script.Configs)
local function Get(v4) -- proto[2], line 85  -- upvalues: r4
	if r4[v4] ~= nil then return r4[v4] end
	local r2 = ("no currency is registered under \"%*\""):format(v4)
	return r4[v4]
end
local function CurrencyNameExists(v5) -- proto[3], line 93  -- upvalues: r4
	if r4[v5] ~= nil then return true end
	return false, (("no currency is registered under \"%*\""):format(v5))
end
local Directory = { Directory = r4, Get = Get, CurrencyNameExists = CurrencyNameExists }
return table.freeze(Directory)