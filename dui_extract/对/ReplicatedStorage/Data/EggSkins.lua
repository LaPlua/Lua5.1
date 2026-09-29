-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.EggSkins
-- ============================================

-- bytecode
-- Original size: 1061 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 30, Protos: 2, Main proto: 1

-- ============== SOURCE ==============
-- main chunk (proto[1], line 1)
local Biohazard = {}
local ModelName = { ModelName = "Biohazard Egg", Icon = "rbxassetid://103838374075457", DisplayName = "Biohazard Egg" }
Biohazard.Biohazard = (table.freeze(ModelName))
local ModelName_2 = { ModelName = "Experiment Egg", Icon = "rbxassetid://77124617553239", DisplayName = "Experiment Egg" }
Biohazard.Experimental = (table.freeze(ModelName_2))
local ModelName_3 = { ModelName = "Unstable", Icon = "rbxassetid://121178065227483", DisplayName = "Unstable Egg" }
Biohazard.UnstableDNA = (table.freeze(ModelName_3))
local ModelName_4 = { ModelName = "LimitedExperimentEgg", Icon = "", DisplayName = "Limited Experiment Egg" }
Biohazard.LimitedExperiment = (table.freeze(ModelName_4))
local ModelName_5 = { ModelName = "Riftborn Egg", Icon = "rbxassetid://136340085637939", DisplayName = "Riftborn Egg" }
Biohazard.Riftborn = (table.freeze(ModelName_5))
local ModelName_6 = { ModelName = "Riftbeasts Egg", Icon = "rbxassetid://97679329738336", DisplayName = "Riftbeasts Egg" }
Biohazard.Riftbeasts = (table.freeze(ModelName_6))
local ModelName_7 = { ModelName = "Shattered Rift Egg", Icon = "rbxassetid://85929412992561", DisplayName = "Shattered Rift Egg" }
Biohazard.ShatteredRift = (table.freeze(ModelName_7))
local r1 = table.freeze(Biohazard)
local r2 = r1
local function Get(v1) -- proto[0], line 48  -- upvalues: r2
	if v1 == nil then return nil end
	return r2[v1]
end
local Directory = { Directory = r1, Get = Get }
return table.freeze(Directory)