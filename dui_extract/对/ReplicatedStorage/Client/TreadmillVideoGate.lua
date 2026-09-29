-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.TreadmillVideoGate
-- ============================================

-- bytecode
-- Original size: 996 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 22, Protos: 3, Main proto: 2

-- ============== SOURCE ==============
-- main chunk (proto[2], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Policy = require(ReplicatedStorage.Client.Policy)
local Signal = require(ReplicatedStorage.Packages.Signal)
local TreadmillFlags = require(ReplicatedStorage.Shared.Flags.TreadmillFlags)
local function IsVideoPlayerDisabled() -- proto[0], line 22  -- upvalues: TreadmillFlags, Policy
	if TreadmillFlags.VideoPlayerDisabled.Get then return true end
	if not (TreadmillFlags.PolicyServiceVideoEnabled.Get) then return false end
	return (not Policy.IsEndlessContentLoadAllowed)
end
local Changed = { Changed = (Signal.new()), IsVideoPlayerDisabled = IsVideoPlayerDisabled }
local r1 = Changed.IsVideoPlayerDisabled()
local s1 = Changed
local function update() -- proto[1], line 38  -- upvalues: s1, r1
	if s1.IsVideoPlayerDisabled == r1 then return end
	r1 = s1.IsVideoPlayerDisabled
end
TreadmillFlags.VideoPlayerDisabled.Changed:Connect(update)
TreadmillFlags.PolicyServiceVideoEnabled.Changed:Connect(update)
Policy.Loaded:Connect(update)
return Changed