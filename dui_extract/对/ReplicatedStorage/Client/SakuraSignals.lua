-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.SakuraSignals
-- ============================================

-- bytecode
-- Original size: 296 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 9, Protos: 1, Main proto: 0

-- ============== SOURCE ==============
-- main chunk (proto[0], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Packages.Signal)
local Reveal = { Reveal = (Signal.new()), ShowTutorial = (Signal.new()) }
return Reveal