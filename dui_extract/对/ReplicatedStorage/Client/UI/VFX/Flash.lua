-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.VFX.Flash
-- ============================================

-- bytecode
-- Original size: 3297 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 61, Protos: 9, Main proto: 8

-- ============== SOURCE ==============
-- main chunk (proto[8], line 1)
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local OverlayRoot = require(script.Parent.OverlayRoot)
local Attack = { Attack = 0.5, Decay = 0.9, Tint = (Color3.new(1, 1, 1)), Opacity = 1 }
local style = { style = Enum.EasingStyle.Quint, direction = Enum.EasingDirection.Out }
local style_2 = { style = Enum.EasingStyle.Cubic, direction = Enum.EasingDirection.InOut }
local s1 = {}
s1 = nil
local function attach(v1) -- proto[1], line 48  -- upvalues: s1, OverlayRoot
	if s1 and s1.Parent then
		v1.Parent = s1
		return
	end
	local function anon0() -- proto[0], line 54  -- upvalues: OverlayRoot, s1, v1
		s1 = OverlayRoot
		v1.Parent = OverlayRoot
	end
end
local s2 = nil
local function sheetFor(v2) -- proto[3], line 61  -- upvalues: s1, s2, OverlayRoot
	local w1 = v2.ToHex
	local v1_e = s1[w1]
	if v1_e then return v1_e end
	Instance.new.Name = (("Wash_%*"):format(w1))
	Instance.new.ZIndex = 500
	Instance.new.BorderSizePixel = 0
	Instance.new.BackgroundColor3 = v2
	Instance.new.BackgroundTransparency = 1
	Instance.new.Size = UDim2.fromScale
	Instance.new.Visible = false
	local frame = { frame = Instance.new, startedAt = 0, keys = nil }
	s1[w1] = frame
	local ToHex = w1
	local data = frame
	if s2 and s2.Parent then
		Instance.new.Parent = s2
		return frame
	end
	local s1 = s2
	local v2 = Instance.new
	local function anon0() -- proto[0], line 54  -- upvalues: OverlayRoot, s1, v2
		s1 = OverlayRoot
		v2.Parent = OverlayRoot
	end
	return frame
end
local s3 = style
local s4 = style_2
local function envelope(v3, v4) -- proto[4], line 88  -- upvalues: s2, s3, s4
	local v_u1 = v4.Attack
	if not (v_u1) then
		v_u1 = s2.Attack
	end
	local v_u2 = v4.Decay
	if not (v_u2) then
		v_u2 = s2.Decay
	end
	local v_u3 = v4.Opacity
	if not (v_u3) then
		v_u3 = s2.Opacity
	end
	local r1 = math.clamp(v_u3, 0, 1)
	local _r5 = {}
	local level = { at = 0, level = v3, style = s3.style, direction = s3.direction }
	local at = { at = v_u1, level = r1, style = s3.style, direction = s3.direction }
	local level_2 = { at = (v_u1 + v_u2), level = 0, style = s4.style, direction = s4.direction }
	_r5[1], _r5[2], _r5[3] = level, at, level_2
	return _r5
end
local function levelAt(v5, v6) -- proto[5], line 100  -- upvalues: TweenService
	for _i = 2, (#v5) do
		if v6 >= v5[_i].at then continue end
		local v_u4 = v5[_i].at
		return (v5[(_i - 1)].level + ((v5[_i].level - v5[(_i - 1)].level) * TweenService.GetValue)), false
	end
	return v5[(#v5)].level, true
end
local connection = nil
local function step() -- proto[6], line 114  -- upvalues: s1, levelAt, connection
	local f1 = false
	for _k5, _v6 in ipairs(s1) do
		if _v6.keys == nil then continue end
		_v6.frame.BackgroundTransparency = (1 - levelAt)
		if _v6.keys then
			_v6.keys = nil
			_v6.frame.Visible = false
		else
			f1 = true
		end
	end
	if f1 then return end
	if not connection then return end
	connection = nil
end
local Play = {}
function Play.Play(v7) -- proto[7], line 139  -- upvalues: sheetFor, s2, envelope, U3, RunService, step
	local U3
	sheetFor.keys = envelope
	sheetFor.startedAt = os.clock
	sheetFor.frame.Visible = true
	if U3 == nil then
		U3 = RunService.Heartbeat.Connect
	end
end
return table.freeze(Play)