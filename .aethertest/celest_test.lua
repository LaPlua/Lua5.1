-- 星穹独立示例：背景透明 + 数值星拖动 验证
__ERR = {}
local function try(name, fn)
	local ok, err = xpcall(fn, function(e) return debug.traceback(tostring(e), 2) end)
	if not ok then __ERR[#__ERR + 1] = name .. " -> " .. tostring(err) end
end

-- 让入场协程先跑一段
try("drain", function() __drain(6000) end)

local CoreGui = game:GetService("CoreGui")
local UIS     = game:GetService("UserInputService")

local function descendants(cls)
	local out = {}
	for _, d in ipairs(CoreGui:GetDescendants()) do
		if d.ClassName == cls then out[#out + 1] = d end
	end
	return out
end

-- [1] 背景必须透明
local gui = nil
for _, d in ipairs(CoreGui:GetChildren()) do
	if d.Name == "CelestStandalone" then gui = d end
end
if not gui then
	__ERR[#__ERR + 1] = "未找到 CelestStandalone ScreenGui"
else
	local root = nil
	for _, c in ipairs(gui:GetChildren()) do
		if c.ClassName == "Frame" then root = c break end
	end
	if not root then
		__ERR[#__ERR + 1] = "未找到根容器"
	elseif root.BackgroundTransparency ~= 1 then
		__ERR[#__ERR + 1] = "根容器背景未透明（BackgroundTransparency=" .. tostring(root.BackgroundTransparency) .. "）"
	end
end

-- [2] 数值星拖动：记录百分比标签 → 依次按下 → 拖动 → 松开
local function valueLabels()
	local t = {}
	for _, d in ipairs(CoreGui:GetDescendants()) do
		if d.ClassName == "TextLabel" and type(d.Text) == "string" and d.Text:match("^%d+%%$") then
			t[#t + 1] = d
		end
	end
	return t
end

local before = valueLabels()
local nb = #before
local beforeTxts = {}
for i, d in ipairs(before) do beforeTxts[i] = d.Text end
local function snapshot(t)
	local s = {}
	for i, d in ipairs(t) do s[i] = d.Text end
	return table.concat(s, ",")
end
local beforeTxt = table.concat(beforeTxts, ",")
try("drain2", function() __drain(2000) end)

local btns = descendants("TextButton")
try("press-down", function()
	for _, b in ipairs(btns) do b.MouseButton1Down:Fire() end
end)

local drag = {
	UserInputType = Enum.UserInputType.MouseMovement,
	KeyCode = Enum.KeyCode.Unknown,
	Position = Vector3.new(300, 300, 0),
	Delta = Vector3.new(200, 0, 0),
}
try("drag", function() UIS.InputChanged:Fire(drag) end)

local endin = {
	UserInputType = Enum.UserInputType.MouseButton1,
	KeyCode = Enum.KeyCode.Unknown,
	Position = Vector3.new(300, 300, 0),
	Delta = Vector3.new(0, 0, 0),
}
try("release", function() UIS.InputEnded:Fire(endin) end)

try("drain3", function() __drain(2000) end)

-- 统计变化
local changed, total = 0, 0
local after = valueLabels()
for i = 1, math.min(#beforeTxts, #after) do
	total = total + 1
	if beforeTxts[i] ~= after[i].Text then changed = changed + 1 end
end
__REPORT = {
	"数值百分比标签数=" .. tostring(nb),
	"before=" .. beforeTxt,
	"after=" .. snapshot(after),
	"TextButton数=" .. tostring(#btns),
	"拖动后发生变化的标签数=" .. tostring(changed) .. "/" .. tostring(total),
}
if nb == 0 then
	__ERR[#__ERR + 1] = "没有找到任何数值星百分比标签"
elseif changed == 0 then
	__ERR[#__ERR + 1] = "拖动后数值未发生变化（拖动逻辑仍然失效）"
end