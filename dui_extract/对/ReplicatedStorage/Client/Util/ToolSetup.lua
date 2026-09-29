-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Util.ToolSetup
-- ============================================

-- bytecode
-- Original size: 1691 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 39, Protos: 8, Main proto: 7

-- ============== SOURCE ==============
-- main chunk (proto[7], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ToolCooldown = require(ReplicatedStorage.Shared.Util.ToolCooldown)
local ToolSession = require(ReplicatedStorage.Client.Util.ToolSession)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local r1 = t.strict(t.array(t.string))
local Attach = {}
ReplicatedStorage = r1
local LocalPlayer = Players.LocalPlayer
function Attach.Attach(v1, v2) -- proto[5], line 24  -- upvalues: ReplicatedStorage, Trove, LocalPlayer, ToolSession
	if ((type(v1)) == "string") then
		local _r2 = {v1}
	end
	local accepts = { accepts = v1, hooks = (v2 or {}), spawns = Trove.new, grip = nil, held = nil }
	local ToolSession = accepts
	accepts.spawns:Add(LocalPlayer.CharacterAdded:Connect(function(v3)
	end))
	local GetCurrentTool = {}
	function GetCurrentTool.GetCurrentTool() -- proto[1], line 41  -- upvalues: ToolSession
		return ToolSession.held
	end
	function GetCurrentTool.GetCurrentToolGearName() -- proto[2], line 42  -- upvalues: ToolSession, ToolSession
		return ToolSession.GearNameOf(ToolSession.held)
	end
	function GetCurrentTool.IsActive() -- proto[3], line 43  -- upvalues: ToolSession
		local f1 = not (ToolSession.held == nil)
		return f1
	end
	function GetCurrentTool.Cleanup() -- proto[4], line 44  -- upvalues: ToolSession, ToolSession
	end
	return GetCurrentTool
end
function Attach.ApplyCooldown(v4, v5) -- proto[6], line 48  -- upvalues: ToolCooldown
	if not v4.GetCurrentTool then return end
	local w1 = v4.GetCurrentTool
	if not w1.Parent then return end
end
return Attach