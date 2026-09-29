-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.EggState
-- ============================================

-- bytecode
-- Original size: 16639 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 192, Protos: 54, Main proto: 53

-- ============== SOURCE ==============
local function apply(v1) -- proto[42], line 413  -- upvalues: index, s1, s2, s3, ownedRows
	local index
	index = (index + 1)
	s1[v1.OwnerUserId] = index
	s2[v1.OwnerUserId] = nil
end
local function apply(v2) -- proto[43], line 422  -- upvalues: index, s4, s5, TableUtil, s3
	local index
	index = (index + 1)
	s4[v2.Uid] = index
	s5[v2.Uid] = TableUtil.Copy
end
local function apply(v3) -- proto[45], line 432  -- upvalues: index, s4, s5, s3
	local index
	index = (index + 1)
	s4[v3] = index
	s5[v3] = nil
end
local function apply(v4) -- proto[46], line 442  -- upvalues: index, s4, s5, TableUtil, s3, fieldRows
	local index
	for _k4, _v5 in ipairs do
		index = (index + 1)
		s4[_v5] = index
		s5[_v5] = nil
	end
	for _k4, _v5 in ipairs do
		index = (index + 1)
		s4[_v5.Uid] = index
		s5[_v5.Uid] = TableUtil.Copy
	end
end
local function apply(v5) -- proto[47], line 458  -- upvalues: s6, TableUtil, s3, twin
	local s6
	s6 = TableUtil.Copy
	s3.CarryChanged:Fire(twin(s6))
end
local function apply(v6) -- proto[48], line 467  -- upvalues: ReplicatedStorage, LocalPlayer, Workspace, s3
	local Stage = { Stage = "CLIENT_FEEDBACK_RECEIVED", UserId = LocalPlayer.UserId, ServerTime = Workspace.GetServerTimeNow, AssetCategory = v6.AssetCategory, DisplayName = v6.DisplayName }
end
local function apply(v7) -- proto[49], line 482  -- upvalues: s3
end
local function apply(v8) -- proto[50], line 488  -- upvalues: s3
end
-- main chunk (proto[53], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local AreaEggs = require(ReplicatedStorage.Shared.Types.AreaEggs)
local Log = require(ReplicatedStorage.Packages.Log)
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local AreaEggResetCycle = require(ReplicatedStorage.Shared.Types.AreaEggResetCycle)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Promise = require(ReplicatedStorage.Packages.Promise)
local OnboardingTiming = require(ReplicatedStorage.Shared.Util.OnboardingTiming)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local t = require(ReplicatedStorage.Packages.t)
local SnapshotRefreshed = { SnapshotRefreshed = (Signal.new()), OwnerRefreshed = (Signal.new()), OwnerCleared = (Signal.new()), FieldRefreshed = (Signal.new()), FieldShifted = (Signal.new()), FieldGone = (Signal.new()), CarryChanged = (Signal.new()), FieldClaimed = (Signal.new()), ResetCountdown = (Signal.new()), RarityRevealed = (Signal.new()), RarityPresented = (Signal.new()), ResetFade = (Signal.new()) }
local r1 = t.strict(t.string)
local r2 = t.strict(t.number)
local r3 = t.strict(t.boolean)
local r4 = t.strict(t.optional(t.string))
local r5 = t.strict(t.CFrame)
local r6 = Log.new()
local s2 = {}
local s5 = {}
local s1 = {}
local s4 = {}
local s7 = {}
local IsCarrying = { IsCarrying = false }
local function twin(v9) -- proto[0], line 77  -- upvalues: TableUtil
	return TableUtil.Copy(v9, true)
end
local index = 0
local function stampOwner(v10) -- proto[1], line 79  -- upvalues: index, s1
	index = (index + 1)
	s1[v10] = index
end
local function stampField(v11) -- proto[2], line 84  -- upvalues: index, s4
	index = (index + 1)
	s4[v11] = index
end
local function ownedRows() -- proto[3], line 89  -- upvalues: s2, TableUtil
	local _r0 = {}
	for _k4, _v5 in ipairs(s2) do
		local OwnerUserId = { OwnerUserId = _k4, Records = TableUtil.Copy }
		table.insert(_r0, OwnerUserId)
	end
	return _r0
end
local function fieldRows() -- proto[4], line 97  -- upvalues: s5, twin, Workspace
	local _r0 = {}
	for _k4, _v5 in ipairs(s5) do
		table.insert(_r0, twin(_v5))
	end
	local Records = { Records = _r0, ServerTime = Workspace.GetServerTimeNow }
	return Records
end
local s3 = SnapshotRefreshed
local function tellOwned() -- proto[5], line 105  -- upvalues: s3, ownedRows
end
local function tellField() -- proto[6], line 107  -- upvalues: s3, fieldRows
end
local function dropOwner(v12) -- proto[7], line 109  -- upvalues: s2, s3, ownedRows
	s2[v12] = nil
end
local function adoptOwned(v13, v14) -- proto[8], line 115  -- upvalues: s2, s1, TableUtil, s3, ownedRows
	local _r2 = {}
	for _k6, _v7 in ipairs(s2) do
		_r2[_k6] = nil
	end
	for _k6, _v7 in ipairs do
		local v_u1 = s1[_v7.OwnerUserId]
		local f1 = false  -- skip 1
		f1 = true
		if f1 then
			v_u1 = TableUtil.Copy
		else
			v_u1 = _r2[_v7.OwnerUserId]
		end
		_r2[_v7.OwnerUserId] = v_u1
	end
	s2 = _r2
end
local function adoptField(v15, v16) -- proto[9], line 129  -- upvalues: s5, s4, TableUtil, s3, fieldRows
	local _r2 = {}
	for _k6, _v7 in ipairs(s5) do
		_r2[_k6] = nil
	end
	for _k6, _v7 in ipairs do
		local v_u1 = s4[_v7.Uid]
		local f1 = false  -- skip 1
		f1 = true
		if f1 then
			v_u1 = TableUtil.Copy
		else
			v_u1 = _r2[_v7.Uid]
		end
		_r2[_v7.Uid] = v_u1
	end
	s5 = _r2
end
ReplicatedStorage = r6
local keepAsking = <closure K50>
local function keepAsking(v17, v18) -- proto[10], line 143  -- upvalues: ReplicatedStorage, keepAsking
	if pcall then return end
	local r7 = ("%* never landed, going round again: %*"):format(v17, v18)
end
local function outcome(v19, v20) -- proto[11], line 154
	local f2 = not (v19 ~= true)
	if (typeof(v20)) ~= "string" then return f2, nil end
	return f2, v20
end
local string = r1
Remotes = Remotes.EggWorld
function SnapshotRefreshed.FetchEggRecord(v21) -- proto[12], line 158  -- upvalues: string, Remotes, Eggs, twin, ReplicatedStorage
	if Remotes.AskEggRecord.InvokeServer == nil then return nil end
	if Eggs.SchemaValidation.SavedEgg then return twin(Remotes.AskEggRecord.InvokeServer) end
	local r7 = ("the egg record for %* came back malformed: %*"):format(v21, Remotes.AskEggRecord.InvokeServer)
	return nil
end
function SnapshotRefreshed.SyncOwnedEggs() -- proto[13], line 175  -- upvalues: index, Remotes, Eggs, adoptOwned, ownedRows
	assert(Eggs.SchemaValidation.RuntimeEggSnapshot, (("the owned egg snapshot failed validation: %*"):format(Remotes.AskLiveSnapshot.InvokeServer)))
	return ownedRows
end
local f3 = false
function SnapshotRefreshed.SyncFieldEggs() -- proto[18], line 185  -- upvalues: U0, index, Promise, Remotes, AreaEggs, f3, adoptField, OnboardingTiming, fieldRows
	local U0
	local andThen
	if U0 == nil then
		U0 = (Promise.try.timeout).andThen
		andThen = (Promise.try.timeout).andThen
		-- anon17 captures:
	end
	if not ((((Promise.try.timeout).andThen ^ "try")).await) then
		local _r4 = tostring((((Promise.try.timeout).andThen ^ "try")))
	end
	return fieldRows
end
local boolean = r3
function SnapshotRefreshed.FetchRarityShows() -- proto[19], line 214  -- upvalues: Remotes, boolean, AreaEggResetCycle
	local f2
	if (Remotes.AskFieldEggRarityShows.InvokeServer ~= true) or (Remotes.AskFieldEggRarityShows == nil) then
		f2 = not (Remotes.AskFieldEggRarityShows.InvokeServer ~= true)
		return f2, nil
	end
	assert(AreaEggResetCycle.SchemaValidation.RevealPayload, (("the rare spawn reveal payload failed validation: %*"):format(Remotes.AskFieldEggRarityShows)))
	return true, Remotes.AskFieldEggRarityShows
end
function SnapshotRefreshed.WearEggTool(v23) -- proto[20], line 226  -- upvalues: string, outcome, Remotes
	return outcome(Remotes.AskWearTool:InvokeServer(v23))
end
function SnapshotRefreshed.DoffEggTool(v24) -- proto[21], line 231  -- upvalues: ReplicatedStorage, outcome, Remotes
	return outcome(Remotes.AskDoffTool:InvokeServer(v24))
end
function SnapshotRefreshed.CarryFieldEgg(v25, v26) -- proto[22], line 236  -- upvalues: string, ReplicatedStorage, outcome, Remotes
	local Uid = { Uid = v25, FirstAreaSlotKey = v26 }
	return outcome(Remotes.AskFieldEggCarry:InvokeServer(Uid))
end
function SnapshotRefreshed.DropFieldEgg(v27) -- proto[23], line 244  -- upvalues: AreaEggs, outcome, Remotes
	local v_u2
	if v27 ~= nil then
		v_u2 = AreaEggs.SchemaValidation.DropReason
	end
	assert(v_u2, v27)
	local Reason = {}
	Reason.Reason = v27
	return outcome(Remotes.AskFieldEggDrop:InvokeServer(Reason))
end
local CFrame = r5
function SnapshotRefreshed.PlantEgg(v28, v29) -- proto[24], line 250  -- upvalues: string, CFrame, s7, Remotes
	local AskPlaceEgg
	local f4
	s7[v28] = true
	local Uid = { Uid = v28, LocalCFrame = v29 }
	f4 = not (Remotes.AskPlaceEgg.InvokeServer ~= true)
	if ((typeof(Remotes.AskPlaceEgg)) == "string") then
		AskPlaceEgg = Remotes.AskPlaceEgg
	else
		AskPlaceEgg = nil
	end
	if f4 == true then return f4, AskPlaceEgg end
	s7[v28] = nil
	return f4, AskPlaceEgg
end
function SnapshotRefreshed.TakePlantCue(v30) -- proto[25], line 267  -- upvalues: string, s7
	local f5 = not (s7[v30] ~= true)
	s7[v30] = nil
	return f5
end
local v_u2
function SnapshotRefreshed.BeginSkipGrowth(v31) -- proto[26], line 275  -- upvalues: string, Remotes, U2, ReplicatedStorage
	local U2
	local AskSkipGrowth
	if Remotes.AskSkipGrowth.InvokeServer ~= true then
		if ((typeof(Remotes.AskSkipGrowth)) == "string") then
			AskSkipGrowth = Remotes.AskSkipGrowth
		else
			AskSkipGrowth = nil
		end
		return false, AskSkipGrowth, (nil)
	end
	if ((typeof(v31)) == "number") then
		v_u2 = v31
	else
		v_u2 = nil
	end
	if v_u2 ~= nil then
		U2 = v31
		return true, nil, v_u2
	end
	return false, "Invalid skip growth product", nil
end
function SnapshotRefreshed.BeginHatch(v32) -- proto[27], line 293  -- upvalues: string, Remotes
	local AskHatch
	local f6 = not (Remotes.AskHatch.InvokeServer ~= true)
	if ((typeof(Remotes.AskHatch)) == "string") then
		AskHatch = Remotes.AskHatch
	else
		AskHatch = nil
	end
	if (typeof(v32)) ~= "string" then return f6, AskHatch, nil end
	return f6, AskHatch, v32
end
function SnapshotRefreshed.FinishHatch(v33) -- proto[28], line 302  -- upvalues: string, Remotes, ReplicatedStorage
	local AskFinishHatch
	if Remotes.AskFinishHatch.InvokeServer ~= true then
		if ((typeof(Remotes.AskFinishHatch)) == "string") then
			AskFinishHatch = Remotes.AskFinishHatch
		else
			AskFinishHatch = nil
		end
		return false, AskFinishHatch, (nil)
	end
	if ((typeof(v33)) == "string") then
		v_u2 = v33
	else
		v_u2 = nil
	end
	if v_u2 ~= nil then return true, nil, v_u2 end
	return false, "Invalid granted asset UID", nil
end
function SnapshotRefreshed.ReadChosenSkipUid() -- proto[29], line 319  -- upvalues: U0
	return U0
end
function SnapshotRefreshed.ForgetChosenSkip() -- proto[30], line 321  -- upvalues: U0
	local U0
	U0 = nil
end
function SnapshotRefreshed.ReadOwnedEggs() -- proto[31], line 323  -- upvalues: ownedRows
	return ownedRows
end
function SnapshotRefreshed.ReadFieldEggs() -- proto[32], line 325  -- upvalues: fieldRows
	return fieldRows
end
function SnapshotRefreshed.HasFieldSnapshot() -- proto[33], line 327  -- upvalues: U0
	return U0
end
local s6 = IsCarrying
function SnapshotRefreshed.ReadCarryState() -- proto[34], line 329  -- upvalues: twin, s6
	return twin(s6)
end
local number = r2
function SnapshotRefreshed.ReadOwnerEggs(v34) -- proto[35], line 331  -- upvalues: number, s2, TableUtil
	if s2[v34] ~= nil then
		return TableUtil.Copy
	end
	return {}
end
function SnapshotRefreshed.ReadOwnedEgg(v35, v36) -- proto[36], line 338  -- upvalues: number, string, s2, TableUtil
	local v1_e
	if (s2[v35] ~= nil) then
		v1_e = s2[v35][v36]
	else
		v1_e = nil
	end
	if v1_e == nil then return nil end
	return TableUtil.Copy
end
function SnapshotRefreshed.ReadFieldEgg(v37) -- proto[37], line 347  -- upvalues: string, s5, TableUtil
	if s5[v37] == nil then return nil end
	return TableUtil.Copy
end
local LocalPlayer = Players.LocalPlayer
function SnapshotRefreshed.IsReadyToHatch(v38) -- proto[38], line 354  -- upvalues: string, s3, LocalPlayer, Workspace, EggRecords
	if s3.ReadOwnedEgg == nil then return false end
	if s3.ReadOwnedEgg.Placement == nil then return false end
	return EggRecords.IsGrown(s3.ReadOwnedEgg, Workspace.GetServerTimeNow, s3.ReadOwnedEgg.GrowthSpeedMultiplier, EggRecords.CurrentNightCredit, LocalPlayer)
end
function SnapshotRefreshed.MayBuyChosenSkip() -- proto[39], line 368  -- upvalues: f3, s3, LocalPlayer
	if not (f3) then return false, "No egg selected" end
	if s3.ReadOwnedEgg ~= nil then
		if s3.ReadOwnedEgg.Placement == nil then return false, "Egg not placed" end
		if not s3.IsReadyToHatch then return true end
		return false, "Egg is already ready"
	end
end
function SnapshotRefreshed.MayBuyGrowAll() -- proto[40], line 386  -- upvalues: s2, LocalPlayer, s3
	local v1_e = s2[LocalPlayer.UserId]
	for _k4, _v5 in ipairs(s2[LocalPlayer.UserId] or {}) do
		if _v5.Placement == nil then continue end
		if not (s3.IsReadyToHatch) then return true end
	end
	return false, "You have no growing eggs!"
end
local _r46 = {}
local function apply(v39) -- proto[41], line 402  -- upvalues: index, s1, s2, TableUtil, s3, ownedRows
	index = (index + 1)
	s1[v39.OwnerUserId] = index
	s2[v39.OwnerUserId] = TableUtil.Copy
	s3.OwnerRefreshed:Fire(v39.OwnerUserId, s3.ReadOwnerEggs(v39.OwnerUserId))
end
local feed = { feed = Remotes.EggWorld.OwnerShifted, vet = Eggs.SchemaValidation.RuntimeEggOwnerUpdate, complaint = "an owned egg write turned up malformed", apply = apply }
-- apply captures: index, s1, s2, s3, ownedRows
local feed_2 = { feed = Remotes.EggWorld.OwnerDropped, vet = Eggs.SchemaValidation.RuntimeEggOwnerClear, complaint = "an owned egg erase turned up malformed", apply = apply }
-- apply captures: index, s4, s5, TableUtil, s3
local feed_3 = { feed = Remotes.EggWorld.FieldEggShifted, vet = AreaEggs.SchemaValidation.AreaEggRecord, complaint = "a field egg write turned up malformed", apply = apply }
local function vet(v40) -- proto[44], line 430
	local f5 = not ((typeof(v40)) ~= "string")
	return f5, "expected a uid string"
end
-- apply captures: index, s4, s5, s3
local feed_4 = { feed = Remotes.EggWorld.FieldEggGone, vet = vet, complaint = "a field egg removal turned up malformed", apply = apply }
-- apply captures: index, s4, s5, TableUtil, s3, fieldRows
local feed_5 = { feed = Remotes.EggWorld.FieldEggBatchShifted, vet = AreaEggs.SchemaValidation.AreaEggBatchUpdate, complaint = "a field egg batch turned up malformed", apply = apply }
-- apply captures: s6, TableUtil, s3, twin
local feed_6 = { feed = Remotes.EggWorld.FieldEggCarry, vet = AreaEggs.SchemaValidation.AreaEggCarryState, complaint = "a field egg carry state turned up malformed", apply = apply }
-- apply captures: ReplicatedStorage, LocalPlayer, Workspace, s3
local feed_7 = { feed = Remotes.EggWorld.FieldEggRedeemVerdict, vet = AreaEggs.SchemaValidation.AreaEggClaimFeedback, complaint = "a field egg claim verdict turned up malformed", apply = apply }
-- apply captures: s3
local feed_8 = { feed = Remotes.EggWorld.FieldEggCycleCountdown, vet = AreaEggResetCycle.SchemaValidation.SequencePayload, complaint = "a field egg reset sequence turned up malformed", apply = apply }
-- apply captures: s3
local feed_9 = { feed = Remotes.EggWorld.FieldEggRaritiesShown, vet = AreaEggResetCycle.SchemaValidation.RevealPayload, complaint = "a field egg rarity reveal turned up malformed", apply = apply }
_r46[1], _r46[2], _r46[3], _r46[4], _r46[5], _r46[6], _r46[7], _r46[8], _r46[9] = feed, feed_2, feed_3, feed_4, feed_5, feed_6, feed_7, feed_8, feed_9
for _k50, _v51 in ipairs(_r46) do
	_v51.feed.OnClientEvent:Connect(function(v41)
		if _v51.vet then
			return
		end
		local r7 = ("%*: %*"):format(_v51.complaint, v41)
	end)
end
Players.PlayerRemoving:Connect(function(v42)
	index = (index + 1)
	s1[v42.UserId] = index
	s2[v42.UserId] = nil
end)
task.spawn(keepAsking, "the owned egg snapshot", SnapshotRefreshed.SyncOwnedEggs)
task.spawn(keepAsking, "the field egg snapshot", SnapshotRefreshed.SyncFieldEggs)
return SnapshotRefreshed