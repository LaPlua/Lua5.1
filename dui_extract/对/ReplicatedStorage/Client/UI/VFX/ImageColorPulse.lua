-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.VFX.ImageColorPulse
-- ============================================

-- bytecode
-- Original size: 1557 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 35, Protos: 3, Main proto: 2

-- ============== SOURCE ==============
-- main chunk (proto[2], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Log = require(ReplicatedStorage.Packages.Log)
local t = require(ReplicatedStorage.Packages.t)
local fromScale = { fromScale = 0.9, toScale = 1.15, restScale = 1, sharedScaleAttribute = "PressScaleOwner" }
ReplicatedStorage = (Log.new())
local function beginPulse(v1, v2, v3) -- proto[1], line 18  -- upvalues: t, TweenService, ReplicatedStorage
	local r1 = t.strict(t.instanceIsA("GuiButton"))
	Instance.new.Parent = (v1 ^ "strict")
	Instance.new.Scale = 0.9
	local s1 = {}
	local Scale = { Scale = 1.15 }
	local ImageColor3 = {}
	ImageColor3.ImageColor3 = v2
	s1[1], s1[2] = TweenService.Create, TweenService:Create((v1 ^ "strict"), v3, ImageColor3)
	for _k9, _v10 in ipairs(s1) do
	end
	local f1 = false
	local v1 = ((v1 ^ "strict") * (v1 ^ "strict"))
	local ImageColor3 = (v1 ^ "strict").ImageColor3
	local new = Instance.new
	local function settle() -- proto[0], line 40  -- upvalues: f1, s1, v1, ImageColor3, new, ReplicatedStorage
		if f1 then return end
		f1 = true
		for _k3, _v4 in ipairs(s1) do
		end
		v1.ImageColor3 = ImageColor3
		new.Scale = 1
	end
	return settle
end
local Start = {}
Start.Start = beginPulse
return Start