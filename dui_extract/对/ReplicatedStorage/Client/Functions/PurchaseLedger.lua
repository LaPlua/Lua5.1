-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Functions.PurchaseLedger
-- ============================================

-- bytecode
-- Original size: 2420 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 41, Protos: 12, Main proto: 11

-- ============== SOURCE ==============
-- main chunk (proto[11], line 1)
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Products = require(ReplicatedStorage.Data.Products)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local s1 = {}
local OwnedPerProfile = {}
local f1
function OwnedPerProfile.OwnedPerProfile(v1) -- proto[0], line 22  -- upvalues: Save
	local Products
	if (Save.Peek ~= nil) then
		Products = Save.Peek.Products
	else
		Products = nil
	end
	if (type(Products)) ~= "table" then return f1 end
	f1 = not (Products[(tostring(v1))] ~= true)
	return f1
end
function OwnedPerProfile.AwaitingReceipt(v2) -- proto[1], line 28  -- upvalues: s1
	local f2 = not (s1[v2] ~= true)
	return f2
end
function OwnedPerProfile.HasOpenTicket() -- proto[2], line 32  -- upvalues: U0
	local f3 = not (U0 == nil)
	return f3
end
s1 = nil
function OwnedPerProfile.OpenTicket(v3) -- proto[4], line 36  -- upvalues: s1
	local SkuId = { SkuId = v3, Live = true }
	s1 = SkuId
	local s2 = SkuId
	return SkuId
end
function OwnedPerProfile.CloseTicket(v4) -- proto[5], line 48  -- upvalues: s1
	if s1 == nil then return end
	if s1.SkuId ~= v4 then return end
	s1.Live = false
	s1 = nil
end
local s2 = OwnedPerProfile
local function settleReceipt(v5) -- proto[6], line 56  -- upvalues: s1, s2
	s1[v5] = nil
end
local LocalPlayer = Players.LocalPlayer
local function onPromptClosed(v6, v7, v8) -- proto[7], line 61  -- upvalues: LocalPlayer, s2, s1, Products
	if v6 ~= LocalPlayer.UserId then return end
	if v7 == nil then return end
	if not (v8) then
		s1[v7] = nil
		return
	end
	if Products.FromProductId == nil then return end
	if not Products.FromProductId.OneTime then return end
	if s2.OwnedPerProfile then return end
	s1[v7] = true
end
if not (RunService:IsClient()) then return table.freeze(OwnedPerProfile) end
Remotes.Storefront.PurchaseRejected.OnClientEvent:Connect(function(v9)
	s1[v9.ProductId] = nil
end)
Remotes.Storefront.PurchaseSettled.OnClientEvent:Connect(function(v10, v11)
	s1[v11.ProductId] = nil
end)
Remotes.Storefront.ReceiptCleared.OnClientEvent:Connect(function(v12, v13, v14)
	s1[v12] = nil
end)
MarketplaceService.PromptProductPurchaseFinished:Connect(onPromptClosed)
return table.freeze(OwnedPerProfile)