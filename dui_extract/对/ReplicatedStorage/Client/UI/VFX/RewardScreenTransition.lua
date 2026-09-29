-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.VFX.RewardScreenTransition
-- ============================================

-- bytecode
-- Original size: 2372 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 50, Protos: 6, Main proto: 5

-- ============== SOURCE ==============
-- main chunk (proto[5], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local OverlayRoot = require(ReplicatedStorage.Client.UI.VFX.OverlayRoot)
local function quintOut(v1, v2) -- proto[0], line 9
	return TweenInfo.new(v1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, (v2 or 0))
end
local BackgroundColor3 = { BackgroundColor3 = (Color3.fromRGB(255, 175, 0)), BackgroundTransparency = 0, Size = (UDim2.new(1, 0, 1, 0)) }
local pitch = { pitch = 1, cues = {{ id = 91650233387983, volume = 0.8 }, { id = 112792997660073, volume = 1 }}, sheetProperties = BackgroundColor3, sheetFade = (TweenInfo.new(1.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0.05)), lensPush = (TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0.05)), lensSettle = (TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0)), lensWide = 100, lensResting = 70 }
local function stage(v3, v4, v5) -- proto[1], line 38  -- upvalues: TweenService
	return TweenService:Create(v3, v4, v5)
end
local s1 = pitch
local function anon4() -- proto[4], line 42  -- upvalues: s1, Audio, OverlayRoot, TweenService
	for _k3, _v4 in ipairs(s1.cues) do
		local PlaybackSpeed = { PlaybackSpeed = s1.pitch, Volume = _v4.volume }
	end
	for _k4, _v5 in ipairs(s1.sheetProperties) do
		Instance.new[_k4] = _v5
	end
	Instance.new.Parent = OverlayRoot
	local FieldOfView = {}
	FieldOfView.FieldOfView = s1.lensResting
	local FieldOfView_2 = {}
	FieldOfView_2.FieldOfView = s1.lensWide
	local BackgroundTransparency = { BackgroundTransparency = 1 }
	local new = (Instance.new ^ "cues")
end
return anon4