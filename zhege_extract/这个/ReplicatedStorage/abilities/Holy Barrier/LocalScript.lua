-- ============================================
-- ClassName: LocalScript
-- FullName: ReplicatedStorage.abilities.Holy Barrier.LocalScript
-- ============================================

-- bytecode
-- Original size: 699 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 19, Protos: 2, Main proto: 1

-- ============== SOURCE ==============
-- main chunk (proto[1], line 1)
local localEvent = script.Parent:WaitForChild("localEvent")
local Parent = script.Parent
local f1 = true
localEvent.Event:Connect(function()
	if Parent.cooldown.Value <= 0 and f1 then
		f1 = false
		f1 = true
	end
end)