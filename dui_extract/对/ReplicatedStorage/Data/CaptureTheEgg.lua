-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.CaptureTheEgg
-- ============================================

-- bytecode
-- Original size: 1382 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 40, Protos: 2, Main proto: 1

-- ============== SOURCE ==============
-- main chunk (proto[1], line 1)
local EventDisplayName = { EventDisplayName = "Capture The Egg Event", EggDisplayName = "Event Egg", CarryCategory = "Baby Aurora Dragon", RewardCategory = "Baby Aurora Dragon", EggScale = 2, RewardScale = 1, CutsceneFallSeconds = 4, LandingSinkStuds = 0.35, LandingRotationDegrees = Vector3.new(-5, 28, 4), StarterRigName = "CaptureTheEggStarterRig", EggUidAttribute = "Event_CaptureTheEggUid", EggHighlightColor = (Color3.fromRGB(255, 214, 89)), BroadcastIconImage = "rbxassetid://116524274262912", SpawnMarkerName = "CaptureTheEggSpawn", FallbackMarkerName = "AdminAbuseEggSpawn", DanceAnimationId = "rbxassetid://507771019", R6DanceAnimationId = "rbxassetid://182435998", ScoreboardVisibleRows = 3 }
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BalanceConfig = require(ReplicatedStorage.Shared.Flags.BalanceConfig)
local EggScale = { EggScale = true, RewardScale = true }
EventDisplayName = BalanceConfig.Bind("Game.Balance.CaptureTheEgg", EventDisplayName, EggScale, false, function(v1)
	local f1
	if 0 < v1.EggScale then
		f1 = not (0 >= v1.RewardScale)
	end
	assert(f1)
end)
return EventDisplayName