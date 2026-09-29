-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.MonsterParasite
-- ============================================

-- bytecode
-- Original size: 11076 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 263, Protos: 12, Main proto: 11

-- ============== SOURCE ==============
-- main chunk (proto[11], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Flyswatter = require(ReplicatedStorage.Data.Gears.Configs.Flyswatter)
local MonsterParasiteFlags = require(ReplicatedStorage.Shared.Flags.MonsterParasiteFlags)
local MonsterParasite = require(ReplicatedStorage.Shared.Types.MonsterParasite)
local Snow = { Snow = 29, Volcano = 26 }
Snow["Abyss Ocean"] = 18
Snow.Prehistoric = 15
Snow.Cosmic = 13
Snow["Cherry Blossom"] = 11
Snow["Titan Temple"] = 9
local s1 = {{ Charge = 0, Scale = 1 }, { Charge = 20, Scale = 1.12 }, { Charge = 40, Scale = 1.25 }, { Charge = 60, Scale = 1.45 }, { Charge = 80, Scale = 1.75 }, { Charge = 100, Scale = 2 }}
local _r7 = {"Monster1", "Monster2", "Monster3", "Monster4"}
local _r8 = {"ChestOrigin", "MouthCenter1", "Tongue3"}
local _r9 = {}
local Idle = { Idle = 128217356432291, Yank = 86644195835902 }
local Idle_2 = { Idle = 99744254158313, Yank = 131549849408123 }
local Idle_3 = { Idle = 122218896916983, Yank = 140178521003505 }
local Idle_4 = { Idle = 124151642143348, Yank = 110901356129499, Burp = 94789436133823 }
local function GetMonsterModelIndex(v1) -- proto[0], line 208
	if 80 <= v1 then return 4 end
	if 60 <= v1 then return 3 end
	if 40 > v1 then return 1 end
	return 2
end
local function buildMonstrousEggIdsList() -- proto[1], line 225  -- upvalues: ReplicatedStorage
	local f1
	local _r1 = {}
	for _k5, _v6 in ipairs(require.Directory["Titan Temple"].DropTable) do
		local Id = { Id = _v6[1], Weight = _v6[2] }
		table.insert(_r1, Id)
	end
	f1 = not (0 >= (#_r1))
	assert(f1, "Titan Temple has no drop table for the Monstrous Egg")
	return _r1
end
local s2 = {}
local Weight = { Id = MonsterParasite.RewardIds.EggGrowthBoost, Weight = 43.5, DisplayName = "1.25x Egg Growth", DisplayNote = "5 Minutes", Rarity = "Common", Icon = "rbxassetid://84954605144740", Metadata = { DurationSeconds = 300, Multiplier = 1.25 } }
local Weight_2 = { Id = MonsterParasite.RewardIds.SpeedBoost, Weight = 30, DisplayName = "1.25x Speed", DisplayNote = "5 Minutes", Rarity = "Uncommon", Icon = "rbxassetid://78137530993637", Metadata = { DurationSeconds = 300, Multiplier = 1.25 } }
local Weight_3 = { Id = MonsterParasite.RewardIds.TreadmillBoost, Weight = 20, DisplayName = "2x Treadmill Speed", DisplayNote = "5 Minutes", Rarity = "Rare", Metadata = { DurationSeconds = 300 } }
local GearId = {}
GearId.GearId = Flyswatter._id
local Weight_4 = { Id = MonsterParasite.RewardIds.ExclusiveWeapon, Weight = 5, DisplayName = "Flyswatter", DuplicateRewardId = MonsterParasite.RewardIds.TreadmillBoost, Rarity = "Epic", Icon = Flyswatter.Icon, Metadata = GearId }
local MutationId = { MutationId = "Monstrous", EggIdsList = (buildMonstrousEggIdsList()) }
local Weight_5 = { Id = MonsterParasite.RewardIds.MonsterEgg, Weight = 1.5, DisplayName = "PARASITE EGG", DisplayNote = "Guaranteed Monstrous Mutation", NoteIsPanelOnly = true, Rarity = "BEST REWARD", Icon = "rbxassetid://121553987798547", Metadata = MutationId }
s2[1], s2[2], s2[3], s2[4], s2[5] = Weight, Weight_2, Weight_3, Weight_4, Weight_5
local function RewardLabel(v2) -- proto[2], line 314
	if v2.DisplayNote == nil then return v2.DisplayName end
	if v2.NoteIsPanelOnly then return v2.DisplayName end
	return (("%* (%*)"):format(v2.DisplayName, v2.DisplayNote))
end
local function GetReward(v3) -- proto[3], line 322  -- upvalues: s2
	for _k4, _v5 in ipairs(s2) do
		if _v5.Id == v3 then return _v5 end
	end
	local r1 = ("Unknown Monster Chest reward %*"):format(v3)
end
local r2 = CFrame.new(0, -0.15, -0.35)
local s3 = Snow
local function GetSpawnChance(v4) -- proto[4], line 468  -- upvalues: MonsterParasiteFlags, s3
	if MonsterParasiteFlags.SpawnChanceByArea.Get[v4] == nil then return (s3[v4] or 0) end
	return MonsterParasiteFlags.SpawnChanceByArea.Get[v4]
end
local function GetBellyScale(v5) -- proto[5], line 477  -- upvalues: s1
	local v_u2 = s1[1].Scale
	for _k5, _v6 in ipairs(s1) do
		if v5 < _v6.Charge then return v_u2 end
		v_u2 = _v6.Scale
	end
	return v_u2
end
local function BoostMultiplier(v6) -- proto[6], line 493  -- upvalues: MonsterParasite, s2
	local _r2
	for _k7, _v8 in ipairs(s2) do
		if (_v8.Id == MonsterParasite.BoostRewardIds[v6]) then
			_r2 = _v8
		end
		local r1 = ("Unknown Monster Chest reward %*"):format(MonsterParasite.BoostRewardIds[v6])
		_r2 = nil
	end
	_r2 = _r2.Metadata
	_r2 = _r2.Multiplier
	return (_r2 or 1)
end
local function BoostDurationSeconds(v7) -- proto[7], line 496  -- upvalues: MonsterParasite, s2
	local _r2
	for _k7, _v8 in ipairs(s2) do
		if (_v8.Id == MonsterParasite.BoostRewardIds[v7]) then
			_r2 = _v8
		end
		local r1 = ("Unknown Monster Chest reward %*"):format(MonsterParasite.BoostRewardIds[v7])
		_r2 = nil
	end
	_r2 = _r2.Metadata
	_r2 = _r2.DurationSeconds
	return (_r2 or 0)
end
local function GetRewardWeight(v8) -- proto[8], line 499  -- upvalues: MonsterParasiteFlags, s2
	local _r2
	if MonsterParasiteFlags.RewardWeights.Get[v8] ~= nil then return MonsterParasiteFlags.RewardWeights.Get[v8] end
	for _k6, _v7 in ipairs(s2) do
		if (_v7.Id == v8) then
			_r2 = _v7
		end
		local r1 = ("Unknown Monster Chest reward %*"):format(v8)
		_r2 = nil
	end
	_r2 = _r2.Weight
	return _r2
end
local EventName = { EventName = "MonsterParasite", EndsAt = 1788620400, MinimumRarityNumber = 5, EligibilityGuardId = "Jungle", SpawnChanceByArea = Snow, ChargePerFeed = 20, MaxCharge = 100, BellyStages = s1, Rewards = s2, FeedDistance = 14, HudDistance = 24, RequestCooldown = 0.75, PromptHoldDuration = 0.25, MonsterOffset = (CFrame.new(0, 0, -8)), MarkerFolderName = "MonsterParasiteMarkers", MonsterSpawnMarkerName = "MonsterSpawn", ChestSpawnMarkerName = "MonsterChestSpawn", ChestSpawnCFrameAttributeName = "MonsterChestSpawnCFrame", AssetsFolderName = "MonsterParasite", ParasiteModelName = "Parasite", ParasiteVisualName = "MonsterParasiteVisual", ParasiteIdleAnimationId = 113082199990805, ParasiteCrownOffset = Vector2.zero, ParasiteScaleMultiplier = 0.45, MonsterModelName = "Monster", MonsterModelNames = _r7, MonsterModelIndexAttributeName = "MonsterModelIndex", MonsterRetiringAttributeName = "MonsterRetiring", MonsterRetireSeconds = 0.45, MonsterAnimationIdsByIndex = _r9, ChestModelName = "MonsterChest", ChestToolName = "Monster Chest", ChestToolItemType = "MonsterChest", ChestToolScale = 0.42, ChestToolGrip = (r2 * (CFrame.Angles(0, 1.5707963267948966, 0))), ChestToolIcon = "rbxassetid://139693832314356", ChestPickupDuration = 0.6, ParasiteBillboardName = "MonsterParasite", ParasiteBillboardScale = 0.5, ParasiteHighlightName = "MonsterParasiteHighlight", ParasiteHighlightColor = (Color3.fromRGB(198, 158, 255)), ParasiteHighlightTransparency = 0.25, ParasiteHighlightFillTransparency = 0.7, HudName = "MonsterChargeUI", WorldFolderName = "MonsterParasiteMonsters", PadName = "Monster", MonsterDisplayName = "The Hungry Monster", TalkPromptName = "TalkPrompt", TalkPromptText = "Who are you?", FeedPromptName = "FeedPrompt", FeedPromptText = "Feed Parasite", ChestPromptName = "ChestPrompt", ChestPromptText = "Claim Monster Chest", DialogueText = "Parasites make me stronger. Bring me an infested egg, and I will eat the parasite without harming what is inside.", RewardTitle = "MONSTER CHEST REWARD", BellyPartName = "Belly", ParasiteEatTargetPartName = "ParasiteEatTarget", TongueTipName = "Tongue3", ChestOriginPartName = "ChestOrigin", ChestOriginNames = _r8, GrabMarkerName = "Grab", BurpMarkerName = "burp_start", ChestOffset = (CFrame.new(0, 2, -4)), YankDuration = 0.35, BellyTweenDuration = 0.45, FullChargeHoldDuration = 0.8, FullChargeModelHoldDuration = 15, BurpBeatDuration = 0.18, RoarDuration = 0.55, ChestLaunchDelay = 0.06, ChestLaunchDuration = 0.78, ChestBounceDuration = 0.4, ChestLaunchHeight = 5, ChestBounceHeight = 1.4, ChestLaunchStartScale = 0.65, ChestLaunchSpins = 2, ChestLaunchBeatFallback = 2.4, ChestThrowDistanceMin = 12, ChestThrowDistanceMax = 19, ChestThrowSpreadDegrees = 26, ChestThrowStraightJitterDegrees = 5, ChestThrowAttempts = 5, ChestGroundRestDuration = 0.3, ChestPickupRise = 2.5, ChestGroundProbeHeight = 6, ChestGroundProbeDepth = 90, ChestImpactShakeMagnitude = 1.4, ChestImpactShakeRoughness = 9, ChestImpactShakeFadeIn = 0.04, ChestImpactShakeFadeOut = 0.5, ChestImpactShakeRange = 110, SoundFolderName = "MonsterParasite", YankSoundName = "Yank", ChompSoundName = "Chomp", BurpSoundName = "Burp", RoarSoundName = "Roar", EnergyBurstSoundName = "EnergyBurst", ChestLandingSoundName = "ChestLanding", ChestSoundName = "ChestOpen", VfxFolderName = "MonsterParasite", EnergyBurstVfxName = "EnergyBurst", SwapPoofVfxName = "SwapPoof", GroundHitParticlesName = "BigHitGroundAttach", HudRootName = "Root", HudBarName = "Bar", HudFillName = "Fill", HudPercentName = "Percent", HudStatusName = "Status", HudTimerName = "Timer", HudChargingText = "MONSTER CHARGE", HudReadyText = "MONSTER CHEST READY!", GetSpawnChance = GetSpawnChance, GetBellyScale = GetBellyScale, GetMonsterModelIndex = GetMonsterModelIndex, GetReward = GetReward, RewardLabel = RewardLabel, BoostMultiplier = BoostMultiplier, BoostDurationSeconds = BoostDurationSeconds, GetRewardWeight = GetRewardWeight }
local ReplicatedStorage_2 = game:GetService("ReplicatedStorage")
local BalanceConfig = require(ReplicatedStorage_2.Shared.Flags.BalanceConfig)
local MinimumRarityNumber = { MinimumRarityNumber = true, ChargePerFeed = true, MaxCharge = true, FeedDistance = true, RequestCooldown = true, PromptHoldDuration = true }
EventName = BalanceConfig.Bind("Game.Balance.MonsterParasite", EventName, MinimumRarityNumber, false, function(v9)
	local f2
	if 0 < v9.ChargePerFeed then
		if 0 < v9.MaxCharge then
			f2 = not (0 >= v9.FeedDistance)
		end
	end
	assert(f2)
end)
local _r16 = {}
for _k20, _v21 in ipairs(s2) do
	local DurationSeconds_4 = { DurationSeconds = _v21.Metadata.DurationSeconds, Multiplier = _v21.Metadata.Multiplier }
	_r16[_v21.Id] = DurationSeconds_4
end
local ReplicatedStorage_3 = game:GetService("ReplicatedStorage")
local BalanceConfig_2 = require(ReplicatedStorage_3.Shared.Flags.BalanceConfig)
ReplicatedStorage = (BalanceConfig_2.Bind("Game.Balance.MonsterChestRewards", _r16, true, false))
MonsterParasite = MonsterParasite.RewardIds
local function refreshRewards() -- proto[10], line 542  -- upvalues: s2, ReplicatedStorage, MonsterParasite, buildMonstrousEggIdsList
	for _k3, _v4 in ipairs(s2) do
		_v4.Metadata.DurationSeconds = ReplicatedStorage[_v4.Id].DurationSeconds
		_v4.Metadata.Multiplier = ReplicatedStorage[_v4.Id].Multiplier
		if ReplicatedStorage[_v4.Id].DurationSeconds then
			_v4.DisplayNote = (("%* Minutes"):format(ReplicatedStorage[_v4.Id].DurationSeconds / 60))
			if _v4.Id == MonsterParasite.EggGrowthBoost then
				_v4.DisplayName = (("%*x Egg Growth"):format(ReplicatedStorage[_v4.Id].Multiplier))
			end
			if _v4.Id == MonsterParasite.SpeedBoost then
				_v4.DisplayName = (("%*x Speed"):format(ReplicatedStorage[_v4.Id].Multiplier))
			end
		end
		if _v4.Id ~= MonsterParasite.MonsterEgg then continue end
		_v4.Metadata.EggIdsList = buildMonstrousEggIdsList
	end
end
refreshRewards()
local BalanceConfig_3 = require(ReplicatedStorage.Shared.Flags.BalanceConfig)
BalanceConfig_3.Changed:Connect(refreshRewards)
return EventName