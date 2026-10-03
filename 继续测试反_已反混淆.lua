-- 反混淆结果：源脚本「继续测试反」（Luraph v15.0 保护，外层另有 OUTLIERS 加载器）。
-- 通过运行时追踪 + VM 反虚拟化重建；局部变量名为工具推断，非原始命名。
return function(arg, arg2, arg3)
	_bsdata0 = nil
	local n = 90
	local v = pcall
	local v2 = type
	local v3 = tostring
	local v4 = tonumber
	local v5 = error
	local v6 = warn
	local v7 = string
	local format = v7.format
	local gsub = v7.gsub
	local lower = v7.lower
	local sub = v7.sub
	local match = v7.match
	local v8 = table
	local concat = v8.concat
	local v9 = math
	local floor = v9.floor
	local v10 = task
	local spawn = v10.spawn
	local wait = v10.wait
	local v11 = os
	local clock = v11.clock
	local v12 = game
	local getService = game.GetService
	local v13 = gethwid
	local v14 = request
	local v15 = loadstring
	local v16 = getgenv
	local v17 = hookfunction
	local v18 = isfunctionhooked

	if pcall ~= v or type ~= v2 or tostring ~= v3 or tonumber ~= v4 or error ~= v5 or warn ~= v6 or string ~= v7 or v7.format ~= format or v7.gsub ~= gsub or v7.lower ~= lower or v7.sub ~= sub or v7.match ~= match or table ~= v8 or v8.concat ~= concat or math ~= v9 or v9.floor ~= floor or task ~= v10 or v10.spawn ~= spawn or v10.wait ~= wait or os ~= v11 or v11.clock ~= clock or game ~= v12 or game.GetService ~= getService or request ~= v14 or loadstring ~= v15 or getgenv ~= v16 or hookfunction ~= v17 or isfunctionhooked ~= v18 then
		v5("[Moon] 登录脚本函数完整性校验失败", 0)
	end

	local function fn()
		if v2(v17) ~= "function" or v2(v18) ~= "function" then
			return false
		end

		for i = 1, 3 do
			local function fn2()
				return true
			end

			if not v(v17, fn2, function()
				return true
			end) then
				return false
			end
			local v19, v20 = v(v18, fn2)
			if not v19 or v20 ~= true then
				return false
			end
		end

		return true
	end

	local v19 = fn()

	local function fn2(arg4, arg5)
		if v2(arg4) ~= "function" or not v19 then
			v5("[Moon] " .. arg5 .. " 完整性校验失败", 0)
		end

		local v20, v21 = v(v18, arg4)

		if not v20 or v21 == true then
			v5("[Moon] " .. arg5 .. " 完整性校验失败", 0)
		end
	end

	fn2(v, "pcall")
	fn2(v2, "type")
	fn2(v3, "tostring")
	fn2(v4, "tonumber")
	fn2(v5, "error")
	fn2(v6, "warn")
	fn2(format, "string.format")
	fn2(gsub, "string.gsub")
	fn2(lower, "string.lower")
	fn2(sub, "string.sub")
	fn2(match, "string.match")
	fn2(concat, "table.concat")
	fn2(floor, "math.floor")
	fn2(spawn, "task.spawn")
	fn2(wait, "task.wait")
	fn2(clock, "os.clock")
	fn2(getService, "GetService")
	fn2(v14, "request")
	fn2(v15, "loadstring")
	fn2(v16, "getgenv")
	fn2(v17, "hookfunction")
	fn2(v18, "isfunctionhooked")

	if game ~= v12 or v12.GetService ~= getService then
		v5("[Moon] GetService 函数或 game 对象已被替换", 0)
	end

	fn2(getService, "GetService")
	local httpService = getService(v12, "HttpService")
	local jsonEncode = httpService.JSONEncode
	local jsonDecode = httpService.JSONDecode
	fn2(jsonEncode, "JSONEncode")
	fn2(jsonDecode, "JSONDecode")
	local localPlayer = getService(v12, "Players").LocalPlayer
	local kick = localPlayer and localPlayer.Kick
	fn2(kick, "Kick")

	local function fn3(arg4)
		v(spawn, function()
			if v2(kick) == "function" then
				v(kick, localPlayer, "[Moon] " .. arg4)
			end
		end)

		v5("[Moon] " .. arg4, 0)
	end

	if gethwid ~= v13 then
		fn3("gethwid 函数已被替换")
	end

	if v2(v13) == "function" then
		fn2(v13, "gethwid")
	end

	local v20 = nil
	local v21 = nil
	local v22 = v3(localPlayer.UserId)
	local v23 = nil

	if v2(v16) == "function" then
		if getgenv ~= v16 then
			fn3("getgenv 函数已被替换")
		end

		fn2(v16, "getgenv")
		local v24, v25 = v(v16)

		if v24 and v2(v25) == "table" then
			v23 = v25
		end
	end

	local function fn4(arg4, arg5, arg6)
		if v2(arg4) ~= "function" then
			arg6(arg5 .. "_replaced")
			return
		end
		local v24, v25 = v(v18, arg4)

		if not v24 then
			arg6("hook_probe_failed")
		elseif v25 == true then
			arg6(arg5 .. "_hooked")
		end
	end

	local function fn5()
		local tbl = {}

		local function fn6(arg4)
			tbl[#tbl + 1] = arg4
		end

		if not v19 then
			fn6("hook_probe_failed")
		end

		if v2(v17) ~= "function" or v2(v18) ~= "function" then
			fn6("hook_api_missing")
			return tbl
		end

		if pcall ~= v then
			fn6("pcall_replaced")
		end

		if type ~= v2 then
			fn6("type_replaced")
		end

		if tostring ~= v3 then
			fn6("tostring_replaced")
		end

		if tonumber ~= v4 then
			fn6("tonumber_replaced")
		end

		if error ~= v5 then
			fn6("error_replaced")
		end

		if warn ~= v6 then
			fn6("warn_replaced")
		end

		if string ~= v7 then
			fn6("string_library_replaced")
		end

		if v7.format ~= format then
			fn6("string_format_replaced")
		end

		if v7.gsub ~= gsub then
			fn6("string_gsub_replaced")
		end

		if v7.lower ~= lower then
			fn6("string_lower_replaced")
		end

		if v7.sub ~= sub then
			fn6("string_sub_replaced")
		end

		if v7.match ~= match then
			fn6("string_match_replaced")
		end

		if table ~= v8 then
			fn6("table_library_replaced")
		end

		if v8.concat ~= concat then
			fn6("table_concat_replaced")
		end

		if math ~= v9 then
			fn6("math_library_replaced")
		end

		if v9.floor ~= floor then
			fn6("math_floor_replaced")
		end

		if task ~= v10 then
			fn6("task_library_replaced")
		end

		if v10.spawn ~= spawn then
			fn6("task_spawn_replaced")
		end

		if v10.wait ~= wait then
			fn6("task_wait_replaced")
		end

		if os ~= v11 then
			fn6("os_library_replaced")
		end

		if v11.clock ~= clock then
			fn6("os_clock_replaced")
		end

		if game ~= v12 then
			fn6("game_replaced")
		end

		if game.GetService ~= getService then
			fn6("getservice_replaced")
		end

		if httpService.JSONEncode ~= jsonEncode then
			fn6("jsonencode_replaced")
		end

		if httpService.JSONDecode ~= jsonDecode then
			fn6("jsondecode_replaced")
		end

		if not localPlayer or localPlayer.Kick ~= kick then
			fn6("kick_replaced")
		end

		if gethwid ~= v13 then
			fn6("gethwid_replaced")
		end

		if v2(v13) == "function" then
			fn4(v13, "gethwid", fn6)
		end

		if v20 then
			if v20.GetClientId ~= v21 then
				fn6("getclientid_replaced")
			end

			fn4(v21, "getclientid", fn6)
		end

		if request ~= v14 then
			fn6("request_replaced")
		end

		if loadstring ~= v15 then
			fn6("loadstring_replaced")
		end

		if getgenv ~= v16 then
			fn6("getgenv_replaced")
		end

		if hookfunction ~= v17 then
			fn6("hookfunction_replaced")
		end

		if isfunctionhooked ~= v18 then
			fn6("isfunctionhooked_replaced")
		end

		fn4(v, "pcall", fn6)
		fn4(v2, "type", fn6)
		fn4(v3, "tostring", fn6)
		fn4(v4, "tonumber", fn6)
		fn4(v5, "error", fn6)
		fn4(v6, "warn", fn6)
		fn4(format, "string_format", fn6)
		fn4(gsub, "string_gsub", fn6)
		fn4(lower, "string_lower", fn6)
		fn4(sub, "string_sub", fn6)
		fn4(match, "string_match", fn6)
		fn4(concat, "table_concat", fn6)
		fn4(floor, "math_floor", fn6)
		fn4(spawn, "task_spawn", fn6)
		fn4(wait, "task_wait", fn6)
		fn4(clock, "os_clock", fn6)
		fn4(getService, "getservice", fn6)
		fn4(v14, "request", fn6)
		fn4(v15, "loadstring", fn6)
		fn4(v16, "getgenv", fn6)
		fn4(v17, "hookfunction", fn6)
		fn4(v18, "isfunctionhooked", fn6)
		fn4(jsonEncode, "jsonencode", fn6)
		fn4(jsonDecode, "jsondecode", fn6)
		fn4(kick, "kick", fn6)
		return tbl
	end

	if #fn5() > 0 then
		v5("[Moon] 登录脚本函数完整性校验失败", 0)
	end

	local function fn6(arg4)
		return v2(arg4) == "string" and #arg4 > 0 and #arg4 <= 256 and not match(arg4, "%s")
	end

	local function fn7()
		if gethwid ~= v13 then
			fn3("gethwid 函数已被替换")
		end

		local str = "gethwid() 函数不存在"

		if v2(v13) == "function" then
			if gethwid ~= v13 then
				fn3("gethwid 函数已被替换")
			end

			fn2(v13, "gethwid")
			local v24
			str, v24 = v(v13)
			if str and fn6(v24) then
				return lower(v24)
			end
			str = str and "gethwid() 返回值无效" or "gethwid() 调用报错"
		end

		if not v20 then
			if game ~= v12 or v12.GetService ~= getService then
				fn3("GetService 函数或 game 对象已被替换")
			end

			fn2(getService, "GetService")
			local rbxAnalyticsService, v24 = v(getService, v12, "RbxAnalyticsService")

			if not rbxAnalyticsService or not v24 then
				fn3("无法获取 HWID：" .. str .. "；回退失败：无法获取 RbxAnalyticsService")
			end

			v20 = v24

			local v25, v26 = v(function()
				return v20.GetClientId
			end)

			if not v25 or v2(v26) ~= "function" then
				fn3("无法获取 HWID：" .. str .. "；回退失败：GetClientId 方法不可用")
			end

			v21 = v26
		end

		if v20.GetClientId ~= v21 then
			fn3("GetClientId 函数已被替换")
		end

		fn2(v21, "GetClientId")
		local v24, v25 = v(v21, v20)

		if not v24 then
			fn3("无法获取 HWID：" .. str .. "；回退失败：GetClientId() 调用报错")
		end

		if not fn6(v25) then
			fn3("无法获取 HWID：" .. str .. "；回退失败：GetClientId() 返回值无效")
		end

		return lower(v25)
	end

	local v24 = fn7()
	local v25 = v3(game.GameId)
	local v26 = v3(game.PlaceId)

	if not match(v25, "^[1-9]%d*$") then
		fn3("无法读取 Universe ID")
	end

	if not match(v26, "^[1-9]%d*$") then
		fn3("无法读取 Place ID")
	end

	local function fn8()
		local v27, v28 = v(function()
			return v3(v12.PlaceId)
		end)

		if v27 and v2(v28) == "string" and match(v28, "^[1-9]%d*$") then
			return v28
		end
		return nil
	end

	local function fn9(arg4, arg5)
		local v27, v28 = v(function()
			return v14({
				Url = arg .. arg4,
				Method = "POST",
				Headers = { ["Content-Type"] = "application/json" },
				Body = jsonEncode(httpService, arg5),
			})
		end)

		if not v27 or v2(v28) ~= "table" then
			return nil, nil, nil
		end
		local v29 = v4(v28.StatusCode)
		local flag = v28.Success == false
		local flag2

		if flag then
			flag2 = flag
		elseif v29 then
			flag2 = v29 < 200 or v29 >= 300
		else
			flag2 = v29
		end

		if flag2 then
			local v30, v31 = v(function()
				return jsonDecode(httpService, v28.Body or "")
			end)

			return nil, v29, v30 and v2(v31) == "table" and v2(v31.error) == "string" and v31.error or nil
		end

		local v30, v31 = v(function()
			return jsonDecode(httpService, v28.Body or "")
		end)

		if not v30 or v2(v31) ~= "table" then
			return nil, v29, nil
		end
		return v31, v29, nil
	end

	local function fn10(arg4)
		v(function()
			fn9("/api/loader/report", { token = arg2, hwid = v24, robloxUserId = v22, placeId = fn8(), universeId = v25, signals = arg4 })
		end)
	end

	local function fn11()
		local v27 = fn5()

		local function fn12(arg4)
			v27[#v27 + 1] = arg4
		end

		if not v23 or v23.request ~= v14 then
			fn12("request_environment_mismatch")
		end

		if not v23 or v23.loadstring ~= v15 then
			fn12("loadstring_environment_mismatch")
		end

		if not v23 or v23.getgenv ~= v16 then
			fn12("getgenv_environment_mismatch")
		end

		local v28, v29 = v(function()
			return v3(v12.GameId)
		end)

		local v30, v31 = v(function()
			return v3(v12.PlaceId)
		end)

		local v32, v33 = v(function()
			return v3(localPlayer.UserId) == v22
		end)

		local v34, v35 = v(fn7)

		if not v28 or v29 ~= v25 or not v30 or not match(v31, "^[1-9]%d*$") or not v32 or not v33 or not v34 or v35 ~= v24 then
			fn12("environment_mismatch")
		end

		return v27
	end

	local function fn12()
		local v27 = fn11()

		if #v27 > 0 then
			fn10(v27)
			fn3("客户端完整性检查发现异常：" .. concat(v27, ", "))
		end
	end

	local function fn13()
		local authorize, v27, v28 = fn9("/api/loader/authorize", {
			token = arg2,
			loginTicket = arg3,
			hwid = v24,
			robloxUserId = v22,
			placeId = fn8(),
			universeId = v25,
		})

		if not authorize then
			fn3(v28 or v27 and "授权接口返回 HTTP " .. v27 .. "，未提供具体原因" or "授权网络请求失败：未收到服务器响应")
		end

		if v2(authorize.sessionToken) ~= "string" or #authorize.sessionToken == 0 then
			fn3("授权响应缺少有效会话令牌")
		end

		if v2(authorize.script) ~= "string" or #authorize.script == 0 then
			fn3("授权响应缺少游戏脚本源码")
		end

		if authorize.universeId ~= v25 then
			fn3("授权响应的游戏 Universe ID 与当前游戏不一致")
		end

		return authorize
	end

	local function fn14(arg4)
		local v27 = clock()

		spawn(function()
			while true do
				wait(30)
				local v28 = fn11()

				if #v28 > 0 then
					fn10(v28)
					fn3("客户端运行环境发生变化：" .. concat(v28, ", "))
				end

				local heartbeat, v29, v30 = fn9("/api/loader/heartbeat", {
					sessionToken = arg4,
					hwid = v24,
					robloxUserId = v22,
					placeId = fn8(),
					universeId = v25,
					integrityOk = true,
				})

				if heartbeat and heartbeat.ok == true then
					v27 = clock()
					continue
				end

				if v29 and v29 >= 400 and v29 < 500 then
					fn3(v30 or "心跳接口拒绝请求：HTTP " .. v29 .. "，未提供具体原因")
					continue
				end

				if not (n <= clock() - v27) then
					continue
				end
				fn3("心跳连接超时：服务器未在规定时间内成功续期，请重新运行 Loader")
			end
		end)
	end

	local function fn15(arg4)
		local v27, v28 = v(v15, arg4)

		if not v27 or v2(v28) ~= "function" then
			fn3("脚本加载失败")
		end

		local v29, v30 = v(v28)

		if not v29 then
			v6("[Moon] 脚本运行失败: " .. v3(v30))
		end
	end

	local function fn16()
		fn12()
		local v27 = fn13()
		_bsdata0 = { sessionToken = v27.sessionToken }
		fn14(v27.sessionToken)
		fn15(v27.script)
	end

	fn16()
end
