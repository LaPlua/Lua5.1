-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.AssetViewport
-- ============================================

-- bytecode
-- Original size: 6007 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 101, Protos: 10, Main proto: 9

-- ============== SOURCE ==============
-- main chunk (proto[9], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local ItemDisplay = require(ReplicatedStorage.Shared.Modules.ItemDisplay)
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local Trove = require(ReplicatedStorage.Packages.Trove)
local AssetModels = require(ReplicatedStorage.Shared.Modules.AssetModels)
local t = require(ReplicatedStorage.Packages.t)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local Log = require(ReplicatedStorage.Packages.Log)
local r1 = Log.new()
local r2 = Color3.fromRGB(300, 300, 300)
local r3 = t.strict(t.instanceIsA("GuiObject"))
local r4 = t.strict(t.instanceIsA("Model"))
local r5 = t.strict(t.Instance)
local r6 = t.strict(t.CFrame)
local r7 = t.strict(t.Vector3)
local r8 = t.strict(t.number)
local r9 = t.strict(t.string)
local Mount = {}
local s1 = Mount
local Unit = Vector3.new(-1, 0, -1).Unit
local function raise(v1, v2, v3, v4) -- proto[0], line 40  -- upvalues: Trove, s1, ModelBounds, Unit
	if v4 then
		Instance.new.Parent = v3
		v2.Parent = Instance.new
		if not (s1.LoopIdle ~= nil) then
			v2.Parent = v3
		end
	end
	Instance.new.FieldOfView = 50
	Instance.new.Parent = v3
	v3.CurrentCamera = Instance.new
	local r10 = math.max(v2.X, v2.Y, v2.Z)
	local w1 = (ModelBounds.Position + (Vector3.new(0, (-0.15000000000000002 * v2.Y), 0)))
	Instance.new.CFrame = CFrame.new
	return Trove.new, Instance.new, v2
end
ReplicatedStorage = r3
function Mount.Mount(v5) -- proto[1], line 79  -- upvalues: ReplicatedStorage, r2
	Instance.new.Name = "AssetViewport"
	Instance.new.ZIndex = (v5.ZIndex + 1)
	Instance.new.AnchorPoint = Vector2.new
	Instance.new.BackgroundTransparency = 1
	Instance.new.Position = UDim2.fromScale
	Instance.new.Size = UDim2.fromScale
	Instance.new.Parent = (v5 ^ "Instance")
	Instance.new.LightColor = r2
	Instance.new.Ambient = r2
	return Instance.new
end
local string = r9
Assets = Assets.Directory
function Mount.LoopIdle(v6, v7) -- proto[2], line 92  -- upvalues: string, ReplicatedStorage, Assets
	if Assets[v6].Animations.Idle == nil then return nil end
	if v7.FindFirstChildWhichIsA == nil then return nil end
	if v7.GetAttribute == true then return nil end
	(v7.FindFirstChildWhichIsA).LoadAnimation.Looped = true
	return (v7.FindFirstChildWhichIsA).LoadAnimation
end
function Mount.ShowModel(v8, v9) -- proto[3], line 110  -- upvalues: ReplicatedStorage, raise, ModelBounds
	local v_u1
	local r1
	assert(v9.IsA, "ShowModel requires a ViewportFrame")
	local w2 = v8.Clone
	local r11 = math.tan((math.rad("".FieldOfView * 0.5)))
	_r14[1], _r14[2] = -1, 1
	for _k17, _v18 in {} do
		_r19[1], _r19[2] = -1, 1
		for _k22, _v23 in {} do
			_r24[1], _r24[2] = -1, 1
			for _k27, _v28 in {} do
				r1 = Vector3.new((w2.X * _v18), (w2.Y * _v23), (w2.Z * _v28))
				r1 = ModelBounds.VectorToWorldSpace
				local r12 = math.abs(CFrame.lookAt.VectorToObjectSpace.X)
				local r13 = math.abs(CFrame.lookAt.VectorToObjectSpace.Y)
				local w3 = (CFrame.lookAt.VectorToObjectSpace.Z + (r12 / (r11 * 1)))
				v_u1 = (math.max(0, w3, (CFrame.lookAt.VectorToObjectSpace.Z + (r13 / r11))))
			end
		end
	end
	local r14 = math.max(0.5, (v_u1 * 1.1))
	"".CFrame = CFrame.lookAt
	return raise, "", w2
end
function Mount.ShowAsset(v10, v11, v12) -- proto[4], line 141  -- upvalues: AssetModels, ReplicatedStorage, Trove, raise
	if not (AssetModels.GetAssetModelIfReplicated) then
		local AssetId = {}
		AssetId.AssetId = v10
		return Trove.new, nil, nil
	end
	return raise(v10, AssetModels.GetAssetModelIfReplicated.Clone, v11, v12)
end
local Instance = r5
local number = r8
function Mount.ShowItem(v13, v14, v15, v16) -- proto[5], line 157  -- upvalues: AssetItem, Instance, number, raise, ItemDisplay
	assert(AssetItem.AssetItemData(v13))
	table.clone.Scale = 1
	local w2 = v13.Category
	return raise, w2, ItemDisplay.CreateActiveModel
end
local CFrame = r6
local Vector3 = r7
function Mount.Orbit(v17, v18, v19, v20) -- proto[6], line 175  -- upvalues: CFrame, Vector3, number
	return CFrame.lookAt(((CFrame.new * CFrame.Angles) * CFrame.new.ToObjectSpace).Position, v18)
end
function Mount.AimOrbit(v21, v22, v23, v24, v25) -- proto[7], line 186  -- upvalues: Instance, s1
	v21.CFrame = s1.Orbit
end
function Mount.AimLocalOrbit(v26, v27, v28, v29, v30, v31, v32) -- proto[8], line 194  -- upvalues: Instance, CFrame, Vector3, number
	local r1 = Vector3.new(0, 0, (-v29))
	local r15 = Vector3.new(0, (v30 + ((math.tan(v32)) * v29)), 0)
	((v26 ^ "CFrame") * (v26 ^ "CFrame")).CFrame = CFrame.lookAt
end
return Mount