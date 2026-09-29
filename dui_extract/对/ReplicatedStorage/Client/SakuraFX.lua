-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.SakuraFX
-- ============================================

-- bytecode
-- Original size: 2352 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 53, Protos: 6, Main proto: 5

-- ============== SOURCE ==============
-- main chunk (proto[5], line 1)
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Sakura = require(ReplicatedStorage.Data.Sakura)
local Audio = require(ReplicatedStorage.Shared.Audio)
local EmitBurst = {}
local Sakura_2 = ReplicatedStorage.Assets.VFX:WaitForChild("Sakura")
local function spawnAnchor(v1, v2) -- proto[0], line 39  -- upvalues: Workspace, Debris
	Instance.new.Name = "SakuraFXHost"
	Instance.new.Anchored = true
	Instance.new.CanCollide = false
	Instance.new.CanQuery = false
	Instance.new.CanTouch = false
	Instance.new.Transparency = 1
	Instance.new.Size = (Vector3.new(1, 1, 1) * v2)
	Instance.new.Position = v1
	Instance.new.Parent = Workspace
	return Instance.new
end
local function cue(v3, v4, v5, v6, v7, v8) -- proto[1], line 54  -- upvalues: Sakura, Audio
	local f1 = not (Sakura.Sounds[v3] == nil)
	assert(f1, (("no sound id catalogued under Sakura.Sounds.%*"):format(v3)))
	local PlaybackSpeed = { PlaybackSpeed = (v6 or 1), Volume = (v5 or 1), MaxDistance = (v7 or 120), Looped = v8 }
	return Audio.Play(Sakura.Sounds[v3], v4, PlaybackSpeed)
end
Sakura = Sakura_2
function EmitBurst.EmitBurst(v9, v10, v11, v12) -- proto[2], line 72  -- upvalues: Sakura, Workspace, Debris
	local f2
	local v_u1 = v9
	f2 = not (Sakura.FindFirstChild == nil)
	assert(f2, (("no burst prefab named %* under Assets.VFX.Sakura"):format(v9)))
	Instance.new.Name = "SakuraFXHost"
	Instance.new.Anchored = true
	Instance.new.CanCollide = false
	Instance.new.CanQuery = false
	Instance.new.CanTouch = false
	Instance.new.Transparency = 1
	Instance.new.Size = (Vector3.new(1, 1, 1) * (v12 or 4))
	Instance.new.Position = v10
	Instance.new.Parent = Workspace
	for _k9, _v10 in ipairs((Sakura.FindFirstChild).GetChildren) do
		if not _v10.IsA then continue end
		_v10.Clone.Enabled = false
		_v10.Clone.Parent = Instance.new
		local r1 = math.max(1, (math.floor(((v11 * (math.max(_v10.Rate, 1))) / 20))))
	end
	return Instance.new
end
function EmitBurst.PlayCue(v13, v14, v15, v16, v17) -- proto[3], line 98  -- upvalues: cue
	return cue(v13, v14, v15, v16, v17)
end
function EmitBurst.PlayLooped(v18, v19, v20, v21) -- proto[4], line 108  -- upvalues: cue
	return cue(v18, v19, v20, v21, nil, true)
end
return EmitBurst