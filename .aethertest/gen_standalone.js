// 由 Celest.lua + 内联示例 生成 Celest-Standalone.lua（保持两者同源）
const fs = require('fs');

const lib = fs.readFileSync('/workspace/Celest.lua', 'utf8')
  .replace(/^[\s\S]*?--\]\][ \t]*\r?\n/, '') // 去掉库本体的开头文档注释
  .trimStart();

const header = `--[[
    星 穹 · C E L E S T   —— 独立单文件版
    =================================================================
    自包含：库本体已内联，直接粘进执行器即可运行，不依赖网络或其它文件。
    与 Celest.lua 同源，版本号见下方 Celest.Version。

    · 电脑：按 ALT 呼出星图，再按归寂；CTRL + K 搜索
    · 手机：点右下角常驻星点呼出，再点归寂
    · 三级同心星环：第1环 = 主侧边栏（大类）星点；
      第2环 = 副侧边栏（一个主栏可挂多个子类）星点；
      第3环起 = 当前副栏的功能星（开关点击亮灭、数值星拖动调值、下拉星展开、带箭头星一次执行）
--]]

`;

const example = `---------------------------------------------------------------- 主侧边栏与副侧边栏
-- 第1环 = 主侧边栏（大类）；第2环 = 副侧边栏（一个主栏可挂多个）；第3环起 = 功能
local win = Celest.new({
	title    = "星 穹",
	subtitle = "C E L E S T   ·   独立版",
})

---------------------------------------------------------------- 主栏：兵戈（下挂「瞄准」「武备」两个副栏）
local combat = win:Category("兵戈", "sword")        -- 主侧边栏（第1环）
local aim    = combat:Category("瞄准", "target")    -- 副侧边栏（第2环）
local arms   = combat:Category("武备", "shield")    -- 同一个主栏可挂多个副栏
aim:Toggle("自动瞄准", false, function(on) end)
aim:Toggle("弹道预判", true,  function(on) end)
aim:Slider("视野半径", 0, 100, 62, function(v) end)
aim:Dropdown("瞄准部位", { "头部", "胸部", "最近" }, "头部", function(v) end)
arms:Toggle("穿墙视野", true,  function(on) end)
arms:Toggle("无后坐力", false, function(on) end)
arms:Slider("平滑阻尼", 0, 100, 35, function(v) end)
arms:Button("锁定最近目标", function() end)

---------------------------------------------------------------- 主栏：观照
local visual = win:Category("观照", "eye")
local mark   = visual:Category("标记", "target")
local info   = visual:Category("读数", "list")
mark:Toggle("描边高亮", true,  function(on) end)
mark:Toggle("方框标记", false, function(on) end)
mark:Toggle("队友标记", false, function(on) end)
info:Toggle("骨架绘制", false, function(on) end)
info:Toggle("距离读数", true,  function(on) end)
info:Slider("描边浓度", 0, 100, 48, function(v) end)

---------------------------------------------------------------- 主栏：律令
local sys  = win:Category("律令", "gear")
local core = sys:Category("核心", "gear")
core:Toggle("搜索面板", true, function(on) end)
core:Slider("星痕上限", 1, 10, 6, function(v) end)
core:Button("展开搜索", function() win:Search() end)
core:Button("关闭星图", function() win:Close() end)

print("Celest", Celest.Version, "已加载：按 ALT 呼出/再按归寂 · CTRL+K 搜索 · 手机点右下星点")
win:Open()
`;

const out = header + 'local Celest = (function()\n' + lib + '\nend)()\n\n' + example;
fs.writeFileSync('/workspace/Celest-Standalone.lua', out);
console.log('celest.js length=' + out.length);