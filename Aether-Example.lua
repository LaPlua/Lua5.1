--==============================================================================
--  AETHER UI · 自包含示例 Example
--  自带加载库本体：直接从 GitHub 加载本文件即可运行，无需先手动加载库。
--  加载： loadstring(game:HttpGet("https://raw.githubusercontent.com/LaPlua/Lua5.1/main/Aether-Example.lua"))()
--==============================================================================

-- 0) 加载库本体（已加载过则直接复用）
if not Aether then
	Aether = loadstring(game:HttpGet("https://raw.githubusercontent.com/LaPlua/Lua5.1/main/Aether.lua"))()
end
if not Aether then
	error("[AETHER] 库本体加载失败：请检查执行器是否支持 loadstring / game:HttpGet。")
end

-- 1) 创建实例 ---------------------------------------------------------------
local lib = Aether.new({
	Name  = "AETHER",
	-- Icon  = "https://example.com/logo.png",  -- 可选：自定义左上角 / 悬浮窗图标（网络图）
	Theme = "void",
	-- Boot = false,      -- 跳过开机自检
	-- Persist = false,   -- 关闭配置持久化
})

-- 2) 左侧主侧边栏：一个页面 -------------------------------------------------
local pageMain = lib:Page("主页", "home")
local tabCore  = pageMain:Tab("核心", "power")
local tabLook  = pageMain:Tab("外观", "palette")

-- 3) 卡片 + 控件 ------------------------------------------------------------
local sec1 = tabCore:Section({ Title = "功能开关", Desc = "点击即时生效", Icon = "bolt" })

sec1:Toggle({
	Title = "示例开关", Desc = "带配置存档的布尔项", Default = false, Flag = "demo_toggle",
	Callback = function(v)
		lib:Notify({ Title = v and "示例开关 已开启" or "示例开关 已关闭", Icon = "power", Duration = 2 })
	end,
})

sec1:Slider({
	Title = "示例滑条", Desc = "拖动 / 滚轮均可调", Min = 0, Max = 100, Step = 5,
	Default = 50, Suffix = "%", Flag = "demo_slider",
})

sec1:Dropdown({
	Title = "示例下拉", Options = { "选项 A", "选项 B", "选项 C" }, Default = 1,
	Flag = "demo_dropdown",
})

sec1:Keybind({
	Title = "示例热键", Desc = "点击后按任意按键", Flag = "demo_key",
	Callback = function(key) lib:Log("热键触发：" .. tostring(key and key.Name), "accent") end,
})

local sec2 = tabLook:Section({ Title = "外观示例", Icon = "palette" })

sec2:ColorPicker({ Title = "示例颜色", Default = Color3.fromRGB(0, 226, 255), Flag = "demo_color" })
sec2:Segmented({ Title = "示例分段", Options = { "低", "中", "高" }, Default = 2, Flag = "demo_seg" })
sec2:Progress({ Title = "示例进度", Default = 0.4 })
sec2:Graph({ Title = "实时帧率", Source = "fps" })  -- 绑定内置遥测

local sec3 = tabLook:Section({ Title = "操作示例", Icon = "terminal" })
sec3:Button({ Title = "切换主题", Icon = "palette", Callback = function() lib:CycleTheme() end })
sec3:Button({ Title = "指令面板 (Ctrl+K)", Icon = "search", Callback = function() lib:Palette() end })
sec3:Button({ Title = "控制台 (F8)", Desc = "直接执行 Lua", Icon = "terminal",
	Variant = "ghost", Callback = function() lib:Console() end })
sec3:Label({ Title = "版本", Text = "AETHER v" .. Aether.Version })
sec3:Divider()
sec3:Note({ Text = "右键任意控件：重置 / 复制 / 固定到快捷栏；固定后按住 ALT 用环形菜单触发。" })

-- 4) 第二个页面（可选，演示多页切换） ---------------------------------------
local pageAbout = lib:Page("关于", "user")
local tabInfo = pageAbout:Tab("信息", "scan")
local secInfo = tabInfo:Section({ Title = "关于本库", Icon = "globe" })
secInfo:Label({ Title = "框架", Text = "AETHER 以太界面框架" })
secInfo:Label({ Title = "主题数", Text = "5 套" })
secInfo:Button({ Title = "发送一条通知", Icon = "bolt",
	Callback = function()
		lib:Notify({ Title = "来自示例的通知", Desc = "右下角堆叠卡片", Icon = "check" })
	end,
})

-- 5) 收尾 -------------------------------------------------------------------
lib:Select(pageMain, tabCore)
lib:Notify({ Title = "示例已加载", Desc = "Ctrl+K 指令面板 · F8 控制台 · ALT 环形菜单", Duration = 5 })