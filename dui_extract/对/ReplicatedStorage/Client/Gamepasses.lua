-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Gamepasses
-- ============================================

-- bytecode
-- Original size: 838 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 22, Protos: 2, Main proto: 1

-- ============== SOURCE ==============
-- main chunk (proto[1], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Gamepasses = require(ReplicatedStorage.Data.Gamepasses)
local Shared = ReplicatedStorage:WaitForChild("Shared")
local Save = require(Shared:WaitForChild("Save"))
local Owns = {}
local f1
function Owns.Owns(v1, v2) -- proto[0], line 14  -- upvalues: Gamepasses, Save, Players
	if Gamepasses.Directory[v1] == nil then
		local r1 = ("\"%*\" is not a gamepass"):format((tostring(v1)))
	end
	if Save.Await == nil then return false end
	local w1 = Gamepasses.Directory[v1]
	if (typeof(Save.Await.Gamepasses)) ~= "table" then return f1 end
	f1 = not (Save.Await.Gamepasses[w1.Name] ~= true)
	return f1
end
return table.freeze(Owns)