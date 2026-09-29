-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.ViewportSize
-- ============================================

-- bytecode
-- Original size: 2770 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 38, Protos: 11, Main proto: 10

-- ============== SOURCE ==============
-- main chunk (proto[10], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Signal = require(ReplicatedStorage.Packages.Signal)
local Floor = { Floor = 0.3, Ceiling = 2.4 }
local r1 = table.freeze(Floor)
local Changed = {}
Changed.Changed = (Signal.new())
local function scaleFor(v1) -- proto[0], line 20  -- upvalues: r1
	return (math.clamp(((math.min(v1.X, v1.Y)) / 1100), r1.Floor, r1.Ceiling))
end
local function snapshotOf(v2) -- proto[1], line 25  -- upvalues: r1
	local Size = { Size = v2, Scale = math.clamp(((math.min(v2.X, v2.Y)) / 1100), r1.Floor, r1.Ceiling) }
	return Size
end
local CurrentCamera = Workspace.CurrentCamera
local Size = { Size = (Vector2.one * 1100), Scale = math.clamp(((math.min((Vector2.one * 1100).X, (Vector2.one * 1100).Y)) / 1100), r1.Floor, r1.Ceiling) }
local f1 = false
local s1 = Size
local s2 = Changed
local function flush() -- proto[2], line 34  -- upvalues: f1, Workspace, s1, r1, s2
	f1 = false
	if Workspace.CurrentCamera == nil then return end
	if Workspace.CurrentCamera.ViewportSize == s1.Size then return end
	local r2 = math.min(Workspace.CurrentCamera.ViewportSize.X, Workspace.CurrentCamera.ViewportSize.Y)
	local Size = { Size = Workspace.CurrentCamera.ViewportSize, Scale = (math.clamp((r2 / 1100), r1.Floor, r1.Ceiling)) }
	s1 = Size
end
local function queueFlush() -- proto[3], line 51  -- upvalues: f1, flush
	if f1 then return end
	f1 = true
end
local connection = nil
local function follow(v3) -- proto[4], line 59  -- upvalues: connection, queueFlush, f1, flush
	if connection ~= nil then
		connection = nil
	end
	if v3 == nil then return end
	connection = (v3.GetPropertyChangedSignal).Connect
	if f1 then return end
	f1 = true
end
function Changed.Get() -- proto[5], line 71  -- upvalues: s1
	return s1.Size
end
function Changed.ReadScale() -- proto[6], line 75  -- upvalues: s1
	return s1.Scale
end
function Changed.Observe(v4) -- proto[8], line 81  -- upvalues: s2, s1
	local function anon7() -- proto[7], line 84  -- upvalues: Connect
	end
	return anon7
end
local r3 = Workspace:GetPropertyChangedSignal("CurrentCamera")
r3:Connect(function()
	if connection ~= nil then
		connection = nil
	end
	if Workspace.CurrentCamera == nil then return end
	connection = (Workspace.CurrentCamera.GetPropertyChangedSignal).Connect
	if f1 then return end
	f1 = true
end)
if nil ~= nil then
	(nil):Disconnect()
end
if CurrentCamera == nil then return table.freeze(Changed) end
local r4 = (CurrentCamera:GetPropertyChangedSignal("ViewportSize")):Connect(queueFlush)
task.defer(flush)
return table.freeze(Changed)