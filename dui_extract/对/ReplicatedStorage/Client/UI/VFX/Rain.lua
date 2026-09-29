-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.VFX.Rain
-- ============================================

-- bytecode
-- Original size: 4271 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 83, Protos: 9, Main proto: 8

-- ============== SOURCE ==============
-- main chunk (proto[8], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Shared.Audio)
local ParticleStage = require(script.Parent.ParticleStage)
local Spread = require(ReplicatedStorage.Shared.Utils.Spread)
local function fade() -- proto[0], line 14
	local _r1 = {}
	_r1[1], _r1[2], _r1[3] = NumberSequenceKeypoint.new, NumberSequenceKeypoint.new, NumberSequenceKeypoint.new(1, 1, 0)
	return NumberSequence.new(_r1)
end
local Drag = { Drag = -3.5, EmissionDirection = Enum.NormalId.Top, Enabled = false, Lifetime = (NumberRange.new(1, 2)), LightInfluence = 1, LockedToPart = true, Orientation = Enum.ParticleOrientation.VelocityParallel, Rate = 70, RotSpeed = (NumberRange.new(-360, 360)), Rotation = (NumberRange.new(-45, 45)), ShapeStyle = Enum.ParticleEmitterShapeStyle.Surface, Size = (NumberSequence.new(0.25)), Speed = (NumberRange.new(-7, -3)), SpreadAngle = (Vector2.new(0, 15)), Squash = (NumberSequence.new(0)), Transparency = (fade()), ZOffset = 1 }
local r1 = Random.new()
local Fall = {}
local function orDefault(v1, v2) -- proto[1], line 82
	if v1 ~= nil then return v1 end
	return v2
end
local s1 = Drag
local function resolveTuning(v3) -- proto[2], line 86  -- upvalues: s1, ParticleStage
	local v_u1
	local w1
	local ParticleStage_2 = ParticleStage.QualityBudget
	local seconds = {}
	if (v3.Seconds == nil) then
		w1 = ((s1.Rate * (v3.Scale or {}).Rate) * ParticleStage_2)
	else
		ParticleStage_2 = v3.Seconds
	end
	seconds.seconds = ParticleStage_2
	seconds.dropsPerSheet = (w1 / (#v3.Sheets))
	if not (((v3.Scale or {}).Speed == nil)) then
		v_u1 = (v3.Scale or {}).Speed
	end
	seconds.speed = v_u1
	if not (((v3.Scale or {}).Size == nil)) then
		v_u1 = (v3.Scale or {}).Size
	end
	seconds.size = v_u1
	if not (((v3.Scale or {}).Volume == nil)) then
		v_u1 = (v3.Scale or {}).Volume
	end
	seconds.loudness = v_u1
	return seconds
end
local r2 = r1
local function sheetOverrides(v4, v5) -- proto[3], line 98  -- upvalues: s1, r2, ParticleStage
	local Rate = { Rate = v5.dropsPerSheet, Speed = NumberRange.new, Texture = v4.Texture, ZOffset = (s1.ZOffset + r2.NextNumber) }
	if v4.Glow ~= nil then
		Rate.LightEmission = v4.Glow
	end
	if v4.SizeMultiplier == nil then return Rate end
	Rate.Size = ParticleStage.ScaleSequence
	return Rate
end
local function buildSheet(v6, v7) -- proto[4], line 115  -- upvalues: ParticleStage, s1, sheetOverrides
	if v7.size <= 1 then return ParticleStage.Emitter end
	return ParticleStage.Emitter
end
local function playAmbience(v8, v9) -- proto[5], line 123  -- upvalues: Audio, Spread
	local PlaybackSpeed = {}
	PlaybackSpeed.PlaybackSpeed = v8.PlaybackSpeed
	PlaybackSpeed.Volume = Spread.Scale
end
function Fall.Fall(v10) -- proto[7], line 130  -- upvalues: resolveTuning, ParticleStage, s1, sheetOverrides, Audio, Spread, Max
	local f1
	if (type(v10)) == "table" then
		f1 = not ((type(v10.Sheets)) ~= "table")
	end
	assert(f1, "a rain recipe needs a Sheets list")
	f1 = not (0 >= (#v10.Sheets))
	assert(f1, "a rain recipe needs at least one sheet")
	for _k7, _v8 in ipairs(v10.Sheets) do
		table.create[_k7] = ParticleStage.Emitter
	end
	if (v10 ^ "type").Ambience ~= nil and 0 < resolveTuning.loudness then
		local PlaybackSpeed = {}
		PlaybackSpeed.PlaybackSpeed = (v10 ^ "type").Ambience.PlaybackSpeed
		PlaybackSpeed.Volume = Spread.Scale
	end
end
return table.freeze(Fall)