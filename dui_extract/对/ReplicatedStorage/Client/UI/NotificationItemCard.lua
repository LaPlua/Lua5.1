-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.NotificationItemCard
-- ============================================

-- bytecode
-- Original size: 3133 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 71, Protos: 9, Main proto: 8

-- ============== SOURCE ==============
-- main chunk (proto[8], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HoverCard = require(ReplicatedStorage.Client.HoverCard)
local NotificationItem = require(ReplicatedStorage.Shared.NotificationItem)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Sparkles = require(ReplicatedStorage.Client.UI.VFX.Sparkles)
local s1 = {"Level", "Strength"}
local Build = {}
local function child(v1, v2) -- proto[0], line 25
	local v_u1 = v2
	local w1 = v1.FindFirstChild
	local w2 = v1.GetFullName
	assert(w1, (("%* is missing %*"):format(w2, v2)))
	return w1
end
local function countText(v3) -- proto[1], line 31  -- upvalues: Simple
	return (("%*x"):format(Simple.FormatCompact))
end
local function byPriority(v4, v5) -- proto[2], line 35
	local f1 = not (v4.Priority >= v5.Priority)
	return f1
end
local function describeItem(v6) -- proto[3], line 39  -- upvalues: byPriority
	local f2 = not (v6.Description == "")
	local _r2 = {}
	local kind = { kind = "body", text = v6.Description }
	local Priority = { Priority = 40, When = f2, Row = kind }
	local kind_2 = { kind = "tier", rarity = v6.Rarity }
	local Priority_2 = { Priority = 20, When = true, Row = kind_2 }
	local kind_3 = { kind = "heading", text = v6.Name }
	local Priority_3 = { Priority = 10, When = true, Row = kind_3 }
	local Priority_4 = { Priority = 30, When = f2, Row = { kind = "rule" } }
	_r2[1], _r2[2], _r2[3], _r2[4] = Priority, Priority_2, Priority_3, Priority_4
	local _r3 = {}
	for _k7, _v8 in ipairs(_r2) do
		if not _v8.When then continue end
		table.insert(_r3, _v8.Row)
	end
	return _r3
end
local function applyPresentation(v7, v8, v9, v10) -- proto[4], line 57  -- upvalues: Simple, s1
	local f3
	local r1 = ("%* is missing Icon"):format(v7.GetFullName)
	local w1 = v7.FindFirstChild
	local w2 = v7.FindFirstChild
	assert(w2, r1)
	local r2 = ("%* is missing Quantity"):format(v7.GetFullName)
	local w3 = v7.FindFirstChild
	local w4 = v7.FindFirstChild
	assert(w4, r2)
	w1.Image = v9.Icon
	w3.Text = ((("%*x"):format(Simple.FormatCompact)))
	f3 = not (v10.ShowCount == false)
	w3.Visible = f3
	for _k9, _v10 in ipairs(s1) do
		if not (v7 ^ "Icon").FindFirstChild then continue end
		if not ((v7 ^ "Icon").FindFirstChild).IsA then continue end
		(v7 ^ "Icon").FindFirstChild.Visible = false
	end
end
local function sparkleWhenPlaced(v11) -- proto[6], line 71  -- upvalues: Sparkles
	local function anon5() -- proto[5], line 72  -- upvalues: v11, Sparkles
		if v11.Parent == nil then return end
	end
end
function Build.Build(v12, v13) -- proto[7], line 79  -- upvalues: NotificationItem, applyPresentation, HoverCard, describeItem, Sparkles
	local v_u1 = v12
	assert(NotificationItem.Schema, "invalid notification item card")
	if 5 > NotificationItem.Describe.Rarity.Rank then return NotificationItem.Describe.Rarity.ItemTemplate.Clone end
	local v12 = NotificationItem.Describe.Rarity.ItemTemplate.Clone
	local function anon5() -- proto[5], line 72  -- upvalues: v12, Sparkles
		if v12.Parent == nil then return end
	end
	return NotificationItem.Describe.Rarity.ItemTemplate.Clone
end
return Build