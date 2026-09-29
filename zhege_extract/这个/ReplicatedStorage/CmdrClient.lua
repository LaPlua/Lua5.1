-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.CmdrClient
-- ============================================

-- bytecode
-- Original size: 2937 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 57, Protos: 14, Main proto: 13

-- ============== SOURCE ==============
-- main chunk (proto[13], line 1)
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local Shared = script:WaitForChild("Shared")
local Util = require(Shared:WaitForChild("Util"))
if (RunService:IsClient()) == false then
	error("Server scripts cannot require the client library. Please require the server library to use Cmdr in your own code.")
end
local ReplicatedRoot = { ReplicatedRoot = script, RemoteFunction = script:WaitForChild("CmdrFunction"), RemoteEvent = script:WaitForChild("CmdrEvent"), ActivationKeys = {}, Enabled = true, MashToEnable = false, ActivationUnlocksMouse = false, HideOnLostFocus = true, PlaceName = "Cmdr", Util = Util, Events = {} }
local _index = {}
function _index.__index(self, v1) -- proto[1], line 28
	local v1_e = self.Dispatcher[v1]
	if not v1_e then return end
	if (type(v1_e)) ~= "function" then return end
	local function anon0(v2, ...) -- proto[0], line 31  -- upvalues: v1_e, self
		return v1_e(self.Dispatcher)
	end
	return anon0
end
local object = setmetatable(ReplicatedRoot, _index)
local Registry = require(Shared.Registry)
object.Registry = (Registry(object))
local Dispatcher = require(Shared.Dispatcher)
object.Dispatcher = (Dispatcher(object))
local CmdrInterface = require(script.CmdrInterface)
local r1 = CmdrInterface(object)
function object.SetActivationKeys(v3, v4) -- proto[2], line 51  -- upvalues: Util
	v3.ActivationKeys = Util.MakeDictionary
end
CmdrInterface = r1
function object.SetPlaceName(v5, v6) -- proto[3], line 56  -- upvalues: CmdrInterface
	v5.PlaceName = v6
end
function object.SetEnabled(v7, v8) -- proto[4], line 62
	v7.Enabled = v8
end
function object.SetActivationUnlocksMouse(v9, v10) -- proto[5], line 67
	v9.ActivationUnlocksMouse = v10
end
function object.Show(v11) -- proto[6], line 72  -- upvalues: CmdrInterface
	if not (v11.Enabled) then return end
end
function object.Hide(v12) -- proto[7], line 81  -- upvalues: CmdrInterface
end
function object.Toggle(v13) -- proto[8], line 86  -- upvalues: CmdrInterface
	if not (v13.Enabled) then return v13:Hide() end
end
function object.SetMashToEnable(v14, v15) -- proto[9], line 95
	v14.MashToEnable = v15
	if not v15 then return end
end
function object.SetHideOnLostFocus(v16, v17) -- proto[10], line 104
	v16.HideOnLostFocus = v17
end
function object.HandleEvent(v18, v19, v20) -- proto[11], line 109
	v18.Events[v19] = v20
end
if (RunService:IsServer()) == false then
	object.Registry:RegisterTypesIn(script:WaitForChild("Types"))
	object.Registry:RegisterCommandsIn(script:WaitForChild("Commands"))
end
object.RemoteEvent.OnClientEvent:Connect(function(v21, ...)
	if not object.Events[v21] then return end
	object.Events[v21](object.Events)
end)
local DefaultEventHandlers = require(script.DefaultEventHandlers)
DefaultEventHandlers(object)
return object