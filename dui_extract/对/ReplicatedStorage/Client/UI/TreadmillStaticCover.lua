-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.TreadmillStaticCover
-- ============================================

-- bytecode
-- Original size: 1251 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 31, Protos: 5, Main proto: 4

-- ============== SOURCE ==============
-- main chunk (proto[4], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local TreadmillVideoController = require(ReplicatedStorage.Shared.TreadmillVideoController)
local Interface = require(ReplicatedStorage.Shared.TreadmillVideoController.Types.Interface)
local r1 = GUI.StaticTreadmillImageSurfaceGui()
assert((r1:IsA("SurfaceGui")), "Static treadmill image GUI must be a SurfaceGui")
local Create = {}
ReplicatedStorage = r1
function Create.Create(v1, v2) -- proto[0], line 23  -- upvalues: ReplicatedStorage
	ReplicatedStorage.Clone.Name = v1
	ReplicatedStorage.Clone.Adornee = v2
	ReplicatedStorage.Clone.Enabled = true
	ReplicatedStorage.Clone.Parent = ReplicatedStorage.Parent
	return ReplicatedStorage.Clone
end
function Create.SetEnabled(v3, v4) -- proto[1], line 35
	v3.Enabled = v4
end
function Create.ApplyMedia(v5, v6) -- proto[2], line 42  -- upvalues: TreadmillVideoController
	v5.VideoFrame.Image.Image = TreadmillVideoController.ResolveCoverImage
	v5.VideoFrame.StopPlay.Image = TreadmillVideoController.GetStoppedIconImage
	v5.VideoFrame.StopPlay.Visible = true
end
local s1 = Create
function Create.ApplyFeed(v7, v8) -- proto[3], line 51  -- upvalues: s1, TreadmillVideoController
	s1.ApplyMedia(v7, TreadmillVideoController.GetCurrentMediaEntry(v8))
end
return Create