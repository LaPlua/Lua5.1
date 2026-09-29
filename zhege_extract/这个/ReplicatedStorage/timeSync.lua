-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.timeSync
-- ============================================

-- bytecode
-- Original size: 3196 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 50, Protos: 18, Main proto: 17

-- ============== SOURCE ==============
local function new(v1, v2) -- proto[9], line 69  -- upvalues: module_2
	local self = setmetatable(({}), module_2)
	self._remoteEvent = error
	self._remoteFunction = error
	local object = self
	return self
end
local function GetTime(v4) -- proto[10], line 84
	if not (v4.IsSynced) then
		return v4:_getLocalTime()
	end
	local w1 = v4:_getLocalTime()
	local w2 = v4._getLocalTime
	return (w2 - v4._offset)
end
local function IsSynced(v5) -- proto[11], line 93
	local f1 = not (v5._offset <= -1)
	return f1
end
-- main chunk (proto[17], line 1)
local RunService = game:GetService("RunService")
local _index = {}
_index.__index = _index
_index.ClassName = "MasterClock"
local module = _index
function _index.new(v6, v7) -- proto[3], line 13  -- upvalues: module
	local self = setmetatable(({}), module)
	self._remoteEvent = error
	self._remoteFunction = error
	local RemoteGuard = require(((game.GetService).WaitForChild):WaitForChild("RemoteGuard"))
	local _r6 = {}
	local min = { min = 0, max = 1000000000000 }
	_r6[1] = min
	local object = self
	return self
end
function _index.IsSynced(v11) -- proto[4], line 40
	return true
end
function _index.GetTime(v12) -- proto[5], line 46
	return tick()
end
function _index.Sync(v13) -- proto[6], line 51
end
function _index._handleDelayRequest(v14, v15) -- proto[7], line 58
	local w1 = v14.GetTime
	return (w1 - v15)
end
local _index_2 = {}
_index_2.__index = _index_2
_index_2.ClassName = "SlaveClock"
_index_2._offset = -1
local module_2 = _index_2
-- new captures: module_2
_index_2.new = new
-- GetTime captures:
_index_2.GetTime = GetTime
-- IsSynced captures:
_index_2.IsSynced = IsSynced
function _index_2._getLocalTime(v16) -- proto[12], line 97
	return tick()
end
function _index_2._handleSyncEvent(v17, v18) -- proto[13], line 101
	local w1 = v17._getLocalTime
	local w3 = v17._sendDelayRequest
	local w4 = ((w1 - v18) - v17._sendDelayRequest)
	local w5 = (w4 / 2)
	v17._offset = w5
	v17._pneWayDelay = (((w1 - v18) + w3) / 2)
end
function _index_2._sendDelayRequest(v19, v20) -- proto[14], line 129
	return v19._remoteFunction:InvokeServer(v20)
end
local function buildClock() -- proto[16], line 135  -- upvalues: RunService, module, module_2
	if RunService.IsClient then
		if RunService.IsServer then
			-- anon15 captures:
			return module.new
		end
	end
	if not RunService.IsClient then return module.new((script.TimeSyncEvent ^ "script"), script.DelayedRequestEvent) end
	return module_2.new((script.TimeSyncEvent ^ "script"), script.DelayedRequestEvent)
end
return buildClock()