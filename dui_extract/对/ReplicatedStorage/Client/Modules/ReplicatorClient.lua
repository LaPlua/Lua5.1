-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Modules.ReplicatorClient
-- ============================================

-- bytecode
-- Original size: 8978 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 92, Protos: 26, Main proto: 25

-- ============== SOURCE ==============
local function Path(v1, v2) -- proto[20], line 659
	if ((type(v2)) == "string") then
		local _r2 = {v2}
	end
	local function anon19(v3) -- proto[19], line 662  -- upvalues: v2
		if v3 == nil then return table.clone end
		if (type(v3)) == "string" then
			table.insert(table.clone, v3)
			return table.clone
		end
		return table.clone
	end
	return anon19
end
-- main chunk (proto[25], line 1)
if _G.__ReplicatorClientReference then
	error("replicator has already been required on the client in another module.")
end
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local r1 = utf8.char(0)
local r2 = utf8.char(1)
local r3 = utf8.char(2)
local index = {}
local index_2 = {}
local index_3 = {}
local ReplicatorSignal = require(script.ReplicatorSignal)
local Buff = require(script.Buff)
local s1 = {}
local s2 = {}
local s3 = {}
local function ensureDescendantPath(v4, v5) -- proto[0], line 99
	local v_u1 = v4
	for _i = 1, (#v5) do
		if not (v_u1[v5[_i]]) then
			v_u1[v5[_i]] = {}
		end
		v_u1 = _r7
	end
	return v_u1
end
local deepCopy = <closure K20>
local function deepCopy(v6) -- proto[1], line 113  -- upvalues: deepCopy
	for _k5, _v6 in ipairs(table.clone) do
		if (type(_v6)) ~= "table" then continue end
		table.clone[_k5] = deepCopy
	end
	return table.clone
end
local function makeDotCallsError(v7) -- proto[3], line 123
	for _k4, _v5 in ipairs(v7) do
		if (type(_v5)) ~= "function" then continue end
		local function anon2(...) -- proto[2], line 126  -- upvalues: v7, _k4, _v5
			local r4
			if (select(1)) ~= v7 then
				r4 = ("called %* with .%*() instead of :%*()"):format(_k4, _k4, _k4)
				return
			end
			return _v5(r4, ("called %* with .%*() instead of :%*()"), _k4, _k4, _k4)
		end
		v7[_k4] = anon2
	end
end
local fireInitialSignals = <closure K22>
local function fireInitialSignals(v8, v9) -- proto[4], line 137  -- upvalues: index, index_2, index_3, fireInitialSignals
	local v1_e = v8[index]
	if v1_e then
		v1_e.signal:Fire(v9:TryIndex(v1_e.path))
	end
	if v8[index_3] then
		if v9.TryIndex then
			for _k9, _v10 in ipairs(v9.TryIndex) do
			end
		end
	end
	for _k8, _v9 in ipairs(v8) do
		if (type(_k8)) ~= "string" then continue end
	end
end
local disconnectAllSignals = <closure K23>
local function disconnectAllSignals(v10) -- proto[5], line 162  -- upvalues: index, index_2, disconnectAllSignals
	for _k6, _v7 in ipairs(v10) do
		if (type(_k6)) ~= "string" then continue end
	end
end
local s1
local function handlePacket(v11) -- proto[8], line 178  -- upvalues: r1, s1, s3, s2, deepCopy, fireInitialSignals, r2, index_3, U8, index, index_2, r3, disconnectAllSignals
	local w1 = v11[1]
	local w2 = v11[2]
	local w3
	if v11[1] == r1 then
		for _k8, _v9 in ipairs(s1) do
			if _v9 ~= v11[3] then continue end
			if _k8 == v11[2] then continue end
			local r4 = ("client received 2 Replicators with the same Id \"%*\""):format(v11[3])
		end
		s1[v11[2]] = v11[3]
		s2[v11[3]].Data = deepCopy
		return
	end
	if w1 == r2 then
		if not (s1[w2]) then return end
		w3 = s1[w2]
		if not (s2[w3]) then return end
		local s4 = {}
		s1 = s4
		local v1_e
		local v2_e
		local function fireNilDescendants(v12, v13) -- proto[6], line 214  -- upvalues: index_3, s1, U2, index, index_2, deepCopy, fireNilDescendants
			local v3_e = v13[index_3]
			if v3_e and _r3 == "table" then
				for _v6 in type(v12) do
					table.insert(s1, {v3_e.signal, _k6, U2})
				end
			end
			for _k6, _v7 in ipairs(v13) do
				if (type(_k6)) ~= "string" then continue end
				if (type(v12)) == "table" then
					v1_e = v12[_k6]
					v1_e = nil
				end
				v2_e = _v7[index]
				if v2_e then
					table.insert(s1, {v2_e.signal, U2, nil})
				end
				v2_e = _v7[index_2]
				if v2_e then
					local _r13 = {}
					_r13[1], _r13[2], _r13[3] = v2_e.signal, U2, v1_e
					table.insert(s1, _r13)
				end
			end
		end
		local f1
		local f2
		local f3
		local v4_e
		local function apply(v14, v15, v16) -- proto[7], line 254  -- upvalues: fireNilDescendants, index_3, apply, s1, U4, index, index_2, deepCopy
			local v_u2
			if (type(v15)) == "table" and v15.__none == "__none" then
				if not v16 then return nil end
				v_u2 = v14
				return nil
			end
			if (type(v14)) ~= "table" then return v15 end
			if (type(v15)) ~= "table" then return v15 end
			f1 = not (v14[1] == nil)
			local v_u2 = v16
			if v_u2 then
				v_u2 = v16[index_3]
			end
			for _k8, _v9 in next do
				if f1 then
					if (type(_k8)) == "string" then
						_k8 = tonumber(_k8)
					end
				end
				local _r10_2 = v16
				if _r10_2 then
					_r10_2 = v16[(tostring(_k8))]
				end
				if v_u2 then
					local v_u3 = v14[_k8]
					f2 = not (v_u3 ~= nil)
					f3 = not (apply ~= nil)
					if f2 ~= f3 then
						table.insert(s1, {v_u2.signal, _k8, apply})
					end
				end
				if _r10_2 then
					v4_e = _r10_2[index]
					if v4_e then
						table.insert(s1, {v4_e.signal, apply, v15})
					end
					v4_e = _r10_2[index_2]
					if v4_e then
						local _r17 = {}
						_r17[1], _r17[2], _r17[3] = v4_e.signal, apply, v14[_k8]
						table.insert(s1, _r17)
					end
				end
				v14[_k8] = apply
			end
			return v14
		end
		if s2[w3].Data ~= apply then
			s2[w3].Data = apply
		end
		for _k13, _v14 in ipairs(s4) do
			local _r16, _r17 = unpack(_v14, 2, 3)
		end
		return
	end
	if w1 ~= r3 then return end
	local w4 = s1[w2]
	local v5_e = s2[w4]
	if not (v5_e) then return end
	v5_e._destroyed = true
	s2[w4] = nil
end
function s3.get(v17) -- proto[22], line 370  -- upvalues: s2, ReplicatorSignal, U2, ensureDescendantPath, U4, U5, U6, makeDotCallsError
	local v5_e = s2[v17]
	if v5_e then return v5_e end
	local Data = { Id = v17, Data = nil, Ready = false, Destroying = ReplicatorSignal.new, _indices_signals = {}, _listen_raw_signal = ReplicatorSignal.new, _destroyed = false, _signal_descendants = {} }
	local s1 = Data
	local function registerListener(v18, v19, v20) -- proto[10], line 390  -- upvalues: U0, ensureDescendantPath, s1, ReplicatorSignal
		local signal
		local v_u2 = ensureDescendantPath[v19]
		if not (v_u2) then
			signal = { signal = ReplicatorSignal.new, path = v18, connected = 0 }
			v_u2 = signal
			ensureDescendantPath[v19] = v_u2
		end
		v_u2.connected = (v_u2.connected + 1)
		local s1 = v_u2
		local function anon9() -- proto[9], line 415  -- upvalues: Connect, s1, ensureDescendantPath, v19
			s1.connected = (s1.connected - 1)
			if s1.connected > 0 then return end
			ensureDescendantPath[v19] = nil
		end
		return anon9
	end
	function Data.Listen(v21, v22, v23) -- proto[12], line 452  -- upvalues: registerListener, U1
		if (type(v22[1])) == "table" then
			local s1 = {}
			for _k7, _v8 in ipairs(v22) do
				table.insert(s1, registerListener)
			end
			local function anon11() -- proto[11], line 459  -- upvalues: s1
				for _k3, _v4 in ipairs(s1) do
				end
			end
			return anon11
		end
		return registerListener
	end
	function Data.ListenRaw(v24, v25) -- proto[13], line 488  -- upvalues: s1
		return s1._listen_raw_signal:Connect(v25)
	end
	function Data.Observe(v26, v27, v28) -- proto[14], line 510  -- upvalues: s1, registerListener, U2
		return registerListener
	end
	function Data.ObserveKeys(v29, v30, v31) -- proto[15], line 540  -- upvalues: s1, registerListener, U2
		if s1.TryIndex then
			for _k7, _v8 in ipairs(s1.TryIndex) do
			end
		end
		return registerListener
	end
	function Data.ListenKeys(v32, v33, v34) -- proto[16], line 572  -- upvalues: registerListener, U1
		return registerListener
	end
	function Data.Index(v35, v36) -- proto[17], line 591  -- upvalues: s1
		local s3 = s1.Data
		for _k7, _v8 in ipairs(v36) do
			s3 = s3[_v8]
			if _k7 >= (#v36) then continue end
			if (type(s3)) == "table" then continue end
			local r4 = ("Replicator:Index() failed %* is not a table."):format(table.concat)
		end
		return s3
	end
	function Data.TryIndex(v37, v38) -- proto[18], line 623  -- upvalues: s1
		if (type(s1.Data)) ~= "table" then return nil end
		for _k7, _v8 in ipairs(v38) do
			if _k7 >= (#v38) then continue end
			if (type(s1.Data[_v8])) ~= "table" then return nil end
		end
		return s1.Data[_v8]
	end
	-- Path captures:
	Data.Path = Path
	function Data.WaitForLoaded(v39) -- proto[21], line 690  -- upvalues: s1
		if s1.Data then return end
	end
	s2[v17] = Data
	return Data
end
local f4 = false
function s3.init() -- proto[24], line 724  -- upvalues: f4, ReplicatedStorage, Buff, handlePacket
	if f4 then return end
	f4 = true
	local f4 = false
end
_G.__ReplicatorClientReference = s3
return s3