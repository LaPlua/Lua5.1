-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.AssetIconShape
-- ============================================

-- bytecode
-- Original size: 8772 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 123, Protos: 21, Main proto: 20

-- ============== SOURCE ==============
-- main chunk (proto[20], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local Assets_2 = require(ReplicatedStorage.Data.Assets)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local r1 = UDim2.fromScale(0.5, 0.5)
local r2 = Vector2.new(0.5, 0.5)
local r3 = UDim2.fromScale(1, 1)
local r4 = UDim2.fromScale(0.77, 0.77)
local r5 = UDim2.fromScale(0.85, 0.85)
local r6 = UDim2.fromScale(0, 0)
local r7 = Color3.fromRGB(0, 0, 0)
local r8 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local r9 = TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local r10 = t.strict(t.instanceIsA("ImageLabel"))
local r11 = t.strict(t.string)
local r12 = t.strict(t.Color3)
local r13 = t.strict(t.number)
local r14 = t.strict(t.instanceIsA("GuiObject"))
local r15 = t.strict(t.optional(t.callback))
local OverlayRainbow = {}
local function carries(v1, v2) -- proto[0], line 52
	local f1
	if v1.BaseMutation == v2 then return f1 end
	f1 = not (table.find == nil)
	return f1
end
local function zoomFor(v3) -- proto[1], line 58
	return 1, nil
end
local function iconFor(v4, v5) -- proto[2], line 60  -- upvalues: Mutations
	if v4.MutationIcons == nil then return (v4.Icon or "") end
	_r4[1], _r4[2] = Mutations.Ids.Golden, Mutations.Ids.Silver
	for _k7, _v8 in {} do
		if v5.BaseMutation == _v8 then continue end
		if table.find == nil then continue end
		if v4.MutationIcons[_v8] ~= nil then return v4.MutationIcons[_v8] end
	end
	return (v4.Icon or "")
end
local function imagesFor(v6, v7) -- proto[3], line 76  -- upvalues: iconFor, Mutations
	local WhiteImage = nil
	local v_u1 = v7
	if v7.BaseMutation ~= Mutations.Ids.Rainbow then
		if (table.find ~= nil) then
			v_u1 = v6.WhiteImage
		end
	end
	local Icon = { Icon = iconFor, RainbowOverlay = WhiteImage }
	return Icon
end
local function stretchBy(v8, v9, v10) -- proto[4], line 86
	return UDim2.new((v8.X.Scale * v9), (v8.X.Offset * v9), (v8.Y.Scale * v10), (v8.Y.Offset * v10))
end
local function makeCanvas(v11, v12, v13, v14) -- proto[5], line 95  -- upvalues: r1, r2
	Instance.new.Name = v11
	Instance.new.Size = v12
	Instance.new.Position = r1
	Instance.new.AnchorPoint = r2
	Instance.new.BackgroundTransparency = 1
	Instance.new.ClipsDescendants = true
	Instance.new.ZIndex = v13
	Instance.new.Parent = v14
	return Instance.new
end
local function makeZoomedImage(v15, v16, v17, v18, v19) -- proto[6], line 109  -- upvalues: r1, r2
	Instance.new.Name = v15
	Instance.new.Image = v16
	Instance.new.Size = UDim2.fromScale
	Instance.new.Position = (r1 + v18)
	Instance.new.AnchorPoint = r2
	Instance.new.BackgroundTransparency = 1
	Instance.new.ScaleType = Enum.ScaleType.Fit
	Instance.new.ZIndex = v19
	return Instance.new
end
ReplicatedStorage = r10
local string = r11
r1 = r3
r3 = r1
function OverlayRainbow.OverlayRainbow(v20, v21) -- proto[7], line 129  -- upvalues: ReplicatedStorage, string, r1, r3, r2, Rarity
	Instance.new.Name = "RainbowOverlayImage"
	Instance.new.Image = v21
	Instance.new.ImageTransparency = 0.5
	Instance.new.Size = r1
	Instance.new.Position = r3
	Instance.new.AnchorPoint = r2
	Instance.new.BackgroundTransparency = 1
	Instance.new.ScaleType = Enum.ScaleType.Fit
	Instance.new.ZIndex = (v20.ZIndex + 1)
	Instance.new.Parent = v20
	Rarity.Rarities.Rainbow.RarityGradient.Clone.Parent = Instance.new
	return Instance.new
end
function OverlayRainbow.Strip(v22) -- proto[8], line 150  -- upvalues: ReplicatedStorage
	(v22 ^ "RainbowOverlayImage").ImageTransparency = 0
end
local Color3 = r12
local number = r13
function OverlayRainbow.Tint(v23, v24, v25) -- proto[9], line 166  -- upvalues: ReplicatedStorage, Color3, number, r7
	local w1 = v23.FindFirstChild
	v23.ImageColor3 = v24
	v23.ImageTransparency = v25
	if v23.FindFirstChild == nil then return end
	for _k8, _v9 in ipairs(w1.GetDescendants) do
		if not _v9.IsA then continue end
		_v9.ImageTransparency = v25
		_v9.ImageColor3 = v24
	end
end
Assets = Assets_2
function OverlayRainbow.ResolveImages(v26) -- proto[10], line 192  -- upvalues: AssetItem, Assets, imagesFor
	local f2
	assert(AssetItem.AssetItemData(v26))
	local v_u2 = v26.Category
	f2 = not (Assets.Directory[v_u2] == nil)
	assert(f2, (("no asset directory entry for category %*"):format(v26.Category)))
	return imagesFor
end
local s1 = OverlayRainbow
r6 = (r1)
function OverlayRainbow.Paint(v27, v28) -- proto[11], line 200  -- upvalues: ReplicatedStorage, AssetItem, Assets, imagesFor, r1, s1, r3, r4, r2, r5, r7, r6
	local f3
	assert(AssetItem.AssetItemData(v28))
	local v_u1 = v28.Category
	f3 = not (Assets.Directory[v_u1] == nil)
	assert(f3, (("no asset directory entry for category %*"):format(v28.Category)))
	assert((nil or r1), "the icon zoom offset fell through its own default")
	v27.BackgroundTransparency = 1
	v27.ScaleType = Enum.ScaleType.Fit
	if 1 <= 1 then
		v27.Image = imagesFor.Icon
		v27.ImageTransparency = 0
		if imagesFor.RainbowOverlay == nil then return end
		return
	end
	v27.Image = ""
	v27.ImageTransparency = 1
	Instance.new.Name = "AssetIconShapeLayer"
	Instance.new.Size = r3
	Instance.new.Position = r4
	Instance.new.AnchorPoint = r2
	Instance.new.BackgroundTransparency = 1
	Instance.new.ZIndex = (v27 ^ "AssetItemData").ZIndex
	Instance.new.Parent = (v27 ^ "AssetItemData")
	Instance.new.Name = "IconStrokeFrame"
	Instance.new.Size = r5
	Instance.new.Position = r4
	Instance.new.AnchorPoint = r2
	Instance.new.BackgroundTransparency = 1
	Instance.new.ClipsDescendants = true
	Instance.new.ZIndex = (v27 ^ "AssetItemData").ZIndex
	Instance.new.Parent = Instance.new
	Instance.new.Name = "IconStrokeImage"
	Instance.new.Image = imagesFor.Icon
	Instance.new.Size = UDim2.fromScale
	Instance.new.Position = (r4 + (nil or r1))
	Instance.new.AnchorPoint = r2
	Instance.new.BackgroundTransparency = 1
	Instance.new.ScaleType = Enum.ScaleType.Fit
	Instance.new.ZIndex = (v27 ^ "AssetItemData").ZIndex
	Instance.new.ImageColor3 = r7
	Instance.new.Parent = Instance.new
	Instance.new.Name = "IconClipFrame"
	Instance.new.Size = r6
	Instance.new.Position = r4
	Instance.new.AnchorPoint = r2
	Instance.new.BackgroundTransparency = 1
	Instance.new.ClipsDescendants = true
	Instance.new.ZIndex = ((v27 ^ "AssetItemData").ZIndex + 1)
	Instance.new.Parent = Instance.new
	Instance.new.Name = "IconImage"
	Instance.new.Image = imagesFor.Icon
	Instance.new.Size = UDim2.fromScale
	Instance.new.Position = (r4 + (nil or r1))
	Instance.new.AnchorPoint = r2
	Instance.new.BackgroundTransparency = 1
	Instance.new.ScaleType = Enum.ScaleType.Fit
	Instance.new.ZIndex = ((v27 ^ "AssetItemData").ZIndex + 1)
	Instance.new.Parent = Instance.new
	if imagesFor.RainbowOverlay == nil then return end
end
local ReplicatedStorage_2 = r10
local ReplicatedStorage_3 = r15
r2 = r9
function OverlayRainbow.WireHoverSquash(v29, v30, v31) -- proto[19], line 254  -- upvalues: ReplicatedStorage, ReplicatedStorage_2, ReplicatedStorage_3, Trove, TweenService, r2, r8
	local f4 = nil
	local function drop() -- proto[12], line 267  -- upvalues: f4
		if not f4 then return end
		f4 = nil
	end
	local function applyScaleType(v32) -- proto[13], line 276  -- upvalues: v30
		v30.ScaleType = v32
		for _k4, _v5 in ipairs(v30.GetDescendants) do
			if not _v5.IsA then continue end
			_v5.ScaleType = v32
		end
	end
	local Size = v30.Size
	local function snapTo(v33) -- proto[14], line 285  -- upvalues: f4, v30, Size, applyScaleType
		if f4 then
			f4 = nil
		end
		if not (v30) then return end
		if (v33 or Size) then
			v30.Size = (v33 or Size)
		end
	end
	local function relax(v34) -- proto[16], line 298  -- upvalues: v30, Size, f4, applyScaleType, TweenService, r2
		if v30 then
			if f4 then
				f4 = nil
			end
			if not (v30) then return end
			if Size then
				v30.Size = Size
			end
			return
		end
		if v34 == false then
			if f4 then
				f4 = nil
			end
			if not (v30) then return end
			if (Size or Size) then
				v30.Size = (Size or Size)
			end
			return
		end
		if f4 then
			f4 = nil
		end
		local Size_2 = {}
		Size_2.Size = Size
		f4 = TweenService.Create
	end
	local function squash() -- proto[17], line 322  -- upvalues: v30, v31, f4, applyScaleType, TweenService, r8, Size
		if not v30 then return end
		if v31 then
			if not (v31) then return end
			if f4 then
				f4 = nil
			end
		end
		local Size_2 = {}
		Size_2.Size = UDim2.new
		f4 = (TweenService ^ "Cancel").Create
	end
	return Trove.new, relax
end
return OverlayRainbow