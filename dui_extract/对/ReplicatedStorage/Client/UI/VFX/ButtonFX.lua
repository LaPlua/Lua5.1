-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.VFX.ButtonFX
-- ============================================

-- bytecode
-- Original size: 10437 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 148, Protos: 27, Main proto: 26

-- ============== SOURCE ==============
-- main chunk (proto[26], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GUI = require(ReplicatedStorage.Client.GUI)
local PlatformController = require(ReplicatedStorage.Client.PlatformController)
local bound = { bound = "PressBound", glyph = "PressGlyph", silent = "MuteSounds", ownedScale = "PressScaleOwner" }
local r1 = Vector2.new(0.5, 0.5)
local r2 = UDim2.fromScale(0, 0.08)
local r3 = TweenInfo.new(0.09, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local intoSunk = { intoSunk = 42, outOfSunk = 26, hover = 22 }
local volume = { id = Constants.BUTTON_FX.BUTTON_MOUSE_DOWN_SOUND, volume = 3.4, pitch = (NumberRange.new(0.93, 1.06)) }
local r4 = Random.new()
local s1 = {}
local s2 = {}
local function noop() -- proto[0], line 96
end
local connection = nil
local function stepMotions(v1) -- proto[1], line 100  -- upvalues: s2, connection
	for _k4, _v5 in ipairs(s2) do
		if _k4.Parent == nil then
			s2[_k4] = nil
			continue
		end
		local r5 = math.exp(((-_v5.stiffness) * v1))
		_v5.velocity = ((_v5.velocity - (_v5.stiffness * ((_v5.velocity + (_v5.stiffness * (_k4.Scale - _v5.target))) * v1))) * r5)
		if (math.abs((((_k4.Scale - _v5.target) + ((_v5.velocity + (_v5.stiffness * (_k4.Scale - _v5.target))) * v1)) * r5))) < 0.0005 then
			if (math.abs(_v5.velocity)) < 0.0005 then
				_k4.Scale = _v5.target
				s2[_k4] = nil
				continue
			end
		end
		_k4.Scale = (_v5.target + (((_k4.Scale - _v5.target) + ((_v5.velocity + (_v5.stiffness * (_k4.Scale - _v5.target))) * v1)) * r5))
	end
	if not connection then return end
	if next ~= nil then return end
	connection = nil
end
local function drive(v2, v3, v4) -- proto[2], line 127  -- upvalues: s2, U1, RunService, stepMotions
	local U1
	local v1_e = s2[v2]
	if v1_e then
		v1_e.target = v3
		v1_e.stiffness = v4
	else
		local target = { target = v3, velocity = 0, stiffness = v4 }
		s2[v2] = target
	end
	if U1 ~= nil then return end
	U1 = RunService.PreRender.Connect
end
local function accepting(v5) -- proto[3], line 142
	local f1
	local v_u1 = v5.host.Active
	if not v_u1 then return f1 end
	f1 = not (v5.input.GuiState == Enum.GuiState.NonInteractable)
	return f1
end
local function poseOf(v6) -- proto[4], line 146  -- upvalues: PlatformController
	local v_u1 = v6.host.Active
	if v_u1 then
		if v6.input.GuiState == Enum.GuiState.NonInteractable then return "Rest" end
		if v6.gamepadHeld then return "Sunk" end
		if v6.input.GuiState == Enum.GuiState.Press then return "Sunk" end
		if v6.input.GuiState ~= Enum.GuiState.Hover then return "Rest" end
		if not PlatformController.IsDesktop then return "Rest" end
		return "Raised"
	end
end
local function scaleFor(v7, v8) -- proto[5], line 160
	if v8 == "Sunk" then return v7.sunkScale end
	if v8 ~= "Raised" then return 1 end
	return v7.raisedScale
end
local function stiffnessFor(v9, v10) -- proto[6], line 167
	if v10 == "Sunk" then return 42 end
	if v9 ~= "Sunk" then return 22 end
	return 26
end
local s3 = volume
r1 = r4
local function playPressCue(v11) -- proto[7], line 174  -- upvalues: Audio, s3, r1
	local PlaybackSpeed = { PlaybackSpeed = r1.NextNumber, Volume = v11 }
end
local function placeGlyph(v12, v13) -- proto[8], line 181  -- upvalues: r2, TweenService, r1
	if v12.glyph == nil then return end
	local Position = {}
	Position.Position = v12.glyphRest
end
local s4 = intoSunk
local function refresh(v14) -- proto[9], line 190  -- upvalues: PlatformController, Audio, s3, r1, s4, s2, U6, RunService, stepMotions, placeGlyph
	local U6
	local v_u2
	local state_3_2
	local v_u3 = v14.host.Active
	if v14.pose == "Rest" then return end
	v14.pose = "Rest"
	if "Rest" == "Sunk" and v14.cueGain then
		local PlaybackSpeed = { PlaybackSpeed = r1.NextNumber, Volume = v14.cueGain }
	end
	if ("Rest" == "Sunk") then
		v_u2 = v14.sunkScale
	elseif ("Rest" == "Raised") then
		v_u2 = v14.raisedScale
	end
	if ("Rest" == "Sunk") then
		state_3_2 = s4.intoSunk
	elseif (v14.pose == "Sunk") then
		state_3_2 = s4.outOfSunk
	else
		state_3_2 = s4.hover
	end
	local v1_e = s2[v14.scale]
	if v1_e then
		v1_e.target = 1
		v1_e.stiffness = state_3_2
	else
		local target = { target = 1, velocity = 0, stiffness = state_3_2 }
		s2[v14.scale] = target
	end
	if U6 == nil then
		U6 = RunService.PreRender.Connect
	end
end
local function centerAnchor(v15) -- proto[10], line 207  -- upvalues: r1
	local w1 = v15.AbsoluteSize
	local f2
	if v15.AnchorPoint == r1 then return end
	v15.AnchorPoint = r1
	if v15.FindFirstChildWhichIsA == nil then
		f2 = not (v15.FindFirstChildWhichIsA == nil)
	end
	if f2 and 0 < w1.X and 0 < w1.Y and 0 < Vector2.zero.X and 0 < Vector2.zero.Y then
		v15.Position = UDim2.new
		return
	end
	(v15 ^ "AnchorPoint").Position = UDim2.new
end
local function adoptScale(v16) -- proto[11], line 243
	if v16.FindFirstChildOfClass then
		if (v16.FindFirstChildOfClass).IsA then return v16.FindFirstChildOfClass end
		Instance.new.Name = "PressScale"
		Instance.new.Parent = v16
		return Instance.new
	end
end
local function findGlyph(v17) -- proto[12], line 254
	local w2 = v17.GetAttribute
	if (type(w2)) ~= "string" then return nil end
	if not v17.FindFirstChild then return nil end
	if not (v17.FindFirstChild).IsA then return nil end
	local w3 = v17.FindFirstChild
	return w3
end
local function mirrorActive(v18) -- proto[13], line 263
	if v18.input == v18.host then return end
	v18.input.Active = v18.host.Active
	v18.input.Selectable = v18.host.Active
end
local function liveBinding(v19) -- proto[14], line 273  -- upvalues: s1
	local w4 = v19.GetAttribute
	local w2 = v19.GetAttribute
	if (type(w2)) ~= "number" then return nil end
	local v2_e = s1[w4]
	if v2_e then
		if v2_e.host == v19 then return v2_e end
		return nil
	end
end
local function unbind(v20) -- proto[15], line 284  -- upvalues: s1, s2
	if s1[v20.serial] ~= v20 then return end
	s1[v20.serial] = nil
	for _k4, _v5 in ipairs(v20.links) do
	end
	local activation = v20.activation
	if activation then
		v20.activation = nil
	end
	s2[(v20 ^ "serial").scale] = nil
	if (v20 ^ "serial").scale.Parent then
		(v20 ^ "serial").scale.Scale = 1
	end
	local glyph = (v20 ^ "serial").glyph
	if glyph then
		glyph.Position = (v20 ^ "serial").glyphRest
	end
	if not (v20 ^ "serial").ownsInput then return end
end
local function wire(self) -- proto[22], line 317  -- upvalues: refresh, unbind, GUI
	table.insert(self.links, (self.input.GetPropertyChangedSignal):Connect(function()
	end))
	table.insert(self.links, self.input.InputBegan:Connect(function(v21)
		if v21.KeyCode ~= Enum.KeyCode.ButtonA then return end
		self.gamepadHeld = true
	end))
	table.insert(self.links, self.input.InputEnded:Connect(function(v22)
		if v22.KeyCode ~= Enum.KeyCode.ButtonA then return end
		self.gamepadHeld = false
	end))
	table.insert(self.links, (self.host.GetPropertyChangedSignal):Connect(function()
		if self.input ~= self.host then
			self.input.Active = self.host.Active
			self.input.Selectable = self.host.Active
		end
	end))
	table.insert(self.links, self.host.Destroying:Connect(function()
	end))
	local onActivate = self.onActivate
	if not onActivate then return end
	self.activation = GUI.OnActivated
end
local s5 = bound
local index = 0
local function bind(v23) -- proto[24], line 355  -- upvalues: s5, s1, noop, centerAnchor, index, s3, wire, unbind
	local FindFirstChild, index_2
	local w4 = v23.host
	local v_u3
	local f3
	local v_u5
	local f2
	local v_u6
	local v2_e
	if ((type(v23.host.GetAttribute)) ~= "number") then
		v_u6 = nil
	else
		v2_e = s1[v23.host.GetAttribute]
		if v2_e and (v2_e.host == v23.host) then
			v_u6 = v2_e
		else
			v2_e = nil
		end
	end
	if v2_e then
		return noop
	end
	if v23.host.FindFirstChildOfClass then
		Instance.new.Name = "PressScale"
		Instance.new.Parent = w4
	end
	local w5 = w4.GetAttribute
	if (type(w5)) ~= "string" then
		v_u3 = nil
	else
		if w4.FindFirstChild then
			if (w4.FindFirstChild).IsA then
				v_u3 = w4.FindFirstChild
			end
			FindFirstChild = nil
		end
	end
	if (v23 ^ "host").silent ~= true then
		f3 = not (w4.GetAttribute ~= true)
	end
	index = (index + 1)
	if FindFirstChild then
		index_2 = FindFirstChild.Position
	end
	v_u5 = (not (f3) and ((v23 ^ "host") * (v23 ^ "host")).cueGain) or s3.volume
	f2 = not (((v23 ^ "host") * (v23 ^ "host")).ownsInput ~= true)
	local serial = { serial = index, host = w4, input = ((v23 ^ "host") * (v23 ^ "host")).input, scale = Instance.new, glyph = FindFirstChild, glyphRest = UDim2.new, raisedScale = (((v23 ^ "host") * (v23 ^ "host")).peakScale or 1.07), sunkScale = (((v23 ^ "host") * (v23 ^ "host")).pressedScale or 0.94), pose = "Rest", gamepadHeld = false, cueGain = v_u5, onActivate = ((v23 ^ "host") * (v23 ^ "host")).onActivate, ownsInput = f2, links = {}, activation = nil }
	s1[serial.serial] = serial
	if serial.input ~= serial.host then
		serial.input.Active = serial.host.Active
		serial.input.Selectable = serial.host.Active
	end
	local unbind = serial
	local function anon23() -- proto[23], line 391  -- upvalues: unbind, unbind
	end
	return anon23
end
local function anon25(v24, v25, v26, v27) -- proto[25], line 396  -- upvalues: bind
	local f4
	if (typeof(v24)) == "table" then
		return bind
	end
	local w4 = v24.IsA
	assert(w4, "ButtonFX needs a GuiButton")
	if v25 ~= nil then
		f4 = not ((type(v25)) ~= "number")
	end
	assert(f4, "ButtonFX peak scale must be a number")
	if v26 ~= nil then
		f4 = not ((type(v26)) ~= "function")
	end
	assert(f4, "ButtonFX activation handler must be a function")
	local host = { host = v24, input = v24, peakScale = v25, onActivate = v26, silent = v27 }
	return bind
end
return anon25