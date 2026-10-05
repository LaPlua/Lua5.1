-- 回归验证：开关只能点星切换；点空白不改状态/不关星图；关闭主界面不清开关
__ERR = {}
local function try(name, fn)
	local ok, err = xpcall(fn, function(e) return debug.traceback(tostring(e), 2) end)
	if not ok then __ERR[#__ERR + 1] = name .. " -> " .. tostring(err) end
end

try("drain", function() __drain(6000) end)

local CoreGui = game:GetService("CoreGui")
local function findGui()
	for _, d in ipairs(CoreGui:GetChildren()) do
		if d.Name == "CelestUI" then return d end
	end
end

local win = Celest.new({ title = "星 穹", subtitle = "T" })
local c1 = win:Category("测试", "✦")
local onN, offN = 0, 0
local t1 = c1:Toggle("开关A", false, function(on)
	if on then onN = onN + 1 else offN = offN + 1 end
end)
try("build", function() __drain(5000) end)

local function starBtn(it)
	return it._ui and it._ui.node and it._ui.node:FindFirstChildOfClass("TextButton")
end
local function blankBtn()
	return win.shell and win.shell.blank
end

-- 1) 打开星图
try("open", function() win:Open(); __drain(1500) end)
__REPORT = {}
__REPORT[#__REPORT + 1] = "开图后 mapOpen=" .. tostring(win.mapOpen)

-- 2) 点功能星 → 应开
try("click-star", function() starBtn(t1).MouseButton1Click:Fire() end)
if t1.value ~= true then __ERR[#__ERR + 1] = "点功能星后应为 true，实际 " .. tostring(t1.value) end
if onN ~= 1 then __ERR[#__ERR + 1] = "开回调应触发 1 次，实际 " .. tostring(onN) end

-- 3) 点空白 → 状态不能变，星图不能关
local bk = blankBtn()
__REPORT[#__REPORT + 1] = "空白按钮存在=" .. tostring(bk ~= nil)
if bk then
	try("click-blank", function() bk.MouseButton1Click:Fire(); __drain(600) end)
end
if t1.value ~= true then __ERR[#__ERR + 1] = "点空白后开关被改了：value=" .. tostring(t1.value) end
if offN ~= 0 then __ERR[#__ERR + 1] = "点空白误触了关回调 " .. tostring(offN) .. " 次" end
if not win.mapOpen then __ERR[#__ERR + 1] = "点空白把星图关了" end

-- 4) 关闭主界面 → 开关不能被清掉
try("close", function() win:Close(); __drain(1500) end)
__REPORT[#__REPORT + 1] = "关图后 value=" .. tostring(t1.value) .. " off回调=" .. tostring(offN) .. " mapOpen=" .. tostring(win.mapOpen)
if t1.value ~= true then __ERR[#__ERR + 1] = "关闭主界面把已开启的功能关了：value=" .. tostring(t1.value) end
if offN ~= 0 then __ERR[#__ERR + 1] = "关闭主界面触发了关回调 " .. tostring(offN) .. " 次" end

-- 5) 重新打开 → 状态仍在
try("reopen", function() win:Open(); __drain(1500) end)
__REPORT[#__REPORT + 1] = "重开后 value=" .. tostring(t1.value)
if t1.value ~= true then __ERR[#__ERR + 1] = "重开后开关状态丢失" end

-- 6) 再点功能星 → 才应关
try("click-star-again", function() starBtn(t1).MouseButton1Click:Fire() end)
if t1.value ~= false then __ERR[#__ERR + 1] = "再点功能星后应为 false，实际 " .. tostring(t1.value) end
if offN ~= 1 then __ERR[#__ERR + 1] = "关回调应触发 1 次，实际 " .. tostring(offN) end