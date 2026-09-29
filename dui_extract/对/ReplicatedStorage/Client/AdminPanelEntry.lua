-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.AdminPanelEntry
-- ============================================

-- bytecode
-- Original size: 2152 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 30, Protos: 7, Main proto: 6

-- ============== SOURCE ==============
-- main chunk (proto[6], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Environment = require(ReplicatedStorage.Shared.Modules.Environment)
local Signal = require(ReplicatedStorage.Packages.Signal)
local StaffEntryHotkey = require(ReplicatedStorage.Client.StaffEntryHotkey)
local Changed = {}
Changed.Changed = (Signal.new())
local KeyboardEnabled = (not UserInputService.TouchEnabled)
local function isToggleHonoured() -- proto[0], line 23  -- upvalues: KeyboardEnabled, U1
	if not KeyboardEnabled then return U1 end
	return U1
end
local f1 = false
local TouchEnabled = (not UserInputService.KeyboardEnabled)
local function canShowPanel() -- proto[1], line 25  -- upvalues: StaffEntryHotkey, f1, Environment, TouchEnabled, KeyboardEnabled, U5
	if StaffEntryHotkey.IsHidden then return false end
	if f1 then return U5 end
	if Environment.IsDevPlace then return U5 end
	if Environment.IsTestPlace then return U5 end
	if TouchEnabled then return U5 end
	if not KeyboardEnabled then return U5 end
	return U5
end
local F8 = Enum.KeyCode.F8
local s1 = Changed
local function onInputBegan(v1, v2) -- proto[2], line 36  -- upvalues: KeyboardEnabled, F8, U2, s1, StaffEntryHotkey, f1, Environment, TouchEnabled
	local U2
	if KeyboardEnabled then
		if (not v2) then
			if v1.KeyCode ~= F8 then return end
			U2 = (not U2)
		end
	end
end
function Changed.CanShowPanel() -- proto[3], line 44  -- upvalues: StaffEntryHotkey, f1, Environment, TouchEnabled, KeyboardEnabled, U5
	if StaffEntryHotkey.IsHidden then return false end
	if f1 then return U5 end
	if Environment.IsDevPlace then return U5 end
	if Environment.IsTestPlace then return U5 end
	if TouchEnabled then return U5 end
	if not KeyboardEnabled then return U5 end
	return U5
end
function Changed.SetAdminStatus(v3) -- proto[4], line 46  -- upvalues: f1, s1, StaffEntryHotkey, Environment, TouchEnabled, KeyboardEnabled, U6
	if f1 == v3 then return end
	f1 = v3
end
UserInputService.InputBegan:Connect(onInputBegan)
StaffEntryHotkey.Changed:Connect(function()
end)
return Changed