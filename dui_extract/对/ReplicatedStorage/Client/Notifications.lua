-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Notifications
-- ============================================

-- bytecode
-- Original size: 1367 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 27, Protos: 3, Main proto: 2

-- ============== SOURCE ==============
-- main chunk (proto[2], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Reward = {}
local Reward_2 = require(script.Reward)
Reward.Reward = Reward_2
local RiftSpawn = require(script.RiftSpawn)
Reward.RiftSpawn = RiftSpawn
local Toast = require(script.Toast)
Reward.Toast = Toast
local s1 = Reward
local function channelFor(v1) -- proto[0], line 17  -- upvalues: s1
	if (typeof(s1[v1])) == "table" then
		if (typeof(s1[v1].Show)) == "function" then return s1[v1] end
	end
	local r1 = ("Alerts.Raise addressed an unknown notification channel: %*"):format((tostring(v1)))
	return nil
end
Remotes.Alerts.Raise.OnClientEvent:Connect(function(v2)
	if (typeof(v2)) ~= "table" then
		local r1 = ("Alerts.Raise expects a request table, got %*"):format((typeof(v2)))
		return
	end
	local w1 = v2.Type
	local w2 = s1[v2.Type]
	if (typeof(w2)) == "table" then
		local r2 = ("Alerts.Raise addressed an unknown notification channel: %*"):format((tostring(w1)))
		if w2 == nil then return end
		table.clone.Type = nil
	end
end)
return table.freeze(Reward)