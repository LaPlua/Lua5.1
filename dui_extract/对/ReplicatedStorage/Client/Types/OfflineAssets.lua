-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Types.OfflineAssets
-- ============================================

-- bytecode
-- Original size: 660 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 20, Protos: 1, Main proto: 0

-- ============== SOURCE ==============
-- main chunk (proto[0], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local AwardedAmount = { AwardedAmount = t.number, BaseAmount = t.number, ClaimedByUid = (t.map(t.string, t.number)) }
local ClaimableAmount = { ClaimableAmount = t.number, IsMultiplierPurchasePending = t.boolean, ReservedAmount = t.number, TotalAmount = t.number }
local OfflineRedeemResult = { OfflineRedeemResult = (t.interface(AwardedAmount)), OfflineClaimSummary = (t.interface(ClaimableAmount)) }
return OfflineRedeemResult