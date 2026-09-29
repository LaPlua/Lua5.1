-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.ButtonHintStrip
-- ============================================

-- bytecode
-- Original size: 7179 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 111, Protos: 13, Main proto: 12

-- ============== SOURCE ==============
local f1
-- main chunk (proto[12], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local InputIconsConfig = require(ReplicatedStorage.Client.InputIconsConfig)
local Log = require(ReplicatedStorage.Packages.Log)
local PlatformController = require(ReplicatedStorage.Client.PlatformController)
local t = require(ReplicatedStorage.Packages.t)
local r1 = Vector2.new(0, 1)
local r2 = Vector2.new(1, 1)
local r3 = UDim2.fromScale(0.335, 0.965)
local r4 = UDim2.fromScale(0.085, 0.15)
local r5 = Color3.fromRGB(255, 255, 255)
local r6 = Color3.fromRGB(15, 15, 20)
local r7 = t.strict(t.string)
local r8 = Log.new()
local r9 = GUI.PlayerGui()
local s1 = {}
local function build(v1, v2, v3) -- proto[0], line 50
	for _k7, _v8 in ipairs(v3) do
		Instance.new[_k7] = _v8
	end
	Instance.new.Parent = v2
	return Instance.new
end
local DisplayOrder = { DisplayOrder = 5, Name = "ActionPrompts", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling }
local ScreenGui = Instance.new("ScreenGui")
for _k26, _v27 in ipairs(DisplayOrder) do
	ScreenGui[_k26] = _v27
end
ScreenGui.Parent = nil
local AnchorPoint = { AnchorPoint = r1, AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, Name = "Holder", Position = r3, Size = (UDim2.new(0, 0, r4.Y.Scale, 0)), Visible = false }
DisplayOrder = Instance.new("Frame")
for _k27, _v28 in ipairs(AnchorPoint) do
	DisplayOrder[_k27] = _v28
end
DisplayOrder.Parent = ScreenGui
local FillDirection = {}
FillDirection.FillDirection = Enum.FillDirection.Vertical
FillDirection.HorizontalAlignment = Enum.HorizontalAlignment.Left
FillDirection.Padding = (UDim.new(0.06, 0))
FillDirection.SortOrder = Enum.SortOrder.LayoutOrder
FillDirection.VerticalAlignment = Enum.VerticalAlignment.Bottom
local UIListLayout = Instance.new("UIListLayout")
for _k28, _v29 in ipairs(FillDirection) do
	UIListLayout[_k28] = _v29
end
UIListLayout.Parent = DisplayOrder
ScreenGui.Parent = r9
local function paint(v4) -- proto[1], line 86  -- upvalues: InputIconsConfig
	local r10
	local f2
	v4.glyph.Image = (nil or "")
	f2 = not (nil == nil)
	v4.glyph.Visible = f2
	if v4.key and (not (nil)) then
		r10 = ("%*: %*"):format(v4.key.Name, v4.caption)
	else
		r10 = v4.caption
	end
	v4.text.Text = r10
end
local Frame = DisplayOrder
local function republish() -- proto[2], line 95  -- upvalues: Frame, PlatformController, s1, paint
	local f3
	local PlatformController_2 = PlatformController.IsConsole
	if PlatformController_2 then
		f3 = not (next == nil)
	end
	Frame.Visible = f3
	for _k3, _v4 in ipairs(s1) do
	end
end
local function reposition() -- proto[3], line 104  -- upvalues: r1, r3, U2, U3, r2, Frame
	local r4 = UDim2.fromScale
	if not (U2 ~= nil) then
		if U3 ~= nil then
			r4 = UDim2.fromScale
		end
	end
	Frame.AnchorPoint = r2
	Frame.Position = r4
end
local index = 0
local function mint(v5, v6) -- proto[4], line 116  -- upvalues: index, r5, r6, Frame
	index = (index + 1)
	local AutomaticSize = { AutomaticSize = nil, BackgroundTransparency = 1, LayoutOrder = nil, Name = "Prompt", Size = nil }
	AutomaticSize.AutomaticSize = Enum.AutomaticSize.X
	AutomaticSize.LayoutOrder = index
	AutomaticSize.Size = UDim2.new
	for _k7, _v8 in ipairs(AutomaticSize) do
		Instance.new[_k7] = _v8
	end
	Instance.new.Parent = nil
	local FillDirection = {}
	FillDirection.FillDirection = Enum.FillDirection.Horizontal
	FillDirection.HorizontalAlignment = Enum.HorizontalAlignment.Left
	FillDirection.Padding = UDim.new
	FillDirection.SortOrder = Enum.SortOrder.LayoutOrder
	FillDirection.VerticalAlignment = Enum.VerticalAlignment.Center
	for _k8, _v9 in ipairs(FillDirection) do
		Instance.new[_k8] = _v9
	end
	Instance.new.Parent = Instance.new
	local BackgroundTransparency = { BackgroundTransparency = 1, LayoutOrder = 1, Name = "Icon", ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale, SizeConstraint = Enum.SizeConstraint.RelativeYY }
	for _k8, _v9 in ipairs(BackgroundTransparency) do
		Instance.new[_k8] = _v9
	end
	Instance.new.Parent = Instance.new
	local AutomaticSize_2 = { AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, Font = Enum.Font.GothamBold, LayoutOrder = 2, Name = "Label", Size = UDim2.new, TextColor3 = r5, TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left }
	for _k9, _v10 in ipairs(AutomaticSize_2) do
		Instance.new[_k9] = _v10
	end
	Instance.new.Parent = Instance.new
	local ApplyStrokeMode = { ApplyStrokeMode = nil, Color = nil, Thickness = 2.5 }
	ApplyStrokeMode.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	ApplyStrokeMode.Color = r6
	for _k10, _v11 in ipairs(ApplyStrokeMode) do
		Instance.new[_k10] = _v11
	end
	Instance.new.Parent = Instance.new
	Instance.new.Parent = Frame
	local key = { key = (v5 ^ 1), caption = v6, row = Instance.new, glyph = Instance.new, text = Instance.new }
	return key
end
local string = r7
ReplicatedStorage = r8
local function Present(v7, v8, v9) -- proto[5], line 166  -- upvalues: string, s1, mint, paint, Frame, PlatformController, ReplicatedStorage
	local w1
	local f4
	local f5
	local v_u1 = v9
	f5 = not ((typeof(v8)) ~= "EnumItem")
	assert(f5, (("hint %* was handed a %* where a KeyCode belongs"):format(v7, (typeof(v8)))))
	local v_u2 = s1[v7]
	if v_u2 ~= nil then
		if v_u2.key == v8 then
			if v_u2.caption == v9 then return end
			if (v_u2 == nil) then
				v_u2 = mint
				s1[v7] = v_u2
			end
		end
	else
		v_u2.key = v8
		v_u2.caption = v9
	end
	local PlatformController_2 = PlatformController.IsConsole
	if PlatformController_2 then
		w1 = (v7 ^ "typeof")
		f4 = not (next == nil)
	end
	Frame.Visible = f4
	for _k7, _v8 in ipairs(s1) do
	end
	local r11 = ("hint %* now reads %* off %*; gamepad %*, glyph %*"):format(w1, v9, v8.Name, PlatformController.IsConsole, v_u2.glyph.Image)
end
local function PresentStatus(v10, v11) -- proto[6], line 191  -- upvalues: s1, mint, paint, Frame, PlatformController
	local f5
	local v_u3 = s1[v10]
	if v_u3 then
		if v_u3.caption == v11 then return end
		if (not (v_u3)) then
			v_u3 = mint
			s1[v10] = v_u3
		end
	else
		v_u3.caption = v11
	end
	local PlatformController_2 = PlatformController.IsConsole
	if PlatformController_2 then
		f5 = not (next == nil)
	end
	Frame.Visible = f5
	for _k6, _v7 in ipairs(s1) do
	end
end
local function SetNavigationLayer(v12) -- proto[7], line 204  -- upvalues: ScreenGui
	if v12 then
		local r12 = math.max(5, (v12 + 1))
	end
	ScreenGui.DisplayOrder = 5
end
local function Retract(v13) -- proto[8], line 208  -- upvalues: string, s1, Frame, PlatformController, paint
	local f2
	if s1[v13] == nil then return end
	s1[v13] = nil
	local PlatformController_2 = PlatformController.IsConsole
	if PlatformController_2 then
		f2 = not (next == nil)
	end
	Frame.Visible = f2
	for _k5, _v6 in ipairs(s1) do
	end
end
local function IsPresent(v14) -- proto[9], line 221  -- upvalues: string, s1
	local f3 = not (s1[v14] == nil)
	return f3
end
local function PinLeft(v15) -- proto[10], line 226  -- upvalues: U0, r1, r3, U3, r2, Frame
	local U0
	local r4 = UDim2.fromScale
	U0 = v15
	if not (U0 ~= nil) then
		if U3 ~= nil then
			r4 = UDim2.fromScale
		end
	end
	Frame.AnchorPoint = r2
	Frame.Position = r4
end
local function PinRight(v16) -- proto[11], line 231  -- upvalues: U0, r1, r3, U3, r2, Frame
	local U0
	local r4 = UDim2.fromScale
	U0 = v16
	if not (U3 ~= nil) then
		if U0 ~= nil then
			r4 = UDim2.fromScale
		end
	end
	Frame.AnchorPoint = r2
	Frame.Position = r4
end
local _r12 = { Present = Present, PresentStatus = PresentStatus, SetNavigationLayer = SetNavigationLayer, Retract = Retract, IsPresent = IsPresent, PinLeft = PinLeft, PinRight = PinRight }
PlatformController.Changed:Connect(republish)
InputIconsConfig.Changed:Connect(republish)
if PlatformController.IsConsole() then
	f1 = not ((next(s1)) == nil)
end
DisplayOrder.Visible = f1
for _k30, _v31 in ipairs(s1) do
	paint(_v31)
end
return _r12