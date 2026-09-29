-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Types.ShakeRequestData
-- ============================================

-- bytecode
-- Original size: 570 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 17, Protos: 1, Main proto: 0

-- ============== SOURCE ==============
-- main chunk (proto[0], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local _r2 = {}
local FadeInTime = { FadeInTime = (t.optional(t.number)), FadeOutTime = (t.optional(t.number)), Magnitude = t.number, PosInfluence = (t.optional(t.Vector3)), RotInfluence = (t.optional(t.Vector3)), Roughness = t.number }
_r2.SchemaValidation = (t.interface(FadeInTime))
return _r2