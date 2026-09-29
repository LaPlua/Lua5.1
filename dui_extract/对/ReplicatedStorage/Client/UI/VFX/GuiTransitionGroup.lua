-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.VFX.GuiTransitionGroup
-- ============================================

-- bytecode
-- Original size: 4028 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 64, Protos: 13, Main proto: 12

-- ============== SOURCE ==============
-- main chunk (proto[12], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local t = require(ReplicatedStorage.Packages.t)
local s1 = {}
local property = { property = "BackgroundTransparency", classes = {"GuiObject"} }
local property_2 = { property = "GroupTransparency", classes = {"CanvasGroup"} }
local property_3 = { property = "ImageTransparency", classes = {"ImageLabel", "ImageButton"} }
local property_4 = { property = "TextTransparency", classes = {"TextLabel", "TextButton", "TextBox"} }
local property_5 = { property = "TextStrokeTransparency", classes = {"TextLabel", "TextButton", "TextBox"} }
local property_6 = { property = "Transparency", classes = {"UIStroke"} }
s1[1], s1[2], s1[3], s1[4], s1[5], s1[6] = property, property_2, property_3, property_4, property_5, property_6
local _index = {}
_index.__index = _index
_index.__class = "GuiTransitionGroup"
local function isAnyOf(v1, v2) -- proto[0], line 52
	local v_u1
	for _k6, _v7 in ipairs(v2) do
		v_u1 = v1.IsA
	end
	return v_u1
end
local function captureFade(v3) -- proto[1], line 60  -- upvalues: s1
	local v_u2
	local _r1 = {}
	local _r2 = {}
	for _k6, _v7 in ipairs(s1) do
		for _k13, _v14 in ipairs(_v7.classes) do
			v_u2 = v3.IsA
		end
		if not v_u2 then continue end
		_r1[((#_r1) + 1)] = _v7.property
		_r2[_v7.property] = v3[_v7.property]
	end
	if not _r1[1] then return nil end
	local element = { element = v3, properties = _r1, restingAlpha = _r2 }
	return element
end
local function raised(v4, v5) -- proto[2], line 76
	return UDim2.new(v4.X.Scale, v4.X.Offset, (v4.Y.Scale - v5), v4.Y.Offset)
end
local function schedule(v6, v7, v8, v9) -- proto[3], line 80  -- upvalues: TweenService
	v6[((#v6) + 1)] = TweenService.Create
end
local function placeSlides(v10, v11) -- proto[4], line 86
	for _k5, _v6 in ipairs(v10.slides) do
		_v6.element.Position = _v6.liftedPosition
	end
end
local function drift(v12, v13, v14) -- proto[5], line 92  -- upvalues: TweenService
	for _k6, _v7 in ipairs(v12.fades) do
		local _r8 = {}
		for _k12, _v13 in ipairs(_v7.properties) do
			_r8[_v13] = 1
		end
		v12.running[((#v12.running) + 1)] = TweenService.Create
	end
	for _k6, _v7 in ipairs(v12.slides) do
		local Position = {}
		Position.Position = _v7.liftedPosition
		v12.running[((#v12.running) + 1)] = TweenService.Create
	end
end
local module = _index
local function new(v15, v16, v17) -- proto[6], line 107  -- upvalues: t, module, captureFade
	local self = setmetatable(({}), module)
	self.running = {}
	self.fades = _r4
	self.slides = _r4
	for _k7, _v8 in {} do
		if captureFade == nil then continue end
		self.fades[((#self.fades) + 1)] = captureFade
	end
	for _k7, _v8 in {} do
		if not _v8.IsA then continue end
		local element = { element = _v8, homePosition = _v8.Position, liftedPosition = UDim2.new }
		self.slides[((#self.slides) + 1)] = element
	end
	return self
end
_index.new = new
function _index.Halt(v18) -- proto[7], line 138
	for _k4, _v5 in ipairs(v18.running) do
	end
end
function _index.SnapHidden(v19) -- proto[8], line 145
	for _k4, _v5 in ipairs(v19.fades) do
		for _k10, _v11 in ipairs(_v5.properties) do
			_v5.element[_v11] = 1
		end
	end
	for _k4, _v5 in ipairs(v19.slides) do
		_v5.element.Position = _v5.liftedPosition
	end
end
function _index.Reveal(v20, v21) -- proto[9], line 156  -- upvalues: drift
end
function _index.Conceal(v22, v23) -- proto[10], line 158  -- upvalues: drift
end
function _index.Rehome(v24) -- proto[11], line 160
	for _k4, _v5 in ipairs(v24.slides) do
		_v5.element.Position = _v5.homePosition
	end
end
return _index