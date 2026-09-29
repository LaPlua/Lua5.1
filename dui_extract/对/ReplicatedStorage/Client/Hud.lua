-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Hud
-- ============================================

-- bytecode
-- Original size: 5153 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 83, Protos: 10, Main proto: 9

-- ============== SOURCE ==============
-- main chunk (proto[9], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local Game = { Game = "GameHUD", Treadmill = "TradmilHud" }
local EggsButton = {}
EggsButton.EggsButton = {"RightButtons", "EggsButton"}
EggsButton.ExperimentTimer = {"BottomRight", "ExperimentTimer"}
EggsButton.ExperimentTimerValue = {"BottomRight", "ExperimentTimer", "Value"}
EggsButton.IndexButton = {"LeftControls", "IndexBTN"}
EggsButton.IndexNotificationBadge = {"LeftControls", "IndexBTN", "NotificationBadge"}
EggsButton.Money = {"BottomLeft", "Money"}
EggsButton.MoneyIcon = {"BottomLeft", "Money", "Icon"}
EggsButton.MoneyValue = {"BottomLeft", "Money", "Value"}
EggsButton.NightTimer = {"BottomRight", "NightTimer"}
EggsButton.NightTimerIcon = {"BottomRight", "NightTimer", "ImageLabel"}
EggsButton.NightTimerValue = {"BottomRight", "NightTimer", "Value"}
EggsButton.PetsButton = {"RightButtons", "PetsButton"}
EggsButton.QuestlineBadge = {"RightButtons", "QuestlineButton", "Badge"}
EggsButton.QuestlineButton = {"RightButtons", "QuestlineButton"}
EggsButton.RiftButton = {"RightButtons", "RiftButton"}
EggsButton.ShopButton = {"LeftControls", "ShopBTN"}
EggsButton.SlowToggle = {"LeftControls", "Slowmode"}
EggsButton.SlowToggleHitbox = {"LeftControls", "Slowmode", "Hitbox"}
EggsButton.SlowToggleKnob = {"LeftControls", "Slowmode", "Btn"}
EggsButton.SlowToggleLabel = {"LeftControls", "Slowmode", "txt"}
EggsButton.Speed = {"BottomLeft", "Speed"}
EggsButton.SpeedMultiButton = {"LeftControls", "SpeedMulti"}
EggsButton.SpeedMultiShine = {"LeftControls", "SpeedMulti", "Glow"}
EggsButton.SpeedShopButton = {"BottomLeft", "Speed", "ShopBTN"}
EggsButton.SpeedValue = {"BottomLeft", "Speed", "Value"}
EggsButton.FriendBoost = {"BottomLeft", "FriendBoost"}
EggsButton.TemporarySpeedBoost = {"BottomLeft", "TemporarySpeedBoost"}
local r1 = GUI.HUD()
r1.ResetOnSpawn = false
local s1 = {}
local s2 = {}
local Screen = {}
local walk = <closure K60>
local function walk(v1, v2, v3) -- proto[0], line 72  -- upvalues: walk
	if v2[v3] == nil then return v1 end
	for _k7, _v8 in ipairs(v1.GetChildren) do
		if _v8.Name ~= v2[v3] then continue end
		if walk ~= nil then return walk end
	end
	return nil
end
local s3 = Game
ReplicatedStorage = r1
local function variantFrame(v4) -- proto[1], line 90  -- upvalues: s1, s3, ReplicatedStorage
	local w1 = s3[v4]
	local f1
	local v1_e = s1[v4]
	if v1_e then return v1_e end
	f1 = not (s3[v4] == nil)
	assert(f1, (("no HUD variant named %*"):format(v4)))
	assert((ReplicatedStorage.FindFirstChild).IsA, (("HUD.%* must be a Frame"):format(w1)))
	s1[v4] = ReplicatedStorage.FindFirstChild
	return ReplicatedStorage.FindFirstChild
end
local s4 = EggsButton
local function chainFor(v5) -- proto[2], line 105  -- upvalues: s4
	local f2 = not (s4[v5] == nil)
	assert(f2, (("no HUD role is registered under %*"):format(v5)))
	return s4[v5]
end
function Screen.Screen() -- proto[3], line 115  -- upvalues: ReplicatedStorage
	return ReplicatedStorage
end
function Screen.Frame(v6) -- proto[4], line 119  -- upvalues: s1, s3, ReplicatedStorage
	local f3
	local v1_e = s1[(v6 or "Game")]
	if v1_e then return v1_e end
	f3 = not (s3[(v6 or "Game")] == nil)
	assert(f3, (("no HUD variant named %*"):format(v6 or "Game")))
	assert((ReplicatedStorage.FindFirstChild).IsA, (("HUD.%* must be a Frame"):format(s3[(v6 or "Game")])))
	s1[(v6 or "Game")] = ReplicatedStorage.FindFirstChild
	return ReplicatedStorage.FindFirstChild
end
function Screen.Find(v7, v8) -- proto[5], line 125  -- upvalues: s2, walk, s1, s3, ReplicatedStorage, s4
	local f4
	local f5
	if s2[(v8 or "Game")] == nil then
		s2[(v8 or "Game")] = {}
	end
	if _r3[v7] ~= nil then return _r3[v7] end
	if not ((s1[(v8 or "Game")])) then
		f4 = not (s3[(v8 or "Game")] == nil)
		assert(f4, (("no HUD variant named %*"):format(v8 or "Game")))
		assert((ReplicatedStorage.FindFirstChild).IsA, (("HUD.%* must be a Frame"):format(s3[(v8 or "Game")])))
		s1[(v8 or "Game")] = ReplicatedStorage.FindFirstChild
	end
	f5 = not (s4[v7] == nil)
	assert(f5, (("no HUD role is registered under %*"):format(v7)))
	_r3[v7] = walk
	return _r3[v7]
end
local s5 = Screen
function Screen.Get(v9, v10) -- proto[6], line 140  -- upvalues: s5, s3, s4
	local f6
	local f1
	local v_u1 = v10
	f1 = not (s5.Find == nil)
	f6 = not (s4[v9] == nil)
	assert(f6, (("no HUD role is registered under %*"):format(v9)))
	local r2 = ("HUD.%*.%* is missing"):format(s3[(v10 or "Game")], table.concat)
	assert(f1, r2)
	return s5.Find
end
function Screen.Every(v11) -- proto[7], line 148  -- upvalues: s3, s5
	local _r1 = {}
	for _v5 in ipairs(s3) do
		local v_u2 = _k5
		if s5.Find == nil then continue end
		table.insert(_r1, s5.Find)
	end
	return _r1
end
function Screen.SetTreadmillActive(v12) -- proto[8], line 159  -- upvalues: s1, s3, ReplicatedStorage
	local v_u3
	local f7
	local Game = s1.Game
	if not (Game) then
		f7 = not (s3.Game == nil)
		assert(f7, "no HUD variant named Game")
		assert((ReplicatedStorage.FindFirstChild).IsA, (("HUD.%* must be a Frame"):format(s3.Game)))
		s1.Game = ReplicatedStorage.FindFirstChild
		v_u3 = ReplicatedStorage.FindFirstChild
	end
	v_u3.Visible = (not v12)
	local Treadmill = s1.Treadmill
	if Treadmill then
		v_u3 = Treadmill
	else
		f7 = not (s3.Treadmill == nil)
		assert(f7, "no HUD variant named Treadmill")
		assert((ReplicatedStorage.FindFirstChild).IsA, (("HUD.%* must be a Frame"):format(s3.Treadmill)))
		s1.Treadmill = ReplicatedStorage.FindFirstChild
		v_u3 = ReplicatedStorage.FindFirstChild
	end
	v_u3.Visible = v12
end
return table.freeze(Screen)