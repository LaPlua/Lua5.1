-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.ExpandedLobby
-- ============================================

-- bytecode
-- Original size: 970 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 27, Protos: 2, Main proto: 1

-- ============== SOURCE ==============
-- main chunk (proto[1], line 1)
local Control = { Control = "Control", Variant = "Variant" }
local CenterZ = { CenterZ = -364.1, ZScale = 1.35, WestColumnXOffset = -20, WestColumnMaxX = 500 }
local TestAttributeKey = { TestAttributeKey = "ExpandedLobby.Group", ServerTypeAttributeKey = "ExpandedLobby.ServerType", Groups = (table.freeze(Control)), UnlockedValue = "None", ServerAttribute = "ExpandedLobbyServerGroup", TeleportDataKey = "ExpandedLobbyGroup", StudioForceAttribute = "ExpandedLobbyForceGroup", RemovalTag = "ExpandedLobbyABTestRemoval", JobAttributeWaitSeconds = 15, ApplyDeadlineSeconds = 120, PlotSpread = (table.freeze(CenterZ)) }
local s1 = TestAttributeKey
function TestAttributeKey.IsValidGroup(v1) -- proto[0], line 26  -- upvalues: s1
	local f1
	if v1 == s1.Groups.Control then return f1 end
	f1 = not (v1 ~= s1.Groups.Variant)
	return f1
end
return table.freeze(TestAttributeKey)