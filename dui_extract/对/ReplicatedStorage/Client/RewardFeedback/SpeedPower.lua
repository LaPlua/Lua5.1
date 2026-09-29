-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.RewardFeedback.SpeedPower
-- ============================================

-- bytecode
-- Original size: 1253 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 36, Protos: 3, Main proto: 2

-- ============== SOURCE ==============
-- main chunk (proto[2], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Reward = require(ReplicatedStorage.Client.Notifications.Reward)
local Rain = require(ReplicatedStorage.Client.UI.VFX.Rain)
local _r3 = {0.9, 1.1}
local function showerRecipe() -- proto[0], line 15  -- upvalues: U0
	local Volume = { Volume = 1.3, PlaybackSpeed = U0, Sounds = {"rbxassetid://78590382571227"} }
	local SizeMultiplier = { SizeMultiplier = 3, Texture = "rbxassetid://78137530993637" }
	local Ambience = { Ambience = Volume, Sheets = {SizeMultiplier}, Seconds = 1 }
	return Ambience
end
local r1 = table.freeze((showerRecipe()))
local Announce = {}
function Announce.Announce(v1) -- proto[1], line 36  -- upvalues: Rain, r1, Reward
	local f1
	if (type(v1)) == "number" then
		f1 = not (0 >= v1)
	end
	assert(f1, "a speed power announcement needs a positive amount")
	local Item = {}
	local Amount = { Amount = (math.round(v1)), Kind = "SpeedPower" }
	Item.Item = Amount
end
return Announce