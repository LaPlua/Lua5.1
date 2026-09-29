-- ============================================
-- ClassName: ModuleScript
-- FullName: ReplicatedStorage.Client.HotbarImagePreloadController
-- ============================================

-- bytecode
-- Original size: 9808 bytes
-- Bytecode version: 12, types version: 3
-- Strings: 148, Protos: 24, Main proto: 23

-- ============== SOURCE ==============
-- main chunk (proto[23], line 1)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local AreaEggs = require(ReplicatedStorage.Shared.Types.AreaEggs)
local Areas = require(ReplicatedStorage.Data.Areas)
local AssetIconShape = require(ReplicatedStorage.Client.UI.AssetIconShape)
local Assets = require(ReplicatedStorage.Data.Assets)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local EggState = require(ReplicatedStorage.Client.EggState)
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local GuardChasePolicy = require(ReplicatedStorage.Shared.Modules.GuardAreas.GuardChasePolicy)
local GuardEscape = require(ReplicatedStorage.Shared.Utils.GuardEscape)
local GuardEscapePrediction = require(ReplicatedStorage.Shared.Modules.GuardAreas.GuardEscapePrediction)
local Guards = require(ReplicatedStorage.Data.Guards)
local HotbarImagePreloadPolicy = require(ReplicatedStorage.Client.HotbarImagePreloadPolicy)
local ImagePreloader = require(ReplicatedStorage.Client.ImagePreloader)
local Log = require(ReplicatedStorage.Packages.Log)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Player = require(ReplicatedStorage.Shared.Player)
local SpeedPowerProjection = require(ReplicatedStorage.Client.SpeedPowerProjection)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local s1 = {}
s1[10650210095] = true
s1[10737944401] = true
local r1 = Log.new()
local World = Workspace:WaitForChild("World")
local Areas_2 = World:WaitForChild("Areas")
local GuardAreas = Areas_2:WaitForChild("GuardAreas")
local SeparationLine = Areas_2:WaitForChild("SeparationLine")
assert((GuardAreas:IsA("Folder")), "Workspace.World.Areas.GuardAreas must be a Folder")
assert((SeparationLine:IsA("BasePart")), "Workspace.World.Areas.SeparationLine must be a BasePart")
local function showDebugNotification(v1) -- proto[0], line 73  -- upvalues: s1, Toast
	if not (s1[game.GameId]) then return end
	local Text = { Text = (("[DEBUG]: %*"):format(v1)), Seconds = 1.5, Color = Color3.fromRGB, Unique = true }
end
local function getAreaModel(v2) -- proto[1], line 86  -- upvalues: GuardAreas
	if GuardAreas.FindFirstChild == nil then return nil end
	if not (GuardAreas.FindFirstChild).IsA then return nil end
	return GuardAreas.FindFirstChild
end
local function getGuardRoot(v3) -- proto[2], line 91
	if v3.FindFirstChild == nil then return nil end
	if not ((v3.FindFirstChild).IsA) then return nil end
	if (v3.FindFirstChild).FindFirstChild == nil then return nil end
	if not ((v3.FindFirstChild).FindFirstChild).IsA then return nil end
	return (v3.FindFirstChild).FindFirstChild
end
ReplicatedStorage = r1
local function resolveRequiredSpeedPower(v4) -- proto[4], line 101  -- upvalues: getGuardRoot, Areas, Guards, SeparationLine, GuardEscape, GuardEscapePrediction, GuardChasePolicy, ReplicatedStorage
	if getGuardRoot == nil then return nil end
	local function anon3() -- proto[3], line 107  -- upvalues: Areas, v4, Guards, SeparationLine, GuardEscape, GuardEscapePrediction, getGuardRoot, GuardChasePolicy
		assert((v4.FindFirstChild).IsA, (("%*.Bounds must be a BasePart"):format(v4.GetFullName)))
		assert((v4.FindFirstChild).IsA, (("%*.ClosestExitPoint must be a BasePart"):format(v4.GetFullName)))
		local BaseGuardWalkSpeed = { BaseGuardWalkSpeed = Guards.Directory[Areas.Directory[v4.Name].GuardId].WalkSpeed, ExitDirection = (-SeparationLine.CFrame.LookVector), ExitDistance = GuardEscapePrediction.ResolveExitDistance, FlatRadius = Guards.Directory[Areas.Directory[v4.Name].GuardId].FlatRadius, GuardStartPosition = getGuardRoot.Position, HitDistance = GuardChasePolicy.ResolveHitDistance, PlayerStartPosition = v4.FindFirstChild.Position }
		return GuardEscape.RequiredSpeedPower(BaseGuardWalkSpeed)
	end
	if pcall then return anon3 end
	local r2 = ("Unable to resolve guard escape requirement for %*: %*"):format(v4.Name, anon3)
	return nil
end
local function cacheRequiredSpeedPower(v5, v6) -- proto[5], line 144  -- upvalues: resolveRequiredSpeedPower
	if resolveRequiredSpeedPower == nil then return end
	v5.RequiredSpeedPowerByAreaId[v6.Name] = resolveRequiredSpeedPower
end
local function getRequiredSpeedPower(v7, v8) -- proto[6], line 151  -- upvalues: GuardAreas, resolveRequiredSpeedPower
	local FindFirstChild = nil
	local v_u1 = v7.RequiredSpeedPowerByAreaId
	if v_u1[v8] ~= nil then return v_u1[v8] end
	if GuardAreas.FindFirstChild ~= nil then
		if (GuardAreas.FindFirstChild).IsA then
			v_u1 = GuardAreas.FindFirstChild
		end
	end
	if FindFirstChild == nil then return nil end
	if resolveRequiredSpeedPower == nil then return v7.RequiredSpeedPowerByAreaId[v8] end
	v7.RequiredSpeedPowerByAreaId[FindFirstChild.Name] = resolveRequiredSpeedPower
	return v7.RequiredSpeedPowerByAreaId[v8]
end
local LocalPlayer = Players.LocalPlayer
local function getDistanceToClaimLine() -- proto[7], line 165  -- upvalues: Player, LocalPlayer, HotbarImagePreloadPolicy, SeparationLine
	if Player.FindRootPart == nil then return nil end
	if Player.FindRootPart.IsA then return HotbarImagePreloadPolicy.GetShortestDistanceToClaimLine(SeparationLine, Player.FindRootPart.Position) end
	return nil
end
local function requestEggIcon(v9) -- proto[8], line 173  -- upvalues: Assets, ImagePreloader, showDebugNotification
	if not ImagePreloader.Request then return end
	local r2 = ("Preloading image for %* egg"):format(Assets.Directory[v9].DisplayName)
end
local function requestPetIcons(v10) -- proto[9], line 180  -- upvalues: EggRecords, AssetIconShape, ImagePreloader, Assets, showDebugNotification
	local _r3 = {AssetIconShape.ResolveImages.Icon}
	if AssetIconShape.ResolveImages.RainbowOverlay ~= nil then
		_r3[((#_r3) + 1)] = AssetIconShape.ResolveImages.RainbowOverlay
	end
	if 0 >= ImagePreloader.RequestAll then return end
	local r2 = ("Preloading image for %* pet"):format(Assets.Directory[v10.AssetCategory].DisplayName)
end
local function scanReadyEggs(v11) -- proto[10], line 193  -- upvalues: EggState, LocalPlayer, requestPetIcons
	if v11.Destroyed then return end
	for _k5, _v6 in ipairs(EggState.ReadOwnerEggs) do
		if v11.ReadyPreloadedByUid[_k5] then continue end
		if _v6.Placement == nil then continue end
		if not EggState.IsReadyToHatch then continue end
		v11.ReadyPreloadedByUid[_k5] = true
	end
	for _v5 in ipairs(v11.ReadyPreloadedByUid) do
		if EggState.ReadOwnerEggs[_k5] ~= nil then continue end
		v11.ReadyPreloadedByUid[_k5] = nil
	end
end
local v_u2
local function handleCarryState(v12, v13) -- proto[12], line 219  -- upvalues: GuardAreas, resolveRequiredSpeedPower, SpeedPowerProjection, Player, LocalPlayer, HotbarImagePreloadPolicy, SeparationLine, Assets, ImagePreloader, showDebugNotification, Timer
	local v1_e
	v12.CarryGeneration = (v12.CarryGeneration + 1)
	if not v13.IsCarrying then return end
	if v13.AreaId == nil then return end
	if v13.AssetCategory == nil then return end
	local v_u2 = v12.RequiredSpeedPowerByAreaId
	if v_u2[v13.AreaId] ~= nil then
		local v_u3 = v_u2[v13.AreaId]
	else
		if GuardAreas.FindFirstChild ~= nil then
			if (GuardAreas.FindFirstChild).IsA then
				v_u2 = GuardAreas.FindFirstChild
			end
			v_u2 = nil
		end
		if v_u2 == nil then
			v1_e = nil
		else
			if resolveRequiredSpeedPower ~= nil then
				v12.RequiredSpeedPowerByAreaId[v_u2.Name] = resolveRequiredSpeedPower
			end
			v1_e = v12.RequiredSpeedPowerByAreaId[v13.AreaId]
		end
	end
	local w1 = v12.CarryGeneration
	if Player.FindRootPart ~= nil then
		v_u2 = HotbarImagePreloadPolicy.GetShortestDistanceToClaimLine
		if HotbarImagePreloadPolicy.ShouldPreloadCarriedEgg then
			if not ImagePreloader.Request then return end
			local r2 = ("Preloading image for %* egg"):format(Assets.Directory[v13.AssetCategory].DisplayName)
			return
		end
		local v12 = ((v12 ^ "CarryGeneration") * (v12 ^ "CarryGeneration"))
		local CarryGeneration = w1
		local AssetCategory = v13.AssetCategory
		(((v12 ^ "CarryGeneration") * (v12 ^ "CarryGeneration")).CarryTrove):Add(Timer.Simple(0.1, function()
			if v12.Destroyed then return end
			local arg0_2 = v12.CarryGeneration
			if arg0_2 ~= CarryGeneration then return end
			if Player.FindRootPart ~= nil then
				arg0_2 = HotbarImagePreloadPolicy.GetShortestDistanceToClaimLine
				if arg0_2 == nil then return end
				if not (HotbarImagePreloadPolicy.IsWithinClaimPreloadDistance) then return end
				if ImagePreloader.Request then
					local r2 = ("Preloading image for %* egg"):format(Assets.Directory[AssetCategory].DisplayName)
				end
			end
		end))
	end
end
local function Start(self) -- proto[18], line 259  -- upvalues: GuardAreas, resolveRequiredSpeedPower, EggState, handleCarryState, LocalPlayer, scanReadyEggs, Timer
	local v_u1 = self.Started
	local w2 = (not v_u1)
	assert(w2, "HotbarImagePreloadController already started")
	v_u1 = self.Destroyed
	local w3 = (not v_u1)
	assert(w3, "HotbarImagePreloadController is destroyed")
	self.Started = true
	for _k4, _v5 in ipairs(GuardAreas.GetChildren) do
		if not _v5.IsA then continue end
		if resolveRequiredSpeedPower == nil then continue end
		self.RequiredSpeedPowerByAreaId[_v5.Name] = resolveRequiredSpeedPower
	end
	((self ^ "Started").Trove):Add(EggState.CarryChanged:Connect(function(v16)
	end))
	((self ^ "Started").Trove):Add(EggState.OwnerRefreshed:Connect(function(v17)
		if v17 ~= LocalPlayer.UserId then return end
	end))
	local self = (self ^ "Started")
	((self ^ "Started").Trove):Add(Timer.Simple(0.25, function()
	end))
end
local function Destroy(v18) -- proto[19], line 292
	if v18.Destroyed then return end
	v18.Destroyed = true
	v18.CarryGeneration = (v18.CarryGeneration + 1)
end
local Start = {}
Start.Start = Start
Start.Destroy = Destroy
local r3 = table.freeze(Start)
local _index = {}
_index.__index = r3
r3 = (table.freeze(_index))
local function IsA(v19) -- proto[20], line 311  -- upvalues: r3
	local f1
	if (type(v19)) ~= "table" then return f1 end
	f1 = not ((getmetatable(v19)) ~= r3)
	return f1
end
local function Assert(v20) -- proto[21], line 315  -- upvalues: r3
	local f2
	if (type(v20)) == "table" then
		f2 = not ((getmetatable(v20)) ~= r3)
	end
	assert(f2, "Expected HotbarImagePreloadController")
	return v20
end
local new = {}
local function new() -- proto[22], line 322  -- upvalues: Trove, r3
	local CarryGeneration = { CarryGeneration = 0, CarryTrove = Trove.new.Extend, Destroyed = false, ReadyPreloadedByUid = {}, RequiredSpeedPowerByAreaId = {}, Started = false, Trove = Trove.new }
	local self = setmetatable(CarryGeneration, r3)
	return self
end
new.new = new
new.IsA = IsA
new.Assert = Assert
return table.freeze(new)