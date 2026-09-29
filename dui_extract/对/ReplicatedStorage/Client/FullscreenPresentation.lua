-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.FullscreenPresentation
-- ============================================

-- bytecode
-- Original size: 6283 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 99, Protos: 11, Main proto: 10

-- ============== SOURCE ==============
-- main chunk (proto[10], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local GameAudioMute = require(ReplicatedStorage.Client.GameAudioMute)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Open = {}
local function watchingCFrame(v1, v2) -- proto[0], line 17
	local r1 = math.max(v1.ViewportSize.X, 1)
	local r2 = math.max(v1.ViewportSize.Y, 1)
	local r3 = math.rad(v1.FieldOfView)
	local w1 = (r1 / r2)
	local r4 = math.tan(r3 / 2)
	local w2 = ((math.max(((v2.Size.Y / 2) / r4), (((v2.Size.X / 2) / r4) / w1))) * 1.05)
	return CFrame.lookAt((v2.Position + (v2.CFrame.LookVector * w2)), v2.Position)
end
local LocalPlayer = Players.LocalPlayer
local s1 = nil
function Open.Open(v3, v4, v5) -- proto[9], line 25  -- upvalues: LocalPlayer, Workspace, s1, HiddenUIHandler, Tabs, Signal, watchingCFrame, GameAudioMute, TweenService, UserInputService, RunService
	if s1 then return nil end
	if not LocalPlayer.Character.FindFirstChildOfClass then return nil end
	if not Workspace.CurrentCamera then return nil end
	if not LocalPlayer.FindFirstChildOfClass then return nil end
	if not v3.IsDescendantOf then return nil end
	if not v4.IsDescendantOf then return nil end
	if Workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then return nil end
	if HiddenUIHandler.IsHidden then return nil end
	if Tabs.IsActive then return nil end
	local Closed = {}
	Closed.Closed = Signal.new
	local s2 = {}
	local w3 = (v3 ^ "Character")
	s1 = Closed
	local f1 = false
	local s3 = Closed
	local f2 = nil
	local f3 = nil
	local f4 = true
	local CurrentCamera = Workspace.CurrentCamera
	local CameraSubject = Workspace.CurrentCamera.CameraSubject
	local CFrame = Workspace.CurrentCamera.CFrame
	local Focus = Workspace.CurrentCamera.Focus
	local CameraType = Workspace.CurrentCamera.CameraType
	local f5 = nil
	local f6 = nil
	function Closed.Close() -- proto[1], line 60  -- upvalues: f1, s1, s3, s2, f2, f3, f4, CurrentCamera, Workspace, CameraSubject, CFrame, Focus, CameraType, f5, f6
		if f1 then return end
		f1 = true
		if s1 == s3 then
			s1 = nil
		end
		for _k3, _v4 in ipairs(s2) do
		end
		if f4 and CurrentCamera.Parent and Workspace.CurrentCamera == CurrentCamera and CurrentCamera.CameraType == Enum.CameraType.Scriptable and CurrentCamera.CameraSubject == CameraSubject then
			CurrentCamera.CFrame = CFrame
			CurrentCamera.Focus = Focus
			CurrentCamera.CameraType = CameraType
		end
	end
	function Closed.IsClosed() -- proto[2], line 99  -- upvalues: U0
		return U0
	end
	local s1 = nil
	local Acquire = nil
	local Acquire_2 = nil
	local s4 = nil
	s2 = TweenService
	local watchingCFrame_2 = watchingCFrame
	local v3 = w3
	if xpcall then return Closed end
	return nil
end
return table.freeze(Open)