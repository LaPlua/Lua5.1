-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.WorldFX.Pads
-- ============================================

-- bytecode
-- Original size: 4640 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 83, Protos: 13, Main proto: 12

-- ============== SOURCE ==============
-- main chunk (proto[12], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local PointInBox = require(ReplicatedStorage.Shared.Utils.PointInBox)
local Player = require(ReplicatedStorage.Shared.Player)
local Signal = require(ReplicatedStorage.Packages.Signal)
local r1 = TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local Changed = {}
Changed.Changed = (Signal.new())
local s1 = {}
local function padBox(v1) -- proto[0], line 47  -- upvalues: ModelBounds
	if v1.IsA then
		local w1 = v1.CFrame
		return w1, v1.Size
	end
	if v1.IsA then return ModelBounds(v1) end
	local w2 = v1.GetPivot
	return w2, Vector3.new(0, 0, 0)
end
local function topUnderFoot(v2, v3) -- proto[1], line 59  -- upvalues: ModelBounds, PointInBox
	local v_u1
	local v_u2
	if (v2.Surface.IsA) then
		v_u1 = v2.Surface.CFrame
		v_u2 = v2.Surface.Size
	else
		if (v2.Surface.IsA) then
			v_u1 = ModelBounds
			v_u2 = v2.Surface
		else
			v_u1 = v2.Surface.GetPivot
		end
	end
	if not (PointInBox) then return nil end
	return (v_u1 * CFrame.new).Position.Y
end
local function padBeneath(v4) -- proto[2], line 69  -- upvalues: s1, topUnderFoot
	local v_u3 = nil
	for _k6, _v7 in ipairs(s1) do
		if topUnderFoot == nil then continue end
		if -inf >= topUnderFoot then continue end
		v_u3 = _v7
	end
	return v_u3
end
local s2 = Changed
local function transition(v5) -- proto[3], line 81  -- upvalues: U0, s2
	local U0
	if v5 == U0 then return end
	U0 = v5
end
Changed.Changed:Connect(function(v6, v7)
	local Left
	local Entered
	if (v6 ~= nil) then
		local v_u1 = v6.Hooks
		Entered = v_u1.Entered
	else
		Entered = nil
	end
	if (v7 ~= nil) then
		local v_u2 = v7.Hooks
		Left = v_u2.Left
	else
		Left = nil
	end
	if Left == nil then return end
end)
local f1 = false
local function poll() -- proto[5], line 103  -- upvalues: s1, Player, padBeneath, U3, s2, f1
	local U3
	while true do
		if 0 < (#s1) then
			if not ((nil == U3)) then
				U3 = nil
			end
		end
	end
	if not ((U3 == nil)) then
		U3 = nil
	end
	f1 = false
end
local function startBob(self) -- proto[7], line 113  -- upvalues: TweenService, r1, GameFlags
	local w1 = self.GetPivot
	Instance.new.Name = "PadMarkerLift"
	Instance.new.Value = -0.4
	local GetPivot = w1
	Instance.new.Parent = self
	local Value = { Value = 0.4 }
	local Height = { Height = Instance.new, Motion = TweenService.Create, Follow = Instance.new.Changed.Connect }
	return Height
end
local function stopBob(v9) -- proto[8], line 130
end
GameFlags.WorldOverlaysHidden.Changed:Connect(function(v10)
	for _k4, _v5 in ipairs(s1) do
		if _v5.Bob == nil then continue end
	end
end)
function Changed.Track(v11, v12) -- proto[11], line 152  -- upvalues: s1, U1, startBob, f1, poll
	local w1 = v11.IsA
	assert(w1, "Pads.Track needs a PVInstance surface")
	local s2 = nil
	local function untrack() -- proto[10], line 156  -- upvalues: s1, s2, U2
		local U2
		if table.find == nil then return end
		if U2 ~= s2 then return end
		U2 = nil
	end
	local Surface = { Surface = v11, Hooks = (v12 or {}), Bob = nil, Gone = v11.Destroying.Once }
	table.insert(s1, Surface)
	if f1 then return untrack end
	f1 = true
	return untrack
end
return table.freeze(Changed)