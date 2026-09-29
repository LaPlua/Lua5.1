-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.BossEvent
-- ============================================

-- bytecode
-- Original size: 3002 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 54, Protos: 11, Main proto: 10

-- ============== SOURCE ==============
-- main chunk (proto[10], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local BossEventFlags = require(ReplicatedStorage.Shared.Flags.BossEventFlags)
local BossEventSounds = ReplicatedStorage.Assets.Sounds:WaitForChild("BossEventSounds")
local s1 = {}
local function CurrentPeriod() -- proto[0], line 54  -- upvalues: Workspace
	return R0
end
local function PeriodStart(v1) -- proto[1], line 58
	return (v1 * 1800)
end
local function ClampDuration(v2) -- proto[2], line 64
	return (math.clamp(v2, 1, 1740))
end
local function HealthMultiplier(v3) -- proto[3], line 71  -- upvalues: BossEventFlags
	local r1 = math.max((math.floor(v3)), 1)
	local r2 = nil
	local v_u1 = nil
	for _k9, _v10 in ipairs(BossEventFlags.HealthScalesWithPlayers.Get) do
		local _r11 = tonumber(_k9)
		if _r11 == nil then continue end
		if _r11 <= r1 and -inf < _r11 then
			r2 = _v10
		end
		if _r11 >= inf then continue end
		v_u1 = _v10
	end
	local v_u2 = r2
	if v_u2 then return 1 end
	v_u2 = v_u1
	if v_u2 then return 1 end
	return 1
end
local function soundNamed(v4) -- proto[4], line 99  -- upvalues: s1, BossEventSounds
	if s1[v4] ~= nil then return s1[v4] end
	assert((BossEventSounds.FindFirstChild).IsA, (("BossEventSounds needs the Sound %*"):format(v4)))
	s1[v4] = BossEventSounds.FindFirstChild
	return BossEventSounds.FindFirstChild
end
local s2 = nil
local function PlaySound(v5, v6, v7) -- proto[5], line 114  -- upvalues: s1, BossEventSounds, s2, RunService, Audio
	local MaxDistance
	if not (s1[v5] ~= nil) then
		assert((BossEventSounds.FindFirstChild).IsA, (("BossEventSounds needs the Sound %*"):format(v5)))
		s1[v5] = BossEventSounds.FindFirstChild
	end
	if not ((v7 ~= nil)) then
		MaxDistance = {}
	end
	local v_u3 = (MaxDistance.MaxDistance or BossEventSounds.FindFirstChild.RollOffMaxDistance)
	MaxDistance.MaxDistance = v_u3
	MaxDistance.SoundGroup = (MaxDistance.SoundGroup or "SFX")
	if not RunService.IsServer then return Audio.Play(BossEventSounds.FindFirstChild, v6, MaxDistance) end
	if s2 == nil then return Audio.Play(BossEventSounds.FindFirstChild, v6, MaxDistance) end
	if MaxDistance.Recipient ~= nil then return Audio.Play(BossEventSounds.FindFirstChild, v6, MaxDistance) end
	for _k9, _v10 in ipairs(s2) do
		table.clone.Recipient = _v10
	end
	return nil
end
local function SetAudience(v8) -- proto[6], line 136  -- upvalues: U0
	local U0
	U0 = v8
end
local function PlaySoundEverywhere(v9, v10) -- proto[7], line 144  -- upvalues: s2, BossEventSounds
	return s2.PlaySound(v9, BossEventSounds, v10)
end
local function CurrentWindow(v11) -- proto[8], line 148  -- upvalues: s2, Workspace
	local Open
	if (Workspace.GetServerTimeNow - s2.PeriodStart) < s2.ClampDuration then
		Open = { Open = true, OpensAt = s2.PeriodStart, ClosesAt = (s2.PeriodStart + s2.ClampDuration) }
		return Open
	end
	local Open_2 = { Open = false, OpensAt = (s2.PeriodStart + 1800), ClosesAt = ((s2.PeriodStart + 1800) + s2.ClampDuration) }
	return Open_2
end
local function SecondsUntilNextOpen() -- proto[9], line 169  -- upvalues: Workspace
	return (1800 - (Workspace.GetServerTimeNow % 1800))
end
local IntervalSeconds = { IntervalSeconds = 1800, BossName = "Abyss Overlord", CurrentPeriod = CurrentPeriod, PeriodStart = PeriodStart, ClampDuration = ClampDuration, HealthMultiplier = HealthMultiplier, PlaySound = PlaySound, SetAudience = SetAudience, PlaySoundEverywhere = PlaySoundEverywhere, CurrentWindow = CurrentWindow, SecondsUntilNextOpen = SecondsUntilNextOpen }
return table.freeze(IntervalSeconds)