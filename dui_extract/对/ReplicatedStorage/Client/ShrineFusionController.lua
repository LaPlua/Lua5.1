-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.ShrineFusionController
-- ============================================

-- bytecode
-- Original size: 42593 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 345, Protos: 35, Main proto: 34

-- ============== SOURCE ==============
local Color
-- main chunk (proto[34], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ShrineFusionSequence = require(ReplicatedStorage.Client.ShrineFusionSequence)
local ShrinePadZone = require(ReplicatedStorage.Shared.Util.ShrinePadZone)
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local Light = { Light = (Color3.fromRGB(255, 209, 74)), Dark = (Color3.fromRGB(198, 42, 32)) }
local DiscDiameter = { DiscDiameter = 15.6, DiscLift = 0.07, OrbCount = 3, OrbRadius = 7.2, OrbSize = 0.7, OrbSpeed = 1.3, OrbBob = 0.5, OrbHeight = 1.3, AnimDistance = 180, Approach = 6, Breathe = 1.7, FieldSize = 46, ArcCurve = 9, ArcWidth = 0.9 }
local s1 = {}
local Ready = { Ready = false }
local FusionShrineBillboard = ReplicatedStorage.Assets.Billboards:WaitForChild("FusionShrineBillboard")
assert((FusionShrineBillboard:IsA("BillboardGui")), "ReplicatedStorage.Assets.Billboards.FusionShrineBillboard must be a BillboardGui")
local function child(v1, v2) -- proto[0], line 96
	local v_u1 = v2
	local w1 = v1.FindFirstChild
	local w2 = v1.GetFullName
	assert(w1, w2 .. "." .. v2 .. " is missing")
	return w1
end
local function statusOf(v3, v4) -- proto[1], line 102
	local v_u2 = v4
	local w1 = v3.FindFirstChild
	local w2 = v3.GetFullName
	assert(w1, w2 .. "." .. v4 .. " is missing")
	local w3 = w1.FindFirstChild
	local w4 = w1.GetFullName
	assert(w3, w4 .. "." .. "Status" .. " is missing")
	local w5 = w3.IsA
	local w6 = w3.GetFullName
	assert(w5, w6 .. " must be a TextLabel")
	return w3
end
local function contentOf(v5) -- proto[2], line 108
	local w1 = v5.FindFirstChild
	local w2 = v5.GetFullName
	assert(w1, w2 .. "." .. "Card" .. " is missing")
	local w7 = w1.GetFullName
	local w4 = w1.FindFirstChild
	assert(w4, w7 .. "." .. "Inner" .. " is missing")
	local w8 = w4.FindFirstChild
	local w9 = w4.GetFullName
	assert(w8, w9 .. "." .. "Content" .. " is missing")
	return w8
end
local function styleOf(v6) -- proto[3], line 112
	local Color
	local w1 = v6.FindFirstChildOfClass
	local Text = {}
	local v_u3 = v6.Text
	Text.Text = v_u3
	if w1 then
		Color = w1.Color
	else
		Color = nil
	end
	Text.Color = Color
	return Text
end
local Card = FusionShrineBillboard:FindFirstChild("Card")
assert(Card, (FusionShrineBillboard:GetFullName()) .. "." .. "Card" .. " is missing")
local Inner = Card:FindFirstChild("Inner")
local r1 = Card:GetFullName()
local w10 = r1 .. "." .. "Inner" .. " is missing"
assert(Inner, w10)
local Content = Inner:FindFirstChild("Content")
local w11 = (Inner:GetFullName()) .. "." .. "Content" .. " is missing"
assert(Content, w11)
local DivineColumn = Content:FindFirstChild("DivineColumn")
assert(DivineColumn, (Content:GetFullName()) .. "." .. "DivineColumn" .. " is missing")
local Status = DivineColumn:FindFirstChild("Status")
local r2 = DivineColumn:GetFullName()
local w12 = r2 .. "." .. "Status" .. " is missing"
assert(Status, w12)
local _r29 = Status:IsA("TextLabel")
local r3 = Status:GetFullName()
assert(_r29, r3 .. " must be a TextLabel")
local class_UIGradient = Status:FindFirstChildOfClass("UIGradient")
local Text = {}
local v_u4 = Status.Text
Text.Text = v_u4
if class_UIGradient then
	Color = class_UIGradient.Color
else
	Color = nil
end
Text.Color = Color
local Card_2 = FusionShrineBillboard:FindFirstChild("Card")
assert(Card_2, (FusionShrineBillboard:GetFullName()) .. "." .. "Card" .. " is missing")
Color = Card_2:FindFirstChild("Inner")
assert(Color, (Card_2:GetFullName()) .. "." .. "Inner" .. " is missing")
class_UIGradient = Color:FindFirstChild("Content")
assert(class_UIGradient, (Color:GetFullName()) .. "." .. "Content" .. " is missing")
local EternalColumn = class_UIGradient:FindFirstChild("EternalColumn")
assert(EternalColumn, (class_UIGradient:GetFullName()) .. "." .. "EternalColumn" .. " is missing")
Status = EternalColumn:FindFirstChild("Status")
local r4 = EternalColumn:GetFullName()
local w13 = r4 .. "." .. "Status" .. " is missing"
assert(Status, w13)
assert((Status:IsA("TextLabel")), (Status:GetFullName()) .. " must be a TextLabel")
local class_UIGradient_2 = Status:FindFirstChildOfClass("UIGradient")
v_u4 = Status.Text
if class_UIGradient_2 then
	Color = class_UIGradient_2.Color
else
	Color = nil
end
local Text_2 = { Text = v_u4, Color = Color }
local s2 = { COMPLETED = Text, AVAILABLE = Text_2 }
local function applyStatus(v7, v8) -- proto[4], line 122  -- upvalues: s2
	local w1 = v7.FindFirstChildOfClass
	local v1_e
	if ((type(v8)) == "string") then
		v1_e = s2[v8]
	else
		v1_e = nil
	end
	v7.Text = "LOADING"
	if not w1 then return end
	if not s2.AVAILABLE.Color then return end
	w1.Color = s2.AVAILABLE.Color
end
local function mix(v9, v10, v11) -- proto[5], line 132
	return (v9 + ((v10 - v9) * v11))
end
local function smooth(v12) -- proto[6], line 136
	local r5 = math.clamp(v12, 0, 1)
	return ((r5 * r5) * (3 - (r5 * 2)))
end
local LocalPlayer = Players.LocalPlayer
local function localRoot() -- proto[7], line 141  -- upvalues: LocalPlayer
	if not nil then return nil end
	if not (nil).IsA then return nil end
	return (nil).Position
end
local function shotRig(v13) -- proto[8], line 147  -- upvalues: LocalPlayer
	local Position
	local w14 = v13.Light.Position
	local w15 = v13.Dark.Position
	local w16 = (v13.Light.Position - v13.Dark.Position)
	local w17 = (((v13.Light.Position + v13.Dark.Position) / 2) + Vector3.new(0, 5.5, 0))
	Position = nil
	local Focus = { Focus = w17, Axis = Vector3.new(1, 0, 0), Front = (Vector3.new(0, 1, 0)).Cross, Light = w14, Dark = w15, Span = (math.max(18, (w16.Magnitude * 1.25))), Root = Position, Approach = (Vector3.new(0, 1, 0)).Cross }
	return Focus
end
local function camFrame(v14, v15, v16, v17) -- proto[9], line 167  -- upvalues: ShrineFusionSequence
	local v_u9
	local r6
	local r7
	local r8
	local r9
	local v_u5
	local Dist
	if not (v14.Cam) then
		Dist = { Dist = 1.26, Height = 9.4, FOV = 56, Angle = 0.34, Drift = 1, Shot = 1 }
		v14.Cam = Dist
	end
	local r10 = math.exp(((-v17) * 2.8))
	local r11 = math.exp(((-v17) * 5.2))
	local w18 = (1 - r10)
	local v_u6 = v14.EndsAt
	local w19 = (v_u6 - v14.StartedAt)
	local w20 = (1 - r11)
	local r12 = math.max(w19, 1)
	local r5 = math.clamp((r12 * 0.24), 0.5, 1.3)
	local r13 = math.clamp(((v16 - v14.StartedAt) / r12), 0, 1)
	if v14.PayoffAt then
		r6 = math.clamp((((v16 - v14.PayoffAt) - 1.1) / 3.4), 0, 1)
	else
		if (v14.EndsAt - r5) <= v16 then
			r7 = math.clamp(((v16 - (v14.EndsAt - r5)) / r5), 0, 1)
		elseif r13 < 0.38 then
			r8 = math.clamp((r13 / 0.38), 0, 1)
		else
			r9 = math.clamp(((r13 - 0.38) / ((math.max((((v14.EndsAt - r5) - v14.StartedAt) / r12), 0.43)) - 0.38)), 0, 1)
			if Dist.Shot <= 1 then
				Dist.Shot = 2
				Dist.Angle = ((((r9 * r9) * (3 - (r9 * 2))) * 0.55) + -0.55)
				Dist.Dist = ((((r9 * r9) * (3 - (r9 * 2))) * -0.32999999999999996) + 0.95)
				Dist.Height = ((((r9 * r9) * (3 - (r9 * 2))) * -0.6000000000000005) + 4.4)
				Dist.FOV = ((((r9 * r9) * (3 - (r9 * 2))) * -4) + 50)
				Dist.Drift = 0.5
			end
		end
	end
	local w21 = ((((r9 * r9) * (3 - (r9 * 2))) * 0.55) + -0.55)
	local w22 = ((((r9 * r9) * (3 - (r9 * 2))) * -0.6000000000000005) + 4.4)
	local w23 = ((((r9 * r9) * (3 - (r9 * 2))) * -4) + 50)
	local w24 = (((((r9 * r9) * (3 - (r9 * 2))) * -0.32999999999999996) + 0.95) - Dist.Dist)
	Dist.Dist = (Dist.Dist + (w24 * w18))
	Dist.Height = (Dist.Height + ((w22 - Dist.Height) * w18))
	if not (ShrineFusionSequence.FlightFocus) then
		v_u9 = w23
	end
	Dist.FOV = (Dist.FOV + ((v_u9 - Dist.FOV) * w18))
	Dist.Angle = (Dist.Angle + ((w21 - Dist.Angle) * w20))
	Dist.Drift = (Dist.Drift + ((0.5 - Dist.Drift) * w20))
	local w25 = ((math.sin(((v16 - v14.StartedAt) * 0.33))) * 0.05)
	local w26 = (Dist.Angle + (w25 * Dist.Drift))
	local w27 = (v15.Front * (math.cos(w26)))
	local r14 = math.sin(w26)
	local w28 = (w27 + (v15.Axis * r14)).Unit
	local w29 = ((w27 + (v15.Axis * r14)).Unit * v15.Span)
	local w30 = (v15.Focus + (w29 * Dist.Dist))
	local r15 = Vector3.new(0, Dist.Height, 0)
	if ShrineFusionSequence.FlightFocus then
		local w31 = (w30 + r15)
		if not (Dist.Anchor) then
			Dist.Anchor = w31
			Dist.AnchorFrom = w31
			Dist.AnchorTo = ((v15.Focus + ((w28 * v15.Span) * 0.78)) + Vector3.new(0, 5.599999904632568, 0))
			Dist.AnchorAt = v16
			Dist.AimPoint = v15.Focus
			Dist.AimGoal = v15.Focus
			Dist.AimVelocity = Vector3.new(0, 0, 0)
		end
	end
	if Dist.Anchor then
		local v_u10 = Dist.AnchorAt
		local w32 = ((v16 - v_u10) / 0.55)
		local r16 = math.clamp(w32, 0, 1)
		Dist.Anchor = Dist.AnchorFrom.Lerp
		if ShrineFusionSequence.FlightFocus then
			v_u5 = v15.Focus
		else
			v_u5 = v15.Focus
		end
		Dist.AimGoal = v_u5
		local r17 = math.min(v17, 0.03333333333333333)
		Dist.AimVelocity = (Dist.AimVelocity + ((((Dist.AimGoal - Dist.AimPoint) * 30.25) - (Dist.AimVelocity * 6.6)) * r17))
		Dist.AimPoint = (Dist.AimPoint + (Dist.AimVelocity * r17))
		return CFrame.lookAt, Dist.FOV
	end
	return CFrame.lookAt, Dist.FOV
end
local function letterbox(v18) -- proto[10], line 256  -- upvalues: TweenService
	local _r1 = {}
	_r2[1], _r2[2] = "TopBar", "BottomBar"
	for _k5, _v6 in {} do
		Instance.new.Name = _v6
		Instance.new.BackgroundColor3 = Color3.new
		Instance.new.BorderSizePixel = 0
		Instance.new.ZIndex = 5
		Instance.new.AnchorPoint = Vector2.new
		Instance.new.Position = UDim2.fromScale
		Instance.new.Size = UDim2.fromScale
		Instance.new.Parent = (v18 ^ "TopBar")
		_r1[_k5] = Instance.new
		local Size = {}
		Size.Size = UDim2.fromScale
	end
	return _r1[1], _r1[2]
end
local function setBillboards(v19, v20) -- proto[11], line 278
	if v19.BillboardsOn == v20 then return end
	v19.BillboardsOn = v20
	for _k5, _v6 in ipairs(v19.Billboards) do
		if not _v6.Parent then continue end
		_v6.Enabled = v20
	end
end
local f1 = false
Remotes = Remotes.ShrineFusion
local data = Ready
local function refresh() -- proto[14], line 290  -- upvalues: f1, Remotes, data
	if f1 then return end
	f1 = true
	local function anon13() -- proto[13], line 295  -- upvalues: Remotes, data, f1
		local function anon12() -- proto[12], line 296  -- upvalues: Remotes
			return Remotes.AskState:InvokeServer()
		end
		if pcall then
			if anon12 then
				if (type(R2)) == "table" then
					data = R2
				end
			end
		end
		f1 = false
	end
end
local function label(v21, v22, v23, v24, v25, v26) -- proto[15], line 306
	Instance.new.Name = v22
	Instance.new.BackgroundTransparency = 1
	Instance.new.Position = v24
	Instance.new.Size = v25
	Instance.new.Font = Enum.Font.GothamBold
	Instance.new.Text = v23
	Instance.new.TextColor3 = v26
	Instance.new.TextScaled = true
	Instance.new.TextWrapped = true
	Instance.new.Parent = v21
	Instance.new.MaxTextSize = 25
	Instance.new.MinTextSize = 10
	Instance.new.Parent = Instance.new
	return Instance.new
end
local function billboard(v27, v28, v29, v30, v31) -- proto[16], line 332
	Instance.new.Name = v28
	Instance.new.Adornee = v29
	Instance.new.Size = UDim2.fromOffset
	Instance.new.StudsOffsetWorldSpace = v31
	Instance.new.MaxDistance = 85
	Instance.new.AlwaysOnTop = false
	Instance.new.ResetOnSpawn = false
	Instance.new.Parent = v27
	return Instance.new
end
local function characterOf(v32) -- proto[17], line 351  -- upvalues: Players
	if not nil then return nil end
	return (nil).Character
end
local function recipeOf(v33) -- proto[18], line 356  -- upvalues: data
	if not data.Ready then return nil end
	if (type(data.Recipes)) ~= "table" then return nil end
	return data.Recipes[v33]
end
local function releaseCamera(v34, v35) -- proto[19], line 360
	if workspace.CurrentCamera ~= v34.Camera then return end
	if workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable then return end
	workspace.CurrentCamera.CameraType = v34.Type
	workspace.CurrentCamera.FieldOfView = v34.FOV
	if v35 then
		workspace.CurrentCamera.CFrame = v35
	end
	workspace.CurrentCamera.CameraSubject = v34.Subject
end
local function dropBars(v36) -- proto[21], line 372  -- upvalues: TweenService
	_r2[1], _r2[2] = v36.Top, v36.Bottom
	for _k5, _v6 in {} do
		local Size = {}
		Size.Size = UDim2.fromScale
	end
end
s2 = nil
local s3 = nil
local function stopCutscene(v37) -- proto[22], line 382  -- upvalues: s2, s3, LocalPlayer, dropBars
	local Position
	s2 = nil
	if not (s2) then
		if v37 ~= true then return end
		if not s3 then return end
		s3 = nil
		if workspace.CurrentCamera == s3.Camera and workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then
			workspace.CurrentCamera.CameraType = s3.Type
			workspace.CurrentCamera.FieldOfView = s3.FOV
			workspace.CurrentCamera.CameraSubject = s3.Subject
		end
		return
	end
	s2.Help.Visible = false
	Position = nil
	if v37 ~= true and workspace.CurrentCamera == s2.Camera and workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then
		if workspace.CurrentCamera == s2.Camera and workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then
			workspace.CurrentCamera.CameraType = s2.Type
			workspace.CurrentCamera.FieldOfView = s2.FOV
			if s2.CFrame then
				workspace.CurrentCamera.CFrame = s2.CFrame
			end
			workspace.CurrentCamera.CameraSubject = s2.Subject
		end
		if v37 == true then
			return
		end
		return
	end
	local Camera = { Camera = nil, Type = nil, FOV = nil, Subject = nil, Gui = nil, Top = nil, Bottom = nil, From = nil, FromFOV = nil, Offset = nil, T = 0 }
	Camera.Camera = s2.Camera
	Camera.Type = s2.Type
	Camera.FOV = s2.FOV
	Camera.Subject = s2.Subject
	Camera.Gui = s2.Gui
	Camera.Top = s2.Top
	Camera.Bottom = s2.Bottom
	Camera.From = workspace.CurrentCamera.CFrame
	Camera.FromFOV = workspace.CurrentCamera.FieldOfView
	Camera.Offset = s2.CamOffset
	s3 = Camera
end
local Character
local function startCutscene(v38) -- proto[23], line 421  -- upvalues: s2, s3, LocalPlayer, PlayerGui, letterbox, label, s1, data, ShrineFusionSequence, Players
	local Fused, Position
	local v2_e
	s2 = nil
	if not (s2) then
		if s3 then
			s3 = nil
			if workspace.CurrentCamera == s3.Camera and workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then
				workspace.CurrentCamera.CameraType = s3.Type
				workspace.CurrentCamera.FieldOfView = s3.FOV
				workspace.CurrentCamera.CameraSubject = s3.Subject
			end
		else
			s2.Help.Visible = false
			Character = LocalPlayer.Character
			if workspace.CurrentCamera == s2.Camera and workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then
				workspace.CurrentCamera.CameraType = s2.Type
				workspace.CurrentCamera.FieldOfView = s2.FOV
				if s2.CFrame then
					workspace.CurrentCamera.CFrame = s2.CFrame
				end
				workspace.CurrentCamera.CameraSubject = s2.Subject
			end
		end
	end
	if (typeof(v38.Shrine)) ~= "Instance" then return end
	local w1 = v38.Shrine
	local w2 = v38.Shrine.IsDescendantOf
	if not w2 then return end
	if not (workspace.CurrentCamera) then return end
	local w3 = w1.FindFirstChild
	if not w3 then return end
	if not w1.FindFirstChild then return end
	if not w3.IsA then return end
	if not ((w1.FindFirstChild).IsA) then return end
	Instance.new.Name = "ShrineFusionRitual"
	Instance.new.DisplayOrder = 60
	Instance.new.ResetOnSpawn = false
	Instance.new.IgnoreGuiInset = true
	Instance.new.Parent = PlayerGui
	local r15 = label(Instance.new, "Help", "Stay on your pad and keep holding your animal. Moving away cancels fusion.", UDim2.fromScale, UDim2.fromScale, Color3.new(1, 1, 1))
	r15.TextStrokeTransparency = 0.3
	r15.ZIndex = 6
	Character = LocalPlayer.Character
	if Character then
		if ((v38 ^ "workspace") * (v38 ^ "workspace")) <= K[65637] then return end
	end
	Position = nil
	local Id = { Id = ((v38 ^ "workspace") * (v38 ^ "workspace")).SessionId, Tier = ((v38 ^ "workspace") * (v38 ^ "workspace")).Tier, Model = w1, Light = w3, Dark = w1.FindFirstChild, EndsAt = ((v38 ^ "workspace") * (v38 ^ "workspace")).EndsAt, StartedAt = workspace.GetServerTimeNow, Camera = workspace.CurrentCamera, Type = workspace.CurrentCamera.CameraType, FOV = workspace.CurrentCamera.FieldOfView, CFrame = workspace.CurrentCamera.CFrame, Subject = workspace.CurrentCamera.CameraSubject, CamOffset = ((workspace.CurrentCamera.CFrame.LookVector * -12) + Vector3.new(0, 4, 0)), Gui = Instance.new, Help = r15, Top = letterbox, Bottom = Instance.new }
	s2 = Id
	workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
	workspace.CurrentCamera.FieldOfView = 56
	local v3_e = s1[w1]
	if v3_e then
		if (v3_e.BillboardsOn == false) then
		else
			v3_e.BillboardsOn = false
			local v_u12 = v3_e.Billboards
			for _k14, _v15 in ipairs(v_u12) do
				if not _v15.Parent then continue end
				_v15.Enabled = false
			end
		end
	end
	if data.Ready then
		local data_2 = data.Recipes
		if (type(data_2)) == "table" then
			v2_e = data.Recipes[((v38 ^ "workspace") * (v38 ^ "workspace")).Tier]
		end
		v2_e = nil
	end
	local Shrine = { Shrine = nil, LightCharacter = nil, DarkCharacter = nil, EndsAt = nil, Tier = nil, FusedCategory = nil, Participant = true }
	Shrine.Shrine = w1
	if (type(((v38 ^ "workspace") * (v38 ^ "workspace")).LightUserId)) == "number" then
		local v_u13 = ((v38 ^ "workspace") * (v38 ^ "workspace")).LightUserId
	end
	local v_u14 = nil
	Shrine.LightCharacter = v_u14
	Character = nil
	Shrine.DarkCharacter = Character
	Character = ((v38 ^ "workspace") * (v38 ^ "workspace")).EndsAt
	Shrine.EndsAt = Character
	v_u14 = ((v38 ^ "workspace") * (v38 ^ "workspace")).Tier
	Shrine.Tier = v_u14
	if v2_e then
		Fused = v2_e.Fused
	else
		Fused = nil
	end
	Shrine.FusedCategory = Fused
end
local function cleanup(v39) -- proto[24], line 487  -- upvalues: s1, s2, stopCutscene
	if not (s1[v39]) then return end
	s1[v39] = nil
	for _k5, _v6 in ipairs(s1[v39].Connections) do
	end
	for _k5, _v6 in ipairs(s1[v39].Owned) do
	end
	if not s2 then return end
	if s2.Model ~= v39 then return end
end
local function register(v40) -- proto[26], line 504  -- upvalues: s1, FusionShrineBillboard, PlayerGui, s2, label, s3, cleanup, f1, Remotes, data
	local v_u15
	if s1[v40] then return end
	if not v40.IsA then return end
	if not (v40.IsDescendantOf) then return end
	local w1 = v40.FindFirstChild
	if not w1 then return end
	if not v40.FindFirstChild then return end
	local w33 = v40.FindFirstChild
	if not w1.IsA then return end
	if not (w33.IsA) then return end
	local Model = { Model = nil, Light = nil, Dark = nil, Owned = nil, Connections = nil, Pads = nil, Billboards = nil, BillboardsOn = true }
	Model.Model = (v40 ^ "Model")
	Model.Light = w1
	Model.Dark = w33
	Model.Owned = {}
	Model.Connections = {}
	Model.Pads = {}
	Model.Billboards = {}
	s1[(v40 ^ "Model")] = Model
	Instance.new.Name = "FusionStatusAnchor"
	Instance.new.Position = w1.CFrame.PointToObjectSpace
	Instance.new.Parent = w1
	table.insert(Model.Owned, Instance.new)
	FusionShrineBillboard.Clone.Name = "PersonalFusionStatus"
	FusionShrineBillboard.Clone.Adornee = Instance.new
	FusionShrineBillboard.Clone.ResetOnSpawn = false
	FusionShrineBillboard.Clone.Enabled = true
	FusionShrineBillboard.Clone.Parent = PlayerGui
	table.insert(Model.Owned, FusionShrineBillboard.Clone)
	table.insert(Model.Billboards, FusionShrineBillboard.Clone)
	assert((FusionShrineBillboard.Clone).FindFirstChild, (FusionShrineBillboard.Clone).GetFullName .. "." .. "Card" .. " is missing")
	assert(((FusionShrineBillboard.Clone).FindFirstChild).FindFirstChild, ((FusionShrineBillboard.Clone).FindFirstChild).GetFullName .. "." .. "Inner" .. " is missing")
	if ((v40 ^ "Model") * (v40 ^ "Model")) > K[525906] then
		assert(table.insert, (((FusionShrineBillboard.Clone).FindFirstChild).FindFirstChild).GetFullName .. "." .. "Content" .. " is missing")
		assert(table.insert.FindFirstChild, table.insert.GetFullName .. table.insert .. "DivineColumn" .. " is missing")
		assert((table.insert.FindFirstChild).FindFirstChild, (table.insert.FindFirstChild).GetFullName .. "." .. "Status" .. " is missing")
		assert(((table.insert.FindFirstChild).FindFirstChild).IsA, ((table.insert.FindFirstChild).FindFirstChild).GetFullName .. " must be a TextLabel")
		Model.Divine = (table.insert.FindFirstChild).FindFirstChild
		assert(table.insert.FindFirstChild, table.insert.GetFullName .. "." .. "EternalColumn" .. " is missing")
		-- FORGPREP R0 iter=((v40 ^ "Model") * (v40 ^ "Model"))[1] -> pc275
		assert((table.insert.FindFirstChild).FindFirstChild, (table.insert.FindFirstChild).GetFullName .. "." .. "Status" .. " is missing")
		assert(((table.insert.FindFirstChild).FindFirstChild).IsA, ((table.insert.FindFirstChild).FindFirstChild).GetFullName .. ((table.insert.FindFirstChild).FindFirstChild))
		_k3.Eternal = (table.insert.FindFirstChild).FindFirstChild
		_k3.Divine.Text = "LOADING"
		if _k3.Divine.FindFirstChildOfClass and s2.AVAILABLE.Color then
			_k3.Divine.FindFirstChildOfClass.Color = s2.AVAILABLE.Color
		end
	end
	_k3.Eternal.Text = "LOADING"
	if _k3.Eternal.FindFirstChildOfClass and s2.AVAILABLE.Color then
		_k3.Eternal.FindFirstChildOfClass.Color = s2.AVAILABLE.Color
	end
	Instance.new.Name = "PersonalFusionHint"
	Instance.new.Adornee = _v4
	Instance.new.Size = UDim2.fromOffset
	Instance.new.StudsOffsetWorldSpace = Vector3.new(0, 11.800000190734863, 0)
	Instance.new.MaxDistance = 85
	Instance.new.AlwaysOnTop = false
	Instance.new.ResetOnSpawn = false
	Instance.new.Parent = PlayerGui
	Instance.new.Enabled = false
	table.insert(_k3.Owned, Instance.new)
	_k3.Hint = Instance.new
	_k3.Message = (label(Instance.new, "Guidance", "", UDim2.new, UDim2.fromScale, Color3.fromRGB(226, 224, 236)))
	_k3.Message.TextStrokeTransparency = 0.25
	local Center = {}
	Center.Center = ((w1.Position + w33.Position) / 2)
	_k3.Anim = Center
	_r8[1], _r8[2] = "Light", "Dark"
	for _k11, _v12 in {} do
		Instance.new.Name = "FusionGlowDisc" .. _v12
		Instance.new.Shape = Enum.PartType.Cylinder
		Instance.new.Size = Vector3.new(0.18000000715255737, 15.600000381469727, 15.600000381469727)
		Instance.new.CFrame = (CFrame.new * CFrame.Angles)
		Instance.new.Anchored = true
		Instance.new.CanCollide = false
		Instance.new.CanTouch = false
		Instance.new.CanQuery = false
		Instance.new.CastShadow = false
		Instance.new.Material = Enum.Material.Neon
		Instance.new.Color = s3[_v12]
		Instance.new.Transparency = 1
		Instance.new.Parent = ((#((v40 ^ "Model") * (v40 ^ "Model"))[1]) % "Model")
		table.insert(_k3.Owned, Instance.new)
		Instance.new.Color = s3[_v12]
		Instance.new.Range = 16
		Instance.new.Brightness = 0
		Instance.new.Enabled = false
		Instance.new.Parent = Instance.new
		Instance.new.Texture = "rbxasset://textures/particles/sparkles_main.dds"
		Instance.new.Color = ColorSequence.new
		Instance.new.LightEmission = 1
		Instance.new.LightInfluence = 0
		Instance.new.Lifetime = NumberRange.new
		Instance.new.Speed = NumberRange.new
		if (((#((v40 ^ "Model") * (v40 ^ "Model"))[1]) % "Model") - ((#((v40 ^ "Model") * (v40 ^ "Model"))[1]) % "Model")) ~= false then continue end
		Instance.new.Acceleration = Vector3.new(0, 1.5, 0)
		Instance.new.EmissionDirection = Enum.NormalId.Right
		Instance.new.Rate = 0
		Instance.new.Enabled = false
		local _r19 = {}
		_r19[1], _r19[2] = NumberSequenceKeypoint.new, NumberSequenceKeypoint.new(1, 0)
		Instance.new.Size = NumberSequence.new
		Instance.new.Parent = Instance.new
		local _r18 = {}
		for _i = 1, 3 do
			Instance.new.Name = "FusionGlowOrb" .. _v12
			Instance.new.Shape = Enum.PartType.Ball
			Instance.new.Size = Vector3.new(0.699999988079071, 0.699999988079071, 0.699999988079071)
			v_u15 = (_k3[_v12].Position.Y + (_k3[_v12].Size.Y / 2)) + 1.3
			Instance.new.CFrame = CFrame.new
			Instance.new.Anchored = true
			Instance.new.CanCollide = false
			Instance.new.CanTouch = false
			Instance.new.CanQuery = false
			Instance.new.CastShadow = false
			Instance.new.Material = Enum.Material.Neon
			Instance.new.Color = s3[_v12]
			Instance.new.Transparency = 1
			Instance.new.Parent = (((#((v40 ^ "Model") * (v40 ^ "Model"))[1]) % "Model") - ((#((v40 ^ "Model") * (v40 ^ "Model"))[1]) % "Model"))
			local state_2_2 = _k3.Owned
			table.insert(state_2_2, Instance.new)
			table.insert(_r18, Instance.new)
		end
		local Pad = { Pad = _k3[_v12], Disc = Instance.new, Glow = Instance.new, Embers = Instance.new, Orbs = _r18, Top = (_k3[_v12].Position.Y + (_k3[_v12].Size.Y / 2)), Offset = ((_k11 - 1) * 2.1), DiscT = 1, LightT = 0, OrbA = 0, Goal = { Disc = 0.62, Breathe = 0.16, Light = 0.7, Orb = 0 } }
		_k3.Pads[_v12] = Pad
	end
	Instance.new.Parent = _k3.Pads.Light.Disc
	(((#((v40 ^ "Model") * (v40 ^ "Model"))[1]) % "Model") - ((#((v40 ^ "Model") * (v40 ^ "Model"))[1]) % "Model"))["K[2080574029]"] = (((#((v40 ^ "Model") * (v40 ^ "Model"))[1]) % "Model") - ((#((v40 ^ "Model") * (v40 ^ "Model"))[1]) % "Model"))
	if (((#((v40 ^ "Model") * (v40 ^ "Model"))[1]) % "Model") - ((#((v40 ^ "Model") * (v40 ^ "Model"))[1]) % "Model")) > K[386533965] then
		Instance.new.Parent = "Attachment".Disc
		Instance.new.Attachment0 = Instance.new
		Instance.new.Attachment1 = Instance.new
		Instance.new.CurveSize0 = 9
		Instance.new.CurveSize1 = 9
		Instance.new.Width0 = 0.9
		Instance.new.Width1 = 0.9
		Instance.new.Segments = 24
		Instance.new.FaceCamera = true
		Instance.new.LightEmission = 1
		Instance.new.LightInfluence = 0
		Instance.new.Color = ColorSequence.new
		local _r12 = {}
		_r12[1], _r12[2], _r12[3] = NumberSequenceKeypoint.new, NumberSequenceKeypoint.new, 0.5(1, 0.75)
		Instance.new.Transparency = NumberSequence.new
		Instance.new.Parent = _k3.Pads.Light.Disc
		_k3.Arc = Instance.new
		Instance.new.Name = "FusionGlowField"
		Instance.new.Size = Vector3.new(46, 0.20000000298023224, 46)
		Instance.new.CFrame = CFrame.new
		Instance.new.Anchored = true
		Instance.new.CanCollide = false
		Instance.new.CanTouch = false
		Instance.new.CanQuery = false
		Instance.new.CastShadow = false
		Instance.new.Transparency = 1
		Instance.new.Parent = (((#((v40 ^ "Model") * (v40 ^ "Model"))[1]) % "Model") - ((#((v40 ^ "Model") * (v40 ^ "Model"))[1]) % "Model"))
		table.insert(_k3.Owned, Instance.new)
		_r12[1], _r12[2] = "Light", "Dark"
		for _k15, _v16 in {} do
			Instance.new.Texture = "rbxasset://textures/particles/sparkles_main.dds"
			Instance.new.Color = ColorSequence.new
			Instance.new.LightEmission = 1
			Instance.new.LightInfluence = 0
			Instance.new.Lifetime = NumberRange.new
			Instance.new.Speed = NumberRange.new
			Instance.new.Rate = 3.5
			Instance.new.EmissionDirection = Enum.NormalId.Top
			Instance.new.Size = NumberSequence.new
			local _r19_2 = {}
			_r19_2[1], _r19_2[2], _r19_2[3], _r19_2[4] = NumberSequenceKeypoint.new, NumberSequenceKeypoint.new, NumberSequenceKeypoint.new, NumberSequenceKeypoint.new(1, 1)
			Instance.new.Transparency = NumberSequence.new
			Instance.new.Parent = Instance.new
		end
	end
	local v4_e = ((-(((#((v40 ^ "Model") * (v40 ^ "Model"))[1]) % "Model") - ((#((v40 ^ "Model") * (v40 ^ "Model"))[1]) % "Model"))) / "Model")
	table.insert(_k3.Connections, (((-(((#((v40 ^ "Model") * (v40 ^ "Model"))[1]) % "Model") - ((#((v40 ^ "Model") * (v40 ^ "Model"))[1]) % "Model"))) / "Model").AncestryChanged):Connect(function()
		if v4_e.IsDescendantOf then return end
	end))
	if f1 then return end
	f1 = true
	local function anon13() -- proto[13], line 295  -- upvalues: Remotes, data, f1
		local function anon12() -- proto[12], line 296  -- upvalues: Remotes
			return Remotes.AskState:InvokeServer()
		end
		if pcall then
			if anon12 then
				if (type(R2)) == "table" then
					data = R2
				end
			end
		end
		f1 = false
	end
end
Remotes.ShrineFusion.Feedback.OnClientEvent:Connect(function(v41)
	if (type(v41)) ~= "table" then return end
	if (type(v41.Message)) ~= "string" then return end
	local Message = {}
	Message.Message = v41.Message
	Message.Until = (os.clock + 4)
	s2 = Message
end)
Remotes.ShrineFusion.Ritual.OnClientEvent:Connect(function(v42)
	if (type(v42)) ~= "table" then return end
	if v42.Phase == "Started" then
		return
	end
	if s2 then
		if s2.Id ~= v42.SessionId then return end
	end
	if v42.Phase == "Completed" then
		if f1 then
		else
			f1 = true
			local function anon13() -- proto[13], line 295  -- upvalues: Remotes, data, f1
				local function anon12() -- proto[12], line 296  -- upvalues: Remotes
					return Remotes.AskState:InvokeServer()
				end
				if pcall then
					if anon12 then
						if (type(R2)) == "table" then
							data = R2
						end
					end
				end
				f1 = false
			end
		end
		if s2 then
			s2.PayoffAt = workspace.GetServerTimeNow
			s2.Help.Visible = false
		end
		if ShrineFusionSequence.Payoff then return end
		return
	end
end)
Remotes.ShrineFusion.StateChanged.OnClientEvent:Connect(function(v43, v44)
	if (type(v44)) ~= "table" then return end
	if (typeof(v43)) ~= "Instance" then return end
	if v44.Phase == "Ritual" then
		local v_u2

		return
	end
	if v44.Phase == "Committing" then
		if f1 then return end
		if not ShrineFusionSequence.IsPlaying then return end
		return
	end
	if v44.Phase ~= "Idle" then return end
	if f1 then return end
	if not ShrineFusionSequence.IsPlaying then return end
	if ShrineFusionSequence.IsResolving then return end
end)
Players.LocalPlayer.CharacterAdded:Connect(function()
end)
local index = 0
local s4 = nil
local index_2 = 0
RunService.RenderStepped:Connect(function(v45)
	local w34
	local w14
	local f2
	local f3
	local w35
	local r18
	local state_2_2
	local f4
	local f5
	local v_u17
	local w36
	local f6
	local data_2
	local w37
	local v1_e
	local w38
	local v_u8
	local w39
	local w40
	local f7
	if s2 then
		if workspace.CurrentCamera == s2.Camera then
			if s2.Model.IsDescendantOf then
				workspace.CurrentCamera.CFrame = camFrame
				workspace.CurrentCamera.FieldOfView = s2
			end
		end
		if s3 then
			if (workspace.CurrentCamera ~= s3.Camera) or (workspace.CurrentCamera.CameraType ~= Enum.CameraType.Scriptable) then
				s3 = nil
			else
				s3.T = (s3.T + (v45 ^ "workspace"))
				local w41 = (s3.T / 0.9)
				local r13 = math.clamp((math.clamp(w41, 0, 1)), 0, 1)
				w34 = ((r13 * r13) * (3 - (r13 * 2)))
				local Character = LocalPlayer.Character
				Position = nil
				if not (Position) then
					w14 = s3.From.Position
				end
				workspace.CurrentCamera.CFrame = s3.From.Lerp
				workspace.CurrentCamera.FieldOfView = (s3.FromFOV + ((s3.FOV - s3.FromFOV) * w34))
				if 1 <= w34 then
					s3 = nil
					if workspace.CurrentCamera == s3.Camera and workspace.CurrentCamera.CameraType == Enum.CameraType.Scriptable then
						workspace.CurrentCamera.CameraType = s3.Type
						workspace.CurrentCamera.FieldOfView = s3.FOV
						workspace.CurrentCamera.CameraSubject = s3.Subject
					end
				end
			end
		end
		local CurrentCamera = workspace.CurrentCamera
		if CurrentCamera then
			for _k7, _v8 in ipairs(s1) do
				local Anim = _v8.Anim
				if not Anim then continue end
				if 180 < (CurrentCamera.CFrame.Position - Anim.Center).Magnitude then continue end
				local w18 = (1 - (math.exp(((-((v45 ^ "workspace") * (v45 ^ "workspace"))) * 6))))
				_r11[1], _r11[2] = "Light", "Dark"
				for _k14, _v15 in {} do
					local v_u18 = _v8.Pads[_v15].Goal
					local r19 = math.sin(((os.clock * 1.7) + _v8.Pads[_v15].Offset))
					local w25 = ((r19 + 1) * 0.5)
					_v8.Pads[_v15].DiscT = (_v8.Pads[_v15].DiscT + (((v_u18.Disc + (v_u18.Breathe * w25)) - _v8.Pads[_v15].DiscT) * w18))
					_v8.Pads[_v15].Disc.Transparency = _v8.Pads[_v15].DiscT
					_v8.Pads[_v15].LightT = (_v8.Pads[_v15].LightT + ((v_u18.Light - _v8.Pads[_v15].LightT) * w18))
					local v_u5 = _v8.Pads[_v15].LightT
					_v8.Pads[_v15].Glow.Brightness = v_u5
					f2 = not (0.05 >= _v8.Pads[_v15].LightT)
					_v8.Pads[_v15].Glow.Enabled = f2
					_v8.Pads[_v15].OrbA = (_v8.Pads[_v15].OrbA + ((v_u18.Orb - _v8.Pads[_v15].OrbA) * w18))
					f3 = not (0.02 >= _v8.Pads[_v15].OrbA)
					for _k23, _v24 in ipairs(_v8.Pads[_v15].Orbs) do
						if f3 then
							local v_u19 = _v8.Pads[_v15].OrbA
							w35 = (7.2 * (0.55 + (0.45 * v_u19)))
							local r20 = math.cos((((os.clock * 1.3) + _v8.Pads[_v15].Offset) + (_k23 * (6.283185307179586 / (#_v8.Pads[_v15].Orbs)))))
							local r14 = math.sin(((os.clock * 2.3) + (_k23 * 1.7)))
							r18 = math.sin((((os.clock * 1.3) + _v8.Pads[_v15].Offset) + (_k23 * (6.283185307179586 / (#_v8.Pads[_v15].Orbs)))))
							if ((v45 ^ "workspace") * (v45 ^ "workspace")) > K[85465904] then continue end
						end
						_v24.Transparency = (1 - (_v8.Pads[_v15].OrbA * 0.85))
					end
				end
			end
		end
		index = (index + ((v45 ^ "workspace") * (v45 ^ "workspace")))
		if index < 0.2 then return end
		index = 0
		for _k7, _v8 in ipairs(s1) do
			if _k7.IsDescendantOf then
				state_2_2 = _k7
				continue
			end
			f4 = not (ShrineFusionSequence.ActiveShrine ~= _k7)
			if not ((_v8.BillboardsOn == (not f4))) then
				_v8.BillboardsOn = (not f4)
				state_2_2 = _v8.Billboards
				for _k14, _v15 in ipairs(state_2_2) do
					v_u8 = _v15.Parent
					if not v_u8 then continue end
					_v15.Enabled = (not f4)
				end
			end
			f5 = not (_k7.GetAttribute == "Disabled")
			_v8.Arc.Enabled = ((not f4) and f5)
			_r12[1], _r12[2] = "Light", "Dark"
			v_u17 = nil
			for _k15, _v16 in {} do
				local v_u9 = _v8.Pads
				if _v8[_v16].GetAttribute ~= true then
					w36 = v_u9[_v16]
					f3 = false  -- skip 1
				end
				f3 = true
				if f3 then
					if _k7.GetAttribute == "Ritual" then
				if f4 then
					w36.Goal.Disc = 0.75
					w36.Goal.Breathe = 0.08
					w36.Goal.Light = 0.5
					w36.Goal.Orb = 0
					w36.Embers.Rate = 0
				elseif (not (f5)) then
					w36.Goal.Disc = 0.93
					w36.Goal.Breathe = 0.03
					w36.Goal.Light = 0
					w36.Goal.Orb = 0
					w36.Embers.Rate = 0
				elseif f2 then
					w36.Goal.Disc = 0.12
					w36.Goal.Breathe = 0.05
					w36.Goal.Light = 3
					w36.Goal.Orb = 1
					w36.Embers.Rate = 26
				elseif f3 then
					w36.Goal.Disc = 0.3
					w36.Goal.Breathe = 0.08
					w36.Goal.Light = 1.8
					w36.Goal.Orb = 1
					w36.Embers.Rate = 15
				else
					w36.Goal.Disc = 0.62
					w36.Goal.Breathe = 0.16
					w36.Goal.Light = 0.7
					w36.Goal.Orb = 0
					w36.Embers.Rate = 4
				end
				f6 = not (0 >= w36.Embers.Rate)
				w36.Embers.Enabled = f6
			end
			data_2 = data.Ready
			if data_2 then
				Divine = data.Divine
			else
				w37 = _v8.Divine
				v_u17 = nil
			end
			if ((type(v_u17)) == "string") then
				v1_e = s2[v_u17]
			else
				v1_e = nil
			end
			w37.Text = "LOADING"
			if v1_e then
				w38 = w37.FindFirstChildOfClass
			else
				v_u8 = s2.AVAILABLE.Color
			end
			if w38 and v_u8 then
				w38.Color = v_u8
			end
			data_2 = data.Ready
			if data_2 then
				Eternal = data.Eternal
			else
				w39 = _v8.Eternal
				v_u17 = nil
			end
			if ((type(v_u17)) == "string") then
				v1_e = s2[v_u17]
			else
				v1_e = nil
			end
			w39.Text = "LOADING"
			-- FORGPREP R0 iter=((v45 ^ "workspace") * (v45 ^ "workspace"))[1] -> pc724
			if v1_e then
				w40 = w39.FindFirstChildOfClass
			end
			if w40 and s2.AVAILABLE.Color then
				w40.Color = s2.AVAILABLE.Color
			end
			local v_u7 = nil
			data = data.Ready
			if data then
				data = data.Enabled
				data = data.Ready
				if data then
					if _k7.GetAttribute ~= "Mismatch" then
						_v8.Message.Text = (v_u7 or "")
						if _v8.BillboardsOn then
							f7 = not (v_u7 == nil)
						end
						_v8.Hint.Enabled = f7
						if not nil then continue end
						if not (nil).IsA then continue end
						v_u8 = _v8.Light.Position
						if ((nil).Position - v_u8).Magnitude >= 100 then continue end
					end
					if index_2 > os.clock then return end
					index_2 = (os.clock + 5)
					if f1 then return end
					f1 = true
					local function anon13() -- proto[13], line 295  -- upvalues: Remotes, data, f1
						local function anon12() -- proto[12], line 296  -- upvalues: Remotes
							return Remotes.AskState:InvokeServer()
						end
						if pcall then
							if anon12 then
								if (type(R2)) == "table" then
									data = R2
								end
							end
						end
						f1 = false
					end
				end
			end
		end
	end
end)
local r21 = CollectionService:GetInstanceAddedSignal("ShrineFusion")
r21:Connect(register)
local r22 = CollectionService:GetInstanceRemovedSignal("ShrineFusion")
r22:Connect(cleanup)
workspace.DescendantAdded:Connect(function(v46)
	if v46.Name ~= "LightPad" then
		if v46.Name ~= "DarkPad" then return end
	end
	local Parent = v46.Parent
	if not Parent then return end
	if not CollectionService.HasTag then return end
end)
local r23, r24, r25 = CollectionService:GetTagged("ShrineFusion")
for _k48, _v49 in ipairs(r23) do
	register(_v49)
end
return table.freeze({})