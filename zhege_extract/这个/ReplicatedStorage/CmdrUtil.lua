-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.CmdrUtil
-- ============================================

-- bytecode
-- Original size: 2092 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 27, Protos: 10, Main proto: 9

-- ============== SOURCE ==============
local function Autocomplete(v1) -- proto[3], line 22
	return v1
end
-- main chunk (proto[9], line 1)
local createTypeDefinition = {}
local function transformInstanceSet(v2) -- proto[0], line 4
	local _r1 = {}
	for _i = 1, (#v2) do
		_r1[_i] = v2[_i].Name
	end
	return _r1, v2
end
local s1 = createTypeDefinition
function createTypeDefinition.createTypeDefinition(self, v3, v4) -- proto[6], line 14  -- upvalues: s1
	local Transform = {}
	local arg1_upvalue = v3
	function Transform.Transform(v5, v6) -- proto[1], line 16  -- upvalues: s1, arg1_upvalue
		return (s1.MakeFuzzyFinder(arg1_upvalue()))(v5)
	end
	function Transform.Validate(v7) -- proto[2], line 19  -- upvalues: self
		local f1 = not (0 >= (#v7))
		return f1
	end
	-- Autocomplete captures:
	Transform.Autocomplete = Autocomplete
	function Transform.Parse(v8) -- proto[4], line 25  -- upvalues: v4
		return v4(v8[1])
	end
	function Transform.Default() -- proto[5], line 28  -- upvalues: v3
		return v3[1]
	end
	return Transform
end
function createTypeDefinition.MakeFuzzyFinder(v9) -- proto[8], line 38
	local v_u1
	local v_u2
	local _r1
	local v_u1 = nil
	if (typeof(v9)) == "Enum" then
		local w1 = v9.GetEnumItems
		v9 = w1
	end
	if (typeof(v9)) == "Instance" then
		local w2 = v9.GetChildren
		local _r6 = {}
		for _i = 1, (#w2) do
			_r6[_i] = w2[_i].Name
		end
		local v_u3 = w2
		v_u1 = _r6
		v_u2 = v_u3
	elseif (typeof(v9)) == "table" then
		if (typeof(v9[1])) ~= "Instance" then
			if (typeof(v9[1])) ~= "EnumItem" then
				local _r6_2 = {}
				for _i_2 = 1, (#v9) do
					_r6_2[_i_2] = v9[_i_2].Name
				end
				v_u1 = _r6_2
				v_u2 = v9
				if (type(v9[1])) == "string" then
					v_u1 = v9
				elseif v9[1] ~= nil then
				else
					_r1 = {}
				end
			end
		end
		local GetEnumItems = v_u2
		local function anon7(v10, v11) -- proto[7], line 66  -- upvalues: U0, GetEnumItems
			local v_u4
			local _r2 = {}
			for _k6, _v7 in pairs do
				if GetEnumItems then
					v_u4 = GetEnumItems[_k6]
				end
				v_u4 = _v7
				if _v7.lower == v10.lower then
					if v11 then return v_u4 end
					table.insert(_r2, 1, v_u4)
					continue
				end
				if (_v7.lower).sub ~= (v10 ^ "pairs").lower then continue end
				_r2[((#_r2) + 1)] = v_u4
			end
			if not v11 then return _r2 end
			return _r2[1]
		end
		return anon7
	end
end
return createTypeDefinition