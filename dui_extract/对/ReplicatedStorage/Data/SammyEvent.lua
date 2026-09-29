-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.SammyEvent
-- ============================================

-- bytecode
-- Original size: 2128 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 45, Protos: 7, Main proto: 6

-- ============== SOURCE ==============
-- main chunk (proto[6], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local World = Workspace:WaitForChild("World")
local Areas = World:WaitForChild("Areas")
local GuardAreas = Areas:WaitForChild("GuardAreas")
local _r7 = {}
_r7[1], _r7[2], _r7[3] = { Id = "Wave1" }, { Id = "Wave2" }, { Id = "Wave3" }
local EMPCoin = ReplicatedStorage.Assets.Models.EMPCoin
local function PickupTemplate() -- proto[0], line 55  -- upvalues: EMPCoin
	return EMPCoin
end
local f2 = nil
local function Zones() -- proto[2], line 60  -- upvalues: f2, GuardAreaGeometry, GuardAreas
	if f2 then return f2 end
	-- anon1 captures:
	f2 = GuardAreaGeometry.ReadAreaBounds
	return GuardAreaGeometry.ReadAreaBounds
end
local s1 = { SpinSpeed = 2.4, PickupRadius = (ReplicatedStorage.Assets.Models.EMPCoin.Size.Y / 2), ChargeMax = 100, PHASES = _r7, PickupTemplate = PickupTemplate, Zones = Zones }
function s1.ZoneIndexAt(v3) -- proto[3], line 74  -- upvalues: s1, GuardAreaGeometry
	local v_u1
	for _k7, _v8 in ipairs(s1.Zones) do
		if GuardAreaGeometry.IsWithinFootprint then return _k7 end
		if (math.abs(_v8.Bounds.Position.X - v3.X)) >= inf then continue end
		v_u1 = _k7
	end
	return v_u1
end
function s1.EncodePickups(v4) -- proto[4], line 91
	for _k6, _v7 in ipairs(v4) do
		buffer.writef32(buffer.create, 0, _v7.X)
		buffer.writef32(buffer.create, (0 + 4), _v7.Y)
		buffer.writef32(buffer.create, (0 + 8), _v7.Z)
	end
	return buffer.create
end
function s1.DecodePickups(v5) -- proto[5], line 103
	local v_u2
	local _r1 = {}
	for _i = 1, R2 do
		v_u2 = ((_i - 1) * 12) + 4
		v_u2 = ((_i - 1) * 12) + 8
		local X = { X = (buffer.readf32(v5, ((_i - 1) * 12))), Y = (buffer.readf32(v5, v_u2)), Z = (buffer.readf32(v5, v_u2)) }
		_r1[_i] = X
	end
	return _r1
end
return s1