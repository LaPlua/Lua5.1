-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.AssetChatBubble
-- ============================================

-- bytecode
-- Original size: 6434 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 114, Protos: 14, Main proto: 13

-- ============== SOURCE ==============
local _r19_3
-- main chunk (proto[13], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local EnsureUIScale = require(ReplicatedStorage.Shared.Utils.EnsureUIScale)
local MessageTyper = require(ReplicatedStorage.Client.UI.MessageTyper)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local r1 = Vector2.new(1084, 144)
local r2 = Vector2.new(251, 72)
local r3 = Vector2.new(213.84, 56.4)
local r4 = TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local r5 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local r6 = t.strict(t.instanceIsA("Model"))
local r7 = t.strict(t.instanceIsA("BasePart"))
local r8 = t.strict(t.boolean)
local r9 = t.strict(t.string)
local _index = {}
_index.__index = _index
_index.__class = "AssetChatBubble"
if ReplicatedStorage.Assets.Billboards.ChatBubble:IsA("BillboardGui") and ReplicatedStorage.Assets.Billboards.ChatBubble.Frame:IsA("Frame") then
	_r19_3 = ReplicatedStorage.Assets.Billboards.ChatBubble.Frame.TextLabel:IsA("TextLabel")
end
assert(_r19_3, "the chat bubble blueprint has the wrong instance shape")
local function claimAdornee(v1) -- proto[0], line 65
	if v1.adornee ~= nil then return v1.adornee end
	assert(v1.proxied, "a bubble without an adornee must have been built in proxy mode")
	Instance.new.Name = "AssetBubbleProxy"
	Instance.new.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
	Instance.new.Transparency = 1
	Instance.new.CanCollide = false
	Instance.new.CanQuery = false
	Instance.new.CanTouch = false
	Instance.new.Anchored = false
	Instance.new.Massless = true
	Instance.new.CFrame = (v1.centre.CFrame + Vector3.new(0, -1, 0))
	Instance.new.Parent = v1.model
	local v_u1 = nil
	if v1.centre.Anchored then
		Instance.new.C0 = v1.centre.CFrame.ToObjectSpace
		v_u1 = Instance.new
	else
		v_u1 = Instance.new
	end
	v_u1.Part0 = v1.centre
	v_u1.Part1 = Instance.new
	v_u1.Parent = v1.centre
	(v1 ^ "adornee").adornee = Instance.new
	return Instance.new
end
local function tearDown(v2, v3) -- proto[1], line 101
	if v2.showing == nil then return end
	if v3 ~= nil then
		if v2.showing ~= v3 then return end
		v2.showing = nil
	end
end
r3 = (r3)
local function widenToFit(v4, v5, v6) -- proto[2], line 111  -- upvalues: r1, TextService, r2, r3
	local f1
	local f2
	Instance.new.Font = v5.FontFace
	Instance.new.Size = r1.Y
	Instance.new.Width = 10000
	Instance.new.Text = v6
	local v_u2 = TextService.GetTextBoundsAsync.Y
	f2 = not (0 >= v_u2)
	assert(f2, "measured chat bubble text has no height")
	if v4.Size.X.Offset <= 0 then
		local v_u3 = v4.Size.Y.Offset
		f1 = not (v_u3 > 0)
	end
	assert(f1, "the chat bubble frame must be sized purely in scale")
	local r10 = math.max(r2.X, (TextService.GetTextBoundsAsync.X + (r2.X - r1.X)))
	v4.Size = UDim2.fromScale
end
ReplicatedStorage = r6
local ReplicatedStorage_2 = r7
local boolean = r8
local module = _index
local function new(v7, v8, v9) -- proto[3], line 132  -- upvalues: ReplicatedStorage, ReplicatedStorage_2, boolean, module, Trove
	local self = setmetatable(({}), module)
	self.lifetime = Trove.new
	local v_u4 = nil
	self.showing = v_u4
	self.model = v7
	self.centre = v8
	if not (v9) then
		v_u4 = v8
	end
	self.adornee = v_u4
	self.sizeFactor = (math.max((v8.Size.X / 0.49799999594688416), (v8.Size.Y / 0.4440000057220459)))
	self.proxied = v9
	self.muted = false
	return self
end
_index.new = new
function _index.Destroy(v10) -- proto[4], line 151
	if v10.showing ~= nil then
		v10.showing = nil
	end
	--[[label pc13]]
end
function _index.PinAbove(v11) -- proto[5], line 156  -- upvalues: boolean, U1
	local U1
	U1 = v11
end
function _index.Mute(v12, v13) -- proto[6], line 161  -- upvalues: boolean
	if v12.muted == v13 then return end
	v12.muted = v13
	if not v13 then return end
	if v12.showing == nil then return end
	v12.showing = nil
end
local string = r9
local ChatBubble = ReplicatedStorage.Assets.Billboards.ChatBubble
r2 = r5
function _index.Say(v14, v15, v16) -- proto[12], line 173  -- upvalues: string, ChatBubble, claimAdornee, U3, Trove, widenToFit, EnsureUIScale, MessageTyper, TweenService, r1, r2
	if v14.muted then
		if v16 == nil then return end
		return
	end
	if v14.showing ~= nil then
		v14.showing = nil
	end
	--[[label pc26]]
	assert((ChatBubble.Clone.Frame).IsA, "the cloned chat bubble lost its Frame")
	assert((ChatBubble.Clone.Frame.TextLabel).IsA, "the cloned chat bubble lost its TextLabel")
	local v_u5 = ChatBubble.Clone.Size
	ChatBubble.Clone.Size = UDim2.new
	ChatBubble.Clone.Frame.AutomaticSize = Enum.AutomaticSize.None
	ChatBubble.Clone.Adornee = claimAdornee
	ChatBubble.Clone.AlwaysOnTop = U3
	ChatBubble.Clone.Parent = (v14 ^ "muted").model
	ChatBubble.Clone.Enabled = true
	ChatBubble.Clone.Frame.TextLabel.Text = ""
	(v14 ^ "muted").showing = Trove.new
	local v14 = ((v14 ^ "muted") * (v14 ^ "muted"))
	local new = Trove.new
	Trove.new:Add(task.spawn(function()
		if v14.showing ~= new then return end
		EnsureUIScale.Scale = 0
		local new = MessageTyper.new

		local Scale = { Scale = 1 }
		local EnsureUIScale = (EnsureUIScale ^ "showing")

		new:Add(task.delay(4, function()
			if v14.showing ~= new then return end
			local Scale = { Scale = 0 }

			new:Add((TweenService.Create.Completed):Connect(function()
				local v_u7 = v14.showing
				if v_u7 ~= nil then
					if not ((new ~= nil) and (v_u7 ~= new)) then
						v14.showing = nil
					end
				end
				if v16 == nil then return end
			end))
		end))

	end))
end
return _index