-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.ModelCameraOcclusion
-- ============================================

-- bytecode
-- Original size: 8770 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 111, Protos: 15, Main proto: 14

-- ============== SOURCE ==============
-- main chunk (proto[14], line 1)
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local Log = require(ReplicatedStorage.Packages.Log)
local Player = require(ReplicatedStorage.Shared.Player)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local blocked = { blocked = {}, faceOwner = {}, probeFrom = {}, probeSkip = {}, roster = {}, shelved = {}, sweep = nil, sweeping = false }
local _r12 = Log.new()
local r1 = t.strict(t.instanceIsA("Model"))
local r2 = t.strict(t.number)
local r3 = t.strict(t.boolean)
local Register = {}
local s1 = blocked
local function repaint(v1, v2) -- proto[0], line 58  -- upvalues: s1
	if v2 == nil then
		if s1.shelved[v1] == nil then return end
		s1.shelved[v1] = nil
		if not v1.Parent then return end
		v1.Transparency = s1.shelved[v1]
		return
	end
	if v1.Transparency >= 1 then return end
	local v_u1 = s1.shelved[v1]
	if v_u1 == nil then
		if v1.Transparency < v2 then
			v_u1 = v1.Transparency
			s1.shelved[v1] = v1.Transparency
		end
	end
	if v_u1 == nil then return end
	v1.Transparency = (math.max(v_u1, v2))
end
local function repaintEntry(v3, v4) -- proto[1], line 83  -- upvalues: s1
	local Target
	v3.Faded = v4
	if v4 then
		Target = v3.Target
	else
		Target = nil
	end
	for _v6 in ipairs(v3.Faces) do
		if Target == nil then
			if s1.shelved[_k6] == nil then continue end
			s1.shelved[_k6] = nil
			if not _k6.Parent then continue end
			_k6.Transparency = s1.shelved[_k6]
			continue
		end
		if _k6.Transparency >= 1 then continue end
		local v_u2 = s1.shelved[_k6]
		if v_u2 == nil then
			if _k6.Transparency < Target then
				v_u2 = _k6.Transparency
				s1.shelved[_k6] = _k6.Transparency
			end
		end
		if v_u2 == nil then continue end
		_k6.Transparency = (math.max(v_u2, Target))
	end
end
local function releaseEverything() -- proto[2], line 92  -- upvalues: s1
	for _k3, _v4 in ipairs(s1.roster) do
		_v4.UnfadeAt = 0
		_v4.Faded = false
		for _v8 in ipairs(_v4.Faces) do
			if s1.shelved[_k8] == nil then continue end
			s1.shelved[_k8] = nil
			if not _k8.Parent then continue end
			_k8.Transparency = s1.shelved[_k8]
		end
	end
end
local function demand(v5) -- proto[3], line 101  -- upvalues: s1
	return assert(s1.roster[v5], (("%* is not registered for occlusion"):format(v5.Name)))
end
local function isUnderfoot(v6, v7, v8) -- proto[4], line 107
	local w1 = v6.GetScale
	local w2 = (w1 / v7.RegisteredScale)
	local r4 = Vector3.new((math.clamp(((v7.Pivot.CFrame * (CFrame.new * v7.Bounds.Rotation))).PointToObjectSpace.X, (-((v7.Extents * w2) * 0.5).X), ((v7.Extents * w2) * 0.5).X)), (-((v7.Extents * w2) * 0.5).Y), (math.clamp(((v7.Pivot.CFrame * (CFrame.new * v7.Bounds.Rotation))).PointToObjectSpace.Z, (-((v7.Extents * w2) * 0.5).Z), ((v7.Extents * w2) * 0.5).Z)))
	local f1 = false  -- skip 1
	f1 = true
	return f1
end
local function advance(v9, v10, v11) -- proto[5], line 121  -- upvalues: repaintEntry, s1
	if v10 then
		v9.UnfadeAt = 0
		return repaintEntry(v9, true)
	end
	if not (v9.Faded) then
		v9.UnfadeAt = 0
		return
	end
	if v9.UnfadeAt <= 0 then
		v9.UnfadeAt = (v11 + 1)
		return
	end
	if v9.UnfadeAt > v11 then return end
	v9.UnfadeAt = 0
	v9.Faded = false
	local w1 = v9.Faces
	for _v6 in ipairs(w1) do
		if s1.shelved[_k6] == nil then continue end
		s1.shelved[_k6] = nil
		if not _k6.Parent then continue end
		_k6.Transparency = s1.shelved[_k6]
	end
end
local function onFrame() -- proto[6], line 137  -- upvalues: Workspace, Player, LocalPlayer, s1, releaseEverything, isUnderfoot
	if not s1.sweeping then return releaseEverything() end
	if not Workspace.CurrentCamera then return releaseEverything() end
	if not Player.FindCharacter then return releaseEverything() end
	if not Player.FindHead then return releaseEverything() end
	if not (Player.FindRootPart) then return releaseEverything() end
	for _k9, _v10 in ipairs(Workspace.CurrentCamera.GetPartsObscuringTarget) do
		local v1_e = s1.faceOwner[_v10]
		if not v1_e then continue end
		s1.blocked[v1_e] = true
	end
	for _k11, _v12 in ipairs(s1.roster) do
		if _v12.Muted then continue end
		if isUnderfoot then
			_v12.UnfadeAt = 0
			_v12.Faded = true
			for _v19 in ipairs(_v12.Faces) do
				if _v12.Target == nil then
					if s1.shelved[_k19] == nil then continue end
					s1.shelved[_k19] = nil
					if not _k19.Parent then continue end
					_k19.Transparency = s1.shelved[_k19]
					continue
				end
				if _k19.Transparency >= 1 then continue end
				local v_u3 = s1.shelved[_k19]
				if v_u3 == nil and _k19.Transparency < _v12.Target then
					v_u3 = _k19.Transparency
					s1.shelved[_k19] = _k19.Transparency
				end
				if v_u3 == nil then continue end
				_k19.Transparency = (math.max(v_u3, _v12.Target))
			end
			continue
		end
		if not (_v12.Faded) then
			_v12.UnfadeAt = 0
			continue
		end
		if _v12.UnfadeAt <= 0 then
			_v12.UnfadeAt = (Workspace.GetServerTimeNow + 1)
			continue
		end
		if _v12.UnfadeAt > Workspace.GetServerTimeNow then continue end
		_v12.UnfadeAt = 0
		_v12.Faded = false
		for _v17 in ipairs(_v12.Faces) do
			if s1.shelved[_k17] == nil then continue end
			s1.shelved[_k17] = nil
			if not _k17.Parent then continue end
			_k17.Transparency = s1.shelved[_k17]
		end
	end
end
ReplicatedStorage = r1
local number = r2
function Register.Register(self, v12) -- proto[9], line 165  -- upvalues: ReplicatedStorage, number, s1, ModelBounds, Trove
	local f2
	local f3
	if 0 <= v12 then
		f2 = false  -- skip 1
		f2 = true
	end
	assert(f2, "an occlusion fade target has to land between 0 and 1")
	f2 = not (s1.roster[(self ^ "an occlusion fade target has to land between 0 and 1")] ~= nil)
	assert(f2, (("%* is being registered for occlusion twice"):format((self ^ "an occlusion fade target has to land between 0 and 1").Name)))
	local _r2 = assert((self ^ "an occlusion fade target has to land between 0 and 1").PrimaryPart, (("%* has no PrimaryPart to measure against"):format((self ^ "an occlusion fade target has to land between 0 and 1").Name)))
	f3 = not (0 >= (self ^ "an occlusion fade target has to land between 0 and 1").GetScale)
	assert(f3, (("%* reports a scale of %*, which cannot be normalised"):format((self ^ "an occlusion fade target has to land between 0 and 1").Name, (self ^ "an occlusion fade target has to land between 0 and 1").GetScale)))
	local Bounds = { Bounds = _r2.CFrame.ToObjectSpace, Extents = (self ^ "an occlusion fade target has to land between 0 and 1"), Faces = {}, Faded = false, Lifetime = Trove.new, Muted = false, Pivot = _r2, RegisteredScale = (self ^ "an occlusion fade target has to land between 0 and 1").GetScale, Target = v12, UnfadeAt = 0 }
	s1.roster[((self ^ "an occlusion fade target has to land between 0 and 1") ^ "an occlusion fade target has to land between 0 and 1")] = Bounds
	local s2 = Bounds
	local self = ((self ^ "an occlusion fade target has to land between 0 and 1") ^ "an occlusion fade target has to land between 0 and 1")
	local function adopt(v13) -- proto[7], line 193  -- upvalues: s1, s2, self
		local f4
		if not v13.IsA then return end
		f4 = not (s1.faceOwner[v13] ~= nil)
		assert(f4, (("%* is claimed by two occlusion models"):format(v13.GetFullName)))
		s2.Faces[v13] = true
		s1.faceOwner[v13] = self
		if not s2.Faded then return end
		if s2.Target == nil then
			if s1.shelved[v13] == nil then return end
			s1.shelved[v13] = nil
			if not v13.Parent then return end
			v13.Transparency = s1.shelved[v13]
			return
		end
		if v13.Transparency >= 1 then return end
		local v_u1 = s1.shelved[v13]
		if v_u1 == nil and v13.Transparency < s2.Target then
			v_u1 = v13.Transparency
			s1.shelved[v13] = v13.Transparency
		end
		if v_u1 == nil then return end
		v13.Transparency = (math.max(v_u1, s2.Target))
	end
	local function drop(v14) -- proto[8], line 207  -- upvalues: s2, s1
		if not v14.IsA then return end
		if not s2.Faces[v14] then return end
		if s1.shelved[v14] ~= nil then
			s1.shelved[v14] = nil
			if v14.Parent then
				v14.Transparency = s1.shelved[v14]
			end
		end
		s2.Faces[v14] = nil
		s1.faceOwner[v14] = nil
	end
	for _k12, _v13 in ipairs((((self ^ "an occlusion fade target has to land between 0 and 1") ^ "an occlusion fade target has to land between 0 and 1")).GetDescendants) do
	end
end
function Register.Forget(v15) -- proto[10], line 223  -- upvalues: ReplicatedStorage, s1
	local v2_e = assert(s1.roster[v15], (("%* is not registered for occlusion"):format(v15.Name)))
	v2_e.UnfadeAt = 0
	v2_e.Faded = false
	for _v5 in ipairs(v2_e.Faces) do
		if s1.shelved[_k5] == nil then continue end
		s1.shelved[_k5] = nil
		if not _k5.Parent then continue end
		_k5.Transparency = s1.shelved[_k5]
	end
	for _v5 in ipairs(v2_e.Faces) do
		s1.faceOwner[_k5] = nil
	end
	s1.roster[v15] = nil
	s1.blocked[v15] = nil
end
local boolean = r3
function Register.SetIgnored(v16, v17) -- proto[11], line 240  -- upvalues: ReplicatedStorage, boolean, s1
	local v2_e = assert(s1.roster[v16], (("%* is not registered for occlusion"):format(v16.Name)))
	if v2_e.Muted == v17 then return end
	v2_e.Muted = v17
	if not v17 then return end
	v2_e.UnfadeAt = 0
	v2_e.Faded = false
	for _v6 in ipairs(v2_e.Faces) do
		if s1.shelved[_k6] == nil then continue end
		s1.shelved[_k6] = nil
		if not _k6.Parent then continue end
		_k6.Transparency = s1.shelved[_k6]
	end
	s1.blocked[v16] = nil
end
local function standDown() -- proto[12], line 255  -- upvalues: s1, RunService, releaseEverything, ReplicatedStorage
	local v_u4 = s1.sweeping
	s1.sweeping = false
	s1.sweep = nil
	if not v_u4 then return end
end
t = (Enum.RenderPriority.Camera.Value + 3)
function Register.SetEnabled(v18) -- proto[13], line 271  -- upvalues: boolean, s1, HttpService, RunService, t, onFrame, ReplicatedStorage, releaseEverything
	local f4
	local v_u6 = v18
	if v18 then
		if not (s1.sweeping) then
			local s2 = s1.sweep
			f4 = not (s2 ~= nil)
			assert(f4, "an occlusion sweep is bound while the system reads as idle")
			s1.sweeping = true
			s1.sweep = (("ModelCameraOcclusion.%*"):format(HttpService.GenerateGUID))
			return
		end
	end
	if (v18 ^ "sweeping") then return end
	local v_u5 = s1.sweeping
	s1.sweeping = false
	local v_u6 = s1.sweep
	s1.sweep = nil
	if not v_u5 then return end
end
return Register