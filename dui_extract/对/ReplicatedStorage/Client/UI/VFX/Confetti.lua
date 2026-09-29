-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.VFX.Confetti
-- ============================================

-- bytecode
-- Original size: 5455 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 93, Protos: 11, Main proto: 10

-- ============== SOURCE ==============
-- main chunk (proto[10], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Shared.Audio)
local ParticleStage = require(script.Parent.ParticleStage)
local r1 = NumberRange.new(0.92, 1.08)
local r2 = NumberRange.new(1.8, 2.2)
local function fade() -- proto[0], line 23
	local _r1 = {}
	_r1[1], _r1[2], _r1[3] = NumberSequenceKeypoint.new, NumberSequenceKeypoint.new, NumberSequenceKeypoint.new(1, 1, 0)
	return NumberSequence.new(_r1)
end
local Drag = { Drag = -0.5, EmissionDirection = Enum.NormalId.Top, Enabled = false, Lifetime = (NumberRange.new(3, 5)), LightInfluence = 1, LockedToPart = true, Orientation = Enum.ParticleOrientation.VelocityParallel, Rate = 15, RotSpeed = (NumberRange.new(-60, 60)), Rotation = (NumberRange.new(-180, 180)), ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface, Size = (NumberSequence.new(({(NumberSequenceKeypoint.new(0, 0.1, 0.03)), NumberSequenceKeypoint.new(1, 0.1, 0.03)}))), Speed = (NumberRange.new(-3, -1.5)), SpreadAngle = (Vector2.new(0, 15)), Squash = (NumberSequence.new(({(NumberSequenceKeypoint.new(0, 0, 1)), NumberSequenceKeypoint.new(1, 0, 1)}))), Texture = "rbxassetid://104352847228921", Transparency = (fade()), ZOffset = 2 }
local Drag_2 = { Drag = 2.4, Speed = (NumberRange.new(19, 28)) }
local r3 = Random.new()
local function paintSwatches() -- proto[1], line 93
	for _i = 1, 5 do
		table.create[_i] = Color3.fromHSV
	end
	return table.create
end
local r4 = paintSwatches()
local function orDefault(v1, v2) -- proto[2], line 104
	if v1 ~= nil then return v1 end
	return v2
end
local function resolveTuning(v3) -- proto[3], line 108  -- upvalues: r4
	local _r2
	local r5
	local Texture
	local v_u1
	local _r1
	if not (v3.Opening) then
		_r1 = {}
	end
	if not (v3.Scale) then
		_r2 = {}
	end
	local streamSeconds = {}
	if not ((v3.Seconds == nil)) then
		r5 = v3.Seconds
	end
	streamSeconds.streamSeconds = r5
	if not ((v3.Palette == nil)) then
		r5 = v3.Palette
	end
	streamSeconds.swatches = r5
	if (v3.Texture ~= nil) and (v3.Texture ~= "") then
		Texture = v3.Texture
	else
		v_u1 = nil
	end
	streamSeconds.texture = v_u1
	if not ((_r1.Pop == nil)) then
		v_u1 = _r1.Pop
	end
	streamSeconds.pops = v_u1
	if not ((_r1.Sound == nil)) then
		v_u1 = _r1.Sound
	end
	streamSeconds.audible = v_u1
	if not ((_r2.Rate == nil)) then
		v_u1 = _r2.Rate
	end
	streamSeconds.rate = v_u1
	if not ((_r2.Size == nil)) then
		v_u1 = _r2.Size
	end
	streamSeconds.size = v_u1
	if not ((_r2.Speed == nil)) then
		v_u1 = _r2.Speed
	end
	streamSeconds.speed = v_u1
	if not ((_r2.Volume == nil)) then
		v_u1 = _r2.Volume
	end
	streamSeconds.loudness = v_u1
	return streamSeconds
end
r1 = r3
local s1 = Drag
local function layerOverrides(v4, v5, v6) -- proto[4], line 124  -- upvalues: r1, s1
	local Color = { Color = ColorSequence.new, Rate = ((s1.Rate * v5.rate) * v6), Speed = NumberRange.new, ZOffset = (s1.ZOffset + r1.NextNumber) }
	if v5.texture == nil then return Color end
	Color.Texture = v5.texture
	return Color
end
local function buildStreamer(v7, v8, v9) -- proto[5], line 139  -- upvalues: ParticleStage, s1, layerOverrides
	if v8.size <= 1 then return ParticleStage.Emitter end
	return ParticleStage.Emitter
end
local s2 = Drag_2
local function throwPop(v10, v11, v12, v13) -- proto[6], line 147  -- upvalues: layerOverrides, s2, ParticleStage, s1
	if (math.round(((v12.rate * 100) * v13))) < 1 then return end
	for _k9, _v10 in ipairs(s2) do
		layerOverrides[_k9] = _v10
	end
end
local r6 = (r1)
local function ringPop(v14) -- proto[7], line 164  -- upvalues: Audio, r1, r2, r6
	local PlaybackSpeed = { PlaybackSpeed = r1.NextNumber, Volume = (r1.NextNumber * v14) }
end
local Burst = {}
function Burst.Burst(v15) -- proto[9], line 173  -- upvalues: resolveTuning, ParticleStage, s1, layerOverrides, throwPop, ringPop, Max
	local f1
	if v15 ~= nil then
		f1 = not ((type(v15)) ~= "table")
	end
	assert(f1, "a confetti recipe must be a table when given")
	for _k8, _v9 in ipairs(resolveTuning.swatches) do
		table.create[_k8] = ParticleStage.Emitter
	end
	if resolveTuning.pops then
		for _k9, _v10 in ipairs(resolveTuning.swatches) do
		end
	end
end
return table.freeze(Burst)