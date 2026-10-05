--==============================================================================
--  AETHER UI · 演示脚本
--  用法：先执行 Aether.lua（库本体），再执行本文件即可。
--==============================================================================
if not Aether then
	error("[AETHER] 请先加载 Aether.lua 库本体，再运行本演示。")
end

local lib = Aether.new({
	Name = "AETHER",
	-- Icon = "https://example.com/your-logo.png",  -- 可选：自定义左上角图标
	Theme = "void",
	-- Boot = false,         -- 想跳过开场自检可设 false
	-- Persist = false,      -- 想关闭配置持久化可设 false
	-- RadialKey = Enum.KeyCode.LeftAlt,
	-- Scale = 1,
})

---------------------------------------------------------------- 页面一：作战
local pCombat = lib:Page("作战", "target")

local tBasic = pCombat:Tab("基础", "power")
local sCore = tBasic:Section({ Title = "核心模块", Desc = "运行时开关与状态", Icon = "power" })

sCore:Toggle({
	Title = "自动瞄准", Desc = "锁定最近目标",
	Default = false, Flag = "aimbot",
	Callback = function(v)
		lib:Notify({ Title = v and "自动瞄准 已开启" or "自动瞄准 已关闭", Icon = "target",
			Kind = v and "warn" or nil, Duration = 2 })
	end,
})
sCore:Toggle({ Title = "穿墙视野", Desc = "透视墙体与掩体", Default = true, Flag = "esp" })
sCore:Toggle({ Title = "无后坐力", Default = false, Flag = "norecoil" })
sCore:Keybind({ Title = "主功能热键", Desc = "点击后按下任意按键", Flag = "mainkey",
	Callback = function(k) lib:Log("热键触发：" .. tostring(k and k.Name), "accent") end })

local sNum = tBasic:Section({ Title = "数值调校", Desc = "阻尼 / 强度 / 半径", Icon = "layers" })
sNum:Slider({ Title = "瞄准阻尼", Desc = "0.05 - 1.00", Min = 0.05, Max = 1, Step = 0.05,
	Default = 0.35, Flag = "smooth", Suffix = "x" })
sNum:Slider({ Title = "视野半径", Min = 30, Max = 600, Step = 10, Default = 180,
	Flag = "radius", Suffix = "m" })
sNum:Segmented({ Title = "锁定部位", Options = { "头部", "躯干", "最近" }, Default = 1, Flag = "part" })
sNum:Graph({ Title = "实时帧率", Desc = "来自遥测总线", Source = "fps" })

local tLook = pCombat:Tab("外观", "palette")
local sLook = tLook:Section({ Title = "视觉参数", Icon = "palette" })
sLook:ColorPicker({ Title = "描边颜色", Default = Color3.fromRGB(0, 226, 255), Flag = "edgecol" })
sLook:Dropdown({ Title = "绘制层", Options = { "骨架", "方框", "信息", "全部" }, Multi = true,
	Default = { true, true, true, true }, Flag = "layers" })
sLook:Dropdown({ Title = "主题预设", Options = { "void", "neon", "ember", "arctic", "mono" },
	Default = 1, Flag = "themepick",
	Callback = function(v) lib:SetTheme(tostring(v)) end })
sLook:Input({ Title = "水印文字", Placeholder = "输入水印…", Default = "AETHER",
	Flag = "watermark" })
sLook:Progress({ Title = "模型加载", Default = 0.62 })

---------------------------------------------------------------- 页面二：遥测
local pTel = lib:Page("遥测", "wave")
local tLive = pTel:Tab("实时", "wave")
local sLive = tLive:Section({ Title = "链路状态", Desc = "FPS / Ping / 时钟", Icon = "wifi" })
sLive:Graph({ Title = "网络延迟", Desc = "单位 ms", Source = "ping" })
sLive:Label({ Title = "客户端", Text = "AETHER v" .. Aether.Version })
sLive:Label({ Title = "执行器能力", Text = "见控制台" })
sLive:Divider()
sLive:Note({ Text = "遥测数据每 0.5s 采样一次；HUD 可在右上角拖动。" })

local tTheme = pTel:Tab("主题", "palette")
local sTheme = tTheme:Section({ Title = "外观引擎", Desc = "切换时全界面平滑过渡", Icon = "palette" })
sTheme:Button({ Title = "下一个主题", Desc = "循环切换", Icon = "palette",
	Callback = function() lib:CycleTheme() end })
sTheme:Button({ Title = "打开指令面板", Desc = "Ctrl + K", Icon = "search",
	Callback = function() lib:Palette() end })
sTheme:Button({ Title = "打开控制台", Desc = "F8", Icon = "terminal",
	Callback = function() lib:Console() end })
sTheme:Button({ Title = "开关遥测 HUD", Desc = "右上角浮窗", Icon = "wave",
	Callback = function() lib:HudToggle() end })

---------------------------------------------------------------- 页面三：系统
local pSys = lib:Page("系统", "terminal")
local tSys = pSys:Tab("控制台", "terminal")
local sSys = tSys:Section({ Title = "内置 REPL", Desc = "直接执行 Lua", Icon = "terminal" })
sSys:Button({ Title = "呼出控制台", Desc = "history 支持 ↑ ↓", Icon = "terminal",
	Callback = function() lib:Console() end })
sSys:Button({ Title = "打印一行日志", Icon = "check",
	Callback = function() lib:Log("来自演示脚本的日志 · " .. os.date("%H:%M:%S"), "ok") end })
sSys:Button({ Title = "发送一条通知", Icon = "bolt",
	Callback = function() lib:Notify({ Title = "通知测试", Desc = "右下角堆叠卡片", Icon = "bolt" }) end })
sSys:Note({ Text = "环形菜单：把任意控件右键「固定到快捷栏」，之后按住 ALT 即可快速触发。" })

---------------------------------------------------------------- 收尾
lib:Select(pCombat, tBasic)
lib:Notify({ Title = "演示已就绪", Desc = "Ctrl+K 指令面板 · F8 控制台 · 按住 ALT 环形菜单", Icon = "power", Duration = 5 })