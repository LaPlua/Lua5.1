-- ============================================
-- ClassName: LocalScript
-- FullName: ReplicatedStorage.GearTools.ShopItems.Katana.Controller
-- ============================================

-- bytecode
-- Original size: 722 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 23, Protos: 1, Main proto: 0

-- ============== SOURCE ==============
local f1
-- main chunk (proto[0], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Client = require(ReplicatedStorage.Shared.Modules.BatController.Client)
local Gears = require(ReplicatedStorage.Data.Gears)
local GearName = script.Parent:GetAttribute("GearName")
f1 = not ((typeof(GearName)) ~= "string")
assert(f1, "Bat Tool requires a GearName attribute")
Client.new(script.Parent, (assert(Gears.Directory[GearName].BatControllerData, (("%* requires BatControllerData"):format(GearName)))))