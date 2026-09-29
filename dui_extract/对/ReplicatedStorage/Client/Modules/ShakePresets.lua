-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Modules.ShakePresets
-- ============================================

-- bytecode
-- Original size: 2428 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 44, Protos: 5, Main proto: 4

-- ============== SOURCE ==============
-- main chunk (proto[4], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Shake = require(ReplicatedStorage.Packages.Shake)
local _r3 = {}
local _r4 = {"Bump", 2.5, 0.25, 0.1, 0.75, Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448), Vector3.new(1, 1, 1)}
local _r5 = {"BumpS", 1.5, 0.25, 0.1, 0.75, Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448), Vector3.new(1, 1, 1)}
local _r6 = {"Explosion", 5, 0.1, 0, 1.5, Vector3.new(0.25, 0.25, 0.25), Vector3.new(4, 1, 1)}
local _r7 = {"Earthquake", 0.6, 0.2857142857142857, 2, 10, Vector3.new(0.25, 0.25, 0.25), Vector3.new(1, 1, 4)}
local _r8 = {"BadTrip", 10, 6.666666666666667, 5, 10, Vector3.new(0, 0, 0.15000000596046448), Vector3.new(2, 1, 4)}
local _r9 = {"HandheldCamera", 1, 0.25, 5, 10, Vector3.new(0, 0, 0), Vector3.new(1, 0.5, 0.5)}
_r3[1], _r3[2], _r3[3], _r3[4], _r3[5], _r3[6], _r3[7], _r3[8] = _r4, _r5, _r6, _r7, _r8, _r9, {"Vibration", 0.4, 0.05, 2, 2, Vector3.new(0, 0.15000000596046448, 0), Vector3.new(1.25, 0, 4)}, {"RoughDriving", 1, 0.5, 1, 1, Vector3.new(0, 0, 0), Vector3.new(1, 1, 1)}
local DriveCamera = {}
for _k8, _v9 in ipairs(_r3) do
	local r1 = Shake.new()
	r1.Amplitude = _v9[2]
	r1.Frequency = _v9[3]
	r1.FadeInTime = _v9[4]
	r1.FadeOutTime = _v9[5]
	r1.PositionInfluence = _v9[6]
	r1.RotationInfluence = _v9[7]
	DriveCamera[_v9[1]] = r1
end
function DriveCamera.DriveCamera(v1, v2) -- proto[3], line 104  -- upvalues: Shake, RunService
	local v_u1 = v2
	if not (v_u1) then
		v_u1 = workspace.CurrentCamera
	end
	assert(v_u1, "no camera to attach a shake to")
	local v_u2 = nil
	local CFrame = nil
	local CurrentCamera = v_u1
	local f1 = true
	local connection = v_u2
	v_u2 = RunService.PostSimulation.Connect
	local Connect = v_u2
	local function anon2() -- proto[2], line 142  -- upvalues: Connect, v1
		if Connect then
			Connect = nil
		end
	end
	return anon2
end
return DriveCamera