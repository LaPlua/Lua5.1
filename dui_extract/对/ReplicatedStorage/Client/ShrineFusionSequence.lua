-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.ShrineFusionSequence
-- ============================================

-- bytecode
-- Original size: 44606 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 294, Protos: 54, Main proto: 53

-- ============== SOURCE ==============
-- main chunk (proto[53], line 1)
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local EggEnergyOrbField = require(ReplicatedStorage.Shared.Eggs.EggEnergyOrbField)
local Flash = require(ReplicatedStorage.Client.UI.VFX.Flash)
local Shake = require(ReplicatedStorage.Client.Shake)
local Trove = require(ReplicatedStorage.Packages.Trove)
local VFX = require(ReplicatedStorage.Shared.Utils.VFX)
local Light = { Light = (Color3.fromRGB(255, 209, 74)), Dark = (Color3.fromRGB(168, 26, 22)) }
local Light_2 = { Light = {(Color3.fromRGB(255, 250, 214)), Color3.fromRGB(255, 198, 44)}, Dark = {(Color3.fromRGB(196, 40, 30)), Color3.fromRGB(84, 6, 12)} }
local r1 = Color3.new(1, 1, 1)
local s1 = {}
local r2 = Random.new()
local function fuseTrack(v1) -- proto[1], line 121  -- upvalues: Audio
	local Volume = { Volume = 1 }
	if not pcall then return end
	if (typeof(Audio.Play)) ~= "Instance" then return end
end
local function debris() -- proto[2], line 131  -- upvalues: Workspace
	if Workspace.FindFirstChild then return Workspace end
	return Workspace
end
local function bezier(v2, v3, v4, v5) -- proto[3], line 135
	return (((v2 * ((1 - v5) * (1 - v5))) + (v3 * (((1 - v5) * 2) * v5))) + (v4 * (v5 * v5)))
end
local function lerp(v6, v7, v8) -- proto[4], line 140
	return (v6 + ((v7 - v6) * v8))
end
local function backOut(v9) -- proto[5], line 144
	return ((((((v9 - 1) * 2.70158) * (v9 - 1)) * (v9 - 1)) + 1) + (((v9 - 1) * 1.70158) * (v9 - 1)))
end
local function quadIn(v10) -- proto[6], line 151  -- upvalues: TweenService
	return TweenService:GetValue(v10, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
end
local function quadInOut(v11) -- proto[7], line 155  -- upvalues: TweenService
	return TweenService:GetValue(v11, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
end
local function cubicIn(v12) -- proto[8], line 159  -- upvalues: TweenService
	return TweenService:GetValue(v12, Enum.EasingStyle.Cubic, Enum.EasingDirection.In)
end
local function freeze(v13) -- proto[9], line 163
	for _k4, _v5 in ipairs(v13.GetDescendants) do
		if not _v5.IsA then continue end
		_v5.Anchored = true
		_v5.CanCollide = false
		_v5.CanQuery = false
		_v5.CanTouch = false
		_v5.Massless = true
		_v5.LocalTransparencyModifier = 0
	end
end
local function detach(v14) -- proto[10], line 176
	for _k4, _v5 in ipairs(v14.GetDescendants) do
		if not (_v5.IsA) then
			continue
		end
		if not (_v5.IsA) then
			_v5.Enabled = false
			continue
		end
		if not _v5.IsA then continue end
		_v5.Enabled = false
	end
end
local function normalizeProp(v15, v16) -- proto[11], line 193
	v15.PrimaryPart = nil
	v15.WorldPivot = v15.GetBoundingBox
	local r3 = math.max(v15.X, v15.Y, v15.Z)
	if 0.01 >= r3 then return end
	local w1 = v15.GetScale
	local w2 = (w1 * (v16 / r3))
	local r4 = math.clamp(w2, 0.01, 50)
end
local _r33 = {}
local _mode = { __mode = "k" }
local object = setmetatable(_r33, _mode)
local _r34 = {}
local _mode_2 = { __mode = "k" }
local object_2 = setmetatable(_r34, _mode_2)
local _r35 = {}
local _mode_3 = { __mode = "k" }
local object_3 = setmetatable(_r35, _mode_3)
local _r36 = {}
local _mode_4 = { __mode = "k" }
local object_4 = setmetatable(_r36, _mode_4)
local function switchable(v17) -- proto[12], line 208
	if v17.IsA then return (v17 ^ "ParticleEmitter").IsA end
	local w3 = v17.IsA
	if w3 then return (v17 ^ "ParticleEmitter").IsA end
	if (v17 ^ "ParticleEmitter").IsA then return (v17 ^ "ParticleEmitter").IsA end
	return (v17 ^ "ParticleEmitter").IsA
end
object = object_4
object_2 = object
object_4 = object_2
local function hideItem(v18) -- proto[13], line 219  -- upvalues: object, object_2, object_3, switchable, object_4
	if v18.IsA then
		object[v18] = true
		v18.LocalTransparencyModifier = 1
		return
	end
	if not (v18.IsA) then
		if object_2[v18] == nil then
			object_2[v18] = v18.Enabled
		end
		v18.Enabled = false
		return
	end
	if v18.IsA then
		if object_3[v18] == nil then
			object_3[v18] = v18.Transparency
		end
		v18.Transparency = 1
		return
	end
	if not switchable then return end
	local w4 = (v18 ^ "BasePart")
	if object_4[w4] == nil then
		object_4[w4] = w4.Enabled
	end
	w4.Enabled = false
	if not w4.IsA then return end
end
local function showItem(v19) -- proto[14], line 245  -- upvalues: object, object_2, object_3, switchable, object_4
	if v19.IsA then
		object[v19] = nil
		v19.LocalTransparencyModifier = 0
		return
	end
	if not (v19.IsA) then
		v19.Enabled = true
		object_2[v19] = nil
		return
	end
	if v19.IsA then
		v19.Transparency = 0
		object_3[v19] = nil
		return
	end
	if not switchable then return end
	local w4 = (v19 ^ "BasePart")
	w4.Enabled = true
	object_4[w4] = nil
end
local function setToolVisibility(v20, v21) -- proto[15], line 265  -- upvalues: hideItem, showItem
	if not (v20) then return end
	for _k5, _v6 in ipairs(v20.GetDescendants) do
	end
end
local Eggs = ReplicatedStorage.Assets.Models.Eggs
local function eggTemplate(v22, v23) -- proto[16], line 278  -- upvalues: Eggs
	if Eggs.FindFirstChild then
		if (Eggs.FindFirstChild).IsA then return Eggs.FindFirstChild end
		return nil
	end
end
local function fallbackProp(v24) -- proto[17], line 288
	Instance.new.Shape = Enum.PartType.Ball
	Instance.new.Material = Enum.Material.Neon
	Instance.new.Color = v24
	Instance.new.Size = Vector3.new(2.5999999046325684, 2.5999999046325684, 2.5999999046325684)
	Instance.new.Anchored = true
	Instance.new.CanCollide = false
	Instance.new.CanQuery = false
	Instance.new.CanTouch = false
	Instance.new.Parent = Instance.new
	Instance.new.WorldPivot = Instance.new.CFrame
	return Instance.new
end
local function tintEmitters(v25, v26, v27) -- proto[18], line 304
	_r4[1], _r4[2], _r4[3] = ColorSequenceKeypoint.new, (ColorSequenceKeypoint.new(0.4, v26:Lerp(v27, 0.65))), ColorSequenceKeypoint.new(1, v27)
	for _k7, _v8 in {} do
		if not (_v8.IsA) then
			if not _v8.IsA then continue end
		end
		_v8.Color = ColorSequence.new
	end
end
local Particles = ReplicatedStorage.Assets.Particles
local function chargeHost(v28) -- proto[19], line 317  -- upvalues: Particles
	local v_u2 = nil
	v_u2 = Instance.new
	v_u2.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
	v_u2.Transparency = 1
	v_u2.Anchored = true
	v_u2.CanCollide = false
	v_u2.CanQuery = false
	v_u2.CanTouch = false
	v_u2.CastShadow = false
	if not (v_u2.FindFirstChild) then
		Instance.new.Name = "Enable"
		Instance.new.Parent = v_u2
	end
	local w5 = v_u2.FindFirstChild
	if w5 then
		if w5.IsA then return v_u2, Instance.new, w5 end
		return v_u2, Instance.new, nil
	end
end
local function rootOf(v29) -- proto[20], line 348
	if not (v29) then return nil end
	if not v29.FindFirstChild then return nil end
	if not (v29.FindFirstChild).IsA then return nil end
	local w3 = v29.FindFirstChild
	return w3
end
local function orbitOffset(v30, v31, v32, v33) -- proto[21], line 356
	local w6 = (v30.PlaneU * (math.cos(v31)))
	local r5 = math.sin(v31)
	if 0.001 >= v33 then return (CFrame.fromAxisAngle * w7) end
	local w7 = ((w6 + (v30.PlaneV * r5)) * v32)
	return (CFrame.fromAxisAngle * w7)
end
local function hideNewTools(v34, v35, v36) -- proto[23], line 364  -- upvalues: hideItem
	if not v36.IsA then return end
	if v36 == v35.Tool then return end
	if v35.Arrived then return end
	if v35.NewTools[v36] then return end
	if (not (v36)) then
	else
		for _k6, _v7 in ipairs(v36.GetDescendants) do
		end
	end
	v35.NewTools[v36] = v36.DescendantAdded.Connect
end
local function sweepTools(v38, v39) -- proto[24], line 378  -- upvalues: hideNewTools, hideItem
	if not v39.Character then return end
	if v39.Arrived then return end
	for _k6, _v7 in ipairs(v39.Character.GetChildren) do
	end
	local Tool = v39.Tool
	if not (Tool) then return end
	for _k7, _v8 in ipairs(Tool.GetDescendants) do
	end
end
local s2 = Light
local FindFirstChild
local function buildSide(self, v40, v41) -- proto[27], line 389  -- upvalues: Players, s2, hideItem, hideNewTools, Eggs, fallbackProp, detach, freeze, chargeHost, r1, EggEnergyOrbField, r2
	local f1
	local self = self
	local w3
	local w8
	local Character
	if Players.LocalPlayer then
		local Players_2 = Players.LocalPlayer
		Character = Players_2.Character
	else
		Character = nil
	end
	if v41 == nil then
	local Name = { Name = v40, Character = v41, Color = s2[v40], Arrived = false, NewTools = {}, Mine = f1 }
	local v_u3 = nil
	if v41 then
		if v41.FindFirstChildOfClass then
			Name.Tool = v41.FindFirstChildOfClass
			v_u3 = (v41.FindFirstChildOfClass).FindFirstChildOfClass
			Name.ToolWatch = (v41.FindFirstChildOfClass.DescendantAdded).Connect
		end
		local data = Name
		w3 = self.Pads[v40]
	end
	local fallbackProp_2 = nil
	local v_u4 = nil
	if v_u3 then
		v_u4 = v_u3.GetPivot
		fallbackProp_2 = v_u3.Clone
	else
		local v_u5 = w3.CFrame
		if Eggs.FindFirstChild then
			if (Eggs.FindFirstChild).IsA then
				w8 = (v_u5 * CFrame.new)
				v_u5 = Eggs.FindFirstChild
			end
			FindFirstChild = nil
		end
		if FindFirstChild then
			fallbackProp_2 = FindFirstChild.Clone
		else
			fallbackProp_2 = fallbackProp
		end
	end
	if ((self ^ "LocalPlayer") * (self ^ "LocalPlayer")) > K[461307] then
		fallbackProp_2.PrimaryPart = nil
		fallbackProp_2.WorldPivot = fallbackProp_2.GetBoundingBox
		if 0.01 < (math.max(fallbackProp_2.X, fallbackProp_2.Y, fallbackProp_2.Z)) then
			local w9 = (fallbackProp_2.GetScale * fallbackProp_2)
			local r4 = math.clamp(w9, 0.01, 50)
		end
	end
	fallbackProp_2.Parent = ((self ^ "LocalPlayer") * (self ^ "LocalPlayer")).Container
	Name.Prop = fallbackProp_2
	Name.Origin = w8.Position
	local Tool = Name.Tool
	if (not (Tool)) then
	else
		for _k13, _v14 in ipairs(Tool.GetDescendants) do
		end
	end
	chargeHost.CFrame = CFrame.new
	chargeHost.Parent = ((self ^ "LocalPlayer") * (self ^ "LocalPlayer"))[1].Container
	Name.Host = chargeHost
	Name.HostEnable = Name.Color
	Name.HostEmit = Tool
	-- FORGPREP R0 iter=((self ^ "LocalPlayer") * (self ^ "LocalPlayer"))[1] -> pc260
	Instance.new.Position = Vector3.new(0, 3.0999999046325684, 0)
	Instance.new.Parent = chargeHost
	Instance.new.Position = Vector3.new(0, -3.0999999046325684, 0)
	Instance.new.Parent = chargeHost
	Instance.new.Attachment0 = Instance.new
	Instance.new.Attachment1 = Instance.new
	Instance.new.Transparency = NumberSequence.new
	Instance.new.WidthScale = NumberSequence.new
	Instance.new.Lifetime = 0.35
	Instance.new.LightEmission = 1
	Instance.new.LightInfluence = 0
	Instance.new.FaceCamera = true
	Instance.new.MinLength = 0
	Instance.new.Parent = chargeHost
	_v4.Trail = Instance.new
	Instance.new.Attachment0 = Name.Color
	Instance.new.Attachment1 = (#((self ^ "LocalPlayer") * (self ^ "LocalPlayer"))[1]).CoreAttachment
	Instance.new.Color = ColorSequence.new
	Instance.new.Transparency = NumberSequence.new
	Instance.new.Width0 = 0.05
	Instance.new.Width1 = 0.25
	Instance.new.LightEmission = 1
	Instance.new.LightInfluence = 0
	Instance.new.FaceCamera = true
	Instance.new.Segments = 12
	Instance.new.Parent = chargeHost
	_v4.Beam = Instance.new
	_v4.BeamSign = -1
	_v4.Field = EggEnergyOrbField.new
	_v4.Theta = 3.141592653589793
	_v4.Roll = r2.NextNumber
	_v4.BobPhase = 2.199114857512855
	return _v4
end
local function revealSide(v44) -- proto[28], line 488  -- upvalues: showItem
	v44.Arrived = true
	local Tool = v44.Tool
	if (not (Tool)) then
	else
		for _k5, _v6 in ipairs(Tool.GetDescendants) do
		end
	end
	for _k4, _v5 in ipairs(v44.NewTools) do
		if (not (_k4)) then
		else
			for _k9, _v10 in ipairs(_k4.GetDescendants) do
			end
		end
	end
end
local function finish(v45) -- proto[29], line 501  -- upvalues: U0, revealSide
	local U0
	if U0 ~= v45 then return end
	U0 = nil
	v45.Dead = true
end
r1 = r2
local function propPivot(v46, v47, v48, v49) -- proto[30], line 512  -- upvalues: r1
	local r2 = Vector3.new(v46.Center.X, v48.Y, v46.Center.Z)
	if 0.001 >= v49 then return (((CFrame.lookAt * CFrame.Angles) * CFrame.new) * CFrame.Angles) end
	local r6 = math.rad(((r1.NextNumber * 22) * v49))
	local r7 = math.rad(((r1.NextNumber * 22) * v49))
	return (((CFrame.lookAt * CFrame.Angles) * CFrame.new) * CFrame.Angles)
end
local function pushImpulse(v50, v51) -- proto[31], line 531  -- upvalues: r1
	local At
	if not (v50.Impulses) then return end
	if not (v50.Impulses[(v50.ImpulseSlot or 1)]) then
		At = {}
		v50.Impulses[(v50.ImpulseSlot or 1)] = At
	end
	At.At = os.clock
	At.Life = (0.34 * r1.NextNumber)
	At.Power = v51
	At.Dir = (Vector3.new(r1.NextNumber, r1.NextNumber, r1:NextNumber(-0.4, 0.4)))
	local w10 = (v50.ImpulseSlot or 1)
	At.Spin = (Vector3.new(r1.NextNumber, r1.NextNumber, r1:NextNumber(-1, 1)))
	(v50 ^ "Impulses").ImpulseSlot = ((w10 % 8) + 1)
end
r2 = r1
local self
local w7
local function stepSession(v52, v53) -- proto[34], line 550  -- upvalues: Workspace, s1, TweenService, pushImpulse, r1, Shake, propPivot, s2, r2
	local Center
	if v52.Dead or v52.Resolving then
		v52.CamPunch = (math.max(((v52.CamPunch or 0) - (v53 * 3)), 0))
		v52.CamRumble = (math.max(((v52.CamRumble or 0) - (v53 * 2)), 0))
		return
	end
	if not (v52.Shrine.IsDescendantOf) then
		return
	end
	if (v52.EndsAt + 6) < Workspace.GetServerTimeNow then
		return
	end
	local v_u3 = (v52 ^ "Dead").EndsAt
	local w11 = (v_u3 - (v52 ^ "Dead").StartAt)
	local r4 = math.clamp(((Workspace.GetServerTimeNow - (v52 ^ "Dead").StartAt) / (math.max(w11, 0.5))), 0, 1)
	local r8 = math.clamp(((Workspace.GetServerTimeNow - (v52 ^ "Dead").StartAt) / (v52 ^ "Dead").LiftSeconds), 0, 1)
	local w12 = (((Workspace.GetServerTimeNow - (v52 ^ "Dead").StartAt) - (v52 ^ "Dead").LiftSeconds) / (math.max(((((v52 ^ "Dead").EndsAt - (v52 ^ "Dead").ShakeLead) - (v52 ^ "Dead").StartAt) - (v52 ^ "Dead").LiftSeconds), 0.1)))
	local r9 = math.clamp(w12, 0, 1)
	local r10 = math.clamp(((Workspace.GetServerTimeNow - ((v52 ^ "Dead").EndsAt - (v52 ^ "Dead").ShakeLead)) / (v52 ^ "Dead").ShakeLead), 0, 1)
	(v52 ^ "Dead").ShakeIntensity = TweenService.GetValue
	(v52 ^ "Dead").CamRumble = (r8 * ((TweenService.GetValue * 0.42000000000000004) + 0.04))
	if 0.02 < TweenService.GetValue then
		if ((v52 ^ "Dead").NextImpulse or 0) <= os.clock then
			(v52 ^ "Dead").NextImpulse = (os.clock + (((TweenService.GetValue * -0.265) + 0.34) * r1.NextNumber))
		else
			(v52 ^ "Dead").NextImpulse = os.clock
		end
	end
	((v52 ^ "Dead") * (v52 ^ "Dead")).Theta = (((v52 ^ "Dead") * (v52 ^ "Dead")).Theta + (((TweenService.GetValue * 6.8) + 1.7) * v53))
	if 0 < r10 then
		local r11 = math.min((r10 / 0.35), 1)
	end
	local r12 = math.max(r9, r10)
	if 0.12 < r10 and not (((v52 ^ "Dead") * (v52 ^ "Dead")).Absorbing) then
		((v52 ^ "Dead") * (v52 ^ "Dead")).Absorbing = true
		if not (((v52 ^ "Dead") * (v52 ^ "Dead")).Participant) then
			Center = { Center = nil, Near = 24, Far = 90 }
			Center.Center = ((v52 ^ "Dead") * (v52 ^ "Dead")).Center
			local Seconds = { Seconds = (((v52 ^ "Dead") * (v52 ^ "Dead")).ShakeLead + 0.8), Magnitude = 0.8, Range = Center }
		end
		_r16[1], _r16[2] = "Light", "Dark"
		for _k19, _v20 in {} do
			local v1_e = ((v52 ^ "Dead") * (v52 ^ "Dead")).Sides[_v20].Field
			v52 = ((v52 ^ "Dead") * (v52 ^ "Dead"))
			if ((v52 ^ "Dead") * (v52 ^ "Dead")) > K[2146635886] then continue end
		end
		local _r16 = {"Light", "Dark"}
		-- FORGPREP_INEXT R16 iter=ipairs(_r16) -> pc515
		local w13 = ((math.sin(((os.clock * 2.6) + ((v52 ^ "Dead") * (v52 ^ "Dead")).Sides[_v20].BobPhase))) * 0.55)
		local w14 = (w13 * (1 - (r9 * 0.6)))
		local w6 = (((v52 ^ "Dead") * (v52 ^ "Dead")).PlaneU * (math.cos((((v52 ^ "Dead") * (v52 ^ "Dead")).Theta + 3.141592653589793))))
		local r13 = math.sin((((v52 ^ "Dead") * (v52 ^ "Dead")).Theta + 3.141592653589793))
		if 0.001 < (TweenService.GetValue * 0.24434609527920614) then
			w7 = ((w6 + (((v52 ^ "Dead") * (v52 ^ "Dead")).PlaneV * r13)) * (((TweenService.GetValue * -3.3) + 5.6) + ((1.2 - ((TweenService.GetValue * -3.3) + 5.6)) * TweenService.GetValue)))
		end
		local r14 = Vector3.new(0, (w14 * (1 - r10)), 0)
		local v_u6 = nil
		local w15 = ((((v52 ^ "Dead") * (v52 ^ "Dead")).Center + (CFrame.fromAxisAngle * w7)) + r14)
		if not ((r8 < 1)) then
			v_u6 = w15
		end
		((v52 ^ "Dead") * (v52 ^ "Dead")).Sides[_v20].Roll = (((v52 ^ "Dead") * (v52 ^ "Dead")).Sides[_v20].Roll + (((TweenService.GetValue * 5.4) + 1.1) * v53))
		((v52 ^ "Dead") * (v52 ^ "Dead")).Sides[_v20].Host.CFrame = CFrame.new
		((v52 ^ "Dead") * (v52 ^ "Dead")).Sides[_v20].Beam.Width0 = ((r4 * 0.3) + 0.05)
		((v52 ^ "Dead") * (v52 ^ "Dead")).Sides[_v20].Beam.Width1 = ((r4 * 0.6000000000000001) + 0.2)
		local w16 = ((math.sin(((os.clock * 1.9) + ((v52 ^ "Dead") * (v52 ^ "Dead")).Sides[_v20].BobPhase))) * 3)
		((v52 ^ "Dead") * (v52 ^ "Dead")).Sides[_v20].Beam.CurveSize0 = (w16 * ((v52 ^ "Dead") * (v52 ^ "Dead")).Sides[_v20].BeamSign)
		local r15 = math.cos(((os.clock * 1.6) + ((v52 ^ "Dead") * (v52 ^ "Dead")).Sides[_v20].BobPhase))
		local w17 = (r15 * 3)
		((v52 ^ "Dead") * (v52 ^ "Dead")).Sides[_v20].Beam.CurveSize1 = (w17 * (-((v52 ^ "Dead") * (v52 ^ "Dead")).Sides[_v20].BeamSign))
		if ((v52 ^ "Dead") * (v52 ^ "Dead")).Absorbing then continue end
	end
	local r16 = math.sin((os.clock * ((r4 * 10) + 6)))
	local w18 = ((r16 * 0.07) + 1)
	((v52 ^ "Dead") * (v52 ^ "Dead"))[1].Core.Size = (Vector3.new(1, 1, 1) * ((((TweenService.GetValue * 0.95) + 0.55) * w18) + (TweenService.GetValue * 0.4)))
	((v52 ^ "Dead") * (v52 ^ "Dead"))[1].Core.CFrame = CFrame.new
	local w19 = (((math.sin(os.clock * 3)) * 0.5) + 0.5)
	-- FORGPREP R0 iter=((v52 ^ "Dead") * (v52 ^ "Dead"))[1] -> pc584
	((v52 ^ "Dead") * (v52 ^ "Dead"))[1].Core.Color = (s2.Light.Lerp).Lerp
end
local RiftTradeIn = ReplicatedStorage.Assets.VFX.RiftTradeIn
local s3 = Light_2
local v_u7
local r1
local function flight(v54, v55) -- proto[35], line 656  -- upvalues: revealSide, RunService, RiftTradeIn, freeze, s3, tintEmitters, VFX
	local v_u10, v_u11, v_u12, v_u13, v_u14, v_u15, v_u16, v_u17
	local r11
	local v_u8
	local v_u9
	local Prop = v55.Prop
	if not Prop or (not (Prop.Parent)) then
		return
	end
	v55.Trail.Enabled = true
	local w20 = Prop.GetPivot.Position
	local w21 = Prop.GetScale
	while true do
		if 0 < 1.15 then
			if not (v54.Dead) then
				if Prop.Parent then
					r11 = math.min(((0 + RunService.RenderStepped.Wait) / 1.15), 1)
					v_u8 = v55.Character
					if not (v_u8) then
						v_u7 = nil
					else
						v_u10 = v_u10 ^ "Prop"
						if v_u8.FindFirstChild then
							if (v_u8.FindFirstChild).IsA then
								v_u7 = v_u8.FindFirstChild
							end
							FindFirstChild = nil
						end
					end
					if not (FindFirstChild) then
						v_u8 = w20
					end
					v_u11 = (w20 + v_u8) * 0.5
					local r3 = math.max(w20.Y, v_u8.Y)
					v_u12 = ((w20 - v_u8) * Vector3.new(1, 0, 1)).Magnitude * 0.5
					r1 = Vector3.new(v_u11.X, ((r3 + v_u12) + 2.5), v_u11.Z)
					v55.Host.CFrame = CFrame.new
					v55.FlightAt = (((w20 * ((1 - (r11 * r11)) * (1 - (r11 * r11)))) + (r1 * (((1 - (r11 * r11)) * 2) * (r11 * r11)))) + (v_u8 * ((r11 * r11) * (r11 * r11))))
					v_u13 = r11 / 0.22
					v_u13 = (math.min(v_u13, 1)) - 1
					v_u14 = v_u13 * 2.70158
					v_u15 = ((v_u14 * v_u13) * v_u13) + 1
					v_u16 = v_u13 * 1.70158
					local w22 = (v_u15 + (v_u16 * v_u13))
					v_u17 = r11 - 0.55
					v_u15 = v_u17 / 0.45
					local r4 = math.clamp(v_u15, 0, 1)
					local r17 = math.max(((w21 + ((v55.EggScale - w21) * w22)) * (1 - ((r4 * r4) * r4))), 0.01)
				end
			end
		end
	end
	v55.Trail.Enabled = false
	v55.FlightAt = nil
	if (v_u10 * v_u10).Dead then return end
	local v_u4 = v55.Character
	if not (v_u4) then
		v_u9 = nil
	else
		local w23 = ((w20 - v_u8) * Vector3.new(1, 0, 1)).Magnitude
		if (v_u10 * v_u10) <= K[526606] then break end
		if ((v_u4.FindFirstChild).IsA) then
			v_u9 = v_u4.FindFirstChild
		else
			FindFirstChild = nil
		end
	end
	if not (FindFirstChild) then
		v_u4 = w20
	end
	if RiftTradeIn.FindFirstChild then
		((RiftTradeIn.FindFirstChild).Clone):PivotTo(CFrame.new(v_u4))
		if not (s3[v55.Name]) then
			v_u8 = s3.Light
		end
		(RiftTradeIn.FindFirstChild).Clone.Parent = (v_u10 * v_u10)[1].Container.Parent
		for _k15, _v16 in ipairs(((RiftTradeIn.FindFirstChild).Clone).GetDescendants) do
			if not _v16.IsA then continue end
			_v16.LocalTransparencyModifier = 1
		end
		-- FORGPREP R0 iter=(v_u10 * v_u10)[1] -> pc334
	end
	if not Prop.Parent then return end
end
local v_u10
local v_u17
local v_u15
local function resolvePayoff(v56, v57) -- proto[37], line 722  -- upvalues: sweepTools, Flash, pushImpulse, Shake, r1, TweenService, VFX, Particles, Eggs, fallbackProp, freeze, RunService, quadInOut, propPivot, flight, U15, revealSide
	local U15, v_u13, v_u16, v_u21, v_u22, v_u23, v_u24
	local w24
	local v_u6
	local Center
	local w25
	local r13
	local w26
	local w27
	local w28
	local v_u18
	local v_u19
	local r18
	local Size
	local w6
	local r5
	local _r2 = {}
	_r3[1], _r3[2] = "Light", "Dark"
	for _k6, _v7 in {} do
		local v_u5 = v56.Sides
		if (v_u5[_v7].Pivot) then
			local w8 = v_u5[_v7]
			v_u5 = w8.Pivot
		else
			w6 = (v56.PlaneU * (math.cos(3.141592653589793)))
			r5 = math.sin(3.141592653589793)
		end
		_r2[_v7] = CFrame.new
	end
	if v56.Participant then
		local Attack = { Attack = 0.06, Decay = 0.22 }
	end
	v56.CamPunch = 1
	local w29 = (v56 ^ "Sides")
	if not ((w29 * w29).Participant) then
		Center = { Center = nil, Near = 24, Far = 90 }
		w25 = (w29 * w29)
		Center.Center = w25.Center
		local Seconds = { Seconds = 0.7, Magnitude = 1, Range = Center }
	end
	Instance.new.Shape = Enum.PartType.Ball
	Instance.new.Material = Enum.Material.Neon
	Instance.new.Color = r1
	Instance.new.Size = Vector3.new(2, 2, 2)
	Instance.new.Transparency = 0.45
	Instance.new.Anchored = true
	Instance.new.CanCollide = false
	Instance.new.CanQuery = false
	Instance.new.CanTouch = false
	Instance.new.CFrame = CFrame.new
	Instance.new.Parent = w25.Container.Parent
	if w25 > K[5376226] then
		VFX.Discard.Shape = Enum.PartType.Cylinder
		VFX.Discard.Material = Enum.Material.Neon
		VFX.Discard.Color = r1
		VFX.Discard.Size = Vector3.new(36, 4.199999809265137, 4.199999809265137)
		VFX.Discard.Transparency = 0.3
		VFX.Discard.Anchored = true
		VFX.Discard.CanCollide = false
		VFX.Discard.CanQuery = false
		VFX.Discard.CanTouch = false
		VFX.Discard.CastShadow = false
		VFX.Discard.CFrame = (CFrame.new * CFrame.Angles)
		VFX.Discard.Parent = w25[1].Container.Parent
		Size = { Size = Vector3.new(36, 0.30000001192092896, 0.30000001192092896), Transparency = 1 }
		-- FORGPREP R0 iter=w25[1] -> pc302
		if Particles.FindFirstChild then
			Instance.new.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
			Instance.new.Transparency = 1
			Instance.new.Anchored = true
			Instance.new.CanCollide = false
			Instance.new.CanQuery = false
			Instance.new.CanTouch = false
			Instance.new.Parent = (w25[1] ^ "Sides").Container.Parent
			(Particles.FindFirstChild).Clone.Parent = Instance.new
		end
	end
	local Size_2 = { Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806), Transparency = 1 }
	if Eggs.FindFirstChild then
		if (Eggs.FindFirstChild).IsA then
			FindFirstChild = Eggs.FindFirstChild
		end
		FindFirstChild = nil
	end
	_r7[1], _r7[2] = "Light", "Dark"
	for _k10, _v11 in {} do
		if not (FindFirstChild) then
			v_u10 = (((#(w25[1] ^ "Sides")) % "Sides") - ((#(w25[1] ^ "Sides")) % "Sides"))
		end
		fallbackProp.PrimaryPart = nil
		fallbackProp.WorldPivot = fallbackProp.GetBoundingBox
		local r3 = math.max(fallbackProp.X, fallbackProp.Y, fallbackProp.Z)
		if 0.01 >= r3 then continue end
		local w30 = fallbackProp.GetScale
		local w31 = (w30 * (3.6 / r3))
		v_u17 = 50
		local r4 = math.clamp(w31, 0.01, v_u17)
		if v_u10 == true then continue end
		fallbackProp.Parent = v_u10.Container
		((#(w25[1] ^ "Sides")) % "Sides").Sides[_v11].Prop = fallbackProp
		((#(w25[1] ^ "Sides")) % "Sides").Sides[_v11].EggScale = fallbackProp.GetScale
		local v_u20 = ((#(w25[1] ^ "Sides")) % "Sides").Sides[_v11].EggScale
		local w32 = (v_u20 * 0.12)
		local r17 = math.max(w32, 0.01)
		for _k17, _v18 in ipairs((((#(w25[1] ^ "Sides")) % "Sides").Sides[_v11].Host).GetDescendants) do
			v_u15 = "ParticleEmitter"
			v_u10["K[201486]"] = v_u10
			_v18.Enabled = false
		end
		((#(w25[1] ^ "Sides")) % "Sides").Sides[_v11].Beam.Enabled = false
		((#(w25[1] ^ "Sides")) % "Sides").Sides[_v11].Trail.Enabled = true
		((#(w25[1] ^ "Sides")) % "Sides").Sides[_v11].RollStart = ((#(w25[1] ^ "Sides")) % "Sides").Sides[_v11].Roll
	end
	local w33 = ((math.ceil(((v_u10.Theta + 7.853981633974483) / 6.283185307179586))) * 6.283185307179586)
	local _r9 = {}
	_r10[1], _r10[2] = "Light", "Dark"
	for _k13, _v14 in {} do
		v_u21 = v_u10.Sides[_v14].Roll / 6.283185307179586
		_r9[_v14] = ((math.ceil(v_u21)) * 6.283185307179586)
	end
	while true do
		if 0 >= 1.8 then break end
		if v_u10.Dead then break end
		local r11 = math.min(((0 + RunService.RenderStepped.Wait) / 1.8), 1)
		v_u10.Theta = (v_u10.Theta + ((w33 - v_u10.Theta) * TweenService.GetValue))
		v_u21 = TweenService.GetValue * 1.4000000000000001
		v_u22 = v_u21 + 1.2
		local r2 = v_u10.Center:Lerp((v_u10.Center - Vector3.new(0, 1.399999976158142, 0)), quadInOut(r11))
		v_u15 = r11 / 0.3
		local w22 = (1 - v_u15)
		local r8 = math.clamp(w22, 0, 1)
		v_u13 = r8 * 0.7
		v_u10.ShakeIntensity = v_u13
		v_u13 = r8 * 0.46
		v_u10.CamRumble = v_u13
		v_u17 = r11 / 0.4
		v_u17 = (math.min(v_u17, 1)) - 1
		v_u23 = v_u17 * 2.70158
		v_u16 = ((v_u23 * v_u17) * v_u17) + 1
		v_u6 = v_u17 * 1.70158
		w24 = (v_u16 + (v_u6 * v_u17))
		v_u6 = "Dark"
		_r21[1], _r21[2] = "Light", v_u6
		for _k24, _v25 in {} do
			local w17 = (v_u10.PlaneU * (math.cos(v_u10.Theta + 3.141592653589793)))
			r13 = math.sin(v_u10.Theta + 3.141592653589793)
			if 0.001 < (0.24434609527920614 * (1 - TweenService.GetValue)) then
				w26 = ((w17 + (v_u10.PlaneV * r13)) * v_u22)
			end
			v_u10.Sides[_v25].Roll = (v_u10.Sides[_v25].RollStart + ((_r9[_v25] - v_u10.Sides[_v25].RollStart) * TweenService.GetValue))
			v_u18 = r8 * 0.5
			v_u10.Sides[_v25].Pivot = propPivot
			w27 = (v_u10.Center - Vector3.new(0, 1.399999976158142, 0))
			w28 = v_u10.Sides[_v25]
			if w28.Prop.Parent then
				r13 = w28.EggScale
				v_u24 = (w24 * 0.88) + 0.12
				v_u18 = (r13 * v_u24)
				v_u19 = 0.01
				local r19 = math.max(v_u18, v_u19)
			end
			w28.Host.CFrame = CFrame.new
		end
	end
	v_u10.ShakeIntensity = 0
	v_u10.CamRumble = 0
	local _r12 = {}
	_r13[1], _r13[2] = "Light", "Dark"
	for _k16, _v17 in {} do
		_r12[_v17] = (w27 + (v_u10.PlaneU * (-1 * 2.6)))
	end
	while true do
		if 0 >= 1.9 then break end
		if (-v_u10).Dead then break end
		local r9 = math.clamp((((0 + RunService.RenderStepped.Wait) - 1.5) / 0.4), 0, 1)
		_r17[1], _r17[2] = "Light", "Dark"
		for _k20, _v21 in {} do
			local w16 = ((math.sin(((os.clock * 2.3) + (-v_u10).Sides[_v21].BobPhase))) * 0.24)
			local r14 = Vector3.new(0, ((w16 * (1 - TweenService.GetValue)) - (TweenService.GetValue * 0.45)), 0)
			local w15 = (_r12[_v21] + r14)
			v_u6 = (1 - TweenService.GetValue) * 0.12217304763960307
			local r20 = Vector3.new((-v_u10).Center.X, w15.Y, (-v_u10).Center.Z)
			local w18 = ((math.sin(((os.clock * 1.7) + (-v_u10).Sides[_v21].BobPhase))) * v_u6)
			r18 = math.cos(((os.clock * 1.3) + (-v_u10).Sides[_v21].BobPhase))
			(-v_u10).Sides[_v21].Pivot = (CFrame.lookAt * CFrame.Angles)
			if (-v_u10).Sides[_v21].Prop.Parent then
				v_u10 = v_u10 / "Sides"
				r18 = (-v_u10).Sides[_v21].EggScale
				v_u19 = TweenService.GetValue * -0.14
				v_u18 = v_u19 + 1
				local w34 = (r18 * v_u18)
				local r21 = math.max(w34, 0.01)
			end
			(-v_u10).Sides[_v21].Host.CFrame = CFrame.new
		end
	end
	v_u10.FlightStartAt = os.clock
	_r13[1], _r13[2] = "Light", "Dark"
	for _k16, _v17 in {} do
		local v2_e = v_u10.Sides[_v17]
		local v2_e_2 = v_u10
	end
	local v_u25 = 0
	while true do
		if v_u25 >= 2.8 then break end
		v_u25 = v_u25 + 0.05
		if not (v_u10 + v_u10).Sides.Light.Arrived then continue end
		if (v_u10 + v_u10).Sides.Dark.Arrived then break end
	end
	if not ((U15 ~= (v_u10 + v_u10))) then
		U15 = nil
		(v_u10 + v_u10).Dead = true
	end
	if v57 then
		if (v_u10 + v_u10) == nil then return end
	end
end
function s1.IsPlaying() -- proto[38], line 923  -- upvalues: U0
	local f2 = not (U0 == nil)
	return f2
end
function s1.ActiveShrine() -- proto[39], line 927  -- upvalues: s2
	if not s2 then return nil end
	return s2.Shrine
end
function s1.IsResolving() -- proto[40], line 931  -- upvalues: s2
	local f2
	if s2 == nil then return f2 end
	f2 = not (s2.Resolving ~= true)
	return f2
end
function s1.FlightFocus() -- proto[41], line 935  -- upvalues: s2
	if not s2 then return nil end
	if not (s2.FlightStartAt) then return nil end
	if (os.clock - s2.FlightStartAt) < 0.15 then return s2.Sides.Light.FlightAt end
	if (os.clock - s2.FlightStartAt) >= 0.3 then return nil end
	local v_u26 = s2.Sides.Dark.FlightAt
	if v_u26 then return v_u26 end
	v_u26 = s2.Sides.Light.FlightAt
	return v_u26
end
function s1.Begin(v58) -- proto[44], line 950  -- upvalues: Workspace, s2, Trove, r1, buildSide, revealSide, RunService, stepSession, fuseTrack
	local f1
	if (typeof(v58.Shrine)) ~= "Instance" then return false end
	if not (v58.Shrine.IsDescendantOf) then return false end
	if not v58.Shrine.FindFirstChild then return false end
	if not (v58.Shrine.FindFirstChild).IsA then return false end
	if not v58.Shrine.FindFirstChild then return false end
	local w3 = v58.Shrine
	local w10 = v58.Shrine.FindFirstChild
	local w4 = v58.Shrine.FindFirstChild
	local w1 = (v58.Shrine.FindFirstChild).IsA
	if not (w1) then return false end
	if s2 then
		s2 = nil
		s2.Dead = true
	end
	f1 = not ((v58 ^ "Shrine").Participant ~= true)
	local Light = { Light = w10, Dark = w4 }
	local Trove_2 = { Trove = Trove.new, Shrine = w3, Tier = (v58 ^ "Shrine").Tier, FusedCategory = (v58 ^ "Shrine").FusedCategory, Participant = f1, TrackCharacter = (v58 ^ "Shrine").TrackCharacter, StartAt = Workspace.GetServerTimeNow, EndsAt = (v58 ^ "Shrine").EndsAt, Pads = Light, Sides = {}, Theta = 0, ShakeIntensity = 0, CamPunch = 0, CamRumble = 0, Impulses = table.create, ImpulseSlot = 1, NextImpulse = 0, Dead = false, Resolving = false, Absorbing = false }
	local v_u9 = Trove_2.EndsAt
	local w35 = (v_u9 - Trove_2.StartAt)
	local r3 = math.max(w35, 1)
	Trove_2.LiftSeconds = (math.clamp((r3 * 0.16), 0.35, 1.1))
	Trove_2.ShakeLead = (math.clamp((r3 * 0.24), 0.5, 1.3))
	Trove_2.PlaneU = Vector3.new(1, 0, 0)
	Trove_2.PlaneV = Trove_2.PlaneU.Cross
	Trove_2.Center = (((w10.Position + w4.Position) * 0.5) + Vector3.new(0, 5.5, 0))
	Trove_2.GroundY = (math.max((w10.Position.Y + (w10.Size.Y * 0.5)), (w4.Position.Y + (w4.Size.Y * 0.5))))
	Instance.new.Name = "ShrineFusionSequence"
	local Parent = ((v58 ^ "Shrine") * (v58 ^ "Shrine")).Parent
	Instance.new.Parent = Workspace
	Trove_2.Container = Instance.new
	if ((v58 ^ "Shrine") * (v58 ^ "Shrine")) > K[5376420] then
		-- FORGPREP_NEXT R64 -> pc-14873
		Instance.new.Shape = "Part"
		Instance.new.Material = Enum.Material.Neon
		Instance.new.Color = r1
		Instance.new.Size = Vector3.new(0.550000011920929, 0.550000011920929, 0.550000011920929)
		Instance.new.Transparency = 0.3
		Instance.new.Anchored = true
		Instance.new.CanCollide = false
		Instance.new.CanQuery = false
		Instance.new.CanTouch = false
		Instance.new.CastShadow = false
		Instance.new.CFrame = CFrame.new
		Instance.new.Parent = Instance.new
		Trove_2.Core = Instance.new
		Instance.new.Parent = Instance.new
		Trove_2.CoreAttachment = Instance.new
		local w36 = Trove_2.Sides
		w36.Dark = buildSide
		local s2 = Trove_2
		return true
	end
end
function s1.Payoff(v60) -- proto[46], line 1038  -- upvalues: s2, resolvePayoff, revealSide
	if not s2 then return false end
	if s2.Resolving then return false end
	if s2.Dead then return false end
	s2.Resolving = true
	local s1 = s2
	return true
end
function s1.Cancel() -- proto[48], line 1057  -- upvalues: s2, RunService, TweenService, revealSide
	if not s2 then return end
	if s2.Resolving then return end
	s2.Dead = true
	local s1 = s2
end
pcall(function()

end)
pcall(function()
	local f3
	local r7

end)
return table.freeze(s1)