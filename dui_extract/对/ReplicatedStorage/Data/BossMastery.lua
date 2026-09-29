-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.BossMastery
-- ============================================

-- bytecode
-- Original size: 12288 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 170, Protos: 32, Main proto: 31

-- ============== SOURCE ==============
-- main chunk (proto[31], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local BossMasteryFlags = require(ReplicatedStorage.Shared.Flags.BossMasteryFlags)
local BossMastery = require(ReplicatedStorage.Shared.Types.BossMastery)
local Currency = require(ReplicatedStorage.Data.Currency)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Rift = require(ReplicatedStorage.Data.Rift)
local RiftbornEgg = {}
local DisplayName = { Id = "RiftbornEgg", DisplayName = "Riftborn Egg", Reward = { Kind = "RiftEgg", BannerId = "Verdant", Mutated = false } }
RiftbornEgg.RiftbornEgg = DisplayName
local DisplayName_2 = { Id = "RiftbeastsEgg", DisplayName = "Riftbeasts Egg", Reward = { Kind = "RiftEgg", BannerId = "Umbral", Mutated = false } }
RiftbornEgg.RiftbeastsEgg = DisplayName_2
local DisplayName_3 = { Id = "MutatedRiftbornEgg", DisplayName = "Mutated Riftborn Egg", Reward = { Kind = "RiftEgg", BannerId = "Verdant", Mutated = true } }
RiftbornEgg.MutatedRiftbornEgg = DisplayName_3
local DisplayName_4 = { Id = "RotationMutatedEgg", DisplayName = "Mutated Egg", Reward = { Kind = "RiftRotationEgg", Mutated = true } }
RiftbornEgg.RotationMutatedEgg = DisplayName_4
local DisplayName_5 = { Id = "TokenBoost", DisplayName = "Permanent Boss Token Boost", Reward = { Kind = "TokenBoost", Percent = 50 } }
RiftbornEgg.TokenBoost = DisplayName_5
local s1 = {{ Id = "Mastery3", Kills = 3, RewardId = "RiftbornEgg" }, { Id = "Mastery5", Kills = 5, RewardId = "TokenBoost" }, { Id = "Mastery10", Kills = 10, RewardId = "RiftbeastsEgg" }, { Id = "Mastery15", Kills = 15, RewardId = "MutatedRiftbornEgg" }, { Id = "Mastery20", Kills = 20, RewardId = "RotationMutatedEgg" }, { Id = "Mastery30", Kills = 30, RewardId = "RotationMutatedEgg" }}
local s2 = {}
for _k13, _v14 in ipairs(s1) do
	s2[_v14.Id] = _v14
end
local _r10 = {}
local DisplayName_6 = { Id = "CashBooster", DisplayName = "2x Cash Booster", Icon = "rbxassetid://119640363267627", Price = 175, Reward = { Kind = "CashBooster" } }
local DisplayName_7 = { Id = "SpeedBoost", DisplayName = "1.25x Speed", Icon = "rbxassetid://78137530993637", Price = 225, Reward = { Kind = "SpeedBoost" } }
local DisplayName_8 = { Id = "TreadmillBooster", DisplayName = "2x Treadmill Booster", Icon = "rbxassetid://107126944152347", Price = 200, Reward = { Kind = "TreadmillBoost" } }
local DisplayName_9 = { Id = "MutationConsumable", DisplayName = "Mutation Consumable", Icon = "rbxassetid://74755693699202", Price = 400, Reward = { Kind = "MutationConsumable" } }
_r10[1], _r10[2], _r10[3], _r10[4] = DisplayName_6, DisplayName_7, DisplayName_8, DisplayName_9
local s3 = {}
for _k15, _v16 in ipairs(_r10) do
	s3[_v16.Id] = _v16
end
local Verdant = { Verdant = 55, Umbral = 40, Radiant = 5 }
local s4 = RiftbornEgg
local function getRewardSpec(v1) -- proto[0], line 173  -- upvalues: s4
	return s4[v1]
end
local function GetMilestone(v2) -- proto[1], line 177  -- upvalues: s2
	return s2[v2]
end
local function FinalMilestone() -- proto[2], line 181  -- upvalues: s1
	return s1[(#s1)]
end
local function GetMilestoneKills(v3) -- proto[3], line 185  -- upvalues: BossMasteryFlags
	if BossMasteryFlags.MilestoneKillOverrides.Get[v3.Id] == nil then return v3.Kills end
	return BossMasteryFlags.MilestoneKillOverrides.Get[v3.Id]
end
local function GetMilestoneRewardId(v4) -- proto[4], line 193  -- upvalues: BossMasteryFlags, s4
	if BossMasteryFlags.MilestoneRewardIdOverrides.Get[v4.Id] == nil then return v4.RewardId end
	if s4[BossMasteryFlags.MilestoneRewardIdOverrides.Get[v4.Id]] == nil then return v4.RewardId end
	return BossMasteryFlags.MilestoneRewardIdOverrides.Get[v4.Id]
end
local MutationId = { MutationId = "Boss", InfiniteMilestoneId = "Infinite", Milestones = s1, ShopProducts = _r10, GetMilestone = GetMilestone, FinalMilestone = FinalMilestone, GetMilestoneKills = GetMilestoneKills, GetMilestoneRewardId = GetMilestoneRewardId }
local s5 = MutationId
function MutationId.GetMilestoneReward(v5) -- proto[5], line 202  -- upvalues: s5, s4
	local f1
	local state_4_2 = s5.GetMilestoneRewardId
	local v_u1 = s4[state_4_2]
	if not (v_u1) then
		state_4_2 = v5.RewardId
		v_u1 = s4[state_4_2]
	end
	f1 = not (v_u1 == nil)
	assert(f1, (("Unknown Boss Mastery reward for %*"):format(v5.Id)))
	return v_u1.Reward
end
function MutationId.GetInfiniteRewardId() -- proto[6], line 209  -- upvalues: BossMasteryFlags, s4
	if s4[BossMasteryFlags.InfiniteRewardId.Get] == nil then return "RotationMutatedEgg" end
	if s4[BossMasteryFlags.InfiniteRewardId.Get].Reward.Kind == "RiftEgg" then return BossMasteryFlags.InfiniteRewardId.Get end
	if s4[BossMasteryFlags.InfiniteRewardId.Get].Reward.Kind ~= "RiftRotationEgg" then return "RotationMutatedEgg" end
	return BossMasteryFlags.InfiniteRewardId.Get
end
function MutationId.GetInfiniteReward() -- proto[7], line 224  -- upvalues: s5, s4
	local state_4_2 = s5.GetInfiniteRewardId
	local w1 = s4[state_4_2]
	return (assert(w1, "Infinite Boss Mastery reward spec is missing")).Reward
end
function MutationId.InfiniteRevealKey(v6) -- proto[8], line 232  -- upvalues: s5
	return (("%*:%*"):format(s5.InfiniteMilestoneId, v6))
end
function MutationId.GetTokenBoostPercent(v7) -- proto[9], line 236  -- upvalues: s5, BossMasteryFlags
	if s5.GetMilestoneReward.Kind ~= "TokenBoost" then return 0 end
	if BossMasteryFlags.TokenBoostPercentOverrides.Get[v7.Id] == nil then return s5.GetMilestoneReward.Percent end
	return BossMasteryFlags.TokenBoostPercentOverrides.Get[v7.Id]
end
function MutationId.GetShopProduct(v8) -- proto[10], line 249  -- upvalues: s3
	return s3[v8]
end
function MutationId.GetShopProducts() -- proto[11], line 253  -- upvalues: BossMasteryFlags, s3
	local _r0 = {}
	local _r1 = {}
	for _k5, _v6 in ipairs(BossMasteryFlags.ShopProductIds.Get) do
		if s3[_v6] == nil then continue end
		if _r1[_v6] then continue end
		_r1[_v6] = true
		table.insert(_r0, s3[_v6])
	end
	return _r0
end
function MutationId.IsShopProductListed(v9) -- proto[12], line 266  -- upvalues: s5
	for _k4, _v5 in ipairs(s5.GetShopProducts) do
		if _v5.Id == v9 then return true end
	end
	return false
end
function MutationId.GetShopPrice(v10) -- proto[13], line 275  -- upvalues: BossMasteryFlags
	if BossMasteryFlags.ShopPriceOverrides.Get[v10.Id] == nil then return v10.Price end
	return BossMasteryFlags.ShopPriceOverrides.Get[v10.Id]
end
function MutationId.GetShopDisplayName(v11) -- proto[14], line 283  -- upvalues: BossMasteryFlags
	if v11.Reward.Kind == "CashBooster" then
		return (("%*x Cash Booster"):format(BossMasteryFlags.CashBoosterMultiplier.Get))
	end
	if v11.Reward.Kind == "SpeedBoost" then
		return (("%*x Speed"):format(BossMasteryFlags.SpeedBoostMultiplier.Get))
	end
	if v11.Reward.Kind ~= "TreadmillBoost" then return v11.DisplayName end
	return (("%*x Treadmill Booster"):format(BossMasteryFlags.TreadmillBoostMultiplier.Get))
end
function MutationId.GetShopQuantity(v12) -- proto[15], line 295  -- upvalues: BossMasteryFlags
	if v12.Reward.Kind ~= "Traps" then return 1 end
	return BossMasteryFlags.TrapsPerPurchase:Get()
end
function MutationId.GetShopQuantityText(v13) -- proto[16], line 302  -- upvalues: BossMasteryFlags, s5
	if v13.Reward.Kind == "CashBooster" then
		return (("%*m"):format((math.max((math.floor(BossMasteryFlags.CashBoosterDurationSeconds.Get / 60)), 0))))
	end
	if v13.Reward.Kind == "SpeedBoost" then
		return (("%*m"):format((math.max((math.floor(BossMasteryFlags.SpeedBoostDurationSeconds.Get / 60)), 0))))
	end
	if v13.Reward.Kind == "TreadmillBoost" then
		return (("%*m"):format((math.max((math.floor(BossMasteryFlags.TreadmillBoostDurationSeconds.Get / 60)), 0))))
	end
	if v13.Reward.Kind == "MutationConsumable" then
		return (("%*%%"):format(BossMasteryFlags.MutationConsumableSuccessPercent.Get))
	end
	return (("x%*"):format(s5.GetShopQuantity))
end
function MutationId.RewardNeedsReveal(v14) -- proto[17], line 327
	local f2
	if v14.Kind == "RiftEgg" then return f2 end
	f2 = not (v14.Kind ~= "RiftRotationEgg")
	return f2
end
local s6 = Verdant
function MutationId.GetRotationBannerWeights() -- proto[18], line 331  -- upvalues: BossMasteryFlags, s6, Rift
	for _k5, _v6 in ipairs(BossMasteryFlags.InfiniteBannerWeights.Get) do
		if Rift.GetBanner == nil then continue end
		table.clone[_k5] = _v6
	end
	return table.clone
end
function MutationId.RollBannerId(v15) -- proto[19], line 342  -- upvalues: s5
	for _k6, _v7 in ipairs(s5.GetRotationBannerWeights) do
		if 0 >= _v7 then continue end
	end
	if (0 + _v7) <= 0 then return nil end
	local w2 = (v15.NextNumber * (0 + _v7))
	for _k9, _v10 in ipairs(s5.GetRotationBannerWeights) do
		if w2 <= (0 + _v10) then return _k9 end
	end
	return _k9
end
function MutationId.RollReveal(v16, v17) -- proto[20], line 370  -- upvalues: s5, Rift
	local BannerId
	local v_u2 = nil
	if v16.Kind == "RiftEgg" then
		BannerId = v16.BannerId
	else
		if v16.Kind ~= "RiftRotationEgg" then return nil end
		if s5.RollBannerId == nil then return nil end
		v_u2 = s5.RollBannerId
	if Rift.RollPet == nil then return nil end
	local BannerId = { BannerId = v_u2, AssetId = Rift.RollPet }
	return BannerId
end
function MutationId.FillMissingReveals(v18, v19) -- proto[22], line 394  -- upvalues: Assets, Rift, s5, s1
	local clone = table.clone
	local f3 = false
	local arg1_upvalue = v19
	local function ensure(v20, v21) -- proto[21], line 401  -- upvalues: clone, Assets, Rift, f3, s5, arg1_upvalue
		if clone[v20] ~= nil then
			if v21.Kind == "RiftEgg" then
				if clone[v20].BannerId == v21.BannerId then
					if Assets.Directory[clone[v20].AssetId] ~= nil then
						if Rift.BannerContainsPet then return end
						clone[v20] = nil
						f3 = true
					end
				end
			end
		end
		if s5.RollReveal == nil then return end
		clone[v20] = s5.RollReveal
		f3 = true
	end
	for _k8, _v9 in ipairs(s1) do
		if v18.ClaimedMilestoneIds[_v9.Id] then continue end
		ensure(_v9.Id, s5.GetMilestoneReward(_v9))
	end
	local v_u3 = v18.ClaimedMilestoneIds
	local v_u4 = s5.FinalMilestone.Id
	if v_u3[v_u4] then
		local r1 = math.max(s5.ClaimableInfiniteCount, 1)
		for _i = (v18.InfiniteRewardsClaimed + 1), (v18.InfiniteRewardsClaimed + r1) do
		end
	end
	return (v18 ^ "table")
end
function MutationId.TokenBoostMultiplierFor(v22) -- proto[23], line 448  -- upvalues: BossMasteryFlags
	for _k5, _v6 in ipairs(v22) do
	end
	return (((0 + _v6) / 100) + 1)
end
function MutationId.NextMilestoneFor(v23) -- proto[24], line 460  -- upvalues: s1, s5
	for _k4, _v5 in ipairs(s1) do
		if v23 < s5.GetMilestoneKills then return _v5 end
	end
	return nil
end
function MutationId.ClaimableInfiniteCount(v24) -- proto[25], line 469  -- upvalues: s5, BossMasteryFlags
	if not (v24.ClaimedMilestoneIds[s5.FinalMilestone.Id]) then return 0 end
	local r1 = math.max(s5.GetMilestoneKills, 0)
	local v_u6 = v24.InfiniteRewardsClaimed
	local w3 = (r1 - v_u6)
	return (math.max(w3, 0))
end
local function bossEggIcon() -- proto[26], line 483  -- upvalues: Mutations
	if Mutations.Get == nil then return "rbxassetid://121553987798547" end
	if Mutations.Get.EggIcon == nil then return "rbxassetid://121553987798547" end
	return Mutations.Get.EggIcon
end
local function tokenBoostPresentation(v25) -- proto[27], line 491  -- upvalues: Currency
	local Title = { Title = "Permanent Token Boost", Icon = (assert(Currency.Directory.BossTokens.Icon, "Boss Tokens icon is missing")), Amount = (("+%*%%"):format(v25)), HoverTitle = "BOSS TOKEN BOOST", HoverDescription = (("Earn +%*%% Boss Tokens from boss kills"):format(v25)) }
	return Title
end
local function rotationEggIcons() -- proto[28], line 504  -- upvalues: s5, Rift
	local _r1 = {}
	for _k5, _v6 in ipairs(Rift.Banners) do
		if Rift.GetBannerEggIcon == nil then continue end
		table.insert(_r1, Rift.GetBannerEggIcon)
	end
	return _r1
end
function MutationId.GetRewardPresentation(v26, v27, v28) -- proto[29], line 519  -- upvalues: Currency, Rift, Mutations, rotationEggIcons, s3, s5
	local r2
	local r3
	local v_u5
	local Title
	if v26.Kind == "TokenBoost" then
		Title = { Title = "Permanent Token Boost", Icon = (assert(Currency.Directory.BossTokens.Icon, "Boss Tokens icon is missing")), Amount = (("+%*%%"):format(v26.Percent)), HoverTitle = "BOSS TOKEN BOOST", HoverDescription = (("Earn +%*%% Boss Tokens from boss kills"):format(v26.Percent)) }
		return Title
	end
	local r4 = ("x%*"):format(v28 or 1)
	if v26.Kind == "RiftEgg" then
		if v26.Mutated then
			local r5 = ("Mutated %* Egg"):format(Rift.GetBannerDisplayName)
		else
			r2 = ("%* Egg"):format(Rift.GetBannerDisplayName)
		end
		local Rift_2 = Rift.GetBannerEggIcon
		if not (Rift_2) then
			if (Mutations.Get ~= nil) and (Mutations.Get.EggIcon ~= nil) then
				Rift_2 = Mutations.Get.EggIcon
			end
		end
		if v26.Mutated then
			local r6 = ("MUTATED %* EGG"):format(Rift.GetBannerDisplayName)
		else
			local r7 = ("%* EGG"):format(Rift.GetBannerDisplayName)
		end
		if v26.Mutated then
			local r8 = ("Awards a %* Egg with the Fractured mutation"):format(Rift.GetBannerDisplayName)
		else
			r3 = ("Awards a %* Egg"):format(Rift.GetBannerDisplayName)
		end
		local Title_2 = { Title = r2, Icon = "rbxassetid://121553987798547", Amount = r4, HoverTitle = string.upper, HoverDescription = r3 }
		return Title_2
	end
	if v26.Kind == "RiftRotationEgg" then
		if not (rotationEggIcons[1]) then
			if (Mutations.Get ~= nil) and (Mutations.Get.EggIcon ~= nil) then
				r3 = Mutations.Get.EggIcon
			end
		end
		local Title_3 = { Title = "Random Mutated Egg", Icon = "rbxassetid://121553987798547", CycleIcons = rotationEggIcons, Amount = r4, HoverTitle = "MUTATED EGG", HoverDescription = "Awards a random egg with the Fractured mutation" }
		return Title_3
	end
	if (s3["MutationConsumable"]) then
		v_u5 = s5.GetShopDisplayName
	end
	if (s3["MutationConsumable"]) then
		v_u5 = s3["MutationConsumable"].Icon
	else
		if (Mutations.Get ~= nil) and (Mutations.Get.EggIcon ~= nil) then
			v_u5 = Mutations.Get.EggIcon
		end
	end
	local Title_4 = { Title = "Reward", Icon = "rbxassetid://121553987798547", Amount = r4 }
	return Title_4
end
function MutationId.GetMilestonePresentation(v29, v30, v31) -- proto[30], line 574  -- upvalues: s5, Currency
	if s5.GetMilestoneReward.Kind ~= "TokenBoost" then return s5.GetRewardPresentation(s5.GetMilestoneReward, v30, v31) end
	local Title = { Title = "Permanent Token Boost", Icon = (assert(Currency.Directory.BossTokens.Icon, "Boss Tokens icon is missing")), Amount = (("+%*%%"):format(s5.GetTokenBoostPercent)), HoverTitle = "BOSS TOKEN BOOST", HoverDescription = (("Earn +%*%% Boss Tokens from boss kills"):format(s5.GetTokenBoostPercent)) }
	return Title
end
return table.freeze(MutationId)