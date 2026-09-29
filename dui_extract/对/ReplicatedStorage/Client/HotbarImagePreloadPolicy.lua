-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.HotbarImagePreloadPolicy
-- ============================================

-- bytecode
-- Original size: 1319 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 25, Protos: 5, Main proto: 4

-- ============== SOURCE ==============
-- main chunk (proto[4], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local t = require(ReplicatedStorage.Packages.t)
local r1 = t.strict(t.instanceIsA("BasePart"))
local r2 = t.strict(t.Vector3)
local r3 = t.strict(t.number)
local r4 = t.strict(t.optional(t.number))
ReplicatedStorage = r1
local Vector3 = r2
local function GetShortestDistanceToClaimLine(v1, v2) -- proto[0], line 23  -- upvalues: ReplicatedStorage, Vector3, GuardAreaGeometry
	return (math.abs(GuardAreaGeometry.SignedDistanceToLine))
end
local number = r3
local function IsSpeedEligible(v3, v4) -- proto[1], line 33  -- upvalues: number, ReplicatedStorage
	if v4 == nil then return f1 end
	local f1 = false  -- skip 1
	f1 = true
	return f1
end
local CLAIM_PRELOAD_DISTANCE_STUDS = { CLAIM_PRELOAD_DISTANCE_STUDS = 50, GetShortestDistanceToClaimLine = GetShortestDistanceToClaimLine, IsSpeedEligible = IsSpeedEligible }
local s1 = CLAIM_PRELOAD_DISTANCE_STUDS
function CLAIM_PRELOAD_DISTANCE_STUDS.IsWithinClaimPreloadDistance(v5) -- proto[2], line 43  -- upvalues: number, s1
	local f2 = not (v5 >= s1.CLAIM_PRELOAD_DISTANCE_STUDS)
	return f2
end
function CLAIM_PRELOAD_DISTANCE_STUDS.ShouldPreloadCarriedEgg(v6, v7, v8) -- proto[3], line 49  -- upvalues: ReplicatedStorage, s1
	local v_u1
	local s2 = s1.IsSpeedEligible
	if s2 then return v_u1 end
	if v8 == nil then return v_u1 end
	v_u1 = s1.IsWithinClaimPreloadDistance
	return v_u1
end
return table.freeze(CLAIM_PRELOAD_DISTANCE_STUDS)