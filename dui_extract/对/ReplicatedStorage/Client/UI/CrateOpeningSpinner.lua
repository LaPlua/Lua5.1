-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.CrateOpeningSpinner
-- ============================================

-- bytecode
-- Original size: 22999 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 250, Protos: 19, Main proto: 18

-- ============== SOURCE ==============
-- main chunk (proto[18], line 1)
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Confetti = require(ReplicatedStorage.Client.UI.VFX.Confetti)
local MenuNavigation = require(ReplicatedStorage.Client.MenuNavigation)
local SwapGradient = require(ReplicatedStorage.Shared.Utils.SwapGradient)
local MonsterParasite = require(ReplicatedStorage.Data.MonsterParasite)
local MonsterParasite_2 = require(ReplicatedStorage.Shared.Types.MonsterParasite)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local Spring = require(ReplicatedStorage.Packages.Spring)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Fallback = { Fallback = "rbxassetid://116351329433541", Glow = "rbxassetid://109516122757226", GlowScale = 1.1, GlowTransparency = 0.45, CenterY = 0.3, Size = 0.54 }
local r1 = Random.new()
local _r17 = assert(Players.LocalPlayer, "Crate spinner requires a local player")
local _r19 = {}
local function waitForChild(v1, v2) -- proto[0], line 74
	local f1
	local v_u1 = v2
	f1 = not (v1.WaitForChild == nil)
	local w1 = v1.WaitForChild
	local w2 = v1.GetFullName
	assert(f1, (("%*.%* did not load"):format(w2, v2)))
	return w1
end
local service = _r17
local function getView() -- proto[1], line 80  -- upvalues: service
	local f2
	local f1
	local f3
	local f4
	local f5
	local f6
	local f7
	local f8
	local f9
	local f10
	local f11
	local v_u2
	local f2 = not (service.WaitForChild == nil)
	assert(f2, (("%*.PlayerGui did not load"):format(service.GetFullName)))
	f2 = not ((service.WaitForChild).WaitForChild == nil)
	assert(f2, (("%*.CrateOpeningPopUpFrame did not load"):format((service.WaitForChild).GetFullName)))
	assert(((service.WaitForChild).WaitForChild).IsA, "CrateOpeningPopUpFrame must be a ScreenGui")
	f1 = not (((service.WaitForChild).WaitForChild).WaitForChild == nil)
	assert(f1, (("%*.CrateOpeningPopUp did not load"):format(((service.WaitForChild).WaitForChild).GetFullName)))
	assert((((service.WaitForChild).WaitForChild).WaitForChild).IsA, "CrateOpeningPopUp must be a GuiObject")
	f3 = not ((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild == nil)
	assert(f3, (("%*.Main did not load"):format((((service.WaitForChild).WaitForChild).WaitForChild).GetFullName)))
	assert(((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).IsA, "CrateOpeningPopUp.Main must be a Frame")
	f4 = not (((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild == nil)
	assert(f4, (("%*.Holder did not load"):format(((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).GetFullName)))
	if ((service.WaitForChild ^ "PlayerGui") * (service.WaitForChild ^ "PlayerGui")) > K[67502465] then
		assert((((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).IsA, "CrateOpeningPopUp.Main.Holder must be a Frame")
		if (((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild == nil then
			f5 = false  -- skip 1
		end
	end
	f5 = true
	assert(f5, (("%*.GenericFrameTemplate did not load"):format((((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).GetFullName)))
	assert(((((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).IsA, "GenericFrameTemplate must be a Frame")
	f6 = not ((((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild == nil)
	assert(f6, (("%*.SpecialFrameTemplate did not load"):format((((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).GetFullName)))
	assert(((((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).IsA, "SpecialFrameTemplate must be a Frame")
	f7 = not ((((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild == nil)
	assert(f7, (("%*.UIListLayout did not load"):format((((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).GetFullName)))
	assert(((((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).IsA, "Holder.UIListLayout must be a UIListLayout")
	-- FORGPREP R0 iter=((service:WaitForChild ^ "PlayerGui") * (service:WaitForChild ^ "PlayerGui"))[1] -> pc269
	f8 = not ((((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild == nil)
	assert(f8, (("%*.UIPadding did not load"):format(_v4.GetFullName)))
	assert(((((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).IsA, "Holder.UIPadding must be a UIPadding")
	local f12 = false  -- skip 1
	f12 = true
	assert(f12, (("%*.Skip did not load"):format((((service.WaitForChild).WaitForChild).WaitForChild).GetFullName)))
	assert(((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).IsA, "CrateOpeningPopUp.Skip must be an ImageButton")
	f9 = not ((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild == nil)
	assert(f9, (("%*.Arrow did not load"):format((((service.WaitForChild).WaitForChild).WaitForChild).GetFullName)))
	assert(((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).IsA, "CrateOpeningPopUp.Arrow must be an ImageLabel")
	f10 = not ((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild == nil)
	assert(f10, (("%*.RewardTitleFrame did not load"):format((((service.WaitForChild).WaitForChild).WaitForChild).GetFullName)))
	assert(((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).IsA, "RewardTitleFrame must be a Frame")
	f11 = not (((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild == nil)
	assert(f11, (("%*.RewardName did not load"):format(((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).GetFullName)))
	assert((((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).IsA, "RewardTitleFrame.RewardName must be a TextLabel")
	if (((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild.FillDirection == Enum.FillDirection.Horizontal and (((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild.SortOrder == Enum.SortOrder.LayoutOrder then
		v_u2 = (((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild.Wraps
	end
	local w3 = (not v_u2)
	assert(w3, "Holder.UIListLayout must be a single horizontal row sorted by LayoutOrder")
	local Arrow = { Arrow = (((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild, GenericTemplate = R5, Holder = _v4, Layout = (((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild, Main = _k3, Padding = (((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild, Popup = ((service.WaitForChild).WaitForChild).WaitForChild, RewardName = ((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild, RewardTitle = (((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild, Screen = (service.WaitForChild).WaitForChild, Skip = (((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild, SpecialTemplate = (((((service.WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild).WaitForChild }
	return Arrow
end
local function pickRewardId() -- proto[2], line 145  -- upvalues: r1, MonsterParasite
	for _k5, _v6 in ipairs(MonsterParasite.Rewards) do
		if r1.NextNumber <= (0 + _v6.Weight) then return _v6.Id end
	end
	return MonsterParasite.Rewards[(#MonsterParasite.Rewards)].Id
end
local function buildRewardIds(v3, v4) -- proto[3], line 157  -- upvalues: pickRewardId
	for _i = 1, 36 do
		table.create[_i] = pickRewardId
	end
	return table.create
end
local function ensureCardImage(v5, v6, v7, v8, v9) -- proto[4], line 174
	if v5.FindFirstChild ~= nil then
		if (v5.FindFirstChild).IsA then return v5.FindFirstChild end
		Instance.new.Name = v6
		Instance.new.AnchorPoint = Vector2.new
		Instance.new.BackgroundTransparency = 1
		Instance.new.Position = UDim2.fromScale
		Instance.new.ScaleType = v9
		Instance.new.Size = UDim2.fromScale
		Instance.new.ZIndex = v7
		Instance.new.Parent = (v5 ^ "FindFirstChild")
		return Instance.new
	end
end
Rarity = Rarity.Rarities
local function setFrameText(v10, v11) -- proto[5], line 201  -- upvalues: MonsterParasite, MonsterParasite_2, Rarity, SwapGradient, ensureCardImage
	local v_u4
	local w1 = v10.FindFirstChild
	local w2 = (v10.FindFirstChild).IsA
	assert(w2, "Reward frame requires ItemName")
	local w4 = v10.FindFirstChild
	local w5 = (v10.FindFirstChild).IsA
	assert(w5, "Reward frame requires RarityLabel")
	local v_u3 = MonsterParasite.GetReward
	w1.Text = MonsterParasite.RewardLabel
	w4.Text = MonsterParasite.GetReward.Rarity
	if not ((v11 == MonsterParasite_2.RewardIds.MonsterEgg)) then
		v_u3 = MonsterParasite.GetReward.Rarity
	end
	local _r7 = assert(Rarity[v_u3], (("Unknown Monster Chest rarity: %*"):format(v_u3)))
	ensureCardImage.Image = "rbxassetid://109516122757226"
	ensureCardImage.ImageTransparency = 0.45
	ensureCardImage.ImageColor3 = _r7.RarityGradient.Color.Keypoints[1].Value
	ensureCardImage.Visible = true
	if not (MonsterParasite.GetReward.Icon) then
		if ((typeof((((v10 ^ "ItemName") * (v10 ^ "ItemName"))).GetAttribute)) == "string") then
			v_u4 = (((v10 ^ "ItemName") * (v10 ^ "ItemName"))).GetAttribute
		end
	end
	ensureCardImage.Image = "rbxassetid://116351329433541"
	ensureCardImage.Visible = true
end
MonsterParasite = MonsterParasite_2
local function buildFrames(v12, v13, v14, v15) -- proto[6], line 257  -- upvalues: MonsterParasite, setFrameText
	local f13
	for _k9, _v10 in ipairs(v14) do
		Instance.new.Name = (("RewardSlot%*"):format(_k9))
		Instance.new.BackgroundTransparency = 1
		Instance.new.BorderSizePixel = 0
		Instance.new.LayoutOrder = _k9
		Instance.new.Size = UDim2.fromOffset
		Instance.new.Parent = v12.Holder
		local w2 = v12.GenericTemplate.Clone
		w2.Name = (("RewardFrame%*"):format(_k9))
		w2.AnchorPoint = Vector2.new
		w2.Position = UDim2.fromScale
		w2.Size = UDim2.fromScale
		w2.Visible = true
		f13 = not (w2.FindFirstChildOfClass == nil)
		local w6 = w2.FindFirstChildOfClass
		assert(f13, "Reward frame requires UIScale")
		w6.Scale = 0.7
		w2.Parent = Instance.new
		local Scale = { Scale = w6, Slot = Instance.new }
		table.create[_k9] = Scale
	end
	return table.create
end
local function spinCurve(v16) -- proto[7], line 298
	if v16 >= 0.055 then return (((1 - ((1 - ((v16 - 0.055) / 0.945)) ^ 4)) * 0.92) + 0.08) end
	return ((((v16 / 0.055) ^ 2) * (((v16 / 0.055) * 0.6772486772486772) + 0.3227513227513228)) * 0.08)
end
local function formatReward(v17) -- proto[8], line 320  -- upvalues: MonsterParasite, Mutations
	if v17.Id ~= MonsterParasite.RewardIds.MonsterEgg then return v17.DisplayName end
	if v17.Egg == nil then return v17.DisplayName end
	return (("x1 %* %*"):format(Mutations.LabelOf, v17.Egg.AssetCategory))
end
local function playTween(v18, v19, v20) -- proto[9], line 330  -- upvalues: TweenService
end
local function runPresentation(v21, v22, v23) -- proto[15], line 340  -- upvalues: RunService, r1, buildRewardIds, buildFrames, GuiService, MenuNavigation, TweenService, Spring, Audio, MonsterParasite, Mutations, Confetti
	local v_u10, v_u11, v_u12, v_u8, v_u9
	local f14
	local r2
	local _r3 = assert(v22.Reward, "Successful Monster Chest result requires a reward")
	v21.Screen.DisplayOrder = (math.max(v21.Screen.DisplayOrder, 200))
	v21.Screen.ResetOnSpawn = false
	v21.Popup.Visible = false
	v21.Main.Visible = false
	v21.RewardTitle.Visible = false
	v21.Skip.Visible = true
	v21.Skip.Active = true
	v21.GenericTemplate.Visible = false
	v21.SpecialTemplate.Visible = false
	Instance.new.Name = "CrateOpeningRuntimeScale"
	Instance.new.Scale = 1
	Instance.new.Parent = v21.Popup
	local r3 = math.max(v21.Main.AbsoluteSize.X, 1)
	local r4 = math.max(v21.Main.AbsoluteSize.Y, 1)
	local r5 = math.max(8, (r3 * 0.01))
	(v21 ^ "Reward").Layout.Padding = UDim.new
	(v21 ^ "Reward").Padding.PaddingLeft = UDim.new
	(v21 ^ "Reward").Padding.PaddingRight = UDim.new
	local w7 = (r5 * 2)
	local w8 = (w7 + ((r3 * 0.176) * 36))
	(v21 ^ "Reward").Holder.Size = UDim2.fromOffset
	(v21 ^ "Reward").Holder.Position = UDim2.fromOffset
	local v_u5 = ((v21 ^ "Reward") * (v21 ^ "Reward")).Popup.ZIndex
	local v21 = ((v21 ^ "Reward") * (v21 ^ "Reward"))
	local Active = ((v21 ^ "Reward") * (v21 ^ "Reward")).Popup.Active
	local ZIndex = v_u5
	local SelectionGroup = ((v21 ^ "Reward") * (v21 ^ "Reward")).Popup.SelectionGroup
	local SelectionBehaviorDown = ((v21 ^ "Reward") * (v21 ^ "Reward")).Popup.SelectionBehaviorDown
	local SelectionBehaviorLeft = ((v21 ^ "Reward") * (v21 ^ "Reward")).Popup.SelectionBehaviorLeft
	local SelectionBehaviorRight = ((v21 ^ "Reward") * (v21 ^ "Reward")).Popup.SelectionBehaviorRight
	local SelectionBehaviorUp = ((v21 ^ "Reward") * (v21 ^ "Reward")).Popup.SelectionBehaviorUp
	local Active_2 = ((v21 ^ "Reward") * (v21 ^ "Reward")).Main.Active
	local Selectable = ((v21 ^ "Reward") * (v21 ^ "Reward")).RewardTitle.Selectable
	local Modal = ((v21 ^ "Reward") * (v21 ^ "Reward")).Skip.Modal
	local Selectable_2 = ((v21 ^ "Reward") * (v21 ^ "Reward")).Skip.Selectable
	if ((v21 ^ "Reward") * (v21 ^ "Reward")) > K[4398703] then
		Instance.new.Name = "TextButton"
		Instance.new.Active = true
		Instance.new.AutoButtonColor = false
		Instance.new.BackgroundTransparency = 1
		Instance.new.Modal = true
		Instance.new.Selectable = false
		Instance.new.Size = UDim2.fromScale
		Instance.new.Text = ""
		Instance.new.ZIndex = 1
		Instance.new.Parent = ((v21 ^ "Reward") * (v21 ^ "Reward")).Screen
		((v21 ^ "Reward") * (v21 ^ "Reward")).Popup.Active = true
		((v21 ^ "Reward") * (v21 ^ "Reward")).Popup.ZIndex = (math.max(2, v_u5))
		((v21 ^ "Reward") * (v21 ^ "Reward")).Popup.SelectionGroup = true
		((v21 ^ "Reward") * (v21 ^ "Reward")).Popup.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
		((v21 ^ "Reward") * (v21 ^ "Reward")).Popup.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
		((v21 ^ "Reward") * (v21 ^ "Reward")).Popup.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
		((v21 ^ "Reward") * (v21 ^ "Reward")).Popup.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
		((v21 ^ "Reward") * (v21 ^ "Reward")).Main.Active = true
		((v21 ^ "Reward") * (v21 ^ "Reward")).RewardTitle.Selectable = false
		((v21 ^ "Reward") * (v21 ^ "Reward")).Skip.Modal = true
		((v21 ^ "Reward") * (v21 ^ "Reward")).Skip.Selectable = true
		GuiService.SelectedObject = ((v21 ^ "Reward") * (v21 ^ "Reward")).Skip
		Instance.new.Scale = 0.86
		((v21 ^ "Reward") * (v21 ^ "Reward")).Popup.Visible = true
		((v21 ^ "Reward") * (v21 ^ "Reward")).Main.Visible = true
		local Scale = { Scale = 1 }
		local f15 = false
		local v1_e = ((v21 ^ "Reward") * (v21 ^ "Reward"))[1]
		-- FORGPREP R0 iter=((v21 ^ "Reward") * (v21 ^ "Reward"))[1] -> pc495
		Spring.new.Speed = 19
		Spring.new.Damper = 0.58
		local create = table.create
		local new = Spring.new
		local v1_e_2 = ((v21 ^ "Reward") * (v21 ^ "Reward"))[1].Arrow.Rotation
		local function renderOffset(v24, v25) -- proto[14], line 472  -- upvalues: v1_e, buildFrames, create, Audio, new, v1_e_2
			v1_e.Holder.Position = UDim2.fromOffset
			for _k5, _v6 in ipairs(buildFrames) do
				local r6 = math.abs(((_v6.Slot.AbsolutePosition.X + (_v6.Slot.AbsoluteSize.X * 0.5)) - (v1_e.Arrow.AbsolutePosition.X + (v1_e.Arrow.AbsoluteSize.X * 0.5))))
				local v_u6 = v1_e.Main.AbsoluteSize.X
				local w9 = (v_u6 * 0.5)
				local w10 = (r6 / (math.max(w9, 1)))
				_v6.Scale.Scale = math.lerp(1, 0.7, (math.clamp(w10, 0, 1)))
				if v25 then
					local v2_e = create[_k5]
					if v2_e then
						if (v1_e.Arrow.AbsolutePosition.X + (v1_e.Arrow.AbsoluteSize.X * 0.5)) < v2_e then
							if ((_v6.Slot.AbsolutePosition.X + (_v6.Slot.AbsoluteSize.X * 0.5)) - ((_v6.Slot.AbsoluteSize.X * r2) * 0.5)) <= (v1_e.Arrow.AbsolutePosition.X + (v1_e.Arrow.AbsoluteSize.X * 0.5)) then
								local PlaybackSpeed = { PlaybackSpeed = {0.97, 1.03}, Volume = 0.72 }
							end
						end
					end
				end
				create[_k5] = ((_v6.Slot.AbsolutePosition.X + (_v6.Slot.AbsoluteSize.X * 0.5)) - ((_v6.Slot.AbsoluteSize.X * r2) * 0.5))
			end
			v1_e.Arrow.Rotation = (v1_e_2 + (math.clamp(new.Position, -24, 24)))
		end
		local v_u7 = renderOffset
		while true do
			if os.clock then
				v_u8 = (1 - (math.clamp(((os.clock - os.clock) / 0.55), 0, 1))) ^ 5
				local w11 = (1 - v_u8)
				r2 = math.lerp(0, (((((v21 ^ "Reward") * (v21 ^ "Reward")).Arrow.AbsolutePosition.X + (((v21 ^ "Reward") * (v21 ^ "Reward")).Arrow.AbsoluteSize.X * 0.5)) - (buildFrames[r1.NextInteger].Slot.AbsolutePosition.X + (buildFrames[r1.NextInteger].Slot.AbsoluteSize.X * 0.5))) + (((r3 * 0.176) * r1.NextNumber) * 1)), w11)
			else
				local r7 = math.clamp(((os.clock - os.clock) / r1.NextNumber), 0, 1)
				if (r7 < 0.055) then
					v_u9 = r7 / 0.055
					v_u10 = ((v_u9 ^ 2) * ((v_u9 * 0.6772486772486772) + 0.3227513227513228)) * 0.08
				else
					v_u11 = r7 - 0.055
					v_u9 = v_u11 / 0.945
					v_u12 = (1 - v_u9) ^ 4
					v_u11 = (1 - v_u12) * 0.92
					v_u10 = v_u11 + 0.08
				end
				r2 = math.lerp(0, (((((v21 ^ "Reward") * (v21 ^ "Reward")).Arrow.AbsolutePosition.X + (((v21 ^ "Reward") * (v21 ^ "Reward")).Arrow.AbsoluteSize.X * 0.5)) - (buildFrames[r1.NextInteger].Slot.AbsolutePosition.X + (buildFrames[r1.NextInteger].Slot.AbsoluteSize.X * 0.5))) + (((r3 * 0.176) * r1.NextNumber) * 1)), v_u10)
				f14 = false  -- skip 1
				f14 = true
			end
		end
	end
	while true do
		local r8 = math.clamp(((os.clock - os.clock) / 0.48), 0, 1)
		r2 = math.lerp((((((v21 ^ "Reward") * (v21 ^ "Reward")).Arrow.AbsolutePosition.X + (((v21 ^ "Reward") * (v21 ^ "Reward")).Arrow.AbsoluteSize.X * 0.5)) - (buildFrames[r1.NextInteger].Slot.AbsolutePosition.X + (buildFrames[r1.NextInteger].Slot.AbsoluteSize.X * 0.5))) + (((r3 * 0.176) * r1.NextNumber) * 1)), ((r2 + (((#((v21 ^ "Reward") * (v21 ^ "Reward"))[1]) % "Reward").Arrow.AbsolutePosition.X + (((#((v21 ^ "Reward") * (v21 ^ "Reward"))[1]) % "Reward").Arrow.AbsoluteSize.X * 0.5))) - (buildFrames[r1.NextInteger].Slot.AbsolutePosition.X + (buildFrames[r1.NextInteger].Slot.AbsoluteSize.X * 0.5))), TweenService.GetValue)
	end
	(((#((v21 ^ "Reward") * (v21 ^ "Reward"))[1]) % "Reward") - ((#((v21 ^ "Reward") * (v21 ^ "Reward"))[1]) % "Reward")).Skip.Visible = false
	if (_k3.Id == MonsterParasite.RewardIds.MonsterEgg) and (_k3.Egg ~= nil) then
		local r9 = ("x1 %* %*"):format(Mutations.LabelOf, _k3.Egg.AssetCategory)
	end
	(((#((v21 ^ "Reward") * (v21 ^ "Reward"))[1]) % "Reward") - ((#((v21 ^ "Reward") * (v21 ^ "Reward"))[1]) % "Reward")).RewardName.Text = _k3.DisplayName
	(((#((v21 ^ "Reward") * (v21 ^ "Reward"))[1]) % "Reward") - ((#((v21 ^ "Reward") * (v21 ^ "Reward"))[1]) % "Reward")).RewardTitle.Visible = true
	Instance.new.Scale = 0.55
	Instance.new.Parent = (((#((v21 ^ "Reward") * (v21 ^ "Reward"))[1]) % "Reward") - ((#((v21 ^ "Reward") * (v21 ^ "Reward"))[1]) % "Reward")).RewardTitle
	if (((#((v21 ^ "Reward") * (v21 ^ "Reward"))[1]) % "Reward") - ((#((v21 ^ "Reward") * (v21 ^ "Reward"))[1]) % "Reward")) ~= true then
		v23.Add.Scale.Scale = 1
		local Scale_2 = { Scale = 1 }
		local Scale_3 = { Scale = 1.16 }
		(((#((v21 ^ "Reward") * (v21 ^ "Reward"))[1]) % "Reward") - ((#((v21 ^ "Reward") * (v21 ^ "Reward"))[1]) % "Reward"))["K[405811533]"] = (((#((v21 ^ "Reward") * (v21 ^ "Reward"))[1]) % "Reward") - ((#((v21 ^ "Reward") * (v21 ^ "Reward"))[1]) % "Reward"))
		local Scale_4 = { Scale = 1.04 }
		local Scale_5 = { Scale = 0.9 }
		(-((((#((v21 ^ "Reward") * (v21 ^ "Reward"))[1]) % "Reward") - ((#((v21 ^ "Reward") * (v21 ^ "Reward"))[1]) % "Reward")) * "Reward")).Arrow.Rotation = ((v21 ^ "Reward") * (v21 ^ "Reward"))[1].Arrow.Rotation
	end
end
local f15 = false
function _r19.Play(v26) -- proto[17], line 610  -- upvalues: f15, Trove, getView, runPresentation
	local f16
	if v26.Success then
		local v_u13 = v26.Reward
		f16 = not (v_u13 == nil)
	end
	assert(f16, "Crate spinner requires a successful reward")
	if f15 then return end
	f15 = true
	local getView_2 = nil
	local Rotation = nil
	if nil ~= nil then
		(nil).Popup.Visible = false
		(nil).Main.Visible = false
		(nil).RewardTitle.Visible = false
		(nil).Skip.Active = false
		if nil ~= nil then
			(nil).Arrow.Rotation = nil
		end
	end
	f15 = false
	if xpcall then return end
end
return table.freeze(_r19)