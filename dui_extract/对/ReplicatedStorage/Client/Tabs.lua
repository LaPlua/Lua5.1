-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Tabs
-- ============================================

-- bytecode
-- Original size: 17398 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 150, Protos: 40, Main proto: 39

-- ============== SOURCE ==============
-- main chunk (proto[39], line 1)
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local BossEventFlags = require(ReplicatedStorage.Shared.Flags.BossEventFlags)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local GUI = require(ReplicatedStorage.Client.GUI)
local GamepadBindings = require(ReplicatedStorage.Client.GamepadBindings)
local PlatformController = require(ReplicatedStorage.Client.PlatformController)
local Signal = require(ReplicatedStorage.Packages.Signal)
local r1 = UDim2.fromScale(0.5, 0.5)
local r2 = NumberRange.new(24, 160)
local r3 = TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local r4 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local BossMastery = { BossMastery = true, BossShop = true }
local Activated = { Activated = (Signal.new()), Deactivated = (Signal.new()) }
local s1 = {}
local function animate(v1, v2, v3, v4) -- proto[0], line 75  -- upvalues: TweenService
	if v4 then
		for _k7, _v8 in ipairs(v3) do
			v1[_k7] = _v8
		end
		return nil
	end
	return TweenService.Create
end
local Parent = assert(Workspace.CurrentCamera, "Tabs requires Workspace.CurrentCamera")
local BlurEffect = Instance.new("BlurEffect")
BlurEffect.Enabled = false
BlurEffect.Name = "MenuBackdropBlur"
BlurEffect.Size = 0
BlurEffect.Parent = Parent
local s2 = {}
local function drive(v5, v6, v7, v8, v9) -- proto[1], line 102  -- upvalues: s2, TweenService
	if s2[v5] ~= nil then
		s2[v5] = nil
	end
	if v9 then
		for _k10, _v11 in ipairs(v8) do
			v6[_k10] = _v11
		end
	end
	if TweenService.Create == nil then return TweenService.Create end
	s2[v5] = TweenService.Create
	return TweenService.Create
end
local service = _r20
local function tabletLayout() -- proto[2], line 121  -- upvalues: PlatformController, service
	local PlatformController_2 = PlatformController.IsMobile
	if not PlatformController_2 then return f1 end
	local f1 = false  -- skip 1
	f1 = true
	return f1
end
local f2 = false
local function parkPlayerList() -- proto[3], line 126  -- upvalues: f2, PlatformController, service, StarterGui
	local f1
	if f2 then return end
	local PlatformController_2 = PlatformController.IsMobile
	if PlatformController_2 then
		f1 = false  -- skip 1
		f1 = true
	end
	if not (f1) then return end
	if not StarterGui.GetCoreGuiEnabled then return end
	f2 = true
end
local function unparkPlayerList() -- proto[4], line 136  -- upvalues: f2, StarterGui
	if not f2 then return end
	f2 = false
end
r2 = r4
local function blurIn(v10) -- proto[5], line 144  -- upvalues: BlurEffect, r2, s2, TweenService
	BlurEffect.Enabled = true
	local Size = { Size = 14 }
	local v_u1 = s2.blur
	if v_u1 ~= nil then
		s2.blur = nil
	end
	if v10 then
		for _k9, _v10 in ipairs(Size) do
			BlurEffect[_k9] = _v10
		end
	end
	if TweenService.Create == nil then return end
	s2.blur = TweenService.Create
end
local function blurOut(v11) -- proto[6], line 149  -- upvalues: BlurEffect, r2, s2, TweenService
	local Size = { Size = 0 }
	local v_u2 = s2.blur
	if v_u2 ~= nil then
		s2.blur = nil
	end
	if v11 then
		for _k9, _v10 in ipairs(Size) do
			BlurEffect[_k9] = _v10
		end
	end
	if TweenService.Create == nil then return TweenService.Create end
	s2.blur = TweenService.Create
	return TweenService.Create
end
local function pushFieldOfView(v12) -- proto[7], line 156  -- upvalues: f2, service, r2, s2, TweenService
	f2 = service.FieldOfView
	local FieldOfView = {}
	FieldOfView.FieldOfView = (service.FieldOfView + 5)
	local v_u2 = s2.fieldOfView
	if v_u2 ~= nil then
		s2.fieldOfView = nil
	end
	if v12 then
		for _k10, _v11 in ipairs(FieldOfView) do
			service[_k10] = _v11
		end
	end
	if TweenService.Create == nil then return end
	s2.fieldOfView = TweenService.Create
end
local function restoreFieldOfView(v13) -- proto[8], line 162  -- upvalues: U0, service, r2, s2, TweenService
	if U0 == nil then return end
	local FieldOfView = {}
	FieldOfView.FieldOfView = U0
	local v_u2 = s2.fieldOfView
	if v_u2 ~= nil then
		s2.fieldOfView = nil
	end
	if v13 then
		for _k10, _v11 in ipairs(FieldOfView) do
			service[_k10] = _v11
		end
	end
	if TweenService.Create == nil then return end
	s2.fieldOfView = TweenService.Create
end
local index = 0
local FieldOfView = nil
local function raiseBackdrop(v14, v15) -- proto[9], line 169  -- upvalues: index, FieldOfView, service, BlurEffect, r2, s2, TweenService, f2, PlatformController, StarterGui
	local f3
	index = (index + 1)
	FieldOfView = service.FieldOfView
	BlurEffect.Enabled = true
	local Size = { Size = 14 }
	local v_u2 = s2.blur
	if v_u2 ~= nil then
		s2.blur = nil
	end
	if v15 then
		for _k10, _v11 in ipairs(Size) do
			BlurEffect[_k10] = _v11
		end
	end
	if TweenService.Create ~= nil then
		s2.blur = TweenService.Create
	end
	if not (v14.holdCamera) then
		FieldOfView = service.FieldOfView
		local FieldOfView_2 = {}
		FieldOfView_2.FieldOfView = (service.FieldOfView + 5)
		local v_u3 = s2.fieldOfView
		if v_u3 ~= nil then
			s2.fieldOfView = nil
		end
		if v15 then
			for _k11, _v12 in ipairs(FieldOfView_2) do
				service[_k11] = _v12
			end
		end
		if TweenService.Create ~= nil then
			s2.fieldOfView = TweenService.Create
		end
	end
	if f2 then return end
	local PlatformController_2 = PlatformController.IsMobile
	if PlatformController_2 then
		f3 = false  -- skip 1
		f3 = true
	end
	if not (f3) then return end
	if not StarterGui.GetCoreGuiEnabled then return end
	f2 = true
end
local function lowerBackdrop(v16) -- proto[11], line 179  -- upvalues: index, BlurEffect, U2, service, r2, s2, TweenService, f2, StarterGui
	local U2
	local v_u4 = s2.fieldOfView
	index = (index + 1)
	local index_2 = index
	local function forget() -- proto[10], line 183  -- upvalues: index, index_2, BlurEffect, U3
		local U3
		if index ~= index_2 then return end
		BlurEffect.Enabled = false
		U3 = nil
	end
	if U2 ~= nil then
		local FieldOfView = {}
		FieldOfView.FieldOfView = U2
		if v_u4 ~= nil then
			s2.fieldOfView = nil
		end
		if v16 then
			for _k12, _v13 in ipairs(FieldOfView) do
				service[_k12] = _v13
			end
		end
		if TweenService.Create ~= nil then
			s2.fieldOfView = TweenService.Create
		end
	end
	local Size = { Size = 0 }
	local v_u4 = s2.blur
	if v_u4 ~= nil then
		s2.blur = nil
	end
	if v16 then
		for _k11, _v12 in ipairs(Size) do
			BlurEffect[_k11] = _v12
		end
	end
	if TweenService.Create ~= nil then
		s2.blur = TweenService.Create
	end
	if not (TweenService.Create) then
		if index == index then
			BlurEffect.Enabled = false
			U2 = nil
		end
	end
	if not f2 then return end
	f2 = false
end
local r5 = Workspace:GetPropertyChangedSignal("CurrentCamera")
r5:Connect(function()
	if Workspace.CurrentCamera == nil then return end
	if Workspace.CurrentCamera == service then return end
	service = Workspace.CurrentCamera
	BlurEffect.Parent = Workspace.CurrentCamera
end)
local s3 = {}
local function anon13(v17) -- proto[13], line 211
	return v17:FindFirstChild("Frame")
end
local function anon15(v19) -- proto[15], line 217
	return v19:FindFirstChildWhichIsA("ImageLabel")
end
s3[1], s3[2], s3[3] = anon13, function(v18)
	return v18:FindFirstChildOfClass("Frame")
end, anon15
local function stageFor(v20) -- proto[16], line 222  -- upvalues: s1
	local v1_e = s1[v20]
	if v1_e then return v1_e end
	local generation = { generation = 0, wired = false }
	s1[v20] = generation
	return generation
end
local function dropCloser(v21) -- proto[17], line 232
	local closer = v21.closer
	if not closer then return end
	v21.closer = nil
end
local function screenNamed(v22) -- proto[18], line 240  -- upvalues: GUI
	assert(GUI.Get.IsA, (("tab %* must resolve to a ScreenGui"):format(v22)))
	return GUI.Get
end
local function bodyOf(v23) -- proto[19], line 246  -- upvalues: s3
	for _k4, _v5 in ipairs(s3) do
		if not _v5 then continue end
		if _v5.IsA then return _v5 end
	end
	local r6 = ("tab %* has no GuiObject body"):format(v23.Name)
end
local function scaleOf(v24) -- proto[20], line 257
	if v24.FindFirstChild then
		if (v24.FindFirstChild).IsA then return v24.FindFirstChild end
		if v24.FindFirstChildOfClass then return v24.FindFirstChildOfClass end
		Instance.new.Name = "MenuScale"
		Instance.new.Parent = v24
		return Instance.new
	end
end
local function specOf(v25) -- proto[21], line 272
	local f3
	local holdCamera = {}
	f3 = not (v25.GetAttribute ~= true)
	holdCamera.holdCamera = f3
	f3 = not (v25.GetAttribute ~= true)
	holdCamera.selfAnimated = f3
	f3 = not (v25.GetAttribute ~= true)
	holdCamera.snapClose = f3
	return holdCamera
end
local function entryTravel(v26) -- proto[22], line 280  -- upvalues: service, r2
	return (math.clamp(((service.ViewportSize.Y / 2) * 0.18), r2.Min, r2.Max))
end
local function loweredPose(v27) -- proto[23], line 288  -- upvalues: r1, service, r2
	local r7 = math.clamp(((service.ViewportSize.Y / 2) * 0.18), r2.Min, r2.Max)
	return (r1 + UDim2.fromOffset)
end
local function closeButtonOf(v28) -- proto[24], line 292
	local FindFirstChild
	if v28.FindFirstChild == nil then
		if (v28.FindFirstChildWhichIsA) then
			FindFirstChild = (v28.FindFirstChildWhichIsA).FindFirstChild
		else
			FindFirstChild = nil
		end
	end
	if FindFirstChild == nil then return nil end
	local w1 = FindFirstChild.IsA
	assert(w1, (("%* must be a GuiButton"):format(FindFirstChild.GetFullName)))
	return FindFirstChild
end
local s4 = Activated
local function wireCloseButton(v29, v30) -- proto[26], line 306  -- upvalues: closeButtonOf, ButtonFX, GUI, s4, GamepadBindings
	if v29.wired then return end
	v29.wired = true
end
local function releaseFocus(v31) -- proto[27], line 322  -- upvalues: GuiService
	if GuiService.SelectedObject == nil then return end
	if not GuiService.SelectedObject.IsDescendantOf then return end
	GuiService.SelectedObject = nil
	GuiService.GuiNavigationEnabled = false
end
local s5 = BossMastery
local function admitted(v32) -- proto[28], line 330  -- upvalues: s5, BossEventFlags
	local f4
	if s5[v32] ~= true then return f4 end
	f4 = not (BossEventFlags.ContentEnabled.Get ~= true)
	return f4
end
r3 = r2
local function exit(v33, v34) -- proto[31], line 336  -- upvalues: s1, GUI, specOf, bodyOf, U4, GuiService, r2, TweenService, r1, service, r3, lowerBackdrop, s4
	local U4, v_u4
	local generation
	if not ((s1[v33])) then
		generation = { generation = 0, wired = false }
		s1[v33] = generation
	end
	assert(GUI.Get.IsA, (("tab %* must resolve to a ScreenGui"):format(v33)))
	if bodyOf.FindFirstChild then
		if not ((bodyOf.FindFirstChildOfClass)) then
			Instance.new.Name = "MenuScale"
			Instance.new.Parent = bodyOf
		end
	end
	if v34.instant ~= true then
		v_u4 = specOf.snapClose
	end
	generation.generation = (generation.generation + 1)
	local closer = generation.closer
	if closer then
		generation.closer = nil
	end
	U4 = nil
	local v_u5 = GuiService.SelectedObject
	if v_u5 ~= nil then
		if v_u5.IsDescendantOf then
			GuiService.SelectedObject = nil
			GuiService.GuiNavigationEnabled = false
		end
	end
	local s2 = generation
	local generation = generation.generation
	local Get = GUI.Get
	local function settle() -- proto[29], line 351  -- upvalues: s2, generation, Get
		if s2.generation ~= generation then return end
		local closer = s2.closer
		if closer then
			s2.closer = nil
		end
		Get.Enabled = false
	end
	if specOf.selfAnimated then
		if not (v_u4) then
			if generation.generation == generation.generation then
				closer = generation.closer
				if closer then
					generation.closer = nil
				end
				GUI.Get.Enabled = false
			else
				if ((v33 ^ "generation") * (v33 ^ "generation")) > K[251792176] then return end
			end
		else
			if v_u4 then
				Instance.new.Scale = 0.9
				if generation.generation == generation.generation then
					closer = generation.closer
					if closer then
						generation.closer = nil
					end
					GUI.Get.Enabled = false
				else
					local Scale = { Scale = 0.9 }
					local Position = {}
					local r7 = math.clamp(((service.ViewportSize.Y / 2) * 0.18), r3.Min, r3.Max)
					Position.Position = (r1 + UDim2.fromOffset)
				end
			end
		end
	end
	local instant = { instant = v_u4, replacedBy = v34.replacedBy }
	-- FORGPREP R0 iter=((v33 ^ "generation") * (v33 ^ "generation"))[1] -> pc290
end
r4 = r3
local function enter(v35, v36) -- proto[32], line 388  -- upvalues: s1, GUI, specOf, bodyOf, wireCloseButton, U5, index, FieldOfView, service, BlurEffect, r2, s2, TweenService, f2, PlatformController, StarterGui, r1, r3, r4, s4
	local U5
	local v_u6
	local generation
	if not ((s1[v35])) then
		generation = { generation = 0, wired = false }
		s1[v35] = generation
	end
	assert(GUI.Get.IsA, (("tab %* must resolve to a ScreenGui"):format(v35)))
	if bodyOf.FindFirstChild then
		if not ((bodyOf.FindFirstChildOfClass)) then
			Instance.new.Name = "MenuScale"
			Instance.new.Parent = bodyOf
		end
	end
	generation.generation = (generation.generation + 1)
	local closer = generation.closer
	if closer then
		generation.closer = nil
	end
	U5 = ((v35 ^ "generation") * (v35 ^ "generation"))
	GUI.Get.Enabled = true
	index = (index + 1)
	FieldOfView = service.FieldOfView
	local w2 = ((v35 ^ "generation") * (v35 ^ "generation"))
	BlurEffect.Enabled = true
	local Size = { Size = 14 }
	local v_u5 = s2.blur
	if v_u5 ~= nil then
		s2.blur = nil
	end
	if v36 then
		for _k15, _v16 in ipairs(Size) do
			BlurEffect[_k15] = _v16
		end
	end
	if TweenService.Create ~= nil then
		s2.blur = TweenService.Create
	end
	if not (specOf.holdCamera) then
		FieldOfView = service.FieldOfView
		local FieldOfView_2 = {}
		FieldOfView_2.FieldOfView = (service.FieldOfView + 5)
		v_u6 = s2.fieldOfView
		if v_u6 ~= nil then
			s2.fieldOfView = nil
			if w2 > K[590094] then
				for _k16, _v17 in ipairs(FieldOfView_2) do
					service[_k16] = _v17
				end
			end
		end
		if TweenService.Create ~= nil then
			s2.fieldOfView = TweenService.Create
		end
	end
	if not (f2) then
		local f5 = false  -- skip 1
		if StarterGui.GetCoreGuiEnabled then
			f2 = true
		end
	end
	if specOf.selfAnimated then
		bodyOf.Position = r1
	elseif v36 then
		bodyOf.Position = r1
		Instance.new.Scale = 1
	else
		v_u6 = math.clamp(((service.ViewportSize.Y / 2) * 0.18), r3.Min, r3.Max)
		bodyOf.Position = (r1 + UDim2.fromOffset)
		Instance.new.Scale = 0.96
		local Position = {}
		Position.Position = r1
		local Scale = { Scale = 1 }
		-- FORGPREP R0 iter=w2[1] -> pc331
	end
	local instant = {}
	instant.instant = v36
end
function Activated.Active() -- proto[33], line 421  -- upvalues: U0
	return U0
end
function Activated.IsActive(v37) -- proto[34], line 425  -- upvalues: U0
	local f4
	if U0 == nil then return f4 end
	if v37 == nil then return f4 end
	f4 = not (U0 ~= v37)
	return f4
end
function Activated.Activate(v38, v39) -- proto[35], line 430  -- upvalues: U0, s5, BossEventFlags, exit, enter
	if U0 == v38 then return false end
	if s5[v38] == true then
		if BossEventFlags.ContentEnabled.Get ~= true then return false end
		if U0 ~= nil then
			local instant = { instant = true, replacedBy = v38 }
		end
	end
	return true
end
function Activated.Deactivate(v40) -- proto[36], line 442  -- upvalues: U0, exit
	local f6
	if U0 == nil then return end
	local instant = {}
	if v40 ~= nil then
		f6 = not (v40.instant ~= true)
	end
	instant.instant = f6
end
function Activated.Toggle(v41, v42) -- proto[37], line 449  -- upvalues: s4, U1
	if s4.Activate then return end
	if U1 ~= v41 then return end
end
BossEventFlags.ContentEnabled.Changed:Connect(function()
	if index == nil then return end
	if s5[index] == true then
		if BossEventFlags.ContentEnabled.Get == true then return end
		local instant = { instant = true }
	end
end)
return table.freeze(Activated)