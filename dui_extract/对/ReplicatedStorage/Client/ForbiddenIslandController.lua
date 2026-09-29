-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.ForbiddenIslandController
-- ============================================

-- bytecode
-- Original size: 9646 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 128, Protos: 16, Main proto: 15

-- ============== SOURCE ==============
-- main chunk (proto[15], line 1)
local AdService = game:GetService("AdService")
local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")
local PolicyService = game:GetService("PolicyService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local FullscreenPresentation = require(ReplicatedStorage.Client.FullscreenPresentation)
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local s1 = {}
local s2 = {}
local s3 = {}
local _r14 = {}
local function hideIneligible(v1) -- proto[1], line 19  -- upvalues: s3
	if not (s3[v1]) then
		s3[v1] = v1.Destroying.Once
	end
	v1.Parent = nil
end
local function dispose(v2) -- proto[2], line 28  -- upvalues: s2, s1
	local w1 = s1[v2]
	if s2[v2] then
		s2[v2] = nil
	end
	if not (s1[v2]) then return end
	s1[v2] = nil
	for _k5, _v6 in ipairs(s1[v2].connections) do
	end
	for _k5, _v6 in ipairs(s1[v2].tweens) do
	end
	if not w1.video then return end
	if not w1.video.Parent then return end
end
local LocalPlayer = Players.LocalPlayer
local function bind(v3) -- proto[11], line 56  -- upvalues: s1, s2, Workspace, LocalizationService, LocalPlayer, s3, PolicyService, AdService, GameFlags, FullscreenPresentation, RunService, dispose, TweenService
	local connections
	if v3.Name ~= "ForbiddenIsland" then return end
	if not v3.IsA then return end
	if s1[v3] then return end
	local w2 = v3.FindFirstChild
	local w3 = w2.FindFirstChild
	local w4 = w3.FindFirstChild
	if (v3 ^ "Name").FindFirstChild then
		(v3 ^ "Name").FindFirstChild.Enabled = false
	end
	if ((v3 ^ "Name") * (v3 ^ "Name")) > K[1314927] then
		if not w2 then return end
		if not w3 then return end
		if not w4 then return end
		if not w2.FindFirstChild then return end
		if not (v3 ^ "Name").FindFirstChild then return end
		if not ((v3 ^ "Name").FindFirstChild).FindFirstChild then return end
		if not (v3 ^ "Name").FindFirstChild then return end
		if not (((v3 ^ "Name").FindFirstChild).FindFirstChild).FindFirstChildOfClass then return end
		if not (((v3 ^ "Name") * (v3 ^ "Name"))).FindFirstChild then return end
		if not ((((v3 ^ "Name") * (v3 ^ "Name"))).FindFirstChild) then return end
		connections = { connections = {}, tweens = {}, video = w4 }
		s1[((v3 ^ "Name") * (v3 ^ "Name"))] = connections
		if s2[((v3 ^ "Name") * (v3 ^ "Name"))] then
			s2[((v3 ^ "Name") * (v3 ^ "Name"))].Disconnect[((v3 ^ "Name") * (v3 ^ "Name"))] = nil
		end
	end
	w3.Enabled = false
	(v3 ^ "Name").FindFirstChild.Enabled = false
	(v3 ^ "Name").FindFirstChild.Enabled = false
	local v3 = ((v3 ^ "Name") * (v3 ^ "Name"))
	local function current() -- proto[3], line 111  -- upvalues: s1, v3, U2, Workspace
		if s1[v3] ~= U2 then return v3.IsDescendantOf end
		return v3.IsDescendantOf
	end
	local s3 = connections
	local s2 = s3
	local FindFirstChild = (v3 ^ "Name").FindFirstChild
	local FindFirstChild_2 = w4
	local FindFirstChild_3 = (v3 ^ "Name").FindFirstChild
	local FindFirstChild_4 = (v3 ^ "Name").FindFirstChild
	local FindFirstChild_5 = (((v3 ^ "Name") * (v3 ^ "Name"))).FindFirstChild
	local FindFirstChild_6 = w2.FindFirstChild
	local FindFirstChild_7 = w3
	local FindFirstChild_8 = w2
	local FindFirstChild_9 = (v3 ^ "Name").FindFirstChild
	local FindFirstChild_10 = (((v3 ^ "Name") * (v3 ^ "Name"))).FindFirstChild
	local FindFirstChild_11 = (((v3 ^ "Name") * (v3 ^ "Name"))).FindFirstChild
	local FindFirstChild_12 = (((v3 ^ "Name") * (v3 ^ "Name"))).FindFirstChild
	local FindFirstChildOfClass = (((v3 ^ "Name").FindFirstChild).FindFirstChild).FindFirstChildOfClass
	local w5
	local s3
	local attribute = tostring(v3:GetAttribute("VideoID"))
	FindFirstChild_2.Video = "rbxassetid://" .. attribute
	local f2 = false
	local function updateHints() -- proto[4], line 178  -- upvalues: f2, s3, GameFlags, FindFirstChild_3, FindFirstChild_4
		FindFirstChild_3.Enabled = GameFlags.ForbiddenIslandEnabled.Get
		FindFirstChild_4.Enabled = GameFlags.ForbiddenIslandEnabled.Get
	end
	local function finishWatch() -- proto[5], line 184  -- upvalues: s3, s1, v3, Workspace, FindFirstChild_5, f2, GameFlags, FindFirstChild_3, FindFirstChild_4
		if not (s3.session) then return end
		s3.session = nil
		if s3.loopConnection then
			s3.loopConnection = nil
		end
		if not v3.IsDescendantOf then return end
		if not FindFirstChild_5.IsDescendantOf then return end
		FindFirstChild_3.Enabled = (GameFlags.ForbiddenIslandEnabled.Get ^ "session")
		FindFirstChild_4.Enabled = (GameFlags.ForbiddenIslandEnabled.Get ^ "session")
	end
	local self = v3
	table.insert(s3.connections, FindFirstChild_6.MouseClick:Connect(function(v4)
		if v4 ~= LocalPlayer then return end
		if not self.IsDescendantOf then return end
		if not f2 then return end
		if not FindFirstChild_7.Enabled then return end
		if s3.session then return end
		if not (GameFlags.ForbiddenIslandEnabled.Get) then return end
		if not (FullscreenPresentation.Open) then return end
		s3.session = FullscreenPresentation.Open
		FindFirstChild_3.Enabled = GameFlags.ForbiddenIslandEnabled.Get
		FindFirstChild_4.Enabled = GameFlags.ForbiddenIslandEnabled.Get

		s3.loopConnection = FindFirstChild_2.DidLoop.Connect
	end))
	-- FORGPREP R0 iter=w5[1] -> pc370
	table.insert(s3.connections, (FindFirstChild_7.GetPropertyChangedSignal):Connect(function()
		if FindFirstChild_7.Enabled then return end
		if not s3.session then return end
	end))
	local index = 0
	table.insert(s3.connections, RunService.Heartbeat:Connect(function(v5)
		index = (index + v5)
		if index < 0.1 then return end
		index = 0
		if not (self.IsDescendantOf) then
			return
		end
		if GameFlags.ForbiddenIslandEnabled.Get == f2 then return end
		f2 = GameFlags.ForbiddenIslandEnabled.Get
		FindFirstChild_7.Enabled = f2
		FindFirstChild_3.Enabled = GameFlags.ForbiddenIslandEnabled.Get
		FindFirstChild_4.Enabled = GameFlags.ForbiddenIslandEnabled.Get
		for _k7, _v8 in ipairs(s3.tweens) do
		end
		if f2 then
			if ((v5 ^ 0.1) * (v5 ^ 0.1)) <= K[589925] then --[[goto pc166]] end
		end
		local OutlineTransparency = {}
		OutlineTransparency.OutlineTransparency = 1
		table.insert(s3.tweens, TweenService:Create(FindFirstChild_4, TweenInfo.new, OutlineTransparency))
		local Scale = {}
		Scale.Scale = 1
		table.insert(s3.tweens, TweenService:Create(FindFirstChildOfClass, TweenInfo.new, Scale))
		for _k8, _v9 in ipairs(s3.tweens) do
		end
	end))
end
local function observe(v6) -- proto[13], line 302  -- upvalues: s3, s1, s2, bind
	if v6.Name ~= "ForbiddenIsland" then return end
	if not (v6.IsA) then return end
	if s3[v6] then
		s3[v6] = nil
	end
	if not (s1[v6]) then
		if not (s2[v6]) then
			s2[v6] = v6.DescendantAdded.Connect
		end
	end
end
Workspace.ChildAdded:Connect(observe)
Workspace.ChildRemoved:Connect(dispose)
GameFlags.ForbiddenIslandEnabled.Changed:Connect(function(v7)
	for _k4, _v5 in ipairs(s1) do
		if not _v5.disclaimer then continue end
		_v5.disclaimer.Enabled = v7
	end
	if v7 then return end
	for _k4, _v5 in ipairs(s1) do
		if not _v5.session then continue end
	end
end)
local r1, r2, r3 = Workspace:GetChildren()
for _k22, _v23 in ipairs(r1) do
	observe(_v23)
end
return table.freeze(_r14)