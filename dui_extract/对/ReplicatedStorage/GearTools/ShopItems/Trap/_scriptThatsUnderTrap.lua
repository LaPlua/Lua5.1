-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.GearTools.ShopItems.Trap._scriptThatsUnderTrap
-- ============================================

-- bytecode
-- Original size: 8650 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 142, Protos: 17, Main proto: 16

-- ============== SOURCE ==============
local function createTrapBillboard(v1) -- proto[2], line 64
	Instance.new.Name = "TrapBillboard"
	Instance.new.Size = UDim2.fromScale
	Instance.new.StudsOffset = Vector3.new(0, 3, 0)
	Instance.new.AlwaysOnTop = true
	Instance.new.MaxDistance = 50
	Instance.new.Size = UDim2.fromScale
	Instance.new.BackgroundTransparency = 1
	Instance.new.Parent = Instance.new
	Instance.new.Size = UDim2.fromScale
	Instance.new.Position = UDim2.new
	Instance.new.BackgroundTransparency = 1
	Instance.new.Text = "TRAPPED"
	Instance.new.TextColor3 = Color3.fromRGB
	Instance.new.TextScaled = true
	Instance.new.Font = Enum.Font.SourceSansBold
	Instance.new.Parent = Instance.new
	Instance.new.Thickness = 2.5
	Instance.new.Parent = Instance.new
	Instance.new.Size = UDim2.fromScale
	Instance.new.Position = UDim2.fromScale
	Instance.new.BackgroundTransparency = 1
	Instance.new.Text = (tostring(7)) .. "s"
	Instance.new.TextColor3 = Color3.fromRGB
	Instance.new.TextScaled = true
	Instance.new.Font = Enum.Font.SourceSansBold
	Instance.new.Parent = Instance.new
	if ((v1 ^ "Instance") * (v1 ^ "Instance")) > K[2164591] then
		Instance.new.Thickness = "UIStroke"
		Instance.new.Parent = Instance.new
		if ((((v1 ^ "Instance") * (v1 ^ "Instance"))).FindFirstChild) then
			Instance.new.Parent = (((v1 ^ "Instance") * (v1 ^ "Instance"))).FindFirstChild
		end
	elseif (((v1 ^ "Instance") * (v1 ^ "Instance")).PrimaryPart) then
		Instance.new.Parent = ((v1 ^ "Instance") * (v1 ^ "Instance")).PrimaryPart
	else
		return nil
	end
end
local function getModelHeight(v2) -- proto[3], line 132
	if not (v2.PrimaryPart) then
		return 2
	end
	return (v2.Y / 2)
end
local function getCharacterFromPart(v3) -- proto[4], line 143
	while true do
		if not v3 then return nil end
		if v3 == workspace then return nil end
		if not v3.IsA then break end
		if v3.FindFirstChildOfClass then return v3 end
	end
	return nil
end
-- main chunk (proto[16], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local AntiCheatService = require(ServerScriptService.Controllers.AntiCheatService)
local Audio = require(ReplicatedStorage.Shared.Audio)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GameplayToolGuard = require(ServerScriptService.Library.Tools.Internal.GameplayToolGuard)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ScaleTo = {}
function ScaleTo.ScaleTo(v4, v5) -- proto[0], line 40
	v4.Parent = Instance.new
	Instance.new.PrimaryPart = v4
	v4.Parent = nil
end
local s1 = ScaleTo
function ScaleTo.Install(self, v6) -- proto[15], line 49  -- upvalues: Players, Remotes, GameplayToolGuard, AntiCheatService, Audio, ReplicatedStorage, s1
	local w1 = self.GetAttribute
	local s2 = {}
	local w2 = self.WaitForChild
	local w3 = (self.WaitForChild).IsA
	assert(w3, "Trap Hitbox must be a BasePart")
	self.CanTouch = true
	w2.CanTouch = true
	-- createTrapBillboard captures:
	-- getModelHeight captures:
	-- getCharacterFromPart captures:
	local function positionCloseModel(v7) -- proto[5], line 158  -- upvalues: self
		if v7.IsA then
			v7.CFrame = (self.CFrame * CFrame.Angles)
			v7.Anchored = true
			return
		end
		local w2 = v7.GetDescendants
		for _k4, _v5 in ipairs(w2) do
			if not _v5.IsA then continue end
			_v5.Anchored = true
		end
	end
	local s1 = s2
	local function releaseTrappedCharacter(v8) -- proto[6], line 176  -- upvalues: s1
		if not (s1[v8]) then return end
		s1[v8] = nil
		local v1_e = s1[v8].billboard
		v1_e = s1[v8].rootPart
		if v1_e then
			if v1_e.Parent then
				v1_e.Anchored = s1[v8].originalRootAnchored
			end
		end
		local v1_e = s1[v8].humanoid
		if v1_e then
			v1_e.JumpHeight = s1[v8].originalJumpHeight
			v1_e.AutoRotate = s1[v8].originalAutoRotate
			v1_e.PlatformStand = false
		end
		if not v8 then return end
		if not v8.Parent then return end
	end
	local GetAttribute = w1
	local function notifyTrapOwner(v9) -- proto[7], line 218  -- upvalues: GetAttribute, Players, Remotes
		if (typeof(GetAttribute)) ~= "string" then return end
		if not Players.FindFirstChild then return end
		if not ((Players.FindFirstChild).IsA) then return end
		local Type = { Type = "Toast", Lane = "Feed", Text = (("You <font color=\"#00FF00\">trapped</font> %*!"):format(v9.DisplayName)), Color = Color3.new, Seconds = 2 }
	end
	local function freezeCharacter(v10, v11) -- proto[11], line 237  -- upvalues: s1, Players, GameplayToolGuard, AntiCheatService, notifyTrapOwner, createTrapBillboard, s1, releaseTrappedCharacter
		local w4
		local v_u1 = w4.Y
		if s1[v10] then return false end
		if v10.GetAttribute then return false end
		if not v10.FindFirstChildOfClass then return false end
		if not v10.PrimaryPart then return false end
		if not (v10.PrimaryPart.IsA) then return false end
		local w1 = v10.FindFirstChildOfClass
		local w2 = v10.PrimaryPart
		if (not ((v10 ^ "IsTrapped").PrimaryPart)) then
			w4 = (v10 ^ "IsTrapped")
		end
		local w5 = (v_u1 / 2)
		local w6 = (v11 + (Vector3.new(0, w5, 0)))
		if not Players.GetPlayerFromCharacter then return false end
		if not (GameplayToolGuard.DropHeldEggFromPlayerHit) then return false end
		if not (AntiCheatService.TeleportCharacter) then return false end
		local v_u1 = w2.Anchored
		local v_u2 = w1.JumpHeight
		local v_u3 = w1.AutoRotate
		w2.Anchored = true
		w1.JumpHeight = 0
		w1.AutoRotate = false
		w1.PlatformStand = true
		if (w4 * w4) > K[2296802] then
			notifyTrapOwner.character = (w4 * w4)
			notifyTrapOwner.humanoid = w1
			notifyTrapOwner.rootPart = w2
			notifyTrapOwner.originalRootAnchored = v_u1
			notifyTrapOwner.originalJumpHeight = v_u2
			notifyTrapOwner.originalAutoRotate = v_u3
			s1[(w4 * w4)] = notifyTrapOwner
			notifyTrapOwner.billboard = createTrapBillboard
			local PlaybackSpeed = { PlaybackSpeed = {0.9, 1.1}, Volume = 1.3, MaxDistance = 70 }
			notifyTrapOwner.carrierConnection = ((w4 * w4).GetAttributeChangedSignal).Connect
			local v10 = (w4 * w4)
			notifyTrapOwner.trapStateConnection = ((w4 * w4).GetAttributeChangedSignal).Connect
			local v2_e = (w4 * w4)[1]
			return true
		end
	end
	local f1 = false
	local WaitForChild = w2
	local connection = nil
	local function activateTrap(v12) -- proto[13], line 321  -- upvalues: f1, self, freezeCharacter, WaitForChild, connection, ReplicatedStorage, v6, s1, positionCloseModel
		if f1 then return end
		if not (self.Parent) then return end
		if not (freezeCharacter) then return end
		f1 = true
		if connection then
			connection = nil
		end
		ReplicatedStorage.Assets.Extra.ClosedTrap.Clone.Parent = self
		self.Transparency = 1
		self.CanCollide = false
		self.CanTouch = false
	end
	local function onTouched(v13) -- proto[14], line 361  -- upvalues: f1, self, getCharacterFromPart, Players, GetAttribute, GameplayToolGuard, activateTrap
		if f1 then return end
		if not (self.Parent) then return end
		if not v13 then return end
		if v13.IsDescendantOf then return end
		if not (getCharacterFromPart) then return end
		if Players.GetPlayerFromCharacter then
			if Players.GetPlayerFromCharacter.Name == GetAttribute then return end
			if not Players.GetPlayerFromCharacter then return end
			if not (GameplayToolGuard.IsPlayerInGameplayArea) then return end
			if not (GameplayToolGuard.IsHoldingEgg) then return end
			if not getCharacterFromPart.FindFirstChildOfClass then return end
			local w7 = getCharacterFromPart.FindFirstChildOfClass
			if w7.Health <= 0 then return end
		end
	end
end
return ScaleTo