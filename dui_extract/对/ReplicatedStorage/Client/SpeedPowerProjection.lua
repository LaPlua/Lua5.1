-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.SpeedPowerProjection
-- ============================================

-- bytecode
-- Original size: 6001 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 40, Protos: 11, Main proto: 10

-- ============== SOURCE ==============
local EqualisedSpeedPower
local f1
local r1
local MinimumSpeedPower
-- main chunk (proto[10], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Save = require(ReplicatedStorage.Shared.Save)
local Signal = require(ReplicatedStorage.Packages.Signal)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local t = require(ReplicatedStorage.Packages.t)
local r2 = t.strict(t.number)
local Changed = {}
Changed.Changed = (Signal.new())
local v_u1 = TreadmillUtil.DEFAULT_BASE_SPEED_POWER
local function readSavedPower() -- proto[0], line 31  -- upvalues: Save, TreadmillUtil
	if Save.Await ~= nil then return TreadmillUtil.NormalizeSpeedPower(Save.Await.SpeedPower) end
	return TreadmillUtil.NormalizeSpeedPower(Save.Await.SpeedPower)
end
local function readOverride(v1) -- proto[1], line 37  -- upvalues: Workspace
	if (type(Workspace.GetAttribute)) ~= "number" then return nil end
	if 0 >= Workspace.GetAttribute then return nil end
	return Workspace.GetAttribute
end
TreadmillUtil = v_u1
local index = 0
local TreadmillUtil_2 = TreadmillUtil.DEFAULT_BASE_SPEED_POWER
local f2 = false
local function runTotal() -- proto[2], line 42  -- upvalues: TreadmillUtil, index, U2, TreadmillUtil_2, f2
	if U2 == nil then return TreadmillUtil_2 end
	if f2 then return (TreadmillUtil + index) end
	return (math.max(TreadmillUtil_2, (TreadmillUtil + index)))
end
local function computeShown() -- proto[3], line 52  -- upvalues: Workspace, TreadmillUtil, index, U3, TreadmillUtil_2, f2
	local r3
	local GetAttribute
	if ((type(Workspace.GetAttribute)) == "number") and (0 < Workspace.GetAttribute) then
		GetAttribute = Workspace.GetAttribute
	else
		GetAttribute = nil
	end
	if GetAttribute ~= nil then return GetAttribute end
	if (U3 == nil) then
	elseif f2 then
	else
		r3 = math.max(TreadmillUtil_2, (TreadmillUtil + index))
	end
	if ((type(Workspace.GetAttribute)) == "number") and (0 < Workspace.GetAttribute) then
		GetAttribute = Workspace.GetAttribute
	else
		GetAttribute = nil
	end
	if GetAttribute == nil then return r3 end
	return (math.max(r3, GetAttribute))
end
local TreadmillUtil_3 = TreadmillUtil.DEFAULT_BASE_SPEED_POWER
local s1 = Changed
local function republish() -- proto[4], line 63  -- upvalues: Workspace, TreadmillUtil, index, U3, TreadmillUtil_2, f2, TreadmillUtil_3, s1
	local v_u2
	local r3
	local GetAttribute
	if ((type(Workspace.GetAttribute)) == "number") and (0 < Workspace.GetAttribute) then
		GetAttribute = Workspace.GetAttribute
	else
		GetAttribute = nil
	end
	if (GetAttribute ~= nil) then
		v_u2 = GetAttribute
	else
		if (U3 == nil) then
		elseif f2 then
		else
			r3 = math.max(TreadmillUtil_2, (TreadmillUtil + index))
		end
		if ((type(Workspace.GetAttribute)) == "number") and (0 < Workspace.GetAttribute) then
			GetAttribute = Workspace.GetAttribute
		else
			GetAttribute = nil
		end
		if (GetAttribute == nil) then
			v_u2 = r3
		else
			v_u2 = math.max(r3, GetAttribute)
		end
	end
	if v_u2 == TreadmillUtil_3 then return end
	TreadmillUtil_3 = v_u2
	s1 = s1.Changed
end
local TreadmillUtil_4 = TreadmillUtil.DEFAULT_BASE_SPEED_POWER
local function syncWithSave() -- proto[5], line 71  -- upvalues: TreadmillUtil, Save, TreadmillUtil_2, f2, U4, TreadmillUtil_3, index, Workspace, TreadmillUtil_4, s1
	local U4
	local GetAttribute
	local r3
	local f3
	TreadmillUtil = TreadmillUtil_2.NormalizeSpeedPower
	if (not f2) and U4 ~= nil then
		f3 = false  -- skip 1
		f3 = true
	end
	if f3 then
		U4 = nil
		TreadmillUtil_3 = TreadmillUtil
		index = 0
	end
	if ((type(Workspace.GetAttribute)) == "number") and (0 < Workspace.GetAttribute) then
		GetAttribute = Workspace.GetAttribute
	else
		GetAttribute = nil
	end
	if (GetAttribute ~= nil) then
		r1 = GetAttribute
	else
		if (U4 == nil) then
		elseif f2 then
		else
			r3 = math.max(TreadmillUtil, (TreadmillUtil_3 + index))
		end
		if ((type(Workspace.GetAttribute)) == "number") and (0 < Workspace.GetAttribute) then
			GetAttribute = Workspace.GetAttribute
		else
			GetAttribute = nil
		end
		if (GetAttribute == nil) then
			r1 = r3
		else
			r1 = math.max(r3, GetAttribute)
		end
	end
	if r1 == TreadmillUtil_4 then return end
	TreadmillUtil_4 = r1
	s1 = s1.Changed
end
function Changed.ReadProjected() -- proto[6], line 84  -- upvalues: TreadmillUtil
	return TreadmillUtil
end
local number = r2
function Changed.OpenSession(v2) -- proto[7], line 86  -- upvalues: number, TreadmillUtil, Save, TreadmillUtil_2, f2, U5, TreadmillUtil_3, TreadmillUtil_4, index, Workspace, s1
	local U5
	local r4
	local GetAttribute
	TreadmillUtil = TreadmillUtil_2.NormalizeSpeedPower
	f2 = true
	U5 = v2
	TreadmillUtil_3 = (math.max(TreadmillUtil, TreadmillUtil_4))
	index = 0
	if ((type(Workspace.GetAttribute)) == "number") and (0 < Workspace.GetAttribute) then
		GetAttribute = Workspace.GetAttribute
	else
		GetAttribute = nil
	end
	if (GetAttribute ~= nil) then
		r4 = GetAttribute
	else
		if (U5 == nil) then
		elseif f2 then
		else
			r1 = math.max(TreadmillUtil, (TreadmillUtil_3 + index))
		end
		if ((type(Workspace.GetAttribute)) == "number") and (0 < Workspace.GetAttribute) then
			GetAttribute = Workspace.GetAttribute
		else
			GetAttribute = nil
		end
		if (GetAttribute == nil) then
			r4 = r1
		else
			r4 = math.max(r1, GetAttribute)
		end
	end
	if r4 == TreadmillUtil_4 then return end
	TreadmillUtil_4 = r4
	s1 = s1.Changed
end
function Changed.CreditRevealedGain(v3, v4) -- proto[8], line 97  -- upvalues: number, U1, index, Workspace, TreadmillUtil, TreadmillUtil_2, f2, TreadmillUtil_3, s1
	local index_2
	local r3
	local GetAttribute
	if U1 == v3 then
		if 0 >= v4 then return false end
		index = (index + v4)
		if ((type(Workspace.GetAttribute)) == "number") and (0 < Workspace.GetAttribute) then
			GetAttribute = Workspace.GetAttribute
		end
	else
		GetAttribute = nil
	end
	if (GetAttribute ~= nil) then
		index_2 = GetAttribute
	else
		if (U1 == nil) then
		elseif f2 then
		else
			r3 = math.max(TreadmillUtil_2, (TreadmillUtil + index))
		end
		if ((type(Workspace.GetAttribute)) == "number") and (0 < Workspace.GetAttribute) then
			GetAttribute = Workspace.GetAttribute
		else
			GetAttribute = nil
		end
		if (GetAttribute == nil) then
			index_2 = r3
		else
			index_2 = math.max(r3, GetAttribute)
		end
	end
	if index_2 == TreadmillUtil_3 then return false end
	TreadmillUtil_3 = index_2
	s1 = s1.Changed
	return false
end
function Changed.CloseSession(v5) -- proto[9], line 110  -- upvalues: number, U1, f2, TreadmillUtil, Save, TreadmillUtil_2, TreadmillUtil_3, index, Workspace, TreadmillUtil_4, s1
	local U1
	local GetAttribute
	local r3
	local f4
	if U1 ~= v5 then return end
	f2 = false
	TreadmillUtil = TreadmillUtil_2.NormalizeSpeedPower
	if (not f2) and U1 ~= nil then
		f4 = false  -- skip 1
		f4 = true
	end
	if f4 then
		U1 = nil
		TreadmillUtil_3 = TreadmillUtil
		index = 0
	end
	if ((type(Workspace.GetAttribute)) == "number") and (0 < Workspace.GetAttribute) then
		GetAttribute = Workspace.GetAttribute
	else
		GetAttribute = nil
	end
	if (GetAttribute ~= nil) then
		r1 = GetAttribute
	else
		if (U1 == nil) then
		elseif f2 then
		else
			r3 = math.max(TreadmillUtil, (TreadmillUtil_3 + index))
		end
		if ((type(Workspace.GetAttribute)) == "number") and (0 < Workspace.GetAttribute) then
			GetAttribute = Workspace.GetAttribute
		else
			GetAttribute = nil
		end
		if (GetAttribute == nil) then
			r1 = r3
		else
			r1 = math.max(r3, GetAttribute)
		end
	end
	if r1 == TreadmillUtil_4 then return end
	TreadmillUtil_4 = r1
	s1 = s1.Changed
end
local r5 = Save.Await()
if not ((r5 == nil)) then
	EqualisedSpeedPower = r5.SpeedPower
end
local r6 = TreadmillUtil.NormalizeSpeedPower(EqualisedSpeedPower)
if (not false) and nil ~= nil then
	f1 = false  -- skip 1
	f1 = true
end
if f1 then
	v_u1 = r6
end
EqualisedSpeedPower = Workspace:GetAttribute("EqualisedSpeedPower")
if not (((type(EqualisedSpeedPower)) == "number") and (0 < EqualisedSpeedPower)) then
	EqualisedSpeedPower = nil
end
if (EqualisedSpeedPower ~= nil) then
	r1 = EqualisedSpeedPower
else
	if (nil == nil) then
		EqualisedSpeedPower = r6
	elseif false then
		EqualisedSpeedPower = (v_u1 + 0)
	else
		EqualisedSpeedPower = math.max(r6, (v_u1 + 0))
	end
	MinimumSpeedPower = Workspace:GetAttribute("MinimumSpeedPower")
	if not (((type(MinimumSpeedPower)) == "number") and (0 < MinimumSpeedPower)) then
		MinimumSpeedPower = nil
	end
	if (MinimumSpeedPower == nil) then
		r1 = EqualisedSpeedPower
	else
		r1 = math.max(EqualisedSpeedPower, MinimumSpeedPower)
	end
end
if r1 ~= TreadmillUtil.DEFAULT_BASE_SPEED_POWER then
	EqualisedSpeedPower = Changed.Changed
	EqualisedSpeedPower:Fire(r1)
end
local r7 = Save.Watch("SpeedPower")
r7:Connect(syncWithSave)
local r8 = Workspace:GetAttributeChangedSignal("EqualisedSpeedPower")
r8:Connect(republish)
local r9 = Workspace:GetAttributeChangedSignal("MinimumSpeedPower")
r9:Connect(republish)
return Changed