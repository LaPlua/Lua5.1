-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.Products
-- ============================================

-- bytecode
-- Original size: 14120 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 197, Protos: 32, Main proto: 31

-- ============== SOURCE ==============
local function refuse() -- proto[4], line 98
	return false, "DNA stealing is no longer available."
end
local r1
local r2
local r3
local r4
local r5
-- main chunk (proto[31], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local CashPacks = require(ReplicatedStorage.Data.CashPacks)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GameplayBalance = require(ReplicatedStorage.Shared.Flags.GameplayBalance)
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local GeneratedProducts = require(script.Internal.GeneratedProducts)
local LimitedEgg = require(ReplicatedStorage.Data.LimitedEgg)
local MarketplaceValidator = require(script.Internal.MarketplaceValidator)
local ProductTypes = require(script.Internal.ProductTypes)
local Sakura = require(ReplicatedStorage.Data.Sakura)
local t = require(ReplicatedStorage.Packages.t)
local BillboardReward = require(script.Builders.BillboardReward)
local TreadmillAdEggBoost = require(script.Builders.TreadmillAdEggBoost)
local CashPack = require(script.Builders.CashPack)
local EggSkipGrowth = require(script.Builders.EggSkipGrowth)
local LimitedEgg_2 = require(script.Builders.LimitedEgg)
local Money = require(script.Builders.Money)
local RiftRefresh = require(script.Builders.RiftRefresh)
local SamplePack = require(script.Builders.SamplePack)
local SamplePacks = require(ReplicatedStorage.Data.SamplePacks)
local ServerLuck = require(script.Builders.ServerLuck)
local ServerLuckExtension = require(script.Builders.ServerLuckExtension)
local SpeedBoost = require(script.Builders.SpeedBoost)
local SpeedPower = require(script.Builders.SpeedPower)
local TemporarySpeedBoost = require(script.Builders.TemporarySpeedBoost)
local s1 = {}
local s2 = {}
local function enlist(v1) -- proto[0], line 57  -- upvalues: t, s1, s2
	local w1 = v1.Name
	if s1[v1.Name] ~= nil then
		local r6 = ("product \"%*\" is listed twice"):format(v1.Name)
	end
	if s2[(v1 ^ "Name").ProductId] ~= nil then
		local r1 = ("\"%*\" reuses ProductId %* of \"%*\""):format(w1, (v1 ^ "Name").ProductId, s2[(v1 ^ "Name").ProductId].Name)
	end
	s1[w1] = (v1 ^ "Name")
	s2[(v1 ^ "Name").ProductId] = (v1 ^ "Name")
end
local function requirePlayer(v2) -- proto[1], line 74  -- upvalues: t
	local r7 = t.strict(t.instanceIsA("Player"))
end
local function clientProfileLoaded() -- proto[2], line 78  -- upvalues: ReplicatedStorage
	if require.Await == nil then return false, "Data not loaded" end
	return true
end
local function creditWhenLoaded(v3, v4, v5) -- proto[3], line 86  -- upvalues: ServerScriptService
	if not require.IsPlayerLoaded then return "Retry" end
	return "Credit"
end
local function retiredDnaProduct(v6, v7) -- proto[5], line 97
	-- refuse captures:
	local Name = { Name = v6, ProductId = v7, DisplayName = v6, Desc = "DNA stealing is no longer available.", Silent = true, Precheck = refuse, Authorize = refuse, Grant = refuse }
	return Name
end
local function growAllEggsProduct(v8) -- proto[10], line 114  -- upvalues: ServerScriptService, t, ReplicatedStorage, creditWhenLoaded
	local function eggs() -- proto[6], line 115  -- upvalues: ServerScriptService
		return require
	end
	local function Grant(v9) -- proto[7], line 126  -- upvalues: t, ServerScriptService
		local r7 = t.strict(t.instanceIsA("Player"))
		return require.PurchaseGrowAll(v9)
	end
	local function Precheck() -- proto[8], line 130  -- upvalues: ReplicatedStorage
		return require.MayBuyGrowAll()
	end
	local function Authorize(v10) -- proto[9], line 134  -- upvalues: t, ServerScriptService
		local r7 = t.strict(t.instanceIsA("Player"))
		return require.CanPurchaseGrowAll(v10)
	end
	local Name = { Name = v8, DisplayName = "Grow All Eggs", Desc = "Finish growing all placed eggs.", ProductId = 3611613592, HoldWhilePending = true, Silent = true, Grant = Grant, Precheck = Precheck, Authorize = Authorize, ResolveFailedReceipt = creditWhenLoaded }
	return Name
end
local function earningsBoostProduct(v11) -- proto[14], line 142  -- upvalues: ReplicatedStorage, ServerScriptService, t, clientProfileLoaded, creditWhenLoaded
	local function boostService() -- proto[11], line 148  -- upvalues: ServerScriptService
		return require(ServerScriptService.Controllers.EarningsBoostService)
	end
	local function Grant(v12) -- proto[12], line 158  -- upvalues: t, ServerScriptService
		local r7 = t.strict(t.instanceIsA("Player"))
		return require.Activate(v12)
	end
	local function Authorize(v13) -- proto[13], line 163  -- upvalues: t, ServerScriptService
		local r7 = t.strict(t.instanceIsA("Player"))
		return require.CanActivate(v13)
	end
	local Name = { Name = v11, DisplayName = (("x%* Earnings (%*m)"):format(require.GetConfiguredMultiplier, (require.DURATION_SECONDS / 60))), Desc = (("Your pets earn %*x cash for %* minutes."):format(require.GetConfiguredMultiplier, (require.DURATION_SECONDS / 60))), ProductId = 3709963353, HoldWhilePending = true, Grant = Grant, Precheck = clientProfileLoaded, Authorize = Authorize, ResolveFailedReceipt = creditWhenLoaded }
	return Name
end
local function sakuraLuckBoostProduct(v14, v15, v16) -- proto[21], line 171  -- upvalues: GameFlags, ServerScriptService, Sakura, t, ReplicatedStorage
	local function bloomActive() -- proto[15], line 176  -- upvalues: GameFlags
		local f1 = not (GameFlags.GreatBloomEnabled.Get ~= true)
		return f1
	end
	local function sakuraService() -- proto[16], line 180  -- upvalues: ServerScriptService
		return require(ServerScriptService.Controllers.SakuraService)
	end
	local function Grant(v17) -- proto[17], line 190  -- upvalues: t, ServerScriptService, v16
		local r7 = t.strict(t.instanceIsA("Player"))
		return require.ActivateLuckBoost(v17, v16)
	end
	local function Precheck() -- proto[18], line 194  -- upvalues: GameFlags, ReplicatedStorage, Sakura, v16
		if GameFlags.GreatBloomEnabled.Get ~= true then return false, "The Great Bloom has ended" end
		if require.Await ~= nil then return Sakura.CanBuyLuckBoost(require.Await.Sakura, v16) end
		return false, "Data not loaded"
	end
	local function Authorize(v18) -- proto[19], line 205  -- upvalues: t, GameFlags, ServerScriptService, v16
		local r7 = t.strict(t.instanceIsA("Player"))
		if GameFlags.GreatBloomEnabled.Get ~= true then return false, "The Great Bloom has ended" end
		return require.CanActivateLuckBoost(v18, v16)
	end
	local arg1_upvalue = v15
	local function ResolveFailedReceipt(v19, v20, v21) -- proto[20], line 212  -- upvalues: GameFlags, ServerScriptService, arg1_upvalue
		if GameFlags.GreatBloomEnabled.Get == true then
			if not require.IsPlayerLoaded then return "Retry" end
			return "Credit"
		end
		local ProductId = { ProductId = arg1_upvalue, Reason = (v21 or "Unknown") }
		return "Satisfied"
	end
	local Name = { Name = v14, DisplayName = (("Sakura Luck Boost %*"):format(v16)), Desc = (("%*x Great Bloom odds for the egg inside the incubator (%*/%*)."):format(Sakura.GetLuckMultiplier, v16, Sakura.Incubator.MaxLuckBoosts)), ProductId = v15, HoldWhilePending = true, Grant = Grant, Precheck = Precheck, Authorize = Authorize, ResolveFailedReceipt = ResolveFailedReceipt }
	return Name
end
enlist((growAllEggsProduct("EggGrowAll")))
enlist((earningsBoostProduct("EarningsBoost2x")))
enlist(RiftRefresh("RiftRefresh", 3710888247))
for _k39, _v40 in ipairs(SamplePacks.Offers) do
	enlist(SamplePack((("SamplePack%*"):format(_k39)), _v40.ProductId))
end
local ProductId = { ProductId = 3611606887, Minutes = 15 }
for _k40, _v41 in ipairs({ProductId, { ProductId = 3611606895, Minutes = 30 }, { ProductId = 3611606898, Minutes = 60 }, { ProductId = 3611606901, Minutes = 120 }, { ProductId = 3611606906, Minutes = 180 }, { ProductId = 3611606912, Minutes = 240 }, { ProductId = 3611606918, Minutes = 360 }, { ProductId = 3611606926, Minutes = 480 }, { ProductId = 3611606930, Minutes = 600 }, { ProductId = 3611606938, Minutes = 720 }}) do
	r1 = ("Instant Hatch (%*)"):format(_k40)
	enlist(EggSkipGrowth(r1, _v41.ProductId, (_v41.Minutes * 60)))
end
local _r37 = {}
local Config = { Config = LimitedEgg.Luminous, Name = "Limited Egg", Count = 1, ProductId = 3712476038 }
local Config_2 = { Config = LimitedEgg.Luminous, Name = "Limited Egg x3", Count = 3, ProductId = 3712476039 }
local Config_3 = { Config = LimitedEgg.Luminous, Name = "Limited Egg x10", Count = 10, ProductId = 3712476044 }
local w2 = EggSkipGrowth(r1, _v41.ProductId, (_v41.Minutes * 60))
local Config_4 = { Config = LimitedEgg.Luminous, Name = "Limited Egg x50", Count = 50, ProductId = 3712476050 }
local Config_5 = { Config = LimitedEgg.Extinction, Name = "Extinction Egg", Count = 1, ProductId = 3714749344 }
local Config_6 = { Config = LimitedEgg.Extinction, Name = "Extinction Egg x3", Count = 3, ProductId = 3714749375 }
local Config_7 = { Config = LimitedEgg.Extinction, Name = "Extinction Egg x10", Count = 10, ProductId = 3714749397 }
local Config_8 = { Config = LimitedEgg.Extinction, Name = "Extinction Egg x50", Count = 50, ProductId = 3714749414 }
_r37[1], _r37[2], _r37[3], _r37[4], _r37[5], _r37[6], _r37[7], _r37[8] = Config, Config_2, Config_3, Config_4, Config_5, Config_6, Config_7, Config_8
for _k41, _v42 in ipairs(_r37) do
	enlist(LimitedEgg_2(_v42.Name, _v42.ProductId, _v42.Count, _v42.Config))
end
local Amount = { Amount = 24000, ProductId = 3611606487 }
for _k42, _v43 in ipairs({Amount, { Amount = 200000, ProductId = 3611606470 }, { Amount = 800000, ProductId = 3611606501 }, { Amount = 4000000, ProductId = 3611606493 }, { Amount = 8000000, ProductId = 3611606507 }}) do
	enlist(Money((("Money_%*"):format(_v43.Amount)), _v43.ProductId))
end
for _k42, _v43 in ipairs(CashPacks.Offers) do
	enlist(CashPack(_v43.Name, _v43.ProductId))
end
for _k43, _v44 in ipairs({3709207454, 3709207509, 3709207563}) do
	enlist((sakuraLuckBoostProduct((("SakuraLuckBoost%*"):format(_k43)), _v44, _k43)))
end
local Multiplier = { Multiplier = 2, ProductId = 3604958187 }
for _k44, _v45 in ipairs({Multiplier, { Multiplier = 4, ProductId = 3604958083 }, { Multiplier = 8, ProductId = 3604957992 }}) do
	r2 = ("ServerLuck_X%*"):format(_v45.Multiplier)
	enlist(ServerLuck(r2, _v45.ProductId, _v45.Multiplier))
end
local Minutes = { Minutes = 15, ProductId = 3604958348 }
for _k45, _v46 in ipairs({Minutes, { Minutes = 30, ProductId = 3604958272 }}) do
	local w3 = ServerLuck(r2, _v45.ProductId, _v45.Multiplier)
	r3 = ("ServerLuck_Extend%*"):format(_v46.Minutes)
	enlist(ServerLuckExtension(r3, _v46.ProductId, _v46.Minutes))
end
local w4 = ServerLuckExtension(r3, _v46.ProductId, _v46.Minutes)
for _k46, _v47 in ipairs({3611606570, 3611606611, 3611606618, 3611606628, 3611606636, 3611606645, 3611606648, 3611606653, 3611606661, 3611606588, 3611606597, 3611606604}) do
	r4 = ("SpeedBoostTier%*"):format(_k46)
	enlist(SpeedBoost(r4, _v47, _k46, 3611606604))
end
local w5 = SpeedBoost(r4, _v47, _k46, 3611606604)
for _k47, _v48 in ipairs({{ Amount = 150000, ProductId = 3611606545 }, { Amount = 1000000, ProductId = 3611606516 }, { Amount = 10000000, ProductId = 3611606528 }, { Amount = 50000000, ProductId = 3611606552 }, { Amount = 500000000, ProductId = 3611606562 }, { Amount = 1000000000, ProductId = 3611606539 }}) do
	r5 = ("SpeedPower_%*"):format(_v48.Amount)
	enlist(SpeedPower(r5, _v48.ProductId))
end
local Rarity = { Rarity = "Common", ProductId = 3611606824 }
local w6 = SpeedPower(r5, _v48.ProductId)
for _k48, _v49 in ipairs({Rarity, { Rarity = "Uncommon", ProductId = 3611606832 }, { Rarity = "Rare", ProductId = 3611606840 }, { Rarity = "Epic", ProductId = 3611606843 }, { Rarity = "Legendary", ProductId = 3611606849 }, { Rarity = "Mythic", ProductId = 3611606854 }, { Rarity = "Cosmic", ProductId = 3611606859 }, { Rarity = "Secret", ProductId = 3611606864 }, { Rarity = "Eternal", ProductId = 3611606875 }, { Rarity = "Divine", ProductId = 3611606880 }}) do
	enlist((retiredDnaProduct((("Steal%*"):format(_v49.Rarity)), _v49.ProductId)))
end
local Label = { Label = "10Minutes", Seconds = 600, ProductId = 3608561503 }
for _k49, _v50 in ipairs({Label, { Label = "30Minutes", Seconds = 1800, ProductId = 3608561464 }, { Label = "1Hour", Seconds = 3600, ProductId = 3608561433 }}) do
	enlist(TemporarySpeedBoost((("TemporarySpeedBoost_%*"):format(_v50.Label)), _v50.ProductId, _v50.Seconds))
end
local Variant = { Variant = "Alt1", Control = 3711307995, Double = 3711308134, Quadruple = 3711308259 }
for _k50, _v51 in ipairs({Variant, { Variant = "Alt2", Control = 3711039542, Double = 3711036110, Quadruple = 3711036196 }, { Variant = "Default", Control = 3711313393, Double = 3711313465, Quadruple = 3711313519 }}) do
	local Control = {}
	Control.Control = _v51.Control
	Control["2x"] = _v51.Double
	Control["4x"] = _v51.Quadruple
	for _k56, _v57 in ipairs(Control) do
		enlist(BillboardReward((("RVBillboard_%*_%*"):format(_v51.Variant, _k56)), _v57))
	end
end
local Name = { Name = "TreadmillAdEggBoost", ProductId = 3714369091 }
for _k51, _v52 in ipairs({Name, { Name = "TreadmillAdEggBoost_DEV", ProductId = 3714368905 }, { Name = "TreadmillAdEggBoost_DEV2", ProductId = 3590880144 }}) do
	local v_u1 = _v52.Name
	local v_u2 = _v52.ProductId
	enlist(TreadmillAdEggBoost(v_u1, v_u2))
end
for _k51, _v52 in ipairs(GeneratedProducts.Records) do
	enlist(_v52)
end
if Constants.IS_STUDIO then
	local s3 = {}
	for _v52 in ipairs(s1) do
		table.insert(s3, _k52)
	end
	table.sort(s3)
	task.spawn(function()
		for _k3, _v4 in ipairs(s3) do
		end
	end)
end
table.freeze(s1)
table.freeze(s2)
local function ladder(self) -- proto[24], line 437  -- upvalues: s1
	local _r1 = {}
	for _k5, _v6 in ipairs(s1) do
		local v_u3 = _v6
		if self == nil then continue end
		table.insert(_r1, _v6)
	end
	return table.freeze(_r1)
end
local r8 = ladder(function(v24)
	return v24.EggSkipGrowthMaxRemainingSeconds
end)
local r9 = ladder(function(v25)
	return v25.SpeedPowerReward
end)
local function FromProductId(v26) -- proto[27], line 462  -- upvalues: s2
	return s2[v26]
end
local function ProductNameExists(v27) -- proto[28], line 466  -- upvalues: s1
	if (rawget(s1, v27)) ~= nil then return true end
	return false, (("no product is registered under \"%*\""):format(v27))
end
GameplayBalance = GameplayBalance.EggProducts
local function GetEggSkipGrowthProduct(v28) -- proto[29], line 473  -- upvalues: GameplayBalance, r8
	local f2 = false  -- skip 1
	f2 = true
	assert(f2, "remaining seconds cannot be negative")
	if v28 <= GameplayBalance.MIN_SKIP_SECONDS then return nil end
	for _k4, _v5 in ipairs(r8) do
		if v28 <= _v5.EggSkipGrowthMaxRemainingSeconds then return _v5 end
	end
	local w7 = r8[(#r8)]
	return assert(w7, "no egg skip-growth product is registered")
end
r8 = r9
local function SmallestSufficientSpeedPowerProduct(v29) -- proto[30], line 494  -- upvalues: t, r8
	for _k4, _v5 in ipairs(r8) do
		if v29 <= _v5.SpeedPowerReward then return _v5 end
	end
	local w7 = r8[(#r8)]
	return assert(w7, "no speed-power product is registered")
end
local Directory = { Directory = s1, TreadmillSpeedEquivalentOffers = GeneratedProducts.TreadmillSpeedEquivalentOffers, FromProductId = FromProductId, ProductNameExists = ProductNameExists, GetEggSkipGrowthProduct = GetEggSkipGrowthProduct, SmallestSufficientSpeedPowerProduct = SmallestSufficientSpeedPowerProduct }
return Directory