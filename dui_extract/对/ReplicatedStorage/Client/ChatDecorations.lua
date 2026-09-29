-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.ChatDecorations
-- ============================================

-- bytecode
-- Original size: 3751 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 74, Protos: 9, Main proto: 8

-- ============== SOURCE ==============
-- main chunk (proto[8], line 1)
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local Rarity = require(ReplicatedStorage.Data.Rarity)
local Staff = require(ReplicatedStorage.Shared.Modules.Staff)
local r1 = Color3.fromHex("FFC700")
local r2 = Color3.new(1, 1, 1)
local Divine = { Divine = true, Eternal = true, Secret = true }
local _r9 = {}
local function tinted(v1, v2) -- proto[0], line 27
	return (("<font color=\"#%*\">%*</font>"):format(v2.ToHex, v1))
end
local function freshProperties() -- proto[1], line 31  -- upvalues: TextChatService
	return TextChatService.ChatWindowConfiguration:DeriveNewMessageProperties()
end
local function badgesFor(v3) -- proto[2], line 36  -- upvalues: Players, Staff, r1
	local _r1 = {}
	if nil == nil then return _r1 end
	local r3 = typeof((nil).GetAttribute)
	if Staff.ChatTag ~= nil then
		table.insert(_r1, Staff.ChatTag)
	end
	if (nil).GetAttribute ~= nil then return _r1 end
	if (nil).GetAttribute ~= true then return _r1 end
	table.insert(_r1, (("<font color=\"#%*\">[VIP-OG]</font>"):format(r1.ToHex)))
	return _r1
end
local function speakerName(v4) -- proto[3], line 55  -- upvalues: Players
	if nil == nil then return nil end
	if (typeof(nil)) ~= "string" then return nil end
	return string.gsub
end
local function rarityIn(v5) -- proto[4], line 68  -- upvalues: HttpService
	if v5 == "" then return nil end
	if not pcall then return nil end
	if (typeof(HttpService.JSONDecode)) ~= "table" then return nil end
	return HttpService.JSONDecode.rarity
end
local s1 = Divine
local function shineFor(v6) -- proto[5], line 76  -- upvalues: HttpService, s1, Rarity
	local rarity
	local v1_e
	if v6 == "" then
	else
		local v_u2 = v6
		if pcall then
			if (typeof(HttpService.JSONDecode)) == "table" then
				rarity = HttpService.JSONDecode.rarity
			end
			rarity = nil
		end
	end
	if (rarity ~= nil) and (s1[rarity]) then
		v1_e = Rarity.Rarities[rarity]
	else
		v1_e = nil
	end
	if v1_e == nil then return nil end
	return v1_e.RarityGradient
end
local function decorate(v7) -- proto[7], line 82  -- upvalues: badgesFor, HttpService, s1, Rarity, speakerName, TextChatService, r2
	local rarity
	local v1_e
	local RarityGradient
	local w1
	local r4
	if v7.Metadata == "" then
	else
		if pcall then
			if (typeof(HttpService.JSONDecode)) == "table" then
				rarity = HttpService.JSONDecode.rarity
			end
			rarity = nil
		end
	end
	if (rarity ~= nil) and (s1[rarity]) then
		v1_e = Rarity.Rarities[rarity]
	else
		v1_e = nil
	end
	if (v1_e ~= nil) then
		RarityGradient = v1_e.RarityGradient
	else
		RarityGradient = nil
	end
	if RarityGradient == nil then
		if (#badgesFor) <= 0 then
			if speakerName == nil then return nil end
			local TextChatService_2 = TextChatService.ChatWindowConfiguration
			w1 = TextChatService_2.DeriveNewMessageProperties
			if (0 < (#badgesFor)) then
				local badgesFor_2 = speakerName
				local r5 = ("%* %*"):format(table.concat, (speakerName or (v7 ^ "TextSource").PrefixText))
			end
		else
			local speakerName_2 = speakerName
		end
		w1.PrefixText = (speakerName or (v7 ^ "TextSource").PrefixText)
		return w1
	end
	w1 = (v7 ^ "TextSource").Text
	if 0 < (#badgesFor) then
		r4 = ("%* %*"):format(table.concat, string.gsub)
	end
	TextChatService = TextChatService.ChatWindowConfiguration
	local w2 = TextChatService.DeriveNewMessageProperties
	w2.TextColor3 = r2
	TextChatService.ChatWindowConfiguration.DeriveNewMessageProperties.PrefixText = r4
	TextChatService.ChatWindowConfiguration.DeriveNewMessageProperties.PrefixTextProperties = w2
	TextChatService.ChatWindowConfiguration.DeriveNewMessageProperties.Text = "!"
	TextChatService.ChatWindowConfiguration.DeriveNewMessageProperties.TextColor3 = r2
	RarityGradient.Clone.Parent = w2
	((v7 ^ "TextSource") * (v7 ^ "TextSource")).ChatWindowMessageProperties = TextChatService.ChatWindowConfiguration.DeriveNewMessageProperties
	local w3 = RarityGradient.Clone
	local Clone = w3
	return TextChatService.ChatWindowConfiguration.DeriveNewMessageProperties
end
TextChatService.OnIncomingMessage = decorate
return table.freeze(_r9)