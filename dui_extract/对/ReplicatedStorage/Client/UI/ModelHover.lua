-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.ModelHover
-- ============================================

-- bytecode
-- Original size: 1373 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 36, Protos: 2, Main proto: 1

-- ============== SOURCE ==============
-- main chunk (proto[1], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollisionGroups = require(ReplicatedStorage.Shared.Types.CollisionGroups)
local t = require(ReplicatedStorage.Packages.t)
local r1 = t.strict(t.table)
local r2 = t.strict(t.Vector2)
local r3 = t.strict(t.number)
local r4 = t.strict(t.string)
local r5 = t.strict(t.instanceIsA("Model"))
local r6 = RaycastParams.new()
r6.CollisionGroup = CollisionGroups.PLAYER_COLLISION_GROUP
r6.IgnoreWater = true
local KeyUnderCursor = {}
local table = r1
local Vector2 = r2
local number = r3
local string = r4
ReplicatedStorage = r5
function KeyUnderCursor.KeyUnderCursor(v1, v2, v3) -- proto[0], line 20  -- upvalues: table, Vector2, number, r6, string, ReplicatedStorage
	local f1
	local v_u1 = v3
	f1 = not (0 >= v3)
	assert(f1, "a hover probe with no reach can never touch anything")
	if not (workspace.Raycast) then return nil end
	for _k9, _v10 in pairs do
		if not _v10.Parent then continue end
		if (workspace.Raycast.Instance).IsDescendantOf then return _k9 end
	end
	return nil
end
return KeyUnderCursor