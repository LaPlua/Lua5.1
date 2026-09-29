-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.Gamepasses
-- ============================================

-- bytecode
-- Original size: 1319 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 33, Protos: 2, Main proto: 1

-- ============== SOURCE ==============
-- main chunk (proto[1], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local Name = { Name = t.string, DisplayName = t.string, Desc = t.string, Icon = t.string, ProductId = (t.intersection(t.integer, t.numberPositive)), Precheck = (t.optional(t.callback)) }
local r1 = t.interface(Name)
local _r3 = {}
local s1 = {}
local r2, r3, r4 = script.Configs:GetChildren()
for _k8, _v9 in ipairs(r2) do
	if not _v9:IsA("ModuleScript") then continue end
	local _v9 = require(_v9)
	local r5, r6 = r1(_v9)
	if not (r5) then
		error((("gamepass config %* is malformed: %*"):format(_v9.Name, r6)))
	end
	if _v9.Name ~= _v9.Name then
		error((("gamepass config %* calls itself \"%*\""):format(_v9.Name, _v9.Name)))
	end
	if s1[_v9.ProductId] ~= nil then
		error((("gamepasses \"%*\" and \"%*\" share ProductId %*"):format(s1[_v9.ProductId].Name, _v9.Name, _v9.ProductId)))
	end
	_r3[_v9.Name] = _v9
	s1[_v9.ProductId] = _v9
end
table.freeze(_r3)
table.freeze(s1)
local function FromProductId(v1) -- proto[0], line 59  -- upvalues: s1
	return s1[v1]
end
local Directory = { Directory = _r3, FromProductId = FromProductId }
return table.freeze(Directory)