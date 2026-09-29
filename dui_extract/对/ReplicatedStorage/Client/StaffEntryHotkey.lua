-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.StaffEntryHotkey
-- ============================================

-- bytecode
-- Original size: 711 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 18, Protos: 3, Main proto: 2

-- ============== SOURCE ==============
-- main chunk (proto[2], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Signal = require(ReplicatedStorage.Packages.Signal)
local Changed = {}
Changed.Changed = (Signal.new())
local RightBracket = Enum.KeyCode.RightBracket
local s1 = Changed
local function onInputBegan(v1, v2) -- proto[0], line 15  -- upvalues: UserInputService, RightBracket, U2, s1
	local U2
	if v2 then return end
	if UserInputService.GetFocusedTextBox then return end
	if v1.KeyCode ~= RightBracket then return end
	U2 = (not U2)
end
function Changed.IsHidden() -- proto[1], line 26  -- upvalues: U0
	return U0
end
UserInputService.InputBegan:Connect(onInputBegan)
return Changed