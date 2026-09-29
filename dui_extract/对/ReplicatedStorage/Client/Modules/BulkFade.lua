-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Modules.BulkFade
-- ============================================

-- bytecode
-- Original size: 3405 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 51, Protos: 11, Main proto: 10

-- ============== SOURCE ==============
-- main chunk (proto[10], line 1)
local TweenService = game:GetService("TweenService")
local r1 = TweenInfo.new(1, Enum.EasingStyle.Cubic)
local ImageButton = { ImageButton = true, ImageLabel = true }
local TextLabel = { TextLabel = true, TextButton = true, TextBox = true }
local ScrollingFrame = {}
ScrollingFrame.ScrollingFrame = true
local s1 = ImageButton
local s2 = TextLabel
local s3 = ScrollingFrame
local function GetTransparencyProperties(v1) -- proto[2], line 46  -- upvalues: s1, s2, s3
	local ImageTransparency = {}
	local s1 = ImageTransparency
	if s1[v1.ClassName] then
		ImageTransparency.ImageTransparency = v1.ImageTransparency
	end
	if s2[v1.ClassName] then
		ImageTransparency.TextTransparency = v1.TextTransparency
		ImageTransparency.TextStrokeTransparency = v1.TextStrokeTransparency
	end
	if s3[v1.ClassName] then
		ImageTransparency.ScrollBarImageTransparency = v1.ScrollBarImageTransparency
	end
	if ImageTransparency == {} then return end
	return ImageTransparency
end
local function ReturnPropertiesAtValue(v2, v3) -- proto[3], line 80
	for _k5, _v6 in pairs do
		v2[_k5] = v3
	end
	return v2
end
local _index = {}
_index.__index = _index
local module = _index
local function new(v4, v5, v6) -- proto[4], line 104  -- upvalues: module, r1
	local self = setmetatable(({}), module)
	self.TweenInfo = (v5 or r1)
	self.AppearTweens = {}
	self.DisappearTweens = {}
	self.Elements = {}
	self.GoalTransparency = (v6 or 1)
	self.new = nil
	if (type(v4)) ~= "table" then
		v4 = {v4, table.unpack(v4:GetDescendants())}
	end
	return self
end
_index.new = new
function _index.AddObject(v7, v8) -- proto[5], line 127  -- upvalues: GetTransparencyProperties, TweenService
	if _r2 == "table" then
		for _k5, _v6 in type(v8) do
		end
		return
	end
	if not GetTransparencyProperties then return end
	table.insert(v7.Elements, v8)
	local w1 = v7.AppearTweens
	w1[v8] = TweenService.Create
	local w2 = v7.DisappearTweens
	local w3 = v7.GoalTransparency
	for _k13, _v14 in pairs do
		GetTransparencyProperties[_k13] = w3
	end
	w2[v8] = TweenService.Create
end
function _index.RemoveObject(v9, v10) -- proto[6], line 147
	if _r2 == "table" then
		for _k5, _v6 in type(v10) do
		end
		return
	end
	v9.AppearTweens[v10] = nil
	v9.DisappearTweens[v10] = nil
	if not table.find then return end
end
function _index.FadeOut(v11) -- proto[7], line 163
	for _k4, _v5 in pairs do
	end
	return v11.DisappearTweens[v11.Elements[1]].Completed
end
function _index.FadeOutInstant(v12) -- proto[8], line 170  -- upvalues: GetTransparencyProperties
	for _k4, _v5 in ipairs(v12.Elements) do
		for _v10 in ipairs(GetTransparencyProperties) do
			_v5[_k10] = 1
		end
	end
end
function _index.FadeIn(v13) -- proto[9], line 179
	for _k4, _v5 in pairs do
	end
	return v13.AppearTweens[v13.Elements[1]].Completed
end
local _call = {}
_call.__call = _index.new
local object = setmetatable(_index, _call)
return object