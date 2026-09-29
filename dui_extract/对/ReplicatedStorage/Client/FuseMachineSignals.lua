-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.FuseMachineSignals
-- ============================================

-- bytecode
-- Original size: 236 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 8, Protos: 1, Main proto: 0

-- ============== SOURCE ==============
-- main chunk (proto[0], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Packages.Signal)
local FuseStarted = {}
FuseStarted.FuseStarted = (Signal.new())
return FuseStarted