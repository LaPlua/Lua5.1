-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Gifting
-- ============================================

-- bytecode
-- Original size: 12323 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 166, Protos: 24, Main proto: 23

-- ============== SOURCE ==============
-- main chunk (proto[23], line 1)
local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local CashPacks = require(ReplicatedStorage.Data.CashPacks)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local GUI = require(ReplicatedStorage.Client.GUI)
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local GamepadBindings = require(ReplicatedStorage.Client.GamepadBindings)
local Gamepasses = require(ReplicatedStorage.Data.Gamepasses)
local GiftProductsMapping = require(ReplicatedStorage.Data.GiftProductsMapping)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local PlatformController = require(ReplicatedStorage.Client.PlatformController)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local r1 = GUI.Shop()
local Frame = r1:WaitForChild("Frame")
local GiftingPopUp = r1:WaitForChild("GiftingPopUp")
local ScrollingFrame = GiftingPopUp:WaitForChild("ScrollingFrame")
local PlayerTemplate = ScrollingFrame:WaitForChild("PlayerTemplate")
local PendingPurchase = Players.LocalPlayer.PlayerGui:WaitForChild("PendingPurchase")
local PendingPurchaseHandler = require(PendingPurchase:WaitForChild("PendingPurchaseHandler"))
local MenuNavigation = require(ReplicatedStorage.Client.MenuNavigation)
local s1 = {}
local s2 = {}
local r2 = GiftingPopUp.Header.Title:Clone()
r2.Name = "CashPackNotice"
r2.Text = "Cash gifts use the receiver's pack value, which may differ from yours."
r2.AnchorPoint = (Vector2.new(0.5, 0))
r2.Position = (UDim2.fromScale(0.5, 0.16))
r2.Size = (UDim2.new(0.92, 0, 0, 44))
r2.TextWrapped = true
r2.TextScaled = false
r2.TextSize = 16
r2.Visible = false
r2.Parent = GiftingPopUp
GiftingPopUp.Visible = false
local r3, r4, r5 = ScrollingFrame:GetChildren()
for _k37, _v38 in ipairs(r3) do
	if _v38.Name ~= "PlayerTemplate" then continue end
	if not _v38:IsA("GuiObject") then continue end
	_v38.Visible = false
end
local function notify(v3) -- proto[0], line 57  -- upvalues: Toast
	local Text = { Text = v3, Seconds = 5 }
end
s1 = nil
local GiftingPopUp_2 = r2
local ScrollingFrame_2 = ScrollingFrame.Position
local ScrollingFrame_3 = ScrollingFrame.Size
local GiftingPopUp_3 = GiftingPopUp.Header.Title.Text
local function closePicker(v4) -- proto[1], line 61  -- upvalues: s1, MenuNavigation, GiftingPopUp, GiftingPopUp_2, ScrollingFrame, ScrollingFrame_2, ScrollingFrame_3, GiftingPopUp_3, Frame, GuiService, Tabs
	s1 = nil
	GiftingPopUp.Visible = false
	GiftingPopUp_2.Visible = false
	ScrollingFrame.Position = ScrollingFrame_2
	ScrollingFrame.Size = ScrollingFrame_3
	GiftingPopUp.Header.Title.Text = GiftingPopUp_3
	Frame.Visible = true
	if GuiService.SelectedObject then
		if GuiService.SelectedObject.IsDescendantOf then
			GuiService.SelectedObject = nil
		end
	end
	if v4 == false then return end
	if not s1 then return end
	if not s1.sourceTab then return end
	if s1.sourceTab == "Shop" then return end
	if not Tabs.IsActive then return end
end
local function stopOverlay(v5) -- proto[2], line 91
	if not v5.cleanup then return end
	v5.cleanup = nil
end
local function finish(v6) -- proto[3], line 98  -- upvalues: U0
	local U0
	if v6.cleanup then
		v6.cleanup = nil
	end
	if U0 ~= v6 then return end
	U0 = nil
end
local s2
local function selectPlayer(v7, v8) -- proto[6], line 105  -- upvalues: U0, s1, Players, Toast, GameFlags, CashPacks, HttpService, PendingPurchaseHandler, Remotes, closePicker
	local Text
	if U0 ~= v7 then return end
	if s1 then return end
	if v8.Parent ~= Players then
		Text = { Text = "That player has left the server.", Seconds = 5 }
		return
	end
	if not (GameFlags.StorefrontOpen.Get) then
		local Text_2 = { Text = "Purchases are temporarily disabled.", Seconds = 5 }
		return
	end
	if v7.cashSlot then
		if CashPacks.GetShownAmount == nil then
			local Text_3 = { Text = "That player's cash packs are still loading. Please try again.", Seconds = 5 }
			return
		end
	end
	local productId = {}
	productId.productId = (v7 ^ "Parent").productId
	productId.token = HttpService.GenerateGUID
	productId.cleanup = PendingPurchaseHandler.observePendingPurchase
	s1 = productId
	s2 = productId
	local function anon4() -- proto[4], line 131  -- upvalues: s1, s2, Toast
		if s1 ~= s2 then return end
		if s2.cleanup then
			s2.cleanup = nil
		end
		if s1 == s2 then
			s1 = nil
		end
		local Text = { Text = "Your gift is still awaiting confirmation. Delivery may be delayed; please check before trying again.", Seconds = 5 }
	end
	local v7 = (v7 ^ "Parent")
	if s1 ~= productId then return end
	if pcall then
		if productId.cleanup then
			productId.cleanup = nil
		end
		if s1 == productId then
			s2 = nil
			s1 = s2
		end
		if pcall then
			if (type(anon4)) == "string" then
				s2 = anon4
			end
		end
		local Text_4 = { Text = "Could not start this gift. Please try again.", Seconds = 5 }
		return
	end
end
local f2 = nil
local LocalPlayer = Players.LocalPlayer
function s1.Open(v9, v10) -- proto[15], line 165  -- upvalues: f2, Toast, Gamepasses, GiftProductsMapping, s1, Tabs, MenuNavigation, GiftingPopUp, GiftingPopUp_2, ScrollingFrame, ScrollingFrame_2, ScrollingFrame_3, GiftingPopUp_3, Frame, GuiService, Trove, CashPacks, closePicker, PlatformController, LocalPlayer, PlayerTemplate, Simple, ButtonFX, selectPlayer, Players
	local Toast_2
	local Text
	if f2 then
		Text = { Text = "Finish your current gift purchase first.", Seconds = 5 }
		return
	end
	local v_u2 = v10
	if 0 <= 0 then
		Toast_2 = Toast.Show
		local Text_2 = { Text = "Gifting is not available for this item yet.", Seconds = 5 }
		return
	end
	if s1 then
		Toast_2 = s1.sourceTab
	else
		Toast_2 = Tabs.Active
	end
	s1 = nil
	GiftingPopUp.Visible = false
	GiftingPopUp_2.Visible = false
	ScrollingFrame.Position = ScrollingFrame_2
	ScrollingFrame.Size = ScrollingFrame_3
	GiftingPopUp.Header.Title.Text = GiftingPopUp_3
	Frame.Visible = true
	if GuiService.SelectedObject then
		if GuiService.SelectedObject.IsDescendantOf then
			GuiService.SelectedObject = nil
		end
	end
	local sourceTab = { sourceTab = Toast_2, trove = Trove.new, rows = {}, kind = (v9 ^ "Show"), itemId = v10, productId = 0, cashSlot = nil }
	s1 = sourceTab
	if sourceTab.cashSlot then
		GiftingPopUp.Header.Title.Text = "Gift " .. CashPacks.Offers[sourceTab.cashSlot].DisplayName
		GiftingPopUp_2.Visible = true
		ScrollingFrame.Size = UDim2.new
	end
	Frame.Visible = false
	GiftingPopUp.Visible = true
	ScrollingFrame.CanvasPosition = Vector2.zero
	local s1 = sourceTab
	local v_u2
	local function sortRows() -- proto[9], line 207  -- upvalues: s1, PlatformController, MenuNavigation, GuiService, GiftingPopUp
		local _r0 = {}
		for _v4 in ipairs(s1.rows) do
			table.insert(_r0, _k4)
		end
		-- anon8 captures:
		for _k4, _v5 in ipairs(_r0) do
			s1.rows[_v5].card.LayoutOrder = _k4
		end
		if not PlatformController.IsConsole then return end
		if MenuNavigation.IsCursorActive then return end
		if GuiService.SelectedObject then
			if GuiService.SelectedObject.IsDescendantOf then return end
		end
		GuiService.GuiNavigationEnabled = true
		if (_r0[1]) then
			v_u2 = s1.rows[_r0[1]].card
			v_u2 = v_u2.Select
		else
			v_u2 = GiftingPopUp.Close
		end
		GuiService.SelectedObject = v_u2
	end
	local v9
	local Clone
	local function addPlayer(v11) -- proto[12], line 234  -- upvalues: LocalPlayer, s1, s1, Trove, PlayerTemplate, ScrollingFrame, CashPacks, Simple, ButtonFX, selectPlayer, sortRows
		if v11 == LocalPlayer then return end
		if s1.rows[v11] then return end
		if s1 ~= s1 then return end
		local t1 = tostring(v11.UserId)
		PlayerTemplate.Clone.Name = t1
		PlayerTemplate.Clone.PlayerNickName.Text = v11.DisplayName
		PlayerTemplate.Clone.PlayerName.Text = "@" .. v11.Name
		PlayerTemplate.Clone.PlayerIcon.Image = (("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(v11.UserId))
		if (PlayerTemplate.Clone).FindFirstChild then
			if ((PlayerTemplate.Clone).FindFirstChild).IsA then
				(PlayerTemplate.Clone).FindFirstChild.Visible = false
			end
		end
		PlayerTemplate.Clone.Visible = true
		PlayerTemplate.Clone.Parent = ScrollingFrame
		if s1.cashSlot then
			PlayerTemplate.Clone.Size = UDim2.new
			v11 = (v11 ^ "rows")
			Clone = PlayerTemplate.Clone
			local function refreshGiftAmount() -- proto[10], line 258  -- upvalues: CashPacks, v11, s1, Clone, Simple
				Clone.Select.Title.Text = "Loading..."
			end
			local s2 = s1.cashSlot
			PlayerTemplate.Clone.Select.Title.Text = "Loading..."
		end
		Trove.new:Add(ButtonFX(PlayerTemplate.Clone.Select, nil, function()
		end))
		local card = { card = PlayerTemplate.Clone, trove = Trove.new }
		s1.rows[((v11 ^ "rows") * (v11 ^ "rows"))] = card
	end
	if ((v9 ^ "Show") * (v9 ^ "Show")) <= K[990119757] then
		-- FORGPREP_INEXT R7 iter=ipairs(Players:GetPlayers) -> pc277
		if next ~= nil then return end
		local Text_3 = { Text = "There are no other players in this server yet.", Seconds = 5 }
	end
end
function s1.Bind(v13, v14, v15) -- proto[17], line 308  -- upvalues: ButtonFX, s1
	return ButtonFX(v13, nil, function()
	end)
end
ButtonFX(GiftingPopUp.Close)
GamepadBindings.Inspect(GiftingPopUp.Close)
GUI.OnActivated(GiftingPopUp.Close, function()
end)
s2 = nil
Tabs.Deactivated:Connect(function(v16)
	if v16 ~= "Shop" then return end
	s1 = nil
	GiftingPopUp.Visible = false
	GiftingPopUp_2.Visible = false
	ScrollingFrame.Position = ScrollingFrame_2
	ScrollingFrame.Size = ScrollingFrame_3
	GiftingPopUp.Header.Title.Text = GiftingPopUp_3
	Frame.Visible = true
	if GuiService.SelectedObject then
		if GuiService.SelectedObject.IsDescendantOf then
			GuiService.SelectedObject = nil
		end
	end
	if not s2 then return end
	if not s2.cleanup then return end
	s2.cleanup = nil
end)
local r6 = r1:GetPropertyChangedSignal("Enabled")
ReplicatedStorage = r1
r6:Connect(function()
	if ReplicatedStorage.Enabled then return end
	s1 = nil
	GiftingPopUp.Visible = false
	GiftingPopUp_2.Visible = false
	ScrollingFrame.Position = ScrollingFrame_2
	ScrollingFrame.Size = ScrollingFrame_3
	GiftingPopUp.Header.Title.Text = GiftingPopUp_3
	Frame.Visible = true
	if GuiService.SelectedObject then
		if GuiService.SelectedObject.IsDescendantOf then
			GuiService.SelectedObject = nil
		end
	end
	if not s2 then return end
	if not s2.cleanup then return end
	s2.cleanup = nil
end)
Remotes.Gifting.PromptFinished.OnClientEvent:Connect(function(v17, v18)
	if not s1 then return end
	if s1.productId ~= v17 then return end
	if s1.token ~= v18 then return end
	if s1.cleanup then
		s1.cleanup = nil
	end
	if s1 == s1 then
		s1 = nil
	end
end)
Remotes.Gifting.Completed.OnClientEvent:Connect(function(v19, v20, v21, v22)
	if s2[v21] then return end
	s2[v21] = true
	if not s1 then return end
	if s1.productId ~= v19 then return end
	if s1.token ~= v22 then return end
	if s1.cleanup then
		s1.cleanup = nil
	end
	if s1 == s1 then
		s1 = nil
	end
end)
return s1