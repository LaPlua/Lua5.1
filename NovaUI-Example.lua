--==============================================================================
-- Nova UI 使用示例（从远程加载库本体）
--   把下面两行的 URL 换成你自己的仓库地址即可
--==============================================================================
local Nova = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/LaPlua/Lua5.1/main/NovaUI.lua"
))()

--==============================================================================
-- 1. 创建界面
--==============================================================================
local win = Nova.new({
	Title          = "NOVA",              -- 品牌名（侧边栏 logo 旁）
	Subtitle       = "Interface Suite",
	Icon           = "default",           -- 侧边栏 logo：图标名 或 "rbxassetid://xxx"

	PlayerName     = "Past Owl",          -- 主界面左上角：玩家名字
	PlayerSubtitle = "Till: 1 mar 2026",
	Avatar         = nil,                 -- 主界面左上角：玩家头像（nil = 自动取 Roblox 头像）

	FloatingIcon   = nil,                 -- 悬浮球：nil = 纯黑 Open/Close 文字；也可 "rbxassetid://xxx" 用图片
	Accent         = Color3.fromRGB(255, 62, 92),
	Accent2        = Color3.fromRGB(255, 130, 76),
	ToggleKey      = Enum.KeyCode.RightShift,
	Columns        = 2,                   -- 内容区分几列
	StartOpen      = false,               -- 是否开局就展开主界面
})

--==============================================================================
-- 2. 主侧边栏 / 副侧边栏
--   一个主侧边栏可以挂任意多个副侧边栏
--==============================================================================
local combat = win:Primary("Combat", "shield")     -- 主侧边栏
local visual = win:Primary("Visuals", "eye")
local setting = win:Primary("Settings", "settings")

local main    = combat:Secondary("Main", "settings")     -- 副侧边栏
local trigger = combat:Secondary("Trigger", "bolt")
local render  = visual:Secondary("Render", "eye")
local general = setting:Secondary("General", "settings")

--==============================================================================
-- 3. 分组与控件
--==============================================================================
local sec = main:Section("General settings")

sec:Toggle({
	Title    = "Enable module",
	Desc     = "Activates the main module of this section.",
	Default  = false,
	Flag     = "MainEnabled",                -- 可选：结果会写入 Nova.Flags
	Menu     = {                             -- 可选：右侧 "..." 菜单
		{ Name = "Reset to default", Callback = function() end },
		{ Name = "Copy settings",    Callback = function() end },
	},
	Callback = function(v) print("toggle:", v) end,
})

sec:Slider({
	Title    = "Vertical offset",
	Desc     = "Adjusts the upward compensation amount.",
	Min = 0, Max = 100, Step = 1, Default = 50,
	Suffix   = "%",
	Callback = function(v) print("slider:", v) end,
})

sec:Dropdown({
	Title    = "Selected profile",
	Desc     = "Picks the active profile for applying settings.",
	Options  = { "None", "ACE", "Balanced" },
	Default  = "None",
	Callback = function(v) print("dropdown:", v) end,
})

sec:Keybind({
	Title    = "Toggle key",
	Desc     = "Click then press a key to bind.",
	Default  = Enum.KeyCode.F,
	Callback = function(key) print("keybind:", key.Name) end,
})

sec:Input({
	Title       = "Config name",
	Placeholder = "my-config",
	Callback    = function(text) print("input:", text) end,
})

sec:Button({
	Title    = "Run action",
	Text     = "Run",
	Callback = function() win:Notify({ Title = "Done", Desc = "Action executed.", Duration = 2 }) end,
})

sec:Divider()
sec:Label({ Text = "这里是一段说明文字，会自动换行显示。" })

-- 其它页面的示例内容
trigger:Section("Trigger settings"):Toggle({ Title = "Auto trigger", Desc = "Fires when a target is in range.", Default = false })
render:Section("Render options"):Toggle({ Title = "Player highlights", Desc = "Draws a highlight box.", Default = true })
general:Section("Interface"):Slider({ Title = "Interface scale", Desc = "Manual scale multiplier.", Min = 0.5, Max = 1.5, Step = 0.05, Default = 1, Suffix = "x" })

--==============================================================================
-- 4. 通知 / 运行时修改
--==============================================================================
win:Notify({
	Title    = "Nova UI 已加载",
	Desc     = "点击悬浮球或按 RightShift 开关界面。",
	Duration = 4,
	Icon     = "check",
})

win:SetPlayerName("Past Owl")                  -- 运行时改玩家名字
win:SetAvatar("rbxassetid://0000000000")       -- 运行时改头像
win:SetFloatingIcon("rbxassetid://0000000000") -- 运行时改悬浮球图片

win:Open()
-- win:Close() / win:Toggle() / win:IsOpen() / win:Destroy()