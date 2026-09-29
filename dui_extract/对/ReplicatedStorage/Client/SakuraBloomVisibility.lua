-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.SakuraBloomVisibility
-- ============================================

-- bytecode
-- Original size: 1922 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 37, Protos: 7, Main proto: 6

-- ============== SOURCE ==============
-- main chunk (proto[6], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trove = require(ReplicatedStorage.Packages.Trove)
local _r2 = {"LocalTransparencyModifier", "CanCollide", "CanQuery", "CanTouch"}
local CanCollide = { CanCollide = false, CanQuery = false, CanTouch = false, LocalTransparencyModifier = 1 }
local s1 = {"Decal", "Texture"}
local _r5 = {"Transparency"}
local Transparency = { Transparency = 1 }
local _r7 = {"Enabled"}
local Enabled = { Enabled = false }
local s2 = {"ParticleEmitter", "Beam", "Trail", "BillboardGui", "SurfaceGui", "Highlight", "Light", "ProximityPrompt"}
local Conceal = {}
local function anyClassMatches(v1, v2) -- proto[0], line 36
	for _k5, _v6 in ipairs(v2) do
		if v1.IsA then return true end
	end
	return false
end
local function muteFields(v3, v4, v5, v6) -- proto[2], line 48
	for _k8, _v9 in ipairs(v5) do
		table.create[_k8] = v4[_v9]
		v4[_v9] = v6[_v9]
	end
	local arg1_2 = v4
end
local data = CanCollide
local data_2 = Transparency
local data_3 = Enabled
local function mute(v7, v8) -- proto[3], line 73  -- upvalues: muteFields, U1, data, s1, U4, data_2, s2, U7, data_3
	local f1
	if v8.IsA then
		return
	end
	for _k7, _v8 in ipairs(s1) do
		if (v8.IsA) then
			f1 = true
		end
		f1 = false
	end
	if f1 then
		return
	end
	for _k7, _v8 in ipairs(s2) do
		if (v8.IsA) then
			f1 = true
		end
		f1 = false
	end
	if not f1 then return end
end
function Conceal.Conceal(v9) -- proto[5], line 83  -- upvalues: Trove, mute
	for _k5, _v6 in ipairs(v9.GetDescendants) do
	end
	Trove.new:Add(v9.DescendantAdded:Connect(function(v10)
	end))
	return Trove.new
end
return table.freeze(Conceal)