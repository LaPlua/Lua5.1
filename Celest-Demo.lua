--[[
	星 穹 · C E L E S T   —— 示例（基于 Celest 库）
	-----------------------------------------------------------------
	演示如何用库搭一套「无窗体星图」界面：
	内环星点选分类，外环出功能；某类功能多会自动多开几环。
	电脑：按住 ALT 呼出；手机：点右下角星点。
--]]

local Celest = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/LaPlua/Lua5.1/main/Celest.lua?v=" .. os.time()))()

local win = Celest.new({
	title    = "星 穹",
	subtitle = "C E L E S T   ·   示例",
})

---------------------------------------------------------------- 兵戈
local combat = win:Category("兵戈", "✦")
combat:Toggle("自动瞄准", false, function(on) end)
combat:Toggle("穿墙视野", true,  function(on) end)
combat:Toggle("无后坐力", false, function(on) end)
combat:Toggle("弹道预判", true,  function(on) end)
combat:Slider("平滑阻尼", 0, 100, 35, function(v) end)
combat:Slider("视野半径", 0, 100, 62, function(v) end)

---------------------------------------------------------------- 观照
local visual = win:Category("观照", "◈")
visual:Toggle("描边高亮", true,  function(on) end)
visual:Toggle("骨架绘制", false, function(on) end)
visual:Toggle("方框标记", false, function(on) end)
visual:Toggle("距离读数", true,  function(on) end)
visual:Slider("描边浓度", 0, 100, 48, function(v) end)
visual:Slider("绘制层数", 1, 8, 3, function(v) end)

---------------------------------------------------------------- 行止
local move = win:Category("行止", "❖")
move:Toggle("疾行",   false, function(on) end)
move:Toggle("二段跃", false, function(on) end)
move:Toggle("凌波",   false, function(on) end)
move:Toggle("牵引",   false, function(on) end)
move:Slider("速度倍率", 1, 20, 4, function(v) end)
move:Slider("滞空时间", 0, 100, 20, function(v) end)

---------------------------------------------------------------- 律令
local sys = win:Category("律令", "⊙")
sys:Toggle("低语面板", true, function(on) end)
sys:Slider("星痕上限", 1, 10, 6, function(v) end)
sys:Button("展开低语搜索", function() win:Search() end)
sys:Button("关闭星图", function() win:Close() end)