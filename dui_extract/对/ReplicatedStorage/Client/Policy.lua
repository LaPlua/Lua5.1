-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Policy
-- ============================================

-- bytecode
-- Original size: 1536 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 31, Protos: 7, Main proto: 6

-- ============== SOURCE ==============
-- main chunk (proto[6], line 1)
local Players = game:GetService("Players")
local PolicyService = game:GetService("PolicyService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
local Signal = require(ReplicatedStorage.Packages.Signal)
local r1 = Log.new()
local function Get() -- proto[0], line 42  -- upvalues: U0
	return U0
end
local function IsLoaded() -- proto[1], line 46  -- upvalues: U0
	local f1 = not (U0 == nil)
	return f1
end
local Loaded = { Loaded = (Signal.new()), Get = Get, IsLoaded = IsLoaded }
local s1 = Loaded
function Loaded.GetAsync() -- proto[2], line 50  -- upvalues: U0, s1
	if U0 == nil then return s1.Loaded:Wait() end
	return U0
end
local function IsEndlessContentLoadAllowed() -- proto[3], line 59  -- upvalues: s1
	local f2
	if s1 == nil then return false end
	f2 = not (s1.IsEndlessContentLoadAllowed == false)
	return f2
end
Loaded.IsEndlessContentLoadAllowed = IsEndlessContentLoadAllowed
local freeze = nil
ReplicatedStorage = r1
task.spawn(function()
	local v_u1 = 0
	while true do
		if freeze ~= nil then return end
		local function anon4() -- proto[4], line 74  -- upvalues: PolicyService, Players
			return PolicyService:GetPolicyInfoForPlayerAsync(Players.LocalPlayer)
		end
		if pcall then
			if (type(anon4)) == "table" then
				freeze = table.freeze
				return
			end
		end
		local r2 = ("Failed to fetch local player policy info (attempt %*): %*"):format((v_u1 + 1), anon4)
		v_u1 = v_u1 ^ "pcall"
		v_u2 = v_u1 - 1
		v_u3 = ("Failed to fetch local player policy info (attempt %*): %*") * 2
		local r3 = math.min(v_u3, 30)
	end
end)
return Loaded