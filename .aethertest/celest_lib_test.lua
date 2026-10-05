-- Celest 库验证：建窗、分类、功能星、拖动、分类切换、关环清屏
__ERR = {}
local function try(name, fn)
	local ok, err = xpcall(fn, function(e) return debug.traceback(tostring(e), 2) end)
	if not ok then __ERR[#__ERR + 1] = name .. " -> " .. tostring(err) end
end

try("drain", function() __drain(6000) end)

local CoreGui = game:GetService("CoreGui")
local UIS     = game:GetService("UserInputService")
local RenderStepped = game:GetService("RunService").RenderStepped

-- 建一个窗口：兵戈 12 个功能（应自动 2 环）+ 观照 2 个
local win = Celest.new({ title = "星 穹", subtitle = "T" })
local c1  = win:Category("兵戈", "✦")
local s1  = c1:Slider("视野半径", 0, 100, 50)
c1:Toggle("自动瞄准", false)
for i = 1, 10 do c1:Toggle("功能" .. i, false) end
local c2  = win:Category("观照", "◈")
local s2  = c2:Slider("浓度", 0, 100, 20)

try("build", function() __drain(6000) end)

local gui
for _, d in ipairs(CoreGui:GetChildren()) do if d.Name == "CelestUI" then gui = d end end
if not gui then __ERR[#__ERR + 1] = "未建出 CelestUI" end

-- 星点节点统计（当前分类 兵戈 = 12 个 → 2 环）
local starNodes = 0
local function countNodes()
	local n = 0
	for _, it in ipairs(c1.items) do
		if it._ui and it._ui.node and it._ui.node.Parent then n = n + 1 end
	end
	return n
end
starNodes = countNodes()
if starNodes ~= 12 then __ERR[#__ERR + 1] = "兵戈功能星数应为 12，实际 " .. tostring(starNodes) end

-- 关环时应看不到品牌/拦截层
local brand, map
for _, d in ipairs(gui:GetDescendants()) do
	if d.Name == "CelestBrand" then brand = d end
	if d.Name == "CelestMap" then map = d end
end
if not brand then __ERR[#__ERR + 1] = "未找到品牌层" end
if brand and brand.Visible then __ERR[#__ERR + 1] = "未开环时品牌层不应可见" end
if map and map.Visible then __ERR[#__ERR + 1] = "未开环时星图不应可见" end

-- 打开星图 → 品牌层出现
try("open", function() win:Open(); __drain(3000) end)
if brand and not brand.Visible then __ERR[#__ERR + 1] = "开环后品牌层应可见" end

-- 拖动 s1：按下 → 右移 → 松开
local MOUSE = Vector2.new(640, 360)
UIS.GetMouseLocation = function() return MOUSE end
local before = s1.value
local node = s1._ui and s1._ui.node
if not node then
	__ERR[#__ERR + 1] = "滑块无 _ui.node"
else
	local btn = node:FindFirstChildOfClass("TextButton")
	try("press", function() btn.MouseButton1Down:Fire() end)
	MOUSE = Vector2.new(840, 360)
	try("drag", function() for _ = 1, 3 do RenderStepped:Fire() end end)
	try("release", function()
		UIS.InputEnded:Fire({
			UserInputType = Enum.UserInputType.MouseButton1, KeyCode = Enum.KeyCode.Unknown,
			Position = Vector3.new(0, 0, 0), Delta = Vector3.new(0, 0, 0),
		})
	end)
end
local after = s1.value

-- 切换分类：点第二个分类星点
try("switch", function()
	local catLayer
	for _, d in ipairs(map:GetDescendants()) do
		if d.ClassName == "TextButton" and d.Text == "◈" then catLayer = d end
	end
	if catLayer then catLayer.MouseButton1Click:Fire() end
	__drain(2000)
end)
local c2nodes, c2have = 0, 0
for _, it in ipairs(c2.items) do
	c2have = c2have + 1
	if it._ui and it._ui.node and it._ui.node.Parent then c2nodes = c2nodes + 1 end
end

__REPORT = {
	"兵戈功能星数=" .. tostring(starNodes) .. "（应为 12，自动 2 环）",
	"滑块拖动=" .. tostring(math.floor(before)) .. " → " .. tostring(math.floor(after)),
	"切换分类后 观照 星数=" .. tostring(c2nodes) .. "/" .. tostring(c2have),
	"未开环时品牌可见=" .. tostring(brand and brand.Visible),
}
if after <= before then __ERR[#__ERR + 1] = "滑块拖动未生效" end
if c2nodes ~= c2have then __ERR[#__ERR + 1] = "切换分类后星点未重建完整" end