-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Shake
-- ============================================

-- bytecode
-- Original size: 7331 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 95, Protos: 18, Main proto: 17

-- ============== SOURCE ==============
-- main chunk (proto[17], line 1)
local GuiService = game:GetService("GuiService")
local HapticService = game:GetService("HapticService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Client = ReplicatedStorage:WaitForChild("Client")
local PlatformController = require(Client.PlatformController)
local Player = require(ReplicatedStorage.Shared.Player)
local s1 = {3.7, 41.2, 88.9}
local s2 = {}
s2[Enum.VibrationMotor.Large] = 1
s2[Enum.VibrationMotor.Small] = 0.5
local _r12 = {1, 0.9952, 0.9808, 0.9569, 0.9239, 0.8819, 0.8315, 0.773, 0.7071, 0.6344, 0.5556, 0.4714, 0.3827, 0.2903, 0.1951, 0.098}
_r12[17] = 0
local _r12_2 = {0, 0.1951, 0.3827, 0.5556, 0.7071, 0.8315, 0.9239, 0.9808, 1, 0.9808, 0.9239, 0.8315, 0.7071, 0.5556, 0.3827, 0.1951}
_r12_2[17] = 0
local Fade = { Fade = _r12, Pulse = _r12_2 }
local r1 = Random.new()
local function canShake() -- proto[0], line 71  -- upvalues: Workspace, GuiService
	if Workspace.CurrentCamera == nil then return (not GuiService.ReducedMotionEnabled) end
	if Workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then return (not GuiService.ReducedMotionEnabled) end
	return (not GuiService.ReducedMotionEnabled)
end
local function smoothstep(v1, v2, v3) -- proto[1], line 78
	local r2 = math.clamp(((v3 - v1) / (v2 - v1)), 0, 1)
	return ((r2 * r2) * (3 - (r2 * 2)))
end
local function anchorPosition(v4) -- proto[2], line 85  -- upvalues: Player
	if (typeof(v4)) == "Vector3" then return v4 end
	if v4.IsA then
		if Player.FindRootPart == nil then return nil end
		return Player.FindRootPart.Position
	end
	if v4.IsA then
		return v4.GetPivot.Position
	end
	local w1 = v4.IsA
	if not w1 then return nil end
	return (v4 ^ "typeof").WorldPosition
end
local function rangeGain(v5) -- proto[3], line 104  -- upvalues: Player, anchorPosition
	if Player.FindRootPart == nil then return 1 end
	if anchorPosition == nil then return 1 end
	if v5.Far < (anchorPosition - Player.FindRootPart.Position).Magnitude then return nil end
	if v5.Far <= v5.Near then return 1 end
	local r2 = math.clamp((((anchorPosition - Player.FindRootPart.Position).Magnitude - v5.Near) / (v5.Far - v5.Near)), 0, 1)
	if 0 >= (1 - ((r2 * r2) * (3 - (r2 * 2)))) then return nil end
	return (1 - ((r2 * r2) * (3 - (r2 * 2))))
end
local s3 = Fade
local function envelopeAt(v6, v7) -- proto[4], line 121  -- upvalues: s3
	local r2 = math.clamp(v6, 0, 1)
	local r3 = math.floor((r2 * ((#s3[v7]) - 1)))
	local w2 = (r2 * ((#s3[v7]) - 1))
	local w3 = (r3 + 1)
	local w4 = ((r3 + 1) + 1)
	return (math.lerp(s3[v7][w3], s3[v7][(math.min(w4, (#s3[v7])))], (w2 - (w3 - 1))))
end
local function sampleOffset(v8, v9) -- proto[5], line 129  -- upvalues: s1
	for _k7, _v8 in ipairs(s1) do
		table.create[_k7] = ((math.noise * 2.2) * v9)
	end
	return (Vector3.new(table.create[1], table.create[2], table.create[3]))
end
local Gamepad1 = Enum.UserInputType.Gamepad1
local function rumblePad(v10) -- proto[6], line 139  -- upvalues: PlatformController, HapticService, Gamepad1
	if not (v10.rumble) then return nil end
	if not (PlatformController.IsConsole) then
		if not (PlatformController.IsMobile) then return nil end
		if not HapticService.IsVibrationSupported then return nil end
		return Gamepad1
	end
end
local function driveMotors(v11, v12) -- proto[7], line 149  -- upvalues: s2, HapticService
	for _k5, _v6 in ipairs(s2) do
	end
end
local function rumble(v13, v14) -- proto[8], line 155  -- upvalues: PlatformController, HapticService, Gamepad1, s2
	if nil == nil then return end
	local w5 = ((math.sqrt((math.clamp(v13.reach, 0, 1)))) * v14)
	for _k7, _v8 in ipairs(s2) do
	end
end
local function untouchedSinceLastWrite(v15, v16) -- proto[9], line 164
	if v15.lastWritten == nil then return v16.CFrame.FuzzyEq end
	return v16.CFrame.FuzzyEq
end
local function writeOffset(v17, v18, v19) -- proto[10], line 169
	local v_u1
	if v17.lastWritten ~= nil then
		v_u1 = v18.CFrame.FuzzyEq
	end
	v18.CFrame = ((v18.CFrame * CFrame.new) * CFrame.new)
	v17.lastWritten = ((v18.CFrame * CFrame.new) * CFrame.new)
	v17.appliedOffset = v19
end
local function stopLive() -- proto[11], line 180  -- upvalues: s3, RunService, Workspace, PlatformController, HapticService, Gamepad1, s2
	local v_u3
	local v_u2
	if s3 == nil then return end
	s3 = nil
	local CurrentCamera = Workspace.CurrentCamera
	if CurrentCamera then
		if s3.lastWritten ~= nil then
			v_u2 = s3.lastWritten
			v_u3 = CurrentCamera.CFrame.FuzzyEq
		end
		if v_u3 then
			v_u2 = s3.appliedOffset
			CurrentCamera.CFrame = (CurrentCamera.CFrame * CFrame.new)
		end
	end
	if nil == nil then return end
	for _k6, _v7 in ipairs(s2) do
	end
end
local function stepLive(v20) -- proto[12], line 198  -- upvalues: s3, Workspace, stopLive, s3, sampleOffset, PlatformController, HapticService, Gamepad1, s2
	local state_3_2
	local w5
	if (s3 == nil) or (Workspace.CurrentCamera == nil) then
		return
	end
	s3.elapsed = (s3.elapsed + v20)
	if s3.span <= s3.elapsed then
		return
	end
	local r2 = math.clamp((s3.elapsed / s3.span), 0, 1)
	local w6 = s3[s3.shape]
	local w7 = ((#s3[s3.shape]) - 1)
	local w8 = (r2 * w7)
	local w9 = (r2 * w7)
	local r3 = math.floor(w9)
	local w3 = (r3 + 1)
	local w4 = ((r3 + 1) + 1)
	local r4 = math.min(w4, (#w6))
	stopLive = math.lerp(w6[w3], w6[r4], (w8 - (w3 - 1)))
	s3.sinceSample = (s3.sinceSample + v20)
	local v_u1 = s3.offset
	if v_u1 ~= nil then
		s3.sinceSample = 0
		v_u1 = sampleOffset
		s3.offset = v_u1
		if nil ~= nil then
			w5 = ((math.sqrt((math.clamp(s3.reach, 0, 1)))) * stopLive)
			for _k10, _v11 in ipairs(s2) do
			end
		end
	end
	if s3.lastWritten ~= nil then
		state_3_2 = Workspace.CurrentCamera.CFrame.FuzzyEq
	end
	Workspace.CurrentCamera.CFrame = ((Workspace.CurrentCamera.CFrame * CFrame.new) * CFrame.new)
	s3.lastWritten = ((Workspace.CurrentCamera.CFrame * CFrame.new) * CFrame.new)
	s3.appliedOffset = v_u1
end
Player = (Enum.RenderPriority.Camera.Value + 1)
local function begin(v21) -- proto[13], line 224  -- upvalues: U0, RunService, Player, stepLive
	local U0
	U0 = v21
end
local function holdFor(v22) -- proto[14], line 230
	if v22 == nil then return 0 end
	if v22 > 0 then return (1 / v22) end
	return 0
end
local function Play(v23) -- proto[15], line 239  -- upvalues: Workspace, GuiService, stopLive, rangeGain, r1, s3, RunService, Player, stepLive
	local f1
	if GuiService.ReducedMotionEnabled then return end
	if 1 == nil then return end
	f1 = not ((v23 or {}).Rumble == false)
	local span = { span = ((v23 or {}).Seconds or 1), reach = (((v23 or {}).Magnitude or 1) * 1), hold = (1 / (v23 or {}).SamplesPerSecond), shape = "Fade", rumble = f1, seed = r1.NextNumber, elapsed = 0, sinceSample = 0, offset = nil, appliedOffset = Vector3.new(0, 0, 0), lastWritten = nil }
	s3 = span
end
local function Stop() -- proto[16], line 266  -- upvalues: stopLive
end
return table.freeze({ Play = Play, Stop = Stop })