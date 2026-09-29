-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.PlotUpgradeVisibility
-- ============================================

-- bytecode
-- Original size: 1348 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 28, Protos: 3, Main proto: 2

-- ============== SOURCE ==============
-- main chunk (proto[2], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlotState = require(ReplicatedStorage.Client.PlotState)
local t = require(ReplicatedStorage.Packages.t)
local Apply = {}
local function paintSubtree(v1, v2) -- proto[0], line 16
	for _k5, _v6 in ipairs(v1:GetDescendants()) do
		if _v6.IsA then
			_v6.LocalTransparencyModifier = 1
			continue
		end
		if _v6.IsA then
			_v6.Enabled = v2
			continue
		end
		if _v6.IsA and not (v2) then
			_v6.Enabled = false
			continue
		end
		if not _v6.IsA then continue end
		if _v6.Name == "CanUpgrade" then continue end
		_v6.Enabled = true
	end
end
function Apply.Apply(v3, v4) -- proto[1], line 34  -- upvalues: t, PlotState, paintSubtree
	local t1
	local r1 = t.strict(t.optional(t.boolean))
	if (PlotState.ResolveLocalSlot ~= nil) then
		t1 = tostring(PlotState.ResolveLocalSlot)
	else
		t1 = nil
	end
	for _k9, _v10 in ipairs(PlotState.ResolveFolder.GetDescendants) do
		if _v10.Name ~= (v3 ^ "strict") then continue end
		if _v10.Parent == nil then continue end
	end
end
return Apply