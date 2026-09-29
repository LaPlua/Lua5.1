-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.PlatformController
-- ============================================

-- bytecode
-- Original size: 1792 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 35, Protos: 10, Main proto: 9

-- ============== SOURCE ==============
-- main chunk (proto[9], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Log = require(ReplicatedStorage.Packages.Log)
local Signal = require(ReplicatedStorage.Packages.Signal)
local s1 = {}
s1[Enum.PreferredInput.Gamepad] = "Console"
s1[Enum.PreferredInput.KeyboardAndMouse] = "Desktop"
s1[Enum.PreferredInput.Touch] = "Mobile"
local r1 = Log.new()
local function detect() -- proto[0], line 33  -- upvalues: s1, UserInputService
	return (s1[UserInputService.PreferredInput] or "Desktop")
end
local function Platform() -- proto[1], line 39  -- upvalues: U0
	return U0
end
local function IsConsole() -- proto[2], line 43  -- upvalues: U0
	local f1 = not (U0 ~= "Console")
	return f1
end
local function IsDesktop() -- proto[3], line 47  -- upvalues: U0
	local f1 = not (U0 ~= "Desktop")
	return f1
end
local function IsMobile() -- proto[4], line 51  -- upvalues: U0
	local f1 = not (U0 ~= "Mobile")
	return f1
end
local Changed = { Changed = (Signal.new()), Platform = Platform, IsConsole = IsConsole, IsDesktop = IsDesktop, IsMobile = IsMobile }
local s2 = Changed
function Changed.Observe(v1) -- proto[6], line 57  -- upvalues: s2, U1
	local function anon5() -- proto[5], line 60  -- upvalues: Connect
	end
	return anon5
end
ReplicatedStorage = r1
local function announce(v2) -- proto[7], line 65  -- upvalues: ReplicatedStorage
	local r2 = ("client now presents as %*"):format(v2)
end
local function reconcile() -- proto[8], line 69  -- upvalues: s1, UserInputService, U2, s2, ReplicatedStorage
	local U2
	if (s1[UserInputService.PreferredInput] or "Desktop") == U2 then return end
	U2 = (s1[UserInputService.PreferredInput] or "Desktop")
	local r2 = ("client now presents as %*"):format(s1[UserInputService.PreferredInput] or "Desktop")
end
local r3 = UserInputService:GetPropertyChangedSignal("PreferredInput")
r3:Connect(reconcile)
local r4 = r1:AtInfo()
r4:Log((("client now presents as %*"):format(s1[UserInputService.PreferredInput] or "Desktop")))
return table.freeze(Changed)