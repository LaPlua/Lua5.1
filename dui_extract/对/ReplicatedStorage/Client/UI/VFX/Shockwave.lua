-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.VFX.Shockwave
-- ============================================

-- bytecode
-- Original size: 3548 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 64, Protos: 9, Main proto: 8

-- ============== SOURCE ==============
-- main chunk (proto[8], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local OverlayRoot = require(script.Parent.OverlayRoot)
local template = { template = ReplicatedStorage.Assets.UI.Misc.ShockSphere, seconds = 0.8, startTransparency = 0.1, coverage = 0.55, minPeak = 4, maxPeak = 200, fallbackScreenFactor = 16 }
local r1 = TweenInfo.new(template.seconds, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local r2 = TweenInfo.new(template.seconds, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local function midpoint(v1) -- proto[0], line 22
	return UDim2.fromOffset((v1.AbsolutePosition.X + (v1.AbsoluteSize.X * 0.5)), (v1.AbsolutePosition.Y + (v1.AbsoluteSize.Y * 0.5)))
end
local s1 = template
local function peakScaleFor(v2, v3) -- proto[1], line 27  -- upvalues: s1
	local v_u1
	local r3 = math.max(v2.AbsoluteSize.Magnitude, 1)
	local CurrentCamera = workspace.CurrentCamera
	if CurrentCamera then
		r3 = CurrentCamera.ViewportSize
		v_u1 = r3.Magnitude
	end
	return (math.clamp(((((r3 * s1.fallbackScreenFactor) / r3) * s1.coverage) * v3), s1.minPeak, s1.maxPeak))
end
local function timed(v4, v5) -- proto[2], line 36
	if v5 == v4.Time then return v4 end
	return TweenInfo.new
end
local function pulseOf(v6) -- proto[3], line 42
	if v6.FindFirstChildOfClass then
		if (v6.FindFirstChildOfClass).IsA then return v6.FindFirstChildOfClass end
		Instance.new.Parent = v6
		return Instance.new
	end
end
r2 = (r2)
local function anon7(v7, v8, v9, v10) -- proto[7], line 52  -- upvalues: s1, OverlayRoot, TweenService, r1, r2
	local v_u3
	local r3
	local _r13
	if (s1.template.Clone).FindFirstChildOfClass then
		Instance.new.Parent = s1.template.Clone
	end
	Instance.new.Scale = 0
	local v_u2 = v9
	if not (v_u2) then
		v_u2 = s1.startTransparency
	end
	s1.template.Clone.ImageTransparency = v_u2
	s1.template.Clone.Position = UDim2.fromOffset
	s1.template.Clone.Size = UDim2.fromOffset
	s1.template.Clone.Parent = OverlayRoot
	local Clone = s1.template.Clone
	local v7 = (v7 ^ "seconds")
	local function recentre() -- proto[4], line 68  -- upvalues: Clone, v7
		Clone.Position = UDim2.fromOffset
	end
	local s2 = {}
	s2[1], s2[2] = ((v7 ^ "seconds").GetPropertyChangedSignal).Connect, ((v7 ^ "seconds").GetPropertyChangedSignal):Connect(recentre)
	local s1 = s2
	local ImageTransparency = { ImageTransparency = 1 }
	if ((v7 ^ "seconds") * (v7 ^ "seconds")) > K[133627] then
		_r13 = {}
		r3 = math.max(((v7 ^ "seconds") * (v7 ^ "seconds")).AbsoluteSize.Magnitude, 1)
		local CurrentCamera = workspace.CurrentCamera
		if CurrentCamera then
			r3 = CurrentCamera.ViewportSize
			v_u3 = r3.Magnitude
		end
	end
	_r13.Scale = (math.clamp(((((r3 * s1.fallbackScreenFactor) / r3) * s1.coverage) * (v10 or 1)), s1.minPeak, s1.maxPeak))
	return s1.template.Clone
end
return anon7