-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UIEffects
-- ============================================

-- bytecode
-- Original size: 3420 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 44, Protos: 11, Main proto: 10

-- ============== SOURCE ==============
-- main chunk (proto[10], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HoverBob = require(script.HoverBob)
require(script.TaggedSprites)
local Log = require(ReplicatedStorage.Packages.Log)
local SpriteSheet = require(script.SpriteSheet)
local TextGlitch = require(script.TextGlitch)
local r1 = Log.new()
local HoverBob_2 = { HoverBob = HoverBob.Bind, SpriteSheet = SpriteSheet.Bind, TextGlitch = TextGlitch.Bind }
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local s1 = {}
local s2 = {}
ReplicatedStorage = r1
local function stopEffect(v1) -- proto[0], line 36  -- upvalues: s1, ReplicatedStorage
	if s1[v1] == nil then return end
	s1[v1] = nil
	if pcall then return end
	local w1 = s1[v1]
	local w2 = v1.GetFullName
	local r2 = ("UI effect cleanup failed on %*: %*"):format(w2, w1)
end
local s3 = HoverBob_2
local function startEffect(v2) -- proto[1], line 49  -- upvalues: s1, ReplicatedStorage, s3
	local w3
	if s1[v2] ~= nil then
		s1[v2] = nil
		if not (pcall) then
			local w1 = s1[v2]
			local w2 = v2.GetFullName
			local r2 = ("UI effect cleanup failed on %*: %*"):format(w2, w1)
		end
	end
	local w4 = v2.GetAttribute
	if w4 == nil then return end
	local w5 = (v2 ^ "pcall")
	if (typeof(w4)) ~= "string" then
		local r3 = ("%* UIEffect must be a string"):format(w5.GetFullName)
		return
	end
	if s3[w4] == nil then
		local w6 = w5.GetFullName
		w3 = (w5 * w5)
		local r4 = ("%* asks for unknown UIEffect \"%*\""):format(w6, w4)
		return
	end
	if not (pcall) then
		if w3 > K[265042] then
			local r5 = ("UI effect %* failed on %*: %*"):format(w4, w3.GetFullName, w3)
			if not w3 then return end
			return
		end
	end
	s1[w3] = s3[w4]
end
local function watch(v3) -- proto[4], line 75  -- upvalues: s2, startEffect, s1, ReplicatedStorage
	if s2[v3] ~= nil then return end
	s2[v3] = (v3.GetAttributeChangedSignal).Connect
end
local function consider(v4) -- proto[5], line 93  -- upvalues: watch, startEffect
	if v4.GetAttribute == nil then return end
end
local function Bind(v5) -- proto[6], line 106  -- upvalues: watch, startEffect
end
local function Unbind(v6) -- proto[7], line 111  -- upvalues: s1, ReplicatedStorage
	if s1[v6] == nil then return end
	s1[v6] = nil
	if pcall then return end
	local w1 = s1[v6]
	local w2 = v6.GetFullName
	local r2 = ("UI effect cleanup failed on %*: %*"):format(w2, w1)
end
local _r7 = { Bind = Bind, Unbind = Unbind }
local r6, r7, r8 = PlayerGui:GetDescendants()
for _k19, _v20 in ipairs(r6) do
	local UIEffect = _v20:GetAttribute("UIEffect")
	if not ((UIEffect == nil)) then
		watch(_v20)
		startEffect(_v20)
	end
end
PlayerGui.DescendantAdded:Connect(function(v7)
	if v7.GetAttribute == nil then return end

end)
return _r7