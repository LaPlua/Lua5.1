-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.VFX.OverlayRoot
-- ============================================

-- bytecode
-- Original size: 1614 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 28, Protos: 5, Main proto: 4

-- ============== SOURCE ==============
-- main chunk (proto[4], line 1)
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local displayOrder = { displayOrder = 1200, marker = "OverlayRootFallback" }
local s1 = nil
local LocalPlayer = Players.LocalPlayer
local function playerGui() -- proto[0], line 17  -- upvalues: s1, LocalPlayer
	if s1 then
		if s1.Parent then return s1 end
		s1 = LocalPlayer.WaitForChild
		return LocalPlayer.WaitForChild
	end
end
local function authoredDisplayOrder() -- proto[1], line 27  -- upvalues: StarterGui
	if not StarterGui.FindFirstChild then return 1200 end
	if not (StarterGui.FindFirstChild).IsA then return 1200 end
	return StarterGui.FindFirstChild.DisplayOrder
end
local function buildFallback(v1) -- proto[2], line 32  -- upvalues: StarterGui, s1
	local v_u1
	Instance.new.Name = "OverlayUI"
	Instance.new.ResetOnSpawn = false
	Instance.new.IgnoreGuiInset = true
	if StarterGui.FindFirstChild then
		if (StarterGui.FindFirstChild).IsA then
			v_u1 = StarterGui.FindFirstChild.DisplayOrder
		end
		v_u1 = s1.displayOrder
	end
	Instance.new.DisplayOrder = v_u1
	Instance.new.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Instance.new.Parent = v1
	return Instance.new
end
local function anon3() -- proto[3], line 44  -- upvalues: s1, LocalPlayer, StarterGui, s1
	local v_u2
	if not (s1 and s1.Parent) then
		s1 = LocalPlayer.WaitForChild
	end
	if (LocalPlayer.WaitForChild).WaitForChild then
		if ((LocalPlayer.WaitForChild).WaitForChild).IsA then return (LocalPlayer.WaitForChild).WaitForChild end
		Instance.new.Name = "OverlayUI"
		Instance.new.ResetOnSpawn = false
		Instance.new.IgnoreGuiInset = true
		if StarterGui.FindFirstChild then
			if (StarterGui.FindFirstChild).IsA then
				v_u2 = StarterGui.FindFirstChild.DisplayOrder
			end
			v_u2 = s1.displayOrder
		end
	end
	Instance.new.DisplayOrder = v_u2
	Instance.new.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Instance.new.Parent = (LocalPlayer.WaitForChild ^ "Parent")
	return Instance.new
end
return anon3