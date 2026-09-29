-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.SurfaceButtons
-- ============================================

-- bytecode
-- Original size: 840 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 17, Protos: 3, Main proto: 2

-- ============== SOURCE ==============
-- main chunk (proto[2], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local r1 = t.strict(t.instanceIsA("BasePart"))
local r2 = t.strict(t.string)
local Find = {}
local function buttonWithin(v1, v2) -- proto[0], line 12
	if not v1.FindFirstChild then return nil end
	if not (v1.FindFirstChild).IsA then return nil end
	local w1 = v1.FindFirstChild
	return w1
end
ReplicatedStorage = r1
local string = r2
function Find.Find(v3, v4) -- proto[1], line 17  -- upvalues: ReplicatedStorage, string
	local w1 = v3.GetChildren
	local v_u1 = 1
	local v_u2 = nil
	while true do
		if v_u2 ~= nil then return v_u2 end
		if v_u1 > (#w1) then return v_u2 end
		if w1[v_u1].IsA then
			if w1[v_u1].FindFirstChild then
				if (w1[v_u1].FindFirstChild).IsA then
					v_u2 = w1[v_u1].FindFirstChild
				end
				v_u2 = nil
			end
		else
			v_u2 = nil
		end
		v_u1 = v_u1 + 1
	end
	return v_u2
end
return Find