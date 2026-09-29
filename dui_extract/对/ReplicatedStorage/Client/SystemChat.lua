-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.SystemChat
-- ============================================

-- bytecode
-- Original size: 1547 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 36, Protos: 6, Main proto: 5

-- ============== SOURCE ==============
-- main chunk (proto[5], line 1)
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Post = {}
local TextChannel = Instance.new("TextChannel")
TextChannel.Name = "GameSystem"
TextChannel.Parent = TextChatService
local function markup(v1) -- proto[0], line 22
	if v1.Color == nil then return v1.Text end
	return (("<font color=\"#%*\">%*</font>"):format(v1.Color.ToHex, v1.Text))
end
local function metadata(v2) -- proto[1], line 32  -- upvalues: HttpService
	if v2.Rarity == nil then return "" end
	local rarity = {}
	rarity.rarity = v2.Rarity
	return HttpService:JSONEncode(rarity)
end
local function accept(v3) -- proto[2], line 41
	local Rarity
	if (typeof(v3)) ~= "table" then return nil end
	if (typeof(v3.Text)) ~= "string" then return nil end
	local Text = {}
	local v_u1 = v3.Text
	Text.Text = v_u1
	if ((typeof(v3.Color)) == "Color3") then
		v_u1 = v3.Color
	else
		v_u1 = nil
	end
	Text.Color = v_u1
	if ((typeof(v3.Rarity)) == "string") then
		v_u1 = v3.Rarity
	else
		Rarity = nil
	end
	Text.Rarity = Rarity
	return Text
end
function Post.Post(v4) -- proto[3], line 54  -- upvalues: TextChannel, metadata
	local r1
	if not ((v4.Color == nil)) then
		r1 = ("<font color=\"#%*\">%*</font>"):format(v4.Color.ToHex, v4.Text)
	end
	TextChannel:DisplaySystemMessage(r1, metadata(v4))
end
local s1 = Post
Remotes.ChatFeed.Post.OnClientEvent:Connect(function(v5)
	if accept == nil then return end
end)
return table.freeze(Post)