-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.VFX.ParticleStage
-- ============================================

-- bytecode
-- Original size: 4797 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 79, Protos: 16, Main proto: 15

-- ============== SOURCE ==============
-- main chunk (proto[15], line 1)
local Workspace = game:GetService("Workspace")
local Anchored = { Anchored = true, CanCollide = false, CanQuery = false, CanTouch = false, CastShadow = false, Name = "ParticleStage", Transparency = 1 }
local _index = {}
_index.__index = _index
local function sortedKeys(v1) -- proto[0], line 32
	local _r1 = {}
	for _v5 in ipairs(v1) do
		table.insert(_r1, _k5)
	end
	return _r1
end
local function write(v2, v3) -- proto[1], line 41
	for _v8 in ipairs(v3) do
		table.insert(_r2, _k8)
	end
	for _k5, _v6 in {} do
		v2[_v6] = v3[_v6]
	end
end
function _index.Emitter(v4, v5) -- proto[2], line 48
	for _v9 in ipairs(v4) do
		table.insert(_r3, _k9)
	end
	for _k6, _v7 in {} do
		Instance.new[_v7] = v4[_v7]
	end
	if v5 == nil then return Instance.new end
	for _v9 in ipairs(v5) do
		table.insert(_r3, _k9)
	end
	for _k6, _v7 in {} do
		Instance.new[_v7] = v5[_v7]
	end
	return Instance.new
end
local s1 = _index
function _index.Scale(v6, v7) -- proto[3], line 57  -- upvalues: s1
	local Acceleration = {}
	Acceleration.Acceleration = (v6.Acceleration * v7)
	Acceleration.Size = s1.ScaleSequence
	Acceleration.Speed = NumberRange.new
	Acceleration.ZOffset = (v6.ZOffset * v7)
	for _v9 in ipairs(Acceleration) do
		table.insert(_r3, _k9)
	end
	for _k6, _v7 in {} do
		v6[_v7] = Acceleration[_v7]
	end
end
function _index.ScaleSequence(v8, v9) -- proto[4], line 66
	for _k6, _v7 in ipairs(v8.Keypoints) do
		table.create[_k6] = NumberSequenceKeypoint.new
	end
	return NumberSequence.new(table.create)
end
function _index.QualityBudget() -- proto[5], line 74
	if UserSettings.GameSettings.SavedQualityLevel.Value > 0 then return ((UserSettings.GameSettings.SavedQualityLevel.Value / 10) ^ 1.25) end
	return 1
end
function _index.SetEnabled(v10, v11) -- proto[6], line 82
	for _k5, _v6 in ipairs(v10) do
		_v6.Enabled = v11
	end
end
local s2 = Anchored
local function new(v12, v13) -- proto[7], line 88  -- upvalues: s1, s2
	local self = setmetatable(({}), s1)
	self.depth = v12
	self.thickness = v13
	self.watchers = {}
	for _v11 in ipairs(s2) do
		table.insert(_r5, _k11)
	end
	for _k8, _v9 in {} do
		Instance.new[_v9] = s2[_v9]
	end
	self.Part = Instance.new
	return self
end
_index.new = new
function _index.Fit(v14) -- proto[9], line 100  -- upvalues: Workspace
	if Workspace.CurrentCamera == nil then return end
	local CurrentCamera = Workspace.CurrentCamera
	local CFrame = Workspace.CurrentCamera.CFrame
	local function onFarPlane(v15, v16) -- proto[8], line 110  -- upvalues: CurrentCamera, CFrame, U2, LookVector
		return (CFrame.Position + (CurrentCamera.ViewportPointToRay.Direction * (U2 / (CurrentCamera.ViewportPointToRay.Direction).Dot)))
	end
	local w1 = ((Workspace.CurrentCamera.CFrame.Position + (Workspace.CurrentCamera.ViewportPointToRay.Direction * ((v14.depth + (v14.thickness * 0.5)) / (Workspace.CurrentCamera.ViewportPointToRay.Direction).Dot))) - (Workspace.CurrentCamera.CFrame.Position + (Workspace.CurrentCamera.ViewportPointToRay.Direction * ((v14.depth + (v14.thickness * 0.5)) / (Workspace.CurrentCamera.ViewportPointToRay.Direction).Dot))))
	local w2 = ((((Workspace.CurrentCamera.CFrame.Position + (Workspace.CurrentCamera.ViewportPointToRay.Direction * ((v14.depth + (v14.thickness * 0.5)) / (Workspace.CurrentCamera.ViewportPointToRay.Direction).Dot))) + (Workspace.CurrentCamera.CFrame.Position + (Workspace.CurrentCamera.ViewportPointToRay.Direction * ((v14.depth + (v14.thickness * 0.5)) / (Workspace.CurrentCamera.ViewportPointToRay.Direction).Dot)))) * 0.5) - (Workspace.CurrentCamera.CFrame.LookVector * (v14.thickness * 0.5)))
	local w3 = v14.Part
	local w4 = (((Workspace.CurrentCamera.CFrame.Position + (Workspace.CurrentCamera.ViewportPointToRay.Direction * ((v14.depth + (v14.thickness * 0.5)) / (Workspace.CurrentCamera.ViewportPointToRay.Direction).Dot))) - (Workspace.CurrentCamera.CFrame.Position + (Workspace.CurrentCamera.ViewportPointToRay.Direction * ((v14.depth + (v14.thickness * 0.5)) / (Workspace.CurrentCamera.ViewportPointToRay.Direction).Dot))))).Dot
	w3.Size = Vector3.new((math.abs(w4)), (math.abs(w1.Dot)), (v14 ^ "CurrentCamera").thickness)
	(v14 ^ "CurrentCamera").Part.CFrame = (Workspace.CurrentCamera.CFrame.Rotation + w2)
end
function _index.Follow(v17) -- proto[12], line 124  -- upvalues: Workspace
	for _k4, _v5 in ipairs(v17.watchers) do
	end
	if Workspace.CurrentCamera == nil then return end
	v17.Part.Parent = Workspace.CurrentCamera
	local function refit() -- proto[10], line 135  -- upvalues: v17
	end
	local w5 = v17.watchers
	table.insert(w5, (Workspace.CurrentCamera.GetPropertyChangedSignal):Connect(refit))
	local w6 = v17.watchers
	table.insert(w6, (Workspace.CurrentCamera.GetPropertyChangedSignal):Connect(refit))
	table.insert((v17 ^ "watchers").watchers, (Workspace.CurrentCamera.GetPropertyChangedSignal):Connect(refit))
	local v17 = (v17 ^ "watchers")
	table.insert((v17 ^ "watchers").watchers, (Workspace.GetPropertyChangedSignal):Once(function()
	end))
end
function _index.Adopt(v18, v19) -- proto[13], line 146
	v19.Parent = v18.Part
end
function _index.Dispose(v20) -- proto[14], line 150
	for _k4, _v5 in ipairs(v20.watchers) do
	end
end
return table.freeze(_index)