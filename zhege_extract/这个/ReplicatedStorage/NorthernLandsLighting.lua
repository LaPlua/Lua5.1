-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.NorthernLandsLighting
-- ============================================

-- bytecode
-- Original size: 5886 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 88, Protos: 5, Main proto: 4

-- ============== SOURCE ==============
-- main chunk (proto[4], line 1)
local _r1 = {}
local ClockTime = {}
ClockTime.ClockTime = 16
ClockTime.ColorShift_Bottom = (Color3.fromRGB(0, 0, 0))
ClockTime.FogColor = (Color3.fromRGB(192, 192, 192))
ClockTime.FogEnd = 100000
ClockTime.FogStart = 0
ClockTime.EnvironmentDiffuseScale = 1
ClockTime.EnvironmentSpecularScale = 1
ClockTime.ExposureCompensation = 0
ClockTime.GeographicLatitude = 161
ClockTime.Ambient = (Color3.fromRGB(87, 51, 204))
ClockTime.OutdoorAmbient = (Color3.fromRGB(88, 114, 161))
ClockTime.ShadowSoftness = 0
ClockTime.Brightness = 1
ClockTime.ColorShift_Top = (Color3.fromRGB(130, 249, 255))
ClockTime.GlobalShadows = true
local CelestialBodiesShown = {}
CelestialBodiesShown.CelestialBodiesShown = false
CelestialBodiesShown.MoonAngularSize = 11
CelestialBodiesShown.MoonTextureId = "rbxasset://sky/moon.jpg"
CelestialBodiesShown.SkyboxBk = "http://www.roblox.com/asset/?id=155657655"
CelestialBodiesShown.SkyboxDn = "http://www.roblox.com/asset/?id=155674246"
CelestialBodiesShown.SkyboxFt = "http://www.roblox.com/asset/?id=155657609"
CelestialBodiesShown.SkyboxLf = "http://www.roblox.com/asset/?id=155657671"
CelestialBodiesShown.SkyboxRt = "http://www.roblox.com/asset/?id=155657619"
CelestialBodiesShown.SkyboxUp = "http://www.roblox.com/asset/?id=155674931"
CelestialBodiesShown.StarCount = 3000
CelestialBodiesShown.SunAngularSize = 21
CelestialBodiesShown.SunTextureId = "rbxasset://sky/sun.jpg"
CelestialBodiesShown.Name = "Snow Skybox by kulyk"
local Density = {}
Density.Density = 0.4300000071525574
Density.Offset = 0
Density.Name = "Atmosphere"
Density.Color = (Color3.fromRGB(160, 153, 255))
Density.Decay = (Color3.fromRGB(170, 204, 255))
Density.Glare = 0.5
Density.Haze = 0.699999988079071
local _r3 = {}
local ColorCorrectionEffect = {}
local Name = {}
Name.Name = "ColorCorrection"
Name.Brightness = 0.10000000149011612
Name.Contrast = 0
Name.Enabled = true
Name.Saturation = 0.10000000149011612
Name.TintColor = (Color3.fromRGB(245, 225, 255))
ColorCorrectionEffect.ColorCorrectionEffect = Name
local Name_2 = {}
Name_2.Name = "SunRays"
Name_2.Enabled = true
Name_2.Intensity = 0.10700000077486038
Name_2.Spread = 0
ColorCorrectionEffect.SunRaysEffect = Name_2
local Name_3 = {}
Name_3.Name = "DepthOfField"
Name_3.Enabled = false
Name_3.FarIntensity = 0.25
Name_3.FocusDistance = 83.33999633789062
Name_3.InFocusRadius = 0
Name_3.NearIntensity = 0
ColorCorrectionEffect.DepthOfFieldEffect = Name_3
_r3.Lighting = ColorCorrectionEffect
local _r2 = { Lighting = ClockTime, Sky = CelestialBodiesShown, Atmosphere = Density, PostEffects = _r3 }
_r1.Properties = _r2
local _r1_2 = {}
local ClockTime_2 = {}
ClockTime_2.ClockTime = 7.9
ClockTime_2.ColorShift_Bottom = (Color3.fromRGB(70, 80, 100))
ClockTime_2.FogColor = (Color3.fromRGB(153, 157, 255))
ClockTime_2.FogEnd = 750
ClockTime_2.FogStart = 500
ClockTime_2.EnvironmentDiffuseScale = 0
ClockTime_2.EnvironmentSpecularScale = 0.6000000238418579
ClockTime_2.ExposureCompensation = 0
ClockTime_2.GeographicLatitude = 30
ClockTime_2.Ambient = (Color3.fromRGB(95, 91, 109))
ClockTime_2.OutdoorAmbient = (Color3.fromRGB(80, 90, 110))
ClockTime_2.ShadowSoftness = 0.20000000298023224
ClockTime_2.Brightness = 1.4
ClockTime_2.ColorShift_Top = (Color3.fromRGB(0, 0, 0))
ClockTime_2.GlobalShadows = true
local CelestialBodiesShown_2 = {}
CelestialBodiesShown_2.CelestialBodiesShown = true
CelestialBodiesShown_2.MoonAngularSize = 11
CelestialBodiesShown_2.MoonTextureId = "jpg"
CelestialBodiesShown_2.SkyboxBk = "rbxassetid://2664492575"
CelestialBodiesShown_2.SkyboxDn = "rbxassetid://2664492908"
CelestialBodiesShown_2.SkyboxFt = "rbxassetid://2664492789"
CelestialBodiesShown_2.SkyboxLf = "rbxassetid://2664492689"
CelestialBodiesShown_2.SkyboxRt = "rbxassetid://2664492382"
CelestialBodiesShown_2.SkyboxUp = "rbxassetid://2664493022"
CelestialBodiesShown_2.StarCount = 3000
CelestialBodiesShown_2.SunAngularSize = 12
CelestialBodiesShown_2.SunTextureId = "rbxasset://sky/sun.jpg"
CelestialBodiesShown_2.Name = "NL Sky"
local Density_2 = {}
Density_2.Density = 0.38
Density_2.Offset = 0.14
Density_2.Name = "Atmosphere"
Density_2.Color = (Color3.fromRGB(118, 156, 209))
Density_2.Decay = (Color3.fromRGB(107, 0, 214))
Density_2.Glare = 0.4
Density_2.Haze = 1.82
local _r3_2 = {}
local ColorCorrectionEffect_2 = {}
local Name_4 = {}
Name_4.Name = "ColorCorrection"
Name_4.Brightness = 0
Name_4.Contrast = 0
Name_4.Enabled = true
Name_4.Saturation = 0
Name_4.TintColor = (Color3.fromRGB(178, 196, 255))
ColorCorrectionEffect_2.ColorCorrectionEffect = Name_4
local Name_5 = {}
Name_5.Name = "SunRays"
Name_5.Enabled = true
Name_5.Intensity = 0.01
Name_5.Spread = 0.178
ColorCorrectionEffect_2.SunRaysEffect = Name_5
local Name_6 = {}
Name_6.Name = "DepthOfField"
Name_6.Enabled = false
Name_6.FarIntensity = 0.25
Name_6.FocusDistance = 83.33999633789062
Name_6.InFocusRadius = 0
Name_6.NearIntensity = 0
ColorCorrectionEffect_2.DepthOfFieldEffect = Name_6
_r3_2.Lighting = ColorCorrectionEffect_2
local _r2_2 = { Lighting = ClockTime_2, Sky = CelestialBodiesShown_2, Atmosphere = Density_2, PostEffects = _r3_2 }
_r1_2.Properties = _r2_2
local _r1_3 = {}
local ClockTime_3 = {}
ClockTime_3.ClockTime = 7.8
ClockTime_3.ColorShift_Bottom = (Color3.fromRGB(0, 0, 0))
ClockTime_3.FogColor = (Color3.fromRGB(153, 157, 255))
ClockTime_3.FogEnd = 750
ClockTime_3.FogStart = 500
ClockTime_3.EnvironmentDiffuseScale = 0
ClockTime_3.EnvironmentSpecularScale = 0.6000000238418579
ClockTime_3.ExposureCompensation = 0
ClockTime_3.GeographicLatitude = 4
ClockTime_3.Ambient = (Color3.fromRGB(173, 173, 173))
ClockTime_3.OutdoorAmbient = (Color3.fromRGB(144, 144, 144))
ClockTime_3.ShadowSoftness = 0.20000000298023224
ClockTime_3.Brightness = 3.5
ClockTime_3.ColorShift_Top = (Color3.fromRGB(0, 0, 0))
ClockTime_3.GlobalShadows = true
local CelestialBodiesShown_3 = {}
CelestialBodiesShown_3.CelestialBodiesShown = true
CelestialBodiesShown_3.MoonAngularSize = 11
CelestialBodiesShown_3.MoonTextureId = "jpg"
CelestialBodiesShown_3.SkyboxBk = "http://www.roblox.com/asset/?version=1&id=1014344"
CelestialBodiesShown_3.SkyboxDn = "http://www.roblox.com/asset/?version=1&id=1014344"
CelestialBodiesShown_3.SkyboxFt = "http://www.roblox.com/asset/?version=1&id=1014344"
CelestialBodiesShown_3.SkyboxLf = "http://www.roblox.com/asset/?version=1&id=1014344"
CelestialBodiesShown_3.SkyboxRt = "http://www.roblox.com/asset/?version=1&id=1014344"
CelestialBodiesShown_3.SkyboxUp = "http://www.roblox.com/asset/?version=1&id=1014344"
CelestialBodiesShown_3.StarCount = 3000
CelestialBodiesShown_3.SunAngularSize = 35
CelestialBodiesShown_3.SunTextureId = "rbxassetid://115748561224454"
CelestialBodiesShown_3.Name = "RodinSky"
local Density_3 = {}
Density_3.Density = 0.53
Density_3.Offset = 0
Density_3.Name = "Atmosphere"
Density_3.Color = (Color3.fromRGB(98, 46, 47))
Density_3.Decay = (Color3.fromRGB(45, 23, 23))
Density_3.Glare = 0.23
Density_3.Haze = 2.18
local _r3_3 = {}
local ColorCorrectionEffect_3 = {}
local Name_7 = {}
Name_7.Name = "ColorCorrection"
Name_7.Brightness = 0.05
Name_7.Contrast = 0
Name_7.Enabled = true
Name_7.Saturation = 0
Name_7.TintColor = (Color3.fromRGB(255, 111, 113))
ColorCorrectionEffect_3.ColorCorrectionEffect = Name_7
local Name_8 = {}
Name_8.Name = "SunRays"
Name_8.Enabled = true
Name_8.Intensity = 0.01
Name_8.Spread = 0
ColorCorrectionEffect_3.SunRaysEffect = Name_8
local Name_9 = {}
Name_9.Name = "DepthOfField"
Name_9.Enabled = false
Name_9.FarIntensity = 0.25
Name_9.FocusDistance = 83.33999633789062
Name_9.InFocusRadius = 0
Name_9.NearIntensity = 0
ColorCorrectionEffect_3.DepthOfFieldEffect = Name_9
_r3_3.Lighting = ColorCorrectionEffect_3
local _r2_3 = { Lighting = ClockTime_3, Sky = CelestialBodiesShown_3, Atmosphere = Density_3, PostEffects = _r3_3 }
_r1_3.Properties = _r2_3
local Default = { Default = "Day", Day = _r1, Night = _r1_2, BossFight = _r1_3, BonusPreset = "Dark + Bonus" }
local Day = { Day = "Night", Night = Default.BonusPreset }
Day[Default.BonusPreset] = "Day"
Default.Cycle = Day
local s1 = Default
function Default.Next(v1) -- proto[0], line 277  -- upvalues: s1
	return (s1.Cycle[v1] or "Day")
end
function Default.WantsBonusLighting(v2) -- proto[1], line 282  -- upvalues: s1
	local f1 = not (v2 ~= s1.BonusPreset)
	return f1
end
function Default.Get(v3) -- proto[2], line 286  -- upvalues: s1
	if v3 == "Day" then return s1.Day end
	if v3 == "Night" then return s1.Night end
	if v3 ~= s1.BonusPreset then return s1.Day end
	return s1.Night
end
function Default.IsValid(v4) -- proto[3], line 301  -- upvalues: s1
	local f1
	if v4 == "Day" then return f1 end
	if v4 == "Night" then return f1 end
	f1 = not (v4 ~= s1.BonusPreset)
	return f1
end
return Default