-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.WorldFX.TutorialBeam
-- ============================================

-- bytecode
-- Original size: 4247 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 76, Protos: 10, Main proto: 9

-- ============== SOURCE ==============
-- main chunk (proto[9], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local stockName = { stockName = "TutorialBeam", anchorPin = "TutorialBeamTargetAttachment", followerPin = "TutorialBeamPlayerAttachment", rootPart = "HumanoidRootPart", rootPartTimeout = 5, drifterProperties = { Anchored = true, CanCollide = false, Name = "TutorialBeamContainer", Size = Vector3.new(1, 1, 1), Transparency = 1 }, beamProperties = { Enabled = false, FaceCamera = true } }
local Retarget = {}
local function dress(v1, v2) -- proto[0], line 51
	for _k5, _v6 in ipairs(v2) do
		v1[_k5] = _v6
	end
	return v1
end
local function demandAnchor(v3, v4) -- proto[1], line 58
	local r1 = ("%* needs a BasePart or a Vector3"):format(v4)
	local w1 = v3.IsA
	assert(w1, r1)
end
local s1 = stockName
local function pinTo(v5, v6) -- proto[2], line 64  -- upvalues: s1
	Instance.new.Name = s1.anchorPin
	if (typeof(v5)) ~= "Vector3" then
		Instance.new.Parent = v5
		return Instance.new, nil
	end
	for _k8, _v9 in ipairs(s1.drifterProperties) do
		Instance.new[_k8] = _v9
	end
	Instance.new.Position = v5
	Instance.new.Parent = workspace
	Instance.new.Parent = Instance.new
	return Instance.new, Instance.new
end
local function rideCharacter(v7) -- proto[3], line 82  -- upvalues: s1
	if nil ~= nil then
		v7.beam.Enabled = false
		return
	end
	Instance.new.Name = s1.followerPin
	Instance.new.Parent = nil
	local w2 = v7.pins
	local w1 = v7.scope.Add
	w2.follower = w1
	(v7 ^ "owner").beam.Attachment0 = Instance.new
	(v7 ^ "owner").beam.Enabled = true
end
function Retarget.Retarget(v8, v9) -- proto[4], line 105  -- upvalues: t, pinTo
	local w2 = v8.pins
	assert(v9.IsA, "beam retarget needs a BasePart or a Vector3")
	if (typeof(v9)) == "Vector3" and v8.pins.drifter ~= nil then
		v8.pins.drifter.Position = v9
		return
	end
	if v9 == v8.pins.anchor.Parent then return end
	w2.anchor = pinTo
	w2.drifter = v9
	(v8 ^ "strict").beam.Attachment1 = w2.anchor
end
function Retarget.Destroy(v10) -- proto[5], line 128  -- upvalues: t
end
local TutorialBeam = ReplicatedStorage.Assets.Extra.TutorialBeam
local LocalPlayer = Players.LocalPlayer
function Retarget.Attach(v11, v12) -- proto[8], line 133  -- upvalues: Trove, pinTo, TutorialBeam, s1, LocalPlayer, rideCharacter
	local w1 = v11.IsA
	assert(w1, "beam anchor needs a BasePart or a Vector3")
	local s2 = s1.beamProperties
	for _k11, _v12 in ipairs(s2) do
		TutorialBeam.Clone[_k11] = _v12
	end
	if v12 and v12.BeamName then
		s2 = v12.BeamName
	else
		s2 = s1.stockName
	end
	TutorialBeam.Clone.Name = s2
	TutorialBeam.Clone.Attachment1 = pinTo
	TutorialBeam.Clone.Parent = workspace
	local anchor = { anchor = pinTo, follower = nil, drifter = v11 }
	local scope = { scope = Trove.new, beam = TutorialBeam.Clone, owner = LocalPlayer, pins = anchor }
	local function remountOn(v13) -- proto[6], line 155  -- upvalues: s1, rideCharacter, U2
		if not v13.WaitForChild then return end
	end
	return scope
end
return Retarget