-- 回归验证：滑块星为「纯数值」控件——单击只做选中，不再兼任开关；
-- 调值只走拖动通道（cb 触发），不再有 on / onCb。
__ERR = {}
local function try(name, fn)
	local ok, err = xpcall(fn, function(e) return debug.traceback(tostring(e), 2) end)
	if not ok then __ERR[#__ERR + 1] = name .. " -> " .. tostring(err) end
end

try("drain", function() __drain(6000) end)

local win = Celest.new({ title = "星 穹", subtitle = "S" })
local c1 = win:Category("测试", "✦")
local valN, lastV = 0, nil
local s1 = c1:Slider("数值", 0, 100, 50, function(v) valN = valN + 1; lastV = v end)
try("build", function() __drain(5000) end)

local function starBtn(it)
	return it._ui and it._ui.node and it._ui.node:FindFirstChildOfClass("TextButton")
end

try("open", function() win:Open(); __drain(1500) end)

__REPORT = {}
__REPORT[#__REPORT + 1] = "初始 value=" .. tostring(s1.value) .. " on=" .. tostring(s1.on)

-- 1) 纯滑块不应再带 on 字段（开关与滑块已拆开）
if s1.on ~= nil then __ERR[#__ERR + 1] = "滑块不应有 on 字段，实际 " .. tostring(s1.on) end
if s1.onCb ~= nil then __ERR[#__ERR + 1] = "滑块不应有 onCb 字段" end
if s1.value ~= 50 then __ERR[#__ERR + 1] = "初始值应为 50，实际 " .. tostring(s1.value) end

-- 2) 单击滑块星 → 不改值、不触发调值回调（只是选中）
try("click-1", function() starBtn(s1).MouseButton1Click:Fire(); __drain(300) end)
try("click-2", function() starBtn(s1).MouseButton1Click:Fire(); __drain(300) end)
__REPORT[#__REPORT + 1] = "单击2次后 value=" .. tostring(s1.value) .. " cb次数=" .. tostring(valN)
if s1.value ~= 50 then __ERR[#__ERR + 1] = "单击不得改变数值：value=" .. tostring(s1.value) end
if valN ~= 0 then __ERR[#__ERR + 1] = "单击误触调值回调 " .. tostring(valN) .. " 次" end

-- 3) 调值通道仍有效：走 setT 应改值并触发 cb
try("setT", function() s1._ui.setT(80); __drain(300) end)
__REPORT[#__REPORT + 1] = "调值后 value=" .. tostring(s1.value) .. " cb次数=" .. tostring(valN) .. " 末值=" .. tostring(lastV)
if s1.value ~= 80 then __ERR[#__ERR + 1] = "调值后 value 应为 80，实际 " .. tostring(s1.value) end
if valN ~= 1 or lastV ~= 80 then __ERR[#__ERR + 1] = "cb 应收到 1 次 80，实际 " .. tostring(valN) .. "/" .. tostring(lastV) end

-- 4) 越界值应被 clamp
try("clamp", function() s1._ui.setT(999); __drain(200) end)
__REPORT[#__REPORT + 1] = "越界调值后 value=" .. tostring(s1.value)
if s1.value ~= 100 then __ERR[#__ERR + 1] = "越界应 clamp 到 100，实际 " .. tostring(s1.value) end