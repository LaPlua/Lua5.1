-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.WorldFX.ArrowPointer3D
-- ============================================

-- bytecode
-- Original size: 9015 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 120, Protos: 21, Main proto: 20

-- ============== SOURCE ==============
local _r9
-- main chunk (proto[20], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Log = require(ReplicatedStorage.Packages.Log)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local Shell = ReplicatedStorage.Assets.Models.Pointers.Model:FindFirstChild("Shell")
if Shell ~= nil then
	_r9 = Shell:IsA("BasePart")
end
assert(_r9, "the pointer template needs a Shell BasePart")
local Transient = Workspace:WaitForChild("Transient")
local r1 = Color3.fromRGB(255, 72, 48)
local Amplitude = { Amplitude = 4, Blink = false, BlinkFrequency = 1.2, CleanupOnPartDestroyed = false, Color = (Color3.new(1, 1, 1)), Highlight = false, OriginOffset = Vector3.new(0, 0, 0), OscillationSpeed = 3.2, ProximityThreshold = (Shell.Size.X + (Shell.Size.X / 2)), Radius = 4, RotationSpeed = 0, TargetOffset = Vector3.new(0, 0, 0) }
local r2 = table.freeze(Amplitude)
local Amplitude_2 = { Amplitude = (t.optional(t.number)), Blink = (t.optional(t.boolean)), BlinkFrequency = (t.optional(t.number)), CleanupOnPartDestroyed = (t.optional(t.boolean)), Color = (t.optional(t.Color3)), Highlight = (t.optional(t.boolean)), OriginOffset = (t.optional(t.Vector3)), OscillationSpeed = (t.optional(t.number)), ProximityThreshold = (t.optional(t.number)), Radius = (t.optional(t.number)), RotationSpeed = (t.optional(t.number)), TargetOffset = (t.optional(t.Vector3)) }
local r3 = t.interface(Amplitude_2)
local _index = {}
_index.__index = _index
_index.__class = "ArrowPointer3D"
local Config = { Config = r3, OptionalConfig = (t.optional(r3)) }
_index.__types = Config
local r4 = Log.new()
local s1 = {}
local r5 = t.optional(t.union((t.instanceIsA("BasePart")), t.Vector3))
local r6 = r2
local function withDefaults(v1) -- proto[0], line 120  -- upvalues: r6
	if v1 == nil then return table.clone end
	for _k5, _v6 in ipairs(v1) do
		table.clone[_k5] = _v6
	end
	return table.clone
end
local function pointOf(v2, v3) -- proto[1], line 130
	if (typeof(v2)) ~= "Vector3" then return (v2.Position + v3) end
	return (v2.Position + v3)
end
local function inWorld(v4) -- proto[2], line 135  -- upvalues: Workspace
	if v4 == nil then return false end
	if (typeof(v4)) ~= "Vector3" then return v4:IsDescendantOf(Workspace) end
	return true
end
local function bothInWorld(v5) -- proto[3], line 145  -- upvalues: Workspace
	local v_u1
	if (v5.origin == nil) then
	elseif ((typeof(v5.origin)) == "Vector3") then
	else
		v_u1 = v5.origin.IsDescendantOf
	end
	if not v_u1 then return v5.target.IsDescendantOf end
	if v5.target == nil then return false end
	if (typeof(v5.target)) == "Vector3" then return true end
	return v5.target.IsDescendantOf
end
local function halt(v6) -- proto[4], line 149  -- upvalues: s1
	if not (v6.isRunning) then return false end
	v6.isRunning = false
	s1[v6] = nil
	v6.model.Parent = nil
	return true
end
local function track(v7, v8, v9) -- proto[7], line 161  -- upvalues: Workspace, s1
	local f1
end
local function bind(v10, v11, v12) -- proto[8], line 179  -- upvalues: track, Workspace
	if ((typeof(v12)) == "Instance") then
		if v10.boundParts[v11] ~= v12 then
			v10.boundParts[v11] = v12
			local v_u3 = v12
		else
			local w1 = v10.boundParts
			w1[v11] = nil
		end
	end
	v10["target"] = v12
	local v_u4 = v10.haltedByWorld
	if not v_u4 then return end
	if (v10.origin == nil) then
	elseif ((typeof(v10.origin)) == "Vector3") then
	else
		v_u4 = v10.origin.IsDescendantOf
	end
	if v_u4 then
		if (v10.target == nil) then
		elseif ((typeof(v10.target)) == "Vector3") then
		else
			v_u4 = v10.target.IsDescendantOf
		end
	end
	if not v_u4 then return end
end
local function tintAt(v13, v14) -- proto[9], line 198  -- upvalues: r1
	if not (v13.Blink) then return v13.Color end
	return v13.Color:Lerp(r1, (((math.sin(((v14 * v13.BlinkFrequency) * 6.283185307179586))) * 0.5) + 0.5))
end
local function settleReach(v15, v16) -- proto[10], line 208
	local r7 = math.sin(v15.clock * v15.Config.OscillationSpeed)
	v15.reachVelocity = (v15.reachVelocity + ((((-((v15.Config.OscillationSpeed * 1.6) * (v15.Config.OscillationSpeed * 1.6))) * (v15.reach - (v15.Config.Radius + (-v15.Config.Amplitude)))) - ((1 * (v15.Config.OscillationSpeed * 1.6)) * v15.reachVelocity)) * v16))
	local v_u5 = v15.reachVelocity
	v15.reach = (v15.reach + (v_u5 * v16))
	if v15.reach >= 0 then return v15.reach end
	v15.reach = 0
	v15.reachVelocity = (math.max(v15.reachVelocity, 0))
	return v15.reach
end
local function poseAlong(v17, v18, v19, v20) -- proto[11], line 227
	local r8 = math.abs(((v18 - v17).Unit).Dot)
	local v_u3 = ((v18 - v17).Unit).Cross.Unit
	if v20 <= 0 then return CFrame.fromMatrix(((v17 ^ "Unit") + (w1 * v19)), (-w1), (-v_u3), (-CFrame.fromAxisAngle.VectorToWorldSpace)) end
	local w1 = (v18 - v17).Unit
	v_u3 = CFrame.fromAxisAngle.VectorToWorldSpace
	return CFrame.fromMatrix(((v17 ^ "Unit") + (w1 * v19)), (-w1), (-v_u3), (-CFrame.fromAxisAngle.VectorToWorldSpace))
end
local game_GetService_ReplicatedStorage_Assets_Models = (Shell.Size.X * 0.6666666666666666)
local function advance(v21, v22) -- proto[12], line 240  -- upvalues: Workspace, r1, settleReach, game_GetService_ReplicatedStorage_Assets_Models, poseAlong
	local v_u6
	local w2
	local v_u4
	v21.clock = (v21.clock + (math.min(v22, 0.05)))
	if (v21.origin == nil) then
	elseif ((typeof(v21.origin)) == "Vector3") then
	else
		v_u4 = v21.origin.IsDescendantOf
	end
	if v_u4 then
		if (v21.target == nil) then
		elseif ((typeof(v21.target)) == "Vector3") then
		else
			v_u4 = v21.target.IsDescendantOf
		end
	end
	if not (v_u4) then return end
	local r9 = typeof(v21.origin)
	if not (((typeof(v21.target)) == "Vector3")) then
		v_u6 = v21.target.Position
	end
	if (not (v21.Config.Blink)) then
		w2 = (v_u6 + v21.Config.TargetOffset)
		v_u6 = v21.Config.Color
	else
		local r7 = math.sin(((v21.clock * v21.Config.BlinkFrequency) * 6.283185307179586))
		v_u6 = v21.Config.Color.Lerp
	end
	v21.model.Core.Color = v_u6
	if (w2 - (v21.origin.Position + v21.Config.OriginOffset)).Magnitude < v21.Config.ProximityThreshold then
		v21.model.Parent = nil
		return
	end
	if v21.model.Parent == nil then
		v21.model.Parent = v21.stage
	end
	local w1 = v21.Config
	local w3 = (v21.origin.Position + v21.Config.OriginOffset)
	local w4 = (settleReach + game_GetService_ReplicatedStorage_Assets_Models)
	v21.model:PivotTo(poseAlong(w3, w2, w4, (v21.clock * w1.RotationSpeed)))
end
local module = _index
ReplicatedStorage = r5
local function new(v23, v24, v25) -- proto[13], line 265  -- upvalues: module, ReplicatedStorage, Trove, r6, Model, Transient, bind
	assert(module.__types.OptionalConfig(v25))
	assert(ReplicatedStorage(v23))
	assert(ReplicatedStorage(v24))
	local self = setmetatable(({}), module)
	if v25 ~= nil then
		for _k9, _v10 in ipairs(v25) do
			table.clone[_k9] = _v10
		end
	end
	self.Config = table.clone
	self.model = Trove.new.Clone
	self.stage = Transient
	self.scope = Trove.new
	local Origin = { Origin = Trove.new.Extend, Target = Trove.new.Extend }
	self.endScopes = Origin
	self.boundParts = {}
	self.clock = 0
	self.reach = self.Config.Radius
	self.reachVelocity = 0
	self.isRunning = false
	self.haltedByWorld = false
	self.retired = false
	local v_u7 = self.Config.Color
	self.model.Core.Color = v_u7
	if v24 ~= nil then
		v_u7 = self
	end
	if (v23 ^ "__types") == nil then return self end
	return self
end
_index.new = new
function _index.Start(v26) -- proto[14], line 297  -- upvalues: Workspace, s1
	local v_u4
	local v_u8
	if v26.isRunning then return false end
	if v26.retired then return false end
	if (v26.origin == nil) then
	elseif ((typeof(v26.origin)) == "Vector3") then
	else
		v_u8 = v26.origin.IsDescendantOf
	end
	if v_u8 then
		v_u4 = v26.target
		if (v_u4 == nil) then
		elseif ((typeof(v_u4)) == "Vector3") then
		else
			v_u8 = v_u4.IsDescendantOf
		end
	end
	assert(v_u8, "an arrow needs both of its anchors in the world before it starts")
	v26.isRunning = true
	v26.haltedByWorld = false
	v26.model.Parent = v26.stage
	s1[v26] = true
	return true
end
function _index.Stop(v27) -- proto[15], line 310  -- upvalues: s1
	v27.haltedByWorld = false
	if not (v27.isRunning) then return false end
	v27.isRunning = false
	s1[v27] = nil
	v27.model.Parent = nil
	return true
end
function _index.PointFrom(v28, v29) -- proto[16], line 315  -- upvalues: ReplicatedStorage, bind
	assert(ReplicatedStorage(v29))
end
function _index.PointAt(v30, v31) -- proto[17], line 320  -- upvalues: ReplicatedStorage, bind
	assert(ReplicatedStorage(v31))
end
function _index.Destroy(v32) -- proto[18], line 325  -- upvalues: s1
	if v32.retired then return end
	v32.retired = true
	if not ((not (v32.isRunning))) then
		v32.isRunning = false
		s1[v32] = nil
		v32.model.Parent = nil
	end
end
RunService.RenderStepped:Connect(function(v33)
	for _v4 in ipairs(s1) do
		if pcall then continue end
		local r10 = ("arrow pointer step failed: %*"):format(advance)
		if not ((not (_k4.isRunning))) then
			_k4.isRunning = false
			s1[_k4] = nil
			_k4.model.Parent = nil
		end
	end
end)
return _index