-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.Gears
-- ============================================

-- bytecode
-- Original size: 2421 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 61, Protos: 3, Main proto: 2

-- ============== SOURCE ==============
-- main chunk (proto[2], line 1)
local Types = require(script.Types)
local _r3 = {}
_r3["Abyss Ocean Bat"] = (require(script.Configs["Abyss Ocean Bat"]))
local Bat = require(script.Configs.Bat)
_r3.Bat = Bat
local BeeLauncher = require(script.Configs.BeeLauncher)
_r3.BeeLauncher = BeeLauncher
local BigTrap = require(script.Configs.BigTrap)
_r3.BigTrap = BigTrap
_r3["Cosmic Bat"] = (require(script.Configs["Cosmic Bat"]))
_r3["Desert Bat"] = (require(script.Configs["Desert Bat"]))
local Flyswatter = require(script.Configs.Flyswatter)
_r3.Flyswatter = Flyswatter
_r3["Forest Bat"] = (require(script.Configs["Forest Bat"]))
local GravityDisruptor = require(script.Configs.GravityDisruptor)
_r3.GravityDisruptor = GravityDisruptor
_r3["Jungle Bat"] = (require(script.Configs["Jungle Bat"]))
local Katana = require(script.Configs.Katana)
_r3.Katana = Katana
_r3["Lake Bat"] = (require(script.Configs["Lake Bat"]))
_r3["Light Dark Staff"] = (require(script.Configs["Light Dark Staff"]))
_r3["Prehistoric Bat"] = (require(script.Configs["Prehistoric Bat"]))
_r3["Snow Bat"] = (require(script.Configs["Snow Bat"]))
_r3["The Scrambler"] = (require(script.Configs["The Scrambler"]))
_r3["Titan Axe"] = (require(script.Configs["Titan Axe"]))
local Trap = require(script.Configs.Trap)
_r3.Trap = Trap
_r3["Volcano Bat"] = (require(script.Configs["Volcano Bat"]))
local r1 = table.freeze(_r3)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BalanceConfig = require(ReplicatedStorage.Shared.Flags.BalanceConfig)
local MoneyCost = { MoneyCost = true, ShopDropWeight = true, MinShopStockQuantity = true, MaxShopStockQuantity = true, SlapPower = true, MaxActiveDeployments = true, BatControllerData = true, ControllerData = true, COOLDOWN = true, MAX_RANGE = true, MOB_DAMAGE = true, RAGDOLL_DURATION = true, SLAP_DURATION = true, SLAP_FORCE = true, DETECTION_RANGE = true, LIFETIME = true, PULL_SPEED = true, PULL_DURATION = true, MAX_PULL_DISTANCE = true, DANCE_DURATION = true, STUN_DURATION = true, USE_LIMIT = true }
r1 = BalanceConfig.Bind("Game.Balance.Gears", r1, MoneyCost, true, function(v1)
	local f1
	for _k4, _v5 in ipairs(v1) do
		if (_v5.MinShopStockQuantity % 1) <= 0 then
			f1 = not ((_v5.MaxShopStockQuantity % 1) > 0)
		end
		assert(f1)
		f1 = false  -- skip 1
		f1 = true
		assert(f1)
		if not _v5.MaxActiveDeployments then continue end
		f1 = not ((_v5.MaxActiveDeployments % 1) > 0)
		assert(f1)
	end
end)
ReplicatedStorage = r1
local function GearNameExists(v2) -- proto[1], line 91  -- upvalues: ReplicatedStorage
	if (rawget(ReplicatedStorage, v2)) ~= nil then return true end
	return false, (("Gears name \"%*\" does not exist in the Gears directory."):format(v2))
end
local Directory = { Directory = r1, GearNameExists = GearNameExists }
return table.freeze(Directory)