-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.FuseMachineMotion
-- ============================================

-- bytecode
-- Original size: 3659 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 55, Protos: 9, Main proto: 8

-- ============== SOURCE ==============
-- main chunk (proto[8], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VFX = require(ReplicatedStorage.Shared.Utils.VFX)
local t = require(ReplicatedStorage.Packages.t)
local _r5 = {{ Seconds = 0.22, Rise = 2.6, Squash = 0.92, Stretch = 1.12, Pitch = -6, Roll = 5 }, { Seconds = 0.18, Rise = 1.65, Squash = 0.96, Stretch = 1.08, Pitch = 4, Roll = -3 }, { Seconds = 0.15, Rise = 0.9, Squash = 0.985, Stretch = 1.04, Pitch = -2, Roll = 1.5 }}
local Bounce = {}
local EasingStyle = Enum.EasingStyle
local EasingDirection = Enum.EasingDirection
local function backOut(v1) -- proto[0], line 41  -- upvalues: TweenService, EasingStyle, EasingDirection
	return TweenService:GetValue(v1, EasingStyle.Back, EasingDirection.Out)
end
local function bounceOut(v2) -- proto[1], line 43  -- upvalues: TweenService, EasingStyle, EasingDirection
	return TweenService:GetValue(v2, EasingStyle.Bounce, EasingDirection.Out)
end
local function quadIn(v3) -- proto[2], line 45  -- upvalues: TweenService, EasingStyle, EasingDirection
	return TweenService:GetValue(v3, EasingStyle.Quad, EasingDirection.In)
end
local function locateEmitter(v4, v5) -- proto[3], line 47
	if v5.FindFirstChild then return v4.FindFirstChild end
	return v4.FindFirstChild
end
local function poseAt(v6, v7, v8) -- proto[4], line 52  -- upvalues: TweenService, EasingStyle, EasingDirection
	if v7 < 0.34 then
		local r1 = math.min((v7 / 0.34), 1)
		return (v6.Rise * TweenService.GetValue), (v6.Pitch * TweenService.GetValue), (v6.Roll * TweenService.GetValue), (v8 + ((v6.Stretch - v8) * TweenService.GetValue))
	end
	local r2 = math.max((v7 - 0.34), 0)
	local w1 = (r2 / 0.66)
	if w1 < 0.55 then
		return (v6.Rise * (1 - TweenService.GetValue)), (v6.Pitch * (1 - TweenService.GetValue)), (v6.Roll * (1 - TweenService.GetValue)), (v6.Squash + ((v8 - v6.Squash) * TweenService.GetValue))
	end
	return (v6.Rise * (1 - TweenService.GetValue)), (v6.Pitch * (1 - TweenService.GetValue)), (v6.Roll * (1 - TweenService.GetValue)), (v6.Squash + ((v8 - v6.Squash) * TweenService.GetValue))
end
function Bounce.Bounce(v9, v10) -- proto[5], line 80  -- upvalues: t, U1, RunService, poseAt
	local r3 = t.strict(t.instanceIsA("Model"))
	local w2 = (v9 ^ "strict")
	for _k7, _v8 in ipairs do
		local f1 = false
		while true do
			if 0 >= _v8.Seconds then break end
			if not (v10) then
				f1 = true
				break
			end
			local r1 = math.min((0 + RunService.PreRender.Wait), _v8.Seconds)
			local v_u2 = poseAt
			local r4 = math.rad(_v8)
			local r5 = math.rad(r1 / _v8.Seconds)
		end
		if (w2 * w2) <= K[134482] then continue end
		if f1 then return false end
	end
	return true
end
VFX = VFX.EmitTree
function Bounce.Burst(v11, v12) -- proto[6], line 117  -- upvalues: t, VFX
	local r3 = t.strict(t.instanceIsA("Model"))
	local r6 = t.strict(t.instanceIsA("BasePart"))
	if v11.FindFirstChild == nil then return end
end
local s1 = Bounce
function Bounce.Run(v13, v14, v15) -- proto[7], line 127  -- upvalues: t, s1
	local r3 = t.strict(t.instanceIsA("Model"))
	local r6 = t.strict(t.instanceIsA("BasePart"))
	if not s1.Bounce then return s1.Bounce end
	return s1.Bounce
end
return Bounce