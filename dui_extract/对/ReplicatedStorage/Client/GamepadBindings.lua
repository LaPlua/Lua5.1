-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.GamepadBindings
-- ============================================

-- bytecode
-- Original size: 17251 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 197, Protos: 43, Main proto: 42

-- ============== SOURCE ==============
-- main chunk (proto[42], line 1)
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local ConsoleSignals = require(ReplicatedStorage.Client.ConsoleSignals)
local GUI = require(ReplicatedStorage.Client.GUI)
local InputIconsConfig = require(ReplicatedStorage.Client.InputIconsConfig)
local Log = require(ReplicatedStorage.Packages.Log)
local MenuNavigation = require(ReplicatedStorage.Client.MenuNavigation)
local PlatformController = require(ReplicatedStorage.Client.PlatformController)
local _r11 = {Enum.KeyCode.ButtonA, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonX, Enum.KeyCode.ButtonY, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonL2, Enum.KeyCode.ButtonL3, Enum.KeyCode.ButtonR1, Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonR3, Enum.KeyCode.ButtonSelect, Enum.KeyCode.ButtonStart, Enum.KeyCode.DPadDown, Enum.KeyCode.DPadLeft, Enum.KeyCode.DPadRight, Enum.KeyCode.DPadUp}
local _r12 = {}
_r12[Enum.KeyCode.ButtonStart] = true
local s1 = {}
s1[Enum.KeyCode.DPadDown] = true
s1[Enum.KeyCode.DPadLeft] = true
s1[Enum.KeyCode.DPadRight] = true
s1[Enum.KeyCode.DPadUp] = true
local s2 = {}
local s3 = {}
for _k19, _v20 in ipairs(_r11) do
	s2[_v20.Name] = _v20
	s3[_v20] = true
end
assert(s3[Enum.KeyCode.ButtonB], "the close key has to be a routable key")
local ActivePets = { ActivePets = { rank = 900, captionedClose = true }, BackpackGui = { blocked = true }, BossMastery = { captionedClose = true }, BossShop = { captionedClose = true }, DropHeldEgg = { rank = 200 }, FreeGift = { captionedClose = true }, GrowingEggs = { rank = 900, captionedClose = true }, Index = { captionedClose = true }, LimitedTimePopupsUI = { captionedClose = true }, Message = { rank = 1000 }, MonsterChestRewards = { captionedClose = true }, PetFuse = { captionedClose = true }, PhoneVideoUI = { blocked = true }, PopupPrompt = { captionedClose = true }, RescueDragonFTUEQuest = { captionedClose = true }, RiftTradeIn = { captionedClose = true }, DrScrambleTradeIn = { captionedClose = true }, RobuxShop = { captionedClose = true }, RobuxShopOLD = { blocked = true }, OldRobuxShop = { blocked = true }, RunButton = { rank = 100 }, ScrambleBossMastery = { captionedClose = true }, SellPrompt = { captionedClose = true }, Settings = { captionedClose = true }, SpeedShop = { blocked = true }, TrailShop = { captionedClose = true }, Treadmill = { blocked = true }, TreadmillScreenButtonSwapLeft = { blocked = true }, TreadmillScreenButtonSwapRight = { blocked = true }, TreadmillScreenComments = { blocked = true }, TreadmillUI = { blocked = true } }
local s4 = {}
local r1 = table.freeze(s4)
local microsoft = { microsoft = "B", sony = "O" }
local r2 = Log.new()
local r3 = GUI.PlayerGui()
local s5 = {}
local s6 = {}
local s7 = {}
local s8 = {}
local function describe(v1) -- proto[0], line 140
	if v1 == nil then return "none" end
	return v1.GetFullName
end
local s9 = ActivePets
local function policyOf(v2) -- proto[1], line 144  -- upvalues: s9, r1
	local v1_e = s9[v2]
	return (s9[v2] or r1)
end
local function screenOf(v3) -- proto[2], line 148
	if v3.IsA then return v3 end
	return v3.FindFirstAncestorOfClass
end
local f1
local function blocked(v4) -- proto[3], line 154  -- upvalues: s9, r1
	local w1 = v4.FindFirstAncestorWhichIsA
	if w1 == nil then return f1 end
	local v1_e = s9[w1.Name]
	f1 = not ((s9[v4.FindFirstAncestorWhichIsA.Name] or r1).blocked ~= true)
	return f1
end
local showing = <closure K115>
local function showing(v5) -- proto[4], line 163  -- upvalues: showing
	if v5.IsA then return v5.Enabled end
	if v5.IsA then
		if not (v5.Visible) then return false end
		local w2 = v5.Parent
		if w2 == nil then return showing end
		return showing
	end
end
local ownerAbove = <closure K116>
local function ownerAbove(v6) -- proto[5], line 176  -- upvalues: ownerAbove
	if v6.Parent == nil then return nil end
	if v6.Parent.IsA then return nil end
	if v6.Parent.IsA then return v6.Parent end
	return ownerAbove
end
local function rankOf(v7) -- proto[6], line 184  -- upvalues: s9, r1
	local v1_e = s9[v7.Name]
	return (((s9[v7.Name] or r1).rank or v7.DisplayOrder))
end
local function keyFrom(v8) -- proto[7], line 188  -- upvalues: s2, s3
	local w2 = s2[v8]
	local r4 = typeof(v8)
	if s2[v8] ~= nil then
		if s3[w2] then return w2 end
	end
	local r5 = ("%* is not a key this router knows"):format((tostring(v8)))
	return w2
end
s4 = microsoft
local f2 = nil
local function closeCaption() -- proto[8], line 200  -- upvalues: s4, f2, InputIconsConfig
	if f2 then return s4[InputIconsConfig.Vendor] end
	return s4[InputIconsConfig.Vendor]
end
local function artFor(v9) -- proto[9], line 204  -- upvalues: s7, InputIconsConfig
	if s7[v9] ~= nil then return s7[v9] end
	s7[v9] = (InputIconsConfig.Image or "")
	return (InputIconsConfig.Image or "")
end
local function applyLook(v10) -- proto[10], line 214  -- upvalues: s6, PlatformController, InputIconsConfig, ButtonB, s4, f2
	local w1
	local w3
	if s6[v10] == nil then return end
	if s6[v10].image ~= nil then
		if v10.IsA then
			if PlatformController.IsConsole then
				w1 = s6[v10].image
				w3 = s6[v10].caption
			end
			v10.Image = w1
		end
		if w3 ~= nil then
			if v10.IsA then
				(v10 ^ "IsConsole").Text = w3
			end
		end
	end
	(v10 ^ "IsConsole").Visible = (PlatformController.IsConsole or s6[v10].visible)
end
local function remember(v11, v12) -- proto[12], line 231  -- upvalues: s6, applyLook
	if s6[v11] == nil then
		s6[v11] = v12
		local function anon11() -- proto[11], line 234  -- upvalues: s6, v11
			s6[v11] = nil
		end
	end
end
local function rememberCaption(v13) -- proto[13], line 241  -- upvalues: s6, applyLook
	if v13 == nil then return end
	if not v13.IsA then return end
	local visible = { visible = v13.Visible, caption = v13.Text }
	if s6[v13] == nil then
		s6[v13] = visible
		local function anon11() -- proto[11], line 234  -- upvalues: s6, v13
			s6[v13] = nil
		end
	end
end
local function decorateClose(v14, v15) -- proto[14], line 249  -- upvalues: s6, applyLook
	local visible
	local v14 = v14.FindFirstChild
	if v14.FindFirstChild ~= nil then
		if (v14.FindFirstChild).IsA then
			visible = { visible = v14.FindFirstChild.Visible, image = v14.FindFirstChild.Image }
			if s6[v14.FindFirstChild] == nil then
				s6[v14.FindFirstChild] = visible
				local function anon11() -- proto[11], line 234  -- upvalues: s6, v14
					s6[v14] = nil
				end
			end
			return
		end
	end
	local w1 = v14.FindFirstChild
	if w1 ~= nil then
		if w1.IsA then
			local visible_2 = { visible = w1.Visible, caption = w1.Text }
			if s6[w1] == nil then
				s6[w1] = visible_2
				-- anon11 captures: s6, v14
			end
		end
	end
	if not v15 then return end
	if w1 == nil then return end
	if w1.FindFirstChild == nil then return end
	if not (w1.FindFirstChild).IsA then return end
	local visible_3 = { visible = w1.FindFirstChild.Visible, caption = w1.FindFirstChild.Text }
	if s6[w1.FindFirstChild] == nil then
		s6[w1.FindFirstChild] = visible_3
		-- anon11 captures: s6, v14
	end
end
local function paintGlyph(v16, v17) -- proto[15], line 267  -- upvalues: PlatformController, s7, InputIconsConfig
	local f3
	if PlatformController.IsConsole then
		f3 = not (v16.GetAttribute == true)
	end
	v16.Visible = f3
	if not PlatformController.IsConsole then return end
	if not (v16.IsA) then
		if not v16.IsA then return end
	end
	if not ((s7[v17] ~= nil)) then
		s7[v17] = (InputIconsConfig.Image or "")
	end
	(v16 ^ "IsConsole").Image = (InputIconsConfig.Image or "")
end
local function releaseClaimsOn(v18) -- proto[16], line 278  -- upvalues: s8
	for _k4, _v5 in ipairs(s8) do
		if _v5 ~= v18 then continue end
		s8[_k4] = nil
	end
end
local function bind(v19, v20, v21, v22) -- proto[18], line 286  -- upvalues: s5, s8
	local w1 = v19.FindFirstAncestorOfClass
	local _r4 = assert(w1, (("%* needs a ScreenGui above it to take gamepad input"):format("none")))
	local key = { key = v20, closes = v22, glyph = v21, owner = v19, screen = _r4 }
	s5[v19] = key
end
local function adoptGlyph(v23) -- proto[19], line 311  -- upvalues: s2, ownerAbove, bind, paintGlyph
	local f4
	local ownerAbove_2
	local f3 = not ((typeof(v23.GetAttribute)) ~= "string")
	local r5 = ("%* needs a string GamepadKey attribute"):format("none")
	local w2 = v23.GetAttribute
	assert(f3, r5)
	f4 = not (s2[w2] == nil)
	assert(f4, (("%*: %* is not a key this router knows"):format("none", w2)))
	if v23.Parent ~= nil then
		ownerAbove_2 = nil
		local w1 = v23.Parent
		local w3 = v23.Parent.IsA
		if w3 then
			ownerAbove_2 = w1
		end
		local _r3 = assert(ownerAbove_2, (("%* has to sit under a GuiButton"):format("none")))
	end
end
local function adoptClose(v24) -- proto[20], line 330  -- upvalues: decorateClose, s9, r1, bind, ButtonB
	local w1 = v24.FindFirstAncestorOfClass
	local v1_e = s9[(assert(w1, (("close button %* needs a ScreenGui above it"):format("none")))).Name]
end
local function eligible(v25, v26) -- proto[21], line 341  -- upvalues: showing, U1, U2
	local v_u4
	local v_u3 = v25.key
	if v_u3 ~= v26 then return false end
	if not (v25.owner.IsA) then
		if v25.owner.IsA then
			if v25.owner.Parent ~= nil then
				v_u4 = v25.owner.Parent
				v_u3 = showing
			end
		end
	end
	if not (v_u3) then return false end
	if v25.glyph ~= nil then
		if not (v25.glyph.Visible) then return false end
		if U1 ~= nil then
			if v25.screen ~= U1 then return false end
			if U2 == nil then return v25.owner.IsDescendantOf end
			return v25.owner.IsDescendantOf
		end
	end
end
local function score(v27) -- proto[22], line 356  -- upvalues: s9, r1
	local v1_e = s9[v27.screen.Name]
	local r6 = ((s9[v27.screen.Name] or r1).rank or v27.screen.DisplayOrder)
	if not v27.closes then return (w4 + 1) end
	local w4 = (r6 * 2)
	return (w4 + 1)
end
local function claimantFor(v28) -- proto[23], line 360  -- upvalues: s5, eligible, s9, r1
	local w4
	local v_u5 = nil
	for _k6, _v7 in ipairs(s5) do
		if not eligible then continue end
		local v1_e = s9[_v7.screen.Name]
		local r6 = ((s9[_v7.screen.Name] or r1).rank or _v7.screen.DisplayOrder)
		if _v7.closes then
			w4 = (r6 * 2)
		end
		if -inf >= (w4 + 1) then continue end
		v_u5 = _k6
	end
	return v_u5
end
local function selectionTakesA() -- proto[24], line 374  -- upvalues: GuiService, showing
	local v_u5
	if GuiService.SelectedObject == nil then return v_u5 end
	if GuiService.SelectedObject.IsA then return GuiService.SelectedObject.Enabled end
	if GuiService.SelectedObject.IsA then
		if not (GuiService.SelectedObject.Visible) then return false end
		if GuiService.SelectedObject.Parent == nil then return v_u5 end
		v_u5 = showing
		return v_u5
	end
end
local function routes(v29) -- proto[25], line 379  -- upvalues: s3, f2, PlatformController, MenuNavigation, GuiService, showing
	local v_u5
	if not s3[v29] then return false end
	if not f2 then return false end
	if not PlatformController.IsConsole then return false end
	if MenuNavigation.IsSuspended then return false end
	if v29 ~= Enum.KeyCode.ButtonA then return true end
	if GuiService.SelectedObject ~= nil then
		if not (GuiService.SelectedObject.IsA) then
			if GuiService.SelectedObject.IsA then
				if GuiService.SelectedObject.Parent ~= nil then
					v_u5 = showing
				end
			end
		end
	end
	if v_u5 then return false end
	if not MenuNavigation.IsCursorActive then return true end
	return false
end
ReplicatedStorage = r2
local function press(v30) -- proto[26], line 398  -- upvalues: s8, routes, claimantFor, ReplicatedStorage, U4, GuiService, ConsoleSignals
	local w2
	if s8[v30] ~= nil then return true end
	if not (routes) then return false end
	if claimantFor == nil then
		if (GuiService.SelectedObject ~= nil) then
			w2 = v30.Name
		end
		local r5 = ("%*: no button answered (focus %*, selection %*)"):format(w2, "none", "none")
		return false
	end
	s8[(v30 ^ "AtDebug")] = claimantFor
	return true
end
local function release(v31, v32) -- proto[27], line 421  -- upvalues: s8, s3, PlatformController, showing, ConsoleSignals
	local v_u6
	s8[v31] = nil
	if s8[v31] == nil then return false end
	if not v32 then return true end
	if not s3[v31] then return true end
	if not PlatformController.IsConsole then return true end
	local showing_2 = s8[v31].Active
	if not showing_2 then return true end
	if s8[v31].IsA then
		showing_2 = s8[v31].Enabled
	else
		if s8[v31].IsA then
			if s8[v31].Parent ~= nil then
				v_u6 = showing
			end
		end
	end
	if not v_u6 then return true end
	return true
end
local function onRoutedKey(v33, v34, v35) -- proto[28], line 441  -- upvalues: press, s8, s3, PlatformController, showing, ConsoleSignals
	local v_u7
	local f3
	local f5
	if not (v34 == Enum.UserInputState.Begin) then
		f5 = not (v34 == Enum.UserInputState.Cancel)
		s8[v35.KeyCode] = nil
		if s8[v35.KeyCode] == nil then
			f3 = false
		else
			if f5 then
				if s3[v35.KeyCode] then
					if PlatformController.IsConsole then
						if s8[v35.KeyCode].Active then
							if s8[v35.KeyCode].IsA then
								local showing_2 = s8[v35.KeyCode].Enabled
							else
								if s8[v35.KeyCode].IsA then
									if s8[v35.KeyCode].Parent ~= nil then
										v_u7 = showing
									end
								end
							end
						end
					end
				end
			end
			f3 = true
		end
	end
	if not f3 then return Enum.ContextActionResult.Pass end
	return Enum.ContextActionResult.Sink
end
local function repaint() -- proto[29], line 454  -- upvalues: s6, applyLook, s5, paintGlyph
	for _v3 in ipairs(s6) do
		if _k3.Parent == nil then continue end
	end
	for _k3, _v4 in ipairs(s5) do
		if _v4.glyph == nil then continue end
	end
end
local function GlyphFor(v36) -- proto[30], line 470  -- upvalues: s2, s3, s7, InputIconsConfig
	local w2 = s2[v36]
	local r4 = typeof(v36)
	if s2[v36] ~= nil then
		local r5 = ("%* is not a key this router knows"):format((tostring(v36)))
	end
	if s7[w2] ~= nil then return s7[w2] end
	s7[w2] = (InputIconsConfig.Image or "")
	return (InputIconsConfig.Image or "")
end
local function IsOnScreen(v37) -- proto[31], line 474  -- upvalues: showing
	local v_u5
	if v37.IsA then return v37.Enabled end
	if v37.IsA then
		if not (v37.Visible) then return false end
		if v37.Parent == nil then return v_u5 end
		v_u5 = showing
		return v_u5
	end
end
local function TrackCloseButton(v38) -- proto[32], line 478  -- upvalues: s9, r1, adoptClose
	if v38.FindFirstAncestorWhichIsA ~= nil then
		local w3 = v38.FindFirstAncestorWhichIsA.Name
		local v1_e = s9[w3]
		if (s9[v38.FindFirstAncestorWhichIsA.Name] or r1).blocked == true then return end
	end
end
local function Inspect(v39) -- proto[33], line 484  -- upvalues: s9, r1, adoptGlyph, adoptClose
	if v39.FindFirstAncestorWhichIsA ~= nil then
		local w3 = v39.FindFirstAncestorWhichIsA.Name
		local v1_e = s9[w3]
		if (s9[v39.FindFirstAncestorWhichIsA.Name] or r1).blocked == true then return end
		if v39.Name == "GamepadGlyph" then
			if v39.IsA then
				return
			end
		end
	end
	if v39.Name ~= "Close" then return end
	local w5 = v39.IsA
	if not w5 then return end
	if (v39 ^ "LayerCollector").FindFirstAncestorOfClass == nil then return end
end
local function FocusScreen(v40, v41) -- proto[34], line 499  -- upvalues: ReplicatedStorage, U1, U2, U3
	local U1, U2
	local w2 = v40.IsDescendantOf
	assert(w2, "only a screen inside the local PlayerGui can take focus")
	if U1 == v40 then
		if U2 == v41 then return end
		U1 = v40
		U2 = v41
	end
end
local function EnableMarkers(v42) -- proto[35], line 511  -- upvalues: U0, U1
	local U0
	U0 = v42
	if v42 then return end
end
local s10 = { GlyphFor = GlyphFor, IsOnScreen = IsOnScreen, TrackCloseButton = TrackCloseButton, Inspect = Inspect, FocusScreen = FocusScreen, EnableMarkers = EnableMarkers }
function s10.Rescan(v43) -- proto[36], line 518  -- upvalues: U0, PlatformController, InputIconsConfig, U3, ReplicatedStorage, s10, repaint
	local U0
	local v_u3 = v43
	if not (v_u3) then
		v_u3 = PlatformController.Platform
	end
	U0 = nil
	for _k4, _v5 in ipairs(ReplicatedStorage.GetDescendants) do
	end
end
MenuNavigation.CursorChanged:Connect(function()
end)
PlatformController.Changed:Connect(function(v44)
end)
InputIconsConfig.Changed:Connect(function()
end)
local _r58 = {}
for _k62, _v63 in ipairs(_r11) do
	if _r12[_v63] then continue end
	table.insert(_r58, _v63)
end
ContextActionService:BindActionAtPriority("GamepadGlyphRouting", onRoutedKey, false, Enum.ContextActionPriority.High.Value, table.unpack(_r58))
UserInputService.InputBegan:Connect(function(v45)
	if U0 == nil then return end
	if not s1[v45.KeyCode] then return end
end)
UserInputService.InputEnded:Connect(function(v46)
	if U0 == nil then return end
	if not s1[v46.KeyCode] then return end
	s8[v46.KeyCode] = nil
	if s8[v46.KeyCode] == nil then return end
	if not s3[v46.KeyCode] then return end
	if not PlatformController.IsConsole then return end
	local showing_2 = s8[v46.KeyCode].Active
	if not showing_2 then return end
	if s8[v46.KeyCode].IsA then
		showing_2 = s8[v46.KeyCode].Enabled
	else
		if s8[v46.KeyCode].IsA then
			if s8[v46.KeyCode].Parent ~= nil then
				v_u6 = showing
			end
		end
	end
	if not v_u6 then return end
end)
local r7 = r2:AtInfo()
r7:Log("gamepad routing online")
return s10