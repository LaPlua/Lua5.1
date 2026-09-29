-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.Sakura
-- ============================================

-- bytecode
-- Original size: 5832 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 121, Protos: 14, Main proto: 13

-- ============== SOURCE ==============
-- main chunk (proto[13], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
local IntervalSeconds = { IntervalSeconds = 1800, OffsetSeconds = 900, DurationSeconds = 285, NightPollSeconds = 0.5, EndsAtAttribute = "GreatBloomEndsAt", MaxActiveTrees = 50, SpawnDelayMin = 0.25, SpawnDelayMax = 0.75, SpawnClearance = 6, SpawnAttempts = 40, HitCooldownSeconds = 0.6, HitHoldSeconds = 0.2, EndingWarningSeconds = 30, HitRange = 10, SpawnShakeRadius = 10, CrystalScale = 0.22, CrystalPickupRange = 10, CrystalLifetimeSeconds = 60, CrystalSpreadRadius = 14, Sizes = {{ Id = "Small", Weight = 50, Hits = 1, CrystalsPerHit = 0, ScatterCrystals = 1, ScatterCrystalValue = 5 }, { Id = "Medium", Weight = 30, Hits = 2, CrystalsPerHit = 0, ScatterCrystals = 2, ScatterCrystalValue = 5 }, { Id = "Large", Weight = 15, Hits = 3, CrystalsPerHit = 0, ScatterCrystals = 4, ScatterCrystalValue = 5 }, { Id = "Gigantic", Weight = 5, Hits = 3, CrystalsPerHit = 0, ScatterCrystals = 6, ScatterCrystalValue = 5 }} }
local Cost = { Cost = 1000, MaxChargePercent = 150, SpecialChanceAt100 = 2.5, SpecialChanceAtMax = 5, LuckBoostMultiplier = 2, LuckBoostProductNames = {"SakuraLuckBoost1", "SakuraLuckBoost2", "SakuraLuckBoost3"}, MaxLuckBoosts = 3 }
local AreaId = { AreaId = "CherryBlossom", DisplayName = "Cherry Blossom", Emoji = "🌸", Rarity = Rarity.Rarities.Divine, Lighting = "CherryBlossom" }
local EventName = { EventName = "GreatBloom", CurrencyId = "SakuraCrystals", MutationName = "Sakura", SpecialMutationName = "GreatBloom", TreeTag = "SakuraBloomTree", CrystalTag = "SakuraCrystal", BatToolAttribute = "IsBat", Bloom = IntervalSeconds, Incubator = Cost, Sounds = { TreeSpawn = 116457372922007, TreeHit = 84529703733081, TreeBreak = 83426144942407, CrystalPickup = 98181315786739, CrystalsGained = 72831064837421, Deposit = 133204478644023, Mutate = 139860804876890, CraneFlap = 9120779671, Bloom = 9116418035, Unlocked = 102177008084626, TutorialOpen = 89550685069550 }, AreaDisplay = AreaId, Quest = { CraneAssetId = "Crane" } }
local s1 = EventName
function EventName.GetRequiredCrystals() -- proto[0], line 122  -- upvalues: s1
	return s1.Incubator.Cost
end
function EventName.GetChargePercent(v1, v2) -- proto[1], line 126  -- upvalues: s1
	if v2 <= 0 then return 0 end
	return (math.clamp(((v1 / v2) * 100), 0, s1.Incubator.MaxChargePercent))
end
function EventName.GetLuckMultiplier(v3) -- proto[2], line 134  -- upvalues: s1
	return R1
end
function EventName.CanBuyLuckBoost(v4, v5) -- proto[3], line 138  -- upvalues: s1
	if not (v4.Unlocked) then return false, "The Sakura Incubator is still sealed" end
	if v4.Egg == false then return false, "Place an egg inside first" end
	if s1.Incubator.MaxLuckBoosts <= v4.LuckBoost then return false, "This egg already has max luck" end
	if v5 == (v4.LuckBoost + 1) then return true, nil end
	return false, "Wrong luck boost tier for this egg"
end
function EventName.GetFreeChargeCap(v6) -- proto[4], line 161  -- upvalues: s1
	return (math.ceil(((v6 * s1.Incubator.MaxChargePercent) / 100)))
end
function EventName.GetMutationChance(v7) -- proto[5], line 165
	return (math.clamp(v7, 0, 100))
end
function EventName.GetEffectiveMutationChance(v8, v9) -- proto[6], line 170  -- upvalues: s1
	return (100 - s1.GetSpecialChance)
end
function EventName.GetSpecialChance(v10, v11) -- proto[7], line 174  -- upvalues: s1
	local r1 = math.max((v10 - 100), 0)
	local v_u1 = s1.Incubator.MaxChargePercent
	local w1 = (v_u1 - 100)
	local w2 = (r1 / (math.max(w1, 1)))
	return (math.clamp(((s1.Incubator.SpecialChanceAt100 + ((s1.Incubator.SpecialChanceAtMax - s1.Incubator.SpecialChanceAt100) * w2)) * s1.GetLuckMultiplier), 0, 100))
end
function EventName.PickTreeSize(v12) -- proto[8], line 182  -- upvalues: s1
	for _k6, _v7 in ipairs(s1.Bloom.Sizes) do
	end
	local w3 = (v12.NextNumber * (0 + _v7.Weight))
	for _k8, _v9 in ipairs(s1.Bloom.Sizes) do
		if w3 <= (0 + _v9.Weight) then return _v9 end
	end
	return s1.Bloom.Sizes[(#s1.Bloom.Sizes)]
end
function EventName.GetTreeSize(v13) -- proto[9], line 204  -- upvalues: s1
	for _k4, _v5 in ipairs(s1.Bloom.Sizes) do
		if _v5.Id == v13 then return _v5 end
	end
	local r2 = ("Unknown Sakura tree size %*"):format(v13)
end
function EventName.HasSakuraMutation(v14) -- proto[10], line 214  -- upvalues: s1
	local f1
	if v14 == nil then return false end
	if table.find ~= nil then return f1 end
	f1 = not (table.find == nil)
	return f1
end
function EventName.IsBatTool(v15) -- proto[11], line 223  -- upvalues: s1
	local f1 = not (v15.GetAttribute ~= true)
	return f1
end
local ReplicatedStorage_2 = game:GetService("ReplicatedStorage")
local BalanceConfig = require(ReplicatedStorage_2.Shared.Flags.BalanceConfig)
local Bloom = { Bloom = { IntervalSeconds = true, OffsetSeconds = true, DurationSeconds = true, MaxActiveTrees = true, SpawnDelayMin = true, SpawnDelayMax = true, HitCooldownSeconds = true, HitRange = true, CrystalPickupRange = true, CrystalLifetimeSeconds = true, Sizes = true }, Incubator = { Cost = true, MaxChargePercent = true, SpecialChanceAt100 = true, SpecialChanceAtMax = true, LuckBoostMultiplier = true, MaxLuckBoosts = true } }
EventName = BalanceConfig.Bind("Game.Balance.Sakura", EventName, Bloom, false, function(v16)
	local f2
	if 0 < v16.Bloom.IntervalSeconds then
		f2 = not (0 >= v16.Bloom.DurationSeconds)
	end
	assert(f2)
	if v16.Bloom.SpawnDelayMin <= v16.Bloom.SpawnDelayMax then
		f2 = not (0 >= v16.Bloom.SpawnDelayMin)
	end
	assert(f2)
	f2 = not ((v16.Bloom.MaxActiveTrees % 1) > 0)
	assert(f2)
	if 0 < v16.Incubator.Cost then
		f2 = not (100 >= v16.Incubator.MaxChargePercent)
	end
	assert(f2)
	if v16.Incubator.SpecialChanceAt100 <= 100 then
		f2 = false  -- skip 1
		f2 = true
	end
	assert(f2)
	if ((v16 ^ "Bloom").Incubator.MaxLuckBoosts % 1) <= 0 then
		f2 = false  -- skip 1
		f2 = true
	end
	assert(f2)
end)
return EventName