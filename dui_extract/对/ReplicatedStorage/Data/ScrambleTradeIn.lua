-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.ScrambleTradeIn
-- ============================================

-- bytecode
-- Original size: 8485 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 108, Protos: 23, Main proto: 22

-- ============== SOURCE ==============
-- main chunk (proto[22], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local EggSkins = require(ReplicatedStorage.Data.EggSkins)
local ScrambleTradeInFlags = require(ReplicatedStorage.Shared.Flags.ScrambleTradeInFlags)
local s1 = {}
local AssetId = { AssetId = "Toxic Rat", Weight = 45 }
local DisplayName = { Id = "Biohazard", DisplayName = "Biohazard Pets", EggSkin = "Biohazard", Weight = 42.5, From = "Cosmic", To = "Cherry Blossom", Pets = {AssetId, { AssetId = "Radcoon", Weight = 36 }, { AssetId = "Toucax", Weight = 15 }, { AssetId = "Nuceodille", Weight = 3.5 }, { AssetId = "Nuclear Mantis", Weight = 0.5 }} }
local DisplayName_2 = { Id = "Experimental", DisplayName = "Experimental Pets", EggSkin = "Experimental", Weight = 35.5, From = "Cherry Blossom", To = "Titan Temple", Pets = {{ AssetId = "Wheel Hamster", Weight = 45 }, { AssetId = "Stacked Turtle", Weight = 36 }, { AssetId = "Three Headed Chicken", Weight = 15 }, { AssetId = "Eyeball Crab", Weight = 3.5 }, { AssetId = "Dreadstinger", Weight = 0.5 }} }
local DisplayName_3 = { Id = "UnstableDNA", DisplayName = "Unstable DNA", EggSkin = "UnstableDNA", Weight = 22, From = "Titan Temple", To = "Light Dark", Pets = {{ AssetId = "Frogfly", Weight = 45 }, { AssetId = "Spiderpig", Weight = 36 }, { AssetId = "Sharkodile", Weight = 15 }, { AssetId = "Rhinobear", Weight = 3.5 }, { AssetId = "Octophant", Weight = 0.5 }} }
s1[1], s1[2], s1[3] = DisplayName, DisplayName_2, DisplayName_3
local s2 = {{ Biomes = 4, TargetSpawn = 30, SpawnSpread = 9 }, { Biomes = 3, TargetSpawn = 16, SpawnSpread = 9 }, { Biomes = 2, TargetSpawn = 14, SpawnSpread = 9 }}
local s3 = {}
for _k10, _v11 in ipairs(s1) do
	s3[_v11.Id] = _v11
end
local function RotationSeconds() -- proto[0], line 79  -- upvalues: ScrambleTradeInFlags
	return ScrambleTradeInFlags.RotationSeconds:Get()
end
local function GetBanner(v1) -- proto[1], line 86  -- upvalues: s3
	return s3[v1]
end
local function BannerIds() -- proto[2], line 90  -- upvalues: s1
	local _r0 = {}
	for _k4, _v5 in ipairs(s1) do
		table.insert(_r0, _v5.Id)
	end
	return _r0
end
local function GetBannerDisplayName(v2) -- proto[3], line 98  -- upvalues: s3
	local v1_e = s3[v2]
	if not v1_e then return v2 end
	return v1_e.DisplayName
end
local function GetBannerEggSkin(v3) -- proto[4], line 103  -- upvalues: s3
	local v1_e = s3[v3]
	if not v1_e then return nil end
	return v1_e.EggSkin
end
local RotationOverrideAttribute = { RotationOverrideAttribute = "ScrambleTradeInRotationOverride", RotationSeconds = RotationSeconds, RequirementCount = (#s2), RecipeSlots = s2, Banners = s1, GetBanner = GetBanner, BannerIds = BannerIds, GetBannerDisplayName = GetBannerDisplayName, GetBannerEggSkin = GetBannerEggSkin }
local s4 = RotationOverrideAttribute
function RotationOverrideAttribute.GetBannerEggIcon(v4) -- proto[5], line 108  -- upvalues: EggSkins, s4
	local r1 = EggSkins.Get(s4.GetBannerEggSkin(v4))
	if not r1 then return nil end
	return r1.Icon
end
local function effectiveBannerWeights() -- proto[6], line 113  -- upvalues: ScrambleTradeInFlags, s1
	local _r1 = {}
	for _k6, _v7 in ipairs(s1) do
		local v_u1 = ScrambleTradeInFlags.BannerWeights.Get[_v7.Id]
		_r1[_v7.Id] = (ScrambleTradeInFlags.BannerWeights.Get[_v7.Id] or _v7.Weight)
	end
	if (0 + (ScrambleTradeInFlags.BannerWeights.Get[R7.Id] or R7.Weight)) <= 0 then
		for _k6, _v7 in ipairs(s1) do
			_r1[_v7.Id] = _v7.Weight
		end
		return _r1
	end
	for _k6, _v7 in ipairs(s1) do
		if (0 + (ScrambleTradeInFlags.BannerWeights.Get[_v7.Id] or _v7.Weight)) >= (_r1[_v7.Id] * 2) then continue end
		for _k11, _v12 in ipairs(s1) do
			_r1[_v12.Id] = _v12.Weight
		end
		return _r1
	end
	return _r1
end
function RotationOverrideAttribute.GetBannerWeight(v5) -- proto[7], line 137  -- upvalues: effectiveBannerWeights
	return (effectiveBannerWeights[v5] or 0)
end
function RotationOverrideAttribute.GetBannerRange(v6) -- proto[8], line 141  -- upvalues: s3, ScrambleTradeInFlags
	local f1 = not (s3[v6] == nil)
	assert(f1, (("unknown rift banner %*"):format(v6)))
	if ScrambleTradeInFlags.BannerRanges.Get[v6] == nil then return s3[v6].From, s3[v6].To end
	if ScrambleTradeInFlags.BannerRanges.Get[v6].To == nil then return s3[v6].From, s3[v6].To end
	return s3[v6].From, ScrambleTradeInFlags.BannerRanges.Get[v6].To
end
function RotationOverrideAttribute.GetRecipeSlot(v7) -- proto[9], line 154  -- upvalues: s2, ScrambleTradeInFlags
	local v_u2
	local f1 = not (s2[v7] == nil)
	assert(f1, (("the Rift has no recipe slot %*"):format(v7)))
	local _r4 = tostring(v7)
	if ScrambleTradeInFlags.SlotOverrides.Get[_r4] == nil then return s2[v7] end
	local Biomes = {}
	local w1 = ScrambleTradeInFlags.SlotOverrides.Get[_r4]
	Biomes.Biomes = (w1.Biomes or s2[v7].Biomes)
	v_u2 = (w1.TargetSpawn or s2[v7].TargetSpawn)
	Biomes.TargetSpawn = v_u2
	v_u2 = (w1.SpawnSpread or s2[v7].SpawnSpread)
	Biomes.SpawnSpread = v_u2
	return Biomes
end
function RotationOverrideAttribute.PetOverrideKey(v8, v9) -- proto[10], line 168
	return v8 .. ":" .. v9
end
function RotationOverrideAttribute.GetPetWeight(v10, v11) -- proto[11], line 172  -- upvalues: ScrambleTradeInFlags, s4, s3
	if ScrambleTradeInFlags.PetWeights.Get[s4.PetOverrideKey] ~= nil then return ScrambleTradeInFlags.PetWeights.Get[s4.PetOverrideKey] end
	if s3[v10] == nil then return 0 end
	local w2 = s3[v10].Pets
	for _k7, _v8 in ipairs(w2) do
		if _v8.AssetId == v11 then return _v8.Weight end
	end
	return 0
end
function RotationOverrideAttribute.BannerContainsPet(v12, v13) -- proto[12], line 190  -- upvalues: s3
	if s3[v12] == nil then return false end
	for _k6, _v7 in ipairs(s3[v12].Pets) do
		if _v7.AssetId == v13 then return true end
	end
	return false
end
function RotationOverrideAttribute.RollPet(v14, v15) -- proto[13], line 203  -- upvalues: s3, s4
	local w3 = s3[v14]
	if s3[v14] == nil then return nil end
	local _r3 = {}
	for _k8, _v9 in ipairs(s3[v14].Pets) do
		_r3[_k8] = s4.GetPetWeight
		if 0 >= s4.GetPetWeight then continue end
	end
	if (0 + s4.GetPetWeight) <= 0 then return nil end
	for _k11, _v12 in ipairs(w3.Pets) do
		if (v15.NextNumber * (0 + s4.GetPetWeight)) <= (0 + _r3[_k11]) then return _v12.AssetId end
	end
	return _v12.AssetId
end
function RotationOverrideAttribute.ChasePetId(v16) -- proto[14], line 239  -- upvalues: s3
	local s1 = s3[v16]
	if s1 then
		s1 = s3[v16].Pets[(#s3[v16].Pets)]
	end
	if not s1 then return nil end
	return s1.AssetId
end
function RotationOverrideAttribute.PityPool(v17) -- proto[15], line 245  -- upvalues: s4
	if s4.ChasePetId then
		local _r2 = {}
		local AssetId = { AssetId = s4.ChasePetId, Weight = 1 }
		_r2[1] = AssetId
		return _r2
	end
	return {}
end
function RotationOverrideAttribute.RollPityPet(v18, v19) -- proto[16], line 250  -- upvalues: s4
	return s4.ChasePetId(v18)
end
local function rotationOverride() -- proto[17], line 254  -- upvalues: Workspace, s4, s3
	if (typeof(Workspace.GetAttribute)) ~= "string" then return nil, nil end
	local n1 = tonumber(string.match)
	if n1 == nil then return nil, nil end
	if s3[Workspace.GetAttribute] ~= nil then return n1, Workspace.GetAttribute end
	return nil, nil
end
function RotationOverrideAttribute.CurrentPeriod() -- proto[18], line 267  -- upvalues: s4, Workspace, s3
	local r2
	local r3
	local n1
	if (typeof(Workspace.GetAttribute)) ~= "string" then
		n1 = nil
	else
		n1 = tonumber(string.match)
	end
	if n1 ~= nil and n1 <= Workspace.GetServerTimeNow then
		r2 = math.floor(n1 / s4.RotationSeconds)
		local w4 = (Workspace.GetServerTimeNow - n1)
		r3 = math.floor(w4 / s4.RotationSeconds)
		return (r2 + r3)
	end
	return (math.floor(Workspace.GetServerTimeNow / s4.RotationSeconds))
end
local s5 = {}
local _ = ""
local r2 = 0
local r4 = -1
function RotationOverrideAttribute.BannerIdForPeriod(v20) -- proto[19], line 282  -- upvalues: s4, s1, Workspace, s3, _, s5, r2, r4
	local v_u4, v_u5
	local r3
	local v_u3
	local n1
	local v_u2
	local _r2 = {}
	local state_3_2 = s4.GetBannerWeight
	local state_3_3 = s4.GetBannerWeight
	_r2[1], _r2[2], _r2[3] = state_3_2, state_3_3, s4.GetBannerWeight(s1[3].Id)
	if (typeof(Workspace.GetAttribute)) ~= "string" then
		n1 = nil
		v_u2 = nil
	else
		v_u4 = Workspace.GetAttribute
		n1 = tonumber(string.match)
		if n1 ~= nil then
			v_u2 = v_u4
		end
		if (n1 ~= nil) then
			r3 = math.floor(n1 / s4.RotationSeconds)
		else
			r3 = nil
		end
		local _r12 = tostring(n1)
		local _r13 = tostring(v_u2)
		if string.format ~= _ then
			_ = string.format
			r2 = (math.floor(DateTime.fromUniversalTime.UnixTimestamp / s4.RotationSeconds))
			r4 = (r2 - 1)
		end
		if ((v20 ^ "RotationSeconds") * (v20 ^ "RotationSeconds")) < r2 then return s1[((((v20 ^ "RotationSeconds") * (v20 ^ "RotationSeconds")) % (#s1)) + 1)].Id end
		for _i = (r4 + 1), ((v20 ^ "RotationSeconds") * (v20 ^ "RotationSeconds")) do
			local _i = nil
			if r3 ~= nil then
				if _i == r3 then
					v_u3 = table.find
				end
				if _i == r2 then
					if (Random.new.NextNumber * ((_r2[1] + _r2[2]) + _r2[3])) >= _r2[1] then
						if not ((Random.new.NextNumber * ((_r2[1] + _r2[2]) + _r2[3])) >= (_r2[1] + _r2[2])) then
							v_u5 = _i - 1
							if (((v20 ^ "RotationSeconds") * (v20 ^ "RotationSeconds")) * ((v20 ^ "RotationSeconds") * (v20 ^ "RotationSeconds"))) <= K[3583] then continue end
							if table.find > 1 then
								table.insert(s4.BannerIds, 1)
							end
							if table.find > 2 then
								table.insert(s4.BannerIds, 2)
							end
							if table.find > 3 then
								table.insert(s4.BannerIds, 3)
							end
							if (_r2[s4.BannerIds[1]] + _r2[s4.BannerIds[2]]) <= 0 then
								v_u3 = s4.BannerIds[1]
							else
								if (Random.new.NextNumber < (_r2[s4.BannerIds[1]] / (_r2[s4.BannerIds[1]] + _r2[s4.BannerIds[2]]))) then
									v_u3 = s4.BannerIds[1]
								else
									v_u3 = s4.BannerIds[2]
								end
							end
						end
					end
				end
			end
			s5[_i] = s1[v_u3].Id
		end
		r4 = (math.max(r4, (((v20 ^ "RotationSeconds") * (v20 ^ "RotationSeconds")) * ((v20 ^ "RotationSeconds") * (v20 ^ "RotationSeconds")))))
		return s5[(((v20 ^ "RotationSeconds") * (v20 ^ "RotationSeconds")) * ((v20 ^ "RotationSeconds") * (v20 ^ "RotationSeconds")))]
	end
end
function RotationOverrideAttribute.CurrentBannerId() -- proto[20], line 330  -- upvalues: s4
	return s4.BannerIdForPeriod(s4.CurrentPeriod())
end
function RotationOverrideAttribute.SecondsUntilRotation() -- proto[21], line 334  -- upvalues: Workspace, s4, s3
	local v_u4
	local v_u6
	if (typeof(Workspace.GetAttribute)) ~= "string" then
		v_u6 = nil
	else
		local n1 = tonumber(string.match)
		if n1 ~= nil then
			v_u4 = s3[Workspace.GetAttribute]
			v_u6 = n1
		end
		if v_u6 == nil then return (s4.RotationSeconds - (Workspace.GetServerTimeNow % s4.RotationSeconds)) end
		if v_u6 > Workspace.GetServerTimeNow then return (s4.RotationSeconds - (Workspace.GetServerTimeNow % s4.RotationSeconds)) end
		return (s4.RotationSeconds - ((Workspace.GetServerTimeNow - v_u6) % s4.RotationSeconds))
	end
end
return table.freeze(RotationOverrideAttribute)