-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.CameraShaker
-- ============================================

-- bytecode
-- Original size: 3744 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 61, Protos: 10, Main proto: 9

-- ============== SOURCE ==============
-- main chunk (proto[9], line 1)
local _index = {}
_index.__index = _index
local r1 = Vector3.new()
local CameraShakeInstance = require(script.CameraShakeInstance)
_index.CameraShakeInstance = CameraShakeInstance
local CameraShakePresets = require(script.CameraShakePresets)
_index.Presets = CameraShakePresets
local module = _index
function _index.new(v1, v2) -- proto[0], line 74  -- upvalues: r1, module
	local f1
	local f1 = not ((type(v1)) ~= "number")
	assert(f1, "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)")
	f1 = not ((type(v2)) ~= "function")
	assert(f1, "Callback must be a function")
	local _running = { _running = false, _renderName = "CameraShaker", _renderPriority = v1, _posAddShake = r1, _rotAddShake = r1, _camShakeInstances = {}, _removeInstances = {}, _callback = v2 }
	local self = setmetatable(_running, module)
	return self
end
function _index.Start(self) -- proto[2], line 95  -- upvalues: profilebegin, profileend
if self._running then return end
self._running = true
function _index.Stop(v4) -- proto[3], line 108
	if not (v4._running) then return end
	v4._running = false
end
CameraShakeInstance = CameraShakeInstance.CameraShakeState
local new = CFrame.new
local Angles = CFrame.Angles
local rad = math.rad
function _index.Update(v5, v6) -- proto[4], line 115  -- upvalues: r1, CameraShakeInstance, new, Angles, rad
	for _i = 1, (#v5._camShakeInstances) do
		if v5._camShakeInstances[_i].GetState == CameraShakeInstance.Inactive and v5._camShakeInstances[_i].DeleteOnInactive then
			v5._removeInstances[((#v5._removeInstances) + 1)] = _i
			continue
		end
		if v5._camShakeInstances[_i].GetState == CameraShakeInstance.Inactive then continue end
	end
	local w1 = (r1 + (v5._camShakeInstances[_i].UpdateShake * v5._camShakeInstances[_i].RotationInfluence))
	for _i_2 = (#v5._removeInstances), 1, -1 do
		v5._removeInstances[_i_2] = nil
	end
	local r2 = rad(w1.Y)
	local w2 = (new * Angles)
	local r3 = rad(w1.X)
	local r4 = rad(w1.Z)
	return (w2 * Angles)
end
function _index.Shake(v7, v8) -- proto[5], line 151
	local v_u1
	if (type(v8)) == "table" then
		v_u1 = v8._camShakeInstance
	end
	assert(v_u1, "ShakeInstance must be of type CameraShakeInstance")
	v7._camShakeInstances[((#v7._camShakeInstances) + 1)] = v8
	return v8
end
function _index.ShakeSustain(v9, v10) -- proto[6], line 158
	local v_u1
	if (type(v10)) == "table" then
		v_u1 = v10._camShakeInstance
	end
	assert(v_u1, "ShakeInstance must be of type CameraShakeInstance")
	v9._camShakeInstances[((#v9._camShakeInstances) + 1)] = v10
	return v10
end
function _index.ShakeOnce(v11, v12, v13, v14, v15, v16, v17) -- proto[7], line 166  -- upvalues: CameraShakeInstance
	local v_u2 = v12
	local v_u3 = v14
	if (typeof(v16)) == "Vector3" then
		v_u2 = v16
	end
	CameraShakeInstance.new.PositionInfluence = Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448)
	if (typeof(v17)) == "Vector3" then
		local v_u2 = v17
	end
	CameraShakeInstance.new.RotationInfluence = Vector3.new(1, 1, 1)
	v11._camShakeInstances[((#v11._camShakeInstances) + 1)] = CameraShakeInstance.new
	return CameraShakeInstance.new
end
function _index.StartShake(v18, v19, v20, v21, v22, v23) -- proto[8], line 175  -- upvalues: CameraShakeInstance
	local v_u4 = v19
	local v_u5 = v21
	if (typeof(v22)) == "Vector3" then
		v_u4 = v22
	end
	CameraShakeInstance.new.PositionInfluence = Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448)
	if (typeof(v23)) == "Vector3" then
		local v_u4 = v23
	end
	CameraShakeInstance.new.RotationInfluence = Vector3.new(1, 1, 1)
	v18._camShakeInstances[((#v18._camShakeInstances) + 1)] = CameraShakeInstance.new
	return CameraShakeInstance.new
end
return _index