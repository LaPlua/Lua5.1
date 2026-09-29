-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.AreaEggResetWall
-- ============================================

-- bytecode
-- Original size: 5383 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 70, Protos: 17, Main proto: 16

-- ============== SOURCE ==============
-- main chunk (proto[16], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Signal = require(ReplicatedStorage.Packages.Signal)
local Seconds = { Seconds = 1, Style = Enum.EasingStyle.Elastic, Direction = Enum.EasingDirection.Out }
local Seconds_2 = { Seconds = 0.35, Style = Enum.EasingStyle.Quad, Direction = Enum.EasingDirection.Out }
local CollapseSeconds = { CollapseSeconds = Seconds_2.Seconds, Changed = (Signal.new()) }
local function demandFolder(v1, v2) -- proto[0], line 37
	assert(v1[v2].IsA, (("%* under %* is not a Folder"):format(v2, v1.Name)))
	return v1[v2]
end
local function demandPart(v3, v4) -- proto[1], line 43
	assert(v3[v4].IsA, (("%* under %* is not a BasePart"):format(v4, v3.Name)))
	return v3[v4]
end
assert((Workspace.World:IsA("Folder")), (("World under %* is not a Folder"):format(Workspace.Name)))
assert((Workspace.World.Areas:IsA("Folder")), (("Areas under %* is not a Folder"):format(Workspace.World.Name)))
assert((Workspace.World.Areas.WallStartVisual:IsA("BasePart")), (("WallStartVisual under %* is not a BasePart"):format(Workspace.World.Areas.Name)))
assert((Workspace.World.Areas.WallStartCollision:IsA("BasePart")), (("WallStartCollision under %* is not a BasePart"):format(Workspace.World.Areas.Name)))
local w1 = (Workspace.World.Areas.WallStartVisual.CFrame * (CFrame.new((Vector3.new(0, 1, 0) * (Workspace.World.Areas.WallStartVisual.Size.Y * -0.5)))))
Workspace.World.Areas.WallStartVisual.CanCollide = false
local Y = Workspace.World.Areas.WallStartVisual.Size.Y
local WallStartVisual = Workspace.World.Areas.WallStartVisual
local assert = (Workspace.World.Areas.WallStartVisual.Size * Vector3.new(1, 0, 1))
local r1 = w1
local function applyHeight(v5) -- proto[2], line 63  -- upvalues: Y, WallStartVisual, assert, r1
	WallStartVisual.Size = (assert + (Vector3.new(0, 1, 0) * (math.clamp(v5, 0, Y))))
	WallStartVisual.CFrame = (r1 * CFrame.new)
end
local WallStartCollision = Workspace.World.Areas.WallStartCollision
local function setBarrierSolid(v6) -- proto[3], line 69  -- upvalues: WallStartCollision
	table.insert(WallStartCollision.GetDescendants, WallStartCollision)
	for _k5, _v6 in ipairs(WallStartCollision.GetDescendants) do
		if not _v6.IsA then continue end
		_v6.CanCollide = v6
	end
end
local s1 = CollapseSeconds
local function publishSealed(v7) -- proto[4], line 79  -- upvalues: U0, s1
	local U0
	if U0 == v7 then return end
	U0 = v7
end
local connection = nil
local function abortSweep() -- proto[5], line 86  -- upvalues: connection
	connection = nil
	if not connection then return end
end
local function runSweep(self, v8, v9) -- proto[8], line 97  -- upvalues: connection, Y, WallStartVisual, assert, r1, RunService, TweenService
	connection = nil
	local r2 = math.clamp(v8, 0, Y)
	WallStartVisual.Size = (assert + (Vector3.new(0, 1, 0) * r2))
	WallStartVisual.CFrame = (r1 * CFrame.new)
	local w2 = (Vector3.new(0, 1, 0) * (r2 * 0.5))
	local r3 = 0
	r2 = (v9 - v8)
	local connection = nil
	connection = RunService.PreRender.Connect
	while true do
		if not RunService.PreRender.Connect.Connected then break end
	end
	if connection ~= RunService.PreRender.Connect then return false end
	connection = nil
	local r4 = math.clamp(v9, 0, Y)
	WallStartVisual.Size = (assert + (Vector3.new(0, 1, 0) * r4))
	WallStartVisual.CFrame = (r1 * CFrame.new)
	local w3 = (Vector3.new(0, 1, 0) * (r4 * 0.5))
	return true
end
local f1 = false
function CollapseSeconds.ArmReveal() -- proto[9], line 132  -- upvalues: connection, Y, WallStartVisual, assert, r1, setBarrierSolid, f1, s1
	local r2 = math.clamp(0, 0, Y)
	WallStartVisual.Size = (assert + (Vector3.new(0, 1, 0) * r2))
	WallStartVisual.CFrame = (r1 * CFrame.new)
	local w2 = (Vector3.new(0, 1, 0) * (r2 * 0.5))
	if f1 == true then return end
	f1 = true
end
local data = Seconds
function CollapseSeconds.RaiseWall() -- proto[10], line 139  -- upvalues: runSweep, data, Y
end
local data_2 = Seconds_2
function CollapseSeconds.DropWall() -- proto[11], line 141  -- upvalues: setBarrierSolid, f1, s1, runSweep, data_2, WallStartVisual
	if f1 ~= false then
		f1 = false
	end
end
function CollapseSeconds.ClearWall() -- proto[12], line 148  -- upvalues: connection, Y, WallStartVisual, assert, r1, setBarrierSolid, f1, s1
	local r2 = math.clamp(0, 0, Y)
	WallStartVisual.Size = (assert + (Vector3.new(0, 1, 0) * r2))
	WallStartVisual.CFrame = (r1 * CFrame.new)
	local w2 = (Vector3.new(0, 1, 0) * (r2 * 0.5))
	if f1 == false then return end
	f1 = false
end
function CollapseSeconds.ResolveWallPart() -- proto[13], line 155  -- upvalues: WallStartVisual
	return WallStartVisual
end
function CollapseSeconds.ResolveFullHeight() -- proto[14], line 157  -- upvalues: Y
	return Y
end
function CollapseSeconds.IsSealed() -- proto[15], line 159  -- upvalues: U0
	return U0
end
return CollapseSeconds