-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.WorldFX.HoverHighlight
-- ============================================

-- bytecode
-- Original size: 2403 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 55, Protos: 5, Main proto: 4

-- ============== SOURCE ==============
-- main chunk (proto[4], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local t = require(ReplicatedStorage.Packages.t)
local DepthMode = { DepthMode = Enum.HighlightDepthMode.Occluded, FillColor = (Color3.fromRGB(255, 255, 255)), FillTransparency = 1, OutlineColor = (Color3.fromRGB(255, 255, 255)), OutlineTransparency = 1 }
local fadeSeconds = { fadeSeconds = 0.2, easing = Enum.EasingStyle.Quad, direction = Enum.EasingDirection.Out, shown = { OutlineTransparency = 0 }, hidden = { OutlineTransparency = 1 }, restingLook = DepthMode }
local s1 = fadeSeconds
local function glide(v1, v2, v3) -- proto[0], line 25  -- upvalues: s1, TweenService
	return TweenService.Create
end
local function raise(v4, v5, v6) -- proto[1], line 33  -- upvalues: t, s1, TweenService
	local r1 = t.strict(t.instanceIsA("Model"))
	local r2 = t.strict(t.optional(t.number))
	for _k8, _v9 in ipairs(s1.restingLook) do
		Instance.new[_k8] = _v9
	end
	Instance.new.Adornee = (v4 ^ "strict")
	Instance.new.Name = v5
	Instance.new.Parent = (v4 ^ "strict")
	return Instance.new
end
local Completed = Enum.PlaybackState.Completed
local function lower(self, v7) -- proto[3], line 51  -- upvalues: t, Completed, s1, TweenService
	local w1 = self.IsA
	assert(w1, "fade-out was handed something that is not a Highlight")
	local r2 = t.strict(t.optional(t.number))
	local function reap(v8) -- proto[2], line 55  -- upvalues: Completed, self
		if v8 ~= Completed then return end
	end
end
local FadeIn = { FadeIn = raise, FadeOut = lower }
return FadeIn