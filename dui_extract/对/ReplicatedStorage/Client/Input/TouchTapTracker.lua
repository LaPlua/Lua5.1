-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Input.TouchTapTracker
-- ============================================

-- bytecode
-- Original size: 2542 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 42, Protos: 10, Main proto: 9

-- ============== SOURCE ==============
-- main chunk (proto[9], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
local t = require(ReplicatedStorage.Packages.t)
local _index = {}
_index.__index = _index
_index.__class = "TouchTapTracker"
local r1 = t.strict(t.optional(t.table))
local r2 = t.strict(t.optional(t.number))
local r3 = Log.new()
local function requireTouch(v1) -- proto[0], line 36
	local f1 = not (v1.UserInputType ~= Enum.UserInputType.Touch)
	assert(f1)
end
local function travelled(v2, v3) -- proto[1], line 40
	local origin = v2.origin
	if not origin then return nil end
	return (v3.Position - origin).Magnitude
end
ReplicatedStorage = r1
local ReplicatedStorage_2 = r2
local module = _index
local ReplicatedStorage_3 = r3
function _index.new(v4) -- proto[2], line 45  -- upvalues: ReplicatedStorage, ReplicatedStorage_2, module, ReplicatedStorage_3
	local self = setmetatable(({}), module)
	self.slop = ((v4 or {}).MaxMovement or 16)
	self.holdLimit = ((v4 or {}).MaxDuration or 0.35)
	self.claimed = nil
	self.pressedAt = 0
	self.origin = nil
	self.aborted = false
	return self
end
function _index.Reset(v5) -- proto[3], line 66
	v5.claimed = nil
	v5.pressedAt = 0
	v5.origin = nil
	v5.aborted = false
end
function _index.IsTrackingInput(v6, v7) -- proto[4], line 73
	local f1 = not (v6.claimed ~= v7)
	return f1
end
function _index.IsCancelled(v8) -- proto[5], line 77
	return v8.aborted
end
function _index.Begin(v9, v10) -- proto[6], line 79
	local f2 = not (v10.UserInputType ~= Enum.UserInputType.Touch)
	assert(f2)
	v9.claimed = v10
	v9.pressedAt = os.clock
	v9.origin = v10.Position
	v9.aborted = false
end
function _index.Update(v11, v12) -- proto[7], line 88
	local Magnitude
	local f2
	local f2 = not (v12.UserInputType ~= Enum.UserInputType.Touch)
	assert(f2)
	if v11.claimed ~= v12 then return false end
	if v11.aborted then return false end
	local origin = v11.origin
	if origin then
		Magnitude = (v12.Position - origin).Magnitude
	else
		Magnitude = nil
	end
	if Magnitude ~= nil then
		f2 = not (v11.slop >= Magnitude)
	end
	v11.aborted = f2
	return (not f2)
end
function _index.Evaluate(v13, v14, v15) -- proto[8], line 104
	local Magnitude
	local f3
	local f4 = not (v14.UserInputType ~= Enum.UserInputType.Touch)
	assert(f4)
	local origin = v13.origin
	if origin then
		Magnitude = (v14.Position - origin).Magnitude
	else
		Magnitude = nil
	end
	if (not v15) then
		if v13.claimed == v14 then
			if (not v13.aborted) then
				if Magnitude ~= nil then
					if 0 < v13.pressedAt then
						if (os.clock - v13.pressedAt) <= v13.holdLimit then
							f3 = false  -- skip 1
							f3 = true
						end
					end
				end
			end
		end
	end
	return f3
end
return _index