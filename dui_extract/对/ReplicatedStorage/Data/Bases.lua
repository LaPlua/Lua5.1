-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.Bases
-- ============================================

-- bytecode
-- Original size: 6608 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 73, Protos: 7, Main proto: 6

-- ============== SOURCE ==============
local v1_e
local f1
local _r14
local f2
local ToUpdate
local PetArea
local _r13
-- main chunk (proto[6], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local t = require(ReplicatedStorage.Packages.t)
local _r5 = {1000, 1000000, 75000000, 500000000, 1000000000, 50000000000, 500000000000, 1000000000000, 25000000000000, 100000000000000, 500000000000000, 5000000000000000}
local function getBaseModelIfServer(v1) -- proto[0], line 43  -- upvalues: t, Constants, ServerStorage
	if not Constants.IS_SERVER then return nil end
	return ServerStorage.Assets.Models.Bases.Main[v1]
end
local s1 = {}
local r1 = t.strict(t.string)
r1("1")
if Constants.IS_SERVER then
	v1_e = ServerStorage.Assets.Models.Bases.Main["1"]
else
	v1_e = nil
end
local MaxAssets = { MaxAssets = 7, Model = v1_e, Cost = 0 }
s1[0] = MaxAssets
local MaxAssets_2 = { MaxAssets = 7, Model = nil, Cost = nil }
v1_e = t.strict
local r2 = v1_e(t.string)
r2("1")
r2 = Constants.IS_SERVER
if r2 then
	r2 = ServerStorage.Assets
	r2 = r2.Models
	r2 = r2.Bases
	r2 = r2.Main
	v1_e = r2["1"]
else
	v1_e = nil
end
MaxAssets_2.Model = v1_e
MaxAssets_2.Cost = _r5[1]
local MaxAssets_3 = { MaxAssets = 9, Model = nil, Cost = nil }
r2 = t.strict
local r3 = r2(t.string)
r3("2")
r3 = Constants.IS_SERVER
if r3 then
	r3 = ServerStorage.Assets
	r3 = r3.Models
	r3 = r3.Bases
	r3 = r3.Main
	v1_e = r3["2"]
else
	v1_e = nil
end
MaxAssets_3.Model = v1_e
MaxAssets_3.Cost = _r5[2]
local MaxAssets_4 = { MaxAssets = 10, Model = nil, Cost = nil }
r3 = t.strict
local r4 = r3(t.string)
r4("3")
r4 = Constants.IS_SERVER
if r4 then
	r4 = ServerStorage.Assets
	r4 = r4.Models
	r4 = r4.Bases
	r4 = r4.Main
	v1_e = r4["3"]
else
	v1_e = nil
end
MaxAssets_4.Model = v1_e
MaxAssets_4.Cost = _r5[3]
local MaxAssets_5 = { MaxAssets = 11, Model = nil, Cost = nil }
r4 = t.strict
local r5 = r4(t.string)
r5("4")
r5 = Constants.IS_SERVER
if r5 then
	r5 = ServerStorage.Assets
	r5 = r5.Models
	r5 = r5.Bases
	r5 = r5.Main
	v1_e = r5["4"]
else
	v1_e = nil
end
MaxAssets_5.Model = v1_e
MaxAssets_5.Cost = _r5[4]
local MaxAssets_6 = { MaxAssets = 12, Model = nil, Cost = nil }
r5 = t.strict
local r6 = r5(t.string)
r6("5")
r6 = Constants.IS_SERVER
if r6 then
	r6 = ServerStorage.Assets
	r6 = r6.Models
	r6 = r6.Bases
	r6 = r6.Main
	v1_e = r6["5"]
else
	v1_e = nil
end
MaxAssets_6.Model = v1_e
MaxAssets_6.Cost = _r5[5]
local MaxAssets_7 = { MaxAssets = 13, Model = nil, Cost = nil }
r6 = t.strict
local r7 = r6(t.string)
r7("6")
r7 = Constants.IS_SERVER
if r7 then
	r7 = ServerStorage.Assets
	r7 = r7.Models
	r7 = r7.Bases
	r7 = r7.Main
	v1_e = r7["6"]
else
	v1_e = nil
end
MaxAssets_7.Model = v1_e
MaxAssets_7.Cost = _r5[6]
local MaxAssets_8 = { MaxAssets = 14, Model = nil, Cost = nil }
r7 = t.strict
local r8 = r7(t.string)
r8("7")
r8 = Constants.IS_SERVER
if r8 then
	r8 = ServerStorage.Assets
	r8 = r8.Models
	r8 = r8.Bases
	r8 = r8.Main
	v1_e = r8["7"]
else
	v1_e = nil
end
MaxAssets_8.Model = v1_e
MaxAssets_8.Cost = _r5[7]
local MaxAssets_9 = { MaxAssets = 15, Model = nil, Cost = nil }
r8 = t.strict
local r9 = r8(t.string)
r9("8")
r9 = Constants.IS_SERVER
if r9 then
	r9 = ServerStorage.Assets
	r9 = r9.Models
	r9 = r9.Bases
	r9 = r9.Main
	v1_e = r9["8"]
else
	v1_e = nil
end
MaxAssets_9.Model = v1_e
MaxAssets_9.Cost = _r5[8]
local MaxAssets_10 = { MaxAssets = 16, Model = nil, Cost = nil }
r9 = t.strict
local r10 = r9(t.string)
r10("9")
r10 = Constants.IS_SERVER
if r10 then
	r10 = ServerStorage.Assets
	r10 = r10.Models
	r10 = r10.Bases
	r10 = r10.Main
	v1_e = r10["9"]
else
	v1_e = nil
end
MaxAssets_10.Model = v1_e
MaxAssets_10.Cost = _r5[9]
local MaxAssets_11 = { MaxAssets = 17, Model = nil, Cost = nil }
r10 = t.strict
local r11 = r10(t.string)
r11("10")
r11 = Constants.IS_SERVER
if r11 then
	r11 = ServerStorage.Assets
	r11 = r11.Models
	r11 = r11.Bases
	r11 = r11.Main
	v1_e = r11["10"]
else
	v1_e = nil
end
MaxAssets_11.Model = v1_e
MaxAssets_11.Cost = _r5[10]
local MaxAssets_12 = { MaxAssets = 18, Model = nil, Cost = nil }
r11 = t.strict
local r12 = r11(t.string)
r12("11")
r12 = Constants.IS_SERVER
if r12 then
	r12 = ServerStorage.Assets
	r12 = r12.Models
	r12 = r12.Bases
	r12 = r12.Main
	v1_e = r12["11"]
else
	v1_e = nil
end
MaxAssets_12.Model = v1_e
MaxAssets_12.Cost = _r5[11]
r12 = t.strict
local r13 = r12(t.string)
r13("12")
r13 = Constants.IS_SERVER
if r13 then
	r13 = ServerStorage.Assets
	r13 = r13.Models
	r13 = r13.Bases
	r13 = r13.Main
	v1_e = r13["12"]
else
	v1_e = nil
end
local MaxAssets_13 = { MaxAssets = 19, Model = v1_e, Cost = _r5[12] }
s1 = {}
local s2 = { BASES = s1, SKINS = s1 }
s2.MIN_ASSET_EQUIP_CAPACITY = s2.BASES[0].MaxAssets
r13 = s2.BASES
s2.MAX_ASSET_EQUIP_CAPACITY = s2.BASES[(#r13)].MaxAssets
function s2.GetMaxBaseLevel() -- proto[1], line 127  -- upvalues: s2
	local v_u1
	for _v4 in pairs do
		if 0 >= _k4 then continue end
		v_u1 = _k4
	end
	return v_u1
end
function s2.GetBaseConfigFor(v2, v3) -- proto[2], line 139  -- upvalues: t, s2
	local r14 = t.strict(t.optional(t.string))
	v2 = math.max(0, (math.floor(v2)))
	local r15 = nil
	for _v6 in pairs do
		if _k6 > v2 then continue end
		if r15 then
			if r15 >= _k6 then continue end
		end
		r15 = _k6
	end
	if r15 then
		if v3 then return s2.BASES[r15], s2.SKINS[v3] end
		if not r15 then return nil end
		return s2.BASES[r15]
	end
end
function s2.GetAssetEquipCapacity(v4) -- proto[3], line 166  -- upvalues: s2
	local v_u2
	if s2.GetBaseConfigFor then
		v_u2 = s2.GetBaseConfigFor.MaxAssets
		if v_u2 then return v_u2 end
	end
	v_u2 = s2.MIN_ASSET_EQUIP_CAPACITY
	return v_u2
end
if Constants.IS_STUDIO then
	v_u3 = s2.BASES
	local f3 = false  -- skip 1
	f3 = true
	assert(f3, "Not enough costs for the number of bases")
	for _k10, _v11 in pairs(s2.BASES) do
		if _v11.Cost ~= _r5[_k10] and _k10 <= 0 then
			f1 = not (_v11.Cost > 0)
		end
		local v_u4 = _k10
		assert(f1, (("Cost for base index %* does not match expected cost from COSTS table"):format(v_u4)))
		if Constants.IS_SERVER then
			if (typeof(_v11.Model)) == "Instance" then
				_r14 = _v11.Model:IsA("Model")
			end
			assert(_r14, (("Model for base index %* is not a valid Model instance"):format(_k10)))
			if _v11.Model.PrimaryPart then
				f2 = not (_v11.Model.PrimaryPart.Name ~= "CenterPoint")
			end
			assert(f2, (("Model for base index %* must have a PrimaryPart named \"CenterPoint\""):format(_k10)))
			ToUpdate = _v11.Model:FindFirstChild("ToUpdate")
			if ToUpdate and ToUpdate:IsA("Model") and ToUpdate.PrimaryPart and ToUpdate.PrimaryPart.Name == "CenterPoint" then
				PetArea = ToUpdate:FindFirstChild("PetArea")
			end
			assert(PetArea, (("Model for base index %* must have a child Model named \"ToUpdate\" with a PrimaryPart named \"CenterPoint\""):format(_k10)))
		end
		if (typeof(_v11.MaxAssets)) == "number" then
			f1 = not (_v11.MaxAssets ~= (s2.GetAssetEquipCapacity(_k10)))
		end
		assert(f1, (("MaxAssets for base index %* must match asset equip capacity"):format(_k10)))
	end
end
if Constants.IS_STUDIO then
	if Constants.IS_SERVER then
		for _k10, _v11 in pairs(s2.SKINS) do
			if (typeof(_v11.FirstFloor)) == "Instance" then
				_r13 = _v11.FirstFloor:IsA("Model")
			end
			assert(_r13, (("Model for base skin index %* is not a valid Model instance"):format(_k10)))
		end
	end
end
s1 = {}
for _k11, _v12 in ipairs(s2.BASES) do
	s1[_k11] = _v12.MaxAssets
end
local ReplicatedStorage_2 = game:GetService("ReplicatedStorage")
ReplicatedStorage_2 = ReplicatedStorage_2.Shared
ReplicatedStorage_2 = ReplicatedStorage_2.Flags
ReplicatedStorage_2 = ReplicatedStorage_2.BalanceConfig
local ReplicatedStorage_2_2 = require(ReplicatedStorage_2)
game = s2.BASES
local Cost = { Cost = true, MaxAssets = true }
s2.BASES = (ReplicatedStorage_2_2.Bind("Game.Balance.Bases", game, Cost, true, function(v5)
	local f4
	for _k4, _v5 in ipairs(v5) do
		if (_v5.MaxAssets % 1) <= 0 and 1 <= _v5.MaxAssets then
			f4 = false  -- skip 1
			f4 = true
		end
		assert(f4)
	end
end))
local function refreshCapacityLimits() -- proto[5], line 243  -- upvalues: s2
	s2.MIN_ASSET_EQUIP_CAPACITY = s2.BASES[0].MaxAssets
	s2.MAX_ASSET_EQUIP_CAPACITY = s2.BASES[s2.GetMaxBaseLevel].MaxAssets
end
game = s2.BASES
s2.MIN_ASSET_EQUIP_CAPACITY = game[0].MaxAssets
local w1 = game[0].MaxAssets
game = s2.BASES
w1 = game[(s2.GetMaxBaseLevel())]
w1 = w1.MaxAssets
s2.MAX_ASSET_EQUIP_CAPACITY = w1
game = (ReplicatedStorage * ReplicatedStorage).Shared
game = game.Flags
game = game.BalanceConfig
local game = require(game)
game = game.Changed
game:Connect(refreshCapacityLimits)
return s2