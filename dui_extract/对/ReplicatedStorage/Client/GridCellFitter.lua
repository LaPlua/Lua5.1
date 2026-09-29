-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.GridCellFitter
-- ============================================

-- bytecode
-- Original size: 2029 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 39, Protos: 7, Main proto: 6

-- ============== SOURCE ==============
-- main chunk (proto[6], line 1)
local Fit = {}
local function renderScale(v1) -- proto[0], line 13
	local w1 = v1.FindFirstChildWhichIsA
	while true do
		if v1 == nil then break end
		if v1.IsA then break end
		if v1.FindFirstChildWhichIsA == nil then continue end
	end
	if 0 >= (1 * w1.Scale) then return 1 end
	local w2 = (1 * w1.Scale)
	return w2
end
local function wholePixels(v2, v3) -- proto[1], line 26
	return (math.floor(((v2.Scale * v3) + v2.Offset)))
end
function Fit.Fit(self, v4, v5) -- proto[5], line 34  -- upvalues: renderScale
	assert(self.Parent.IsA, (("%* needs a GuiObject parent"):format(self.GetFullName)))
	local Parent = self.Parent
	local new = UDim2.new
	local function refit(v6) -- proto[2], line 41  -- upvalues: v4, self, renderScale, Parent, new
		if v6 ~= nil then
			v4 = v6
		end
		local f1 = false  -- skip 1
		f1 = true
		assert(f1, (("%* cannot fit %* columns"):format(self.GetFullName, v4)))
		local r1 = math.floor(((new.X.Scale * (Parent.AbsoluteSize / renderScale).X) + new.X.Offset))
		local r2 = math.floor(((new.Y.Scale * (Parent.AbsoluteSize / renderScale).Y) + new.Y.Offset))
		local w3 = ((math.floor((((Parent.AbsoluteSize.X / renderScale) - (nil).ScrollBarThickness) / v4))) - r1)
		local r3 = math.max(w3, 0)
		self.CellPadding = UDim2.fromOffset
		self.CellSize = UDim2.fromOffset
	end
	local w1 = self.Parent
	local Connect = (w1.GetPropertyChangedSignal).Connect
	return refit
end
return table.freeze(Fit)