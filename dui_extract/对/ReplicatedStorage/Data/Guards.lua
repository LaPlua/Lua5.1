-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.Guards
-- ============================================

-- bytecode
-- Original size: 2242 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 46, Protos: 5, Main proto: 4

-- ============== SOURCE ==============
-- main chunk (proto[4], line 1)
local Types = require(script.Types)
local _r3 = {}
_r3["Abyss Ocean"] = (require(script.Configs["Abyss Ocean"]))
_r3["Cherry Blossom"] = (require(script.Configs["Cherry Blossom"]))
local Cosmic = require(script.Configs.Cosmic)
_r3.Cosmic = Cosmic
local Desert = require(script.Configs.Desert)
_r3.Desert = Desert
local Forest = require(script.Configs.Forest)
_r3.Forest = Forest
local Jungle = require(script.Configs.Jungle)
_r3.Jungle = Jungle
_r3["Titan Temple"] = (require(script.Configs["Titan Temple"]))
_r3["Light Dark"] = (require(script.Configs["Light Dark"]))
_r3["Light Dark Light"] = (require(script.Configs["Light Dark Light"]))
_r3["Light Dark Dark"] = (require(script.Configs["Light Dark Dark"]))
_r3["Light Dark Mixed"] = (require(script.Configs["Light Dark Mixed"]))
local Lake = require(script.Configs.Lake)
_r3.Lake = Lake
local Prehistoric = require(script.Configs.Prehistoric)
_r3.Prehistoric = Prehistoric
local Snow = require(script.Configs.Snow)
_r3.Snow = Snow
local Volcano = require(script.Configs.Volcano)
_r3.Volcano = Volcano
local r1 = table.freeze(_r3)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BalanceConfig = require(ReplicatedStorage.Shared.Flags.BalanceConfig)
local WalkSpeed = { WalkSpeed = true, FlatRadius = true, HitDistance = true, EggPickupDistance = true, HomeImpulseBoostDistanceXZ = true }
r1 = BalanceConfig.Bind("Game.Balance.Guards", r1, WalkSpeed, true, function(v1)
	local f1
	for _k4, _v5 in ipairs(v1) do
		if 0 < _v5.WalkSpeed then
			if 0 < _v5.FlatRadius then
				f1 = not (0 >= _v5.HitDistance)
			end
		end
		assert(f1)
	end
end)
ReplicatedStorage = r1
local function GuardNameExists(v2) -- proto[1], line 48  -- upvalues: ReplicatedStorage
	if (rawget(ReplicatedStorage, v2)) ~= nil then return true end
	return false, (("Guard name \"%*\" does not exist in the Guards directory."):format(v2))
end
local function GetLowestWalkSpeed() -- proto[2], line 56
	return require.GuardMovement.MIN_REFERENCE_WALK_SPEED
end
local function GetHighestWalkSpeed() -- proto[3], line 60
	return require.GuardMovement.MAX_REFERENCE_WALK_SPEED
end
local Directory = { Directory = r1, GuardNameExists = GuardNameExists, GetLowestWalkSpeed = GetLowestWalkSpeed, GetHighestWalkSpeed = GetHighestWalkSpeed }
return table.freeze(Directory)