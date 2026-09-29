-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.SamplePacks
-- ============================================

-- bytecode
-- Original size: 2292 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 40, Protos: 5, Main proto: 4

-- ============== SOURCE ==============
-- main chunk (proto[4], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local ScrambleRules = require(ReplicatedStorage.Shared.Util.ScrambleRules)
local s1 = {{ ProductId = 3713243987, EventId = "DrScrambleOutbreak", Amount = 100, Label = "Sample Pack 1" }, { ProductId = 3713244009, EventId = "DrScrambleOutbreak", Amount = 500, Label = "Sample Pack 2" }, { ProductId = 3713244032, EventId = "DrScrambleOutbreak", Amount = 1500, Label = "Sample Pack 3" }, { ProductId = 3714309175, EventId = "DrScrambleOutbreak", Amount = 3000, Label = "Sample Pack 4" }}
local function validateCatalog(v1) -- proto[0], line 42  -- upvalues: ScrambleRules
	local f1
	local v_u1
	local f2
	if (type(v1)) == "table" then
		f2 = false  -- skip 1
		f2 = true
	end
	assert(f2, "Scramble: invalid pack catalog")
	local _r1 = {}
	for _k5, _v6 in ipairs(v1 ^ "type") do
		f1 = not ((type(_v6)) ~= "table")
		assert(f1, "Scramble: invalid Sample pack")
		if ScrambleRules.Integer then
			v_u1 = _r1[_v6.ProductId]
		end
		local w1 = (not v_u1)
		assert(w1, "Scramble: invalid product ID")
		v_u1 = _v6.Amount
		assert(ScrambleRules.Integer, "Scramble: invalid Sample pack amount")
		if (type(_v6.EventId)) == "string" and 0 < (#_v6.EventId) then
			f1 = false  -- skip 1
			f1 = true
		end
		assert(f1, "Scramble: invalid pack event")
		if (type(_v6.Label)) == "string" then
			f1 = false  -- skip 1
			f1 = true
		end
		assert(f1, "Scramble: invalid pack label")
		_r1[_v6.ProductId] = true
	end
	return (v1 ^ "type")
end
ReplicatedStorage = (FastFlags.Replicated("Game.Scramble.SamplePacks", validateCatalog, s1))
local function Get() -- proto[1], line 77  -- upvalues: ReplicatedStorage, s1
	local _r0 = {}
	local _r1 = {}
	for _k5, _v6 in ipairs(ReplicatedStorage.Get) do
		table.insert(_r0, _v6)
		_r1[_v6.ProductId] = true
	end
	for _k5, _v6 in ipairs(s1) do
		local v_u2 = _v6.ProductId
		if _r1[v_u2] then continue end
		table.insert(_r0, _v6)
	end
	return _r0
end
local Offers = { Offers = s1, Get = Get }
local s2 = Offers
function Offers.Find(v2) -- proto[2], line 93  -- upvalues: s2
	for _k4, _v5 in ipairs(s2.Get) do
		if _v5.ProductId == v2 then return _v5 end
	end
	return nil
end
function Offers.getChangedSignal() -- proto[3], line 102  -- upvalues: ReplicatedStorage
	return ReplicatedStorage.Changed
end
return table.freeze(Offers)