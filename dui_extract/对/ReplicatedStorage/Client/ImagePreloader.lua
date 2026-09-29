-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.ImagePreloader
-- ============================================

-- bytecode
-- Original size: 1795 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 32, Protos: 6, Main proto: 5

-- ============== SOURCE ==============
-- main chunk (proto[5], line 1)
local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
local t = require(ReplicatedStorage.Packages.t)
local r1 = t.strict(t.string)
local r2 = t.strict(t.table)
local s1 = {}
local s2 = {}
local r3 = Log.new()
local Request = {}
ReplicatedStorage = r3
local function preload(v1) -- proto[2], line 33  -- upvalues: ContentProvider, s1, s2, ReplicatedStorage
	local v_u1
	local v_u2
	for _i = 1, 3 do
		if pcall then
			if ContentProvider.GetAssetFetchStatus == Enum.AssetFetchStatus.Success then
				s1[v1] = true
				v_u2 = nil
				s2[v1] = v_u2
				return
			end
			v_u1 = (tostring(ContentProvider.GetAssetFetchStatus))
			if ContentProvider.GetAssetFetchStatus ~= Enum.AssetFetchStatus.TimedOut then
				break
			else
				v_u1 = tostring(function()
					local _r2 = {v1}

				end)
			end
		end
		if _i >= 3 then continue end
		v_u2 = _i * 0.5
	end
	s2[v1] = nil
	local r4 = ("Failed to preload image %*: %*"):format(v1, v_u1)
end
local string = r1
function Request.Request(v4) -- proto[3], line 76  -- upvalues: string, s1, s2, ContentProvider, preload
	if v4 == "" then return false end
	if s1[v4] then return false end
	if s2[v4] then return false end
	if ContentProvider.GetAssetFetchStatus == Enum.AssetFetchStatus.Success then
		s1[v4] = true
		return false
	end
	s2[v4] = true
	return true
end
local table = r2
local s3 = Request
function Request.RequestAll(v5) -- proto[4], line 92  -- upvalues: table, s3
	for _k5, _v6 in ipairs(v5) do
		if not s3.Request then continue end
	end
	return (0 + 1)
end
return table.freeze(Request)