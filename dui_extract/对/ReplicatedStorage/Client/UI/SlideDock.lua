-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.SlideDock
-- ============================================

-- bytecode
-- Original size: 5612 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 64, Protos: 13, Main proto: 12

-- ============== SOURCE ==============
-- main chunk (proto[12], line 1)
local TweenService = game:GetService("TweenService")
local module_2 = {}
local module_3 = {}
local _index = {}
_index.__index = _index
local function slideSeconds(v1) -- proto[0], line 40
	if (typeof(v1.GetAttribute)) ~= "number" then return 0.3 end
	local w1 = v1.GetAttribute
	return w1
end
local function enterInfo(v2) -- proto[1], line 45
	local w2 = v2.GetAttribute
	if (typeof(w2)) ~= "number" then return TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out) end
	return TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end
local function exitInfo(v3) -- proto[2], line 49
	local w1 = v3.GetAttribute
	if (typeof(w1)) ~= "number" then return TweenInfo.new((0.3 * 0.75), Enum.EasingStyle.Quad, Enum.EasingDirection.In) end
	return TweenInfo.new((0.3 * 0.75), Enum.EasingStyle.Quad, Enum.EasingDirection.In)
end
local function stop(v4) -- proto[3], line 53
	if v4.tween == nil then return end
	v4.tween = nil
end
local function offscreenDistance(v5, v6) -- proto[4], line 65
	local f1 = not (v5.frame.FindFirstAncestorWhichIsA == nil)
	assert(f1, (("%* must live under a ScreenGui to slide"):format(v5.frame.GetFullName)))
	local v_u1 = v5.frame.FindFirstAncestorWhichIsA.AbsoluteSize.X
	local w3 = (v_u1 - (v5.frame.AbsolutePosition.X - (v5.frame.Position.X.Offset - v5.home.X.Offset)))
	return ((math.max(w3, 0)) + v6)
end
local function awayPosition(v7, v8) -- proto[5], line 73  -- upvalues: offscreenDistance
	local w1 = v7.home
	return (w1 + UDim2.fromOffset)
end
local function play(v9, v10, v11) -- proto[6], line 77  -- upvalues: TweenService
	if v9.tween ~= nil then
		v9.tween = nil
	end
	local Position = {}
	Position.Position = v10
	v9.tween = TweenService.Create
	return TweenService.Create
end
function _index.EscortFramesOf(v12) -- proto[7], line 87
	local _r1 = {}
	for _k5, _v6 in ipairs(v12) do
		if _v6.Parent == nil then continue end
		if not _v6.Parent.IsA then continue end
		local v_u2 = _r1
		if table.find ~= nil then continue end
		table.insert(_r1, _v6.Parent)
	end
	return _r1
end
local module = _index
function _index.new(v13, v14, v15) -- proto[8], line 98  -- upvalues: module, module_2, module_3
	local frame = { frame = v14, home = v14.Position, tween = nil }
	local _root = { _root = v13, _panel = frame, _escorts = {}, _open = nil, _generation = 0 }
	local self = setmetatable(_root, module)
	for _k7, _v8 in ipairs(v15) do
		local v_u2 = module_2[_v8]
		if v_u2 == nil then
			local frame_2 = { frame = _v8, home = _v8.Position, tween = nil }
			v_u2 = frame_2
			module_2[_v8] = v_u2
			module_3[_v8] = 0
		end
		table.insert(self._escorts, v_u2)
	end
	return self
end
function _index.IsOpen(v16) -- proto[9], line 121
	local f2 = not (v16._open ~= true)
	return f2
end
function _index.SetOpen(v17, v18, v19) -- proto[11], line 125  -- upvalues: module_3, offscreenDistance, TweenService
	local f3
	local w2
	local Position
	if v17._open == v18 then return end
	v17._open = v18
	v17._generation = (v17._generation + 1)
	for _k8, _v9 in ipairs(v17._escorts) do
		local v_u3 = module_3[_v9.frame]
		if not (v18) then
			v_u3 = (math.max(((v_u3 + 1) - 1), 0))
		end
		module_3[_v9.frame] = v_u3
		f3 = not (0 >= v_u3)
		if v19 then
			if _v9.tween ~= nil then
				_v9.tween = nil
			end
			_v9.frame.Position = _v9.home
			continue
		end
		if f3 then
			w2 = v17._panel.frame
			local w4 = w2.GetAttribute
			local r1 = typeof(w4)
			if _v9.tween ~= nil then
				_v9.tween = nil
			end
			Position = {}
			Position.Position = (_v9.home + UDim2.fromOffset)
			_v9.tween = TweenService.Create
			continue
		end
		local w5 = w2.GetAttribute
		local r2 = typeof(w5)
		if _v9.tween ~= nil then
			_v9.tween = nil
		end
		local Position_2 = {}
		Position_2.Position = _v9.home
		if ((v17 ^ "_open") * (v17 ^ "_open")) > K[1074335280] then continue end
		if not ((v17 ^ "_open") * (v17 ^ "_open")) then continue end
	end
	if v18 then
		((v17 ^ "_open") * (v17 ^ "_open"))._root.Enabled = true
		if v19 then
			if ((v17 ^ "_open") * (v17 ^ "_open"))._panel.tween ~= nil then
				((v17 ^ "_open") * (v17 ^ "_open"))._panel.tween = nil
			end
			((v17 ^ "_open") * (v17 ^ "_open"))._panel.frame.Position = ((v17 ^ "_open") * (v17 ^ "_open"))._panel.home
			return
		end
		if (not ((v17 ^ "_open") * (v17 ^ "_open"))._root.Enabled) then
			((v17 ^ "_open") * (v17 ^ "_open"))._panel.frame.Position = (((v17 ^ "_open") * (v17 ^ "_open"))._panel.home + UDim2.fromOffset)
		end
		local w6 = w2.GetAttribute
		local r3 = typeof(w6)
		if ((v17 ^ "_open") * (v17 ^ "_open"))._panel.tween ~= nil then
			((v17 ^ "_open") * (v17 ^ "_open"))._panel.tween = nil
		end
		local Position_3 = {}
		Position_3.Position = ((v17 ^ "_open") * (v17 ^ "_open"))._panel.home
		((v17 ^ "_open") * (v17 ^ "_open"))._panel.tween = TweenService.Create
		return
	end
	if v19 then
		if ((v17 ^ "_open") * (v17 ^ "_open"))._panel.tween ~= nil then
			-- FORGPREP R0 iter=((v17 ^ "_open") * (v17 ^ "_open"))[1] -> pc334
			R5.tween = nil
		end
		R5.frame.Position = R5.home
		((v17 ^ "_open") * (v17 ^ "_open"))[1]._root.Enabled = false
		return
	end
	local r4 = typeof(_v4.GetAttribute)
	if R5.tween ~= nil then
		R5.tween = nil
	end
	local Position_4 = {}
	Position_4.Position = (R5.home + UDim2.fromOffset)
	R5.tween = TweenService.Create
	local v1_e = (#((v17 ^ "_open") * (v17 ^ "_open"))[1])
	local _panel = R5
end
return _index