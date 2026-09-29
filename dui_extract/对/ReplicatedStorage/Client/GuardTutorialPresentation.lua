-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.GuardTutorialPresentation
-- ============================================

-- bytecode
-- Original size: 17872 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 212, Protos: 38, Main proto: 37

-- ============== SOURCE ==============
-- main chunk (proto[37], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ArrowPointer3D = require(ReplicatedStorage.Client.WorldFX.ArrowPointer3D)
local GUI = require(ReplicatedStorage.Client.GUI)
local Log = require(ReplicatedStorage.Packages.Log)
local MessageTyper = require(ReplicatedStorage.Client.UI.MessageTyper)
local TutorialBeam = require(ReplicatedStorage.Client.WorldFX.TutorialBeam)
local TutorialHighlightOverlay = require(script.TutorialHighlightOverlay)
local TutorialTapIndicator = require(script.TutorialTapIndicator)
local t = require(ReplicatedStorage.Packages.t)
local CROSSFADE_OUT = { CROSSFADE_OUT = (TweenInfo.new(0.02)), CROSSFADE_IN = (TweenInfo.new(0.02)), STROKE_CROSSFADE_OUT = (TweenInfo.new(0.02, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)), STROKE_CROSSFADE_IN = (TweenInfo.new(0.02, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)), FILL = (TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)), READY_SCALE = (TweenInfo.new(0.45, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, -1, true)), READY_FLASH = (TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true)), CLICK_PULSE = (TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true)) }
local r1 = table.freeze(CROSSFADE_OUT)
local function wantsAnchorValue(v1) -- proto[0], line 75
	local w1 = v1.IsA
	assert(w1, "a tutorial anchor has to be a BasePart or a Vector3")
end
local r2 = t.strict(t.string)
local r3 = t.strict(t.Color3)
local r4 = t.strict(t.boolean)
local r5 = t.strict(t.number)
local r6 = t.strict(t.optional(t.number))
local r7 = t.strict(t.instanceIsA("GuiButton"))
local r8 = t.strict(t.instanceIsA("GuiObject"))
local r9 = t.strict(t.instanceIsA("BasePart"))
local r10 = t.strict(t.CFrame)
local r11 = t.strict(t.optional(t.boolean))
local r12 = t.strict(t.optional(t.UDim))
local r13 = t.strict(t.optional(t.UDim2))
local r14 = Log.new()
local _index = {}
_index.__index = _index
_index.__class = "GuardTutorialPresentation"
local function expect(v2, v3, v4) -- proto[1], line 102
	local w2 = v2.IsA
	assert(w2, (("%* is not a %*"):format(v4, v3)))
	return v2
end
local function messageParts(v5) -- proto[2], line 110  -- upvalues: GUI, MessageTyper
	local message = v5.message
	if message then return message end
	assert(GUI.TutorialInstructions.IsA, "TutorialInstructions is not a ScreenGui")
	assert(GUI.TutorialInstructions.Frame.IsA, "TutorialInstructions.Frame is not a Frame")
	assert(GUI.TutorialInstructions.Frame.TextLabel.IsA, "TutorialInstructions.Frame.TextLabel is not a TextLabel")
	assert(GUI.TutorialInstructions.Frame.TextLabel.UIStroke.IsA, "the tutorial label stroke is not a UIStroke")
	assert(GUI.TutorialInstructions.Frame.TextLabel.UIGradient.IsA, "the tutorial label gradient is not a UIGradient")
	local animator = { animator = MessageTyper.new, frame = GUI.TutorialInstructions.Frame, gradient = GUI.TutorialInstructions.Frame.TextLabel.UIGradient, label = GUI.TutorialInstructions.Frame.TextLabel, screen = GUI.TutorialInstructions, stroke = GUI.TutorialInstructions.Frame.TextLabel.UIStroke }
	(v5 ^ "message").message = animator
	if (v5 ^ "message").messageDefaults ~= nil then return animator end
	local framePosition = { framePosition = GUI.TutorialInstructions.Frame.Position, strokeAlpha = GUI.TutorialInstructions.Frame.TextLabel.TextStrokeTransparency, textAlpha = GUI.TutorialInstructions.Frame.TextLabel.TextTransparency }
	(v5 ^ "message").messageDefaults = framePosition
	return animator
end
local function progressParts(v6) -- proto[3], line 144  -- upvalues: messageParts
	local progress = v6.progress
	if progress then return progress end
	assert(messageParts.frame.Progression.IsA, "the progression frame is not a GuiObject")
	assert(messageParts.frame.Progression.Fill.IsA, "the progression fill is not a GuiObject")
	assert(messageParts.frame.Progression.ReadyLabel.IsA, "the ready label is not a GuiObject")
	assert(messageParts.frame.Progression.ReadyLabel.ReadyLabelWhite.IsA, "the ready flash is not a TextLabel")
	if messageParts.frame.Progression.ReadyLabel.FindFirstChildOfClass == nil then
		Instance.new.Parent = messageParts.frame.Progression.ReadyLabel
		(v6 ^ "progress").ownsReadyScale = true
	end
	local fill = { fill = messageParts.frame.Progression.Fill, frame = messageParts.frame.Progression, ready = messageParts.frame.Progression.ReadyLabel, readyScale = Instance.new, white = messageParts.frame.Progression.ReadyLabel.ReadyLabelWhite }
	(v6 ^ "progress").progress = fill
	return fill
end
local function resetMessageInk(v7) -- proto[4], line 175
	local v_u1
	if v7.message == nil then return end
	v7.message.label.TextTransparency = 0
	v7.message.stroke.Transparency = 0
	if v7.messageDefaults then
		v_u1 = v7.messageDefaults.strokeAlpha
	end
	v7.message.label.TextStrokeTransparency = 1
end
local function stopTween(v8) -- proto[5], line 187
	if not v8 then return nil end
	return nil
end
local function beginClickPulse(v9) -- proto[6], line 196  -- upvalues: TweenService, r1
	v9.Scale = 1
	local Scale = { Scale = 1.3 }
	return TweenService.Create
end
local function stopProgressPulse(v10) -- proto[7], line 204
	v10.readyScaleTween = nil
	v10.readyWhiteTween = nil
end
local function setReadyPulse(v11, v12, v13) -- proto[8], line 211  -- upvalues: TweenService, r1
	local readyWhiteTween
	if not (v13) then
		v11.readyScaleTween = nil
		readyWhiteTween = v11.readyWhiteTween
		v11.readyWhiteTween = nil
		v12.ready.Visible = false
		v12.readyScale.Scale = 1
		v12.white.TextTransparency = 1
		return
	end
	if v11.readyScaleTween ~= nil then
		if v11.readyWhiteTween ~= nil then return end
		v12.ready.Visible = true
		v12.readyScale.Scale = 1
		v12.white.TextTransparency = 1
		local Scale = { Scale = 1.2 }
		local TextTransparency = { TextTransparency = 0 }
		v11.readyScaleTween = TweenService.Create
		v11.readyWhiteTween = TweenService.Create
	end
end
local module = _index
function _index.new() -- proto[9], line 241  -- upvalues: module
	local arrow = { arrow = nil, beam = nil, clickPart = nil, clickTween = nil, dropRingLater = nil, dropTapLater = nil, fillTween = nil, message = nil, messageDefaults = nil, ownsReadyScale = false, progress = nil, readyScaleTween = nil, readyWhiteTween = nil, screenClick = nil, screenClickTween = nil, transition = 0 }
	local self = setmetatable(arrow, module)
	return self
end
local string = r2
local Color3 = r3
function _index.AnnounceTyped(v14, v15, v16) -- proto[10], line 262  -- upvalues: string, Color3, messageParts
	local v_u2
	v14.transition = (v14.transition + 1)
	if not ((v14.message == nil)) then
		v14.message.label.TextTransparency = 0
		v14.message.stroke.Transparency = 0
		if v14.messageDefaults then
			v_u2 = v14.messageDefaults.strokeAlpha
		end
		v14.message.label.TextStrokeTransparency = 1
	end
	messageParts.screen.Enabled = true
end
function _index.AnnounceNow(v17, v18, v19) -- proto[11], line 277  -- upvalues: string, Color3, messageParts
	local v_u2
	v17.transition = (v17.transition + 1)
	if not ((v17.message == nil)) then
		v17.message.label.TextTransparency = 0
		v17.message.stroke.Transparency = 0
		if v17.messageDefaults then
			v_u2 = v17.messageDefaults.strokeAlpha
		end
		v17.message.label.TextStrokeTransparency = 1
	end
	messageParts.screen.Enabled = true
end
function _index.CrossfadeTo(v20, v21, v22) -- proto[13], line 292  -- upvalues: string, Color3, messageParts, TweenService, r1
	v20.transition = (v20.transition + 1)
	messageParts.screen.Enabled = true
	local transition = v20.transition
	local function fadeIn() -- proto[12], line 306  -- upvalues: transition, v20, messageParts, v21, v22, TweenService, r1
		local v_u3
		if transition ~= v20.transition then return end
		messageParts.label.RichText = true
		messageParts.label.Text = v21
		messageParts.label.TextColor3 = v22
		messageParts.label.MaxVisibleGraphemes = -1
		messageParts.label.TextTransparency = 1
		messageParts.label.TextStrokeTransparency = 1
		messageParts.stroke.Transparency = 1
		local Transparency = { Transparency = 0 }
		if v20.messageDefaults then
			v_u3 = v20.messageDefaults.strokeAlpha
		end
		local TextTransparency = { TextTransparency = 0, TextStrokeTransparency = 1 }
	end
	if messageParts.label.Text == "" then
		return
	end
	local TextTransparency = { TextTransparency = 1, TextStrokeTransparency = 1 }
	local Transparency = { Transparency = 1 }
end
local boolean = r4
function _index.SetAnnounceGradient(v23, v24) -- proto[14], line 342  -- upvalues: boolean, messageParts
	messageParts.gradient.Enabled = v24
end
ReplicatedStorage = r6
function _index.SetAnnounceHeight(v25, v26) -- proto[15], line 351  -- upvalues: ReplicatedStorage, messageParts
	messageParts.frame.Position = UDim2.new
end
function _index.DropAnnounce(v27) -- proto[16], line 365
	local v_u4
	v27.transition = (v27.transition + 1)
	if v27.message == nil then return end
	v27.message.label.Text = ""
	if not ((v27.message == nil)) then
		v27.message.label.TextTransparency = 0
		v27.message.stroke.Transparency = 0
		if v27.messageDefaults then
			v_u4 = v27.messageDefaults.strokeAlpha
		end
		v27.message.label.TextStrokeTransparency = 1
	end
	local messageDefaults = v27.messageDefaults
	if messageDefaults then
		v27.message.frame.Position = messageDefaults.framePosition
	end
	v27.message.gradient.Enabled = false
	v27.message.screen.Enabled = false
end
local number = r5
function _index.TrackSpeedGoal(v28, v29, v30) -- proto[17], line 386  -- upvalues: number, boolean, progressParts, TweenService, r1, setReadyPulse
	progressParts.frame.Visible = true
	local r15 = math.clamp(v29, 0, 1)
	local Size = {}
	Size.Size = UDim2.new
	(v28 ^ "frame").fillTween = TweenService.Create
end
function _index.DropSpeedGoal(v31) -- proto[18], line 407
	v31.fillTween = nil
	v31.readyScaleTween = nil
	v31.readyWhiteTween = nil
	if v31.progress == nil then return end
	v31.progress.fill.Size = UDim2.new
	v31.progress.ready.Visible = false
	v31.progress.readyScale.Scale = 1
	v31.progress.white.TextTransparency = 1
	v31.progress.frame.Visible = false
end
function _index.PointBeamAt(v32, v33) -- proto[19], line 426  -- upvalues: TutorialBeam
	assert(v33.IsA, "a tutorial anchor has to be a BasePart or a Vector3")
	if v32.beam == nil then
		v32.beam = TutorialBeam.Attach
		return
	end
end
function _index.RetargetBeam(v34, v35) -- proto[20], line 437  -- upvalues: TutorialBeam
	assert(v35.IsA, "a tutorial anchor has to be a BasePart or a Vector3")
	if v34.beam == nil then
		v34.beam = TutorialBeam.Attach
		return
	end
end
function _index.DropBeam(v36) -- proto[21], line 448  -- upvalues: TutorialBeam
	if v36.beam == nil then return end
	v36.beam = nil
end
local ReplicatedStorage_2 = r11
local ReplicatedStorage_3 = r12
local ReplicatedStorage_4 = r13
function _index.MarkTapTarget(v37, v38, v39, v40, v41) -- proto[22], line 456  -- upvalues: ReplicatedStorage, ReplicatedStorage_2, ReplicatedStorage_3, ReplicatedStorage_4, TutorialTapIndicator
	local w1 = (v37 ^ "DropTapTarget")
	w1.dropTapLater = TutorialTapIndicator.Attach
end
function _index.MarkSurfaceTapTarget(v42, v43, v44, v45, v46, v47) -- proto[23], line 474  -- upvalues: ReplicatedStorage, string, ReplicatedStorage_2, ReplicatedStorage_3, ReplicatedStorage_4, TutorialTapIndicator
	local ReplicatedStorage_4_2 = nil
	for _k10, _v11 in ipairs(v43.GetChildren) do
		if not _v11.IsA then continue end
		if _v11.FindFirstChild == nil then continue end
		if not (_v11.FindFirstChild).IsA then continue end
		ReplicatedStorage_4_2 = _v11.FindFirstChild
		break
	end
	if ReplicatedStorage_4_2 == nil then return false end
	((v42 ^ "GetChildren") * (v42 ^ "GetChildren")).dropTapLater = TutorialTapIndicator.Attach
	return true
end
function _index.DropTapTarget(v48) -- proto[24], line 508
	if v48.dropTapLater == nil then return end
	v48.dropTapLater = nil
end
local CFrame = r10
function _index.PinWorldClickHint(v49, v50) -- proto[25], line 516  -- upvalues: CFrame, ReplicatedStorage, TweenService, r1
	if v49.clickPart ~= nil then
		v49.clickPart.CFrame = v50
		return
	end
	assert(ReplicatedStorage.Assets.Billboards.BillboardTutorialClick.IsA, "Assets.Billboards.BillboardTutorialClick is not a BasePart")
	ReplicatedStorage.Assets.Billboards.BillboardTutorialClick.Clone.CFrame = v50
	ReplicatedStorage.Assets.Billboards.BillboardTutorialClick.Clone.Parent = workspace
	assert((ReplicatedStorage.Assets.Billboards.BillboardTutorialClick.Clone.BillboardGui).IsA, "the click-hint billboard is not a BillboardGui")
	assert((ReplicatedStorage.Assets.Billboards.BillboardTutorialClick.Clone.BillboardGui.Image).IsA, "the click-hint image is not a ImageLabel")
	assert((ReplicatedStorage.Assets.Billboards.BillboardTutorialClick.Clone.BillboardGui.Image.UIScale).IsA, "the click-hint scale is not a UIScale")
	(v49 ^ "clickPart").clickPart = ReplicatedStorage.Assets.Billboards.BillboardTutorialClick.Clone
	ReplicatedStorage.Assets.Billboards.BillboardTutorialClick.Clone.BillboardGui.Image.UIScale.Scale = 1
	local Scale = { Scale = 1.3 }
	(v49 ^ "clickPart").clickTween = TweenService.Create
end
function _index.DropWorldClickHint(v51) -- proto[26], line 543
	v51.clickTween = nil
	if v51.clickPart == nil then return end
	v51.clickPart = nil
end
function _index.SetScreenClickHint(v52, v53) -- proto[27], line 554  -- upvalues: boolean, Players, TweenService, r1
	assert((Players.LocalPlayer.WaitForChild).IsA, "LocalPlayer.PlayerGui is not a PlayerGui")
	assert(((Players.LocalPlayer.WaitForChild).WaitForChild).IsA, "PlayerGui.TutorialClick is not a ScreenGui")
	assert(((Players.LocalPlayer.WaitForChild).WaitForChild.Image).IsA, "TutorialClick.Image is not a ImageLabel")
	assert(((Players.LocalPlayer.WaitForChild).WaitForChild.Image.UIScale).IsA, "TutorialClick.Image.UIScale is not a UIScale")
	(v52 ^ "LocalPlayer").screenClick = (Players.LocalPlayer.WaitForChild).WaitForChild
	if not (v53) then
		return
	end
	(Players.LocalPlayer.WaitForChild).WaitForChild.Enabled = true
	if (v52 ^ "LocalPlayer").screenClickTween ~= nil then return end
	(Players.LocalPlayer.WaitForChild).WaitForChild.Image.UIScale.Scale = 1
	local Scale = { Scale = 1.3 }
	((v52 ^ "LocalPlayer") * (v52 ^ "LocalPlayer")).screenClickTween = TweenService.Create
end
function _index.DropScreenClickHint(v54) -- proto[28], line 579
	v54.screenClickTween = nil
	if v54.screenClick == nil then return end
	v54.screenClick.Enabled = false
end
function _index.RingButton(v55, v56) -- proto[29], line 588  -- upvalues: ReplicatedStorage, TutorialHighlightOverlay
	v55.dropRingLater = TutorialHighlightOverlay.Attach
end
function _index.DropRing(v57) -- proto[30], line 595
	if v57.dropRingLater == nil then return end
	v57.dropRingLater = nil
end
function _index.PointArrowAt(v58, v59, v60, v61) -- proto[31], line 603  -- upvalues: ArrowPointer3D
	assert(v59.IsA, "a tutorial anchor has to be a BasePart or a Vector3")
	assert(v60.IsA, "a tutorial anchor has to be a BasePart or a Vector3")
	assert(ArrowPointer3D.__types.OptionalConfig(v61))
	(v58 ^ "typeof").arrow = ArrowPointer3D.new
end
function _index.RetargetArrow(v62, v63) -- proto[32], line 619
	assert(v63.IsA, "a tutorial anchor has to be a BasePart or a Vector3")
	local _r2 = assert(v62.arrow, "there is no tutorial arrow to retarget")
end
function _index.RebaseArrow(v64, v65) -- proto[33], line 625
	assert(v65.IsA, "a tutorial anchor has to be a BasePart or a Vector3")
	local _r2 = assert(v64.arrow, "there is no tutorial arrow to rebase")
end
function _index.DropArrow(v66) -- proto[34], line 631
	if v66.arrow == nil then return end
	v66.arrow = nil
end
function _index.DropEverything(v67) -- proto[35], line 640
end
function _index.Destroy(v68) -- proto[36], line 651  -- upvalues: ReplicatedStorage
	local w2 = v68.progress
	if not v68.ownsReadyScale then return end
	if w2 == nil then return end
	v68.progress = nil
end
return _index