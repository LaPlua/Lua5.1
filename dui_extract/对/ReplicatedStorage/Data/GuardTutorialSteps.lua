-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.GuardTutorialSteps
-- ============================================

-- bytecode
-- Original size: 881 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 22, Protos: 5, Main proto: 4

-- ============== SOURCE ==============
-- main chunk (proto[4], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuardTutorial = require(ReplicatedStorage.Shared.Types.GuardTutorial)
local s1 = {"StealEgg", "HeadToPen", "EquipEgg", "PlaceEgg", "HatchEgg", "PlacePet", "ExpandPen", "TreadmillIntro"}
local r1 = table.freeze(s1)
s1 = {}
for _k7, _v8 in ipairs(r1) do
	s1[_v8] = _k7
end
table.freeze(s1)
local GetOrderedStepIds = {}
function GetOrderedStepIds.GetOrderedStepIds() -- proto[0], line 36  -- upvalues: r1
	return r1
end
function GetOrderedStepIds.GetFirstStepId() -- proto[1], line 38  -- upvalues: r1
	return r1[1]
end
function GetOrderedStepIds.GetIndex(v1) -- proto[2], line 40  -- upvalues: s1
	return s1[v1]
end
local s2 = GetOrderedStepIds
function GetOrderedStepIds.GetNextStepId(v2) -- proto[3], line 42  -- upvalues: s2, r1
	if s2.GetIndex ~= nil then return r1[(s2.GetIndex + 1)] end
	return nil
end
return GetOrderedStepIds