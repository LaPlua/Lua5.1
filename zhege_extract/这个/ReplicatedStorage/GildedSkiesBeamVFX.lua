-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.GildedSkiesBeamVFX
-- ============================================

-- bytecode
-- Original size: 114117 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 402, Protos: 52, Main proto: 51

-- ============== SOURCE ==============
local function Destroy(v1) -- proto[28], line 934
end
local function Destroy(v2) -- proto[47], line 1768
	if v2.connection then
		v2.connection = nil
	end
	if v2.restoreLighting then
		v2.restoreLighting = nil
	end
end
-- main chunk (proto[51], line 1)
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local White = { White = (Color3.fromRGB(255, 225, 160)), Hot = (Color3.fromRGB(245, 178, 60)), Gold = (Color3.fromRGB(222, 136, 14)), Deep = (Color3.fromRGB(176, 88, 5)), Amber = (Color3.fromRGB(140, 58, 3)), Ember = (Color3.fromRGB(90, 28, 2)), Smoke = (Color3.fromRGB(44, 31, 20)), Soot = (Color3.fromRGB(16, 12, 9)), Rock = (Color3.fromRGB(38, 30, 24)) }
local s1 = {}
local _r8 = {"Haze", 430, "Ember", 0.55, 1}
local _r9 = {"Glow", 260, "Amber", 0.42, 1}
s1[1], s1[2], s1[3], s1[4] = _r8, _r9, {"Body", 140, "Deep", 0.28, 1}, {"Core", 60, "Hot", 0.25, 1.1}
s1 = {}
local _r8_2 = {"Flow", "flow", 34, "Gold", 0.7, 1, "Static", 300, 2.4}
s1[1], s1[2], s1[3] = _r8_2, {"Strands", "strands", 26, "Gold", 0.72, 1, "Static", 640, 1.3}, {"Filament", "solid", 5, "White", 0.2, 1.1, "Stretch", 1, 0}
s1 = {}
local _r8_3 = {}
local _r9_3 = {0, 0}
local _r10_3 = {0.08, 0}
local _r11_2 = {0.1, 0.45}
local _r12 = {0.12, 0}
local _r13 = {0.21, 0}
local _r14 = {0.23, 0.31}
local _r15 = {0.25, 0}
local _r16 = {0.32, 0}
local _r17 = {0.33, 0.36}
local _r18 = {0.34, 0}
local _r19 = {0.4, 0}
local _r20 = {0.47, 0.34}
local _r21 = {0.59, 0.71}
local _r22 = {0.73, 0.89}
_r8_3[1], _r8_3[2], _r8_3[3], _r8_3[4], _r8_3[5], _r8_3[6], _r8_3[7], _r8_3[8], _r8_3[9], _r8_3[10], _r8_3[11], _r8_3[12], _r8_3[13], _r8_3[14], _r8_3[15], _r8_3[16] = _r9_3, _r10_3, _r11_2, _r12, _r13, _r14, _r15, _r16, _r17, _r18, _r19, _r20, _r21, _r22, {0.86, 0.98}, {1, 1}
s1.dome = _r8_3
local _r8_4 = {}
local _r9_4 = {0, 0.4}
local _r10_4 = {0.22, 0.62}
local _r11_3 = {0.24, 0.4}
local _r12_2 = {0.26, 0.65}
local _r13_2 = {0.37, 0.8}
local _r14_2 = {0.38, 0.5}
local _r15_2 = {0.39, 0.8}
local _r16_2 = {0.54, 0.82}
local _r17_2 = {0.56, 0.45}
local _r18_2 = {0.58, 0.85}
local _r19_2 = {0.69, 0.92}
local _r20_2 = {0.73, 0.65}
_r8_4[1], _r8_4[2], _r8_4[3], _r8_4[4], _r8_4[5], _r8_4[6], _r8_4[7], _r8_4[8], _r8_4[9], _r8_4[10], _r8_4[11], _r8_4[12], _r8_4[13], _r8_4[14] = _r9_4, _r10_4, _r11_3, _r12_2, _r13_2, _r14_2, _r15_2, _r16_2, _r17_2, _r18_2, _r19_2, _r20_2, {0.76, 0.93}, {1, 1}
s1.groundRing = _r8_4
local _r8_5 = {}
local _r9_5 = {0, 1}
local _r10_5 = {0.09, 0.94}
local _r11_4 = {0.1, 0.4}
local _r12_3 = {0.14, 0.9}
local _r13_3 = {0.23, 0.86}
local _r14_3 = {0.24, 0.45}
local _r15_3 = {0.25, 0.83}
local _r16_3 = {0.34, 0.8}
local _r17_3 = {0.35, 0.5}
local _r18_3 = {0.36, 0.8}
local _r19_3 = {0.5, 0.72}
local _r20_3 = {0.61, 0.72}
local _r21_3 = {0.62, 0.38}
local _r22_3 = {0.63, 0.74}
_r8_5[1], _r8_5[2], _r8_5[3], _r8_5[4], _r8_5[5], _r8_5[6], _r8_5[7], _r8_5[8], _r8_5[9], _r8_5[10], _r8_5[11], _r8_5[12], _r8_5[13], _r8_5[14], _r8_5[15], _r8_5[16] = _r9_5, _r10_5, _r11_4, _r12_3, _r13_3, _r14_3, _r15_3, _r16_3, _r17_3, _r18_3, _r19_3, _r20_3, _r21_3, _r22_3, {0.72, 0.82}, {0.74, 0.42}
local _r9_6 = {0.75, 0.84}
local _r10_6 = {0.82, 0.88}
_r8_5[17], _r8_5[18], _r8_5[19], _r8_5[20] = _r9_6, _r10_6, {0.85, 0.94}, {1, 1}
s1.wind = _r8_5
local _r8_6 = {}
local _r9_7 = {0, 1}
local _r10_7 = {0.06, 0}
local _r11_6 = {0.13, 0}
local _r12_5 = {0.27, 0.8}
local _r13_4 = {0.42, 0.9}
_r8_6[1], _r8_6[2], _r8_6[3], _r8_6[4], _r8_6[5], _r8_6[6], _r8_6[7] = _r9_7, _r10_7, _r11_6, _r12_5, _r13_4, {0.6, 0.96}, {1, 1}
s1.fireRing = _r8_6
local _r8_7 = {}
local _r9_8 = {0, 1}
local _r10_8 = {0.09, 0.92}
local _r11_7 = {0.21, 0.69}
local _r12_6 = {0.28, 0.38}
local _r13_5 = {0.35, 0}
local _r14_5 = {0.66, 0}
local _r15_5 = {0.74, 0.51}
local _r16_4 = {0.82, 0.79}
_r8_7[1], _r8_7[2], _r8_7[3], _r8_7[4], _r8_7[5], _r8_7[6], _r8_7[7], _r8_7[8], _r8_7[9], _r8_7[10] = _r9_8, _r10_8, _r11_7, _r12_6, _r13_5, _r14_5, _r15_5, _r16_4, {0.9, 0.97}, {1, 1}
s1.specs = _r8_7
local _r8_8 = {}
local _r9_9 = {0, 1}
local _r10_9 = {0.09, 0.69}
local _r11_8 = {0.17, 0}
local _r12_7 = {0.73, 0}
local _r13_6 = {0.8, 0.06}
local _r14_6 = {0.84, 0.23}
local _r15_6 = {0.87, 0.49}
_r8_8[1], _r8_8[2], _r8_8[3], _r8_8[4], _r8_8[5], _r8_8[6], _r8_8[7], _r8_8[8], _r8_8[9] = _r9_9, _r10_9, _r11_8, _r12_7, _r13_6, _r14_6, _r15_6, {0.93, 0.81}, {1, 1}
s1.lines = _r8_8
local _r8_9 = {}
local _r9_10 = {0, 0.5}
local _r10_10 = {0.08, 0}
local _r11_9 = {0.48, 0}
local _r12_8 = {0.54, 0.5}
local _r13_7 = {0.65, 0.75}
local _r14_7 = {0.72, 0.9}
_r8_9[1], _r8_9[2], _r8_9[3], _r8_9[4], _r8_9[5], _r8_9[6], _r8_9[7], _r8_9[8] = _r9_10, _r10_10, _r11_9, _r12_8, _r13_7, _r14_7, {0.82, 0.97}, {1, 1}
s1.pillar = _r8_9
local _r8_10 = {}
local _r9_11 = {0, 1}
local _r10_11 = {0.3, 0.7}
local _r11_10 = {0.62, 0.8}
local _r12_9 = {0.72, 0.68}
local _r13_8 = {0.85, 0.94}
_r8_10[1], _r8_10[2], _r8_10[3], _r8_10[4], _r8_10[5], _r8_10[6], _r8_10[7] = _r9_11, _r10_11, _r11_10, _r12_9, _r13_8, {0.9, 0.98}, {1, 1}
s1.brightSmoke = _r8_10
local function lerp(v3, v4, v5) -- proto[0], line 134
	return (v3 + ((v4 - v3) * v5))
end
local function clamp01(v6) -- proto[1], line 138
	return (math.clamp(v6, 0, 1))
end
local function easeOut(v7) -- proto[2], line 142
	v7 = math.clamp(v7, 0, 1)
	local w1 = (1 - v7)
	local w2 = (1 - v7)
	return (1 - (w1 * w2))
end
local function easeIn(v8) -- proto[3], line 147
	v8 = math.clamp(v8, 0, 1)
	return (v8 * v8)
end
local function seq(v9) -- proto[4], line 153
	local _r1 = {}
	for _k5, _v6 in ipairs(v9) do
		table.insert(_r1, NumberSequenceKeypoint.new(_v6[1], _v6[2], (_v6[3] or 0)))
	end
	return NumberSequence.new(_r1)
end
local function grad(v10) -- proto[5], line 161
	local _r1 = {}
	for _k5, _v6 in ipairs(v10) do
		table.insert(_r1, ColorSequenceKeypoint.new(_v6[1], _v6[2]))
	end
	return ColorSequence.new(_r1)
end
local function part(v11, v12, v13, v14) -- proto[6], line 170
	Instance.new.Name = v12
	Instance.new.Anchored = true
	Instance.new.CanCollide = false
	Instance.new.CanQuery = false
	Instance.new.CanTouch = false
	Instance.new.CastShadow = false
	Instance.new.Transparency = 1
	Instance.new.Size = (v14 or Vector3.new(1, 1, 1))
	Instance.new.CFrame = v13
	Instance.new.Parent = v11
	return Instance.new
end
local function light(v15, v16, v17, v18) -- proto[7], line 185
	Instance.new.Color = v16
	Instance.new.Range = v17
	Instance.new.Brightness = v18
	Instance.new.Shadows = false
	Instance.new.Parent = v15
	return Instance.new
end
local function emitter(v19, v20) -- proto[8], line 195
	Instance.new.Rate = 0
	Instance.new.LightEmission = 1
	Instance.new.LightInfluence = 0
	Instance.new.Speed = NumberRange.new
	Instance.new.Rotation = NumberRange.new
	for _k6, _v7 in ipairs(v20) do
		Instance.new[_k6] = _v7
	end
	Instance.new.Parent = v19
	return Instance.new
end
local function flipbook(v21) -- proto[9], line 209
	v21.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
	v21.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
	return v21
end
local function upHint(v22) -- proto[10], line 215
	if 0.99 >= (math.abs(v22.Y)) then return Vector3.new(0, 1, 0) end
	return Vector3.new(1, 0, 0)
end
local function lookAlong(v23, v24) -- proto[11], line 221
	if 0.99 >= (math.abs(v24.Y)) then return CFrame.lookAt(v23, (v23 + v24), Vector3.new(0, 1, 0)) end
	return CFrame.lookAt(v23, (v23 + v24), Vector3.new(0, 1, 0))
end
local function upAlong(v25, v26) -- proto[12], line 227
	local r1 = math.abs(v26.Y)
	return CFrame.fromMatrix(v25, (Vector3.new(0, 1, 0)).Cross.Unit, v26)
end
local function alongAxis(v27, v28, v29) -- proto[13], line 233
	local r1 = math.abs(v28.Y)
	return CFrame.fromMatrix((v27 + (v28 * (v29 / 2))), v28, (v28.Cross).Cross.Unit)
end
local SOURCE_RADIUS = { SOURCE_RADIUS = 38, Palette = White, Textures = { solid = "", flow = "rbxassetid://8168582727", strands = "rbxassetid://8970020142", flare = "rbxasset://textures/glow.png", roundGlow = "rbxasset://textures/particles/explosion01_implosion_main.dds", popGlow = "rbxassetid://13021239686", ring = "rbxassetid://15546047059", dome = "rbxassetid://14759977660", crescent = "rbxassetid://10927171150", crescentThin = "rbxassetid://9409204201", shard = "rbxassetid://10953621940", disc = "rbxassetid://9656384917", orbit = "rbxassetid://13241209456", spark = "rbxasset://textures/particles/sparkles_main.dds", fireSparks = "rbxasset://textures/particles/fire_sparks_main.dds", fireRing = "rbxassetid://11866455263", wisps = "rbxassetid://11402074359", firePuff = "rbxassetid://11841348746", burst = "rbxassetid://11822996479", burstRing = "rbxassetid://11868400571", swirl = "rbxassetid://11855202643", arcs = "rbxassetid://11495996443" }, GlowLayers = s1, Layers = s1, AlongAxis = alongAxis }
local function towardCamera(v30, v31) -- proto[14], line 241
	if Vector3.new(0, 0, 0).Magnitude >= 0.001 then return (v30 + (Vector3.new(0, 0, 0).Unit * v31)) end
	return v30
end
local _index = {}
_index.__index = _index
local s2 = _index
local Palette = SOURCE_RADIUS.Palette
local Textures = SOURCE_RADIUS.Textures
local ParticleEmitterShape = Enum.ParticleEmitterShape
local ParticleEmitterShapeStyle = Enum.ParticleEmitterShapeStyle
local ParticleOrientation = Enum.ParticleOrientation
function SOURCE_RADIUS.Charge(v32, v33, v34) -- proto[15], line 261  -- upvalues: s2, Palette, emitter, Textures, grad, seq, ParticleEmitterShape, ParticleEmitterShapeStyle, ParticleOrientation
	local object = setmetatable(({}), s2)
	object.position = v33
	object.radius = (v34 or 38)
	object.lastRing = 0
	object.folder = Instance.new
	object.folder.Name = "Charge"
	object.folder.Parent = v32
	Instance.new.Name = "Centre"
	Instance.new.Anchored = true
	Instance.new.CanCollide = false
	Instance.new.CanQuery = false
	Instance.new.CanTouch = false
	Instance.new.CastShadow = false
	Instance.new.Transparency = 1
	Instance.new.Size = (v33 or Vector3.new(1, 1, 1))
	Instance.new.CFrame = CFrame.new
	Instance.new.Parent = object.folder
	local w3 = (v33 or Vector3.new(1, 1, 1))
	Instance.new.Color = Palette.Gold
	Instance.new.Range = 60
	Instance.new.Brightness = 0
	Instance.new.Shadows = false
	Instance.new.Parent = Instance.new
	object.light = Instance.new
	local Name = { Name = "Halo", Texture = Textures.roundGlow, Color = ColorSequence.new, Lifetime = NumberRange.new, Rate = 22, LockedToPart = true, ZOffset = -1 }
	object.halo = emitter
	local _r10 = {}
	_r10[1], _r10[2] = {0, Palette.Deep}, {1, Palette.Hot}
	local _r10_2 = {}
	_r10_2[1], _r10_2[2] = {0, (((v34 or 38) + 150) * 2)}, {1, ((v34 or 38) * 1.9)}
	local _r10_3 = {}
	local _r11_3 = {0, 1}
	local _r12_3 = {0.35, 0.3}
	_r10_3[1], _r10_3[2], _r10_3[3], _r10_3[4] = _r11_3, _r12_3, {0.85, 0.4}, {1, 1}
	local Name_2 = { Name = "ImplodeRing", Texture = Textures.dome, Color = grad, Brightness = 1.6, Lifetime = NumberRange.new, RotSpeed = NumberRange.new, LockedToPart = true, Size = seq, Transparency = seq }
	object.implode = emitter
	if ((v32 ^ "setmetatable") * (v32 ^ "setmetatable")) > K[527012] then
		_r10_3.Name = "Front"
		_r10_3.Anchored = true
		_r10_3.CanCollide = false
		_r10_3.CanQuery = false
		_r10_3.CanTouch = false
		_r10_3.CastShadow = false
		_r10_3.Transparency = 1
		_r10_3.Size = (v33 or Vector3.new(1, 1, 1))
		_r10_3.CFrame = CFrame.new
		_r10_3.Parent = object.folder
		object.front = _r10_3
		local w4 = (v33 or Vector3.new(1, 1, 1))
		local Name_3 = { Name = "Flare", Texture = Textures.flare, Color = ColorSequence.new, Lifetime = nil, Rate = 30, LockedToPart = true }
		object.flare = emitter
		local _r10_4 = {}
		_r10_4[1], _r10_4[2] = {0, Palette.Hot}, {1, Palette.Deep}
		local _r10_5 = {}
		local _r11_5 = {0, 1}
		_r10_5[1], _r10_5[2], _r10_5[3] = _r11_5, {0.2, 0.5}, {1, 1}
		local Name_4 = { Name = "Vortex", Texture = Textures.swirl, Color = grad, LightEmission = 0.7, Lifetime = NumberRange.new, RotSpeed = NumberRange.new, LockedToPart = true, Transparency = seq, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot }
		object.vortex = emitter
		-- FORGPREP R0 iter=((v32 ^ "setmetatable") * (v32 ^ "setmetatable"))[1] -> pc402
		Instance.new.Name = "Cloud"
		Instance.new.Anchored = true
		Instance.new.CanCollide = false
		Instance.new.CanQuery = false
		Instance.new.CanTouch = false
		Instance.new.CastShadow = false
		Instance.new.Transparency = 1
		Instance.new.Size = ((Vector3.new(1, 1, 1) * (_v4 * 2.3)) or Vector3.new(1, 1, 1))
		Instance.new.CFrame = CFrame.new
		Instance.new.Parent = object.folder
		Instance.new.Shape = Enum.PartType.Ball
		local _r11_6 = {}
		_r11_6[1], _r11_6[2] = {0, 60, 20}, {1, 75, 20}
		local Name_5 = { Name = "Arcs", Texture = Textures.arcs, Color = ColorSequence.new, Brightness = 1.5, Lifetime = nil, Size = seq, Shape = ParticleEmitterShape.Sphere, ShapeStyle = ParticleEmitterShapeStyle.Surface, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot }
		_k3.arcs = emitter
		Instance.new.Name = "Shell"
		Instance.new.Anchored = true
		Instance.new.CanCollide = false
		Instance.new.CanQuery = false
		Instance.new.CanTouch = false
		Instance.new.CastShadow = false
		Instance.new.Transparency = 1
		Instance.new.Size = ((Vector3.new(1, 1, 1) * ((_v4 + 150) * 2)) or Vector3.new(1, 1, 1))
		Instance.new.CFrame = CFrame.new
		Instance.new.Parent = _k3.folder
		Instance.new.Shape = Enum.PartType.Ball
		local _r12_7 = {}
		_r12_7[1], _r12_7[2] = {0, Palette.Deep}, {1, Palette.Hot}
		local _r12_8 = {}
		_r12_8[1], _r12_8[2] = {0, 3.5}, {1, 1.5}
		local _r12_9 = {}
		_r12_9[1], _r12_9[2] = {0, 3}, {1, 8}
		local _r12_10 = {}
		local _r13_7 = {0, 1}
		local _r14_5 = {0.3, 0}
		_r12_10[1], _r12_10[2], _r12_10[3], _r12_10[4] = _r13_7, _r14_5, {0.85, 0}, {1, 1}
		local Name_6 = { Name = "Streaks", Texture = Textures.spark, Color = grad, Brightness = 1.5, Orientation = ParticleOrientation.VelocityParallel, Shape = ParticleEmitterShape.Sphere, ShapeStyle = ParticleEmitterShapeStyle.Surface, ShapeInOut = Enum.ParticleEmitterShapeInOut.Inward, Speed = NumberRange.new, Lifetime = NumberRange.new, Rotation = NumberRange.new, Size = seq, Squash = seq, Transparency = seq }
		_k3.streaks = emitter
		local _r12_11 = {}
		_r12_11[1], _r12_11[2] = {0, 95}, {1, 35}
		if (((#((v32 ^ "setmetatable") * (v32 ^ "setmetatable"))[1]) % "setmetatable") - ((#((v32 ^ "setmetatable") * (v32 ^ "setmetatable"))[1]) % "setmetatable")) ~= false then
			local _r12_12 = {}
			local _r13_9 = {0, 1}
			local _r14_7 = {0.3, 0.5}
			_r12_12[1], _r12_12[2], _r12_12[3], _r12_12[4] = _r13_9, _r14_7, {0.8, 0.6}, {1, 1}
			local Name_7 = { Name = "Soot", Texture = Textures.wisps, Color = ColorSequence.new, LightEmission = 0, Shape = ParticleEmitterShape.Sphere, ShapeStyle = ParticleEmitterShapeStyle.Surface, ShapeInOut = Enum.ParticleEmitterShapeInOut.Inward, Speed = NumberRange.new, Lifetime = NumberRange.new, Size = nil, Transparency = seq, ZOffset = -2, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot }
			_k3.soot = emitter
			return _k3
		end
	end
end
function _index.SetAlpha(v35, v36, v37) -- proto[16], line 371  -- upvalues: seq
	if v35.released then return end
	local r2 = math.clamp(v36, 0, 1)
	local w5 = (((math.sin((os.clock * ((r2 * 21) + 5)))) * ((r2 * 0.06) + 0.03)) + 1)
	v35.front.CFrame = CFrame.new
	local _r10 = {}
	_r10[1], _r10[2] = {0, (((v35.radius * 2) * (((r2 * r2) * 1) + 1.1)) * w5)}, {1, ((((v35.radius * 2) * (((r2 * r2) * 1) + 1.1)) * w5) * 1.1)}
	v35.halo.Size = seq
	local _r10_2 = {}
	local _r11_2 = {0, 1}
	_r10_2[1], _r10_2[2], _r10_2[3] = _r11_2, {0.25, ((r2 * -0.32000000000000006) + 0.92)}, {1, 1}
	v35.halo.Transparency = seq
	local _r11_3 = {}
	_r11_3[1], _r11_3[2] = {0, ((((r2 * r2) * 170) + 20) * w5), (((((r2 * r2) * 170) + 20) * w5) * 0.2)}, {1, (((((r2 * r2) * 170) + 20) * w5) * 0.8), (((((r2 * r2) * 170) + 20) * w5) * 0.2)}
	local w1 = v35.radius
	local w6 = v35.flare
	w6.Size = seq
	(v35 ^ "released").flare.Brightness = ((r2 * 0.8999999999999999) + 0.5)
	local _r12_4 = {}
	_r12_4[1], _r12_4[2] = {0, (((w1 * 2) * ((r2 * 0.7) + 1.2)) * 0.8)}, {1, ((w1 * 2) * ((r2 * 0.7) + 1.2))}
	(v35 ^ "released").vortex.Size = seq
	(v35 ^ "released").vortex.Rate = ((r2 * 7) + 0)
	(v35 ^ "released").arcs.Rate = ((((r2 - 0.25) / 0.75) * 19) + 3)
	(v35 ^ "released").streaks.Rate = (((r2 * r2) * 150) + 20)
	(v35 ^ "released").soot.Rate = ((r2 * 9) + 3)
	(v35 ^ "released").light.Brightness = (((r2 * r2) * 5.5) + 0.5)
	(v35 ^ "released").light.Range = ((r2 * 120) + 60)
	if 0.05 >= r2 then return end
	if ((r2 * -0.41000000000000003) + 0.55) > (os.clock - (v35 ^ "released").lastRing) then return end
	(v35 ^ "released").lastRing = os.clock
end
function _index.Release(v38) -- proto[18], line 406
	if v38.released then return end
	v38.released = true
	_r1[1], _r1[2], _r1[3], _r1[4], _r1[5], _r1[6] = v38.halo, v38.flare, v38.vortex, v38.arcs, v38.streaks, v38.soot
	for _k4, _v5 in {} do
		_v5.Enabled = false
	end
	v38.light.Brightness = 0
end
function _index.Destroy(v39) -- proto[19], line 419
end
local _index_2 = {}
_index_2.__index = _index_2
local rings = { rings = 1.6, crescents = 1.6, arcs = 1.6, sparks = 6, wisps = 1.2, soot = 1.1, embers = 4 }
local s3 = _index_2
local s4 = SOURCE_RADIUS
function SOURCE_RADIUS.Beam(v40, v41, v42, v43, v44) -- proto[20], line 443  -- upvalues: s3, Palette, emitter, Textures, seq, ParticleOrientation, grad, s1, s4
	local v_u2, v_u3
	local beam
	local object = setmetatable(({}), s3)
	object.from = v41
	object.to = v42
	object.length = (v42 - v41).Magnitude
	object.direction = (v42 - v41).Unit
	object.radius = (v43 or 38)
	object.widthScale = (v44 or 1)
	object.fade = 0
	local v_u1 = object.length
	local w7 = (v_u1 * 0.8)
	object.segmentLength = math.min(260, (math.max(w7, 40)))
	object.segmentStep = (object.segmentLength / 4)
	object.folder = Instance.new
	object.folder.Name = "Beam"
	object.folder.Parent = v40
	local r1 = math.abs((v42 - v41).Unit.Y)
	local w3 = (v42 - v41).Unit
	Instance.new.Name = "Origin"
	Instance.new.Anchored = true
	Instance.new.CanCollide = false
	Instance.new.CanQuery = false
	Instance.new.CanTouch = false
	Instance.new.CastShadow = false
	Instance.new.Transparency = 1
	Instance.new.Size = (v41 or Vector3.new(1, 1, 1))
	Instance.new.CFrame = CFrame.lookAt
	Instance.new.Parent = object.folder
	Instance.new.Parent = Instance.new
	object.origin = Instance.new
	local w8 = (v41 or Vector3.new(1, 1, 1))
	local r3 = math.abs(w3.Y)
	Instance.new.Name = "Muzzle"
	Instance.new.Anchored = true
	Instance.new.CanCollide = false
	Instance.new.CanQuery = false
	Instance.new.CanTouch = false
	Instance.new.CastShadow = false
	Instance.new.Transparency = 1
	Instance.new.Size = Vector3.new(30, 30, 4)
	Instance.new.CFrame = CFrame.lookAt
	Instance.new.Parent = object.folder
	object.muzzle = Instance.new
	Instance.new.Color = Palette.Gold
	Instance.new.Range = 160
	Instance.new.Brightness = 6
	Instance.new.Shadows = false
	Instance.new.Parent = Instance.new
	object.muzzleLight = Instance.new
	Instance.new.Name = "MuzzleFront"
	Instance.new.Anchored = true
	Instance.new.CanCollide = false
	Instance.new.CanQuery = false
	Instance.new.CanTouch = false
	Instance.new.CastShadow = false
	Instance.new.Transparency = 1
	Instance.new.Size = (v41 or Vector3.new(1, 1, 1))
	Instance.new.CFrame = CFrame.new
	Instance.new.Parent = object.folder
	object.muzzleFront = Instance.new
	local w9 = (v41 or Vector3.new(1, 1, 1))
	local _r15 = {}
	_r15[1], _r15[2] = {0, 170, 35}, {1, 140, 35}
	local Name = { Name = "Flare", Texture = Textures.flare, Color = ColorSequence.new, Brightness = 1.2, Lifetime = NumberRange.new, Rate = 26, Size = seq, LockedToPart = true }
	local Name_2 = { Name = "Halo", Texture = Textures.roundGlow, Color = nil, Lifetime = nil, Rate = 16, Size = nil, Transparency = nil, LockedToPart = true, ZOffset = -1 }
	if ((v40 ^ "setmetatable") * (v40 ^ "setmetatable")) <= K[604835376] then
		Name_2.Lifetime = NumberRange.new
		local _r15_2 = {}
		_r15_2[1], _r15_2[2] = {0, 170}, {1, 200}
		Name_2.Size = seq
		local _r15_3 = {}
		local _r16_3 = {0, 1}
		_r15_3[1], _r15_3[2], _r15_3[3] = _r16_3, {0.25, 0.65}, {1, 1}
		local _r10 = { flare = emitter, halo = emitter }
		local _r15_4 = {}
		_r15_4[1], _r15_4[2] = {0, 80}, {1, 200}
		local _r15_5 = {}
		_r15_5[1], _r15_5[2] = {0, 0.4}, {1, 1}
		local Name_3 = { Name = "Pulses", Texture = Textures.ring, Color = ColorSequence.new, Brightness = 1, Orientation = ParticleOrientation.VelocityPerpendicular, EmissionDirection = Enum.NormalId.Front, Speed = NumberRange.new, Drag = 3, Lifetime = NumberRange.new, Rate = 9, Size = seq, Transparency = seq, Rotation = nil }
		for _v3, _v4, _v5, _v6, _v7, _v8, _v9, _v10, _v11, _v12, _v13, _v14, _v15, _v16, _v17, _v18, _v19, _v20, _v21, _v22, _v23, _v24, _v25, _v26, _v27, _v28, _v29, _v30, _v31, _v32, _v33, _v34, _v35, _v36, _v37, _v38, _v39, _v40, _v41, _v42, _v43, _v44, _v45, _v46, _v47, _v48, _v49, _v50, _v51, _v52, _v53, _v54, _v55, _v56, _v57, _v58, _v59, _v60, _v61, _v62, _v63, _v64, _v65, _v66, _v67, _v68, _v69, _v70, _v71, _v72, _v73, _v74, _v75, _v76, _v77, _v78, _v79, _v80, _v81, _v82, _v83, _v84, _v85, _v86, _v87, _v88, _v89, _v90, _v91, _v92, _v93, _v94, _v95, _v96, _v97, _v98, _v99, _v100, _v101, _v102, _v103, _v104, _v105, _v106, _v107, _v108, _v109, _v110, _v111, _v112, _v113, _v114, _v115, _v116, _v117, _v118, _v119, _v120, _v121, _v122, _v123, _v124, _v125, _v126, _v127, _v128, _v129, _v130, _v131, _v132, _v133, _v134, _v135, _v136, _v137, _v138, _v139, _v140, _v141, _v142, _v143, _v144, _v145, _v146, _v147, _v148, _v149, _v150, _v151, _v152, _v153, _v154, _v155, _v156, _v157, _v158, _v159, _v160, _v161, _v162, _v163, _v164, _v165, _v166 in (-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1] do
			Name_3.Rotation = NumberRange.new
			_r10.pulses = emitter
			_v5.muzzleFx = _r10
			local _r10_2 = {}
			local Name_4 = { Name = "BurstRing", Texture = Textures.burstRing, Color = ColorSequence.new, Brightness = 1.2, Orientation = ParticleOrientation.VelocityPerpendicular, EmissionDirection = Enum.NormalId.Front, Speed = nil, Lifetime = NumberRange.new, Size = NumberSequence.new, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot }
			local _r16_6 = {}
			_r16_6[1], _r16_6[2] = {0, Palette.Hot}, {1, Palette.Deep}
			local _r16_7 = {}
			local _r17_7 = {0, 50}
			_r16_7[1], _r16_7[2], _r16_7[3] = _r17_7, {0.3, 250}, {1, 320}
			local Name_5 = { Name = "Dome", Texture = Textures.dome, Color = grad, Lifetime = NumberRange.new, RotSpeed = NumberRange.new, Size = seq, Transparency = seq }
			local _r17_8 = {}
			local _r18_4 = {0, 0}
			_r17_8[1], _r17_8[2], _r17_8[3] = _r18_4, {0.08, 18}, {1, 0}
			local Name_6 = { Name = "Shards", Texture = Textures.shard, Color = ColorSequence.new, Brightness = 2, LightEmission = 0.6, Orientation = ParticleOrientation.VelocityParallel, EmissionDirection = Enum.NormalId.Front, SpreadAngle = Vector2.new, Speed = NumberRange.new, Lifetime = NumberRange.new, Rotation = NumberRange.new, Size = seq, Squash = nil }
			local _r17_9 = {}
			_r17_9[1], _r17_9[2] = {0, 0}, {1, 3}
			if (((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable") - ((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable")) ~= false then continue end
			local _r18_6 = {}
			local _r19_4 = {0, Palette.Hot}
			_r18_6[1], _r18_6[2], _r18_6[3] = _r19_4, {0.4, Palette.Gold}, {1, Palette.Amber}
			(((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable") - ((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable"))["K[2987397424]"] = (((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable") - ((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable"))
			local _r18_7 = {}
			_r18_7[1], _r18_7[2] = {0, 60}, {1, 170}
			local _r18_8 = {}
			local _r19_6 = {0, 0}
			_r18_8[1], _r18_8[2], _r18_8[3] = _r19_6, {0.6, 0.3}, {1, 1}
			local Name_7 = { Name = "Blast", Texture = Textures.firePuff, Color = grad, LightEmission = 0.4, EmissionDirection = Enum.NormalId.Front, SpreadAngle = Vector2.new, Speed = NumberRange.new, Drag = 5, Lifetime = NumberRange.new, RotSpeed = nil, Size = seq, Transparency = seq, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot }
			local _r19_7 = {}
			_r19_7[1], _r19_7[2] = {0, Palette.Smoke}, {1, Palette.Soot}
			local _r19_8 = {}
			_r19_8[1], _r19_8[2] = {0, 90}, {1, 240}
			local _r19_9 = {}
			local _r20_7 = {0, 1}
			_r19_9[1], _r19_9[2], _r19_9[3] = _r20_7, {0.15, 0.45}, {1, 1}
			local Name_8 = { Name = "BackSoot", Texture = Textures.wisps, Color = nil, LightEmission = 0, SpreadAngle = Vector2.new, Speed = NumberRange.new, Drag = 1.5, Lifetime = NumberRange.new, RotSpeed = NumberRange.new, Size = seq, Transparency = seq, ZOffset = -3, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot }
			_r10_2[1], _r10_2[2], _r10_2[3], _r10_2[4], _r10_2[5] = emitter, emitter, emitter, emitter, emitter
			local _r11 = {}
			local _r12 = {_r10_2[1], 1}
			local _r13 = {_r10_2[2], 1}
			local _r14 = {_r10_2[3], 40}
			_r11[1], _r11[2], _r11[3], _r11[4], _r11[5] = _r12, _r13, _r14, {_r10_2[4], 14}, {_r10_2[5], 10}
			_v5.muzzleBursts = _r11
			local r4 = math.abs(w3.Y)
			Instance.new.Name = "Head"
			Instance.new.Anchored = true
			Instance.new.CanCollide = false
			Instance.new.CanQuery = false
			Instance.new.CanTouch = false
			Instance.new.CastShadow = false
			Instance.new.Transparency = 1
			Instance.new.Size = (v41 or Vector3.new(1, 1, 1))
			Instance.new.CFrame = CFrame.lookAt
			Instance.new.Parent = _v5.folder
			Instance.new.Parent = Instance.new
			_v5.head = Instance.new
			local w10 = (v41 or Vector3.new(1, 1, 1))
			Instance.new.Color = Palette.Gold
			Instance.new.Range = 170
			Instance.new.Brightness = 7
			Instance.new.Shadows = false
			Instance.new.Parent = Instance.new
			_v5.headLight = Instance.new
			local _r18_9 = {}
			_r18_9[1], _r18_9[2] = {0, 115, 25}, {1, 95, 25}
			local Name_9 = { Name = "Flare", Texture = Textures.flare, Color = ColorSequence.new, Lifetime = NumberRange.new, Rate = 30, Size = seq, LockedToPart = true }
			local _r18_10 = {}
			_r18_10[1], _r18_10[2] = {0, 90}, {1, 110}
			local Name_10 = { Name = "Core", Texture = Textures.roundGlow, Color = ColorSequence.new, Lifetime = NumberRange.new, Rate = 20, Size = seq, Transparency = nil, LockedToPart = true }
			local _r18_11 = {}
			_r18_11[1], _r18_11[2] = {0, 0.55}, {1, 1}
			if (((-(-(((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable") - ((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable")))) / "setmetatable") + ((-(-(((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable") - ((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable")))) / "setmetatable")) ~= nil then continue end
			local _r18_12 = {}
			_r18_12[1], _r18_12[2] = {0, Palette.Gold}, {1, Palette.Deep}
			local _r18_13 = {}
			_r18_13[1], _r18_13[2] = {0, 70, 15}, {1, 95, 15}
			local Name_11 = { Name = "Fireball", Texture = Textures.burst, Color = grad, LightEmission = 0.5, Lifetime = NumberRange.new, Rate = 12, Size = seq, LockedToPart = true, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot }
			local _r18_14 = {}
			_r18_14[1], _r18_14[2] = {0, 60, 20}, {1, 75, 20}
			local Name_12 = { Name = "Arcs", Texture = Textures.arcs, Color = nil, Brightness = 1.3, Lifetime = NumberRange.new, Rate = 14, Size = seq, LockedToPart = true, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot }
			local _r18_15 = {}
			local _r19_16 = {0, Palette.Hot}
			_r18_15[1], _r18_15[2], _r18_15[3] = _r19_16, {0.35, Palette.Gold}, {1, Palette.Amber}
			-- FORGPREP_NEXT R0 iter=(-(((-(-(((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable") - ((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable")))) / "setmetatable") + ((-(-(((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable") - ((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable")))) / "setmetatable"))["K[2752516400]"]) -> pc1424
			local _r18_16 = {}
			_r18_16[1], _r18_16[2] = {0, 40}, {1, 105}
			local _r18_17 = {}
			local _r19_18 = {0, 0.2}
			_r18_17[1], _r18_17[2], _r18_17[3] = _r19_18, {0.7, 0.6}, {1, 1}
			local Name_13 = { Name = "FireTrail", Texture = Textures.firePuff, Color = grad, LightEmission = 0.35, EmissionDirection = Enum.NormalId.Back, SpreadAngle = Vector2.new, Speed = NumberRange.new, Drag = 3, Lifetime = NumberRange.new, Rate = 28, RotSpeed = NumberRange.new, Size = seq, Transparency = seq, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot }
			local _r18_18 = {}
			_r18_18[1], _r18_18[2] = {0, 60}, {1, 190}
			local _r18_19 = {}
			_r18_19[1], _r18_19[2] = {0, 0.45}, {1, 1}
			local Name_14 = { Name = "BowRings", Texture = Textures.ring, Color = ColorSequence.new, Brightness = 1, Orientation = ParticleOrientation.VelocityPerpendicular, EmissionDirection = Enum.NormalId.Back, Speed = NumberRange.new, Drag = 2, Lifetime = NumberRange.new, Rate = 16, Rotation = NumberRange.new, Size = seq, Transparency = seq }
			local _r18_20 = {}
			local _r19_21 = {0, Palette.White}
			_r18_20[1], _r18_20[2], _r18_20[3] = _r19_21, {0.5, Palette.Gold}, {1, Palette.Deep}
			if ((not (-(((-(-(((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable") - ((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable")))) / "setmetatable") + ((-(-(((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable") - ((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable")))) / "setmetatable"))["K[2752516400]"])) * "setmetatable") >= R605032752 then continue end
			-- FORGPREP_INEXT R0 iter=ipairs((-((not (-(((-(-(((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable") - ((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable")))) / "setmetatable") + ((-(-(((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable") - ((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable")))) / "setmetatable"))["K[2752516400]"])) * "setmetatable"))) -> pc1695
			local _r18_21 = {}
			_r18_21[1], _r18_21[2] = {0, 4}, {1, 0}
			local _r18_22 = {}
			_r18_22[1], _r18_22[2] = {0, 4}, {1, 8}
			local Name_15 = { Name = "Sparks", Texture = Textures.spark, Color = nil, Brightness = 2, Orientation = ParticleOrientation.VelocityParallel, EmissionDirection = Enum.NormalId.Back, SpreadAngle = Vector2.new, Speed = NumberRange.new, Drag = 2, Lifetime = NumberRange.new, Rate = 80, Rotation = NumberRange.new, Size = seq, Squash = seq }
			_v5.headFx = { flare = emitter, core = emitter, fireball = emitter, arcs = emitter, trail = emitter, bowRings = emitter, sparks = emitter }
			_v5.glows = {}
			local w11 = ((math.ceil(_v5.length / _v5.segmentStep)) + 1)
			-- FORGPREP_INEXT _v14 iter=ipairs(s4.GlowLayers) -> pc1899
			local r5, r6, r7, r8, r9 = table.unpack(_v18)
			local _r24 = {}
			for _i = 1, w11 do
				Instance.new.Position = (Vector3.new(0, 0, (-(((_i - 1) * _v5.segmentStep) - (_v5.segmentLength / 2)))))
				Instance.new.Parent = Instance.new
				v_u2 = _v5.segmentLength / 2
				Instance.new.Position = (Vector3.new(0, 0, (-(((_i - 1) * _v5.segmentStep) + v_u2))))
				Instance.new.Parent = Instance.new
				(-((not (-(((-(-(((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable") - ((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable")))) / "setmetatable") + ((-(-(((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable") - ((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable")))) / "setmetatable"))["K[2752516400]"])) * "setmetatable"))[(-((not (-(((-(-(((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable") - ((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable")))) / "setmetatable") + ((-(-(((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable") - ((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable")))) / "setmetatable"))["K[2752516400]"])) * "setmetatable"))] = (-((not (-(((-(-(((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable") - ((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable")))) / "setmetatable") + ((-(-(((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable") - ((#(-((v40 ^ "setmetatable") * (v40 ^ "setmetatable")))[1]) % "setmetatable")))) / "setmetatable"))["K[2752516400]"])) * "setmetatable"))
				Instance.new.Name = r5 .. _i
				Instance.new.Attachment0 = Instance.new
				Instance.new.Attachment1 = Instance.new
				Instance.new.Texture = Textures.roundGlow
				Instance.new.TextureMode = Enum.TextureMode.Stretch
				Instance.new.Color = ColorSequence.new
				Instance.new.LightEmission = 1
				Instance.new.LightInfluence = 0
				Instance.new.Brightness = r9
				Instance.new.FaceCamera = true
				Instance.new.Segments = 1
				v_u3 = _k17 * 0.1
				Instance.new.ZOffset = v_u3
				Instance.new.Enabled = false
				Instance.new.Parent = Instance.new
				beam = { beam = Instance.new, centre = ((_i - 1) * _v5.segmentStep) }
				table.insert(_r24, beam)
			end
			local segments = { segments = _r24, width = r6, transparency = r8 }
			table.insert(_v5.glows, segments)
			-- generic-for loop _v14.. (vars=2) -> pc1765
			_v5.beams = {}
			-- FORGPREP_INEXT _v14 iter=ipairs(s4.Layers) -> pc1988
			local r10, r11, r12, r13, r14, r15, r16, r17, r18 = table.unpack(_v18)
			Instance.new.Name = r10
			Instance.new.Attachment0 = Instance.new
			Instance.new.Attachment1 = Instance.new
			Instance.new.Texture = Textures[r11]
			Instance.new.TextureMode = Enum.TextureMode[r16]
			Instance.new.TextureLength = r17
			Instance.new.TextureSpeed = r18
			Instance.new.Color = ColorSequence.new
			Instance.new.LightEmission = 1
			Instance.new.LightInfluence = 0
			Instance.new.Brightness = r15
			Instance.new.FaceCamera = true
			Instance.new.Segments = 1
			Instance.new.ZOffset = (((#s4.GlowLayers) + _k17) * 0.1)
			Instance.new.Parent = Instance.new
			local beam_2 = { beam = Instance.new, width = r12, transparency = r14, brightness = r15 }
			table.insert(_v5.beams, beam_2)
			-- generic-for loop _v14.. (vars=2) -> pc1911
			local r19 = math.abs(w3.Y)
		end
	end
	v41.Name = "Axis"
	v41.Anchored = true
	v41.CanCollide = false
	v41.CanQuery = false
	v41.CanTouch = false
	v41.CastShadow = false
	v41.Transparency = 1
	v41.Size = Vector3.new(2, 2, 1)
	v41.CFrame = CFrame.lookAt
	v41.Parent = R5.folder
	R5.axis = v41
	local r20 = math.abs(w3.Y)
	Instance.new.Name = "Volume"
	Instance.new.Anchored = true
	Instance.new.CanCollide = false
	Instance.new.CanQuery = false
	Instance.new.CanTouch = false
	Instance.new.CastShadow = false
	Instance.new.Transparency = 1
	Instance.new.Size = Vector3.new(70, 70, 1)
	Instance.new.CFrame = CFrame.lookAt
	Instance.new.Parent = R5.folder
	R5.volume = Instance.new
	local r21 = math.abs(w3.Y)
	Instance.new.Name = "Shroud"
	Instance.new.Anchored = true
	Instance.new.CanCollide = false
	Instance.new.CanQuery = false
	Instance.new.CanTouch = false
	Instance.new.CastShadow = false
	Instance.new.Transparency = 1
	Instance.new.Size = Vector3.new(150, 150, 1)
	Instance.new.CFrame = CFrame.lookAt
	Instance.new.Parent = R5.folder
	R5.shroud = Instance.new
	local _r14_2 = {}
	local _r19_24 = {}
	_r19_24[1], _r19_24[2] = {0, 40}, {1, 120}
	local _r19_25 = {}
	_r19_25[1], _r19_25[2] = {0, 0.45}, {1, 1}
	local Name_16 = { Name = "Rings", Texture = Textures.ring, Color = ColorSequence.new, Orientation = ParticleOrientation.VelocityPerpendicular, EmissionDirection = Enum.NormalId.Front, Speed = NumberRange.new, Lifetime = NumberRange.new, Rotation = NumberRange.new, Size = seq, Transparency = seq }
	_r14_2.rings = emitter
	local _r19_26 = {}
	_r19_26[1], _r19_26[2] = {0, Palette.Hot}, {1, Palette.Gold}
	if ("setmetatable" - "setmetatable") <= R1259409968 then
		local _r19_27 = {}
		local _r20_25 = {0, 0}
		local _r21_12 = {0.24, 75, 25}
		_r19_27[1], _r19_27[2], _r19_27[3], _r19_27[4] = _r20_25, _r21_12, {0.61, 100, 20}, {1, 110}
		local Name_17 = { Name = "Crescents", Texture = Textures.crescent, Color = grad, Brightness = 1.3, Orientation = ParticleOrientation.VelocityPerpendicular, EmissionDirection = Enum.NormalId.Front, Speed = NumberRange.new, Drag = 3, Lifetime = nil, RotSpeed = NumberRange.new, Size = seq, Transparency = seq }
		local Name_18 = { Name = "Arcs", Texture = Textures.arcs, Color = nil, Brightness = 1.4, Lifetime = nil, Size = nil }
		return ("setmetatable" - "setmetatable")
	end
end
local s5 = rings
function _index_2.SetProgress(v45, v46, v47) -- proto[23], line 833  -- upvalues: s5
	local r22
	local r23
	local f1
	local w1 = v45.direction
	local w6
	local w12
	local w13
	local v_u4
	local r2 = math.clamp(v46, 0, 1)
	local v_u5 = v45.length
	local w14 = (v_u5 * r2)
	local r24 = math.max(w14, 0.1)
	v45.headPosition = (v45.from + (v45.direction * r24))
	local r1 = math.abs(v45.direction.Y)
	v45.head.CFrame = CFrame.lookAt
	if not ((Vector3.new(0, 0, 0).Magnitude < 0.001)) then
		v_u4 = Vector3.new(0, 0, 0).Unit
	end
	v45.muzzleFront.CFrame = CFrame.new
	local r25 = math.clamp((r2 / 0.25), 0, 1)
	local w15 = (1 - ((1 - r25) * (1 - r25)))
	local w16 = ((w15 * 0.55) + 0.45)
	local w17 = (w16 * v45.widthScale)
	local fade = v45.fade
	local glows = ((#v45.glows) + (#v45.beams))
	local function collapseOf(v48) -- proto[21], line 848  -- upvalues: fade, glows
		return (math.clamp((fade * ((((v48 - 1) / (glows - 1)) * -0.7) + 1.7)), 0, 1))
	end
	local clock = os.clock
	local function flickerOf(v49) -- proto[22], line 851  -- upvalues: clock
		return ((1 + (math.noise * 0.12)) + ((math.sin(((clock * 31) + v49))) * 0.03))
	end
	for _k17, _v18 in ipairs(v45.glows) do
		r22 = math.clamp((v45.fade * ((((_k17 - 1) / (((#v45.glows) + (#v45.beams)) - 1)) * -0.7) + 1.7)), 0, 1)
		local r26 = math.sin(((os.clock * 31) + _k17))
		for _k25, _v26 in ipairs(_v18.segments) do
			r23 = math.clamp((((r24 - _v26.centre) / v45.segmentStep) + 1), 0, 1)
			f1 = not (0 >= r23)
			_v26.beam.Enabled = f1
			if 0 >= r23 then continue end
			_v26.beam.Width0 = (((_v18.width * w17) * ((1 + (math.noise * 0.12)) + (r26 * 0.03))) * (1 - (r22 * r22)))
			_v26.beam.Width1 = (((_v18.width * w17) * ((1 + (math.noise * 0.12)) + (r26 * 0.03))) * (1 - (r22 * r22)))
			w6 = v45.fade
			w12 = (#v45.glows)
			w13 = ((#v45.glows) + (#v45.beams))
			_v26.beam.Transparency = NumberSequence.new
		end
	end
	for _k17, _v18 in ipairs((v45 ^ "math").beams) do
		local r27 = math.clamp((w6 * (((((w12 + _k17) - 1) / (w13 - 1)) * -0.7) + 1.7)), 0, 1)
		local r28 = math.sin(((os.clock * 31) + (w12 + _k17)))
		_v18.beam.Width0 = ((((_v18.width * w17) * ((1 + (math.noise * 0.12)) + (r28 * 0.03))) * (1 - (r27 * r27))) * 1.15)
		_v18.beam.Width1 = (((_v18.width * w17) * ((1 + (math.noise * 0.12)) + (r28 * 0.03))) * (1 - (r27 * r27)))
		_v18.beam.Transparency = NumberSequence.new
		_v18.beam.Brightness = (_v18.brightness * (1 + (math.noise * 0.2)))
	end
	local r29 = math.max((r24 - (math.min((v45 ^ "math").radius, r24))), 0.1)
	local r3 = math.abs(w1.Y)
	(v45 ^ "math").axis.CFrame = CFrame.lookAt
	(v45 ^ "math").axis.Size = (Vector3.new(2, 2, r29))
	(v45 ^ "math").volume.CFrame = CFrame.lookAt
	(v45 ^ "math").volume.Size = (Vector3.new(70, 70, r29))
	(v45 ^ "math").shroud.CFrame = CFrame.lookAt
	r29 = (v45 ^ "math").shroud
	r29.Size = (Vector3.new(150, 150, r29))
	for _k21, _v22 in ipairs(s5) do
		(v45 ^ "math").volumeFx[_k21].Rate = (_v22 * (r29 / 100))
	end
end
function _index_2.SetFade(v50, v51) -- proto[24], line 898
	local f2
	v50.fade = (math.clamp(v51, 0, 1))
	f2 = not (v50.fade > 0)
	for _k6, _v7 in ipairs(v50.headFx) do
		_v7.Enabled = f2
	end
	for _k6, _v7 in ipairs(v50.muzzleFx) do
		_v7.Enabled = f2
	end
	v50.headLight.Brightness = ((v50.fade * -7) + 7)
	v50.muzzleLight.Brightness = ((v50.fade * -6) + 6)
end
function _index_2.Fade(v52, v53, v54) -- proto[27], line 913  -- upvalues: RunService
	local connection = nil
end
-- Destroy captures:
_index_2.Destroy = Destroy
local _index_3 = {}
_index_3.__index = _index_3
SOURCE_RADIUS.IMPACT_DURATION = 3
local function scaleEmitter(v55, v56) -- proto[29], line 953
	local _r2 = {}
	for _k6, _v7 in ipairs(v55.Size.Keypoints) do
		table.insert(_r2, NumberSequenceKeypoint.new(_v7.Time, (_v7.Value * v56), (_v7.Envelope * v56)))
	end
	v55.Size = NumberSequence.new
	v55.Speed = NumberRange.new
	v55.Acceleration = (v55.Acceleration * v56)
end
local s6 = _index_3
local function Impact(v57, v58, v59, v60) -- proto[30], line 964  -- upvalues: s6, Palette, emitter, Textures, seq, grad, s1, ParticleOrientation, scaleEmitter
	local _r9
	local Texture_15
	local object = setmetatable(({}), s6)
	object.position = v58
	object.direction = v59
	object.folder = Instance.new
	object.folder.Name = "Impact"
	object.folder.Parent = v57
	Instance.new.Name = "Centre"
	Instance.new.Anchored = true
	Instance.new.CanCollide = false
	Instance.new.CanQuery = false
	Instance.new.CanTouch = false
	Instance.new.CastShadow = false
	Instance.new.Transparency = 1
	Instance.new.Size = Vector3.new(60, 60, 60)
	Instance.new.CFrame = CFrame.new
	Instance.new.Parent = object.folder
	local r1 = math.abs((-v59).Y)
	Instance.new.Name = "Surface"
	Instance.new.Anchored = true
	Instance.new.CanCollide = false
	Instance.new.CanQuery = false
	Instance.new.CanTouch = false
	Instance.new.CastShadow = false
	Instance.new.Transparency = 1
	Instance.new.Size = Vector3.new(50, 1, 50)
	Instance.new.CFrame = CFrame.fromMatrix
	Instance.new.Parent = object.folder
	Instance.new.Name = "Column"
	Instance.new.Anchored = true
	Instance.new.CanCollide = false
	Instance.new.CanQuery = false
	Instance.new.CanTouch = false
	Instance.new.CastShadow = false
	Instance.new.Transparency = 1
	Instance.new.Size = Vector3.new(70, 20, 70)
	Instance.new.CFrame = CFrame.new
	Instance.new.Parent = object.folder
	Instance.new.Color = Palette.Hot
	Instance.new.Range = 320
	Instance.new.Brightness = 0
	Instance.new.Shadows = false
	Instance.new.Parent = Instance.new
	object.light = Instance.new
	local _r14 = {}
	local _r15 = {0, 0}
	local _r16 = {0.18, 0}
	_r14[1], _r14[2], _r14[3], _r14[4] = _r15, _r16, {0.21, 260}, {1, 200}
	local Texture = { Texture = Textures.popGlow, Color = ColorSequence.new, Brightness = 1.5, Lifetime = NumberRange.new, Rotation = NumberRange.new, LockedToPart = true, Size = seq, Squash = nil, ZOffset = 5 }
	local _r14_2 = {}
	local _r15_2 = {0, 0.01}
	_r14_2[1], _r14_2[2], _r14_2[3] = _r15_2, {0.28, 0.67}, {1, 0}
	if ((v57 ^ "setmetatable") * (v57 ^ "setmetatable")) <= K[1795951920] then
		((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))["K[265723]"] = ((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))
		local _r14_3 = {}
		_r14_3[1], _r14_3[2] = {0, 480}, {1, 200}
		local _r14_4 = {}
		_r14_4[1], _r14_4[2] = {0, 0}, {1, 1}
		local Texture_2 = { Texture = Textures.flare, Color = ColorSequence.new, Brightness = 1.2, Lifetime = nil, LockedToPart = true, Size = NumberRange.new, Transparency = seq, ZOffset = 4 }
		_r9 = { pop = emitter, flare = emitter }
		local _r14_5 = {}
		local _r15_5 = {0, Palette.Gold}
		_r14_5[1], _r14_5[2], _r14_5[3] = _r15_5, {0.5, Palette.Deep}, {1, Palette.Amber}
		local _r14_6 = {}
		_r14_6[1], _r14_6[2] = {0, 220, 30}, {1, 280, 30}
		local Texture_3 = { Texture = Textures.burst, Color = grad, LightEmission = 0.6, Lifetime = NumberRange.new, LockedToPart = true, Size = seq, ZOffset = 3, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot }
		for _v3, _v4, _v5, _v6, _v7, _v8, _v9, _v10, _v11, _v12, _v13, _v14, _v15, _v16, _v17, _v18, _v19, _v20, _v21, _v22, _v23, _v24, _v25, _v26, _v27, _v28, _v29, _v30, _v31, _v32, _v33, _v34, _v35, _v36, _v37, _v38, _v39, _v40, _v41, _v42, _v43, _v44, _v45, _v46, _v47, _v48, _v49, _v50 in ((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1] do
			_r9.core = emitter
			local _r14_7 = {}
			_r14_7[1], _r14_7[2] = {0, Palette.Hot}, {1, Palette.Deep}
			local _r14_8 = {}
			local _r15_8 = {0, 0}
			local _r16_8 = {0.05, 215}
			local _r17_4 = {0.22, 395}
			local _r18_2 = {0.43, 475}
			_r14_8[1], _r14_8[2], _r14_8[3], _r14_8[4], _r14_8[5], _r14_8[6] = _r15_8, _r16_8, _r17_4, _r18_2, {0.69, 525}, {1, 550}
			local Texture_4 = { Texture = Textures.dome, Color = grad, Brightness = 1.2, Lifetime = NumberRange.new, RotSpeed = nil, LockedToPart = true, Size = seq, Transparency = seq, ZOffset = 3 }
			_r9.dome = emitter
			local Texture_5 = { Texture = Textures.burstRing, Color = ColorSequence.new, Brightness = 1.3, Orientation = ParticleOrientation.VelocityPerpendicular, EmissionDirection = Enum.NormalId.Top, Speed = NumberRange.new, Lifetime = NumberRange.new, Size = NumberSequence.new, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot }
			_r9.burstRing = emitter
			local _r14_9 = {}
			_r14_9[1], _r14_9[2] = {0, Palette.Gold}, {1, Palette.Deep}
			local _r14_10 = {}
			_r14_10[1], _r14_10[2] = {0, 90}, {1, 330}
			local Texture_6 = { Texture = Textures.fireRing, Color = grad, LightEmission = 0.6, Orientation = ParticleOrientation.VelocityPerpendicular, EmissionDirection = Enum.NormalId.Top, Speed = NumberRange.new, Lifetime = NumberRange.new, TimeScale = 0.65, Rotation = NumberRange.new, Size = seq, Transparency = seq, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot }
			_r9.fireRing = emitter
			if (((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable") - ((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable")) ~= false then continue end
			local _r14_11 = {}
			local _r15_11 = {0, 0}
			local _r16_11 = {0.02, 0}
			local _r17_5 = {0.11, 190, 55}
			local _r18_3 = {0.8, 205, 55}
			local _r19_2 = {0.93, 170, 35}
			_r14_11[1], _r14_11[2], _r14_11[3], _r14_11[4], _r14_11[5], _r14_11[6], _r14_11[7] = _r15_11, _r16_11, _r17_5, _r18_3, _r19_2, {0.97, 150, 20}, {1, 125}
			local Texture_7 = { Texture = Textures.crescentThin, Color = nil, Brightness = 1.4, Orientation = ParticleOrientation.VelocityPerpendicular, EmissionDirection = Enum.NormalId.Top, Speed = NumberRange.new, Drag = 3, Lifetime = NumberRange.new, Rotation = NumberRange.new, RotSpeed = NumberRange.new, Size = seq, Transparency = nil }
			(((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable") - ((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable"))["K[3641445680]"] = (((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable") - ((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable"))
			_r9.groundRings = emitter
			local _r14_12 = {}
			_r14_12[1], _r14_12[2] = {0, Palette.Hot}, {1, Palette.Gold}
			local _r14_13 = {}
			local _r15_13 = {0, 0}
			local _r16_13 = {0.24, 105, 40}
			_r14_13[1], _r14_13[2], _r14_13[3], _r14_13[4] = _r15_13, _r16_13, {0.61, 150, 30}, {1, 165}
			local Texture_8 = { Texture = Textures.crescent, Color = grad, Brightness = 1.4, Orientation = ParticleOrientation.VelocityPerpendicular, EmissionDirection = Enum.NormalId.Top, SpreadAngle = Vector2.new, Speed = nil, Drag = 3, Lifetime = NumberRange.new, RotSpeed = NumberRange.new, Size = seq, Transparency = seq }
			_r9.crescents = emitter
			local _r14_14 = {}
			local _r15_14 = {0, Palette.Gold}
			local _r16_14 = {0.3, Palette.Deep}
			_r14_14[1], _r14_14[2], _r14_14[3], _r14_14[4] = _r15_14, _r16_14, {0.7, Palette.Amber}, {1, Palette.Ember}
			local _r14_15 = {}
			_r14_15[1], _r14_15[2] = {0, 70}, {1, 210}
			local _r14_16 = {}
			local _r15_16 = {0, 0}
			_r14_16[1], _r14_16[2], _r14_16[3] = _r15_16, {0.6, 0.3}, {1, 1}
			local Texture_9 = { Texture = Textures.firePuff, Color = grad, LightEmission = 0.35, SpreadAngle = Vector2.new, Speed = NumberRange.new, Drag = 3.5, Acceleration = Vector3.new(0, 25, 0), Lifetime = NumberRange.new, RotSpeed = NumberRange.new, Size = seq, Transparency = seq, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot }
			_r9.billows = emitter
			local _r14_17 = {}
			_r14_17[1], _r14_17[2] = {0, 0}, {1, 120}
			if (((-(((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable") - ((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable"))) / "setmetatable") + ((-(((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable") - ((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable"))) / "setmetatable")) ~= nil then continue end
			local Texture_10 = { Texture = Textures.wisps, Color = ColorSequence.new, Brightness = 1.5, LightEmission = 0.6, SpreadAngle = Vector2.new, Speed = NumberRange.new, Drag = 8, Acceleration = Vector3.new(0, 30, 0), Lifetime = NumberRange.new, Size = seq, Transparency = nil, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot }
			_r9.brightSmoke = emitter
			local _r14_18 = {}
			_r14_18[1], _r14_18[2] = {0, Palette.Smoke}, {1, Palette.Soot}
			local _r14_19 = {}
			_r14_19[1], _r14_19[2] = {0, 80}, {1, 300}
			local _r14_20 = {}
			local _r15_20 = {0, 1}
			local _r16_20 = {0.1, 0.35}
			_r14_20[1], _r14_20[2], _r14_20[3], _r14_20[4] = _r15_20, _r16_20, {0.6, 0.55}, {1, 1}
			local Texture_11 = { Texture = Textures.wisps, Color = grad, LightEmission = 0, SpreadAngle = Vector2.new, Speed = NumberRange.new, Drag = 2, Acceleration = Vector3.new(0, 14, 0), Lifetime = NumberRange.new, RotSpeed = nil, Size = seq, Transparency = seq, ZOffset = -3, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot }
			_r9.darkSmoke = emitter
			-- FORGPREP_NEXT R0 iter=(((-(((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable") - ((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable"))) / "setmetatable") + ((-(((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable") - ((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable"))) / "setmetatable"))["K[2987134256]"] -> pc1332
			local _r14_21 = {}
			local _r15_21 = {0, 0}
			_r14_21[1], _r14_21[2], _r14_21[3] = _r15_21, {0.08, 38}, {1, 0}
			local _r14_22 = {}
			_r14_22[1], _r14_22[2] = {0, 0}, {1, 3}
			local Texture_12 = { Texture = Textures.shard, Color = ColorSequence.new, Brightness = 2, LightEmission = 0.6, Orientation = ParticleOrientation.VelocityParallel, SpreadAngle = Vector2.new, Speed = NumberRange.new, Lifetime = NumberRange.new, Rotation = NumberRange.new, Size = seq, Squash = seq, ZOffset = 1.5 }
			_r9.shards = emitter
			local _r14_23 = {}
			_r14_23[1], _r14_23[2] = {0, 45, 12}, {1, 0}
			local Texture_13 = { Texture = Textures.orbit, Color = ColorSequence.new, Brightness = 2, LightEmission = 0.5, SpreadAngle = Vector2.new, Speed = NumberRange.new, Drag = 3, Acceleration = Vector3.new(0, 120, 0), Lifetime = NumberRange.new, Rotation = NumberRange.new, RotSpeed = NumberRange.new, Size = seq, Transparency = nil, ZOffset = 2 }
			if ((not (((-(((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable") - ((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable"))) / "setmetatable") + ((-(((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable") - ((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable"))) / "setmetatable"))["K[2987134256]"]) * "setmetatable") >= R1493962032 then continue end
			_r9.specs = emitter
			-- FORGPREP_INEXT R0 iter=ipairs(((not (((-(((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable") - ((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable"))) / "setmetatable") + ((-(((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable") - ((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable"))) / "setmetatable"))["K[2987134256]"]) * "setmetatable")) -> pc1549
			local _r14_24 = {}
			local _r15_24 = {0, 2.5}
			local _r16_24 = {0.26, 4, 0.7}
			_r14_24[1], _r14_24[2], _r14_24[3], _r14_24[4] = _r15_24, _r16_24, {0.58, 6.7, 0.7}, {1, 7.4}
			local Texture_14 = { Texture = Textures.spark, Color = ColorSequence.new, Brightness = 2, Orientation = ParticleOrientation.VelocityParallel, Speed = NumberRange.new, Drag = 2, Acceleration = Vector3.new(0, 750, 0), Lifetime = NumberRange.new, Rotation = NumberRange.new, Size = NumberSequence.new, Squash = seq, Transparency = seq, TimeScale = 0.9 }
			_r9.lines = emitter
			((not (((-(((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable") - ((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable"))) / "setmetatable") + ((-(((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable") - ((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable"))) / "setmetatable"))["K[2987134256]"]) * "setmetatable")[((not (((-(((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable") - ((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable"))) / "setmetatable") + ((-(((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable") - ((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable"))) / "setmetatable"))["K[2987134256]"]) * "setmetatable")] = ((not (((-(((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable") - ((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable"))) / "setmetatable") + ((-(((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable") - ((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable"))) / "setmetatable"))["K[2987134256]"]) * "setmetatable")
			Texture_15 = { Texture = Textures.disc, Color = ColorSequence.new, Orientation = ParticleOrientation.VelocityParallel, Speed = NumberRange.new, Lifetime = NumberRange.new, Rotation = NumberRange.new }
			local _r14_25 = {}
			local _r15_25 = {0, 60}
			_r14_25[1], _r14_25[2], _r14_25[3] = _r15_25, {0.68, 66}, {1, 7}
		end
	end
	-- FORGPREP R0 iter=((not (((-(((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable") - ((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable"))) / "setmetatable") + ((-(((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable") - ((#((v57 ^ "setmetatable") * (v57 ^ "setmetatable"))[1]) % "setmetatable"))) / "setmetatable"))["K[2987134256]"]) * "setmetatable") -> pc1682
	local _r14_26 = {}
	_r14_26[1], _r14_26[2] = {0, -1}, {1, -23}
	Texture_15.Squash = seq
	Texture_15.Transparency = seq
	_r9.pillar = emitter
	local _r14_27 = {}
	_r14_27[1], _r14_27[2] = {0, Palette.Hot}, {1, Palette.Ember}
	local _r14_28 = {}
	_r14_28[1], _r14_28[2] = {0, 3}, {1, 0}
	local _r14_29 = {}
	local _r15_29 = {0, 0}
	_r14_29[1], _r14_29[2], _r14_29[3] = _r15_29, {0.7, 0.2}, {1, 1}
	local Texture_16 = { Texture = Textures.fireSparks, Color = grad, Brightness = 1.5, SpreadAngle = Vector2.new, Speed = NumberRange.new, Drag = 1.2, Acceleration = Vector3.new(0, -20, 0), Lifetime = NumberRange.new, Size = seq, Transparency = seq }
	_r9.embers = emitter
	local _r14_30 = {}
	local _r15_30 = {0, Palette.Gold}
	_r14_30[1], _r14_30[2], _r14_30[3] = _r15_30, {0.5, Palette.Amber}, {1, Palette.Ember}
	if ("setmetatable" - "setmetatable") <= R839650608 then
		local _r14_31 = {}
		_r14_31[1], _r14_31[2] = {0, 40}, {1, 110}
		local _r14_32 = {}
		_r14_32[1], _r14_32[2] = {0, 0.2}, {1, 1}
		local Texture_17 = { Texture = Textures.firePuff, Color = grad, LightEmission = 0.4, SpreadAngle = Vector2.new, Speed = NumberRange.new, Acceleration = Vector3.new(0, 40, 0), Lifetime = NumberRange.new, RotSpeed = nil, Size = seq, Transparency = seq, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot }
		_r9.lingerFire = emitter
		local Texture_18 = { Texture = Textures.roundGlow, Color = nil, Lifetime = nil, LockedToPart = true, Size = nil, Transparency = nil }
		return ("setmetatable" - "setmetatable")
	end
end
if _k3 and _k3 > 1 then
	for _k16, _v17 in ipairs(_v4.emitters) do
	end
	for _k16, _v17 in ipairs(_v4.rocks) do
		local w18 = ((0 or "setmetatable") + "setmetatable")(arg1, arg2, _k3, _v4)
		_v17.velocity = (_v17.velocity * (math.sqrt(_k3)))
	end
end
do return _v4 end
SOURCE_RADIUS.Impact = Impact
function _index_3._rayParams(v61) -- proto[31], line 1298  -- upvalues: Players
	if v61.params then return v61.params end
	local _r1 = {v61.folder}
	for _k5, _v6 in ipairs(Players.GetPlayers) do
		if not _v6.Character then continue end
		table.insert(_r1, _v6.Character)
	end
	RaycastParams.new.FilterType = Enum.RaycastFilterType.Exclude
	RaycastParams.new.FilterDescendantsInstances = _r1
	RaycastParams.new.IgnoreWater = true
	v61.params = RaycastParams.new
	return v61.params
end
function _index_3.Step(v62, v63, v64) -- proto[32], line 1317
	local r2
	local r30
	local w19
	local f3
	if v63 <= 0 then
		v62.light.Brightness = 0
		v62.emitters.lingerFire.Rate = 0
		v62.emitters.lingerGlow.Rate = 0
		for _k7, _v8 in ipairs(v62.rocks) do
			local v_u7 = _v8.part
			v_u7.Transparency = 1
		end
		return
	end
	if not ((v63 < 0.05)) then
		r2 = math.clamp(((v63 - 0.05) / 1.6), 0, 1)
	end
	local w20 = ((math.max((1 - (1 - ((1 - r2) * (1 - r2)))), 0)) * 16)
	v62.light.Brightness = (w20 * (1 + (math.noise * 0.3)))
	w20 = math.clamp((v63 / 0.4), 0, 1)
	v62.light.Range = ((w20 * 140) + 200)
	local w21 = ((w20 * 140) + 200)
	w21 = math.clamp((v63 / 2.6), 0, 1)
	local w22 = (1 - w21)
	v62.emitters.lingerFire.Rate = (w22 * 22)
	v62.emitters.lingerGlow.Rate = (w22 * 14)
	for _k10, _v11 in ipairs(v62.rocks) do
		if v64 then
			if 0 < v64 then
				local r31 = Vector3.new(0, ((-workspace.Gravity) * v64), 0)
				_v11.velocity = (_v11.velocity + r31)
				r30 = workspace:Raycast(_v11.position, (_v11.velocity * v64), v62:_rayParams())
				if r30 then
					local w6 = v62:_rayParams()
					_v11.velocity = ((_v11.velocity - ((2 * _v11.velocity.Dot) * r30.Normal)) * 0.35)
					_v11.position = (r30.Position + (r30.Normal * (_v11.size.Magnitude * 0.3)))
					_v11.bounces = (_v11.bounces + 1)
				else
					_v11.position = (_v11.position + (_v11.velocity * v64))
				end
				local v_u6 = _v11.spin
				if (0 < _v11.bounces) then
					w19 = (v_u6 * v64)
				end
				_v11.rotation = (_v11.rotation * CFrame.Angles)
			end
		end
		local v_u4 = ((v63 - 2.1) / 0.6)
		local r23 = (math.clamp(v_u4, 0, 1))
		local w23 = (1 - (r23 * r23))
		w23 = math.max(w23, 0.01)
		_v11.part.Size = (_v11.size * w23)
		_v11.part.CFrame = (CFrame.new * _v11.rotation)
		_v11.part.Transparency = 0
		if _v11.bounces <= 0 then
			f3 = not (0.5 >= w23)
		end
		_v11.trail.Enabled = f3
		f3 = not (v63 >= 1.4)
		_v11.fire.Enabled = f3
	end
end
local function flashGrade() -- proto[34], line 1364  -- upvalues: Lighting, RunService
	Instance.new.Name = "GildedSkiesImpactGrade"
	Instance.new.Parent = Lighting
	local connection = nil
end
function _index_3.Play(v65) -- proto[38], line 1384  -- upvalues: flashGrade, RunService, s4
	for _k4, _v5 in ipairs(v65.bursts) do
		if (_v5[3]) then
			local v1_e = _v5[1]
			local v1_e_2 = _v5[2]
		end
	end
	local connection = nil
end
local _index_4 = {}
_index_4.__index = _index_4
SOURCE_RADIUS.ARENA_GLOW_NAME = "GildedSkiesArenaGlow"
local function softCone(v66, v67, v68, v69, v70, v71) -- proto[39], line 1434  -- upvalues: Textures
	local v_u8
	local r1 = math.abs((v68 - v67).Unit.Y)
	Instance.new.Name = "LightShaft"
	Instance.new.Anchored = true
	Instance.new.CanCollide = false
	Instance.new.CanQuery = false
	Instance.new.CanTouch = false
	Instance.new.CastShadow = false
	Instance.new.Transparency = 1
	Instance.new.Size = (v67 or Vector3.new(1, 1, 1))
	Instance.new.CFrame = CFrame.lookAt
	Instance.new.Parent = v66
	local r2 = math.clamp(((v68 - v67).Magnitude * 0.5), 40, 260)
	local r24 = math.max(3, ((math.ceil(((v68 - v67).Magnitude / (r2 / 4)))) + 1))
	local _r11 = {}
	for _i = 1, r24 do
		Instance.new.Position = (Vector3.new(0, 0, (-((((_i - 1) / (r24 - 1)) * (v68 - v67).Magnitude) - (r2 / 2)))))
		Instance.new.Parent = Instance.new
		Instance.new.Position = (Vector3.new(0, 0, (-((((_i - 1) / (r24 - 1)) * (v68 - v67).Magnitude) + (r2 / 2)))))
		Instance.new.Parent = Instance.new
		Instance.new.Attachment0 = Instance.new
		Instance.new.Attachment1 = Instance.new
		Instance.new.Texture = Textures.roundGlow
		Instance.new.TextureMode = Enum.TextureMode.Stretch
		Instance.new.Color = ColorSequence.new
		Instance.new.LightEmission = 1
		Instance.new.LightInfluence = 0
		Instance.new.FaceCamera = true
		Instance.new.Segments = 1
		v_u8 = r2 / 2
		local w25 = (((((_i - 1) / (r24 - 1)) * (v68 - v67).Magnitude) - v_u8) / (v68 - v67).Magnitude)
		v71 = math.clamp(w25, 0, 1)
		Instance.new.Width0 = (v69 + ((v70 - v69) * v71))
		v_u8 = r2 / 2
		local w26 = (((((_i - 1) / (r24 - 1)) * (v68 - v67).Magnitude) + v_u8) / (v68 - v67).Magnitude)
		v71 = math.clamp(w26, 0, 1)
		Instance.new.Width1 = (v69 + ((v70 - v69) * v71))
		Instance.new.Transparency = NumberSequence.new
		Instance.new.Parent = Instance.new
		table.insert(_r11, Instance.new)
	end
	return _r11
end
local function pushArenaGlow() -- proto[41], line 1471  -- upvalues: Lighting, s4, TweenService
	local Ambient
	Instance.new.Name = s4.ARENA_GLOW_NAME
	Instance.new.Brightness = 0.25
	Instance.new.Contrast = 0.1
	Instance.new.TintColor = Color3.fromRGB
	Instance.new.Parent = Lighting
	local w27 = Lighting.Ambient
	local Brightness = { Brightness = 0.04, Contrast = 0.06, Saturation = 0.1, TintColor = Color3.fromRGB }
	Ambient = { Ambient = w27.Lerp, OutdoorAmbient = Lighting.OutdoorAmbient.Lerp }
	Ambient = w27
	local OutdoorAmbient = Lighting.OutdoorAmbient
	local function anon40() -- proto[40], line 1497  -- upvalues: new, Lighting, Ambient, OutdoorAmbient
		Lighting.Ambient = Ambient
		Lighting.OutdoorAmbient = OutdoorAmbient
	end
	return anon40
end
local s7 = _index_4
function SOURCE_RADIUS.Sun(v72, v73, v74) -- proto[42], line 1506  -- upvalues: s7, Palette, emitter, Textures, seq, grad, ParticleOrientation, ParticleEmitterShape, ParticleEmitterShapeStyle, s1, softCone
	local object = setmetatable(({}), s7)
	object.position = v73
	object.arena = v74
	object.lastRing = 0
	object.flooded = false
	object.folder = Instance.new
	object.folder.Name = "Sun"
	object.folder.Parent = v72
	Instance.new.Name = "Core"
	Instance.new.Anchored = true
	Instance.new.CanCollide = false
	Instance.new.CanQuery = false
	Instance.new.CanTouch = false
	Instance.new.CastShadow = false
	Instance.new.Transparency = 1
	Instance.new.Size = (v73 or Vector3.new(1, 1, 1))
	Instance.new.CFrame = CFrame.new
	Instance.new.Parent = object.folder
	local w3 = (v73 or Vector3.new(1, 1, 1))
	Instance.new.Color = Palette.Hot
	Instance.new.Range = 60
	Instance.new.Brightness = 0
	Instance.new.Shadows = false
	Instance.new.Parent = Instance.new
	object.light = Instance.new
	local Name = { Name = "Halo", Texture = Textures.roundGlow, Color = ColorSequence.new, Lifetime = NumberRange.new, Rate = 18, LockedToPart = true, ZOffset = -1 }
	object.halo = emitter
	local Name_2 = { Name = "Flare", Texture = Textures.flare, Color = ColorSequence.new, Lifetime = NumberRange.new, Rate = 26, LockedToPart = true }
	object.flare = emitter
	if ((v72 ^ "setmetatable") * (v72 ^ "setmetatable")) > K[788990000] then
		local _r9 = {}
		local _r10 = {0, 1}
		local _r11 = {0.3, 0.62}
		_r9[1], _r9[2], _r9[3], _r9[4] = _r10, _r11, {0.7, 0.62}, {1, 1}
		local Name_3 = { Name = "Rays", Texture = Textures.flare, Color = ColorSequence.new, Lifetime = NumberRange.new, RotSpeed = NumberRange.new, LockedToPart = true, Size = nil, Transparency = seq, ZOffset = -2 }
		object.rays = emitter
		local _r9_2 = {}
		_r9_2[1], _r9_2[2] = {0, 70, 25}, {1, 90, 25}
		local Name_4 = { Name = "Arcs", Texture = Textures.arcs, Color = nil, Brightness = 1.5, Lifetime = NumberRange.new, Size = seq, LockedToPart = true, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot }
		object.arcs = emitter
		local _r9_3 = {}
		_r9_3[1], _r9_3[2] = {0, Palette.Deep}, {1, Palette.Hot}
		local _r9_4 = {}
		_r9_4[1], _r9_4[2] = {0, 484.00000000000006}, {1, 40}
		-- FORGPREP R0 iter=(#((v72 ^ "setmetatable") * (v72 ^ "setmetatable")))[1] -> pc361
		local _r9_5 = {}
		local _r10_5 = {0, 1}
		local _r11_5 = {0.35, 0.3}
		_r9_5[1], _r9_5[2], _r9_5[3], _r9_5[4] = _r10_5, _r11_5, {0.85, 0.45}, {1, 1}
		local Name_5 = { Name = "ImplodeRing", Texture = Textures.dome, Color = grad, Brightness = 1.4, Lifetime = NumberRange.new, RotSpeed = NumberRange.new, LockedToPart = true, Size = seq, Transparency = seq }
		_k3.implode = R5
		v73.Name = "Shell"
		v73.Anchored = true
		v73.CanCollide = false
		v73.CanQuery = false
		v73.CanTouch = false
		v73.CastShadow = false
		v73.Transparency = 1
		v73.Size = Vector3.new(440, 440, 440)
		v73.CFrame = CFrame.new
		v73.Parent = _k3.folder
		v73.Shape = Enum.PartType.Ball
		local _r10_6 = {}
		_r10_6[1], _r10_6[2] = {0, Palette.Deep}, {1, Palette.Hot}
		local _r10_7 = {}
		_r10_7[1], _r10_7[2] = {0, 4}, {1, 1.5}
		local _r10_8 = {}
		_r10_8[1], _r10_8[2] = {0, 3}, {1, 9}
		local _r10_9 = {}
		local _r11_9 = {0, 1}
		local _r12_6 = {0.3, 0}
		_r10_9[1], _r10_9[2], _r10_9[3], _r10_9[4] = _r11_9, _r12_6, {0.85, 0}, {1, 1}
		local Name_6 = { Name = "Streaks", Texture = Textures.spark, Color = grad, Brightness = 1.6, Orientation = ParticleOrientation.VelocityParallel, Shape = ParticleEmitterShape.Sphere, ShapeStyle = ParticleEmitterShapeStyle.Surface, ShapeInOut = Enum.ParticleEmitterShapeInOut.Inward, Speed = NumberRange.new, Lifetime = NumberRange.new, Rotation = NumberRange.new, Size = seq, Squash = seq, Transparency = seq }
		_k3.streaks = emitter
		local _r10_10 = {}
		_r10_10[1], _r10_10[2] = {0, Palette.Gold}, {1, Palette.Hot}
		local _r10_11 = {}
		_r10_11[1], _r10_11[2] = {0, 90}, {1, 25}
		local _r10_12 = {}
		local _r11_12 = {0, 1}
		local _r12_9 = {0.3, 0.4}
		_r10_12[1], _r10_12[2], _r10_12[3], _r10_12[4] = _r11_12, _r12_9, {0.85, 0.5}, {1, 1}
		local Name_7 = { Name = "Inflow", Texture = Textures.wisps, Color = grad, LightEmission = 0.6, Shape = ParticleEmitterShape.Sphere, ShapeStyle = ParticleEmitterShapeStyle.Surface, ShapeInOut = Enum.ParticleEmitterShapeInOut.Inward, Speed = NumberRange.new, Lifetime = NumberRange.new, RotSpeed = NumberRange.new, Size = seq, Transparency = seq, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot }
		if (((#(#((v72 ^ "setmetatable") * (v72 ^ "setmetatable")))[1]) % "setmetatable") - ((#(#((v72 ^ "setmetatable") * (v72 ^ "setmetatable")))[1]) % "setmetatable")) ~= false then
			Instance.new.Name = "Front"
			Instance.new.Anchored = true
			Instance.new.CanCollide = false
			Instance.new.CanQuery = false
			Instance.new.CanTouch = false
			Instance.new.CastShadow = false
			Instance.new.Transparency = 1
			Instance.new.Size = (v73 or Vector3.new(1, 1, 1))
			Instance.new.CFrame = CFrame.new
			Instance.new.Parent = _k3.folder
			_k3.front = Instance.new
			local w4 = (v73 or Vector3.new(1, 1, 1))
			local _r10_13 = {}
			_r10_13[1], _r10_13[2] = {0, Palette.Hot}, {1, Palette.Deep}
			local _r10_14 = {}
			_r10_14[1], _r10_14[2] = {0, 150}, {1, 220}
			(((#(#((v72 ^ "setmetatable") * (v72 ^ "setmetatable")))[1]) % "setmetatable") - ((#(#((v72 ^ "setmetatable") * (v72 ^ "setmetatable")))[1]) % "setmetatable"))["K[789055792]"] = (((#(#((v72 ^ "setmetatable") * (v72 ^ "setmetatable")))[1]) % "setmetatable") - ((#(#((v72 ^ "setmetatable") * (v72 ^ "setmetatable")))[1]) % "setmetatable"))
			local _r10_15 = {}
			local _r11_15 = {0, 1}
			_r10_15[1], _r10_15[2], _r10_15[3] = _r11_15, {0.2, 0.45}, {1, 1}
			local Name_8 = { Name = "Vortex", Texture = Textures.swirl, Color = grad, LightEmission = 0.7, Lifetime = NumberRange.new, RotSpeed = NumberRange.new, LockedToPart = true, Size = nil, Transparency = seq, FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4, FlipbookMode = Enum.ParticleFlipbookMode.OneShot }
			_k3.vortex = emitter
			local _r10_16 = {}
			local _r11_16 = {0, 0}
			_r10_16[1], _r10_16[2], _r10_16[3] = _r11_16, {0.1, 700}, {1, 500}
			local _r10_17 = {}
			local _r11_17 = {0, 0.01}
			_r10_17[1], _r10_17[2], _r10_17[3] = _r11_17, {0.3, 0.6}, {1, 0}
			local _r10_18 = {}
			_r10_18[1], _r10_18[2] = {0, 0}, {1, 1}
			local Name_9 = { Name = "FloodFlash", Texture = Textures.popGlow, Color = ColorSequence.new, Brightness = 1.6, Lifetime = nil, Rotation = NumberRange.new, LockedToPart = true, Size = seq, Squash = seq, Transparency = seq, ZOffset = 5 }
			_k3.flash = emitter
			local _r10_19 = {}
			_r10_19[1], _r10_19[2] = {0, 1200}, {1, 500}
			local _r10_20 = {}
			_r10_20[1], _r10_20[2] = {0, 0}, {1, 1}
			local Name_10 = { Name = "FloodFlare", Texture = Textures.flare, Color = ColorSequence.new, Brightness = 1.3, Lifetime = NumberRange.new, LockedToPart = true, Size = seq, Transparency = seq, ZOffset = 4 }
			_k3.floodFlare = emitter
			local _r10_21 = {}
			_r10_21[1], _r10_21[2] = {0, Palette.Hot}, {1, Palette.Deep}
			local _r10_22 = {}
			local _r11_22 = {0, 40}
			_r10_22[1], _r10_22[2], _r10_22[3] = _r11_22, {0.25, 900}, {1, 1700}
			local Name_11 = { Name = "FloodWave", Texture = Textures.dome, Color = grad, Brightness = 1.2, Lifetime = NumberRange.new, RotSpeed = NumberRange.new, LockedToPart = true, Size = seq, Transparency = seq }
			_k3.floodWave = emitter
			local _r10_23 = {}
			_r10_23[1], _r10_23[2] = {0, Palette.Hot}, {1, Palette.Deep}
			if (((-(((#(#((v72 ^ "setmetatable") * (v72 ^ "setmetatable")))[1]) % "setmetatable") - ((#(#((v72 ^ "setmetatable") * (v72 ^ "setmetatable")))[1]) % "setmetatable"))) / "setmetatable") + ((-(((#(#((v72 ^ "setmetatable") * (v72 ^ "setmetatable")))[1]) % "setmetatable") - ((#(#((v72 ^ "setmetatable") * (v72 ^ "setmetatable")))[1]) % "setmetatable"))) / "setmetatable")) ~= nil then
				local _r10_24 = {}
				_r10_24[1], _r10_24[2] = {0, 4}, {1, 0}
				local Name_12 = { Name = "FloodSparks", Texture = Textures.fireSparks, Color = grad, Brightness = 1.6, SpreadAngle = Vector2.new, Speed = nil, Drag = 1.5, Acceleration = Vector3.new(0, -20, 0), Lifetime = NumberRange.new, Size = seq }
				_k3.floodSparks = emitter
				_k3.shaft = softCone
				_k3.shaftTransparency = 0.72
				0.72.Name = "Pool"
				0.72.Anchored = true
				0.72.CanCollide = false
				0.72.CanQuery = false
				0.72.CanTouch = false
				0.72.CastShadow = false
				0.72.Transparency = 1
				0.72.Size = ((v74 + Vector3.new(0, 0.5, 0)) or Vector3.new(1, 1, 1))
				0.72.CFrame = CFrame.new
				0.72.Parent = _k3.folder
				-- FORGPREP_NEXT R0 iter=(((-(((#(#((v72 ^ "setmetatable") * (v72 ^ "setmetatable")))[1]) % "setmetatable") - ((#(#((v72 ^ "setmetatable") * (v72 ^ "setmetatable")))[1]) % "setmetatable"))) / "setmetatable") + ((-(((#(#((v72 ^ "setmetatable") * (v72 ^ "setmetatable")))[1]) % "setmetatable") - ((#(#((v72 ^ "setmetatable") * (v72 ^ "setmetatable")))[1]) % "setmetatable"))) / "setmetatable"))["K[656978]"] -> pc1341
				local _r11_25 = {}
				local _r12_22 = {0, 1}
				local _r13_9 = {0.3, 0.72}
				_r11_25[1], _r11_25[2], _r11_25[3], _r11_25[4] = _r12_22, _r13_9, {0.7, 0.72}, {1, 1}
				local Name_13 = { Name = "Pool", Texture = Textures.roundGlow, Color = ColorSequence.new, Orientation = ParticleOrientation.VelocityPerpendicular, EmissionDirection = Enum.NormalId.Top, Speed = NumberRange.new, Lifetime = NumberRange.new, LockedToPart = true, Size = NumberSequence.new, Transparency = seq }
				_k3.pool = emitter
				Instance.new.Name = "Motes"
				Instance.new.Anchored = true
				Instance.new.CanCollide = false
				Instance.new.CanQuery = false
				Instance.new.CanTouch = false
				Instance.new.CastShadow = false
				Instance.new.Transparency = 1
				Instance.new.Size = Vector3.new(260, 100, 260)
				Instance.new.CFrame = CFrame.new
				Instance.new.Parent = _k3.folder
				local _r12_23 = {}
				local _r13_10 = {0, 0}
				local _r14_4 = {0.2, 1.4}
				_r12_23[1], _r12_23[2], _r12_23[3], _r12_23[4] = _r13_10, _r14_4, {0.8, 1.4}, {1, 0}
				local _r12_24 = {}
				local _r13_11 = {0, 1}
				local _r14_5 = {0.25, 0.2}
				_r12_24[1], _r12_24[2], _r12_24[3], _r12_24[4] = _r13_11, _r14_5, {0.75, 0.2}, {1, 1}
				local Name_14 = { Name = "Motes", Texture = Textures.spark, Color = ColorSequence.new, Brightness = 1.5, SpreadAngle = Vector2.new, Speed = NumberRange.new, Acceleration = Vector3.new(0, 1.5, 0), Lifetime = NumberRange.new, RotSpeed = NumberRange.new, Size = seq, Transparency = seq }
				_k3.motes = emitter
				return _k3
			end
		end
	end
end
function _index_4.SetAbsorb(v75, v76, v77) -- proto[43], line 1700  -- upvalues: seq
	if v75.flooded then return end
	local r2 = math.clamp(v76, 0, 1)
	local w5 = (((math.sin((os.clock * ((r2 * 22) + 6)))) * ((r2 * 0.05) + 0.03)) + 1)
	v75.front.CFrame = CFrame.new
	local _r9 = {}
	_r9[1], _r9[2] = {0, ((((r2 * r2) * 320) + 60) * w5)}, {1, (((((r2 * r2) * 320) + 60) * w5) * 1.1)}
	v75.halo.Size = seq
	local _r9_2 = {}
	local _r10_2 = {0, 1}
	_r9_2[1], _r9_2[2], _r9_2[3] = _r10_2, {0.25, ((r2 * -0.4) + 0.9)}, {1, 1}
	v75.halo.Transparency = seq
	local _r10_3 = {}
	_r10_3[1], _r10_3[2] = {0, (((r2 * 220) + 40) * w5), ((((r2 * 220) + 40) * w5) * 0.2)}, {1, ((((r2 * 220) + 40) * w5) * 0.8), ((((r2 * 220) + 40) * w5) * 0.2)}
	local w1 = v75.flare
	w1.Size = seq
	(v75 ^ "flooded").flare.Brightness = ((r2 * 0.7999999999999999) + 0.6)
	(v75 ^ "flooded").vortex.Rate = ((r2 * 6) + 2)
	(v75 ^ "flooded").arcs.Rate = ((r2 * 20) + 4)
	(v75 ^ "flooded").streaks.Rate = ((r2 * 160) + 60)
	(v75 ^ "flooded").inflow.Rate = ((r2 * 14) + 6)
	(v75 ^ "flooded").light.Brightness = ((r2 * 5) + 1)
	if ((r2 * -0.22999999999999998) + 0.35) > (os.clock - (v75 ^ "flooded").lastRing) then return end
	(v75 ^ "flooded").lastRing = os.clock
end
function _index_4.Flood(v78) -- proto[46], line 1726  -- upvalues: seq, RunService, pushArenaGlow
	if v78.flooded then return end
	v78.flooded = true
	_r1[1], _r1[2], _r1[3] = v78.streaks, v78.inflow, v78.vortex
	for _k4, _v5 in {} do
		_v5.Rate = 0
	end
	local _r3 = {}
	_r3[1], _r3[2] = {0, 300}, {1, 340}
	(v78 ^ "flooded").halo.Size = seq
	local _r3_2 = {}
	local _r4_2 = {0, 1}
	_r3_2[1], _r3_2[2], _r3_2[3] = _r4_2, {0.25, 0.55}, {1, 1}
	(v78 ^ "flooded").halo.Transparency = seq
	local _r3_3 = {}
	_r3_3[1], _r3_3[2] = {0, 200, 40}, {1, 170, 40}
	(v78 ^ "flooded").flare.Size = seq
	(v78 ^ "flooded").flare.Brightness = 1.2
	(v78 ^ "flooded").rays.Rate = 1.2
	(v78 ^ "flooded").arcs.Rate = 3
	(v78 ^ "flooded").light.Brightness = 4
	(v78 ^ "flooded").pool.Rate = 1.2
	(v78 ^ "flooded").motes.Rate = 45
	local v78 = (v78 ^ "flooded")
	local index = (1 - (v78 ^ "flooded").shaftTransparency)
	((v78 ^ "flooded") * (v78 ^ "flooded")).connection = RunService.Heartbeat.Connect
	((v78 ^ "flooded") * (v78 ^ "flooded")).restoreLighting = pushArenaGlow
end
-- Destroy captures:
_index_4.Destroy = Destroy
SOURCE_RADIUS.BLOOM_NAME = "GildedSkiesEasterEggBloom"
function SOURCE_RADIUS.PushBloom() -- proto[50], line 1788  -- upvalues: Lighting, s4, RunService
	Instance.new.Name = s4.BLOOM_NAME
	Instance.new.Intensity = 0.4
	Instance.new.Size = 28
	Instance.new.Threshold = 1.4
	Instance.new.Parent = Lighting
	local function anon49() -- proto[49], line 1800  -- upvalues: RunService, new
		local connection = nil
	end
	return anon49
end
return SOURCE_RADIUS