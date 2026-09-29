-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.ScrambleMastery
-- ============================================

-- bytecode
-- Original size: 8208 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 113, Protos: 10, Main proto: 9

-- ============== SOURCE ==============
local f1
-- main chunk (proto[9], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local EggSkins = require(ReplicatedStorage.Data.EggSkins)
local ScrambleTradeIn = require(ReplicatedStorage.Data.ScrambleTradeIn)
local Category = { Category = "Mecha Scrambler", Scale = 1 }
local r1 = table.freeze(Category)
local Kind = { Kind = "Banner", BannerId = "Biohazard", Mutated = false }
local r2 = table.freeze(Kind)
local Kind_2 = { Kind = "Banner", BannerId = "Biohazard", Mutated = true }
local r3 = table.freeze(Kind_2)
local Kind_3 = { Kind = "Banner", BannerId = "Experimental", Mutated = false }
local r4 = table.freeze(Kind_3)
local Kind_4 = { Kind = "Banner", BannerId = "Experimental", Mutated = true }
local r5 = table.freeze(Kind_4)
local Kind_5 = { Kind = "Banner", BannerId = "UnstableDNA", Mutated = false }
local r6 = table.freeze(Kind_5)
local Kind_6 = { Kind = "Banner", BannerId = "UnstableDNA", Mutated = true }
local r7 = table.freeze(Kind_6)
local Kind_7 = { Kind = "RandomBanner", Mutated = true }
local r8 = table.freeze(Kind_7)
local Kind_8 = { Kind = "Pet", Category = "Eye Bat", Scale = 1 }
local r9 = table.freeze(Kind_8)
local Kind_9 = { Kind = "Pet", Category = "Citadel Snail", Scale = 1 }
local r10 = table.freeze(Kind_9)
local Kind_10 = { Kind = "Pet", Category = "Uncoiled Armadillo", Scale = 1 }
local r11 = table.freeze(Kind_10)
local Kind_11 = { Kind = "Pet", Category = "Mecha Chompa", Scale = 1 }
local r12 = table.freeze(Kind_11)
local Kind_12 = { Kind = "Pet", Category = "Pink Dragon Experiment", Scale = 1 }
local r13 = table.freeze(Kind_12)
local _r18 = {}
local Kills = { Id = "Scramble1", Kills = 1, Reward = r2 }
local r14 = table.freeze(Kills)
local Kills_2 = { Id = "Scramble3", Kills = 3, Reward = r4 }
local r15 = table.freeze(Kills_2)
local Kills_3 = { Id = "Scramble5", Kills = 5, Reward = r3 }
local r16 = table.freeze(Kills_3)
local Kills_4 = { Id = "Scramble7", Kills = 7, Reward = r6 }
local r17 = table.freeze(Kills_4)
local Kills_5 = { Id = "Scramble10", Kills = 10, Reward = r9 }
local r18 = table.freeze(Kills_5)
local Kills_6 = { Id = "Scramble13", Kills = 13, Reward = r2 }
local r19 = table.freeze(Kills_6)
local Kills_7 = { Id = "Scramble15", Kills = 15, Reward = r3 }
local r20 = table.freeze(Kills_7)
local Kills_8 = { Id = "Scramble18", Kills = 18, Reward = r5 }
local r21 = table.freeze(Kills_8)
local Kills_9 = { Id = "Scramble21", Kills = 21, Reward = r6 }
local r22 = table.freeze(Kills_9)
local Kills_10 = { Id = "Scramble25", Kills = 25, Reward = r10 }
local r23 = table.freeze(Kills_10)
local Kills_11 = { Id = "Scramble30", Kills = 30, Reward = r2 }
local r24 = table.freeze(Kills_11)
local Kills_12 = { Id = "Scramble35", Kills = 35, Reward = r3 }
local r25 = table.freeze(Kills_12)
local Kills_13 = { Id = "Scramble40", Kills = 40, Reward = r7 }
local r26 = table.freeze(Kills_13)
local Kills_14 = { Id = "Scramble45", Kills = 45, Reward = r3 }
local r27 = table.freeze(Kills_14)
local Kills_15 = { Id = "Scramble50", Kills = 50, Reward = r11 }
local r28 = table.freeze(Kills_15)
local Kills_16 = { Id = "Scramble57", Kills = 57, Reward = r5 }
_r18[1], _r18[2], _r18[3], _r18[4], _r18[5], _r18[6], _r18[7], _r18[8], _r18[9], _r18[10], _r18[11], _r18[12], _r18[13], _r18[14], _r18[15], _r18[16] = r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, (table.freeze(Kills_16))
local Kills_17 = { Id = "Scramble64", Kills = 64, Reward = r5 }
local r29 = table.freeze(Kills_17)
local Kills_18 = { Id = "Scramble70", Kills = 70, Reward = r6 }
local r30 = table.freeze(Kills_18)
local Kills_19 = { Id = "Scramble75", Kills = 75, Reward = r12 }
local r31 = table.freeze(Kills_19)
local Kills_20 = { Id = "Scramble82", Kills = 82, Reward = r3 }
local r32 = table.freeze(Kills_20)
local Kills_21 = { Id = "Scramble90", Kills = 90, Reward = r7 }
local r33 = table.freeze(Kills_21)
local Kills_22 = { Id = "Scramble100", Kills = 100, Reward = r13 }
_r18[17], _r18[18], _r18[19], _r18[20], _r18[21], _r18[22] = r29, r30, r31, r32, r33, table.freeze(Kills_22)
local r34 = table.freeze(_r18)
local function petConfig(v1) -- proto[0], line 85  -- upvalues: Assets
	local f2
	local v1_e = assert(Assets.Directory[v1], (("Unknown Scramble mastery egg %*"):format(v1)))
	f2 = not ((type(v1_e.Egg.Icon)) ~= "string")
	assert(f2, (("%* has no egg icon"):format(v1)))
	f2 = not ((type(v1_e.Egg.DisplayName)) ~= "string")
	assert(f2, (("%* has no egg name"):format(v1)))
	return v1_e
end
local function bannerSkin(v2) -- proto[1], line 92  -- upvalues: ScrambleTradeIn, EggSkins
	local _r1 = assert(ScrambleTradeIn.GetBannerEggSkin, (("Unknown Scramble banner %*"):format(v2)))
	return assert(EggSkins.Get, (("Scramble banner %* has no egg skin"):format(v2)))
end
local function validate(v3) -- proto[2], line 97  -- upvalues: Assets, ScrambleTradeIn, EggSkins
	local f3
	if v3.Kind == "Pet" then
		local v1_e = assert(Assets.Directory[v3.Category], (("Unknown Scramble mastery egg %*"):format(v3.Category)))
		f3 = not ((type(v1_e.Egg.Icon)) ~= "string")
		assert(f3, (("%* has no egg icon"):format(v3.Category)))
		f3 = not ((type(v1_e.Egg.DisplayName)) ~= "string")
		assert(f3, (("%* has no egg name"):format(v3.Category)))
		return
	end
	if v3.Kind == "Banner" then
		local _r2 = assert(ScrambleTradeIn.GetBannerEggSkin, (("Unknown Scramble banner %*"):format(v3.BannerId)))
		local _r3 = assert(EggSkins.Get, (("Scramble banner %* has no egg skin"):format(v3.BannerId)))
		return
	end
	for _k4, _v5 in ipairs(ScrambleTradeIn.BannerIds) do
		local _r6 = assert(ScrambleTradeIn.GetBannerEggSkin, (("Unknown Scramble banner %*"):format(_v5)))
		local _r7 = assert(EggSkins.Get, (("Scramble banner %* has no egg skin"):format(_v5)))
	end
end
local function rollBannerId(v4) -- proto[3], line 110  -- upvalues: ScrambleTradeIn
	local f2
	local r35
	for _k5, _v6 in ipairs(ScrambleTradeIn.BannerIds) do
		local v_u1 = _v6
		r35 = math.max(ScrambleTradeIn.GetBannerWeight, 0)
	end
	f2 = not (0 >= (0 + r35))
	assert(f2, "Scramble banners have no weight")
	local w1 = (v4.NextNumber * (0 + r35))
	for _k7, _v8 in ipairs(ScrambleTradeIn.BannerIds) do
		if 0 >= ScrambleTradeIn.GetBannerWeight then continue end
		if (w1 - ScrambleTradeIn.GetBannerWeight) <= 0 then return _v8 end
	end
	return _v8
end
local function Roll(v5, v6) -- proto[4], line 143  -- upvalues: rollBannerId, ScrambleTradeIn
	local Category
	if v5.Kind == "Pet" then
		Category = {}
		Category.Category = v5.Category
		Category.Scale = v5.Scale
		return Category
	end
	local Category_2 = { Category = (assert(ScrambleTradeIn.RollPet, (("Scramble banner %* has no pets"):format(rollBannerId)))), Mutation = nil, EggSkin = ScrambleTradeIn.GetBannerEggSkin }
	return Category_2
end
r1 = r34
local function GetMilestone(v7) -- proto[5], line 156  -- upvalues: r1
	for _k4, _v5 in ipairs(r1) do
		if _v5.Id == v7 then return _v5 end
	end
	return nil
end
local function FinalMilestone() -- proto[6], line 165  -- upvalues: r1
	return r1[(#r1)]
end
local Milestones = { Milestones = r34, InfiniteMilestoneId = "ScrambleInfinite", InfiniteEveryKills = 10, InfiniteReward = r8, BossDropEgg = r1, Roll = Roll, GetMilestone = GetMilestone, FinalMilestone = FinalMilestone }
local s1 = Milestones
function Milestones.ClaimableInfiniteCount(v8) -- proto[7], line 169  -- upvalues: s1
	if not (v8.ClaimedMilestoneIds[s1.FinalMilestone.Id]) then return 0 end
	local r35 = math.max(v8.ClaimedMilestoneIds, 0)
	local v_u2 = v8.InfiniteRewardsClaimed
	local w2 = (r35 - v_u2)
	return (math.max(w2, 0))
end
function Milestones.Presentation(v9) -- proto[8], line 178  -- upvalues: Assets, ScrambleTradeIn, EggSkins
	local f3
	local Title
	local r36
	local _r4
	local r37
	local _r3
	if v9.Kind == "Pet" then
		local v_u3 = Assets.Directory[v9.Category]
		_r3 = assert(v_u3, (("Unknown Scramble mastery egg %*"):format(v9.Category)))
		f3 = not ((type(_r3.Egg.Icon)) ~= "string")
		assert(f3, (("%* has no egg icon"):format(v9.Category)))
		f3 = not ((type(_r3.Egg.DisplayName)) ~= "string")
		assert(f3, (("%* has no egg name"):format(v9.Category)))
		Title = { Title = _r3.DisplayName, Rarity = _r3.Rarity.DisplayName, Icon = _r3.Icon, Amount = "x1" }
		return Title
	end
	if v9.Kind == "Banner" then
		r36 = v9.BannerId
		local _r3_2 = assert(ScrambleTradeIn.GetBannerEggSkin, (("Unknown Scramble banner %*"):format(r36)))
		local v_u4 = r36
		_r4 = assert(EggSkins.Get, (("Scramble banner %* has no egg skin"):format(v_u4)))
		if v9.Mutated then
			r36 = ("Scrambled %*"):format(_r4.DisplayName)
		else
			r36 = _r4.DisplayName
		end
		if v9.Mutated then
			local r38 = ("Awards a random %* pet with the Scrambled mutation"):format(_r4.DisplayName)
		else
			r37 = ("Awards a random %* pet"):format(_r4.DisplayName)
		end
		local Title_2 = { Title = r36, Icon = _r4.Icon, Amount = "x1", HoverTitle = string.upper, HoverDescription = r37 }
		return Title_2
	end
	local _r1 = {}
	local ScrambleTradeIn_2 = ScrambleTradeIn.BannerIds
	for _k5, _v6 in ipairs(ScrambleTradeIn_2) do
		local _r10 = assert(ScrambleTradeIn.GetBannerEggSkin, (("Unknown Scramble banner %*"):format(_v6)))
		table.insert(_r1, (assert(EggSkins.Get, (("Scramble banner %* has no egg skin"):format(_v6)))).Icon)
	end
	local Title_3 = { Title = "Random Egg", Icon = _r1[1], CycleIcons = _r1, Amount = "x1", HoverTitle = string.upper, HoverDescription = "Awards a random lab egg" }
	return Title_3
end
for _k26, _v27 in ipairs(r34) do
	validate(_v27.Reward)
end
validate(Milestones.InfiniteReward)
local v1_e = assert(Assets.Directory[Milestones.BossDropEgg.Category], (("Unknown Scramble mastery egg %*"):format(Milestones.BossDropEgg.Category)))
f1 = not ((type(v1_e.Egg.Icon)) ~= "string")
assert(f1, (("%* has no egg icon"):format(Milestones.BossDropEgg.Category)))
f1 = not ((type(v1_e.Egg.DisplayName)) ~= "string")
assert(f1, (("%* has no egg name"):format(Milestones.BossDropEgg.Category)))
return table.freeze(Milestones)