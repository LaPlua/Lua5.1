-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.BaseUpgrade
-- ============================================

-- bytecode
-- Original size: 4081 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 78, Protos: 14, Main proto: 13

-- ============== SOURCE ==============
-- main chunk (proto[13], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Bases = require(ReplicatedStorage.Data.Bases)
local QueueLock = require(ReplicatedStorage.Shared.Modules.QueueLock)
local Log = require(ReplicatedStorage.Packages.Log)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Audio = require(ReplicatedStorage.Shared.Audio)
local t = require(ReplicatedStorage.Packages.t)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local r1 = Color3.fromRGB(255, 64, 64)
local soundId = { soundId = 119855061490364, pitchRange = {0.9, 1.1}, volume = 1.5 }
local r2 = Log.new()
local r3 = QueueLock.new()
local r4 = Signal.new()
local f1 = false
local function Begin() -- proto[0], line 52  -- upvalues: f1
	assert((not f1), "nested base upgrade transitions are not supported")
	f1 = true
end
local s1 = false
ReplicatedStorage = r4
local function Complete() -- proto[1], line 57  -- upvalues: s1, ReplicatedStorage
	assert(s1, "no base upgrade transition is in flight to finish")
	s1 = false
end
local function IsPlaying() -- proto[2], line 63  -- upvalues: U0
	return U0
end
local s2 = soundId
local function Play(v1) -- proto[3], line 65  -- upvalues: s1, Audio, s2
	local f2
	local v_u1 = workspace.CurrentCamera
	f2 = not (v_u1 == nil)
	assert(f2, "no render camera is bound on this client")
	local PlaybackSpeed = { PlaybackSpeed = s2.pitchRange, Volume = s2.volume }
end
local Completed = { Completed = r4, Begin = Begin, Complete = Complete, IsPlaying = IsPlaying, Play = Play }
local function tierAbove(v2) -- proto[4], line 83  -- upvalues: t, Bases
	local r5 = t.strict(t.intersection(t.integer, t.numberMin(0)))
	return (v2.BaseUpgradeLevel + 1), Bases.BASES[(v2.BaseUpgradeLevel + 1)]
end
local function isWithinBudget(v3, v4) -- proto[5], line 91
	if v4 == nil then return f2 end
	local f2 = false  -- skip 1
	f2 = true
	return f2
end
local function blockingNotice(v5, v6) -- proto[6], line 96  -- upvalues: r1
	local Text
	if v6 == nil then
		Text = { Text = "Max base upgrade reached", Seconds = 2 }
		return Text
	end
	if v5.Money >= v6.Cost then return nil end
	local Text_2 = { Text = "Not enough money", Seconds = 2, Color = r1 }
	return Text_2
end
local function playThenAsk() -- proto[8], line 109  -- upvalues: s1, Remotes
end
local ReplicatedStorage_2 = r2
local function PurchaseNextTier() -- proto[10], line 117  -- upvalues: Save, LocalPlayer, t, Bases, blockingNotice, Toast, ReplicatedStorage, TryCall, playThenAsk, ReplicatedStorage_2
	local f2 = not (Save.Await == nil)
	assert(f2, "local save data has not arrived yet")
	local r5 = t.strict(t.intersection(t.integer, t.numberMin(0)))
	if nil == nil then return false end
	return true
end
local function ResolveNextTier(v7) -- proto[11], line 142  -- upvalues: tierAbove
	return tierAbove(v7)
end
local function IsNextTierAffordable(v8) -- proto[12], line 146  -- upvalues: t, Bases
	local r5 = t.strict(t.intersection(t.integer, t.numberMin(0)))
	if Bases.BASES[(v8.BaseUpgradeLevel + 1)] == nil then return f3 end
	local f3 = false  -- skip 1
	f3 = true
	return f3
end
local Transition = { Transition = Completed, PurchaseNextTier = PurchaseNextTier, ResolveNextTier = ResolveNextTier, IsNextTierAffordable = IsNextTierAffordable }
return Transition