-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.UI.TreadmillStaticRateSign
-- ============================================

-- bytecode
-- Original size: 1271 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 30, Protos: 2, Main proto: 1

-- ============== SOURCE ==============
-- main chunk (proto[1], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Numbers = require(ReplicatedStorage.Shared.Utils.Numbers)
local t = require(ReplicatedStorage.Packages.t)
local Apply = {}
Numbers = Numbers.AddCommas
function Apply.Apply(v1, v2, v3) -- proto[0], line 30  -- upvalues: t, Numbers
	assert(((v1 ^ "strict").SpeedPerSecond).IsA, (("Treadmill \"%*\" SpeedPerSecond must be a BasePart"):format((v1 ^ "strict").Name)))
	assert(((v1 ^ "strict").SpeedPerSecond.BillboardGui).IsA, (("Treadmill \"%*\" SpeedPerSecond.BillboardGui must be a BillboardGui"):format((v1 ^ "strict").Name)))
	assert(((v1 ^ "strict").SpeedPerSecond.BillboardGui.Frame.TextLabel).IsA, (("Treadmill \"%*\" SpeedPerSecond.BillboardGui.Frame.TextLabel must be a TextLabel"):format((v1 ^ "strict").Name)))
	(v1 ^ "strict").SpeedPerSecond.BillboardGui.Frame.TextLabel.TextColor3 = v2
	(v1 ^ "strict").SpeedPerSecond.BillboardGui.Frame.TextLabel.Text = (("+%*/step"):format(Numbers))
	return (v1 ^ "strict").SpeedPerSecond.BillboardGui
end
return Apply