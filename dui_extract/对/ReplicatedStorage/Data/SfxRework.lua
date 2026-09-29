-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.SfxRework
-- ============================================

-- bytecode
-- Original size: 7651 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 115, Protos: 4, Main proto: 3

-- ============== SOURCE ==============
-- main chunk (proto[3], line 1)
local Jump = { Jump = "rbxassetid://129309431169075", GreetingRun = "rbxassetid://79491420286619", GreetingLove = "rbxassetid://77676139105429" }
local r1 = table.freeze(Jump)
local Jump_2 = { Jump = "rbxassetid://109053220376598", GreetingRun = "rbxassetid://80470347388552", GreetingLove = "rbxassetid://82103733277956" }
local r2 = table.freeze(Jump_2)
local _r4 = {}
local Idle = { Idle = 109084013864839 }
_r4["Alabaster Whale"] = (table.freeze(Idle))
local Walk = { Walk = 85892053481113, Idle = 98648905921986 }
_r4["Alien Skeleton Boss"] = (table.freeze(Walk))
local Walk_2 = { Walk = 87539099304537, Idle = 91147897361155 }
_r4.Ankylosaurus = (table.freeze(Walk_2))
local Walk_3 = { Walk = 85249941990373, Idle = 116162430890513 }
_r4["Ascended Vermilion Phoenix"] = (table.freeze(Walk_3))
local Walk_4 = { Walk = 122588221392543, Idle = 139340174291871 }
_r4["Ash Gecko"] = (table.freeze(Walk_4))
local Walk_5 = { Walk = 95640392463828, Idle = 99271197379717 }
_r4["Baby Aurora Dragon"] = (table.freeze(Walk_5))
local Walk_6 = { Walk = 124578818661623, Idle = 140355694088112 }
_r4["Bananita Dolphinita"] = (table.freeze(Walk_6))
local Idle_2 = { Idle = 81960453819318 }
_r4.Basilisk = (table.freeze(Idle_2))
local Walk_7 = { Walk = 98962076190481, Idle = 127207447045739 }
_r4.Bear = (table.freeze(Walk_7))
local Walk_8 = { Walk = 118667471602135, Idle = 90413578033778 }
_r4["Belula Beluga"] = (table.freeze(Walk_8))
local Walk_9 = { Walk = 97704959570533, Idle = 71126963498892 }
_r4["Bomboclat Crocolat"] = (table.freeze(Walk_9))
local Walk_10 = { Walk = 87512139889151, Idle = 75758812305276 }
_r4.Bronto = (table.freeze(Walk_10))
local Walk_11 = { Walk = 87776860556516, Idle = 113732812225664 }
_r4["Brr Brr Patapim"] = (table.freeze(Walk_11))
local Walk_12 = { Walk = 75259005316072, Idle = 92414641075249 }
_r4["Burrowing Owl"] = (table.freeze(Walk_12))
local Walk_13 = { Walk = 75763741236219 }
_r4.Camel = (table.freeze(Walk_13))
local Idle_3 = { Idle = 87747919169770 }
_r4.Catfish = (table.freeze(Idle_3))
local Walk_14 = { Walk = 139724850248238, Idle = 84365701151321 }
_r4["Cave Dragon"] = (table.freeze(Walk_14))
local Walk_15 = { Walk = 97943735213732 }
_r4.Centapede = (table.freeze(Walk_15))
local Walk_16 = { Walk = 103736662890224, Idle = 112652966180684 }
_r4.Cerberus = (table.freeze(Walk_16))
local Walk_17 = { Walk = 77569052979374 }
_r4.Chicken = (table.freeze(Walk_17))
local Walk_18 = { Walk = 118667471602135, Idle = 104388767547534 }
_r4["Chillin Chilli"] = (table.freeze(Walk_18))
local Walk_19 = { Walk = 102126706547517, Idle = 140380957391871 }
_r4.Chimpanzee = (table.freeze(Walk_19))
local Walk_20 = { Walk = 73924753601037, Idle = 109052627263741 }
_r4["Colossal Mammoth"] = (table.freeze(Walk_20))
local Walk_21 = { Walk = 89415448274930 }
_r4.Crane = (table.freeze(Walk_21))
local Walk_22 = { Walk = 97704959570533, Idle = 71126963498892 }
_r4.Crocodile = (table.freeze(Walk_22))
local Walk_23 = { Walk = 92160997537319, Idle = 104088414306613 }
_r4["Cyclops Gorilla"] = (table.freeze(Walk_23))
local Walk_24 = { Walk = 137682861871003, Idle = 90970709685819 }
_r4.DeathstalkerScorpion = (table.freeze(Walk_24))
local Walk_25 = { Walk = 84310341547585, Idle = 129056410182887 }
_r4.DesertLark = (table.freeze(Walk_25))
local Walk_26 = { Walk = 116675021133679, Idle = 91917802939931 }
_r4.Dodo = (table.freeze(Walk_26))
local Walk_27 = { Walk = 109859077831837 }
_r4.Dog = (table.freeze(Walk_27))
local Walk_28 = { Walk = 85249941990373, Idle = 99271197379717 }
_r4.Dragon = (table.freeze(Walk_28))
local Walk_29 = { Walk = 82252285582806, Idle = 138943450824966 }
_r4["Dream Axolotl"] = (table.freeze(Walk_29))
local Walk_30 = { Walk = 84639143672331, Idle = 87598259027411 }
_r4.Duckling = (table.freeze(Walk_30))
local Idle_4 = { Idle = 88927188226844 }
_r4["El Maja"] = (table.freeze(Idle_4))
local Walk_31 = { Walk = 95640392463828, Idle = 99271197379717 }
_r4["Ember Dragon"] = (table.freeze(Walk_31))
local Walk_32 = { Walk = 71370919924821, Idle = 109543717701603 }
_r4["Eternal Lunar Dragon"] = (table.freeze(Walk_32))
local Walk_33 = { Walk = 75830491774531, Idle = 95694784081534 }
_r4.FennecFox = (table.freeze(Walk_33))
local Idle_5 = { Idle = 92586563973540 }
_r4["Finned Thresher"] = (table.freeze(Idle_5))
local Walk_34 = { Walk = 123565424234895, Idle = 73942787332078 }
_r4["Flaming Bull"] = (table.freeze(Walk_34))
local Walk_35 = { Walk = 98592829152488, Idle = 110446822397054 }
_r4.Frog = (table.freeze(Walk_35))
local Walk_36 = { Walk = 122588221392543, Idle = 139340174291871 }
_r4["Galaxy Gecko"] = (table.freeze(Walk_36))
local Walk_37 = { Walk = 92160997537319, Idle = 104088414306613 }
_r4.Gorilla = (table.freeze(Walk_37))
local Walk_38 = { Walk = 93258675255690, Idle = 77733562549629 }
_r4["Ice Dragon"] = (table.freeze(Walk_38))
local Walk_39 = { Walk = 95217113025089, Idle = 124949844244934 }
_r4.Irihorus = (table.freeze(Walk_39))
local Walk_40 = { Walk = 135431282574136, Idle = 129498646783866 }
_r4.Jerboa = (table.freeze(Walk_40))
local Walk_41 = { Walk = 130410188254836 }
_r4.Kitsune = (table.freeze(Walk_41))
local Walk_42 = { Walk = 91336069879459 }
_r4.Koi = (table.freeze(Walk_42))
local Walk_43 = { Walk = 136575457054802, Idle = 95615102125339 }
_r4.Kraken = (table.freeze(Walk_43))
local Walk_44 = { Walk = 121275249192606, Idle = 124578818661623 }
_r4["La Vacca Saturno Saturnita"] = (table.freeze(Walk_44))
local Walk_45 = { Walk = 132145651741965, Idle = 88149843107998 }
_r4["Lava Iguana"] = (table.freeze(Walk_45))
local Walk_46 = { Walk = 98592829152488, Idle = 110446822397054 }
_r4["Lava frog"] = (table.freeze(Walk_46))
local Walk_47 = { Walk = 73924753601037, Idle = 109052627263741 }
_r4.Mammoth = (table.freeze(Walk_47))
local Walk_48 = { Walk = 118667471602135 }
_r4["Mangolini Parrochini"] = (table.freeze(Walk_48))
local Walk_49 = { Walk = 72733661023288, Idle = 93011701238042 }
_r4["Mire Fox"] = (table.freeze(Walk_49))
local Idle_6 = { Idle = 81960453819318 }
_r4.Mosasaurus = (table.freeze(Idle_6))
local Walk_50 = { Walk = 114350383012530 }
_r4["Oni Tiger"] = (table.freeze(Walk_50))
local Walk_51 = { Walk = 136703842556018, Idle = 119425637805679 }
_r4["Orangutini Ananassini"] = (table.freeze(Walk_51))
local Idle_7 = { Idle = 72265202988047 }
_r4.Orca = (table.freeze(Idle_7))
local Idle_8 = { Idle = 87747919169770 }
_r4.Parrotfish = (table.freeze(Idle_8))
local Walk_52 = { Walk = 118893161321883, Idle = 126342128456953 }
_r4.Penguin = (table.freeze(Walk_52))
local Walk_53 = { Walk = 98962076190481, Idle = 127207447045739 }
_r4["Polar Bear"] = (table.freeze(Walk_53))
local Walk_54 = { Walk = 129027332074939, Idle = 91501424120077 }
_r4.Pterodactyl = (table.freeze(Walk_54))
local Walk_55 = { Walk = 93247766618772, Idle = 99003636968368 }
_r4.Raccoon = (table.freeze(Walk_55))
local Walk_56 = { Walk = 96852920499596, Idle = 86273497689098 }
_r4.Rattlesnake = (table.freeze(Walk_56))
local Walk_57 = { Walk = 80776140827842 }
_r4["Red Panda"] = (table.freeze(Walk_57))
local Walk_58 = { Walk = 106128665613743, Idle = 76228157397099 }
_r4["Sabertooth Tiger"] = (table.freeze(Walk_58))
local Walk_59 = { Walk = 98528087932516 }
_r4.Salamander = (table.freeze(Walk_59))
local Walk_60 = { Walk = 116105360458227, Idle = 108765457146691 }
_r4["Sand Spider"] = (table.freeze(Walk_60))
local Walk_61 = { Walk = 140401695659406, Idle = 99271197379717 }
_r4.ScorchedDragon = (table.freeze(Walk_61))
local Walk_62 = { Walk = 95640392463828, Idle = 99271197379717 }
_r4["Shadow Dragon"] = (table.freeze(Walk_62))
local Walk_63 = { Walk = 96920277869957 }
_r4["Snowy Owl"] = (table.freeze(Walk_63))
local Walk_64 = { Walk = 95492669493151, Idle = 86585082706748 }
_r4.Spider = (table.freeze(Walk_64))
local Walk_65 = { Walk = 86323278444941 }
_r4.Stag = (table.freeze(Walk_65))
local Walk_66 = { Walk = 73924753601037, Idle = 98860262183478 }
_r4["Strawberry Elephant"] = (table.freeze(Walk_66))
local Walk_67 = { Walk = 84639143672331, Idle = 124101960931522 }
_r4.Swan = (table.freeze(Walk_67))
local Idle_9 = { Idle = 72092807529166 }
_r4.Swordfish = (table.freeze(Idle_9))
local Walk_68 = { Walk = 106128665613743, Idle = 76228157397099 }
_r4.Tiger = (table.freeze(Walk_68))
local Walk_69 = { Walk = 132784244995896, Idle = 103713074753122 }
_r4["Tob Tobi Tob Tob"] = (table.freeze(Walk_69))
local Walk_70 = { Walk = 84310341547585 }
_r4.Toucan = (table.freeze(Walk_70))
local Walk_71 = { Walk = 111656068182484, Idle = (table.freeze({85318836335134, 119220966165422})) }
_r4.Tralaledon = (table.freeze(Walk_71))
local Walk_72 = { Walk = 114321426046280, Idle = 89022502511741 }
_r4.Triceratops = (table.freeze(Walk_72))
local Idle_10 = { Idle = 89324287675790 }
_r4["Trulimero Trulicina"] = (table.freeze(Idle_10))
local Walk_73 = { Walk = 87776860556516, Idle = 127535170649609 }
_r4["Tung Tung Sahur"] = (table.freeze(Walk_73))
local Walk_74 = { Walk = 96543613394996 }
_r4.Turtle = (table.freeze(Walk_74))
local Walk_75 = { Walk = 86392397661742, Idle = (table.freeze({88194339648259, 106670433570032})) }
_r4.TyrannosaurusRex = (table.freeze(Walk_75))
local Walk_76 = { Walk = 93124590164789, Idle = 116297838397212 }
_r4.Unicorn = (table.freeze(Walk_76))
local Walk_77 = { Walk = 95640392463828, Idle = 99271197379717 }
_r4["Void Dragon"] = (table.freeze(Walk_77))
local Walk_78 = { Walk = 110863031812081 }
_r4.Walrus = (table.freeze(Walk_78))
local Walk_79 = { Walk = 96852920499596, Idle = 86273497689098 }
_r4.Warden = (table.freeze(Walk_79))
local Idle_11 = { Idle = 109084013864839 }
_r4["Whale Shark"] = (table.freeze(Idle_11))
local Walk_80 = { Walk = 86923272173832, Idle = 140562418935008 }
_r4.Yeti = (table.freeze(Walk_80))
local r3 = table.freeze(_r4)
local Kitsune = {}
Kitsune.Kitsune = true
Kitsune["Snowy Owl"] = true
Kitsune.Koi = true
Kitsune.Salamander = true
Kitsune["Oni Tiger"] = true
Kitsune.Stag = true
Kitsune["Red Panda"] = true
Kitsune["Baby Aurora Dragon"] = true
Kitsune["Shadow Dragon"] = true
Kitsune["Ember Dragon"] = true
Kitsune["Void Dragon"] = true
Kitsune.ScorchedDragon = true
local r4 = table.freeze(Kitsune)
local Crane = {}
Crane.Crane = 84639143672331
local r5 = table.freeze(Crane)
local NewAnimalSfx = { NewAnimalSfx = true, NewCherryBlossomSfx = true, GuardFootstepLegacy = "rbxassetid://85892053481113", GuardFootstepNew = "rbxassetid://114350383012530" }
local function withId(v1, v2) -- proto[0], line 148
	if v2 == nil then return nil end
	if v1 == nil then return nil end
	if v2 == v1.SoundId then return v1 end
	local Data = {}
	Data.Data = v1.Data
	Data.SoundId = v2
	return table.freeze(Data)
end
local s1 = NewAnimalSfx
function NewAnimalSfx.Global(v3) -- proto[1], line 162  -- upvalues: s1, r1, r2
	if not s1.NewAnimalSfx then return r2[v3] end
	return r2[v3]
end
r1 = r3
r2 = r4
local r6 = r5
function NewAnimalSfx.Resolve(v4, v5, v6) -- proto[2], line 167  -- upvalues: s1, r1, r2, r6
	local Data
	local v1_e
	if v4 == nil then return v6 end
	if not (s1.NewAnimalSfx) then
		if (r1[v4]) then
			v1_e = v1_e[v5]
		else
			v1_e = nil
		end
		if not ((v1_e == nil) or (v6 == nil)) then
			if not ((v1_e == v6.SoundId)) then
				Data = {}
				Data.Data = v6.Data
				Data.SoundId = v1_e
			end
		end
	end
	if s1.NewCherryBlossomSfx then return table.freeze end
	if v5 ~= "Walk" then return table.freeze end
	if r2[v4] then return nil end
	if r6[v4] == nil then return table.freeze end
	if r6[v4] == nil then return nil end
	if v6 == nil then return nil end
	r6 = v6.SoundId
	if r6[v4] == r6 then return v6 end
	local w1 = r6[v4]
	local Data_2 = { Data = v6.Data, SoundId = w1 }
	return table.freeze
end
return NewAnimalSfx