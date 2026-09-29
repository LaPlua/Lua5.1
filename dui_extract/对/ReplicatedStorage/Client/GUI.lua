-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.GUI
-- ============================================

-- bytecode
-- Original size: 9998 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 143, Protos: 20, Main proto: 19

-- ============== SOURCE ==============
local PlayerGui
-- main chunk (proto[19], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ConsoleSignals = require(ReplicatedStorage.Client.ConsoleSignals)
local GUI = require(ReplicatedStorage.Client.Types.GUI)
local Signal = require(ReplicatedStorage.Packages.Signal)
local r1 = RunService:IsStudio()
local ActivePets = { ActivePets = true, AreaGui = true, AssetEggData = true, AssetHoverData = true, AutoSell = true, Backpack = "BackpackGui", BossMastery = true, BossShop = true, CaptureTheEggUI = true, DrScrambleEvent = "DrScrambleEventUI", DropHeldEgg = true, Fade = true, GetMoreSpeedOnHit = true, GreatBloomBanner = true, GroupReward = "FreeGift", GrowingEggs = true, HUD = true, Index = true, LightVsDarknessUI = true, Message = true, MonsterCharge = "MonsterChargeUI", MonsterChestRewards = true, MonsterEventTutorialFrame = true, Notifications = true, OfflineMoneyInPlot = true, PetFuse = true, PopupPrompt = true, RescueDragonFTUEQuest = true, ResetStartTimer = true, RiftTradeIn = true, DrScrambleTradeIn = true, RollbackReward = "RollbackRewardUI", SakuraCrystalCounter = true, SakuraEggCharge = true, SakuraEventTutorialFrame = true, SammyEventUI = true, ScrambleBossMastery = true, SellPrompt = true, Settings = true, Shop = "RobuxShop", SpeedGainAnimation = true, StaticTreadmillImageSurfaceGui = true, StolenVaultEvent = "StolenVaultEventUI", TopBarStandard = "TopbarStandard", TrailShop = true, TreadmillScreenButtonShare = true, TreadmillScreenButtonSwapLeft = true, TreadmillScreenButtonSwapRight = true, TreadmillScreenComments = true, TreadmillScreenFriendLikes = true, TreadmillScreenSideButtons = true, TreadmillVideoSurfaceGui = true, TutorialInstructions = true }
local AssetHoverData = { AssetHoverData = "ScreenGui", GetMoreSpeedOnHit = "ScreenGui", MonsterCharge = "ScreenGui" }
local function shape(v1, v2) -- proto[0], line 87
	local class = { class = v1, children = v2 }
	return class
end
local Icon = { Icon = { class = "ImageButton", children = nil }, Timer = { class = "TextLabel", children = nil } }
local class_3 = { class = "Frame", children = Icon }
local _r12 = {}
local _r14 = {}
local _r16 = {}
local Button = {}
local Content = {}
local Value = {}
local TextLabel = {}
local class_4 = { class = "TextLabel", children = nil }
TextLabel.TextLabel = class_4
local class_5 = { class = "Frame", children = TextLabel }
Value.Value = class_5
local class_6 = { class = "Frame", children = Value }
Content.Content = class_6
local class_7 = { class = "ImageButton", children = Content }
Button.Button = class_7
local class_8 = { class = "Frame", children = Button }
local Luck = { Luck = class_8, x2Growth = class_3, x2Luck = class_3 }
local class_9 = { class = "Frame", children = Luck }
_r16.List = class_9
local class_10 = { class = "Frame", children = _r16 }
_r14.Holder = class_10
local class_11 = { class = "Frame", children = _r14 }
_r12.BottomFrame = class_11
local class_12 = { class = "ScreenGui", children = _r12 }
local s1 = nil
local function awaitChild(v3, v4) -- proto[1], line 117  -- upvalues: s1
	local w1 = v3.WaitForChild
	if w1 then return error end
	local w2 = v3.GetFullName
	local r2 = ("%* has no child named %*"):format(w2, v4)
	return error
end
if (nil ~= nil) then
	PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui", nil)
else
	class_11 = Players.LocalPlayer:WaitForChild("PlayerGui")
end
local PlayerGui_2 = class_11
if not (PlayerGui_2) then
	PlayerGui_2 = error((("%* has no child named PlayerGui"):format((Players.LocalPlayer:GetFullName()))), 2)
end
local function descend(v5, v6) -- proto[2], line 127  -- upvalues: s1
	local v_u1 = v5
	for _k6, _v7 in ipairs(v6) do
		local w3 = v_u1.WaitForChild
		v_u1 = w3
		if v_u1 then continue end
		local w4 = v_u1.GetFullName
		local r2 = ("%* has no child named %*"):format(w4, _v7)
		v_u1 = error
	end
	return v_u1
end
local conform = <closure K120>
local function conform(v7, v8, v9) -- proto[3], line 135  -- upvalues: conform, s1
	local w1 = v7.IsA
	assert(w1, (("%* is a %*, not the expected %*"):format(v9, v7.ClassName, v8.class)))
	for _k6, _v7 in {} do
		if not (v7.WaitForChild) then
			local w5 = v7.GetFullName
			local r3 = ("%* has no child named %*"):format(w5, _k6)
		end
		local r4 = ("%*.%*"):format(v9, _k6)
	end
end
local r5 = PlayerGui_2
local s2 = nil
local s3 = AssetHoverData
local function screenNamed(v10) -- proto[4], line 145  -- upvalues: s1, r5, s2, s3
	local w1 = s1[v10]
	local v_u2 = r5.WaitForChild
	if not (v_u2) then
		local r2 = ("%* has no child named %*"):format(r5.GetFullName, w1)
		v_u2 = error
	end
	if s3[v10] == nil then return v_u2 end
	local w2 = s3[v10]
	local w6 = v_u2.IsA
	assert(w6, (("%* is a %*, not the %* that GUI.%* promises"):format(w1, v_u2.ClassName, w2, (v10 ^ "WaitForChild"))))
	return v_u2
end
local function adoptScale(v11) -- proto[5], line 159
	if v11.FindFirstChildOfClass ~= nil then return v11.FindFirstChildOfClass end
	Instance.new.Scale = 0
	Instance.new.Parent = v11
	return Instance.new
end
local function resetTimerLabel() -- proto[6], line 170  -- upvalues: s1, r5, s2, s3
	local v_u3 = r5.WaitForChild
	if not (v_u3) then
		local r2 = ("%* has no child named %*"):format(r5.GetFullName, s1.ResetStartTimer)
		v_u3 = error
	end
	if s3.ResetStartTimer ~= nil then
		local w7 = v_u3.IsA
		assert(w7, (("%* is a %*, not the %* that GUI.ResetStartTimer promises"):format(s1.ResetStartTimer, v_u3.ClassName, s3.ResetStartTimer)))
	end
	local _r2 = {"Frame", "TextLabel"}
	local v_u4 = v_u3
	for _k6, _v7 in ipairs(_r2) do
		local w8 = v_u4.WaitForChild
		v_u4 = w8
		if v_u4 then continue end
		local w9 = v_u4.GetFullName
		local r4 = ("%* has no child named %*"):format(w9, _v7)
		v_u4 = error
	end
	return v_u4
end
local BottomUI = {}
local data = class_12
function BottomUI.BottomUI() -- proto[7], line 176  -- upvalues: r5, s1, conform, data
	local v_u4 = r5.WaitForChild
	if not (v_u4) then
		local r2 = ("%* has no child named BottomUI"):format(r5.GetFullName)
		v_u4 = error
	end
	return (v_u4 ^ "BottomUI")
end
function BottomUI.FadeFrame() -- proto[8], line 181  -- upvalues: s1, r5, s2, s3
	local v_u3 = r5.WaitForChild
	if not (v_u3) then
		local r2 = ("%* has no child named %*"):format(r5.GetFullName, s1.Fade)
		v_u3 = error
	end
	if s3.Fade ~= nil then
		local w7 = v_u3.IsA
		assert(w7, (("%* is a %*, not the %* that GUI.Fade promises"):format(s1.Fade, v_u3.ClassName, s3.Fade)))
	end
	local _r2 = {"Fade"}
	local v_u4 = v_u3
	for _k6, _v7 in ipairs(_r2) do
		local w8 = v_u4.WaitForChild
		v_u4 = w8
		if v_u4 then continue end
		local w9 = v_u4.GetFullName
		local r4 = ("%* has no child named %*"):format(w9, _v7)
		v_u4 = error
	end
	return v_u4
end
function BottomUI.PlayerGui() -- proto[9], line 184  -- upvalues: r5
	return r5
end
BottomUI.ResetStartTimerLabel = resetTimerLabel
function BottomUI.ResetStartTimerLabelScale() -- proto[10], line 188  -- upvalues: s1, r5, s2, s3
	local v_u1 = r5.WaitForChild
	if not (v_u1) then
		local r2 = ("%* has no child named %*"):format(r5.GetFullName, s1.ResetStartTimer)
		v_u1 = error
	end
	if s3.ResetStartTimer ~= nil then
		local w3 = v_u1.IsA
		assert(w3, (("%* is a %*, not the %* that GUI.ResetStartTimer promises"):format(s1.ResetStartTimer, v_u1.ClassName, s3.ResetStartTimer)))
	end
	local _r3 = {"Frame", "TextLabel"}
	local v_u3 = v_u1
	for _k7, _v8 in ipairs(_r3) do
		local w7 = v_u3.WaitForChild
		v_u3 = w7
		if v_u3 then continue end
		local w10 = v_u3.GetFullName
		local r4 = ("%* has no child named %*"):format(w10, _v8)
		v_u3 = error
	end
	if v_u3.FindFirstChildOfClass ~= nil then return v_u3.FindFirstChildOfClass end
	Instance.new.Scale = 0
	Instance.new.Parent = v_u3
	return Instance.new
end
s2 = {}
local s4 = BottomUI
local function accessorNamed(v12) -- proto[12], line 195  -- upvalues: s2, s4, s1, r5, s3, s3
	if s2[v12] ~= nil then return s2[v12] end
	local state_3_2 = s3
	local function anon11() -- proto[11], line 203  -- upvalues: v12, s1, r5, s3, state_3_2
		local v_u4 = r5.WaitForChild
		if not (v_u4) then
			local r2 = ("%* has no child named %*"):format(r5.GetFullName, s1[v12])
			v_u4 = error
		end
		if state_3_2[v12] == nil then return w9 end
		local w8 = v_u4.IsA
		local w9 = (v_u4 ^ "WaitForChild")
		assert(w8, (("%* is a %*, not the %* that GUI.%* promises"):format(s1[v12], w9.ClassName, state_3_2[v12], v12)))
		return w9
	end
	s2[v12] = anon11
	return anon11
end
local _index = {}
_index.__index = _index
local s5 = {}
local s6 = {}
function _index.Disconnect(v13) -- proto[13], line 229  -- upvalues: s5
	for _k4, _v5 in ipairs(v13.links) do
	end
	if s5[v13.button] ~= v13 then return end
	s5[v13.button] = nil
end
local OnActivated = {}
local s7 = _index
function OnActivated.OnActivated(self, v14) -- proto[16], line 243  -- upvalues: s5, s7, ConsoleSignals
	local button = { button = self, links = {} }
	local object = setmetatable(button, s7)
	table.insert(object.links, self.Activated:Connect(v14))
	table.insert(object.links, ConsoleSignals.ButtonUp:Connect(function(v15)
		if v15 ~= self then return end
	end))
	s5[self] = object
	return object
end
function OnActivated.Get(v16) -- proto[17], line 272  -- upvalues: s6, s2, s4, s1, r5, s3, s3
	local state_7_2
	if s6[v16] ~= nil then
		state_7_2 = s6[v16].Parent
		if state_7_2 ~= nil then return s6[v16] end
		if s2[v16] ~= nil then
			state_7_2 = s2[v16]
		end
	else
		local state_3_2 = s3
		local function anon11() -- proto[11], line 203  -- upvalues: v16, s1, r5, s3, state_3_2
			local v_u4 = r5.WaitForChild
			if not (v_u4) then
				local r2 = ("%* has no child named %*"):format(r5.GetFullName, s1[v16])
				v_u4 = error
			end
			if state_3_2[v16] == nil then return w9 end
			local w8 = v_u4.IsA
			local w9 = (v_u4 ^ "WaitForChild")
			assert(w8, (("%* is a %*, not the %* that GUI.%* promises"):format(s1[v16], w9.ClassName, state_3_2[v16], v16)))
			return w9
		end
		s2[v16] = anon11
		state_7_2 = anon11
	end
	if state_7_2 == nil then
		local r2 = ("GUI.Get: nothing is registered under %*"):format(v16)
	end
	s6[v16] = state_7_2
	return state_7_2
end
local _index_2 = {}
function _index_2.__index(v17, v18) -- proto[18], line 289  -- upvalues: s2, s4, s1, r5, s3, s3
	if s2[v18] ~= nil then
	else
		local v17 = v18
		local state_3_2 = s3
		local function anon11() -- proto[11], line 203  -- upvalues: v17, s1, r5, s3, state_3_2
			local v_u4 = r5.WaitForChild
			if not (v_u4) then
				local r2 = ("%* has no child named %*"):format(r5.GetFullName, s1[v17])
				v_u4 = error
			end
			if state_3_2[v17] == nil then return w9 end
			local w8 = v_u4.IsA
			local w9 = (v_u4 ^ "WaitForChild")
			assert(w8, (("%* is a %*, not the %* that GUI.%* promises"):format(s1[v17], w9.ClassName, state_3_2[v17], v17)))
			return w9
		end
		s2[v18] = anon11
	end
	if anon11 then return error end
	local r2 = ("GUI has no accessor named %*"):format(v18)
	return error
end
local object = setmetatable(OnActivated, _index_2)
return object