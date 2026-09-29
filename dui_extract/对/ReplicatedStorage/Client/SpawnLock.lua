-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.SpawnLock
-- ============================================

-- bytecode
-- Original size: 4102 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 46, Protos: 13, Main proto: 12

-- ============== SOURCE ==============
-- main chunk (proto[12], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local s1 = {}
local ObtainLock = {}
local function anyClaims() -- proto[0], line 19  -- upvalues: U0
	local f1 = not (next == nil)
	return f1
end
local f2 = false
local function findTemplate() -- proto[1], line 23  -- upvalues: ReplicatedStorage, f2
	if nil ~= nil then return nil end
	if f2 then return nil end
	f2 = true
	return nil
end
local function collidableParts(v1) -- proto[3], line 35
	local s1 = {}
	local function consider(v2) -- proto[2], line 37  -- upvalues: s1
		if not v2.IsA then return end
		if not v2.CanCollide then return end
		s1[((#s1) + 1)] = v2
	end
	if v1.IsA and v1.CanCollide then
		s1[((#s1) + 1)] = v1
	end
	for _k6, _v7 in ipairs(v1.GetDescendants) do
		if not _v7.IsA then continue end
		if not _v7.CanCollide then continue end
		s1[((#s1) + 1)] = _v7
	end
	return s1
end
local function touchesCharacter(v3, v4) -- proto[4], line 49  -- upvalues: Workspace
	local f3
	OverlapParams.new.FilterType = Enum.RaycastFilterType.Include
	OverlapParams.new.FilterDescendantsInstances = {v4}
	f3 = not (0 >= (#Workspace.GetPartsInPart))
	return f3
end
local function solidifyOnceClear(v5) -- proto[6], line 59  -- upvalues: collidableParts, RunService, Players, touchesCharacter
	for _k5, _v6 in ipairs(collidableParts) do
		_v6.CanCollide = false
	end
	if (#collidableParts) <= 0 then return end
end
local function raiseBarrier() -- proto[7], line 86  -- upvalues: ReplicatedStorage, f2, solidifyOnceClear, Workspace
	local FindFirstChild
	if (ReplicatedStorage.FindFirstChild ~= nil) then
		FindFirstChild = (ReplicatedStorage.FindFirstChild).FindFirstChild
	else
		FindFirstChild = nil
	end
	if FindFirstChild == nil and not (f2) then
		f2 = true
	end
	if FindFirstChild == nil then return nil end
	local w1 = FindFirstChild.Clone
	w1.Parent = Workspace
	return w1
end
s1 = nil
local function syncBarrier() -- proto[8], line 97  -- upvalues: s1, U1, ReplicatedStorage, f2, solidifyOnceClear, Workspace
	local v_u2
	local FindFirstChild
	local v_u1
	if next ~= nil then
		if s1 ~= nil then
			v_u1 = s1.Parent
			if v_u1 ~= nil then return end
		end
		if (ReplicatedStorage.FindFirstChild ~= nil) then
			FindFirstChild = (ReplicatedStorage.FindFirstChild).FindFirstChild
		else
			FindFirstChild = nil
		end
		if FindFirstChild == nil and not (f2) then
			f2 = true
		end
		if not ((FindFirstChild == nil)) then
			local w1 = FindFirstChild.Clone
			v_u2 = w1
			w1.Parent = Workspace
			v_u1 = w1
		end
		s1 = v_u1
		return
	end
	s1 = nil
	if (s1 ^ "next") == nil then return end
end
local s2 = nil
function ObtainLock.ObtainLock() -- proto[10], line 111  -- upvalues: s1, s2, ReplicatedStorage, f2, solidifyOnceClear, Workspace
	local FindFirstChild
	local v_u3
	s1[table.freeze] = true
	if next ~= nil then
		if s2 ~= nil then
			v_u3 = s2.Parent
			if (ReplicatedStorage.FindFirstChild ~= nil) then
				FindFirstChild = (ReplicatedStorage.FindFirstChild).FindFirstChild
			else
				FindFirstChild = nil
			end
			if FindFirstChild == nil and not (f2) then
				f2 = true
			end
			if (FindFirstChild == nil) then
				v_u3 = nil
			else
				local w1 = FindFirstChild.Clone
				w1.Parent = Workspace
				v_u3 = w1
			end
			s2 = v_u3
		else
			s2 = nil
		end
	end
	local freeze = (table.freeze ^ "table")
	local function anon9() -- proto[9], line 115  -- upvalues: s1, freeze, s2, ReplicatedStorage, f2, solidifyOnceClear, Workspace
		local v_u2
		local v_u1
		if s1[freeze] == nil then return end
		s1[freeze] = nil
		if next ~= nil then
			if s2 ~= nil then
				v_u1 = s2.Parent
				if v_u1 ~= nil then return end
			end
			if (ReplicatedStorage.FindFirstChild ~= nil) then
				FindFirstChild = (ReplicatedStorage.FindFirstChild).FindFirstChild
			else
				FindFirstChild = nil
			end
			if FindFirstChild == nil and not (f2) then
				f2 = true
			end
			if not ((FindFirstChild == nil)) then
				local w1 = FindFirstChild.Clone
				v_u2 = w1
				w1.Parent = Workspace
				v_u1 = w1
			end
			s2 = v_u1
			return
		end
		s2 = nil
		if (s2 ^ "next") == nil then return end
	end
	return anon9
end
function ObtainLock.IsLocked() -- proto[11], line 124  -- upvalues: U0
	local f1 = not (next == nil)
	return f1
end
return table.freeze(ObtainLock)