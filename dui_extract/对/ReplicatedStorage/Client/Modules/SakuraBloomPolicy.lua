-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.Modules.SakuraBloomPolicy
-- ============================================

-- bytecode
-- Original size: 635 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 15, Protos: 3, Main proto: 2

-- ============== SOURCE ==============
-- main chunk (proto[2], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local HasBloomUnlocked = {}
function HasBloomUnlocked.HasBloomUnlocked(v1, v2) -- proto[0], line 14  -- upvalues: GameFlags
	local f1
	if not (GameFlags.GreatBloomEnabled.Get) then return false end
	if not v1 then return false end
	if v2 == nil then return false end
	f1 = not (v2.Sakura.Unlocked ~= true)
	return f1
end
local s1 = HasBloomUnlocked
function HasBloomUnlocked.CanShowBloom(v3, v4, v5) -- proto[1], line 21  -- upvalues: s1
	local v_u1 = v3
	if not v_u1 then return v_u1 end
	v_u1 = s1.HasBloomUnlocked
	return v_u1
end
return table.freeze(HasBloomUnlocked)