--==============================================================================
-- 星穹 Celest · 最简示例（复制 → 直接运行）
--   电脑：ALT 呼出 / 再按归寂 · CTRL+K 低语 · 手机：点右下角常驻星点
--   想完全离线跑：把下面「加载库」那几行换成 Celest-Standalone.lua 的内容即可
--==============================================================================

---------------------------------------------------------------- 加载库（远程）
local Celest = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/LaPlua/Lua5.1/main/Celest.lua?v=" .. os.time()
))()

-- 版本守卫：如果拉到的是旧缓存，控制台会直接报警
if Celest.Version ~= "1.2.0" then
	warn("[Celest] 实际加载到 " .. tostring(Celest.Version) .. "，期望 1.2.0 → 重启执行器清缓存")
end

---------------------------------------------------------------- 建窗口
local win = Celest.new({
	title    = "星 穹",
	subtitle = "示 例",
})

---------------------------------------------------------------- 分类（glyph 用内置矢量图标名，不依赖字体）
local combat = win:Category("兵戈", "sword")
local visual = win:Category("观照", "eye")

---------------------------------------------------------------- 1) 开关 Toggle(name, 默认, cb)
combat:Toggle("自动瞄准", false, function(on)
	print("[兵戈] 自动瞄准 ->", on)
end)
combat:Toggle("穿墙视野", true, function(on)
	print("[兵戈] 穿墙视野 ->", on)
end)

---------------------------------------------------------------- 2) 数值 Slider(name, 最小, 最大, 默认, cb)
--    操作：先单击数值星选中，再按住左右拖动
combat:Slider("视野半径", 0, 100, 50, function(v)
	print("[兵戈] 视野半径 ->", v)
end)

---------------------------------------------------------------- 3) 下拉框 Dropdown(name, 选项表, 默认, cb)
--    操作：点该下拉星展开列表 → 再点其中一项
combat:Dropdown("作战模式", { "平衡", "激进", "潜行" }, "平衡", function(v)
	print("[兵戈] 作战模式 ->", v)
end)

---------------------------------------------------------------- 4) 按钮 Button(name, cb)（点一次执行一次）
combat:Button("锁定最近目标", function()
	print("[兵戈] 锁定最近目标")
end)
visual:Button("清空全部标记", function()
	print("[观照] 清空全部标记")
end)
visual:Toggle("描边高亮", true, function(on)
	print("[观照] 描边高亮 ->", on)
end)

---------------------------------------------------------------- 5) 运行时 API
--    win:Open()          展开星图
--    win:Close()         收合星图（右下角常驻星点仍在）
--    win:Select(name)    按分类名切换
--    win:Search(prefill) 打开「低语」搜索
--    win:Destroy()       销毁 UI
combat:Button("打开低语搜索", function() win:Search() end)
combat:Button("关闭星图", function() win:Close() end)

---------------------------------------------------------------- 启动
print("Celest", Celest.Version, "已加载：ALT 呼出/再按归寂 · CTRL+K 低语 · 手机点右下星点")
win:Open()