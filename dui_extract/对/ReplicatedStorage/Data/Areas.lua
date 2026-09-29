-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.Areas
-- ============================================

-- bytecode
-- Original size: 1470 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 33, Protos: 3, Main proto: 2

-- ============== SOURCE ==============
-- main chunk (proto[2], line 1)
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
local DropTable = { DropTable = true }
r1 = BalanceConfig.Bind("Game.Balance.Areas", r1, DropTable, true, function(v1)
	local f1
	for _k4, _v5 in ipairs(v1) do
		for _k10, _v11 in ipairs(_v5.DropTable) do
		end
		f1 = not (0 >= (0 + _v11[2]))
		assert(f1)
	end
end)
ReplicatedStorage = r1
local function AreaNameExists(v2) -- proto[1], line 43  -- upvalues: ReplicatedStorage
	if (rawget(ReplicatedStorage, v2)) ~= nil then return true end
	return false, (("Area name \"%*\" does not exist in the Areas directory."):format(v2))
end
local Directory = { Directory = r1, AreaNameExists = AreaNameExists }
return table.freeze(Directory)