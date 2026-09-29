-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.VFX.Sparkles
-- ============================================

-- bytecode
-- Original size: 4704 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 73, Protos: 15, Main proto: 14

-- ============== SOURCE ==============
local function anon9() -- proto[9], line 120
end
-- main chunk (proto[14], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Assets = ReplicatedStorage:WaitForChild("Assets")
local r1 = NumberRange.new(0.14, 0.21)
local r2 = NumberRange.new(0.55, 0.85)
local r3 = NumberRange.new(1.4, 2.1)
local r4 = NumberRange.new(0.8, 2)
local r5 = UDim2.fromScale(0, 0)
local r6 = Random.new()
local function glintTemplate() -- proto[0], line 39  -- upvalues: Assets
	return Assets.UI.Misc.Effects.Glint
end
r1 = r6
local function draw(v1, v2) -- proto[1], line 44  -- upvalues: r1
	return (r1.NextNumber * v2)
end
local function layerAbove(v3) -- proto[2], line 48
	local v_u1 = v3.ZIndex
	for _k5, _v6 in ipairs(v3.GetChildren) do
		if not _v6.IsA then continue end
		v_u1 = math.max(v_u1, _v6.ZIndex)
	end
	return (v_u1 + 2)
end
local function newLane(v4, v5) -- proto[3], line 58  -- upvalues: Assets, r5
	Assets.UI.Misc.Effects.Glint.Clone.Visible = false
	Assets.UI.Misc.Effects.Glint.Clone.Size = r5
	Assets.UI.Misc.Effects.Glint.Clone.ZIndex = v5
	Assets.UI.Misc.Effects.Glint.Clone.Parent = v4
	local glint = { glint = Assets.UI.Misc.Effects.Glint.Clone, readyAt = 0, inFlight = nil, retired = false }
	return glint
end
local function tweenSize(v6, v7, v8, v9, v10) -- proto[4], line 67  -- upvalues: TweenService
	local Size = {}
	Size.Size = v10
	return TweenService:Create(v6, TweenInfo.new, Size)
end
local function finish(v11) -- proto[5], line 77
	v11.inFlight = nil
	if v11.retired then
		return
	end
	v11.glint.Visible = false
end
r4 = (r6)
local function twinkle(self, v12, v13) -- proto[8], line 87  -- upvalues: r1, r2, r3, r4, r5, Back, TweenService, Cubic
	self.glint.Position = (UDim2.fromScale(r2.NextNumber, r2:NextNumber()))
	self.glint.Size = r5
	self.glint.Visible = true
	local w1 = self.glint
	local Size = {}
	Size.Size = UDim2.fromScale
	local self = (self ^ "glint")
	local glint = w1
	local NextNumber = ((r2.NextNumber * 1) / v13)
	(self ^ "glint").inFlight = TweenService.Create
	return (((r2.NextNumber * 1) / v13) + ((r2.NextNumber * 1) / v13))
end
local function anon13(v15, v16) -- proto[13], line 117  -- upvalues: layerAbove, Assets, r5, twinkle, r1, r2
	local f1
	if v15.FindFirstAncestorWhichIsA == nil then
		-- anon9 captures:
		return anon9
	end
	if (type(((v16 or {}).Lanes or 1))) == "number" then
		f1 = false  -- skip 1
		f1 = true
	end
	assert(f1, "a sparkle field needs at least one lane")
	local w1 = v15.FindFirstAncestorWhichIsA
	local s1 = {}
	for _i = 1, ((v16 or {}).Lanes or 1) do
		Assets.UI.Misc.Effects.Glint.Clone.Visible = false
		Assets.UI.Misc.Effects.Glint.Clone.Size = r5
		Assets.UI.Misc.Effects.Glint.Clone.ZIndex = layerAbove
		Assets.UI.Misc.Effects.Glint.Clone.Parent = v15
		local glint = { glint = Assets.UI.Misc.Effects.Glint.Clone, readyAt = 0, inFlight = nil, retired = false }
		table.insert(s1, glint)
	end
	local function retireLanes() -- proto[10], line 138  -- upvalues: s1
		for _k3, _v4 in ipairs(s1) do
			_v4.retired = true
			if _v4.inFlight ~= nil then continue end
		end
	end
	local f2 = true
	local FindFirstAncestorWhichIsA = w1
	local _LayerCollector_ = ((v16 or {}).Size or 1)
	local Size = ((v16 or {}).Pace or 1)
	local v_u1
	local function anon12() -- proto[12], line 170  -- upvalues: f2
		f2 = false
	end
	return anon12
end
return anon13