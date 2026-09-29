-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.DecorationScale
-- ============================================

-- bytecode
-- Original size: 4130 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 67, Protos: 15, Main proto: 14

-- ============== SOURCE ==============
local function Applies(v1) -- proto[1], line 46
	local f1 = not (v1.ScaleType ~= Enum.ScaleType.Slice)
	return f1
end
local function Applies(v2) -- proto[2], line 53
	local f1 = not (v2.StrokeSizingMode ~= Enum.StrokeSizingMode.FixedSize)
	return f1
end
-- main chunk (proto[14], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ViewportSize = require(ReplicatedStorage.Client.ViewportSize)
local LeftControls = { LeftControls = true, RightButtons = true }
local Chat = { Chat = true, TouchGui = true }
local function Applies(v3) -- proto[0], line 39
	local f1 = not (v3.ScaleType ~= Enum.ScaleType.Slice)
	return f1
end
local Property = { Property = "SliceScale", Baseline = "AuthoredSliceScale", Applies = Applies }
-- Applies captures:
local Property_2 = { Property = "SliceScale", Baseline = "AuthoredSliceScale", Applies = Applies }
-- Applies captures:
local Property_3 = { Property = "Thickness", Baseline = "AuthoredThickness", Applies = Applies }
local ImageButton = { ImageButton = Property, ImageLabel = Property_2, UIStroke = Property_3 }
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local s1 = Chat
local function isScaledScreen(v4) -- proto[3], line 62  -- upvalues: s1
	local f1
	if not v4.IsA then return f1 end
	local w1 = v4.Name
	if s1[w1] == true then return f1 end
	f1 = not (v4.GetAttribute == false)
	return f1
end
local function screenOf(v5) -- proto[4], line 68  -- upvalues: PlayerGui
	local v_u1 = v5
	while true do
		if v_u1 == nil then return v_u1 end
		if v_u1.Parent == PlayerGui then return v_u1 end
		v_u1 = v_u1.Parent
	end
	return v_u1
end
local function pinned(v6, v7, v8) -- proto[5], line 76
	local v_u2 = v7
	local w1 = v6.GetAttribute
	local w2 = v6.GetAttribute
	if (type(w2)) == "number" then return w1 end
	return v8
end
local s2 = ImageButton
local index = 1
local function scaleDecoration(v9) -- proto[6], line 85  -- upvalues: s2, index
	if s2[v9.ClassName] == nil then return end
	if not (s2[v9.ClassName].Applies) then return end
	local v_u3 = s2[v9.ClassName].Baseline
	local w2 = s2[v9.ClassName].Property
	local w3 = v9[s2[v9.ClassName].Property]
	v9[w2] = (w3 * index)
end
local r1 = 1
local function refit(v10) -- proto[7], line 94  -- upvalues: r1, PlayerGui, s1, s2
	r1 = (math.lerp(1, v10, 0.45))
	for _k4, _v5 in ipairs(PlayerGui.GetChildren) do
		if not _v5.IsA then continue end
		if s1[_v5.Name] == true then continue end
		if _v5.GetAttribute == false then continue end
		for _k9, _v10 in ipairs(_v5.GetDescendants) do
			if s2[_v10.ClassName] == nil then continue end
			if not ((not (s2[_v10.ClassName].Applies))) then
				local v_u4 = s2[_v10.ClassName].Baseline
				_v10[s2[_v10.ClassName].Property] = (_v10[s2[_v10.ClassName].Property] * r1)
			end
		end
	end
end
local function adoptLater(v11) -- proto[9], line 106  -- upvalues: PlayerGui, s1, s2, index
	local function anon8() -- proto[8], line 107  -- upvalues: v11, PlayerGui, s1, s2, index
		local v_u5 = v11
		while true do
			if v_u5 == nil then break end
			if v_u5.Parent == PlayerGui then break end
			v_u5 = v_u5.Parent
		end
		if v_u5 == nil then return end
		if v_u5.IsA then
			local w4 = v_u5.Name
			if s1[w4] ~= true then
				if v_u5.GetAttribute == false then return end
				if s2[v11.ClassName] == nil then return end
				if not (s2[v11.ClassName].Applies) then return end
				local v_u6 = s2[v11.ClassName].Baseline
				v11[s2[v11.ClassName].Property] = (v11[s2[v11.ClassName].Property] * index)
			end
		end
	end
end
PlayerGui.DescendantAdded:Connect(function(v12)
	if s2[v12.ClassName] == nil then return end
	local function anon8() -- proto[8], line 107  -- upvalues: v12, PlayerGui, s1, s2, index
		local v_u5 = v12
		while true do
			if v_u5 == nil then break end
			if v_u5.Parent == PlayerGui then break end
			v_u5 = v_u5.Parent
		end
		if v_u5 == nil then return end
		if v_u5.IsA then
			local w4 = v_u5.Name
			if s1[w4] ~= true then
				if v_u5.GetAttribute == false then return end
				if s2[v12.ClassName] == nil then return end
				if not (s2[v12.ClassName].Applies) then return end
				local v_u6 = s2[v12.ClassName].Baseline
				v12[s2[v12.ClassName].Property] = (v12[s2[v12.ClassName].Property] * index)
			end
		end
	end
end)
ViewportSize.Observe(function(v13, v14)
end)
local s3 = LeftControls
task.spawn(function()
	local _r1 = {"Game", "Treadmill"}
	local s1 = {}
	for _k6, _v7 in ipairs(_r1) do
		for _k11, _v12 in ipairs(require.Frame.GetChildren) do
			if not _v12.IsA then continue end
			local v_u7 = _v12.Name
			if s3[v_u7] ~= true then continue end
			Instance.new.Name = "HudFitScale"
			Instance.new.Parent = _v12
			table.insert(s1, Instance.new)
		end
	end

end)
return table.freeze({})