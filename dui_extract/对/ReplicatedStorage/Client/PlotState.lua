-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.PlotState
-- ============================================

-- bytecode
-- Original size: 14738 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 117, Protos: 44, Main proto: 43

-- ============== SOURCE ==============
-- main chunk (proto[43], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Log = require(ReplicatedStorage.Packages.Log)
local Plots = require(ReplicatedStorage.Shared.Types.Plots)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Storefront = require(ReplicatedStorage.Client.Functions.Storefront)
local Streamable = require(ReplicatedStorage.Packages.Streamable)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local r1 = t.strict(t.instanceIsA("Player"))
local r2 = t.strict(t.Vector3)
local r3 = t.strict(t.instanceIsA("BasePart"))
local r4 = t.strict(t.instanceIsA("Attachment"))
local r5 = t.strict(t.instanceIsA("BillboardGui"))
local r6 = t.strict(t.instanceIsA("Folder"))
local r7 = Log.new()
local s1 = {}
local s2 = {}
local s3 = {}
local s4 = {}
local LocalPlotChanged = { LocalPlotChanged = (Signal.new()), PlotChanged = (Signal.new()), FolderChanged = (Signal.new()) }
local r8 = Streamable.Streamable.new(Workspace, "Plots")
local LocalPlayer = Players.LocalPlayer
local function localSlot() -- proto[0], line 58  -- upvalues: s1, LocalPlayer
	for _k4, _v5 in ipairs(s1) do
		if _v5 == LocalPlayer.UserId then return _k4 end
	end
	return _k4
end
local s5 = LocalPlotChanged
local function announce(v11) -- proto[1], line 70  -- upvalues: s5, s1, LocalPlayer
	local v_u2 = nil
	for _k5, _v6 in ipairs(s1) do
		if (_v6 == LocalPlayer.UserId) then
			v_u2 = _k5
		end
	end
	if v_u2 ~= v11 then return end
	s5 = s5.LocalPlotChanged
end
Streamable = Streamable.Streamable
local function follow(v12, v13, v14, v15) -- proto[3], line 80  -- upvalues: Streamable
	local function anon2() -- proto[2], line 82  -- upvalues: new
	end
end
ReplicatedStorage = r3
local ReplicatedStorage_2 = r4
local ReplicatedStorage_3 = r5
local function watchSlot(self, v16) -- proto[18], line 86  -- upvalues: s4, Trove, Streamable, s5, s1, LocalPlayer, ReplicatedStorage, s3, ReplicatedStorage_2, ReplicatedStorage_3
	if s4[self] then return end
	local _r5 = tostring(self)
	local plot = { plot = Streamable.new, trove = Trove.new }
	s4[self] = plot
	local new = Streamable.new
	local function ping() -- proto[6], line 103  -- upvalues: self, s5, s1, LocalPlayer
		local v_u2 = nil
		for _k5, _v6 in ipairs(s1) do
			if (_v6 == LocalPlayer.UserId) then
				v_u2 = _k5
			end
		end
		if v_u2 ~= self then return end
		s5 = s5.LocalPlotChanged
	end
	Trove.new:Add(Streamable.new:Observe(function(v17, v18)
		if not (v17.IsA) then
			if not (v17.IsA) then return end
			local v_u1 = nil
			local self_2 = nil
			for _k7, _v8 in ipairs(s1) do
				if (_v8 == LocalPlayer.UserId) then
					v_u1 = _k7
				end
			end
		end
		if v_u1 == self then
			s5 = s5.LocalPlotChanged
			self_2 = self
		end

		Streamable = Streamable.new
		local new = Streamable
		local function anon2() -- proto[2], line 82  -- upvalues: new
		end

		Streamable = Streamable.new
		-- anon2 captures: new

		Streamable = Streamable.new
		-- anon2 captures: new
		if ((v17 ^ "Folder") * (v17 ^ "Folder")) > K[262873] then
			Streamable = Streamable.new
			-- anon2 captures: new
			Streamable = Streamable.new
			-- anon2 captures: new
		end
	end))
end
local function forgetSlot(v27) -- proto[19], line 174  -- upvalues: s4, s3
	if s4[v27] == nil then return end
	s3[v27] = nil
	s4[v27] = nil
end
local function forgetEverySlot() -- proto[20], line 183  -- upvalues: s4, s3
	local _r0 = {}
	for _v4 in ipairs(s4) do
		table.insert(_r0, _k4)
	end
	for _k4, _v5 in ipairs(_r0) do
		if s4[_v5] == nil then continue end
		s3[_v5] = nil
		s4[_v5] = nil
	end
end
local function slotFor(v28) -- proto[21], line 194  -- upvalues: LocalPlayer, ReplicatedStorage, s1
	local v_u3
	if (v28 or LocalPlayer) == LocalPlayer then
		local ReplicatedStorage_2 = nil
		for _k6, _v7 in ipairs(s1) do
			if _v7 ~= LocalPlayer.UserId then continue end
			ReplicatedStorage_2 = _k6
	for _k6, _v7 in ipairs(s1) do
		if v_u3 ~= nil then continue end
		if _v7 ~= (v28 or LocalPlayer).UserId then continue end
		v_u3 = _k6
	end
	return v_u3, (v28 or LocalPlayer)
end
function LocalPlotChanged.ReadOwners() -- proto[22], line 210  -- upvalues: s1
	return table.clone(s1)
end
function LocalPlotChanged.LookupOwner(v29) -- proto[23], line 212  -- upvalues: s1
	return s1[v29]
end
function LocalPlotChanged.ResolveLocalSlot() -- proto[24], line 214  -- upvalues: s1, LocalPlayer
	for _k4, _v5 in ipairs(s1) do
		if _v5 == LocalPlayer.UserId then return _k4 end
	end
	return _k4
end
function LocalPlotChanged.ResolveFolder() -- proto[25], line 216  -- upvalues: U0
	return U0
end
function LocalPlotChanged.ResolvePlot(v30) -- proto[26], line 220  -- upvalues: slotFor, U1, s3
	local v_u4
	if (slotFor ~= nil) and (U1 ~= nil) then
		local _r5 = tostring(slotFor)
	end
	if not ((nil).IsA) then return nil end
	if (nil).FindFirstChild ~= nil then
		v_u4 = s3[slotFor]
	end
	s3[slotFor] = v_u4
	local Slot = { Slot = slotFor, PlotFolder = nil, PetArea = nil, CenterPoint = nil, RespawnPointCFrame = s3[slotFor] }
	return Slot
end
function LocalPlotChanged.FindLocalBaseSign() -- proto[27], line 247  -- upvalues: s5
	if nil == nil then return nil end
	if not (nil).IsA then return nil end
	return nil
end
function LocalPlotChanged.FindRespawnCFrame(v31) -- proto[28], line 257  -- upvalues: slotFor, s3
	if slotFor ~= nil then return s3[slotFor] end
	return nil
end
local Vector3 = r2
function LocalPlotChanged.ContainsLocalPoint(v32) -- proto[29], line 262  -- upvalues: Vector3, s5
	if not (s5.ResolvePlot) then return false end
	if (math.abs((s5.ResolvePlot.PlotFolder.GetBoundingBox).PointToObjectSpace.X)) > (s5.ResolvePlot.PlotFolder * 0.5).X then return f1 end
	local r9 = math.abs((s5.ResolvePlot.PlotFolder.GetBoundingBox).PointToObjectSpace.Z)
	local f1 = false  -- skip 1
	f1 = true
	return f1
end
local function adoptOwner(v33, v34) -- proto[30], line 276  -- upvalues: s1, LocalPlayer, s5
	local v_u3 = nil
	for _k6, _v7 in ipairs(s1) do
		if (_v7 == LocalPlayer.UserId) then
			v_u3 = _k6
		end
	end
	s1[v33] = v34
	if v34 ~= LocalPlayer.UserId then
		if v_u3 ~= v33 then return end
	end
end
local function acceptUpdate(v35) -- proto[31], line 286  -- upvalues: s2, s1, LocalPlayer, s5
	if s2[v35.Slot] ~= nil then
		if s2[v35.Slot] >= v35.Revision then return end
	end
	s2[v35.Slot] = v35.Revision
	local v_u5 = nil
	for _k8, _v9 in ipairs(s1) do
		if (_v9 == LocalPlayer.UserId) then
			v_u5 = _k8
		end
	end
	s1[v35.Slot] = v35.UserId
	if v35.UserId ~= LocalPlayer.UserId then
		if v_u5 ~= v35.Slot then return end
	end
end
local function acceptSnapshot(v36) -- proto[32], line 294  -- upvalues: s2, s1, LocalPlayer, s5
	local v_u6
	local f2
	local f3
	local _r1 = {}
	for _k5, _v6 in ipairs(v36.OwnersBySlot) do
		local _r7 = assert((tonumber(_k5)), (("plot snapshot carried a non-numeric slot: %*"):format(_k5)))
		_r1[_r7] = true
		if s2[_r7] ~= nil then
			if s2[_r7] >= v36.Revision then continue end
		end
		s2[_r7] = v36.Revision
		local state_5_2 = nil
		for _k13, _v14 in ipairs(s1) do
			if (_v14 == LocalPlayer.UserId) then
				v_u6 = _k13
			end
		end
		s1[_r7] = _v6
		if _v6 ~= LocalPlayer.UserId then
			if v_u6 ~= _r7 then continue end
		end
	end
	local _r2 = {}
	for _v6 in ipairs(s2) do
		table.insert(_r2, _k6)
	end
	for _k6, _v7 in ipairs(_r2) do
		_r2 = _r1[_v7]
		if _r2 ~= true then
			_r2 = s2[_v7]
			f2 = not (_r2 >= v36.Revision)
		end
		if f2 then
			f3 = not (s1[_v7] == nil)
		end
		s2[_v7] = s2[_v7]
		if not f3 then continue end
		local state_5_3 = nil
		for _k14, _v15 in ipairs(s1) do
			if (_v15 == LocalPlayer.UserId) then
				state_5_3 = _k14
			end
		end
		s1[_v7] = nil
		if LocalPlayer.UserId ~= nil then
			if state_5_3 ~= _v7 then continue end
		end
	end
end
local function askState() -- proto[33], line 322  -- upvalues: Remotes
	return Remotes.Homestead.AskState:InvokeServer()
end
local function pullSnapshot() -- proto[34], line 324  -- upvalues: askState, Plots, acceptSnapshot
	if not (pcall) then
		return false, (tostring(askState))
	end
	if not (Plots.SchemaValidation.PlotStateSnapshot) then
		return false, (("plot snapshot failed validation: %*"):format(askState))
	end
	return true
end
local pullUntilAnswered = <closure K60>
local function pullUntilAnswered() -- proto[35], line 339  -- upvalues: askState, Plots, acceptSnapshot, ReplicatedStorage, pullUntilAnswered
	local _r4
	local v_u2
	local f4
	local _r4_2 = nil
	if (not (pcall)) then
		_r4 = tostring(askState)
		v_u2 = _r4
	else
		if (not (Plots.SchemaValidation.PlotStateSnapshot)) then
			f4 = false
			v_u2 = ("plot snapshot failed validation: %*"):format(askState)
			_r4 = v_u2
		else
			f4 = true
		end
	end
	if f4 then return end
	local r10 = ("plot snapshot request did not land, retrying: %*"):format(_r4_2)
end
Remotes.Homestead.StateShifted.OnClientEvent:Connect(function(v37)
	if Plots.SchemaValidation.PlotStateUpdate then
		if s2[v37.Slot] ~= nil then
			if s2[v37.Slot] >= v37.Revision then return end
		end
		s2[v37.Slot] = v37.Revision
		local v_u7 = nil
		for _k10, _v11 in ipairs(s1) do
			if (_v11 == LocalPlayer.UserId) then
				v_u7 = _k10
			end
		end
		s1[v37.Slot] = v37.UserId
		if v37.UserId ~= LocalPlayer.UserId then
			if v_u7 ~= v37.Slot then return end
		end
		return
	end
	local r10 = ("plot state update failed validation: %*"):format(v37)
end)
r8:Observe(function(self, v38)
	U1 = self

	local function watchIfNumbered(v39) -- proto[38], line 370  -- upvalues: watchSlot, self
		local n1 = tonumber(v39.Name)
		if n1 == nil then return end
	end
	for _k6, _v7 in ipairs(self.GetChildren) do
		local n1 = tonumber(_v7.Name)
		if n1 == nil then continue end
	end

end)
task.spawn(pullUntilAnswered)
local function onNearbyPurchase(v42) -- proto[42], line 401  -- upvalues: Storefront
end
Remotes.Homestead.AskNearbyPurchase.OnClientEvent:Connect(onNearbyPurchase)
return LocalPlotChanged