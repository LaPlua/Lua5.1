-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.AssetRoster
-- ============================================

-- bytecode
-- Original size: 5373 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 85, Protos: 21, Main proto: 20

-- ============== SOURCE ==============
local function apply(v1) -- proto[17], line 158  -- upvalues: s1, s2
	s1[v1.OwnerUserId] = nil
end
-- main chunk (proto[20], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetRuntime = require(ReplicatedStorage.Shared.Types.AssetRuntime)
local Log = require(ReplicatedStorage.Packages.Log)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Signal = require(ReplicatedStorage.Packages.Signal)
local SnapshotRefreshed = { SnapshotRefreshed = (Signal.new()), OwnerRefreshed = (Signal.new()), OwnerCleared = (Signal.new()), PenAreaChanged = (Signal.new()) }
local r1 = Log.new()
local s1 = {}
local s3 = {}
local function copyContents(v2) -- proto[0], line 47
	local _r1 = {}
	for _k5, _v6 in ipairs(v2) do
		table.clone.Mutations = table.clone
		local OwnerUserId = {}
		OwnerUserId.OwnerUserId = _v6.OwnerUserId
		OwnerUserId.UID = _v6.UID
		OwnerUserId.ItemData = table.clone
		OwnerUserId.MoneyPerSecond = _v6.MoneyPerSecond
		OwnerUserId.Seed = _v6.Seed
		OwnerUserId.IsFirstPlacement = _v6.IsFirstPlacement
		_r1[_k5] = OwnerUserId
	end
	return _r1
end
local function everyPen() -- proto[1], line 64  -- upvalues: s1, copyContents
	local _r0 = {}
	for _k4, _v5 in ipairs(s1) do
		local OwnerUserId = { OwnerUserId = _k4, Records = copyContents }
		table.insert(_r0, OwnerUserId)
	end
	return _r0
end
local s2 = SnapshotRefreshed
local function announce() -- proto[2], line 72  -- upvalues: s2, everyPen
end
local function adopt(v3, v4) -- proto[3], line 74  -- upvalues: s1, s3, copyContents, s2, everyPen
	local _r2 = {}
	for _k6, _v7 in ipairs(s1) do
		_r2[_k6] = nil
	end
	for _k6, _v7 in ipairs do
		local copyContents_2 = s3[_v7.OwnerUserId]
		local f1 = false  -- skip 1
		f1 = true
		if not (f1) then
			copyContents_2 = _r2[_v7.OwnerUserId]
		end
		_r2[_v7.OwnerUserId] = copyContents_2
	end
	s1 = _r2
end
local index = 0
Remotes = Remotes.PenRoster
ReplicatedStorage = r1
local function pullUntilAnswered() -- proto[5], line 89  -- upvalues: index, Remotes, AssetRuntime, adopt, ReplicatedStorage, pullUntilAnswered
	local v_u1
	local function anon4() -- proto[4], line 91  -- upvalues: Remotes
		return Remotes.AskLiveSnapshot:InvokeServer()
	end
	if not (pcall) then
		local _r4 = tostring(anon4)
	end
	if pcall then
		v_u1 = AssetRuntime.SchemaValidation.RuntimeAssetSnapshot
	end
	if v_u1 then
		return
	end
	local r2 = ("pen roster snapshot never landed, going round again: %*"):format(anon4)
end
local function outcome(v5, v6) -- proto[6], line 107
	local f2 = not (v5 ~= true)
	if (typeof(v6)) ~= "string" then return f2, nil end
	return f2, v6
end
local function confirmed(v7) -- proto[7], line 111
	local f3 = not (v7.InvokeServer ~= true)
	return f3
end
function SnapshotRefreshed.WearAsset(v8) -- proto[8], line 113  -- upvalues: Remotes
	local AskWear
	local f4 = not (Remotes.AskWear.InvokeServer ~= true)
	if ((typeof(Remotes.AskWear)) == "string") then
		AskWear = Remotes.AskWear
	else
		AskWear = nil
	end
	if (typeof(v8)) ~= "string" then return f4, AskWear, nil end
	return f4, AskWear, v8
end
function SnapshotRefreshed.DoffAsset(v9) -- proto[9], line 119  -- upvalues: outcome, Remotes
	return outcome(Remotes.AskDoff:InvokeServer(v9))
end
function SnapshotRefreshed.ReadWearLimit() -- proto[10], line 123  -- upvalues: Remotes
	if (typeof(Remotes.AskWearLimit.InvokeServer)) ~= "number" then return 0 end
	return Remotes.AskWearLimit.InvokeServer
end
function SnapshotRefreshed.AckPetsBadge() -- proto[11], line 128  -- upvalues: Remotes
	local f5 = not (Remotes.ConfirmPetsBadge.InvokeServer ~= true)
	return f5
end
function SnapshotRefreshed.AckEquipBestBadge() -- proto[12], line 130  -- upvalues: Remotes
	local f5 = not (Remotes.ConfirmEquipBestBadge.InvokeServer ~= true)
	return f5
end
function SnapshotRefreshed.ReadSnapshot() -- proto[13], line 132  -- upvalues: everyPen
	return everyPen
end
function SnapshotRefreshed.ReadOwnerPen(v10) -- proto[14], line 134  -- upvalues: s1, copyContents
	if s1[v10] ~= nil then
		return copyContents
	end
	return {}
end
function SnapshotRefreshed.FindPenArea(v11) -- proto[15], line 139  -- upvalues: PlotState
	if PlotState.ResolvePlot == nil then return nil end
	return PlotState.ResolvePlot.PetArea
end
local _r20 = {}
local function apply(v12) -- proto[16], line 149  -- upvalues: s1, copyContents, s2
	s1[v12.OwnerUserId] = copyContents
end
local feed = { feed = Remotes.PenRoster.OwnerShifted, vet = AssetRuntime.SchemaValidation.RuntimeAssetOwnerUpdate, complaint = "pen roster owner write turned away", apply = apply }
-- apply captures: s1, s2
local feed_2 = { feed = Remotes.PenRoster.OwnerDropped, vet = AssetRuntime.SchemaValidation.RuntimeAssetOwnerClear, complaint = "pen roster owner erase turned away", apply = apply }
_r20[1], _r20[2] = feed, feed_2
for _k24, _v25 in ipairs(_r20) do
	_v25.feed.OnClientEvent:Connect(function(v13)
		if not (_v25.vet) then
			local r2 = ("%*: %*"):format(_v25.complaint, v13)
			return
		end
		index = (index + 1)
		s3[v13.OwnerUserId] = index
	end)
end
PlotState.PlotChanged:Connect(function(v14, v15)
	if nil == nil then return end
	s2.PenAreaChanged:Fire(nil, s2.FindPenArea(nil))
end)
task.spawn(pullUntilAnswered)
return SnapshotRefreshed