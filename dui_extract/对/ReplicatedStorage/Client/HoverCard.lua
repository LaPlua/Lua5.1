-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.HoverCard
-- ============================================

-- bytecode
-- Original size: 23417 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 212, Protos: 42, Main proto: 41

-- ============== SOURCE ==============
-- main chunk (proto[41], line 1)
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local GamepadBindings = require(ReplicatedStorage.Client.GamepadBindings)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local ViewportSize = require(ReplicatedStorage.Client.ViewportSize)
local ClipToDeviceSafeArea = { ClipToDeviceSafeArea = false, DisplayOrder = 16384, Name = "HoverCardLayer", ResetOnSpawn = false, ScreenInsets = Enum.ScreenInsets.None, ZIndexBehavior = Enum.ZIndexBehavior.Global }
local r1 = Color3.new(1, 1, 1)
local body = { body = "Body", heading = "Heading", rule = "Rule", tier = "Tier" }
local body_2 = { body = 190, heading = 240, tier = 280 }
local s1 = {}
local function child(v1, v2) -- proto[0], line 89
	local v_u1 = v2
	local w1 = v1.FindFirstChild
	local w2 = v1.GetFullName
	assert(w1, (("%* is missing %*"):format(w2, v2)))
	return w1
end
local new = nil
local s2 = ClipToDeviceSafeArea
local function layer() -- proto[1], line 95  -- upvalues: new, s2, Players
	if new then return new end
	for _k5, _v6 in ipairs(s2) do
		Instance.new[_k5] = _v6
	end
	Instance.new.Parent = Players.LocalPlayer.WaitForChild
	new = Instance.new
	return Instance.new
end
local function origin() -- proto[2], line 111  -- upvalues: new, s2, Players
	if new then return w3.AbsolutePosition end
	for _k6, _v7 in ipairs(s2) do
		Instance.new[_k6] = _v7
	end
	Instance.new.Parent = Players.LocalPlayer.WaitForChild
	new = Instance.new
	local w3 = Instance.new
	return w3.AbsolutePosition
end
local w3
local function room() -- proto[3], line 115  -- upvalues: new, s2, Players, Workspace
	if new then
	else
		for _k6, _v7 in ipairs(s2) do
			Instance.new[_k6] = _v7
		end
		Instance.new.Parent = Players.LocalPlayer.WaitForChild
		new = Instance.new
		w3 = Instance.new
	end
	local w4 = w3.AbsoluteSize.X
	local w5 = w3.AbsoluteSize
	if 0 < w4 then
		if 0 < w5.Y then return w5 end
		local CurrentCamera = Workspace.CurrentCamera
		if not CurrentCamera then return Vector2.one end
		return CurrentCamera.ViewportSize
	end
end
local function rectOf(v3) -- proto[4], line 124  -- upvalues: new, s2, Players
	if new then
	else
		for _k10, _v11 in ipairs(s2) do
			Instance.new[_k10] = _v11
		end
		Instance.new.Parent = Players.LocalPlayer.WaitForChild
		new = Instance.new
		w3 = Instance.new
	end
	return { origin = (v3.AbsolutePosition - w3.AbsolutePosition), size = v3.AbsoluteSize }
end
local function pointer() -- proto[5], line 128  -- upvalues: UserInputService, new, s2, Players
	if new then return (UserInputService.GetMouseLocation - w3.AbsolutePosition) end
	for _k8, _v9 in ipairs(s2) do
		Instance.new[_k8] = _v9
	end
	Instance.new.Parent = Players.LocalPlayer.WaitForChild
	new = Instance.new
	local w3 = Instance.new
	return (UserInputService.GetMouseLocation - w3.AbsolutePosition)
end
local function contains(v4, v5) -- proto[6], line 132
	if 0 > (v5 - v4.origin).X then return f1 end
	if 0 > (v5 - v4.origin).Y then return f1 end
	if (v5 - v4.origin).X > v4.size.X then return f1 end
	local f1 = false  -- skip 1
	f1 = true
	return f1
end
local function overlaps(v6, v7) -- proto[7], line 137
	local f2
	if v6.origin.X >= (v7.origin.X + v7.size.X) then return f2 end
	if v7.origin.X >= (v6.origin.X + v6.size.X) then return f2 end
	if v6.origin.Y >= (v7.origin.Y + v7.size.Y) then return f2 end
	f2 = not (v7.origin.Y >= (v6.origin.Y + v6.size.Y))
	return f2
end
local function fitInside(v8, v9, v10) -- proto[8], line 144
	return (v8.Max):Min((v10 - v9).Max)
end
local function sideFacingCentre(v11) -- proto[9], line 151  -- upvalues: new, s2, Players, Workspace
	local v_u2
	if new then
	else
		for _k8, _v9 in ipairs(s2) do
			Instance.new[_k8] = _v9
		end
		Instance.new.Parent = Players.LocalPlayer.WaitForChild
		new = Instance.new
		w3 = Instance.new
	end
	local w4 = w3.AbsoluteSize
	local w5 = w3.AbsoluteSize.X
	if (0 < w5) and (0 < w4.Y) then
		v_u2 = w4
	else
		local Workspace_2 = Workspace.CurrentCamera
		if Workspace_2 then
			v_u2 = Workspace_2.ViewportSize
		end
	end
	if v11.Y > (Vector2.one.Y / 2) then return Vector2.new(-1, -1) end
	return Vector2.new(-1, -1)
end
local function settle(v12, v13, v14) -- proto[10], line 156  -- upvalues: new, s2, Players, Workspace
	local v_u1
	if new then
	else
		for _k11, _v12 in ipairs(s2) do
			Instance.new[_k11] = _v12
		end
		Instance.new.Parent = Players.LocalPlayer.WaitForChild
		new = Instance.new
		w3 = Instance.new
	end
	local w4 = w3.AbsoluteSize
	local w5 = w3.AbsoluteSize.X
	if (0 < w5) and (0 < w4.Y) then
		v_u1 = w4
	else
		local CurrentCamera = Workspace.CurrentCamera
		if CurrentCamera then
			v_u1 = CurrentCamera.ViewportSize
		end
	end
	(v12 ^ "Instance").AnchorPoint = Vector2.zero
	(v12 ^ "Instance").Position = UDim2.fromOffset
end
local v_u3
local function placeAtPointer(v15, v16, v17) -- proto[11], line 162  -- upvalues: new, s2, Players, Workspace
	local w6 = Instance.new
	if new then
	else
		for _k15, _v16 in ipairs(s2) do
			Instance.new[_k15] = _v16
		end
		Instance.new.Parent = Players.LocalPlayer.WaitForChild
		new = Instance.new
	end
	local w7 = w6.AbsoluteSize
	local w8 = w6.AbsoluteSize.X
	if (0 < w8) and (0 < w7.Y) then
		v_u3 = w7
	else
		local CurrentCamera = Workspace.CurrentCamera
		if CurrentCamera then
			v_u3 = CurrentCamera.ViewportSize
		end
	end
	local w9 = v15.card
	w9.AnchorPoint = Vector2.zero
	w9.Position = UDim2.fromOffset
end
local function hintsFrameFor(v18) -- proto[12], line 170
	local w1 = v18.FindFirstAncestorOfClass
	while true do
		if v18.Parent == nil then return nil end
		if v18.Parent == w1 then return nil end
		if not v18.Parent.FindFirstChild then break end
		if not (v18.Parent.FindFirstChild).IsA then break end
		if v18.Parent.FindFirstChild.Visible then return v18.Parent.FindFirstChild end
	end
	return nil
end
local new_5
local function placeBeside(v19, v20) -- proto[13], line 183  -- upvalues: new, s2, Players, Workspace, hintsFrameFor, overlaps
	local new_2
	local CurrentCamera
	local new_3
	local f3
	local origin
	local v_u4
	local w10 = Instance.new
	if new then
	else
		for _k14, _v15 in ipairs(s2) do
			Instance.new[_k14] = _v15
		end
		Instance.new.Parent = Players.LocalPlayer.WaitForChild
		new = Instance.new
		w3 = Instance.new
	end
	local _r4 = { origin = (v19.source.AbsolutePosition - w3.AbsolutePosition), size = v19.source.AbsoluteSize }
	if new then
		new_2 = new
	else
		local w6 = Instance.new
		for _k12, _v13 in ipairs(s2) do
			w6[_k12] = _v13
		end
		w6.Parent = Players.LocalPlayer.WaitForChild
		new = w6
		new_2 = w6
	end
	if not ((0 < new_2.AbsoluteSize.X) and (0 < new_2.AbsoluteSize.Y)) then
		CurrentCamera = Workspace.CurrentCamera
	end
	local _r11 = {}
	local w1 = v19.side
	local w11 = ((_r4.origin.X + _r4.size.X) + v19.clearance)
	local w12 = ((_r4.origin.X - v19.clearance) - v20.X)
	local v_u5 = (_r4.origin + ((_r4.size - v20) / 2)).Y
	if (0 < w1.X) then
		v_u5 = w12
	else
		new_3 = w11
	end
	_r11[1], _r11[2], _r11[3], _r11[4] = Vector2.new, Vector2.new, Vector2.new, Vector2.new(new_3, (_r4.origin + ((_r4.size - v20) / 2)).Y)
	if hintsFrameFor then
		if new then
			new_3 = new
		else
			for _k22, _v23 in ipairs(s2) do
				Instance.new[_k22] = _v23
			end
			Instance.new.Parent = Players.LocalPlayer.WaitForChild
			new = Instance.new
			new_3 = Instance.new
		end
		local _r13 = { origin = (hintsFrameFor.AbsolutePosition - new_3.AbsolutePosition), size = hintsFrameFor.AbsoluteSize }
	end
	for _k17, _v18 in ipairs(_r11) do
		local new_4 = (Vector2.one - v20).Max
		f3 = not (_v18 ~= (_v18.Max).Min)
		if nil ~= nil then
			origin = { origin = _v18, size = v20 }
			v_u4 = nil
			if ((v19 ^ "side") * (v19 ^ "side")) <= K[1381462] then continue end
		end
		if not f3 then continue end
		if new then
			new_4 = new
		else
			for _k30, _v31 in ipairs(s2) do
				Instance.new[_k30] = _v31
			end
			Instance.new.Parent = Players.LocalPlayer.WaitForChild
			new = Instance.new
			new_4 = Instance.new
		end
		if (0 < new_4.AbsoluteSize.X) and (0 < new_4.AbsoluteSize.Y) then
			v_u4 = new_4.AbsoluteSize
		else
			CurrentCamera = Workspace.CurrentCamera
			if CurrentCamera then
				v_u4 = CurrentCamera.ViewportSize
			end
		end
		((v19 ^ "side") * (v19 ^ "side")).card.AnchorPoint = Vector2.zero
		((v19 ^ "side") * (v19 ^ "side")).card.Position = UDim2.fromOffset
		return
	end
	if new then
	else
		for _k24, _v25 in ipairs(s2) do
			Instance.new[_k24] = _v25
		end
		Instance.new.Parent = Players.LocalPlayer.WaitForChild
		new = Instance.new
	end
	local w13 = w10.AbsoluteSize
	local w14 = w10.AbsoluteSize.X
	if (0 < w14) and (0 < w13.Y) then
		new_5 = w13
	else
		CurrentCamera = Workspace.CurrentCamera
		if CurrentCamera then
			new_5 = CurrentCamera.ViewportSize
		end
	end
	-- FORGPREP R0 iter=((v19 ^ "side") * (v19 ^ "side"))[1] -> pc445
	((v19 ^ "side") * (v19 ^ "side"))[1].card.AnchorPoint = Vector2.zero
	((v19 ^ "side") * (v19 ^ "side"))[1].card.Position = UDim2.fromOffset
end
local function stripMarkup(v21) -- proto[14], line 214
	return string.gsub
end
local function looksMarkedUp(v22) -- proto[15], line 218
	local f4 = not (string.find == nil)
	return f4
end
local function measure(v23, v24, v25) -- proto[17], line 222  -- upvalues: TextService
	Instance.new.Font = v23.FontFace
	Instance.new.Size = v23.TextSize
	Instance.new.Text = string.gsub
	Instance.new.Width = v25
	local new = Instance.new
	local function anon16() -- proto[16], line 228  -- upvalues: TextService, new
		return TextService:GetTextBoundsAsync(new)
	end
	if not pcall then return Vector2.new(v25, v23.TextSize) end
	if (typeof(anon16)) ~= "Vector2" then return Vector2.new(v25, v23.TextSize) end
	return anon16
end
local function cardScale() -- proto[18], line 237  -- upvalues: ViewportSize
	return (math.sqrt((math.min(ViewportSize.ReadScale, 1))))
end
local function labelInset(v26) -- proto[19], line 241
	local r2 = math.round(v26.TextSize / 4)
	return ((Vector2.new * 2) + (Vector2.one * (0 * 2)))
end
local function paintGradient(v27, v28) -- proto[20], line 250
	if v27.FindFirstChildOfClass == nil then
		v28.Clone.Parent = v27
		return
	end
	v27.FindFirstChildOfClass.Color = v28.Color
	v27.FindFirstChildOfClass.Enabled = v28.Enabled
	v27.FindFirstChildOfClass.Offset = v28.Offset
	v27.FindFirstChildOfClass.Rotation = v28.Rotation
	v27.FindFirstChildOfClass.Transparency = v28.Transparency
end
local RarityGradients = ReplicatedStorage.Assets.UI.RarityGradients
local function gradientNamed(v29) -- proto[21], line 263  -- upvalues: RarityGradients
	if (type(v29)) ~= "string" then return nil end
	if not RarityGradients.FindFirstChild then return nil end
	if not (RarityGradients.FindFirstChild).IsA then return nil end
	return RarityGradients.FindFirstChild
end
local function styleText(v30, v31) -- proto[22], line 271  -- upvalues: RarityGradients, r1
	local FindFirstChild
	local v_u6
	local w1 = v30.FindFirstChildOfClass
	local f1
	local text = tostring(v31.text or "")
	f1 = not (string.find == nil)
	v30.RichText = f1
	v30.Text = text
	if (typeof(v31.tint)) == "Color3" then
		v30.TextColor3 = v31.tint
	end
	if (type(v31.gradient)) ~= "string" then
		v_u6 = nil
	else
		if RarityGradients.FindFirstChild then
			if (RarityGradients.FindFirstChild).IsA then
				v_u6 = RarityGradients.FindFirstChild
			end
			FindFirstChild = nil
		end
	end
	if not FindFirstChild then return _r2 end
	v30.TextColor3 = r1
	if v30.FindFirstChildOfClass == nil then
		FindFirstChild.Clone.Parent = (v30 ^ "")
		return _r2
	end
	w1.Color = FindFirstChild.Color
	w1.Enabled = FindFirstChild.Enabled
	w1.Offset = FindFirstChild.Offset
	w1.Rotation = FindFirstChild.Rotation
	w1.Transparency = FindFirstChild.Transparency
	return _r2
end
Rarity = Rarity.Rarities
local function rarityConfig(v32) -- proto[23], line 286  -- upvalues: Rarity
	local _r2 = type(v32)
	local r3 = ("Unknown rarity: %*"):format((tostring(v32)))
	local w1 = Rarity[v32]
	assert(w1, r3)
	return w1
end
local function styleTier(v33, v34) -- proto[24], line 292  -- upvalues: Rarity
	local _r4 = type(v34.rarity)
	local t1 = tostring(v34.rarity)
	assert(Rarity[v34.rarity], (("Unknown rarity: %*"):format(t1)))
	v33.Text = Rarity[v34.rarity].DisplayName
	if (v33.FindFirstChildOfClass == nil) then
		Rarity[v34.rarity].RarityGradient.Clone.Parent = v33
	else
		v33.FindFirstChildOfClass.Color = Rarity[v34.rarity].RarityGradient.Color
		v33.FindFirstChildOfClass.Enabled = Rarity[v34.rarity].RarityGradient.Enabled
		v33.FindFirstChildOfClass.Offset = Rarity[v34.rarity].RarityGradient.Offset
		v33.FindFirstChildOfClass.Rotation = Rarity[v34.rarity].RarityGradient.Rotation
		v33.FindFirstChildOfClass.Transparency = Rarity[v34.rarity].RarityGradient.Transparency
	end
	if not v33.FindFirstChildOfClass then return Rarity[v34.rarity].DisplayName end
	local w1 = v33.FindFirstChildOfClass
	if w1.FindFirstChildOfClass == nil then
		Rarity[v34.rarity].RarityGradient.Clone.Parent = w1
		return Rarity[v34.rarity].DisplayName
	end
	w1.FindFirstChildOfClass.Color = Rarity[v34.rarity].RarityGradient.Color
	w1.FindFirstChildOfClass.Enabled = Rarity[v34.rarity].RarityGradient.Enabled
	w1.FindFirstChildOfClass.Offset = Rarity[v34.rarity].RarityGradient.Offset
	w1.FindFirstChildOfClass.Rotation = Rarity[v34.rarity].RarityGradient.Rotation
	w1.FindFirstChildOfClass.Transparency = Rarity[v34.rarity].RarityGradient.Transparency
	return Rarity[v34.rarity].DisplayName
end
local body_3 = { body = styleText, heading = styleText, tier = styleTier }
local s3 = body
local Rows = ReplicatedStorage.Assets.UI.Misc.HoverCard.Rows
local s4 = body_3
local s5 = body_2
local function buildBlock(v35, v36) -- proto[25], line 309  -- upvalues: s3, Rows, s4, s5, measure
	local w15 = s3[t2]
	local frame
	local f5
	local t2 = tostring(v35.kind)
	f5 = not (s3[t2] == nil)
	assert(f5, (("Unknown hover card row kind: %*"):format(t2)))
	assert((Rows.FindFirstChild).IsA, (("Missing hover card row template: %*"):format(w15)))
	(Rows.FindFirstChild).Clone.LayoutOrder = v36
	if s4[t2] == nil then
		frame = { frame = (Rows.FindFirstChild).Clone, height = (Rows.FindFirstChild).Clone.Size.Y.Offset, width = 72 }
		return frame
	end
	assert((((Rows.FindFirstChild).Clone).FindFirstChild).IsA, (("Hover card row template %* needs a title label"):format(w15)))
	local r2 = math.round((((Rows.FindFirstChild).Clone).FindFirstChild.TextSize / 4))
	local r4 = math.ceil((measure + ((Vector2.new * 2) + (Vector2.one * (0 * 2)))).Y)
	local w16 = (measure + ((Vector2.new * 2) + (Vector2.one * (0 * 2))))
	local r5 = math.max(r4, ((Rows.FindFirstChild).Clone).FindFirstChild.TextSize)
	(Rows.FindFirstChild).Clone.Size = UDim2.new
	local frame_2 = { frame = (Rows.FindFirstChild).Clone, height = r5, width = math.clamp((math.ceil(w16.X)), 72, s5[t2]) }
	return frame_2
end
local function follow(v37, v38) -- proto[26], line 339  -- upvalues: GamepadBindings, s1, placeBeside, placeAtPointer, UserInputService, new, s2, Players
	if not (GamepadBindings.IsOnScreen) then
		return
	end
	local v_u6 = v38
	if not (v_u6) then
		v_u6 = v37.card.AbsoluteSize
	end
	if v_u6.Y <= 0 then
		v_u6 = v37.footprint
	end
	if v37.viaSelection then
		return
	end
	if new then
	else
		for _k14, _v15 in ipairs(s2) do
			Instance.new[_k14] = _v15
		end
		Instance.new.Parent = Players.LocalPlayer.WaitForChild
		new = Instance.new
	end
end
local function stillHovered(v39) -- proto[27], line 356  -- upvalues: GuiService, new, s2, Players, UserInputService
	local w6 = Instance.new
	local f4
	if v39.viaSelection then
		f4 = not (GuiService.SelectedObject ~= v39.source)
		return f4
	end
	if new then
	else
		for _k12, _v13 in ipairs(s2) do
			Instance.new[_k12] = _v13
		end
		Instance.new.Parent = Players.LocalPlayer.WaitForChild
		new = Instance.new
		w3 = Instance.new
	end
	local _r2 = { origin = (v39.source.AbsolutePosition - w3.AbsolutePosition), size = v39.source.AbsoluteSize }
	if new then
	else
		for _k11, _v12 in ipairs(s2) do
			Instance.new[_k11] = _v12
		end
		Instance.new.Parent = Players.LocalPlayer.WaitForChild
		new = Instance.new
	end
	if 0 > ((UserInputService.GetMouseLocation - w6.AbsolutePosition) - _r2.origin).X then return f4 end
	if 0 > ((UserInputService.GetMouseLocation - w6.AbsolutePosition) - _r2.origin).Y then return f4 end
	if ((UserInputService.GetMouseLocation - w6.AbsolutePosition) - _r2.origin).X > _r2.size.X then return f4 end
	local f4 = false  -- skip 1
	f4 = true
	return f4
end
local function dismissWhenLeft(v40) -- proto[29], line 363  -- upvalues: s1, GuiService
	if not v40.viaSelection then return end
end
local Card = ReplicatedStorage.Assets.UI.Misc.HoverCard.Card
local function present(v41, v42, v43) -- proto[31], line 378  -- upvalues: s1, Card, Trove, GuiService, s2, dismissWhenLeft, buildBlock, new, s2, Players, ViewportSize, UserInputService, Workspace, Audio, follow, RunService
	local w17
	local w18
	local v_u7
	local _r17
	local w10
	local f6
	if (#v42) <= 0 then return end
	Card.Clone.Visible = false
	assert((Card.Clone).FindFirstChild, (("%* is missing Frame"):format((Card.Clone).GetFullName)))
	assert(((Card.Clone).FindFirstChild).FindFirstChild, (("%* is missing Rows"):format(((Card.Clone).FindFirstChild).GetFullName)))
	local _r5 = assert((((Card.Clone).FindFirstChild).FindFirstChild).FindFirstChildOfClass, "Hover card template needs a UIListLayout under Rows")
	local _r6 = assert((((Card.Clone).FindFirstChild).FindFirstChild).FindFirstChildOfClass, "Hover card template needs a UIPadding under Rows")
	if not (v43 == nil) then
		v_u3 = v43
	end
	local card = { card = Card.Clone, clearance = 12, footprint = Vector2.zero, links = Trove.new, side = Vector2.one, source = (v41 ^ "Dismiss"), viaSelection = v_u3 }
	s2 = card
	local new_2 = v42
	for _k13, _v14 in ipairs(new_2) do
		local v_u8 = _k13
		if s2 ~= card then return end
		local r5 = math.max(72, buildBlock.width)
		buildBlock.frame.Parent = ((Card.Clone).FindFirstChild).FindFirstChild
	end
	if new then
		new_2 = new
	else
		w17 = ((_r5.Padding.Offset * ((#v42) - 1)) + buildBlock.height)
		for _k16, _v17 in ipairs(s2) do
			Instance.new[_k16] = _v17
		end
		if ((v41 ^ "Dismiss") * (v41 ^ "Dismiss")) > K[604769584] then
			new = Instance.new
			new_2 = Instance.new
		end
	end
	Card.Clone.Parent = new_2
	if s2 ~= card then return end
	local w19 = (w17 + _r6.PaddingTop.Offset)
	local r6 = math.min(ViewportSize.ReadScale, 1)
	local w20 = (w19 + _r6.PaddingBottom.Offset)
	local r7 = math.sqrt(r6)
	assert((Card.Clone).FindFirstChild, (_v17:format((Card.Clone).GetFullName)))
	(Card.Clone).FindFirstChild.Scale = r7
	Card.Clone.Size = UDim2.fromOffset
	card.clearance = (r7 * 12)
	local new_3 = w20
	card.footprint = (Vector2.new * r7)
	if card.viaSelection then
		if new then
			new_3 = new
		else
			for _k24, _v25 in ipairs(s2) do
				Instance.new[_k24] = _v25
			end
			Instance.new.Parent = Players.LocalPlayer.WaitForChild
			new = Instance.new
			new_3 = Instance.new
		end
		local _r15 = { origin = (((v41 ^ "Dismiss") * (v41 ^ "Dismiss"))[1].AbsolutePosition - new_3.AbsolutePosition), size = ((v41 ^ "Dismiss") * (v41 ^ "Dismiss"))[1].AbsoluteSize }
	end
	if new then
	else
		-- FORGPREP R0 iter=((v41 ^ "Dismiss") * (v41 ^ "Dismiss"))[1] -> pc354
		for _k25, _v26 in ipairs(s2) do
			Instance.new[_k25] = _v26
		end
		Instance.new.Parent = Players.LocalPlayer.WaitForChild
		new = Instance.new
		w3 = Instance.new
	end
	local new_4 = w3.AbsolutePosition
	if new then
		w18 = (UserInputService.GetMouseLocation - new_4)
		new_4 = new
	else
		for _k25, _v26 in ipairs(s2) do
			Instance.new[_k25] = _v26
		end
		new = Instance.new
		new_4 = Instance.new
	end
	if (0 < new_4.AbsoluteSize.X) and (0 < new_4.AbsoluteSize.Y) then
		v_u7 = new_4.AbsoluteSize
	else
		local CurrentCamera = Workspace.CurrentCamera
		if CurrentCamera then
			v_u7 = CurrentCamera.ViewportSize
		end
	end
	local v_u5 = Vector2.new
	card.side = v_u5
	if card.viaSelection then
	else
		if new then
			new_5 = new
		else
			for _k27, _v28 in ipairs(s2) do
				Instance.new[_k27] = _v28
			end
			Instance.new.Parent = Players.LocalPlayer.WaitForChild
			new = Instance.new
			new_5 = Instance.new
		end
		_r17 = { origin = (card.source.AbsolutePosition - new_5.AbsolutePosition), size = card.source.AbsoluteSize }
		if new then
		else
			for _k26, _v27 in ipairs(s2) do
				Instance.new[_k26] = _v27
			end
			Instance.new.Parent = Players.LocalPlayer.WaitForChild
			new = Instance.new
			w10 = Instance.new
		end
		if 0 <= ((UserInputService.GetMouseLocation - w10.AbsolutePosition) - _r17.origin).X then
			if 0 <= ((UserInputService.GetMouseLocation - w10.AbsolutePosition) - _r17.origin).Y then
				if ((UserInputService.GetMouseLocation - w10.AbsolutePosition) - _r17.origin).X <= _r17.size.X then
					f6 = false  -- skip 1
					f6 = true
				end
			end
		end
	end
	if not (f6) then
		return
	end
	local Volume = { Volume = 0.3 }
	if s2 ~= card then return end
	_k3.Visible = true
	local data = card
end
function s1.Show(v44, v45) -- proto[32], line 451  -- upvalues: present
end
function s1.Attach(self, v46) -- proto[38], line 458  -- upvalues: present, Trove, s2, s1
	local function reveal(v47) -- proto[33], line 459  -- upvalues: v46, present, self
		if not v46 then return end
	end
	local function anon37() -- proto[37], line 480  -- upvalues: new
	end
	return anon37
end
function s1.Dismiss() -- proto[39], line 485  -- upvalues: s2
	if s2 == nil then return end
	s2 = nil
end
Tabs.Deactivated:Connect(function()
end)
return s1