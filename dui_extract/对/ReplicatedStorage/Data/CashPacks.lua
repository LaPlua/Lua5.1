-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.CashPacks
-- ============================================

-- bytecode
-- Original size: 3375 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 67, Protos: 9, Main proto: 8

-- ============== SOURCE ==============
-- main chunk (proto[8], line 1)
local s1 = {1, 1.2, 1.5, 2, 2.5, 3, 4, 5, 6, 8, 10}
local function RoundNice(v1) -- proto[0], line 76  -- upvalues: s1
	local f1
	if v1 <= 0 then return 0 end
	f1 = not (v1 >= inf)
	assert(f1, "Cash pack amount must be finite")
	local r1 = math.floor((math.log10(v1)))
	local w1 = (v1 / assert)
	for _k8, _v9 in ipairs(s1) do
		if (math.abs(((math.log10(_v9)) - (math.log10(w1))))) >= inf then continue end
		r1 = _v9
	end
	return (r1 * assert)
end
local TestName = { TestName = "ScaledCashPacks", AttributeKey = "Economy.CashPacks.Group", GroupAttribute = "CashPackGroup", ReadyAttribute = "CashPacksReady", RevisionAttribute = "CashPackQuoteRevision", AmountAttributePrefix = "CashPackAmount", Offers = {{ Name = "CashPack1", FixedProductName = "Money_24000", ProductId = 3714500805, DisplayName = "Cash Pack I", Minutes = 40, Floor = 24000 }, { Name = "CashPack2", FixedProductName = "Money_200000", ProductId = 3714500817, DisplayName = "Cash Pack II", Minutes = 120, Floor = 200000 }, { Name = "CashPack3", FixedProductName = "Money_800000", ProductId = 3714500825, DisplayName = "Cash Pack III", Minutes = 360, Floor = 800000 }, { Name = "CashPack4", FixedProductName = "Money_4000000", ProductId = 3714500832, DisplayName = "Cash Pack IV", Minutes = 1080, Floor = 4000000 }, { Name = "CashPack5", FixedProductName = "Money_8000000", ProductId = 3714500837, DisplayName = "Cash Pack V", Minutes = 2880, Floor = 8000000 }}, RoundNice = RoundNice }
local s2 = TestName
function TestName.Amount(v2, v3) -- proto[1], line 94  -- upvalues: s2
	return (math.max(v2.Floor, s2.RoundNice(((v2.Minutes * 60) * v3))))
end
function TestName.RefreshQuote(v4, v5) -- proto[2], line 101  -- upvalues: s2
	if v5.Day <= v4.Day then return v4 end
	table.clone.Day = v5.Day
	local f2 = false  -- skip 1
	f2 = true
	if (#(v4 ^ "Day").Amounts) > 0 then
		if not f2 then return table.clone end
	end
	table.clone.PeakBaseRate = (math.max((v4 ^ "Day").PeakBaseRate, v5.PeakBaseRate))
	table.clone.Amounts = _r4
	for _k7, _v8 in {} do
		table.clone.Amounts[_k7] = (math.max(((v4 ^ "Day").Amounts[_k7] or 0), s2.Amount(_v8, table.clone.PeakBaseRate)))
	end
	return table.clone
end
function TestName.FindSlot(v6) -- proto[3], line 123  -- upvalues: s2
	for _k4, _v5 in ipairs(s2.Offers) do
		if _v5.ProductId == v6 then return _k4 end
	end
	return nil
end
function TestName.NormalizeGroup(v7) -- proto[4], line 132
	if v7 == "VariantA" then return v7 end
	if v7 ~= "VariantB" then return "Control" end
	return v7
end
local f3
function TestName.GetCanBuyProduct(v8, v9) -- proto[5], line 138
	local f2
	local f1 = not ((string.sub(v9, 1, 10)) ~= "Treadmill_")
	f2 = not ((string.sub(v9, 1, 6)) ~= "Trail_")
	if not (f1) then
		if not (f2) then return true end
		if v8 == nil then return false end
		if v8 ~= "VariantB" then return f3 end
		if v9 == "Treadmill_AstralTreadmill" then return f3 end
		if v9 ~= "Trail_MoonbloomTrail" then
			f3 = false  -- skip 1
		end
	end
	f3 = true
	return f3
end
function TestName.GetPlayerGroup(v10) -- proto[6], line 152  -- upvalues: s2
	if v10.GetAttribute == true then return s2.NormalizeGroup(v10:GetAttribute(s2.GroupAttribute)) end
	return nil
end
function TestName.GetShownAmount(v11, v12) -- proto[7], line 161  -- upvalues: s2
	if v11.GetAttribute ~= true then return nil end
	if (type(v11.GetAttribute)) ~= "number" then return nil end
	local w1 = v11.GetAttribute
	return w1
end
return TestName