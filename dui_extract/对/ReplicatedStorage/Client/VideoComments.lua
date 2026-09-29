-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.VideoComments
-- ============================================

-- bytecode
-- Original size: 9423 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 102, Protos: 17, Main proto: 16

-- ============== SOURCE ==============
-- main chunk (proto[16], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TreadmillFlags = require(ReplicatedStorage.Shared.Flags.TreadmillFlags)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local TreadmillMediaComments = require(ReplicatedStorage.Shared.Types.TreadmillMediaComments)
local Log = require(ReplicatedStorage.Packages.Log)
local RecommendationSignals = require(ReplicatedStorage.Shared.TreadmillVideoController.RecommendationSignals)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Signal = require(ReplicatedStorage.Packages.Signal)
local TreadmillMediaCommentsConfig = require(ReplicatedStorage.Shared.Modules.TreadmillMediaCommentsConfig)
local t = require(ReplicatedStorage.Packages.t)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local Interface = require(script.Types.Interface)
local r1 = Log.new()
local s1 = {}
local s2 = {}
local s3 = {}
local CommentCountChanged = {}
CommentCountChanged.CommentCountChanged = (Signal.new())
local function getInvokeError(v1) -- proto[0], line 49
	if (typeof(v1)) ~= "string" then return "RequestFailed" end
	return v1
end
local s4 = CommentCountChanged
local function setCachedCommentCount(v2, v3) -- proto[1], line 57  -- upvalues: s1, s4
	local r2 = math.max(0, (math.floor(v3)))
	if s1[v2] ~= nil then
		r2 = math.max(s1[v2], r2)
	end
	if s1[v2] == r2 then return end
	s1[v2] = r2
end
local function refreshCommentCountCache() -- proto[2], line 71  -- upvalues: s2, s3, s4, s1
	for _k3, _v4 in ipairs(s2) do
		local _r5 = {}
		for _k9, _v10 in ipairs(_v4) do
			_r5[_v10] = (s3[_v10] or 0)
		end
		if not (s4.RequestCommentCounts.Ok) then return "failed" end
		if not (s4.RequestCommentCounts.Loaded) then return "unloaded" end
		for _k10, _v11 in ipairs(s4.RequestCommentCounts.CountsByMediaKey) do
			if (s3[_k10] or 0) ~= _r5[_k10] then continue end
			local r2 = math.max(0, (math.floor(_v11)))
			if s1[_k10] ~= nil then
				r2 = math.max(s1[_k10], r2)
			end
			if not ((s1[_k10] == r2)) then
				s1[_k10] = r2
			end
		end
	end
	return "loaded"
end
local f1 = false
local f2 = false
local function startCommentCountRefreshLoop() -- proto[4], line 100  -- upvalues: f1, TreadmillFlags, refreshCommentCountCache, f2
	local function anon3() -- proto[3], line 101  -- upvalues: f1, TreadmillFlags, refreshCommentCountCache, f2
		while true do
			if not f1 then return end
			if not (TreadmillFlags.CommentsDisabled.Get) then
				if refreshCommentCountCache == "loaded" then
					f2 = true
				end
			end
		end
	end
end
function CommentCountChanged.StartCommentCountCache(v4) -- proto[5], line 123  -- upvalues: t, f1, TreadmillMediaCommentsConfig, s2, TreadmillFlags, refreshCommentCountCache, f2
	local _r2_2
	if f1 then return end
	f1 = true
	local _r1 = {}
	local _r2 = {}
	for _k6, _v7 in ipairs(v4) do
		local v_u2 = _v7
		if _r1[_v7] then continue end
		_r1[_v7] = true
		table.insert(_r2, _v7)
		local w1 = (#_r2)
		if TreadmillMediaCommentsConfig.COMMENT_COUNT_KEYS_PER_REQUEST > w1 then continue end
		table.insert(s2, _r2)
		_r2_2 = {}
	end
	if 0 < (#_r2_2) then
		table.insert(s2, _r2_2)
	end
	local function anon3() -- proto[3], line 101  -- upvalues: f1, TreadmillFlags, refreshCommentCountCache, f2
		while true do
			if not f1 then return end
			if not (TreadmillFlags.CommentsDisabled.Get) then
				if refreshCommentCountCache == "loaded" then
					f2 = true
				end
			end
		end
	end
end
function CommentCountChanged.GetCachedCommentCount(v5) -- proto[6], line 153  -- upvalues: t, s1
	return s1[v5]
end
function CommentCountChanged.ReconcileCommentCount(v6, v7) -- proto[7], line 158  -- upvalues: t, s3, s1, s4
	local v_u1 = s3[v6]
	s3[v6] = ((v_u1 or 0) + 1)
	local r2 = math.max(0, (math.floor(v7)))
	if s1[v6] ~= nil then
		r2 = math.max(s1[v6], r2)
	end
	if s1[v6] == r2 then return end
	s1[v6] = r2
end
ReplicatedStorage = r1
TreadmillMediaComments = TreadmillMediaComments.Schema
function CommentCountChanged.RequestCommentPage(v8, v9, v10) -- proto[9], line 167  -- upvalues: TreadmillFlags, t, TryCall, Remotes, ReplicatedStorage, TreadmillMediaComments
	local Error
	if TreadmillFlags.CommentsDisabled.Get then
		Error = { Ok = false, Error = "CommentsDisabled" }
		return Error
	end
	local r3 = t.strict(t.optional(t.number))
	local r4 = t.strict(t.optional(t.number))
	local v8 = (v8 ^ "CommentsDisabled")
	local function anon8() -- proto[8], line 180  -- upvalues: Remotes, v8, v9, v10
		local MediaKey = { MediaKey = v8, Cursor = v9, PageSize = v10 }
		return Remotes.Treadmill.AskReplyPage:InvokeServer(MediaKey)
	end
	if not (TryCall) then
		local r5 = ("Failed treadmill comment page request: %*"):format(anon8)
		local r6 = typeof(anon8)
		local Error_2 = { Ok = false, Error = "RequestFailed" }
		return Error_2
	end
	if not (TreadmillMediaComments.CommentPageResult) then
		local Error_3 = { Ok = false, Error = "InvalidResponse" }
		return Error_3
	end
	if not (anon8.Ok) then
		local Error_4 = { Ok = false, Error = (anon8.Error or "RequestFailed") }
		return Error_4
	end
	local TotalCreatedCount = { Ok = true, TotalCreatedCount = nil, Comments = nil, NextCursor = nil }
	TotalCreatedCount.TotalCreatedCount = (anon8.TotalCreatedCount or 0)
	TotalCreatedCount.Comments = (v10.Comments or {})
	TotalCreatedCount.NextCursor = anon8.NextCursor
	return TotalCreatedCount
end
function CommentCountChanged.RequestCommentCounts(v11) -- proto[11], line 212  -- upvalues: TreadmillFlags, t, TryCall, Remotes, ReplicatedStorage, TreadmillMediaComments
	local CountsByMediaKey
	local f3
	local Error
	if TreadmillFlags.CommentsDisabled.Get then
		Error = { Ok = false, Error = "CommentsDisabled", CountsByMediaKey = {}, Loaded = false, Stale = true }
		return Error
	end
	local function anon10() -- proto[10], line 219  -- upvalues: Remotes, v11
		local MediaKeys = {}
		MediaKeys.MediaKeys = v11
		return Remotes.Treadmill.AskReplyCounts:InvokeServer(MediaKeys)
	end
	if not (TryCall) then
		local r5 = ("Failed treadmill comment counts request: %*"):format(anon10)
		local r6 = typeof(anon10)
		CountsByMediaKey = { Ok = false, CountsByMediaKey = {}, Loaded = false, Stale = true, Error = "RequestFailed" }
		return CountsByMediaKey
	end
	if not (TreadmillMediaComments.CommentCountsResult) then
		local CountsByMediaKey_2 = { Ok = false, CountsByMediaKey = {}, Loaded = false, Stale = true, Error = "InvalidResponse" }
		return CountsByMediaKey_2
	end
	if not (anon10.Ok) then
		local CountsByMediaKey_3 = { Ok = false, CountsByMediaKey = nil, Loaded = nil, Stale = nil, Error = nil }
		CountsByMediaKey_3.CountsByMediaKey = {}
		f3 = not (anon10.Loaded ~= true)
		CountsByMediaKey_3.Loaded = f3
		f3 = not (anon10.Stale == false)
		CountsByMediaKey_3.Stale = f3
		CountsByMediaKey_3.Error = (anon10.Error or "RequestFailed")
		return CountsByMediaKey_3
	end
	local CountsByMediaKey_4 = { Ok = true, CountsByMediaKey = nil, Loaded = nil, Stale = nil }
	CountsByMediaKey = anon10.CountsByMediaKey
	CountsByMediaKey_4.CountsByMediaKey = (v11.CountsByMediaKey or {})
	f3 = not (anon10.Loaded ~= true)
	CountsByMediaKey_4.Loaded = f3
	f3 = not (anon10.Stale ~= true)
	CountsByMediaKey_4.Stale = f3
	return CountsByMediaKey_4
end
function CommentCountChanged.PostComment(v12, v13, v14) -- proto[13], line 267  -- upvalues: TreadmillFlags, t, TryCall, Remotes, ReplicatedStorage, TreadmillMediaComments, RecommendationSignals
	local f4
	local Error
	if TreadmillFlags.CommentsDisabled.Get then
		Error = { Ok = false, Error = "CommentsDisabled" }
		return Error
	end
	local r3 = t.strict(t.optional(t.number))
	local v12 = (v12 ^ "CommentsDisabled")
	local function anon12() -- proto[12], line 280  -- upvalues: Remotes, v12, v13, v14
		local MediaKey = { MediaKey = v12, Message = v13, ImageAssetId = v14 }
		return Remotes.Treadmill.AskPostReply:InvokeServer(MediaKey)
	end
	if not (TryCall) then
		local r5 = ("Failed treadmill post comment request: %*"):format(anon12)
		local r6 = typeof(anon12)
		local Error_2 = { Ok = false, Error = "RequestFailed" }
		return Error_2
	end
	if not (TreadmillMediaComments.PostCommentResult) then
		local Error_3 = { Ok = false, Error = "InvalidResponse" }
		return Error_3
	end
	if not anon12.Ok or (anon12.Comment == nil) then
		local Error_4 = { Ok = false, Error = (anon12.Error or "RequestFailed") }
		return Error_4
	end
	local Comment = { Ok = true, Comment = nil, Pending = nil }
	local v_u3 = anon12.Comment
	Comment.Comment = v_u3
	f4 = not (anon12.Pending ~= true)
	Comment.Pending = f4
	return Comment
end
function CommentCountChanged.SetCommentLike(v15, v16, v17) -- proto[15], line 313  -- upvalues: TreadmillFlags, t, TryCall, Remotes, ReplicatedStorage, TreadmillMediaComments
	local f4
	local Error
	if TreadmillFlags.CommentsDisabled.Get then
		Error = { Ok = false, Error = "CommentsDisabled", CommentId = v16 }
		return Error
	end
	local v15 = (v15 ^ "CommentsDisabled")
	local function anon14() -- proto[14], line 326  -- upvalues: Remotes, v15, v16, v17
		local MediaKey = { MediaKey = v15, CommentId = v16, Liked = v17 }
		return Remotes.Treadmill.AskReplyFavour:InvokeServer(MediaKey)
	end
	if not (TryCall) then
		local r5 = ("Failed treadmill comment like request: %*"):format(anon14)
		local r6 = typeof(anon14)
		local Error_2 = { Ok = false, Error = "RequestFailed", CommentId = v16, LikeCount = nil }
		return Error_2
	end
	if not (TreadmillMediaComments.SetCommentLikeResult) then
		local Error_3 = { Ok = false, Error = "InvalidResponse", CommentId = v16, LikeCount = nil }
		return Error_3
	end
	if not (anon14.Ok) then
		local Error_4 = { Ok = false, Error = (anon14.Error or "RequestFailed"), CommentId = anon14.CommentId, LikeCount = anon14.LikeCount }
		return Error_4
	end
	local CommentId = { Ok = true, CommentId = nil, Liked = nil, Delta = nil, LikeCount = nil }
	local v_u3 = anon14.CommentId
	CommentId.CommentId = v_u3
	f4 = not (anon14.Liked ~= true)
	CommentId.Liked = f4
	CommentId.Delta = (anon14.Delta or 0)
	CommentId.LikeCount = (anon14.LikeCount or 0)
	return CommentId
end
return CommentCountChanged