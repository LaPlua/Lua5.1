-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.LimitedEgg
-- ============================================

-- bytecode
-- Original size: 5780 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 96, Protos: 11, Main proto: 10

-- ============== SOURCE ==============
-- main chunk (proto[10], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local BalanceConfig = require(ReplicatedStorage.Shared.Flags.BalanceConfig)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Interface = require(script.Types.Interface)
local t = require(ReplicatedStorage.Packages.t)
local _r7 = {1, 3, 10, 50}
local AssetId = { AssetId = "Spike", Weight = 39 }
local AssetId_2 = { AssetId = "Manta Ray", Weight = 24 }
local AssetId_3 = { AssetId = "Megalodon", Weight = 18 }
local AssetId_4 = { AssetId = "Electric Eel", Weight = 11 }
local AssetId_5 = { AssetId = "Terra Snapper", Weight = 6.5 }
local AssetId_6 = { AssetId = "Cthulhu", Weight = 0.5 }
local DisplayName = { DisplayName = "Luminous Egg", RerollName = "Luminous Re-roll", EndsAt = Constants.UPDATE_LIVE_AT, BalanceKey = "Game.Balance.LimitedEgg", ProductName = "Limited Egg", MechaPrefix = "Depths ", BaseOdds = (table.freeze(({table.freeze(AssetId), table.freeze(AssetId_2), table.freeze(AssetId_3), table.freeze(AssetId_4), table.freeze(AssetId_5), table.freeze(AssetId_6)}))) }
local AssetId_7 = { AssetId = "Glyptodon", Weight = 39 }
local AssetId_8 = { AssetId = "Terrorbird", Weight = 24 }
local AssetId_9 = { AssetId = "Megatherium", Weight = 18 }
local AssetId_10 = { AssetId = "Dunkleosteus", Weight = 11 }
local AssetId_11 = { AssetId = "Gigantopithecus", Weight = 6.5 }
local AssetId_12 = { AssetId = "Sabertooth", Weight = 0.5 }
local DisplayName_2 = { DisplayName = "Extinction Egg", RerollName = "Skeletal Re-roll", EndsAt = 1791644400, BalanceKey = "Game.Balance.ExtinctionEgg", ProductName = "Extinction Egg", MechaPrefix = "Skeletal ", BaseOdds = (table.freeze(({table.freeze(AssetId_7), table.freeze(AssetId_8), table.freeze(AssetId_9), table.freeze(AssetId_10), table.freeze(AssetId_11), table.freeze(AssetId_12)}))) }
local function weightedRow(v1) -- proto[0], line 69
	if (type(v1)) ~= "table" then return false, "expected { assetName, positiveWeight }" end
	if (type(v1[1])) ~= "string" then return false, "expected { assetName, positiveWeight }" end
	if (type(v1[2])) ~= "number" then return false, "expected { assetName, positiveWeight }" end
	if v1[2] > 0 then return true end
	return false, "expected { assetName, positiveWeight }"
end
local r1 = t.array(weightedRow)
local r2 = t.intersection(t.numberPositive, t.numberMax(1))
local DropTable = {}
DropTable.DropTable = r1
local Chance = { Chance = (t.numberMax(1)), DisplayChance = (t.numberMax(1)), DropTable = r1 }
DropTable.MechaReroll = (t.interface(Chance))
local Amount = {}
Amount.Amount = (t.intersection(t.integer, t.numberMin(1)))
DropTable.Offers = (t.array(t.interface(Amount)))
local r3 = t.interface(DropTable)
local function toRows(v2) -- proto[1], line 90
	for _k5, _v6 in ipairs(v2) do
		local _r8 = {_v6.AssetId, _v6.Weight}
		table.create[_k5] = table.freeze
	end
	return table.freeze(table.create)
end
local function toEntries(v3) -- proto[2], line 98
	local f1
	for _k5, _v6 in ipairs(v3) do
		f1 = not ((type(_v6)) == "table")
		if not (f1) then
			local r4 = ("limited egg drop row %*: %*"):format(_k5, nil)
		end
		local AssetId = { AssetId = _v6[1], Weight = _v6[2] }
		table.create[_k5] = table.freeze
	end
	return table.freeze(table.create)
end
local function prefixed(v4, v5) -- proto[3], line 110
	for _k6, _v7 in ipairs(v4) do
		local AssetId = {}
		AssetId.AssetId = v5 .. _v7.AssetId
		AssetId.Weight = _v7.Weight
		table.create[_k6] = table.freeze
	end
	return table.freeze(table.create)
end
local function offersFor(v6, v7) -- proto[4], line 118
	local r4
	for _k6, _v7 in ipairs(v6) do
		if not ((_v7 <= 1)) then
			r4 = ("%* x%*"):format(v7, _v7)
		end
		local Amount = { Amount = _v7, ProductName = r4 }
		table.create[_k6] = table.freeze
	end
	return table.freeze(table.create)
end
local r5 = RunService:IsStudio()
assert(r2(0.01))
local toEntries = _r7
local index = 0.01
ReplicatedStorage = r3
local function bind(self) -- proto[7], line 134  -- upvalues: prefixed, offersFor, U2, toRows, index, ReplicatedStorage, BalanceConfig, toEntries
	local f2
	f2 = not ((#self.BaseOdds) > 6)
	assert(f2, (("the limited egg shop expects %* drop rows"):format(6)))
	local DisplayName = { DisplayName = nil, RerollName = nil, InfoText = "Pets can have different <font color=\"#55FF77\"><b>sizes</b></font>, <font color=\"#55FF77\"><b>colors</b></font> and <font color=\"#55FF77\"><b>mutations</b></font>. Huge pets and pets with rare mutations earn <font color=\"#1AFF00\"><b>way more money</b></font>!", EndsAt = nil, Offers = nil, DropTable = nil, Entries = nil, MechaReroll = nil }
	DisplayName.DisplayName = self.DisplayName
	DisplayName.RerollName = self.RerollName
	DisplayName.EndsAt = self.EndsAt
	DisplayName.Offers = offersFor
	DisplayName.DropTable = toRows
	DisplayName.Entries = self.BaseOdds
	local Chance = { Chance = index, DisplayChance = 0.01, DropTable = toRows, Entries = prefixed }
	DisplayName.MechaReroll = table.freeze
	local self = (self ^ "BaseOdds")
	local function checkOverrides(v8) -- proto[5], line 154  -- upvalues: ReplicatedStorage, self
		if ReplicatedStorage then return end
		local r4 = ("%* override rejected: %*"):format(self.BalanceKey, v8)
	end
	local DropTable = { DropTable = true, MechaReroll = nil, Offers = true }
	local Chance_2 = { Chance = true, DisplayChance = true, DropTable = true }
	DropTable.MechaReroll = Chance_2
	local Bind = BalanceConfig.Bind
	local function rebuildEntries() -- proto[6], line 167  -- upvalues: Bind, toEntries
		Bind.Entries = toEntries
		if Bind.MechaReroll == nil then return end
		Bind.MechaReroll.Entries = toEntries
	end
	BalanceConfig.Bind.Entries = toEntries
	if BalanceConfig.Bind.MechaReroll ~= nil then
		BalanceConfig.Bind.MechaReroll.Entries = toEntries
	end
	return BalanceConfig.Bind
end
local r6 = bind(DisplayName)
r6 = (bind(DisplayName_2))
local r7 = r6
local function onSale() -- proto[8], line 183  -- upvalues: Workspace, Constants, r6, r7
	if Constants.UPDATE_LIVE_AT > Workspace.GetServerTimeNow then return r7 end
	return r6
end
local SwitchesAt = { SwitchesAt = Constants.UPDATE_LIVE_AT, Luminous = r6, Extinction = r7 }
local _index = {}
function _index.__index(v9, v10) -- proto[9], line 199  -- upvalues: Workspace, Constants, r6, r7
	if Constants.UPDATE_LIVE_AT > Workspace.GetServerTimeNow then return r7[v10] end
	return r7[v10]
end
local object = setmetatable(SwitchesAt, _index)
return object