-- 回归验证：滑块星单击可开/关（on 切换 + onCb），调值回调 cb 不被误触
__ERR = {}
local function try(name, fn)
	local ok, err = xpcall(fn, function(e) return debug.traceback(tostring(e), 2) end)
	if not ok then __ERR[#__ERR + 1] = name .. " -> " .. tostring(err) end
end

try("drain", function() __drain(6000) end)

local win = Celest.new({ title = "星 穹", subtitle = "S" })
local c1 = win:Category("测试", "✦")
local valN, onN, onLast = 0, 0, nil
local s1 = c1:Slider("数值", 0, 100, 50, function(v) valN = valN + 1 end, function(on)
	onN = onN + 1; onLast = on
end)
try("build", function() __drain(5000) end)

local function starBtn(it)
	return it._ui and it._ui.node and it._ui.node:FindFirstChildOfClass("TextButton")
end

try("open", function() win:Open(); __drain(1500) end)

__REPORT = {}
__REPORT[#__REPORT + 1] = "初始 on=" .. tostring(s1.on) .. " value=" .. tostring(s1.value)

-- 1) 单击滑块星 → 关闭
try("click-1", function() starBtn(s1).MouseButton1Click:Fire(); __drain(300) end)
__REPORT[#__REPORT + 1] = "单击1次后 on=" .. tostring(s1.on) .. " onCb次数=" .. tostring(onN) .. " onCb值=" .. tostring(onLast)
if s1.on ~= false then __ERR[#__ERR + 1] = "单击滑块星后 on 应为 false，实际 " .. tostring(s1.on) end
if onN ~= 1 or onLast ~= false then __ERR[#__ERR + 1] = "onCb 应收到 1 次 false，实际 " .. tostring(onN) .. "/" .. tostring(onLast) end

-- 2) 再单击 → 重新打开
try("click-2", function() starBtn(s1).MouseButton1Click:Fire(); __drain(300) end)
__REPORT[#__REPORT + 1] = "单击2次后 on=" .. tostring(s1.on) .. " onCb次数=" .. tostring(onN) .. " onCb值=" .. tostring(onLast)
if s1.on ~= true then __ERR[#__ERR + 1] = "再单击滑块星后 on 应为 true，实际 " .. tostring(s1.on) end
if onN ~= 2 or onLast ~= true then __ERR[#__ERR + 1] = "onCb 应收到第 2 次 true，实际 " .. tostring(onN) .. "/" .. tostring(onLast) end

-- 3) 开关滑块不应触发调值回调
if valN ~= 0 then __ERR[#__ERR + 1] = "切换开关时误触了调值回调 " .. tostring(valN) .. " 次" end
__REPORT[#__REPORT + 1] = "调值回调次数=" .. tostring(valN)

-- 4) 值本身没被改动
if s1.value ~= 50 then __ERR[#__ERR + 1] = "切换开关把值改了：value=" .. tostring(s1.value) end