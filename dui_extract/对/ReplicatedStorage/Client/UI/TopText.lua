-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.TopText
-- ============================================

-- bytecode
-- Original size: 5579 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 91, Protos: 16, Main proto: 15

-- ============== SOURCE ==============
local Response_UI
-- main chunk (proto[15], line 1)
local Debris = game:GetService("Debris")
local GamepadService = game:GetService("GamepadService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
Response_UI = { Response_UI = true, Talk_UI = true }
local r1 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
local r2 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
local Speak = {}
task.wait(1)
local function jitter(v1) -- proto[0], line 36
	return (1 + (math.random / 100))
end
local function eachScript(v2, v3) -- proto[1], line 38
	for _k5, _v6 in ipairs(v2.GetDescendants) do
		if not _v6.IsA then continue end
	end
end
local function switchOn(v4) -- proto[2], line 46
	v4.Enabled = true
end
local function discard(v5) -- proto[3], line 48
end
local function revealNpcText(v6, v7) -- proto[4], line 50  -- upvalues: SoundService
	local v_u1, v_u3
	local _r3 = string.len(v6.Text.gsub)
	if v7 then
		v_u1 = SoundService.NPC_Text
	end
	local v_u2 = 0
	v6.MaxVisibleGraphemes = v_u2
	while true do
		if 1 > _r3 then return end
		if (0.07 < v_u1.TimePosition) or (v_u1.Playing == false) then
			v_u1.TimePosition = 0
			v_u1.Playing = true
			v_u1.PlaybackSpeed = (1 + (math.random / 100))
		end
		v_u3 = v_u3 - 1
		v_u2 = v_u2 + 1
		v6.MaxVisibleGraphemes = v_u2
	end
end
local Response_Text = SoundService.Response_Text
local function revealPlayerText(v8) -- proto[5], line 69  -- upvalues: Response_Text, SoundService, Debris
	local v_u2, v_u3
	local _r2 = string.len(v8.Text.gsub)
	v8.MaxVisibleGraphemes = 0
	while true do
		if 1 > _r2 then return end
		if (((math.floor(_r2 / 3)) * 3) == _r2) or (_r2 == _r2) then
			Response_Text.Clone.Parent = SoundService
			Response_Text.Clone.Name = "SFX"
			Response_Text.Clone.PlaybackSpeed = (1 + (math.random / 100))
			Response_Text.Clone.Playing = true
		end
		v_u3 = v_u3 - 1
		v_u2 = v_u2 + 1
		(v8 ^ "Text").MaxVisibleGraphemes = v_u2
	end
end
local function restockScripts(v9, v10, v11) -- proto[6], line 91
	for _k6, _v7 in ipairs(v9.GetDescendants) do
		if not _v7.IsA then continue end
		for _k11, _v12 in ipairs(v10.GetDescendants) do
			if _v12.Name ~= _v7.Parent.Name then continue end
			if v11 then
				_v7.Enabled = false
			end
			_v7.Clone.Parent = _v12
			_v7.Clone.Enabled = true
		end
	end
end
local Talk_UI = ReplicatedStorage.Assets.UI.Npcs.Talk_UI
local function raiseBubble(v12, v13, v14, v15, v16, v17, v18) -- proto[7], line 113  -- upvalues: Talk_UI, eachScript, discard, revealNpcText, revealPlayerText, switchOn, restockScripts
	local f1
	local v_u4 = v13.Head.FindFirstChild
	f1 = not (v15 ~= true)
	if v_u4 == nil then
		v_u4 = v12.Clone
		v_u4.Parent = v13.Head
	end
	v_u4.TextLabel.Text = v14
	if f1 and v13.Head.FindFirstChild == nil then
		return v_u4
	end
	if not f1 then return v_u4 end
	return v_u4
end
local function clearSideFrame(v19) -- proto[8], line 150
	for _k4, _v5 in ipairs(v19.PlayerGui.Billboard_UI.GetChildren) do
		if _v5.Name == "UIListLayout" then continue end
	end
end
function Speak.Speak(v20, v21, v22) -- proto[9], line 158  -- upvalues: raiseBubble, Talk_UI
	return raiseBubble
end
function Speak.Reply(v23, v24, v25) -- proto[10], line 162  -- upvalues: raiseBubble, Talk_UI
	return raiseBubble
end
Response_UI = ReplicatedStorage.Assets.UI.Npcs.Response_UI
function Speak.Echo(v26, v27, v28) -- proto[11], line 166  -- upvalues: raiseBubble, Response_UI
	if v27 == nil then return end
	return raiseBubble
end
local Option_UI = ReplicatedStorage.Assets.UI.Npcs.Option_UI
function Speak.OfferChoices(v29, v30) -- proto[12], line 174  -- upvalues: Option_UI, TweenService, r1, Debris, GamepadService
	local _r2 = {}
	for _k7, _v8 in pairs do
		Option_UI.Clone.Parent = v29.PlayerGui.Billboard_UI
		Option_UI.Clone.Frame.Frame.Text_Element.Text = _v8
		Option_UI.Clone.Frame.Frame.TextLabel.Text = (tostring(0 + 1)) .. "."
		local _r14 = string.len(_v8)
		Option_UI.Clone.Frame.Frame.Text_Element.UIPadding.PaddingLeft = UDim.new
		local PaddingLeft = {}
		PaddingLeft.PaddingLeft = UDim.new
		table.insert(_r2, Option_UI.Clone)
	end
	if not _r2[1] then return _r2 end
	return _r2
end
local s1 = Response_UI
r1 = r2
function Speak.FadeOut(v31, v32) -- proto[13], line 203  -- upvalues: clearSideFrame, s1, TweenService, r1, Debris
	for _k5, _v6 in ipairs(v31.Head.GetChildren) do
		if not _v6.IsA then continue end
		if not s1[_v6.Name] then continue end
		for _k10, _v11 in ipairs(_v6.GetChildren) do
			if _v11.IsA then
				local TextTransparency = { TextTransparency = 1 }
				continue
			end
			if not _v11.IsA then continue end
			local ImageTransparency = { ImageTransparency = 1 }
		end
	end
end
function Speak.ClearChoices(v33) -- proto[14], line 221  -- upvalues: clearSideFrame, GamepadService
end
return Speak