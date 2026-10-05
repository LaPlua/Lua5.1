-- 交互冒烟：面板 API + 全量事件触发（悬停气泡 / 右键菜单 / 点击 / 拖拽 / 按键）
local mine = {}
local function try(name, fn)
	local ok, err = pcall(fn)
	if not ok then mine[#mine + 1] = name .. " -> " .. tostring(err) end
end

local L = Aether.new({ Name = "SMOKE", Boot = false, Persist = false, Theme = "void" })
local pg = L:Page("冒烟", "home")
local tb = pg:Tab("面板", "layers")
local sc = tb:Section({ Title = "控件冒烟", Icon = "power" })
sc:Toggle({ Title = "T1", Flag = "smoke_t" })
sc:Slider({ Title = "S1", Min = 0, Max = 1, Step = 0.05, Default = 0.5, Flag = "smoke_s" })
sc:Dropdown({ Title = "D1", Options = { "a", "b" }, Default = 1 })
sc:Segmented({ Title = "G1", Options = { "x", "y" }, Default = 1 })
sc:Progress({ Title = "P1", Default = 0.3 })
sc:Graph({ Title = "H1", Source = "fps" })
sc:ColorPicker({ Title = "C1" })
sc:Keybind({ Title = "K1", Flag = "smoke_k" })
sc:Button({ Title = "B1", Callback = function() end })
sc:Label({ Title = "L1", Text = "ok" })
sc:Divider()
sc:Note({ Text = "note" })
L:Select(pg, tb)

try("Toggle(true)", function() L:Toggle(true) end)
try("Notify", function() L:Notify({ Title = "冒烟通知", Desc = "测试", Icon = "check" }) end)
try("Log", function() L:Log("冒烟日志", "accent") end)
try("SetTheme/neon", function() L:SetTheme("neon") end)
try("CycleTheme", function() L:CycleTheme() end)
try("SetTheme/void", function() L:SetTheme("void") end)
try("Palette", function() L:Palette() end)
try("Console", function() L:Console() end)
try("RadialOpen", function() L:RadialOpen() end)
try("RadialClose", function() L:RadialClose() end)
try("HudToggle", function() L:HudToggle() end)
try("HudToggle2", function() L:HudToggle() end)
try("ConsoleToggle", function() L:Console() end)
try("PaletteToggle", function() L:Palette() end)
try("Toggle(false)", function() L:Toggle(false) end)
try("Toggle(true)2", function() L:Toggle(true) end)

-- 打开各面板后再全量触发事件，覆盖更多代码路径
try("Palette2", function() L:Palette() end)
try("Console2", function() L:Console() end)
try("RadialOpen2", function() L:RadialOpen() end)

local fired = __fireEvents()
__FIRED = fired
for i = 1, #mine do __ERR[#__ERR + 1] = mine[i] end