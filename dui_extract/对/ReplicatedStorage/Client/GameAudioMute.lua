-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.GameAudioMute
-- ============================================

-- bytecode
-- Original size: 2740 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 31, Protos: 9, Main proto: 8

-- ============== SOURCE ==============
-- main chunk (proto[8], line 1)
local SoundService = game:GetService("SoundService")
local Acquire = {}
local s1 = {}
local s2 = {}
local s3 = {}
local index = {}
local function track(v1) -- proto[3], line 13  -- upvalues: s1, s3, index, s2, U4
	local v_u1
	if not v1.IsA then return end
	if s1[v1] then return end
	local function originalGroup(v2) -- proto[0], line 18  -- upvalues: s3, index
		if s3[v2] ~= index then return s3[v2] end
		return nil
	end
	local group = {}
	if not ((s3[v1.SoundGroup] == index)) then
		v_u1 = s3[v1.SoundGroup]
	end
	group.group = v_u1
	s1[v1] = group
	local s1 = group
	local function route() -- proto[1], line 26  -- upvalues: s1, s1, s2, s3, U4, v1
		local v_u2 = s2[(s1.group or s1)]
		if not (v_u2) then
			v_u2 = Instance.new
			v_u2.Name = "Muted"
			v_u2.Volume = 0
			s3[v_u2] = (s1.group or s1)
			s2[(s1.group or s1)] = v_u2
			v_u2.Parent = U4
		end
		v1.SoundGroup = v_u2
	end
	group.changed = (v1.GetPropertyChangedSignal).Connect
	local v_u3 = s2[({}.group or index)]
	if not (v_u3) then
		v_u3 = Instance.new
		v_u3.Name = "Muted"
		v_u3.Volume = 0
		s3[v_u3] = ({}.group or index)
		s2[({}.group or index)] = v_u3
		v_u3.Parent = U4
	end
	v1.SoundGroup = v_u3
end
local function untrack(v3) -- proto[4], line 50  -- upvalues: s1, s3
	if not (s1[v3]) then return end
	s1[v3] = nil
	if not s3[v3.SoundGroup] then return end
	v3.SoundGroup = s1[v3].group
end
index = 0
local new = nil
local connection = nil
local connection_2 = nil
function Acquire.Acquire() -- proto[7], line 62  -- upvalues: index, new, SoundService, connection, track, connection_2, s1, s3, U8
	index = (index + 1)
	if index <= 1 then
		new = Instance.new
		new.Name = "FullscreenAudioMute"
		new.Parent = SoundService
		connection = game.DescendantAdded.Connect
		connection_2 = game.DescendantRemoving.Connect
		for _k3, _v4 in ipairs(game.GetDescendants) do
		end
	end
	local f1 = false
	local function anon6() -- proto[6], line 80  -- upvalues: f1, index, connection, connection_2, s1, s3, new, U7
		if f1 then return end
		f1 = true
		index = (index - 1)
		if 0 < index then return end
		for _v3 in ipairs(s1) do
			if not (s1[_k3]) then
				continue
			end
			local w1 = s1[_k3]
			s1[_k3] = nil
			if not s3[_k3.SoundGroup] then continue end
			_k3.SoundGroup = w1.group
		end
		new = nil
	end
	return anon6
end
return table.freeze(Acquire)