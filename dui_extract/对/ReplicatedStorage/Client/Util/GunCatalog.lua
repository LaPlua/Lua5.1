-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Util.GunCatalog
-- ============================================

-- bytecode
-- Original size: 511 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 15, Protos: 2, Main proto: 1

-- ============== SOURCE ==============
-- main chunk (proto[1], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Gears = require(ReplicatedStorage.Data.Gears)
local s1 = {}
for _k6, _v7 in pairs(Gears.Directory) do
	if _v7.ToolController ~= "Gun" then continue end
	s1[((#s1) + 1)] = _v7._id
end
table.freeze(s1)
local ListGearNames = {}
function ListGearNames.ListGearNames() -- proto[0], line 19  -- upvalues: s1
	return table.clone(s1)
end
return ListGearNames