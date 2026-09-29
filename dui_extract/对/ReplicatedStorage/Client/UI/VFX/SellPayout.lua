-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.VFX.SellPayout
-- ============================================

-- bytecode
-- Original size: 8200 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 119, Protos: 16, Main proto: 15

-- ============== SOURCE ==============
-- main chunk (proto[15], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Hud = require(ReplicatedStorage.Client.Hud)
local Numbers = require(ReplicatedStorage.Shared.Utils.Numbers)
local OverlayRoot = require(script.Parent.OverlayRoot)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local r1 = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local r2 = TweenInfo.new(0.26, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local r3 = TweenInfo.new(0.3, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local r4 = TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0.04)
local r5 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local r6 = TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local r7 = Color3.fromRGB(126, 255, 92)
local r8 = TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local _r17 = {}
local r9 = Random.new()
local function money(v1) -- proto[0], line 76  -- upvalues: Simple, Numbers
	if 99999 < v1 then
		local r10 = math.round(v1)
		return "$" .. Simple.FormatCompact
	end
	local r11 = math.round(v1)
	return "$" .. Numbers.AddCommas
end
local function namedScale(v2, v3) -- proto[1], line 83
	if v2.FindFirstChild then
		if (v2.FindFirstChild).IsA then return v2.FindFirstChild end
		Instance.new.Name = v3
		Instance.new.Parent = v2
		return Instance.new
	end
end
local function quadBezier(v4, v5, v6, v7) -- proto[2], line 95
	return (((v4 * ((1 - v7) * (1 - v7))) + (v5 * (((1 - v7) * 2) * v7))) + (v6 * (v7 * v7)))
end
local function playTween(v8, v9, v10) -- proto[3], line 100  -- upvalues: TweenService
	return TweenService.Create
end
local function readout() -- proto[4], line 106  -- upvalues: Hud
	if Hud.Find == nil then return nil end
	local Plate = { Plate = Hud.Find, Icon = Hud.Find, Value = Hud.Find }
	return Plate
end
local function iconCenter(v11) -- proto[5], line 116
	return (v11.AbsolutePosition + (v11.AbsoluteSize / 2))
end
r1 = r2
r2 = r3
r3 = r4
r4 = r5
r5 = r6
local function punch(v12, v13) -- proto[6], line 120  -- upvalues: r1, TweenService, r2, r3, r7, r4, r5
	local v_u1 = w2.Rotation
	local v_u2 = w3.TextColor3
	if v12.Icon.FindFirstChild then
		Instance.new.Name = "PayoutPunch"
		Instance.new.Parent = v12.Icon
	end
	Instance.new.Scale = 1.32
	local Scale = { Scale = 1 }
	local w1 = v12.Plate
	local w2 = v12.Icon
	local w3 = v12.Value
	w2.Rotation = (v_u1 + (-1 * 14))
	local Rotation = {}
	Rotation.Rotation = v_u1
	if w3.FindFirstChild then
		Instance.new.Name = "PayoutPunch"
		Instance.new.Parent = w3
	end
	Instance.new.Scale = 1.16
	local Scale_2 = { Scale = 1 }
	w3.TextColor3 = r7
	local TextColor3 = {}
	TextColor3.TextColor3 = v_u2
	if w1.FindFirstChild then
		Instance.new.Name = "PayoutShake"
		Instance.new.Parent = w1
	end
	Instance.new.Scale = 1.05
	local Scale_3 = { Scale = 1 }
end
local function floatTotal(v14, v15) -- proto[8], line 153  -- upvalues: Simple, Numbers, r7, OverlayRoot, r1, TweenService
	local v_u1
	Instance.new.Name = "PayoutFloater"
	Instance.new.BackgroundTransparency = 1
	if (99999 < v15) then
		local r10 = math.round(v15)
		v_u1 = "$" .. Simple.FormatCompact
	else
		local r11 = math.round(v15)
		v_u1 = "$" .. Numbers.AddCommas
	end
	Instance.new.Text = "+" .. v_u1
	Instance.new.TextColor3 = r7
	Instance.new.FontFace = v14.Value.FontFace
	Instance.new.TextScaled = true
	Instance.new.TextXAlignment = Enum.TextXAlignment.Left
	Instance.new.Size = UDim2.fromOffset
	Instance.new.Position = UDim2.fromOffset
	Instance.new.Parent = OverlayRoot
	Instance.new.Thickness = 2
	Instance.new.Color = Color3.new
	Instance.new.Parent = Instance.new
	local Position = { Position = UDim2.fromOffset, TextTransparency = 1 }
	local Transparency = { Transparency = 1 }
	if ((v14 ^ "Plate") * (v14 ^ "Plate")) <= K[65666] then return end
end
local function flyCoin(v16, v17, v18, v19, v20, v21) -- proto[12], line 185  -- upvalues: OverlayRoot, r1, r2, TweenService, Quart, In
	Instance.new.Name = "Coin"
	Instance.new.BackgroundTransparency = 1
	Instance.new.Image = "rbxassetid://119640363267627"
	Instance.new.AnchorPoint = Vector2.new
	Instance.new.Size = UDim2.fromOffset
	Instance.new.Position = UDim2.fromOffset
	Instance.new.ImageTransparency = 1
	local w1 = v16.Icon
	Instance.new.Parent = OverlayRoot
	local w6 = (v17 + (Vector2.new(r1.NextNumber, r1:NextNumber(-46, 27.599999999999998))))
	local OverlayRoot = w6
	local AbsolutePosition = (((w6 + (w1.AbsolutePosition + (w1.AbsoluteSize / 2))) / 2) + Vector2.new)
	local r12 = (((w1.AbsolutePosition + (w1.AbsoluteSize / 2))).NextNumber * 1)
	if ((v16 ^ "Icon") * (v16 ^ "Icon")) <= K[65666] then return end
end
function _r17.Award(self, v23) -- proto[14], line 260  -- upvalues: readout, punch, Audio, floatTotal, flyCoin
	local v_u3, v_u4
	if self <= 0 then return end
	if readout == nil then return end
	local r13 = math.clamp((#(v23 or {})), 5, 14)
	local r14 = math.clamp((readout.Icon.AbsoluteSize.Y * 0.9), 26, 72)
	local index = 0
	local function onArrive(v24) -- proto[13], line 277  -- upvalues: index, punch, readout, Audio, r13, floatTotal, self
		index = (index + 1)
		local PlaybackSpeed = { PlaybackSpeed = (((v24 / r13) * 0.5) + 0.95), Volume = 0.165 }
		if index ~= r13 then return end
		local Volume = { Volume = 0.49500000000000005 }
	end
	for _i = 1, r13 do
		if (0 < (#(v23 or {}))) then
			v_u3 = ((_i - 1) % (#(v23 or {}))) + 1
		else
			v_u4 = readout.Icon.AbsoluteSize / 2
		end
	end
end
return table.freeze(_r17)