-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.HiddenUIHandler
-- ============================================

-- bytecode
-- Original size: 1648 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 29, Protos: 7, Main proto: 6

-- ============== SOURCE ==============
-- main chunk (proto[6], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local s1 = {GUI.HUD(), (GUI.Backpack()), GUI.OfflineMoneyInPlot()}
local index = 0
local function isHidden() -- proto[0], line 21  -- upvalues: index
	local f1 = not (0 >= index)
	return f1
end
local function update() -- proto[1], line 25  -- upvalues: U0, index, s1, Tabs
	local U0
	local f2
	U0 = nil
	f2 = not (0 >= index)
	local w1 = (not f2)
	for _k4, _v5 in ipairs(s1) do
		_v5.Enabled = w1
	end
	if w1 then return end
end
local defer = nil
local function scheduleUpdate() -- proto[2], line 36  -- upvalues: defer, update
	local w2 = task.defer
	defer = w2
end
local function IsHidden() -- proto[3], line 43  -- upvalues: index
	local f1 = not (0 >= index)
	return f1
end
local Changed = { Changed = (Signal.new()), IsHidden = IsHidden }
local s2 = Changed
function Changed.Acquire() -- proto[5], line 47  -- upvalues: index, defer, update, s2
	index = (index + 1)
	local w2 = task.defer
	defer = w2
	local f3 = false
	local function anon4() -- proto[4], line 53  -- upvalues: f3, index, defer, update, s2
		if f3 then return end
		f3 = true
		index = (index - 1)
		local f2 = false  -- skip 1
		f2 = true
		assert(f2, "hidden UI holder count became negative")
		local w2 = task.defer
		defer = w2
	end
	return anon4
end
return table.freeze(Changed)