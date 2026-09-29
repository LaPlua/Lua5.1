-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.MusicDirector
-- ============================================

-- bytecode
-- Original size: 6800 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 107, Protos: 21, Main proto: 20

-- ============== SOURCE ==============
local r1
local r2
-- main chunk (proto[20], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Player = require(ReplicatedStorage.Shared.Player)
local Preferences = require(ReplicatedStorage.Shared.Preferences)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local AreaEggResetCycle = require(ReplicatedStorage.Data.AreaEggResetCycle)
local Numeric = require(ReplicatedStorage.Shared.Utils.Numeric)
local TreadmillVideoGate = require(ReplicatedStorage.Client.TreadmillVideoGate)
local _r14 = {1836009208, 1846088038, 9045766074, 1842150151}
local World = Workspace:WaitForChild("World")
local Areas = World:WaitForChild("Areas")
local SeparationLine = Areas:WaitForChild("SeparationLine")
local r3 = table.clone(_r14)
Numeric.Shuffle(r3, Random.new())
local Name = { Name = "OutdoorMusic", Source = r3[1], Looped = false }
local r4 = Audio.MusicTrack(Name)
local Name_2 = { Name = "ArenaMusic", Source = 5026653246, Looped = true }
local r5 = Audio.MusicTrack(Name_2)
local Name_3 = { Name = "ChaseMusic", Source = 77770487605071, Looped = true }
local r6 = Audio.MusicTrack(Name_3)
local Name_4 = { Name = "SafeZoneMusic", Source = 77770487605071, Looped = true }
local r7 = Audio.MusicTrack(Name_4)
if AreaEggResetCycle.NightMusic then
	local Name_5 = { Name = "ResetNightMusic", Source = AreaEggResetCycle.NightMusic.Id, Looped = true }
	r1 = Audio.MusicTrack(Name_5)
else
	r1 = nil
end
local Name_6 = { Name = "DrScrambleMusic", Source = 116561685928578, Looped = true }
local r8 = Audio.MusicTrack(Name_6)
local _r28 = {r4, r5, r6, r7, r8}
if r1 then
	table.insert(_r28, r1)
end
local s1 = {}
local r9 = Preferences.IsOn("Music")
local r10 = HiddenUIHandler.IsHidden()
local function fade(self, v1, v2, v3) -- proto[1], line 65  -- upvalues: s1, Audio
	local Volume = { Volume = v1, Seconds = v2, Style = Enum.EasingStyle.Quad, Direction = Enum.EasingDirection.InOut }
	s1[self] = Audio.FadeTo
end
local f1 = false
local function treadmillFeedActive() -- proto[2], line 94  -- upvalues: f1, TreadmillVideoGate
	if not f1 then return (not TreadmillVideoGate.IsVideoPlayerDisabled) end
	return (not TreadmillVideoGate.IsVideoPlayerDisabled)
end
ReplicatedStorage = r9
local f2 = false
local f3 = false
local ReplicatedStorage_2 = r10
local f4 = false
local f5 = false
local f6 = false
local f7 = false
local f8 = false
local function mode() -- proto[3], line 98  -- upvalues: ReplicatedStorage, f1, f2, f3, TreadmillVideoGate, ReplicatedStorage_2, f4, f5, f6, f7, f8
	if not (ReplicatedStorage) then return "Silent" end
	if f1 then
		if not (f2) then
			if TreadmillVideoGate.IsVideoPlayerDisabled then
				if not (ReplicatedStorage_2) then return "Scramble" end
				if f4 then return "Night" end
				if (not TreadmillVideoGate.IsVideoPlayerDisabled) then return "Treadmill" end
				if f2 then return "Silent" end
				if f5 then return "Silent" end
				if f6 then
					if not f7 then return "Arena" end
					return "Chase"
				end
			end
		end
	end
	if ReplicatedStorage_2 then return "Silent" end
	if not f8 then return "Outdoor" end
	return "SafeZone"
end
local _ = ""
local ReplicatedStorage_3 = r4
local ReplicatedStorage_4 = r5
local ReplicatedStorage_5 = r6
local ReplicatedStorage_6 = r7
local ReplicatedStorage_7 = r8
local f9 = r1
local f10 = false
local function refresh() -- proto[4], line 121  -- upvalues: ReplicatedStorage, f1, f2, f3, TreadmillVideoGate, ReplicatedStorage_2, f4, f5, f6, f7, f8, _, fade, ReplicatedStorage_3, ReplicatedStorage_4, ReplicatedStorage_5, ReplicatedStorage_6, ReplicatedStorage_7, f9, f10, AreaEggResetCycle, SoundService
	_ = "Outdoor"
	if "Outdoor" ~= "Chase" then
		if not SoundService.Music.FindFirstChild then return end
		if not (SoundService.Music.FindFirstChild).IsA then return end
		SoundService.Music.FindFirstChild.Volume = 1
	end
end
local IsPastLine = false
local function updateArena() -- proto[5], line 147  -- upvalues: Player, LocalPlayer, GuardAreaGeometry, SeparationLine, IsPastLine, refresh
	local LocalPlayer_2
	if Player.FindRootPart ~= nil then
		LocalPlayer_2 = GuardAreaGeometry.IsPastLine
	end
	if IsPastLine == LocalPlayer_2 then return end
	IsPastLine = LocalPlayer_2
end
local function EnterSaveZone() -- proto[6], line 156  -- upvalues: f1, refresh
	if f1 then return end
	f1 = true
end
local function ExitSaveZone() -- proto[7], line 163  -- upvalues: f1, refresh
	if not f1 then return end
	f1 = false
end
local function HasCustomTreadmill() -- proto[8], line 170  -- upvalues: U0
	return U0
end
local function SetCarryingAreaEgg(v5) -- proto[9], line 174  -- upvalues: U0, refresh
	local U0
	if U0 == v5 then return end
	U0 = v5
end
local function SetGuardedGameplay(v6) -- proto[10], line 181  -- upvalues: U0, refresh
	local U0
	if U0 == v6 then return end
	U0 = v6
end
local function SetScrambleActive(v7) -- proto[11], line 188  -- upvalues: U0, refresh
	local U0
	if U0 == v7 then return end
	U0 = v7
end
local function SetEventMusic(v8) -- proto[12], line 195  -- upvalues: U0, refresh
	local U0
	if U0 == v8 then return end
	U0 = v8
end
local function SetResetNight(v9, v10) -- proto[13], line 202  -- upvalues: U0, f1, refresh
	local U0
	local f11
	if v9 then
		f11 = not (v10 ~= true)
	end
	if U0 == v9 then
		if f1 == f11 then return end
	end
	U0 = v9
	f1 = f11
end
local _r15 = { EnterSaveZone = EnterSaveZone, ExitSaveZone = ExitSaveZone, HasCustomTreadmill = HasCustomTreadmill, SetCarryingAreaEgg = SetCarryingAreaEgg, SetGuardedGameplay = SetGuardedGameplay, SetScrambleActive = SetScrambleActive, SetEventMusic = SetEventMusic, SetResetNight = SetResetNight }
local index = 1
Numeric = Numeric.Shuffle
r4.Ended:Connect(function()
	index = (index + 1)
	if (#r3) < index then
		Numeric(r3, Random.new())
		index = 1
	end
	ReplicatedStorage.SoundId = (("rbxassetid://%*"):format(r3[index]))
end)
Preferences.Observe("Music", function(v11)
	if v11 == ReplicatedStorage then return end
	ReplicatedStorage = v11
end)
HiddenUIHandler.Changed:Connect(function(v12)
	ReplicatedStorage = v12
end)
Remotes.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(v13)
	local f12 = not (v13 == nil)
	f1 = f12
end)
TreadmillVideoGate.Changed:Connect(function()
	if not f1 then return end
end)
RunService.Heartbeat:Connect(function(v14)
	index = (index + v14)
	if 0.1 > index then return end
	index = (index % 0.1)
	if Player.FindRootPart ~= nil then
		LocalPlayer_2 = GuardAreaGeometry.IsPastLine
	end
	if IsPastLine == LocalPlayer_2 then return end
	IsPastLine = LocalPlayer_2
end)
r4:Play()
local r11 = Player.FindRootPart(Players.LocalPlayer)
if r11 ~= nil then
	r2 = GuardAreaGeometry.IsPastLine(SeparationLine, r11.Position)
end
if false ~= r2 then
	refresh()
end
refresh()
return table.freeze(_r15)