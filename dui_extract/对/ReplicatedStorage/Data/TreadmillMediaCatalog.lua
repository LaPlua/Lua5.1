-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Data.TreadmillMediaCatalog
-- ============================================

-- bytecode
-- Original size: 554 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 14, Protos: 2, Main proto: 1

-- ============== SOURCE ==============
-- main chunk (proto[1], line 1)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local function ResolveEntryReleaseVersion(v1) -- proto[0], line 22  -- upvalues: t
	local r1 = t.strict(t.intersection(t.integer, t.numberPositive))
	return v1
end
local BASELINE_RELEASE_VERSION = { BASELINE_RELEASE_VERSION = 1, BASELINE_MEDIA_COUNT = 246, CURRENT_RELEASE_VERSION = 3, ResolveEntryReleaseVersion = ResolveEntryReleaseVersion }
return BASELINE_RELEASE_VERSION