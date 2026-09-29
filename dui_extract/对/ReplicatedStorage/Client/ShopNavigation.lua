-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.ShopNavigation
-- ============================================

-- bytecode
-- Original size: 5487 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 94, Protos: 12, Main proto: 11

-- ============== SOURCE ==============
-- main chunk (proto[11], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local GUI = require(ReplicatedStorage.Client.GUI)
local GUI_2 = require(ReplicatedStorage.Client.Types.GUI)
local Promise = require(ReplicatedStorage.Packages.Promise)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local r1 = GUI.Shop()
local r2 = Trove.new()
local r3 = r2:Extend()
local r4 = Color3.fromRGB(255, 230, 80)
local Featured = { Featured = r1.Frame.ScrollingFrame.FeaturedSectionTitle, Speed = r1.Frame.ScrollingFrame.SpeedSectionTitle, SpeedProducts = r1.Frame.ScrollingFrame.Speed, Money = r1.Frame.ScrollingFrame.Money }
local s1 = {}
local section = { section = "Featured", button = r1.Frame.ButtonsHolder.Featured, anchor = Featured.Featured, color = r1.Frame.ButtonsHolder.Featured.SectionTitle.TextColor3 }
local section_2 = { section = "Speed", button = r1.Frame.ButtonsHolder.Speed, anchor = Featured.Speed, color = r1.Frame.ButtonsHolder.Speed.SectionTitle.TextColor3 }
local section_3 = { section = "Money", button = r1.Frame.ButtonsHolder.Money, anchor = Featured.Money, color = r1.Frame.ButtonsHolder.Money.SectionTitle.TextColor3 }
s1[1], s1[2], s1[3] = section, section_2, section_3
ReplicatedStorage = r1.Frame.ScrollingFrame
local function maximumScroll() -- proto[0], line 60  -- upvalues: ReplicatedStorage
	return (math.max(0, (ReplicatedStorage.AbsoluteCanvasSize.Y - ReplicatedStorage.AbsoluteWindowSize.Y)))
end
local function updateSection() -- proto[1], line 67  -- upvalues: ReplicatedStorage, s1, r4
	local f1
	local f2
	if 0 < (math.max(0, (ReplicatedStorage.AbsoluteCanvasSize.Y - ReplicatedStorage.AbsoluteWindowSize.Y))) then
		f2 = false  -- skip 1
		f2 = true
	end
	for _k7, _v8 in ipairs(s1) do
		if not _v8.anchor.Visible then continue end
		if not f2 then continue end
	end
	for _k7, _v8 in ipairs(s1) do
		f1 = not (_v8.section ~= _v8.section)
		_v8.button.SectionTitle.TextColor3 = _v8.color
	end
end
local f3 = nil
local function cancelTween() -- proto[2], line 89  -- upvalues: f3
	if not f3 then return end
	f3 = nil
end
local function stopScrolling() -- proto[3], line 96  -- upvalues: ReplicatedStorage, f3
	if not f3 then return end
	f3 = nil
end
local s2 = Featured
local function scrollTo(v1) -- proto[4], line 101  -- upvalues: s2, f3, ReplicatedStorage, updateSection, TweenService
	if not (s2[v1.section].Visible) then return end
	if f3 then
		f3 = nil
	end
	local v_u2 = ReplicatedStorage.AbsolutePosition.Y
	local r5 = math.max(0, (ReplicatedStorage.AbsoluteCanvasSize.Y - ReplicatedStorage.AbsoluteWindowSize.Y))
	local w1 = (((s2[v1.section].AbsolutePosition.Y - v_u2) + ReplicatedStorage.CanvasPosition.Y) - 6)
	local r6 = math.clamp(w1, 0, r5)
	if not (v1.animated) then
		ReplicatedStorage.CanvasPosition = Vector2.new
		return
	end
	local CanvasPosition = {}
	CanvasPosition.CanvasPosition = Vector2.new
	f3 = TweenService.Create
end
local Open = {}
function Open.Open(v2) -- proto[6], line 127  -- upvalues: ReplicatedStorage, f3, Tabs, scrollTo, Promise
	if f3 then
		f3 = nil
	end
	if not (Tabs.Activate) then
		local section = { section = v2, animated = false }
		return
	end
	local v2 = (v2 ^ "Clean")
	ReplicatedStorage:AddPromise(Promise.delay:andThen(function()
		if not Tabs.IsActive then return end
		local section = { section = v2, animated = false }
	end))
end
r2:AttachToInstance(r1)
local w2 = r1.Frame.ScrollingFrame
r2:Add(stopScrolling)
for _k26, _v27 in ipairs(s1) do
	_v27.button.Active = true
	_v27.button.Selectable = true
	r2:Add(ButtonFX(_v27.button, 1.08, function()
		if f3 then
			f3 = nil
		end
		local section = { section = nil, animated = true }
		section.section = _v27.section
	end))
	r2:Add((_v27.anchor:GetPropertyChangedSignal("Visible")):Connect(updateSection))
end
r2:Add((w2:GetPropertyChangedSignal("CanvasPosition")):Connect(updateSection))
r2:Add((w2:GetPropertyChangedSignal("AbsoluteCanvasSize")):Connect(updateSection))
r2:Add((w2:GetPropertyChangedSignal("AbsoluteWindowSize")):Connect(updateSection))
r2:Add(w2.InputBegan:Connect(function(v3)
	if v3.UserInputType ~= Enum.UserInputType.Touch then
		if v3.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
	end
	if not f3 then return end
	f3 = nil
end))
r2:Add(w2.InputChanged:Connect(function(v4)
	if v4.UserInputType ~= Enum.UserInputType.MouseWheel then return end
	if not f3 then return end
	f3 = nil
end))
r2:Add(Tabs.Deactivated:Connect(function(v5)
	if v5 ~= "Shop" then return end
	if not f3 then return end
	f3 = nil
end))
_r23[1], _r23[2], _r23[3] = "OldRobuxShop", "SpeedShop", "RobuxShopOLD"
for _k26, _v27 in {} do
	local child = (GUI.PlayerGui()):FindFirstChild(_v27)
	if not child then continue end
	if not child:IsA("ScreenGui") then continue end
	child.Enabled = false
end
r1.ResetOnSpawn = false
w2.CanvasPosition = Vector2.zero
updateSection()
return table.freeze(Open)