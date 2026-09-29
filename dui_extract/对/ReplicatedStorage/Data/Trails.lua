-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.Trails
-- ============================================

-- bytecode
-- Original size: 3176 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 72, Protos: 3, Main proto: 2

-- ============== SOURCE ==============
-- main chunk (proto[2], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rarity = require(ReplicatedStorage.Data.Rarity)
local BlueTrail = {}
local _id = { _id = "BlueTrail", Price = 75000, ProductId = 3611606747, Icon = "rbxassetid://137035834049811", Rarity = Rarity.Rarities.Rare, SpeedMultiplier = 2.5, DisplayInShop = true, DisplayName = "Blue Trail" }
BlueTrail.BlueTrail = (table.freeze(_id))
local _id_2 = { _id = "MoonbloomTrail", Price = 5000000000000000, ProductId = 3712487399, Icon = "rbxassetid://123538285077698", Rarity = Rarity.Rarities.Divine, SpeedMultiplier = 20, SpeedNumberColor = (Color3.fromRGB(29, 255, 210)), DisplayInShop = true, DisplayName = "Moonbloom Trail" }
BlueTrail.MoonbloomTrail = (table.freeze(_id_2))
local _id_3 = { _id = "DivineTrail", Price = 300000000000000, ProductId = 3611606791, Icon = "rbxassetid://140597836052094", Rarity = Rarity.Rarities.Divine, SpeedMultiplier = 14, DisplayInShop = true, DisplayName = "Divine Trail" }
BlueTrail.DivineTrail = (table.freeze(_id_3))
local _id_4 = { _id = "EternalTrail", Price = 12500000000000, ProductId = 3611606787, Icon = "rbxassetid://127740746006344", Rarity = Rarity.Rarities.Eternal, SpeedMultiplier = 10, DisplayInShop = true, DisplayName = "Eternal Trail" }
BlueTrail.EternalTrail = (table.freeze(_id_4))
local _id_5 = { _id = "GalaxyTrail", Price = 20000000000, ProductId = 3611606773, Icon = "rbxassetid://86672420342894", Rarity = Rarity.Rarities.Cosmic, SpeedMultiplier = 5, DisplayInShop = true, DisplayName = "Galaxy Trail" }
BlueTrail.GalaxyTrail = (table.freeze(_id_5))
local _id_6 = { _id = "GoldenTrail", Price = 30000000, ProductId = 3611606764, Icon = "rbxassetid://78957355975053", Rarity = Rarity.Rarities.Legendary, SpeedMultiplier = 3.5, DisplayInShop = true, DisplayName = "Golden Trail" }
BlueTrail.GoldenTrail = (table.freeze(_id_6))
local _id_7 = { _id = "GreenTrail", Price = 5000, ProductId = 3611606739, Icon = "rbxassetid://123930672117029", Rarity = Rarity.Rarities.Uncommon, SpeedMultiplier = 2, DisplayInShop = true, DisplayName = "Green Trail" }
BlueTrail.GreenTrail = (table.freeze(_id_7))
local _id_8 = { _id = "GreyTrail", Price = 100, ProductId = nil, Icon = "rbxassetid://103930213073663", Rarity = Rarity.Rarities.Common, SpeedMultiplier = 1.5, DisplayInShop = true, DisplayName = "Grey Trail" }
BlueTrail.GreyTrail = (table.freeze(_id_8))
local _id_9 = { _id = "PurpleTrail", Price = 1500000, ProductId = 3611606754, Icon = "rbxassetid://109475464579632", Rarity = Rarity.Rarities.Epic, SpeedMultiplier = 3, DisplayInShop = true, DisplayName = "Purple Trail" }
BlueTrail.PurpleTrail = (table.freeze(_id_9))
local _id_10 = { _id = "RedTrail", Price = 750000000, ProductId = 3611606768, Icon = "rbxassetid://72219596211828", Rarity = Rarity.Rarities.Mythic, SpeedMultiplier = 4, DisplayInShop = true, DisplayName = "Red Trail" }
BlueTrail.RedTrail = (table.freeze(_id_10))
local _id_11 = { _id = "SecretTrail", Price = 500000000000, ProductId = 3611606784, Icon = "rbxassetid://124057247070872", Rarity = Rarity.Rarities.Secret, SpeedMultiplier = 7, DisplayInShop = true, DisplayName = "Secret Trail" }
BlueTrail.SecretTrail = (table.freeze(_id_11))
local ReplicatedStorage_2 = game:GetService("ReplicatedStorage")
local BalanceConfig = require(ReplicatedStorage_2.Shared.Flags.BalanceConfig)
local Price = { Price = true, SpeedMultiplier = true }
BlueTrail = BalanceConfig.Bind("Game.Balance.Trails", BlueTrail, Price, true, function(v1)
	local f1
	for _k4, _v5 in ipairs(v1) do
		f1 = not (0 >= _v5.SpeedMultiplier)
		assert(f1)
	end
end)
table.freeze(BlueTrail)
ReplicatedStorage = BlueTrail
local function TrailNameExists(v2) -- proto[1], line 151  -- upvalues: ReplicatedStorage
	if ReplicatedStorage[v2] ~= nil then return true end
	return false, (("Trails name \"%*\" does not exist in the Trails directory."):format(v2))
end
local Directory = { Directory = BlueTrail, TrailNameExists = TrailNameExists }
return table.freeze(Directory)