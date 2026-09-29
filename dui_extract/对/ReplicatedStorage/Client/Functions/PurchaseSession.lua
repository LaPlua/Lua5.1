-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Functions.PurchaseSession
-- ============================================

-- bytecode
-- Original size: 6949 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 102, Protos: 20, Main proto: 19

-- ============== SOURCE ==============
-- main chunk (proto[19], line 1)
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CashPacks = require(ReplicatedStorage.Data.CashPacks)
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local Gamepasses = require(ReplicatedStorage.Data.Gamepasses)
local PurchaseLedger = require(ReplicatedStorage.Client.Functions.PurchaseLedger)
local Products = require(ReplicatedStorage.Data.Products)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Busy = { Busy = "Wrap up the purchase window that's already open before starting another one.", Disabled = "Purchases are paused for a moment while Roblox catches up. Please try again shortly.", Owned = "You already own this!", Pending = "Roblox is still confirming your last attempt to buy this. If it never arrives, rejoin and it will sync.", Screened = "This item isn't available to buy right now.", Settled = "This one-time item already went through on your account. Rejoin if it hasn't shown up yet.", Unavailable = "The shop couldn't open that purchase. Please try again in a moment.", UnknownSku = "We couldn't find that item in the shop. If this keeps happening, let our support team know." }
local Owned = { Owned = true }
local Silent = { Silent = true }
local _r14 = {}
local function refusal(v1, v2) -- proto[0], line 50
	local Refusal = { Refusal = v1, Note = v2 }
	return Refusal
end
local s1 = Busy
local s2 = Owned
local function refuse(v3, v4) -- proto[1], line 54  -- upvalues: ReplicatedStorage, s1, s2
	local v_u1
	if not (v4) then
		v_u1 = s1[v3]
	end
	if s2[v3] then
		return
	end
end
local function chime() -- proto[2], line 64  -- upvalues: ReplicatedStorage
	local PlaybackSpeed = { PlaybackSpeed = 1.3, Volume = 0.6 }
end
local function askServer(v5, v6) -- proto[4], line 73
	local f1
	local function anon3() -- proto[3], line 74  -- upvalues: v5, v6
		return v5:InvokeServer(v6)
	end
	if pcall then
		f1 = not (anon3 ~= true)
	end
	if not pcall then return f1, nil end
	if (type(R4)) ~= "string" then return f1, nil end
	return f1, R4
end
local function storefrontOpen(v7) -- proto[5], line 83  -- upvalues: GameFlags
	if GameFlags.StorefrontOpen.Get then return nil end
	local Refusal = { Refusal = "Disabled", Note = nil }
	return Refusal
end
local function knownSku(v8) -- proto[6], line 87
	if v8.Config ~= nil then return nil end
	local Refusal = { Refusal = "UnknownSku", Note = nil }
	return Refusal
end
local function configVeto(v9) -- proto[7], line 91
	local _r6
	local Refusal
	if v9.Config.Precheck == nil then return nil end
	if not (pcall) then
		local v_u2 = v9.Config.Precheck
		local r1 = ("purchase precheck raised an error: %*"):format(v_u2)
		Refusal = { Refusal = "Screened", Note = nil }
		return Refusal
	end
	if v9.Config.Precheck == true then return nil end
	if ((type(R4)) == "string") then
		_r6 = R4
	else
		_r6 = nil
	end
	local Refusal_2 = { Refusal = "Screened", Note = _r6 }
	return Refusal_2
end
local function playCue(v10) -- proto[8], line 107  -- upvalues: ReplicatedStorage
	local PlaybackSpeed = { PlaybackSpeed = 1.3, Volume = 0.6 }
	return nil
end
local function noOpenPrompt(v11) -- proto[9], line 114  -- upvalues: PurchaseLedger
	if not PurchaseLedger.HasOpenTicket then return nil end
	local Refusal = { Refusal = "Busy", Note = nil }
	return Refusal
end
local function oneTimeNotRepeated(v12) -- proto[10], line 118  -- upvalues: GameFlags, PurchaseLedger
	local Refusal
	if not v12.Config.OneTime then return nil end
	if not (GameFlags.OneTimeRepeatGuard.Get) then return nil end
	if PurchaseLedger.OwnedPerProfile then
		Refusal = { Refusal = "Settled", Note = nil }
		return Refusal
	end
	if not PurchaseLedger.AwaitingReceipt then return nil end
	local Refusal_2 = { Refusal = "Pending", Note = nil }
	return Refusal_2
end
local data = Silent
local function serverApproves(v13) -- proto[11], line 130  -- upvalues: PurchaseLedger, CashPacks, Remotes, data
	local _r3 = nil
	local f2
	v13.Ticket = PurchaseLedger.OpenTicket
	local v_u1 = v13.SkuId
	if CashPacks.FindSlot then return nil end
	local v13 = Remotes.Storefront.AskServerProbe
	local arg1 = v13.SkuId
	local function anon3() -- proto[3], line 74  -- upvalues: v13, arg1
		return v13:InvokeServer(arg1)
	end
	if pcall then
		f2 = not (anon3 ~= true)
	end
	if pcall then
		if (type(R8)) == "string" then
			v_u1 = R8
		end
	end
	if not (PurchaseLedger.OpenTicket.Live) then return data end
	if f2 then return nil end
	local Refusal = { Refusal = "Unavailable", Note = _r3 }
	return Refusal
end
local function promptFromClient(v14) -- proto[12], line 148  -- upvalues: MarketplaceService, LocalPlayer, data, PurchaseLedger
	if pcall then return data end
	if not (v14.Ticket.Live) then return data end
	local Refusal = { Refusal = "Unavailable", Note = nil }
	return Refusal
end
local function promptFromServer(v15) -- proto[13], line 163  -- upvalues: Remotes, data, PurchaseLedger
	local _r3
	local f2
	local v15 = Remotes.Storefront.AskPurchaseOffer
	local arg1 = v15.SkuId
	local function anon3() -- proto[3], line 74  -- upvalues: v15, arg1
		return v15:InvokeServer(arg1)
	end
	if pcall then
		f2 = not (anon3 ~= true)
	end
	if pcall then
		if (type(R8)) == "string" then
			_r3 = R8
		end
		_r3 = nil
	end
	if not (v15.Ticket.Live) then return data end
	if f2 then return nil end
	local Refusal = { Refusal = "Unavailable", Note = _r3 }
	do return Refusal end
	local v15
end
local function openProductPrompt(v16) -- proto[14], line 177  -- upvalues: CashPacks, GameFlags, Remotes, data, PurchaseLedger, MarketplaceService, LocalPlayer
	local f3
	local _r4
	local Refusal
	if CashPacks.FindSlot == nil then
		v16 = Remotes.Storefront.AskPurchaseOffer
		local arg1 = v16.SkuId
		local function anon3() -- proto[3], line 74  -- upvalues: v16, arg1
			return v16:InvokeServer(arg1)
		end
		if pcall then
			f3 = not (anon3 ~= true)
		end
		if pcall then
			if (type(R9)) == "string" then
				_r4 = R9
			end
			_r4 = nil
		end
		if not (v16.Ticket.Live) then return data end
		if f3 then return nil end
		Refusal = { Refusal = "Unavailable", Note = _r4 }
		return Refusal
	end
	MarketplaceService = MarketplaceService.PromptProductPurchase
	local w1 = v16.Ticket
	if pcall then return data end
	if not (w1.Live) then return data end
	PurchaseLedger = PurchaseLedger.CloseTicket
	local Refusal_2 = { Refusal = "Unavailable", Note = nil }
	return Refusal_2
end
local function passNotOwned(v17) -- proto[15], line 189  -- upvalues: ReplicatedStorage
	if not require.Owns then return nil end
	local Refusal = { Refusal = "Owned", Note = nil }
	return Refusal
end
local function openPassPrompt(v18) -- proto[16], line 194  -- upvalues: MarketplaceService, LocalPlayer
	return nil
end
local _r31 = {storefrontOpen, knownSku, noOpenPrompt, oneTimeNotRepeated, configVeto, serverApproves, playCue, openProductPrompt}
local _r32 = {storefrontOpen, knownSku, passNotOwned, configVeto, playCue, openPassPrompt}
local function run(v19, v20) -- proto[17], line 221  -- upvalues: ReplicatedStorage, s1, s2
	local v_u3
	for _k5, _v6 in ipairs(v19) do
		if _v6 == nil then continue end
		if _v6.Refusal == nil then return end
		if not (_v6.Note) then
			v_u3 = s1[_v6.Refusal]
		end
		if s2[_v6.Refusal] then
			return
		end
		return
	end
end
function _r14.Request(v21, v22) -- proto[18], line 234  -- upvalues: RunService, run, U2, Products, U4, Gamepasses
	local SkuId
	local f3
	assert(RunService.IsClient, "purchases are requested from the client")
	f3 = not ((type(v21)) ~= "number")
	assert(f3, "PurchaseSession.Request needs a numeric SKU id")
	if v22 then
		SkuId = { SkuId = v21, Config = Products.FromProductId, Ticket = nil }
		return
	end
	local SkuId_2 = { SkuId = v21, Config = Gamepasses.FromProductId, Ticket = nil }
end
return table.freeze(_r14)