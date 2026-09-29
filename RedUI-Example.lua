--[[
================================================================================
  RedUI 使用示例
  · 左上角：玩家头像（图片可自定义）+ 玩家名字
  · 右上角：品牌名 + 标语 + 圆形图片（可自定义）
  · 左侧：主侧边栏（竖排图标）
  · 顶部：副侧边栏（横排图标，一个主侧边栏可挂多个）+ 搜索按钮
  · 内容：两栏分组卡片，含 Toggle / Slider / Dropdown / Button
================================================================================
]]

-- 本地加载：把 RedUI.lua 放到同目录后
-- local Library = loadstring(readfile("RedUI.lua"))()
-- 或从仓库 raw 地址加载：
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/LaPlua/Lua5.1/main/RedUI.lua"))()

local lib = Library.new({
	BrandName      = "Brand name",
	BrandSlogan    = "The slogan, if there is one.",
	BrandIcon      = nil,                    -- 右上角圆形图片，如 "rbxassetid://000000"
	PlayerName     = "Past Owl",             -- 左上角玩家名字
	PlayerSubtitle = "Till: 1 mar 2026",
	Avatar         = nil,                    -- 左上角玩家头像，如 "rbxassetid://000000"
	FloatingIcon   = nil,                    -- 悬浮窗图片，如 "rbxassetid://000000"
	ToggleKey      = Enum.KeyCode.RightShift, -- 按此键开/关主界面（设为 nil 可关闭）
	Columns        = 2,
	StartOpen      = false,
})

--------------------------------------------------------------------------------
-- 主侧边栏
--------------------------------------------------------------------------------
local combat  = lib:Primary("Combat", "shield")
local visual  = lib:Primary("Visuals", "eye")
local aim     = lib:Primary("Aim", "target")
local clicker = lib:Primary("Clicker", "hand")
local cursor  = lib:Primary("Cursor", "cursor")
local config  = lib:Primary("Configs", "folder")
local setting = lib:Primary("Settings", "settings")

--------------------------------------------------------------------------------
-- 副侧边栏（Combat 下挂了 5 个）
--------------------------------------------------------------------------------
local sMain   = combat:Secondary("Main", "settings")
local sTarget = combat:Secondary("Target", "target")
local sBurst  = combat:Secondary("Burst", "lightning")
local sInput  = combat:Secondary("Input", "hand")
local sOther  = combat:Secondary("Other", "wand")

-- 其它主侧边栏也各自挂一个副侧边栏
visual:Secondary("Render", "eye")
aim:Secondary("Lock", "target")
clicker:Secondary("Auto", "hand")
cursor:Secondary("Style", "cursor")
config:Secondary("Slots", "folder")
setting:Secondary("General", "settings")

--------------------------------------------------------------------------------
-- 内容（对应截图里的两栏分组）
--------------------------------------------------------------------------------
local general = sMain:Section("General settings")

general:Toggle({
	Title = "Enable module",
	Desc  = "Activates the main module of this section.",
	Default = false,
	Callback = function(v) print("[enable module]", v) end,
})

general:Toggle({
	Title = "Alternative mode",
	Desc  = "Uses an alternative processing pattern.",
	Default = false,
	Menu = {
		{ Name = "Reset to default", Callback = function() print("reset") end },
		{ Name = "Copy settings", Callback = function() print("copy") end },
	},
	Callback = function(v) print("[alternative mode]", v) end,
})

local params = sMain:Section("Parameters")

params:Dropdown({
	Title = "Selected profile",
	Desc  = "Picks the active profile for applying settings.",
	Options = { "None", "ACE", "Profile B", "Profile C" },
	Default = "None",
	Callback = function(v) print("[profile]", v) end,
})

params:Slider({
	Title = "Vertical offset",
	Desc  = "Adjusts the upward compensation amount.",
	Min = 0, Max = 100, Step = 1, Default = 50,
	Callback = function(v) print("[vertical]", v) end,
})

params:Slider({
	Title = "Horizontal offset",
	Desc  = "Controls the side-to-side correction value.",
	Min = 0, Max = 100, Step = 1, Default = 50,
	Callback = function(v) print("[horizontal]", v) end,
})

local auto = sMain:Section("Automation")

auto:Toggle({
	Title = "Auto detect",
	Desc  = "Identifies and tracks targets automatically.",
	Default = false,
	Callback = function(v) end,
})

auto:Toggle({
	Title = "Configure range",
	Desc  = "Sets boundaries for the scanning zone.",
	Default = false,
	Callback = function(v) end,
})

auto:Dropdown({
	Title = "Manual selection",
	Desc  = "Lets the user choose a specific target manually.",
	Options = { "ACE", "None" },
	Default = "ACE",
	Callback = function(v) end,
})

local misc = sMain:Section("Miscellaneous")

misc:Toggle({
	Title = "Stable state",
	Desc  = "Maintains an ideal condition and stats.",
	Default = false,
	Menu = {
		{ Name = "Options", Callback = function() end },
	},
	Callback = function(v) end,
})

misc:Toggle({
	Title = "Fast mode",
	Desc  = "Speeds up the processing interval.",
	Default = false,
	Menu = {
		{ Name = "Options", Callback = function() end },
	},
	Callback = function(v) end,
})

misc:Slider({
	Title = "Range value",
	Desc  = "Adjusts the effective range of this option.",
	Min = 0, Max = 100, Step = 1, Default = 50,
	Callback = function(v) end,
})

-- 其它副侧边栏的内容示例
sTarget:Section("Targeting & Detection"):Button({
	Title = "Refresh target list",
	Text = "Refresh",
	Callback = function() print("refresh") end,
})

--------------------------------------------------------------------------------
-- 运行时自定义（都支持 rbxassetid / http 图片 或直接留空用内置字形）
--------------------------------------------------------------------------------
-- lib:SetFloatingIcon("rbxassetid://000000")
-- lib:SetAvatar("rbxassetid://000000")
-- lib:SetBrandIcon("rbxassetid://000000")
-- lib:SetPlayerName("New Player")
-- lib:Open()
-- lib:Close()