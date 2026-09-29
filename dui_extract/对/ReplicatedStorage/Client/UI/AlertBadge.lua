-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.AlertBadge
-- ============================================

-- bytecode
-- Original size: 4427 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 85, Protos: 10, Main proto: 9

-- ============== SOURCE ==============
-- main chunk (proto[9], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local EnsureUIScale = require(ReplicatedStorage.Shared.Utils.EnsureUIScale)
local Signal = require(ReplicatedStorage.Packages.Signal)
local r1 = UDim2.fromScale(0.994, 0.089)
local r2 = UDim2.fromScale(0.147, 0.501)
local r3 = Color3.fromRGB(255, 0, 0)
local r4 = Color3.fromRGB(56, 0, 14)
local r5 = Color3.fromRGB(255, 255, 255)
local r6 = Font.new("rbxassetid://12187365977", Enum.FontWeight.Bold)
local r7 = UDim2.fromScale(0.8, 0.8)
local r8 = TweenInfo.new(0.7, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, -1, true)
local _index = {}
_index.__index = _index
local function build(v1, v2) -- proto[0], line 60  -- upvalues: r3, r1, r2, r4, r6, r7, r5
	if v1.FindFirstChild ~= nil then
		if (v1.FindFirstChild).IsA then return v1.FindFirstChild end
		Instance.new.Name = "AlertBadge"
		Instance.new.AnchorPoint = Vector2.new
		Instance.new.BackgroundColor3 = r3
		Instance.new.BorderSizePixel = 0
		Instance.new.Position = (v2.Position or r1)
		Instance.new.Size = (v2.Size or r2)
		Instance.new.Visible = false
		Instance.new.ZIndex = (v2.ZIndex or 6)
		Instance.new.Parent = Instance.new
		Instance.new.CornerRadius = UDim.new
		Instance.new.Parent = Instance.new
		Instance.new.Color = r4
		Instance.new.Thickness = 1.3
		Instance.new.Parent = Instance.new
		Instance.new.AnchorPoint = Vector2.new
		Instance.new.BackgroundTransparency = 1
		Instance.new.FontFace = r6
		Instance.new.Name = "TextLabel"
		Instance.new.Position = UDim2.fromScale
		Instance.new.Size = r7
		Instance.new.Text = (v2.Text or "!")
		Instance.new.TextColor3 = r5
		Instance.new.TextScaled = true
		Instance.new.ZIndex = (Instance.new.ZIndex + 1)
		Instance.new.Thickness = 1.1
		Instance.new.Parent = Instance.new
		Instance.new.Parent = Instance.new
		Instance.new.Parent = ((v1 ^ "AlertBadge") * (v1 ^ "AlertBadge"))
		return Instance.new
	end
end
local module = _index
local function new(v3, v4) -- proto[2], line 113  -- upvalues: Signal, module, build
	local f1 = not ((v4 or {}).Pulse == false)
	local Dismissed = { Dismissed = Signal.new, _badges = {}, _connections = {}, _tweens = {}, _pulse = f1, _shown = false }
	local self = setmetatable(Dismissed, module)
	for _k7, _v8 in ipairs(v3) do
		if not _v8.IsA then continue end
		table.insert(self._badges, build)
		if (v4 or {}).DismissOnActivated == false then continue end
		if not _v8.IsA then continue end
		local object = self
		table.insert(self._connections, _v8.Activated:Connect(function()
		end))
	end
	return self
end
_index.new = new
function _index.Attach(v5, v6) -- proto[3], line 142  -- upvalues: module
	if v5 ~= nil then
		return module.new(({v5}), v6)
	end
	return module.new(({}), v6)
end
function _index.IsShown(v7) -- proto[4], line 146
	return v7._shown
end
function _index.SetText(v8, v9) -- proto[5], line 150
	for _k5, _v6 in ipairs(v8._badges) do
		for _k10, _v11 in ipairs(_v6.GetDescendants) do
			if not _v11.IsA then continue end
			_v11.Text = v9
		end
	end
end
r6 = r8
function _index.Show(v10) -- proto[6], line 160  -- upvalues: EnsureUIScale, TweenService, r6
	if v10._shown then return end
	v10._shown = true
	for _k4, _v5 in ipairs(v10._badges) do
		_v5.Visible = true
		if (not (v10._pulse)) then
			EnsureUIScale.Scale = 1
		else
			EnsureUIScale.Scale = 0.8
			local Scale = { Scale = 1.2 }
			table.insert(v10._tweens, TweenService.Create)
		end
	end
end
function _index.Dismiss(v11) -- proto[7], line 181  -- upvalues: EnsureUIScale
	if not (v11._shown) then return end
	v11._shown = false
	for _k4, _v5 in ipairs(v11._tweens) do
	end
	for _k4, _v5 in ipairs(v11._badges) do
		EnsureUIScale.Scale = 1
		_v5.Visible = false
	end
end
function _index.Destroy(v12) -- proto[8], line 201
	local w1 = v12._connections
	for _k4, _v5 in ipairs(w1) do
	end
	for _k4, _v5 in ipairs(v12._badges) do
	end
end
return _index