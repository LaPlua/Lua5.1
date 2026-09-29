-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.FallenPowerUp
-- ============================================

-- bytecode
-- Original size: 4793 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 128, Protos: 7, Main proto: 6

-- ============== SOURCE ==============
-- main chunk (proto[6], line 1)
local Magnet = {}
local Display = { Id = "Magnet", Display = "Ring Magnet", Color = (Color3.fromRGB(64, 164, 255)), Order = 1, Icon = "rbxassetid://78796564679501" }
Magnet.Magnet = Display
local Display_2 = { Id = "x2Rings", Display = "2x Rings", Color = (Color3.fromRGB(255, 176, 0)), Order = 2, Icon = "rbxassetid://138829174361176" }
Magnet.x2Rings = Display_2
local Display_3 = { Id = "Fusion", Display = "Fusion", Color = (Color3.fromRGB(96, 196, 66)), Order = 3, Icon = "rbxassetid://108854972154157" }
Magnet.Fusion = Display_3
local FallEase = { FallEase = 2.2, FallTimeNearScale = 0.85, FallTimeFarScale = 1.3, OriginLiftPerSpread = 0.35, PickupRadiusStuds = 7, PickupLagSeconds = 0.5, PickupRetrySeconds = 1.5, DropScatterStuds = 42, SpotAttempts = 12, SpreadStuds = 24, BobStuds = 0.65, BobSpeed = 2.6, SpinSpeed = 1.4, HoverStuds = 2.4, AbsorbSeconds = 0.32, MagnetPullSeconds = 0.42, MagnetPullSpinSpeed = 9, SkyLiftResponse = 2.4, HighlightFillTransparency = 0.5, HighlightPulseFill = 0.34, HighlightOutlineTransparency = 0, HighlightPulse = (TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)), LightBrightness = 2.4, LightRangeStuds = 16, TailLengthStuds = 40, TailWidthStuds = 11, TailTexture = "rbxassetid://134046679013293", BeaconTexture = "rbxassetid://134046679013293", BeaconBaseStuds = 4, BeaconHeightStuds = 272, BeaconWidthStuds = 5, BurstShockTexture = "rbxassetid://14057043166", BurstGlowTexture = "rbxassetid://17061556158", LandShakeSeconds = 0.55, LandShakeIntensity = 1.4, GlobalBumpSeconds = 0.38, GlobalBumpIntensity = 0.45, LandShakeFalloff = 0.7, BurstOriginScale = 2.4, TailSpeedRef = 90, TailMaxLengthStuds = 110, TailTipWidthStuds = 1.8, TailSparkRate = 90, TailSparkStuds = 1.8, PlumeWidthScale = 2.6, PlumeTransparency = 0.72, WorldScale = 4, FlightScale = 3.4, LandScaleSeconds = 0.3, HeadGlowTexture = "rbxassetid://17061556158", HeadPixelRef = 5600, HeadPixelMin = 38, HeadPixelMax = 210, HeadCoreScale = 0.42, MarkerTexture = "rbxassetid://14057043166", MarkerStartStuds = 58, MarkerEndStuds = 14, MarkerThickStuds = 0.05, MarkerLiftStuds = 0.15, MarkerPulseSpeed = 7, ShockwaveSeconds = 0.55, ShockwaveStuds = 72, LandFlashBrightness = 9, LandFlashRangeStuds = 46, RiserSoundId = "rbxassetid://101937236820642", RiserVolume = 0.4, ImpactSoundId = "rbxassetid://131273749621142", ImpactVolume = 0.7, ImpactRangeStuds = 260, HeadCloneScale = 0.55, HeadCloneHoverStuds = 3.4, HeadCloneGapStuds = 1.6, HeadCloneSpinSpeed = 1.8, HeadCloneBobStuds = 0.3, NoticeColor = (Color3.fromRGB(255, 214, 89)), NoticeSeconds = 5, Announce = "Look up! Power ups are falling!", AttributePrefix = "LvdPower_", Kinds = Magnet, KindList = {"Magnet", "x2Rings", "Fusion"} }
local s1 = FallEase
function FallEase.KindById(v1) -- proto[0], line 141  -- upvalues: s1
	return s1.Kinds[v1]
end
function FallEase.IconFor(v2) -- proto[1], line 145  -- upvalues: s1
	if s1.Kinds[v2] == nil then return "" end
	return s1.Kinds[v2].Icon
end
function FallEase.AttributeFor(v3) -- proto[2], line 150  -- upvalues: s1
	return s1.AttributePrefix .. v3
end
function FallEase.ActiveUntil(v4, v5) -- proto[3], line 154  -- upvalues: s1
	local v_u1 = v5
	local r1 = v4:GetAttribute(s1.AttributeFor(v_u1))
	local w1 = s1.AttributeFor(v_u1)
	if (type(r1)) ~= "number" then return 0 end
	return r1
end
function FallEase.IsActive(v6, v7, v8) -- proto[4], line 159  -- upvalues: s1
	local f1 = not (v8 >= s1.ActiveUntil)
	return f1
end
function FallEase.ModelFor(v9) -- proto[5], line 163
	if nil == nil then return nil end
	if not (nil).IsA then return nil end
	return nil
end
return FallEase