--==============================================================================
-- 星穹 Celest 使用示例（从远程加载库本体）
--   把下面两行的 URL 换成你自己的仓库地址即可
--==============================================================================
local Celest = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/LaPlua/Lua5.1/main/Celest.lua?v=" .. os.time()
))()

--==============================================================================
-- 1. 创建星图窗口
--   title    左上角标题
--   subtitle 标题下小字
--   accent   一键换强调色（同时作用于强调色 / 渐变尾色 / 描边色）
--   hint     左下角操作提示（省略则按设备自动生成）
--==============================================================================
local win = Celest.new({
	title    = "星 穹",
	subtitle = "C E L E S T   ·   示例",
	-- accent = Color3.fromRGB(120, 200, 255),   -- 想换色就打开这行
})

--==============================================================================
-- 2. 分类（内环星点）
--   win:Category(name, glyph)
--   glyph 是类别星点上显示的字符，省略为 "✦"
--   点击类别星点 → 外环切换为该分类的功能星
--==============================================================================
local combat = win:Category("兵戈", "✦")
local visual = win:Category("观照", "◈")
local move   = win:Category("行止", "❖")
local system = win:Category("律令", "⊙")

--==============================================================================
-- 3. 控件：Toggle（开关）
--   Toggle(name, default, cb) · cb(on) 在点击切换时触发
--   返回 item，可用 t.value 读当前状态
--==============================================================================
local aim = combat:Toggle("自动瞄准", false, function(on)
	print("[兵戈] 自动瞄准 ->", on)
end)
combat:Toggle("穿墙视野", true, function(on)
	print("[兵戈] 穿墙视野 ->", on)
end)
combat:Toggle("无后坐力", false, function(on)
	print("[兵戈] 无后坐力 ->", on)
end)
combat:Toggle("弹道预判", true, function(on)
	print("[兵戈] 弹道预判 ->", on)
end)

--==============================================================================
-- 4. 控件：Slider（数值）
--   Slider(name, min, max, default, cb) · cb(v) 在拖动时实时触发
--   操作：先单击数值星选中，再按住左右拖动
--   返回 item，可用 s.value 读当前值
--==============================================================================
local damp = combat:Slider("平滑阻尼", 0, 100, 35, function(v)
	print("[兵戈] 平滑阻尼 ->", v)
end)
combat:Slider("视野半径", 0, 100, 62, function(v)
	print("[兵戈] 视野半径 ->", v)
end)

--==============================================================================
-- 5. 控件：Button（按钮）
--   Button(name, cb) · cb() 在点击时触发一次
--==============================================================================
combat:Button("锁定最近目标", function()
	print("[兵戈] 锁定最近目标")
end)

--==============================================================================
-- 6. 其它分类：功能数超过 8 个时，外环会自动多开一环
--   下面「观照」共 10 个 → 自动分 2 环
--==============================================================================
visual:Toggle("描边高亮", true,  function(on) print("[观照] 描边高亮 ->", on) end)
visual:Toggle("骨架绘制", false, function(on) print("[观照] 骨架绘制 ->", on) end)
visual:Toggle("方框标记", false, function(on) print("[观照] 方框标记 ->", on) end)
visual:Toggle("距离读数", true,  function(on) print("[观照] 距离读数 ->", on) end)
visual:Slider("描边浓度", 0, 100, 48, function(v) print("[观照] 描边浓度 ->", v) end)
visual:Slider("绘制层数", 1, 8, 3, function(v) print("[观照] 绘制层数 ->", v) end)
visual:Toggle("队友标记", false, function(on) print("[观照] 队友标记 ->", on) end)
visual:Toggle("轨迹线",   false, function(on) print("[观照] 轨迹线 ->", on) end)
visual:Toggle("命中音效", false, function(on) print("[观照] 命中音效 ->", on) end)
visual:Button("清空全部标记", function() print("[观照] 清空全部标记") end)

--==============================================================================
-- 7. 其它分类：普通写法
--==============================================================================
move:Toggle("疾行",   false, function(on) print("[行止] 疾行 ->", on) end)
move:Toggle("二段跃", false, function(on) print("[行止] 二段跃 ->", on) end)
move:Slider("速度倍率", 1, 20, 4,   function(v) print("[行止] 速度倍率 ->", v) end)
move:Slider("滞空时间", 0, 100, 20, function(v) print("[行止] 滞空时间 ->", v) end)

system:Toggle("低语面板", true, function(on) print("[律令] 低语面板 ->", on) end)
system:Slider("星痕上限", 1, 10, 6, function(v) print("[律令] 星痕上限 ->", v) end)

--==============================================================================
-- 8. 运行时 API
--   win:Open()          展开星图
--   win:Close()         收合星图（右下角常驻星点仍在）
--   win:Select(name)    按分类名切换
--   win:Search(prefill) 打开「低语」搜索（可预填关键字）
--   win:Destroy()       销毁整个 UI
--==============================================================================
system:Button("展开低语搜索", function() win:Search() end)
system:Button("切到「观照」", function() win:Select("观照") end)
system:Button("关闭星图",     function() win:Close() end)

--==============================================================================
-- 9. 默认展开一次（Celest 无 StartOpen，需要就手动调用）
--   电脑也可按住 ALT 呼出；手机点右下角常驻星点
--==============================================================================
print("Celest", Celest.Version, "已加载：按住 ALT 呼出 · CTRL+K 低语 · 手机点右下星点")

win:Open()

-- 只读示例：想取值随时读 item.value
--   print(aim.value, damp.value)