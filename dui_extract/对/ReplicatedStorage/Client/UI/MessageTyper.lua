-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.MessageTyper
-- ============================================

-- bytecode
-- Original size: 3710 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 66, Protos: 10, Main proto: 9

-- ============== SOURCE ==============
-- main chunk (proto[9], line 1)
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Alphabet = require(ReplicatedStorage.Data.Sounds.Languages.Alphabet)
local _index = {}
_index.__index = _index
_index.__class = "MessageTyper"
local function splitGlyphs(v1) -- proto[0], line 32
	local _r2 = {}
	for _k6, _v7 in ipairs(utf8.graphemes) do
		_r2[((#_r2) + 1)] = (string.sub(string.gsub, _k6, _v7))
	end
	return _r2
end
Alphabet = Alphabet.Normal
local function voiceGlyph(v2, v3) -- proto[1], line 42  -- upvalues: Alphabet, Audio, ReplicatedFirst
	if v2 == " " then return end
	if Alphabet[string.lower] then
		return
	end
end
local module = _index
function _index.new(v4, v5, v6, v7) -- proto[2], line 56  -- upvalues: module
	local f1
	local self = setmetatable(({}), module)
	self.label = v4
	self.run = 0
	self.clickSound = (v5 or "rbxassetid://91414159854126")
	f1 = not (v7 == false)
	self.clicksOn = f1
	self.pace = (v6 or 0.09)
	self.driver = nil
	self.watcher = nil
	self.sweep = nil
	return self
end
function _index.Halt(v8) -- proto[3], line 74
	v8.run = (v8.run + 1)
	local sweep = v8.sweep
	if sweep then
		v8.sweep = nil
	end
	local watcher = v8.watcher
	if watcher then
		v8.watcher = nil
	end
	local driver = v8.driver
	if driver then
		v8.driver = nil
	end
	v8.label.MaxVisibleGraphemes = -1
end
function _index.Blank(v9) -- proto[4], line 98
	local w1 = v9.label
	w1.Text = ""
end
function _index.ShowAll(v10, v11, v12) -- proto[5], line 103
	if v10.label.Text == v11 then
		if v10.label.TextColor3 == v12 then
			if v10.label.MaxVisibleGraphemes <= -1 then return end
			v10.label.RichText = true
			v10.label.Text = v11
			v10.label.TextColor3 = v12
			v10.label.MaxVisibleGraphemes = -1
		end
	end
end
function _index.Type(v13, v14, v15) -- proto[8], line 119  -- upvalues: splitGlyphs, Alphabet, Audio, ReplicatedFirst, TweenService
	local w1 = v13.label
	local w2 = v13.run
	if v13.label.Text == v14 then
		if v13.label.TextColor3 == v15 then return end
		v13.run = (v13.run + 1)
		w1.RichText = true
		w1.Text = v14
		w1.TextColor3 = v15
		if (#splitGlyphs) <= 0 then
			w1.MaxVisibleGraphemes = -1
			return
		end
	end
	w1.MaxVisibleGraphemes = 0
	Instance.new.Value = 0
	v13.driver = Instance.new
	local run = w2
	local v14 = (#splitGlyphs)
	local r1 = 0
	local label = w1
	(v13 ^ "label").watcher = (Instance.new.GetPropertyChangedSignal).Connect
	local Value = {}
	Value.Value = (#splitGlyphs)
	(v13 ^ "label").sweep = TweenService.Create
	local v13 = (v13 ^ "label")
end
return _index