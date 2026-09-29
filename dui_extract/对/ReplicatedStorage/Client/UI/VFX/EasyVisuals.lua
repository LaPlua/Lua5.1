-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.VFX.EasyVisuals
-- ============================================

-- bytecode
-- Original size: 4370 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 75, Protos: 13, Main proto: 12

-- ============== SOURCE ==============
-- main chunk (proto[12], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dropshadow = require(script.Dropshadow)
local Gradient = require(script.Gradient)
local Layers = require(script.Layers)
local GradientTemplates = require(script.GradientTemplates)
local Stroke = require(script.Stroke)
local t = require(ReplicatedStorage.Packages.t)
local VisibilityGate = require(script.VisibilityGate)
local UIStroke = { UIStroke = true, UIGradient = true }
local _index = {}
_index.__index = _index
_index.Gradient = Gradient
_index.Stroke = Stroke
_index.Dropshadow = Dropshadow
_index.Templates = GradientTemplates
_index.CurrentEffects = {}
local r1 = t.strict(t.union((t.instanceIsA("GuiObject")), t.instanceIsA("UIStroke")))
local r2 = t.strict(t.string)
local r3 = t.strict(t.number)
local r4 = t.strict(t.union(t.ColorSequence, t.Color3))
local r5 = t.strict(t.union(t.NumberSequence, t.number))
local function broadcast(v1, v2) -- proto[0], line 61
	for _k5, _v6 in ipairs(v1.EffectObjects) do
		if not _v6[v2] then continue end
	end
end
local function absorb(v3, v4) -- proto[1], line 70
	if not (v4) then return end
	for _k5, _v6 in ipairs(v4) do
		v3[((#v3) + 1)] = _v6
	end
end
local function teardown(v5) -- proto[2], line 80
	for _k4, _v5 in ipairs(v5.detached) do
		_v5.Parent = v5.host
	end
	for _k4, _v5 in ipairs(v5.watchers) do
		if (typeof(_v5)) == "table" then
			if (typeof(_v5.Destroy)) == "function" then
				continue
			end
		end
	end
	for _k4, _v5 in ipairs(v5.EffectObjects) do
		if not _v5.Destroy then continue end
	end
end
local function watchLifetime(v6) -- proto[4], line 102  -- upvalues: teardown
	local host = v6.host
	local function anon3() -- proto[3], line 105  -- upvalues: host, teardown, v6
		if host.IsDescendantOf then return end
	end
	return v6.host.AncestryChanged:Connect(anon3)
end
local s1 = UIStroke
local function stashExisting(v7) -- proto[5], line 114  -- upvalues: s1
	for _k6, _v7 in ipairs(v7.host.GetChildren) do
		if not s1[_v7.ClassName] then continue end
		v7.detached[((#v7.detached) + 1)] = _v7
		_v7.Parent = nil
	end
end
ReplicatedStorage = r1
local string = r2
local Presets = script.Presets
local number = r3
local ReplicatedStorage_2 = r4
local ReplicatedStorage_3 = r5
local module = _index
function _index.new(v8, v9, v10, v11, v12, v13, v14, v15, v16) -- proto[8], line 126  -- upvalues: ReplicatedStorage, string, Presets, number, ReplicatedStorage_2, ReplicatedStorage_3, module, stashExisting, teardown, VisibilityGate
	local v_u2
	local host
	local f1
	local v_u1 = v9
	assert(Presets.FindFirstChild, (("EasyVisuals has no preset named %*"):format(v9)))
	if v15 ~= nil then
		v_u2 = v15
	end
	host = { host = (v8 ^ "FindFirstChild"), EffectObjects = {}, detached = {}, watchers = {}, isPaused = false, resumesWhenShown = v_u2, drift = (v10 or 0.007), width = (v11 or 1), lifeWatch = nil, Diagnostic = "DIAGNOSTIC VALUE" }
	local self = setmetatable(host, module)
	local Host = { Host = (v8 ^ "FindFirstChild"), Drift = self.drift, Width = self.width, Color = v13, Alpha = v14, Chain = v16 }
	f1 = not ((typeof(require)) ~= "table")
	assert(f1, "an effect preset must hand back a table")
	local w1 = self.watchers
	local Connections = require.Connections
	if (not (Connections)) then
	else
		for _k18, _v19 in ipairs(Connections) do
			w1[((#w1) + 1)] = _v19
		end
	end
	local Effects = require.Effects
	if (not (Effects)) then
	else
		for _k18, _v19 in ipairs(Effects) do
			self.EffectObjects[((#self.EffectObjects) + 1)] = _v19
		end
	end
	host = self.host
	local v8 = self
	local function anon3() -- proto[3], line 105  -- upvalues: host, teardown, v8
		if host.IsDescendantOf then return end
	end
	self.lifeWatch = self.host.AncestryChanged.Connect
	local object = self
	if not VisibilityGate.Watch then return self end
	self.watchers[((#self.watchers) + 1)] = VisibilityGate.Watch
	return self
end
function _index.Destroy(v17) -- proto[9], line 207  -- upvalues: teardown
end
local function Suspend(v18) -- proto[10], line 209
	for _k4, _v5 in ipairs(v18.EffectObjects) do
		local Suspend = _v5.Suspend
		if not Suspend then continue end
	end
end
_index.Suspend = Suspend
local function Wake(v19) -- proto[11], line 211
	for _k4, _v5 in ipairs(v19.EffectObjects) do
		local Wake = _v5.Wake
		if not Wake then continue end
	end
end
_index.Wake = Wake
return table.freeze(_index)