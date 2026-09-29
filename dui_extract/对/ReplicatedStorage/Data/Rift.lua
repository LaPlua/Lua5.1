-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.Rift
-- ============================================

-- bytecode
-- Original size: 6574 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 97, Protos: 23, Main proto: 22

-- ============== SOURCE ==============
-- main chunk (proto[22], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local EggSkins = require(ReplicatedStorage.Data.EggSkins)
local RiftFlags = require(ReplicatedStorage.Shared.Flags.RiftFlags)
local s1 = {}
local AssetId = { AssetId = "Rift Eye", Weight = 45 }
local DisplayName = { Id = "Verdant", DisplayName = "Riftborn", EggSkin = "Riftborn", Weight = 55, From = "Volcano", To = "Abyss Ocean", Pets = {AssetId, { AssetId = "Voidmaw", Weight = 36 }, { AssetId = "Ventinal", Weight = 15 }, { AssetId = "Wendigo", Weight = 3.5 }, { AssetId = "World Eater", Weight = 0.5 }} }
local DisplayName_2 = { Id = "Umbral", DisplayName = "Riftbeasts", EggSkin = "Riftbeasts", Weight = 40, From = "Prehistoric", To = "Cosmic", Pets = {{ AssetId = "Void Angler", Weight = 45 }, { AssetId = "Riftwing", Weight = 36 }, { AssetId = "Dreadclaw", Weight = 15 }, { AssetId = "Mawbreaker", Weight = 3.5 }, { AssetId = "Void Serpent", Weight = 0.5 }} }
local DisplayName_3 = { Id = "Radiant", DisplayName = "Shattered Rift", EggSkin = "ShatteredRift", Weight = 5, From = "Cherry Blossom", To = "Titan Temple", Pets = {{ AssetId = "Shardling", Weight = 45 }, { AssetId = "Shattered Ram", Weight = 36 }, { AssetId = "Shardwing", Weight = 15 }, { AssetId = "Shattered Drake", Weight = 3.5 }, { AssetId = "Shattered Colossus", Weight = 0.5 }} }
s1[1], s1[2], s1[3] = DisplayName, DisplayName_2, DisplayName_3
local s2 = {{ Biomes = 4, TargetSpawn = 30, SpawnSpread = 9 }, { Biomes = 3, TargetSpawn = 16, SpawnSpread = 9 }, { Biomes = 2, TargetSpawn = 14, SpawnSpread = 9 }}
local s3 = {}
for _k10, _v11 in ipairs(s1) do
	s3[_v11.Id] = _v11
end
local RotationSeconds = {}
local function RotationSeconds() -- proto[0], line 93  -- upvalues: RiftFlags
	return RiftFlags.RotationSeconds:Get()
end
RotationSeconds.RotationSeconds = RotationSeconds
RotationSeconds.RequirementCount = (#s2)
RotationSeconds.RecipeSlots = s2
RotationSeconds.Banners = s1
function RotationSeconds.GetBanner(v3) -- proto[1], line 100  -- upvalues: s3
	return s3[v3]
end
function RotationSeconds.BannerIds() -- proto[2], line 104  -- upvalues: s1
	local _r0 = {}
	for _k4, _v5 in ipairs(s1) do
		table.insert(_r0, _v5.Id)
	end
	return _r0
end
function RotationSeconds.GetBannerDisplayName(v4) -- proto[3], line 112  -- upvalues: s3
	local v1_e = s3[v4]
	if not v1_e then return v4 end
	return v1_e.DisplayName
end
function RotationSeconds.GetBannerEggSkin(v5) -- proto[4], line 118  -- upvalues: s3
	local v1_e = s3[v5]
	if not v1_e then return nil end
	return v1_e.EggSkin
end
local s4 = RotationSeconds
function RotationSeconds.GetBannerEggIcon(v6) -- proto[5], line 123  -- upvalues: EggSkins, s4
	local r1 = EggSkins.Get(s4.GetBannerEggSkin(v6))
	if not r1 then return nil end
	return r1.Icon
end
function RotationSeconds.GetBannerWeight(v7) -- proto[6], line 130  -- upvalues: RiftFlags, s3
	if RiftFlags.BannerWeights.Get[v7] ~= nil then return RiftFlags.BannerWeights.Get[v7] end
	local v1_e = s3[v7]
	if not v1_e then return 0 end
	return v1_e.Weight
end
function RotationSeconds.GetBannerRange(v8) -- proto[7], line 140  -- upvalues: s3, RiftFlags
	local f2 = not (s3[v8] == nil)
	assert(f2, (("unknown rift banner %*"):format(v8)))
	if RiftFlags.BannerRanges.Get[v8] == nil then return s3[v8].From, s3[v8].To end
	if RiftFlags.BannerRanges.Get[v8].To == nil then return s3[v8].From, s3[v8].To end
	return s3[v8].From, RiftFlags.BannerRanges.Get[v8].To
end
function RotationSeconds.GetRecipeSlot(v9) -- proto[8], line 153  -- upvalues: s2, RiftFlags
	local v_u2
	local f2 = not (s2[v9] == nil)
	assert(f2, (("the Rift has no recipe slot %*"):format(v9)))
	local _r4 = tostring(v9)
	if RiftFlags.SlotOverrides.Get[_r4] == nil then return s2[v9] end
	local Biomes = {}
	local w1 = RiftFlags.SlotOverrides.Get[_r4]
	Biomes.Biomes = (w1.Biomes or s2[v9].Biomes)
	v_u2 = (w1.TargetSpawn or s2[v9].TargetSpawn)
	Biomes.TargetSpawn = v_u2
	v_u2 = (w1.SpawnSpread or s2[v9].SpawnSpread)
	Biomes.SpawnSpread = v_u2
	return Biomes
end
function RotationSeconds.PetOverrideKey(v10, v11) -- proto[9], line 167
	return v10 .. ":" .. v11
end
function RotationSeconds.GetPetWeight(v12, v13) -- proto[10], line 171  -- upvalues: RiftFlags, s4, s3
	if RiftFlags.PetWeights.Get[s4.PetOverrideKey] ~= nil then return RiftFlags.PetWeights.Get[s4.PetOverrideKey] end
	if s3[v12] == nil then return 0 end
	local w2 = s3[v12].Pets
	for _k7, _v8 in ipairs(w2) do
		if _v8.AssetId == v13 then return _v8.Weight end
	end
	return 0
end
function RotationSeconds.BannerContainsPet(v14, v15) -- proto[11], line 189  -- upvalues: s3
	if s3[v14] == nil then return false end
	for _k6, _v7 in ipairs(s3[v14].Pets) do
		if _v7.AssetId == v15 then return true end
	end
	return false
end
function RotationSeconds.RollPet(v16, v17) -- proto[12], line 202  -- upvalues: s3, s4
	local w3 = s3[v16]
	if s3[v16] == nil then return nil end
	local _r3 = {}
	for _k8, _v9 in ipairs(s3[v16].Pets) do
		_r3[_k8] = s4.GetPetWeight
		if 0 >= s4.GetPetWeight then continue end
	end
	if (0 + s4.GetPetWeight) <= 0 then return nil end
	for _k11, _v12 in ipairs(w3.Pets) do
		if (v17.NextNumber * (0 + s4.GetPetWeight)) <= (0 + _r3[_k11]) then return _v12.AssetId end
	end
	return _v12.AssetId
end
local function petsByWeight(v18) -- proto[14], line 239  -- upvalues: s3, s4
	if s3[v18] == nil then
		return {}
	end
	local _r2 = {}
	for _k6, _v7 in ipairs(s3[v18].Pets) do
		if 0 >= s4.GetPetWeight then continue end
		local AssetId = {}
		AssetId.AssetId = _v7.AssetId
		AssetId.Weight = s4.GetPetWeight
		table.insert(_r2, AssetId)
	end
	-- anon13 captures:
	return _r2
end
function RotationSeconds.ChasePetId(v19) -- proto[15], line 260  -- upvalues: petsByWeight
	local v2_e = petsByWeight[(#petsByWeight)]
	if not v2_e then return nil end
	return v2_e.AssetId
end
function RotationSeconds.PityPool(v20) -- proto[16], line 268  -- upvalues: petsByWeight, RiftFlags
	local r2 = math.min((#RiftFlags.PityWeights.Get), (#petsByWeight))
	local _r4 = {}
	for _i = 1, r2 do
		local AssetId = {}
		AssetId.AssetId = petsByWeight[(((#petsByWeight) - r2) + _i)].AssetId
		AssetId.Weight = RiftFlags.PityWeights.Get[_i]
		table.insert(_r4, AssetId)
	end
	return _r4
end
function RotationSeconds.RollPityPet(v21, v22) -- proto[17], line 280  -- upvalues: s4
	for _k7, _v8 in ipairs(s4.PityPool) do
		if 0 >= _v8.Weight then continue end
	end
	if (0 + _v8.Weight) <= 0 then return s4.ChasePetId(v21) end
	for _k10, _v11 in ipairs(s4.PityPool) do
		if v21 > K[722144333] then continue end
		if (v22.NextNumber * (0 + _v8.Weight)) <= (0 + _v11.Weight) then return _v11.AssetId end
	end
	return _v11.AssetId
end
function RotationSeconds.CurrentPeriod() -- proto[18], line 312  -- upvalues: Workspace, s4
	return (math.floor(Workspace.GetServerTimeNow / s4.RotationSeconds))
end
function RotationSeconds.BannerIdForPeriod(v23) -- proto[19], line 316  -- upvalues: s1, s4
	for _k5, _v6 in ipairs(s1) do
	end
	if (0 + s4.GetBannerWeight) <= 0 then return s1[1].Id end
	for _k7, _v8 in ipairs(s1) do
		if (Random.new.NextNumber * (0 + s4.GetBannerWeight)) <= (0 + s4.GetBannerWeight) then return _v8.Id end
	end
	local w4 = (#s1)
	return s1[w4].Id
end
function RotationSeconds.CurrentBannerId() -- proto[20], line 336  -- upvalues: s4
	return s4.BannerIdForPeriod(s4.CurrentPeriod())
end
function RotationSeconds.SecondsUntilRotation() -- proto[21], line 340  -- upvalues: Workspace, s4
	return (s4.RotationSeconds - (Workspace.GetServerTimeNow % s4.RotationSeconds))
end
return table.freeze(RotationSeconds)