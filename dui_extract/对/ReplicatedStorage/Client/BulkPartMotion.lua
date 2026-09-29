-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.BulkPartMotion
-- ============================================

-- bytecode
-- Original size: 10045 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 88, Protos: 25, Main proto: 24

-- ============== SOURCE ==============
-- main chunk (proto[24], line 1)
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local t = require(ReplicatedStorage.Packages.t)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local Log = require(ReplicatedStorage.Packages.Log)
local r1 = Log.new()
ReplicatedStorage = (t.intersection((t.numberMinExclusive(-inf)), t.numberMaxExclusive(inf)))
local function isFiniteVector(v1) -- proto[0], line 24  -- upvalues: ReplicatedStorage
	if (typeof(v1)) ~= "Vector3" then return ReplicatedStorage end
	if not ReplicatedStorage then return ReplicatedStorage end
	return ReplicatedStorage
end
local ReplicatedStorage_2
local function isFiniteCFrame(v2) -- proto[1], line 33  -- upvalues: ReplicatedStorage
	local v_u1
	local ReplicatedStorage_2 = ReplicatedStorage
	if (typeof(v2)) ~= "CFrame" then return ReplicatedStorage_2 end
	if (typeof(v2.Position)) == "Vector3" then
		if ReplicatedStorage_2 then
			ReplicatedStorage_2 = ReplicatedStorage
			if ReplicatedStorage_2 then
				v_u1 = v2.Position.Z
				ReplicatedStorage_2 = ReplicatedStorage
			end
		end
	end
	if not ReplicatedStorage_2 then return ReplicatedStorage_2 end
	if (typeof(v2.XVector)) == "Vector3" then
		ReplicatedStorage_2 = ReplicatedStorage
		if ReplicatedStorage_2 then
			local w1 = v2.XVector
			ReplicatedStorage_2 = ReplicatedStorage
			if ReplicatedStorage_2 then
				v_u1 = w1.Z
				ReplicatedStorage_2 = ReplicatedStorage
			end
		end
	end
	if not ReplicatedStorage_2 then return ReplicatedStorage_2 end
	if (typeof((v2 ^ "typeof").YVector)) == "Vector3" then
		ReplicatedStorage_2 = ReplicatedStorage
		if ReplicatedStorage_2 then
			ReplicatedStorage_2 = ReplicatedStorage
			if ReplicatedStorage_2 then
				v_u1 = (v2 ^ "typeof").YVector.Z
				ReplicatedStorage_2 = ReplicatedStorage
			end
		end
	end
	if not ReplicatedStorage_2 then return ReplicatedStorage_2 end
	if (typeof((v2 ^ "typeof").ZVector)) ~= "Vector3" then return ReplicatedStorage_2 end
	ReplicatedStorage_2 = ReplicatedStorage
	if not ReplicatedStorage_2 then return ReplicatedStorage_2 end
	ReplicatedStorage_2 = ReplicatedStorage
	if not ReplicatedStorage_2 then return ReplicatedStorage_2 end
	ReplicatedStorage_2 = ReplicatedStorage
	return ReplicatedStorage_2
end
local r2 = t.strict(t.instanceIsA("BasePart"))
local r3 = t.strict(isFiniteCFrame)
local r4 = t.strict(t.optional(isFiniteCFrame))
local r5 = t.strict(isFiniteVector)
local r6 = t.strict(t.TweenInfo)
local _index = {}
_index.__index = _index
local s1 = {}
local s2 = {}
local s3 = {}
local s4 = {}
local s5 = {}
local function isAlive(v3) -- proto[2], line 75
	local f1
	if v3 == nil then return f1 end
	f1 = not (v3.Parent == nil)
	return f1
end
local function dropGlide(v4) -- proto[3], line 77  -- upvalues: s3
	s3[v4] = nil
	v4.origin = nil
	v4.destination = nil
	v4.curve = nil
	v4.spent = 0
end
local function retire(v5) -- proto[4], line 85  -- upvalues: s1, s2, s3
	local body = v5.body
	if body then
		s1[body] = nil
	end
	s2[v5] = nil
	s3[v5] = nil
	v5.origin = nil
	v5.destination = nil
	v5.curve = nil
	v5.spent = 0
	v5.body = nil
	v5.root = nil
	v5.queued = nil
	v5.extent = nil
	v5.retired = true
end
local function writable(v6) -- proto[5], line 103  -- upvalues: s1, s2, s3
	if v6.body ~= nil then
		if v6.body.Parent ~= nil then return v6.body end
		local body = v6.body
		if body then
			s1[body] = nil
		end
	end
	s2[v6] = nil
	s3[v6] = nil
	v6.origin = nil
	v6.destination = nil
	v6.curve = nil
	v6.spent = 0
	v6.body = nil
	v6.root = nil
	v6.queued = nil
	v6.extent = nil
	v6.retired = true
	return nil
end
local function enqueue(v7, v8) -- proto[6], line 114  -- upvalues: s2
	v7.root = v8
	v7.queued = (v8 * v7.lean)
	s2[v7] = true
end
local isFiniteVector = r5
local function reshape(v9, v10, v11) -- proto[7], line 122  -- upvalues: isFiniteVector, s1, s2, s3
	local body
	if v9.retired then return end
	local v_u2 = v10
	v9.extent = (v10 or v9.extent)
	v_u2 = v11
	v9.stretch = (v11 or v9.stretch)
	if v9.body ~= nil then
		if v9.body.Parent ~= nil then
			v_u2 = v9.body
		end
	else
		body = v9.body
		if body then
			s1[body] = nil
		end
		s2[v9] = nil
		s3[v9] = nil
		v9.origin = nil
		v9.destination = nil
		v9.curve = nil
		v9.spent = 0
		v9.body = nil
		v9.root = nil
		v9.queued = nil
		v9.extent = nil
		v9.retired = true
		body = nil
	end
	if not body then return end
	local v_u1 = (v9.extent or body.Size)
	body.Size = (Vector3.new((v_u1.X * v9.stretch.X), (v_u1.Y * v9.stretch.Y), (v_u1.Z * v9.stretch.Z)))
end
local isFiniteCFrame = r3
local function reposition(v12, v13, v14) -- proto[8], line 141  -- upvalues: isFiniteCFrame, s1, s2, s3
	local body
	if v12.body ~= nil then
		if v12.body.Parent ~= nil then
			body = v12.body
		end
	else
		body = v12.body
		if body then
			s1[body] = nil
		end
		s2[v12] = nil
		s3[v12] = nil
		v12.origin = nil
		v12.destination = nil
		v12.curve = nil
		v12.spent = 0
		v12.body = nil
		v12.root = nil
		v12.queued = nil
		v12.extent = nil
		v12.retired = true
		body = nil
	end
	if not (body) then return end
	s3[v12] = nil
	v12.origin = nil
	v12.destination = nil
	v12.curve = nil
	v12.spent = 0
	v12.root = v13
	v12.queued = (v13 * v12.lean)
	s2[v12] = true
	if not v14 then return end
	s2[v12] = nil
	body.CFrame = v12.queued
end
local function sweepDead() -- proto[9], line 158  -- upvalues: s1, s2, s3
	for _k3, _v4 in ipairs(s1) do
		if _k3 == nil then continue end
		if _k3.Parent ~= nil then continue end
		local body = _v4.body
		if body then
			s1[body] = nil
		end
		s2[_v4] = nil
		s3[_v4] = nil
		_v4.origin = nil
		_v4.destination = nil
		_v4.curve = nil
		_v4.spent = 0
		_v4.body = nil
		_v4.root = nil
		_v4.queued = nil
		_v4.extent = nil
		_v4.retired = true
	end
end
local function advanceGlides(v15) -- proto[10], line 168  -- upvalues: s3, s1, s2, TweenService
	local body
	local f2
	for _v4 in ipairs(s3) do
		if _k4.origin ~= nil then
			if _k4.destination ~= nil then
				f2 = not (_k4.curve == nil)
			end
		end
		if _k4.body == nil then continue end
		if _k4.body.Parent ~= nil then
			body = _k4.body
		else
			body = _k4.body
			if body then
				s1[body] = nil
			end
			s2[_k4] = nil
			s3[_k4] = nil
			_k4.origin = nil
			_k4.destination = nil
			_k4.curve = nil
			_k4.spent = 0
			_k4.body = nil
			_k4.root = nil
			_k4.queued = nil
			_k4.extent = nil
			_k4.retired = true
			body = nil
		end
		if body == nil then
			continue
		end
		if not (f2) then
			s3[_k4] = nil
			_k4.origin = nil
			_k4.destination = nil
			_k4.curve = nil
			_k4.spent = 0
			continue
		end
		_k4.spent = (_k4.spent + v15)
		if (0 < _k4.curve.Time) then
			local r7 = math.clamp((_k4.spent / _k4.curve.Time), 0, 1)
		end
		_k4.root = _k4.origin.Lerp
		_k4.queued = (_k4.origin.Lerp * _k4.lean)
		s2[_k4] = true
		if 1 > 1 then continue end
		s3[_k4] = nil
		_k4.origin = nil
		_k4.destination = nil
		_k4.curve = nil
		_k4.spent = 0
	end
end
local ReplicatedStorage_2 = r4
local s6 = _index
local function Register(v16, v17) -- proto[11], line 199  -- upvalues: ReplicatedStorage, ReplicatedStorage_2, s1, s6
	local object
	if not ((s1[v16] ~= nil) and (not (s1[v16].retired))) then
		local body = { body = v16, root = nil, lean = CFrame.identity, queued = nil, origin = nil, destination = nil, curve = nil, spent = 0, extent = nil, stretch = Vector3.new(1, 1, 1), retired = false }
		object = setmetatable(body, s6)
	end
	s1[v16] = object
	return object
end
local function Forget(v18) -- proto[12], line 232  -- upvalues: ReplicatedStorage, s1, s2, s3
	local v1_e = s1[v18]
	if not v1_e then return end
	local body = v1_e.body
	if body then
		s1[body] = nil
	end
	s2[v1_e] = nil
	s3[v1_e] = nil
	v1_e.origin = nil
	v1_e.destination = nil
	v1_e.curve = nil
	v1_e.spent = 0
	v1_e.body = nil
	v1_e.root = nil
	v1_e.queued = nil
	v1_e.extent = nil
	v1_e.retired = true
end
local function Commit(v19) -- proto[14], line 243  -- upvalues: advanceGlides, s4, s5, s2, s1, s3, TryCall, sweepDead, ReplicatedStorage
	local body
	for _v5 in ipairs(s2) do
		s2[_k5] = nil
		_k5.queued = nil
		if _k5.body == nil then continue end
		if _k5.body.Parent == nil then
			body = _k5.body
			if body then
				s1[body] = nil
			end
			s2[_k5] = nil
			s3[_k5] = nil
			_k5.origin = nil
			_k5.destination = nil
			_k5.curve = nil
			_k5.spent = 0
			_k5.body = nil
			_k5.root = nil
			_k5.queued = nil
			_k5.extent = nil
			_k5.retired = true
			continue
		end
		if not _k5.queued then continue end
		local w2 = _k5.body
		s4[(0 + 1)] = w2
		s5[(0 + 1)] = _k5.queued
	end
	if (0 + 1) <= 0 then return end
	if TryCall then return end
end
local _r15 = { Register = Register, Forget = Forget, Commit = Commit }
function _index.Subject(v20) -- proto[15], line 281
	if not v20.retired then return v20.body end
	return nil
end
function _index.Destroy(v21) -- proto[16], line 283  -- upvalues: s1, s2, s3
	if v21.retired then return end
	local body = v21.body
	if body then
		s1[body] = nil
	end
	s2[v21] = nil
	s3[v21] = nil
	v21.origin = nil
	v21.destination = nil
	v21.curve = nil
	v21.spent = 0
	v21.body = nil
	v21.root = nil
	v21.queued = nil
	v21.extent = nil
	v21.retired = true
end
function _index.Halt(v22) -- proto[17], line 289  -- upvalues: s3
	s3[v22] = nil
	v22.origin = nil
	v22.destination = nil
	v22.curve = nil
	v22.spent = 0
end
function _index.Stretch(v23, v24) -- proto[18], line 291  -- upvalues: reshape
end
function _index.Span(v25, v26) -- proto[19], line 293  -- upvalues: reshape
end
function _index.Lean(v27, v28) -- proto[20], line 297  -- upvalues: isFiniteCFrame, s1, s2, s3
	local body
	if v27.body ~= nil then
		if v27.body.Parent ~= nil then
			body = v27.body
		end
	else
		body = v27.body
		if body then
			s1[body] = nil
		end
		s2[v27] = nil
		s3[v27] = nil
		v27.origin = nil
		v27.destination = nil
		v27.curve = nil
		v27.spent = 0
		v27.body = nil
		v27.root = nil
		v27.queued = nil
		v27.extent = nil
		v27.retired = true
		body = nil
	end
	if not body then return end
	v27.lean = v28
	local v_u2 = (v27.root or body.CFrame)
	v27.root = v_u2
	v27.queued = (v_u2 * v27.lean)
	s2[v27] = true
end
local TweenInfo = r6
function _index.Glide(v29, v30, v31) -- proto[21], line 307  -- upvalues: TweenInfo, isFiniteCFrame, s1, s2, s3
	local body
	if v29.body ~= nil then
		if v29.body.Parent ~= nil then
			body = v29.body
		end
	else
		body = v29.body
		if body then
			s1[body] = nil
		end
		s2[v29] = nil
		s3[v29] = nil
		v29.origin = nil
		v29.destination = nil
		v29.curve = nil
		v29.spent = 0
		v29.body = nil
		v29.root = nil
		v29.queued = nil
		v29.extent = nil
		v29.retired = true
		body = nil
	end
	if not body then return end
	local v_u1 = (v29.root or body.CFrame)
	v29.origin = v_u1
	v29.destination = v31
	v29.curve = v30
	v29.spent = 0
	s3[v29] = true
	s2[v29] = true
end
function _index.Snap(v32, v33) -- proto[22], line 322  -- upvalues: isFiniteCFrame, s1, s2, s3
	local body
	if v32.body ~= nil then
		if v32.body.Parent ~= nil then
			body = v32.body
		end
	else
		body = v32.body
		if body then
			s1[body] = nil
		end
		s2[v32] = nil
		s3[v32] = nil
		v32.origin = nil
		v32.destination = nil
		v32.curve = nil
		v32.spent = 0
		v32.body = nil
		v32.root = nil
		v32.queued = nil
		v32.extent = nil
		v32.retired = true
		body = nil
	end
	if not (body) then return end
	s3[v32] = nil
	v32.origin = nil
	v32.destination = nil
	v32.curve = nil
	v32.spent = 0
	v32.root = v33
	v32.queued = (v33 * v32.lean)
	s2[v32] = true
	s2[v32] = nil
	body.CFrame = v32.queued
end
function _index.SetCFrame(v34, v35) -- proto[23], line 324  -- upvalues: isFiniteCFrame, s1, s2, s3
	local body
	if v34.body ~= nil then
		if v34.body.Parent ~= nil then
			body = v34.body
		end
	else
		body = v34.body
		if body then
			s1[body] = nil
		end
		s2[v34] = nil
		s3[v34] = nil
		v34.origin = nil
		v34.destination = nil
		v34.curve = nil
		v34.spent = 0
		v34.body = nil
		v34.root = nil
		v34.queued = nil
		v34.extent = nil
		v34.retired = true
		body = nil
	end
	if not (body) then return end
	s3[v34] = nil
	v34.origin = nil
	v34.destination = nil
	v34.curve = nil
	v34.spent = 0
	v34.root = v35
	v34.queued = (v35 * v34.lean)
	s2[v34] = true
end
RunService.PreSimulation:Connect(_r15.Commit)
return _r15