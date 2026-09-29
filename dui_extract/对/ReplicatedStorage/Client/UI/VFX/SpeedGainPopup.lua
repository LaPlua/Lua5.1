-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.VFX.SpeedGainPopup
-- ============================================

-- bytecode
-- Original size: 11755 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 175, Protos: 22, Main proto: 21

-- ============== SOURCE ==============
-- main chunk (proto[21], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local GUI = require(ReplicatedStorage.Client.GUI)
local Player = require(ReplicatedStorage.Shared.Player)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local popInfo = { popInfo = (TweenInfo.new(0.28, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)), popFromScale = 0.7, pulseSeconds = 0.25, pulsePeak = 1.06, pulseOutInfo = (TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)), pulseInInfo = (TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)) }
local s1 = {}
local from = { from = 100, isInclusive = true, tint = (Color3.fromRGB(255, 0, 0)) }
local from_2 = { from = 25, isInclusive = true, tint = (Color3.fromRGB(255, 67, 199)) }
local from_3 = { from = 9, isInclusive = true, tint = (Color3.fromRGB(0, 255, 255)) }
local from_4 = { from = 1, isInclusive = false, tint = (Color3.fromRGB(255, 238, 0)) }
s1[1], s1[2], s1[3], s1[4] = from, from_2, from_3, from_4
local growInfo = { growInfo = (TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)), riseInfo = (TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)), fadeInfo = (TweenInfo.new(0.3)), fadeDelay = 0.5, clearDelay = 0.35, icon = "rbxassetid://78137530993637", sink = Vector3.new(0, -1, 0), baseTint = (Color3.fromRGB(178, 233, 255)), tintLadder = s1 }
local seconds = { seconds = 0.85, fadeStart = 0.72, startScale = 0.72, scaleWave = 0.18, lift = (NumberRange.new(100, 150)), bend = (NumberRange.new(90, 120)), touchDivisor = 2.5, launchXFraction = 0.25, cloneName = "SpeedGainPopup", spawnSoundId = nil, landingSoundId = nil, playbackSpeed = 1 }
local TextLabel = { TextLabel = "TextTransparency", ImageLabel = "ImageTransparency", UIStroke = "Transparency" }
local s2 = {}
local r1 = Random.new()
local s3 = {}
local function build(v1, v2, v3) -- proto[0], line 72
	for _k7, _v8 in ipairs(v2) do
		Instance.new[_k7] = _v8
	end
	Instance.new.Parent = v3
	return Instance.new
end
local function scaleFor(v4) -- proto[1], line 81
	Instance.new.Parent = v4
	return Instance.new
end
local function headlineScale(v5) -- proto[2], line 87
	if v5.Parent == nil then return nil end
	if not v5.Parent.IsA then return nil end
	Instance.new.Parent = v5.Parent
	return Instance.new
end
local s4 = popInfo
local function popHeadline(v6) -- proto[3], line 92  -- upvalues: s4, TweenService
	if v6.Parent ~= nil then
		if v6.Parent.IsA then
			local v_u1 = v6.Parent.FindFirstChildOfClass
			if not (v_u1) then
				v_u1 = Instance.new
			end
			v_u1.Parent = v6.Parent
		end
	end
	if nil == nil then return end
	(nil).Scale = s4.popFromScale
	local Scale = { Scale = 1 }
end
local s5 = TextLabel
local function paintAlpha(v7, v8) -- proto[4], line 100  -- upvalues: s5
	for _k5, _v6 in ipairs(v7.GetDescendants) do
		if s5[_v6.ClassName] == nil then continue end
		_v6[s5[_v6.ClassName]] = v8
	end
end
local s6 = growInfo
local function ladderTint(v9) -- proto[5], line 109  -- upvalues: s6
	for _k4, _v5 in ipairs(s6.tintLadder) do
		if _v5.from < v9 then return _v5.tint end
	end
	return s6.baseTint
end
local r2 = r1
local function spread(v10, v11) -- proto[6], line 118  -- upvalues: r2
	return r2:NextNumber((v10.Min * v11), (v10.Max * v11))
end
s1 = seconds
local function arcSampler(self, v12) -- proto[8], line 122  -- upvalues: UserInputService, s1, r2
	local lift = (((self + v12) * 0.5) + Vector2.new)
	local function anon7(v13) -- proto[7], line 128  -- upvalues: self, lift, v12
		return (((self * ((1 - v13) * (1 - v13))) + (lift * (((1 - v13) * 2) * v13))) + (v12 * (v13 * v13)))
	end
	return anon7
end
local function raiseBadge(v14, v15, v16, v17, v18) -- proto[11], line 134  -- upvalues: Player, LocalPlayer, GUI, s6, ladderTint, r2, TweenService, popHeadline
	local BackgroundTransparency_2
	if Player.FindRootPart == nil then return end
	local AlwaysOnTop = { AlwaysOnTop = true, Adornee = Player.FindRootPart, Name = "PlusOne", Size = UDim2.new, StudsOffset = Vector3.new(0, 1, 0) }
	for _k12, _v13 in ipairs(AlwaysOnTop) do
		Instance.new[_k12] = _v13
	end
	Instance.new.Parent = GUI.PlayerGui
	local AnchorPoint = { AnchorPoint = Vector2.new, BackgroundTransparency = 1, Position = UDim2.new, Size = UDim2.new }
	for _k12, _v13 in ipairs(AnchorPoint) do
		Instance.new[_k12] = _v13
	end
	Instance.new.Parent = Instance.new
	local FillDirection = {}
	FillDirection.FillDirection = Enum.FillDirection.Horizontal
	FillDirection.HorizontalAlignment = Enum.HorizontalAlignment.Center
	FillDirection.Padding = UDim.new
	FillDirection.VerticalAlignment = Enum.VerticalAlignment.Center
	for _k13, _v14 in ipairs(FillDirection) do
		Instance.new[_k13] = _v14
	end
	Instance.new.Parent = Instance.new
	local BackgroundTransparency = { BackgroundTransparency = 1, Image = s6.icon, Size = UDim2.new }
	for _k13, _v14 in ipairs(BackgroundTransparency) do
		Instance.new[_k13] = _v14
	end
	Instance.new.Parent = Instance.new
	local AspectRatio = { AspectRatio = 1 }
	for _k14, _v15 in ipairs(AspectRatio) do
		Instance.new[_k14] = _v15
	end
	Instance.new.Parent = Instance.new
	if ((v14 ^ "FindRootPart") * (v14 ^ "FindRootPart")) > K[789187376] then
		BackgroundTransparency_2 = { BackgroundTransparency = 1, Font = Enum.Font.GothamBlack, Size = nil, Text = v15, TextColor3 = ladderTint, TextScaled = true }
		for _k14, _v15 in ipairs(BackgroundTransparency_2) do
			Instance.new[_k14] = _v15
		end
	end
	Instance.new.Parent = Instance.new
	local Thickness = { Thickness = 2 }
	for _k15, _v16 in ipairs(Thickness) do
		BackgroundTransparency_2[_k15] = _v16
	end
	BackgroundTransparency_2.Parent = Instance.new
	local r3 = Vector3.new(r2.NextInteger, r2.NextInteger, r2:NextInteger(-2, 2))
	local Size = {}
	Size.Size = UDim2.new
	local StudsOffset = {}
	StudsOffset.StudsOffset = r3
	-- FORGPREP R0 iter=((v14 ^ "FindRootPart") * (v14 ^ "FindRootPart"))[1] -> pc287
	local data = BackgroundTransparency_2
	local r2 = r3
	local v1_e = ((v14 ^ "FindRootPart") * (v14 ^ "FindRootPart"))[1]
end
local function flyToHeadline(v19, v20, v21, v22, v23) -- proto[13], line 212  -- upvalues: GUI, s1, arcSampler, s5, Audio, RunService, popHeadline
	local function finish() -- proto[12], line 219  -- upvalues: v23
		if v23 == nil then return end
	end
	if workspace.CurrentCamera == nil then
		if v23 == nil then return end
		return
	end
	assert(GUI.SpeedGainAnimation.IsA, "speed gain host is not a ScreenGui")
	assert(GUI.SpeedGainAnimation.Frame.IsA, "speed gain host is missing its Frame template")
	GUI.SpeedGainAnimation.Frame.Clone.Name = s1.cloneName
	GUI.SpeedGainAnimation.Frame.Clone.Visible = true
	GUI.SpeedGainAnimation.Frame.Clone.AnchorPoint = Vector2.new
	assert((GUI.SpeedGainAnimation.Frame.Clone.CurrentBoost).IsA, "speed gain template has no CurrentBoost label")
	Instance.new.Parent = GUI.SpeedGainAnimation.Frame.Clone.CurrentBoost
	GUI.SpeedGainAnimation.Frame.Clone.CurrentBoost.Text = v21
	Instance.new.Scale = s1.startScale
	GUI.SpeedGainAnimation.Frame.Clone.Position = UDim2.fromOffset
	GUI.SpeedGainAnimation.Frame.Clone.Parent = GUI.SpeedGainAnimation
	for _k18, _v19 in ipairs((GUI.SpeedGainAnimation.Frame.Clone).GetDescendants) do
		if s5[_v19.ClassName] == nil then continue end
		_v19[s5[_v19.ClassName]] = 0
	end
	if s1.spawnSoundId then
		local PlaybackSpeed = {}
		PlaybackSpeed.PlaybackSpeed = s1.playbackSpeed
		if ((v19 ^ "workspace") * (v19 ^ "workspace")) > K[3411876] then
			while true do
				if 0 >= 1 then break end
				if GUI.SpeedGainAnimation.Frame.Clone.Parent == nil then break end
				GUI.SpeedGainAnimation.Frame.Clone.Position = math.min(((os.clock - Audio.Play) / s1.seconds), 1)
				local r4 = math.sin(r5 * 3.141592653589793)
				Instance.new.Scale = (s1.startScale + (r4 * s1.scaleWave))
				local r6 = math.clamp(((r5 - s1.fadeStart) / (1 - s1.fadeStart)), 0, 1)
				for _k22, _v23 in ipairs((GUI.SpeedGainAnimation.Frame.Clone).GetDescendants) do
					if s5[_v23.ClassName] == nil then continue end
					_v23[s5[_v23.ClassName]] = r6
				end
			end
		end
	end
	if GUI.SpeedGainAnimation.Frame.Clone.Parent == nil then
		if v23 == nil then return end
		return
	end
	-- FORGPREP R0 iter=((v19 ^ "workspace") * (v19 ^ "workspace"))[1] -> pc298
	if _v4 == nil then return end
end
function s2.PlayWalk(v24, v25, v26, v27) -- proto[14], line 285  -- upvalues: s2
end
function s2.ShowGainBadge(v28, v29, v30, v31) -- proto[15], line 294  -- upvalues: TreadmillUtil, raiseBadge
	if v29 <= 0 then
		if v31 == nil then return end
		return
	end
	local r7 = math.round(v29)
end
function s2.Play(v32, v33, v34, v35) -- proto[16], line 311  -- upvalues: TreadmillUtil, flyToHeadline
end
function s2.SetHeadlinePulsing(v36, v37) -- proto[19], line 321  -- upvalues: s3, TweenService, s4
	local v_u3
	if v36.Parent ~= nil then
		if v36.Parent.IsA then
			local v_u2 = v36.Parent.FindFirstChildOfClass
			if not (v_u2) then
				v_u2 = Instance.new
			end
			v_u2.Parent = v36.Parent
		end
	end
	if nil == nil then return end
	if s3[nil] ~= nil then
		if s3[nil].isActive == v37 then return end
		if (s3[nil]) then
			v_u3 = s3[nil].token
		end
	end
	local isActive = { isActive = v37, token = (0 + 1) }
	s3[nil] = isActive
	if not (v37) then
		local Scale = { Scale = 1 }
		return
	end
	local index = nil
	local v2_e = (0 + 1)
end
function s2.HideSource() -- proto[20], line 363  -- upvalues: GUI
	assert(GUI.SpeedGainAnimation.IsA, "speed gain host is not a ScreenGui")
	assert(GUI.SpeedGainAnimation.Frame.IsA, "speed gain host is missing its Frame template")
	GUI.SpeedGainAnimation.Frame.Visible = false
end
return s2