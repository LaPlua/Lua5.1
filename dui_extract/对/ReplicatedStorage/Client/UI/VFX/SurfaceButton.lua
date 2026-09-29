-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.VFX.SurfaceButton
-- ============================================

-- bytecode
-- Original size: 1117 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 31, Protos: 3, Main proto: 2

-- ============== SOURCE ==============
-- main chunk (proto[2], line 1)
local ButtonFX = require(script.Parent.ButtonFX)
local peakScale = { peakScale = 1.045, pressedScale = 0.965, cueGain = 1.75, hitAreaName = "PressSurface", hitAreaLift = 64 }
local function hitAreaOf(v1) -- proto[0], line 15
	if v1.IsA then return v1, false end
	if v1.FindFirstChild then
		if (v1.FindFirstChild).IsA then return v1.FindFirstChild, false end
		Instance.new.Name = "PressSurface"
		Instance.new.Text = ""
		Instance.new.AutoButtonColor = false
		Instance.new.BackgroundTransparency = 1
		Instance.new.ZIndex = (v1.ZIndex + 64)
		Instance.new.Size = UDim2.fromScale
		Instance.new.Parent = (v1 ^ "GuiButton")
		return Instance.new, true
	end
end
local function anon1(v2, v3, v4) -- proto[1], line 36  -- upvalues: hitAreaOf, ButtonFX
	v2.Active = true
	local host = { host = v2, input = hitAreaOf, ownsInput = v2, peakScale = (v3 or 1.045), pressedScale = 0.965, cueGain = 1.75, onActivate = v4 }
	return ButtonFX(host)
end
return anon1