-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.SmartProximityPrompt
-- ============================================

-- bytecode
-- Original size: 615 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 13, Protos: 2, Main proto: 1

-- ============== SOURCE ==============
-- main chunk (proto[1], line 1)
local FollowerLoop = require(script.FollowerLoop)
local SurfaceTracker = require(script.SurfaceTracker)
local AttachToModel = {}
function AttachToModel.AttachToModel(v1, v2, v3) -- proto[0], line 16  -- upvalues: FollowerLoop, SurfaceTracker
	if (v3 or {}).MaxActivationDistance ~= nil then
		v1.MaxActivationDistance = (v3 or {}).MaxActivationDistance
	end
	local r1 = FollowerLoop.MakeAnchor((v3 or {}).PartName, v2:GetPivot())
	v1.RequiresLineOfSight = false
	return FollowerLoop.Add(v1, v2, r1, SurfaceTracker.new, (v3 or {}))
end
return AttachToModel