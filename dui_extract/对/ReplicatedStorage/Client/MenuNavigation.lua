-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.MenuNavigation
-- ============================================

-- bytecode
-- Original size: 5490 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 76, Protos: 22, Main proto: 21

-- ============== SOURCE ==============
-- main chunk (proto[21], line 1)
local GamepadService = game:GetService("GamepadService")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local PlatformController = require(ReplicatedStorage.Client.PlatformController)
local Preferences = require(ReplicatedStorage.Shared.Preferences)
local Signal = require(ReplicatedStorage.Packages.Signal)
local r1 = Preferences.IsOn("VirtualCursor")
local s1 = {}
local s2 = {}
local function IsSuspended() -- proto[0], line 41  -- upvalues: PlatformController, UserInputService, GuiService, U3, U4
	local f1
	if (not PlatformController.IsConsole) then return f1 end
	if (not UserInputService.GamepadEnabled) then return f1 end
	local UserInputService_2 = UserInputService.VREnabled
	if UserInputService_2 then return f1 end
	local GuiService_2 = GuiService.MenuIsOpen
	if GuiService_2 then return f1 end
	if (not U3) then return f1 end
	f1 = not (next == nil)
	return f1
end
ReplicatedStorage = r1
local function PrefersCursor() -- proto[1], line 50  -- upvalues: ReplicatedStorage
	return ReplicatedStorage
end
local function IsCursorActive() -- proto[2], line 53  -- upvalues: U0
	local f1 = not (U0 == nil)
	return f1
end
local Changed = { Changed = (Signal.new()), CursorChanged = (Signal.new()), SaveFailed = (Signal.new()), CursorFailed = (Signal.new()), SwitchKey = Enum.KeyCode.ButtonR3, IsSuspended = IsSuspended, PrefersCursor = PrefersCursor, IsCursorActive = IsCursorActive }
local s3 = Changed
function Changed.Release() -- proto[4], line 57  -- upvalues: U0, GamepadService, s3
	local U0
	if U0 == nil then return end
	U0 = nil
	if not (pcall) then
		local r2 = ("Could not release menu cursor: %*"):format(function()
		end)
	end
end
function Changed.SetContext(v1, v2) -- proto[6], line 71  -- upvalues: ReplicatedStorage, s3, U2, U3, GamepadService
	local U2, U3
	if v1 ~= nil and ReplicatedStorage then
		U2 = nil
		return false
	end
	if v1 == U3 then return true end
	if v1 == U2 then return false end
	if not (pcall) then
		U2 = v1
		local r2 = ("Could not enable menu cursor: %*"):format(function()
		end)
		return false
	end
	U2 = nil
	U3 = (v1 ^ "IsSuspended")
	return true
end
local f2 = false
local f3 = false
local index = 0
function Changed.SetPreference(v3) -- proto[8], line 102  -- upvalues: ReplicatedStorage, f2, f3, index, U4, s3, Preferences
	local U4
	if ReplicatedStorage == v3 then
		if not (f2) then
			if not (f3) then return end
			ReplicatedStorage = v3
			f3 = true
			index = (index + 1)
			U4 = nil
			if f2 then return end
			f2 = true
		end
	end
end
function Changed.Toggle() -- proto[9], line 134  -- upvalues: s3, ReplicatedStorage
end
function Changed.Suspend(v4, v5) -- proto[10], line 138  -- upvalues: s2, s3
	local f4
	local v_u1 = s2[v4]
	f4 = not (v_u1 ~= true)
	if f4 == v5 then return end
	s2[v4] = nil
end
function Changed.SetOverride(v6, v7, v8, v9, v10, v11, v12) -- proto[11], line 149  -- upvalues: s1, index, s3
	local f5
	if v7 == nil then
		s1[v6] = nil
	else
		index = (index + 1)
		local Root = {}
		Root.Root = v7
		Root.Initial = v8
		Root.Back = v9
		Root.Priority = (v10 or 0)
		f5 = not (v11 ~= true)
		Root.Modal = f5
		f5 = not (v12 ~= true)
		Root.BackInButtons = f5
		Root.Order = index
		s1[v6] = Root
	end
end
local function visible(v13) -- proto[12], line 175
	if v13.FindFirstAncestorWhichIsA == nil then return false end
	local w1 = v13.FindFirstAncestorWhichIsA
	if not (w1.Enabled) then return false end
	while true do
		if not v13.IsA then break end
		if not (v13.Visible) then return false end
		if v13.Parent == w1 then return true end
	end
	return true
end
function Changed.TopOverride() -- proto[13], line 190  -- upvalues: s1, visible
	local v_u2 = nil
	for _k4, _v5 in ipairs(s1) do
		if not _v5.Root.Parent then continue end
		if not visible then continue end
		if v_u2 ~= nil and v_u2.Priority >= _v5.Priority then
			if _v5.Priority ~= v_u2.Priority then continue end
			if v_u2.Order >= _v5.Order then continue end
		end
		v_u2 = _v5
	end
	return v_u2
end
Preferences.Observe("VirtualCursor", function(v14)
	if v14 == ReplicatedStorage then return end
	if f2 then return end
	if f3 then return end
	ReplicatedStorage = v14
	U3 = nil
end)
local function refresh() -- proto[15], line 218  -- upvalues: s3
end
PlatformController.Changed:Connect(refresh)
GuiService.MenuOpened:Connect(refresh)
GuiService.MenuClosed:Connect(refresh)
UserInputService.GamepadConnected:Connect(refresh)
UserInputService.GamepadDisconnected:Connect(refresh)
UserInputService.WindowFocusReleased:Connect(function()
	f2 = false
end)
UserInputService.WindowFocused:Connect(function()
	f2 = true
end)
pcall(function()

end)
return Changed