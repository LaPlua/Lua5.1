-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.Assets
-- ============================================

-- bytecode
-- Original size: 14200 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 290, Protos: 5, Main proto: 4

-- ============== SOURCE ==============
-- main chunk (proto[4], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PersonalityCatalog = require(script.PersonalityCatalog)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local Types = require(script.Types)
local function makeAnimation(v1) -- proto[1], line 28
	local new = Instance.new
	local function setAnimationId() -- proto[0], line 31  -- upvalues: new, v1
		new.AnimationId = v1
	end
	if pcall then return Instance.new end
	local r1 = ("Animation %* is not shared with this experience"):format(v1)
	return Instance.new
end
local DisplayName = { DisplayName = "Assets", Icon = "rbxassetid://116524274262912", ModelName = nil, GrowthTime = 60, WeightKg = 80, HideRarity = nil, IgnoreSizeGrowthMultiplier = nil }
local new = Animation
local arg0 = "rbxassetid://122342179426051"
local function setAnimationId() -- proto[0], line 31  -- upvalues: new, arg0
	new.AnimationId = arg0
end
if not (pcall(setAnimationId)) then
	warn("Animation rbxassetid://122342179426051 is not shared with this experience")
end
local Idle = { Idle = Instance.new("Animation"), Walk = nil, TransitionFadeDuration = nil }
local _r8 = {}
local r2 = table.freeze(({(Color3.fromRGB(86, 160, 61)), 1}))
local r3 = table.freeze(({(Color3.fromRGB(96, 119, 82)), 1}))
local r4 = table.freeze(({(Color3.fromRGB(90, 100, 105)), 1}))
_r8[1], _r8[2], _r8[3], _r8[4], _r8[5] = r2, r3, r4, (table.freeze(({(Color3.fromRGB(93, 84, 67)), 1}))), table.freeze(({(Color3.fromRGB(145, 122, 86)), 1}))
local _id = { _id = nil, DisplayName = "Assets", Icon = nil, Egg = (table.freeze(DisplayName)), WhiteImage = nil, MutationIcons = nil, EarningRate = 1, IndexSpeedReward = 0, DropWeight = 1, VisualOdds = 1, ModelWeight = 80, Animations = (table.freeze(Idle)), WalkAnimationReferenceSpeed = nil, Rarity = Rarity.Rarities.Common, BaseModelScale = 1, LimitedEggViewportScale = 1, LimitedEggViewportVerticalOffset = 0, BaseModelColor = (Color3.fromRGB(86, 160, 61)), PossibleModelColors = (table.freeze(_r8)), PlaceSound = nil, WalkSound = nil, RandomIdleSound = nil, LuckyBlockDropTable = nil, LuckyBlockDropTableType = nil, LuckyBlockLevelRange = nil, LuckyBlockOpenDuration = nil, DontRoll = nil, CannotFuse = nil, GenderLocked = nil, AlbinosColorFullWhite = nil }
local r5 = table.freeze(_id)
local _r8_2 = {}
_r8_2["Nibbles #013"] = (require(script.Configs["Nibbles #013"]))
local LimitedTimeExperimentPet = require(script.Configs.LimitedTimeExperimentPet)
_r8_2.LimitedTimeExperimentPet = LimitedTimeExperimentPet
local Hazardhog = require(script.Configs.Hazardhog)
_r8_2.Hazardhog = Hazardhog
local Ringlord = require(script.Configs.Ringlord)
_r8_2.Ringlord = Ringlord
_r8_2["Ring Guard"] = (require(script.Configs["Ring Guard"]))
_r8_2["Alabaster Whale"] = (require(script.Configs["Alabaster Whale"]))
_r8_2["Alien Skeleton Boss"] = (require(script.Configs["Alien Skeleton Boss"]))
local Ankylosaurus = require(script.Configs.Ankylosaurus)
_r8_2.Ankylosaurus = Ankylosaurus
_r8_2["Archdemon Dragon"] = (require(script.Configs["Archdemon Dragon"]))
_r8_2["Ascended Vermilion Phoenix"] = (require(script.Configs["Ascended Vermilion Phoenix"]))
_r8_2["Ash Gecko"] = (require(script.Configs["Ash Gecko"]))
_r8_2["Baby Aurora Dragon"] = (require(script.Configs["Baby Aurora Dragon"]))
local Balrog = require(script.Configs.Balrog)
_r8_2.Balrog = Balrog
_r8_2["Bananita Dolphinita"] = (require(script.Configs["Bananita Dolphinita"]))
local Basilisk = require(script.Configs.Basilisk)
_r8_2.Basilisk = Basilisk
local Bear = require(script.Configs.Bear)
_r8_2.Bear = Bear
_r8_2["Belula Beluga"] = (require(script.Configs["Belula Beluga"]))
_r8_2["Bomboclat Crocolat"] = (require(script.Configs["Bomboclat Crocolat"]))
local Bronto = require(script.Configs.Bronto)
_r8_2.Bronto = Bronto
_r8_2["Brr Brr Patapim"] = (require(script.Configs["Brr Brr Patapim"]))
_r8_2["Burrowing Owl"] = (require(script.Configs["Burrowing Owl"]))
local Camel = require(script.Configs.Camel)
_r8_2.Camel = Camel
local Catfish = require(script.Configs.Catfish)
_r8_2.Catfish = Catfish
_r8_2["Cave Dragon"] = (require(script.Configs["Cave Dragon"]))
local Centapede = require(script.Configs.Centapede)
_r8_2.Centapede = Centapede
local Cerberus = require(script.Configs.Cerberus)
_r8_2.Cerberus = Cerberus
local Chicken = require(script.Configs.Chicken)
_r8_2.Chicken = Chicken
_r8_2["Chillin Chilli"] = (require(script.Configs["Chillin Chilli"]))
local Chimpanzee = require(script.Configs.Chimpanzee)
_r8_2.Chimpanzee = Chimpanzee
_r8_2["Colossal Mammoth"] = (require(script.Configs["Colossal Mammoth"]))
local Crane = require(script.Configs.Crane)
_r8_2.Crane = Crane
local Crocodile = require(script.Configs.Crocodile)
_r8_2.Crocodile = Crocodile
_r8_2["Cyclops Gorilla"] = (require(script.Configs["Cyclops Gorilla"]))
local DeathstalkerScorpion = require(script.Configs.DeathstalkerScorpion)
_r8_2.DeathstalkerScorpion = DeathstalkerScorpion
_r8_2["Demon Imp"] = (require(script.Configs["Demon Imp"]))
local DesertLark = require(script.Configs.DesertLark)
_r8_2.DesertLark = DesertLark
local Dodo = require(script.Configs.Dodo)
_r8_2.Dodo = Dodo
local Dog = require(script.Configs.Dog)
_r8_2.Dog = Dog
local Dragon = require(script.Configs.Dragon)
_r8_2.Dragon = Dragon
_r8_2["Dream Axolotl"] = (require(script.Configs["Dream Axolotl"]))
_r8_2["Drill Monster"] = (require(script.Configs["Drill Monster"]))
local Duckling = require(script.Configs.Duckling)
_r8_2.Duckling = Duckling
_r8_2["El Maja"] = (require(script.Configs["El Maja"]))
_r8_2["Ember Dragon"] = (require(script.Configs["Ember Dragon"]))
_r8_2["Eternal Lunar Dragon"] = (require(script.Configs["Eternal Lunar Dragon"]))
local FennecFox = require(script.Configs.FennecFox)
_r8_2.FennecFox = FennecFox
_r8_2["Finned Thresher"] = (require(script.Configs["Finned Thresher"]))
_r8_2["Flaming Bull"] = (require(script.Configs["Flaming Bull"]))
local Frog = require(script.Configs.Frog)
_r8_2.Frog = Frog
_r8_2["Galaxy Gecko"] = (require(script.Configs["Galaxy Gecko"]))
local Gorilla = require(script.Configs.Gorilla)
_r8_2.Gorilla = Gorilla
local Hellhound = require(script.Configs.Hellhound)
_r8_2.Hellhound = Hellhound
_r8_2["Ice Dragon"] = (require(script.Configs["Ice Dragon"]))
local Irihorus = require(script.Configs.Irihorus)
_r8_2.Irihorus = Irihorus
local Jerboa = require(script.Configs.Jerboa)
_r8_2.Jerboa = Jerboa
local Kitsune = require(script.Configs.Kitsune)
_r8_2.Kitsune = Kitsune
local Koi = require(script.Configs.Koi)
_r8_2.Koi = Koi
local Kraken = require(script.Configs.Kraken)
_r8_2.Kraken = Kraken
_r8_2["La Vacca Saturno Saturnita"] = (require(script.Configs["La Vacca Saturno Saturnita"]))
_r8_2["Lava Iguana"] = (require(script.Configs["Lava Iguana"]))
_r8_2["Lava frog"] = (require(script.Configs["Lava frog"]))
local Mammoth = require(script.Configs.Mammoth)
_r8_2.Mammoth = Mammoth
_r8_2["Mangolini Parrochini"] = (require(script.Configs["Mangolini Parrochini"]))
_r8_2["Mecha Scorpio"] = (require(script.Configs["Mecha Scorpio"]))
_r8_2["Mecha Froggo"] = (require(script.Configs["Mecha Froggo"]))
_r8_2["Mecha Crawler"] = (require(script.Configs["Mecha Crawler"]))
_r8_2["Mecha Crocodon"] = (require(script.Configs["Mecha Crocodon"]))
_r8_2["Mecha Krakenoid"] = (require(script.Configs["Mecha Krakenoid"]))
_r8_2["Mecha Dreadscale"] = (require(script.Configs["Mecha Dreadscale"]))
_r8_2["Mire Fox"] = (require(script.Configs["Mire Fox"]))
local Scorpio = require(script.Configs.Scorpio)
_r8_2.Scorpio = Scorpio
local Froggo = require(script.Configs.Froggo)
_r8_2.Froggo = Froggo
local Crawler = require(script.Configs.Crawler)
_r8_2.Crawler = Crawler
local Crocodon = require(script.Configs.Crocodon)
_r8_2.Crocodon = Crocodon
local Krakenoid = require(script.Configs.Krakenoid)
_r8_2.Krakenoid = Krakenoid
local Dreadscale = require(script.Configs.Dreadscale)
_r8_2.Dreadscale = Dreadscale
local Mosasaurus = require(script.Configs.Mosasaurus)
_r8_2.Mosasaurus = Mosasaurus
_r8_2["Oni Tiger"] = (require(script.Configs["Oni Tiger"]))
_r8_2["Orangutini Ananassini"] = (require(script.Configs["Orangutini Ananassini"]))
local Orca = require(script.Configs.Orca)
_r8_2.Orca = Orca
local Parrotfish = require(script.Configs.Parrotfish)
_r8_2.Parrotfish = Parrotfish
local Penguin = require(script.Configs.Penguin)
_r8_2.Penguin = Penguin
_r8_2["Polar Bear"] = (require(script.Configs["Polar Bear"]))
local Pterodactyl = require(script.Configs.Pterodactyl)
_r8_2.Pterodactyl = Pterodactyl
local Raccoon = require(script.Configs.Raccoon)
_r8_2.Raccoon = Raccoon
local Rattlesnake = require(script.Configs.Rattlesnake)
_r8_2.Rattlesnake = Rattlesnake
_r8_2["Red Panda"] = (require(script.Configs["Red Panda"]))
_r8_2["Sabertooth Tiger"] = (require(script.Configs["Sabertooth Tiger"]))
local Salamander = require(script.Configs.Salamander)
_r8_2.Salamander = Salamander
_r8_2["Sand Spider"] = (require(script.Configs["Sand Spider"]))
local ScorchedDragon = require(script.Configs.ScorchedDragon)
_r8_2.ScorchedDragon = ScorchedDragon
_r8_2["Shadow Dragon"] = (require(script.Configs["Shadow Dragon"]))
_r8_2["Snowy Owl"] = (require(script.Configs["Snowy Owl"]))
local Spider = require(script.Configs.Spider)
_r8_2.Spider = Spider
local Stag = require(script.Configs.Stag)
_r8_2.Stag = Stag
_r8_2["Strawberry Elephant"] = (require(script.Configs["Strawberry Elephant"]))
local Swan = require(script.Configs.Swan)
_r8_2.Swan = Swan
local Swordfish = require(script.Configs.Swordfish)
_r8_2.Swordfish = Swordfish
local Tiger = require(script.Configs.Tiger)
_r8_2.Tiger = Tiger
_r8_2["Tob Tobi Tob Tob"] = (require(script.Configs["Tob Tobi Tob Tob"]))
local Toucan = require(script.Configs.Toucan)
_r8_2.Toucan = Toucan
local Tralaledon = require(script.Configs.Tralaledon)
_r8_2.Tralaledon = Tralaledon
local Triceratops = require(script.Configs.Triceratops)
_r8_2.Triceratops = Triceratops
_r8_2["Trulimero Trulicina"] = (require(script.Configs["Trulimero Trulicina"]))
_r8_2["Tung Tung Sahur"] = (require(script.Configs["Tung Tung Sahur"]))
local Turtle = require(script.Configs.Turtle)
_r8_2.Turtle = Turtle
local TyrannosaurusRex = require(script.Configs.TyrannosaurusRex)
_r8_2.TyrannosaurusRex = TyrannosaurusRex
local Unicorn = require(script.Configs.Unicorn)
_r8_2.Unicorn = Unicorn
_r8_2["Void Dragon"] = (require(script.Configs["Void Dragon"]))
local Walrus = require(script.Configs.Walrus)
_r8_2.Walrus = Walrus
local Warden = require(script.Configs.Warden)
_r8_2.Warden = Warden
_r8_2["Whale Shark"] = (require(script.Configs["Whale Shark"]))
local Yeti = require(script.Configs.Yeti)
_r8_2.Yeti = Yeti
local Crab = require(script.Configs.Crab)
_r8_2.Crab = Crab
local Rhino = require(script.Configs.Rhino)
_r8_2.Rhino = Rhino
local Mantis = require(script.Configs.Mantis)
_r8_2.Mantis = Mantis
_r8_2["Kaiju Spider"] = (require(script.Configs["Kaiju Spider"]))
local Shark = require(script.Configs.Shark)
_r8_2.Shark = Shark
_r8_2["Blade Head"] = (require(script.Configs["Blade Head"]))
_r8_2["King Kong"] = (require(script.Configs["King Kong"]))
local Godzilla = require(script.Configs.Godzilla)
_r8_2.Godzilla = Godzilla
local Wendigo = require(script.Configs.Wendigo)
_r8_2.Wendigo = Wendigo
local Shardwing = require(script.Configs.Shardwing)
_r8_2.Shardwing = Shardwing
_r8_2["Shattered Drake"] = (require(script.Configs["Shattered Drake"]))
_r8_2["Shattered Colossus"] = (require(script.Configs["Shattered Colossus"]))
local Ventinal = require(script.Configs.Ventinal)
_r8_2.Ventinal = Ventinal
_r8_2["World Eater"] = (require(script.Configs["World Eater"]))
local Mawbreaker = require(script.Configs.Mawbreaker)
_r8_2.Mawbreaker = Mawbreaker
local Dreadclaw = require(script.Configs.Dreadclaw)
_r8_2.Dreadclaw = Dreadclaw
_r8_2["Void Serpent"] = (require(script.Configs["Void Serpent"]))
local ArchAngel = require(script.Configs.ArchAngel)
_r8_2.ArchAngel = ArchAngel
_r8_2["World Burner"] = (require(script.Configs["World Burner"]))
local Pegasus = require(script.Configs.Pegasus)
_r8_2.Pegasus = Pegasus
_r8_2["Skeleton Horse"] = (require(script.Configs["Skeleton Horse"]))
local Aetheron = require(script.Configs.Aetheron)
_r8_2.Aetheron = Aetheron
local Equinox = require(script.Configs.Equinox)
_r8_2.Equinox = Equinox
local Dove = require(script.Configs.Dove)
_r8_2.Dove = Dove
local Lamb = require(script.Configs.Lamb)
_r8_2.Lamb = Lamb
local Moth = require(script.Configs.Moth)
_r8_2.Moth = Moth
local Peacock = require(script.Configs.Peacock)
_r8_2.Peacock = Peacock
local Jellyfish = require(script.Configs.Jellyfish)
_r8_2.Jellyfish = Jellyfish
local Centaur = require(script.Configs.Centaur)
_r8_2.Centaur = Centaur
_r8_2["Flame Sprite"] = (require(script.Configs["Flame Sprite"]))
local Toro = require(script.Configs.Toro)
_r8_2.Toro = Toro
local Imp = require(script.Configs.Imp)
_r8_2.Imp = Imp
_r8_2["Demon Hound"] = (require(script.Configs["Demon Hound"]))
_r8_2["Dark Gargoyle"] = (require(script.Configs["Dark Gargoyle"]))
local RazorFang = require(script.Configs.RazorFang)
_r8_2.RazorFang = RazorFang
_r8_2["Toxic Rat"] = (require(script.Configs["Toxic Rat"]))
local Radcoon = require(script.Configs.Radcoon)
_r8_2.Radcoon = Radcoon
local Toucax = require(script.Configs.Toucax)
_r8_2.Toucax = Toucax
local Nuceodille = require(script.Configs.Nuceodille)
_r8_2.Nuceodille = Nuceodille
_r8_2["Wheel Hamster"] = (require(script.Configs["Wheel Hamster"]))
_r8_2["Stacked Turtle"] = (require(script.Configs["Stacked Turtle"]))
local Frogfly = require(script.Configs.Frogfly)
_r8_2.Frogfly = Frogfly
local Spiderpig = require(script.Configs.Spiderpig)
_r8_2.Spiderpig = Spiderpig
local Sharkodile = require(script.Configs.Sharkodile)
_r8_2.Sharkodile = Sharkodile
local Octophant = require(script.Configs.Octophant)
_r8_2.Octophant = Octophant
_r8_2["Mecha Scrambler"] = (require(script.Configs["Mecha Scrambler"]))
local Dreadstinger = require(script.Configs.Dreadstinger)
_r8_2.Dreadstinger = Dreadstinger
local Rhinobear = require(script.Configs.Rhinobear)
_r8_2.Rhinobear = Rhinobear
_r8_2["Eyeball Crab"] = (require(script.Configs["Eyeball Crab"]))
_r8_2["Three Headed Chicken"] = (require(script.Configs["Three Headed Chicken"]))
_r8_2["Nuclear Mantis"] = (require(script.Configs["Nuclear Mantis"]))
_r8_2["Void Angler"] = (require(script.Configs["Void Angler"]))
_r8_2["Rift Eye"] = (require(script.Configs["Rift Eye"]))
_r8_2["Shattered Ram"] = (require(script.Configs["Shattered Ram"]))
local Shardling = require(script.Configs.Shardling)
_r8_2.Shardling = Shardling
local Voidmaw = require(script.Configs.Voidmaw)
_r8_2.Voidmaw = Voidmaw
local Riftwing = require(script.Configs.Riftwing)
_r8_2.Riftwing = Riftwing
_r8_2["Abyss Overlord"] = (require(script.Configs["Abyssal Overlord"]))
_r8_2["Abyss Overlord OP"] = (require(script.Configs["Abyssal Overlord OP"]))
_r8_2["Manta Ray"] = (require(script.Configs["Manta Ray"]))
local Spike = require(script.Configs.Spike)
_r8_2.Spike = Spike
_r8_2["Riptide Octopus"] = (require(script.Configs["Riptide Octopus"]))
_r8_2["Electric Eel"] = (require(script.Configs["Electric Eel"]))
local Megalodon = require(script.Configs.Megalodon)
_r8_2.Megalodon = Megalodon
local Cthulhu = require(script.Configs.Cthulhu)
_r8_2.Cthulhu = Cthulhu
_r8_2["Depths Manta Ray"] = (require(script.Configs["Depths Manta Ray"]))
_r8_2["Depths Spike"] = (require(script.Configs["Depths Spike"]))
_r8_2["Depths Riptide Octopus"] = (require(script.Configs["Depths Riptide Octopus"]))
_r8_2["Depths Electric Eel"] = (require(script.Configs["Depths Electric Eel"]))
_r8_2["Depths Megalodon"] = (require(script.Configs["Depths Megalodon"]))
_r8_2["Depths Cthulhu"] = (require(script.Configs["Depths Cthulhu"]))
_r8_2["Terra Snapper"] = (require(script.Configs["Terra Snapper"]))
_r8_2["Depths Terra Snapper"] = (require(script.Configs["Depths Terra Snapper"]))
local Glyptodon = require(script.Configs.Glyptodon)
_r8_2.Glyptodon = Glyptodon
local Terrorbird = require(script.Configs.Terrorbird)
_r8_2.Terrorbird = Terrorbird
local Megatherium = require(script.Configs.Megatherium)
_r8_2.Megatherium = Megatherium
local Dunkleosteus = require(script.Configs.Dunkleosteus)
_r8_2.Dunkleosteus = Dunkleosteus
local Gigantopithecus = require(script.Configs.Gigantopithecus)
_r8_2.Gigantopithecus = Gigantopithecus
local Sabertooth = require(script.Configs.Sabertooth)
_r8_2.Sabertooth = Sabertooth
_r8_2["Skeletal Glyptodon"] = (require(script.Configs["Skeletal Glyptodon"]))
_r8_2["Skeletal Terrorbird"] = (require(script.Configs["Skeletal Terrorbird"]))
_r8_2["Skeletal Megatherium"] = (require(script.Configs["Skeletal Megatherium"]))
_r8_2["Skeletal Dunkleosteus"] = (require(script.Configs["Skeletal Dunkleosteus"]))
_r8_2["Skeletal Gigantopithecus"] = (require(script.Configs["Skeletal Gigantopithecus"]))
_r8_2["Skeletal Sabertooth"] = (require(script.Configs["Skeletal Sabertooth"]))
_r8_2["Citadel Snail"] = (require(script.Configs["Citadel Snail"]))
_r8_2["Toxic Crocodile"] = (require(script.Configs["Toxic Crocodile"]))
_r8_2["Mecha Chompa"] = (require(script.Configs["Mecha Chompa"]))
_r8_2["Pink Dragon Experiment"] = (require(script.Configs["Pink Dragon Experiment"]))
_r8_2["Eye Bat"] = (require(script.Configs["Eye Bat"]))
_r8_2["Uncoiled Armadillo"] = (require(script.Configs["Uncoiled Armadillo"]))
_r8_2["67"] = (require(script.Configs["67"]))
_r8_2["67 OP"] = (require(script.Configs["67 OP"]))
_r8_2["Toxic Hedgehog"] = (require(script.Configs["Toxic Hedgehog"]))
_r8_2["Toxic Hedgehog OP"] = (require(script.Configs["Toxic Hedgehog OP"]))
local r6 = table.freeze(_r8_2)
local ReplicatedStorage_2 = game:GetService("ReplicatedStorage")
local BalanceConfig = require(ReplicatedStorage_2.Shared.Flags.BalanceConfig)
local EarningRate = { EarningRate = true, IndexSpeedReward = true, DropWeight = true, VisualOdds = true, ModelWeight = true, Egg = { GrowthTime = true, WeightKg = true }, LuckyBlockDropTable = true, LuckyBlockLevelRange = true, LuckyBlockOpenDuration = true }
local r7 = r6
r6 = BalanceConfig.Bind("Game.Balance.Assets", r6, EarningRate, true, function(v2)
	local f1
	local f2
	for _k5, _v6 in ipairs(v2) do
		if not _v6.Egg then continue end
		if 0 < _v6.Egg.GrowthTime then
			f1 = not (0 >= _v6.Egg.WeightKg)
		end
		assert(f1)
	end
	f2 = not (0 >= (0 + (_v6.DropWeight or 0)))
	assert(f2)
end)
local _r8_3 = {}
for _k12, _v13 in ipairs(r6) do
	if _r8_3[_v13.Rarity._id] == nil then
		_r8_3[_v13.Rarity._id] = {}
	end
	_r15[_k12] = _v13
end
for _k12, _v13 in ipairs(_r8_3) do
	table.freeze(_v13)
end
local r8 = table.freeze(_r8_3)
ReplicatedStorage = r6
local function AssetNameExists(v3) -- proto[3], line 379  -- upvalues: ReplicatedStorage
	if ReplicatedStorage[v3] ~= nil then return true end
	return false, (("Asset name \"%*\" does not exist in the Assets directory."):format(v3))
end
local Directory = { Directory = r6, ByRarity = r8, Personalities = PersonalityCatalog, BaseConfig = r5, AssetNameExists = AssetNameExists }
return table.freeze(Directory)