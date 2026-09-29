-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.ConsoleSignals
-- ============================================

-- bytecode
-- Original size: 337 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 11, Protos: 1, Main proto: 0

-- ============== SOURCE ==============
-- main chunk (proto[0], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Packages.Signal)
local ButtonDown = { ButtonDown = (Signal.new()), ButtonUp = (Signal.new()) }
return table.freeze(ButtonDown)