# Nova UI 使用教程

> 版本 1.5.1 · 兼容 Lua 5.1 / Roblox Luau · 黑白配色 · 自适应分辨率

---

## 目录

1. [文件说明与加载方式](#1-文件说明与加载方式)
2. [快速开始（最小可运行示例）](#2-快速开始最小可运行示例)
3. [层级结构](#3-层级结构)
4. [初始化配置 `Nova.new`](#4-初始化配置-novanew)
5. [主侧边栏 / 副侧边栏](#5-主侧边栏--副侧边栏)
6. [分组 Section](#6-分组-section)
7. [控件详解](#7-控件详解)
8. [标志系统 Flags](#8-标志系统-flags)
9. [图标与图片自定义](#9-图标与图片自定义)
10. [通知 Notify](#10-通知-notify)
11. [运行时窗口控制 API](#11-运行时窗口控制-api)
12. [内置图标名列表](#12-内置图标名列表)
13. [主题自定义](#13-主题自定义)
14. [完整示例](#14-完整示例)
15. [常见问题](#15-常见问题)

---

## 1. 文件说明与加载方式

| 文件 | 作用 |
| --- | --- |
| `NovaUI.lua` | 纯 UI 库本体，末尾 `return Nova`，供其他脚本 require |
| `NovaUI-Demo.lua` | 库 + 演示界面（自包含），直接粘贴执行即可看到完整效果 |

**方式 A：单文件直接执行（推荐新手）**

把 `NovaUI-Demo.lua` 全部内容粘贴进执行器运行即可。

**方式 B：拆分使用**

`NovaUI.lua` 末尾有 `return Nova`，可以这样接：

```lua
-- 本地文件方式
local Nova = loadstring(readfile("NovaUI.lua"))()

-- 或者把库源码字符串化后加载
local Nova = loadstring(game:HttpGet("https://你的地址/NovaUI.lua"))()
```

拿到 `Nova` 后按第 2 节的写法建界面。

---

## 2. 快速开始（最小可运行示例）

```lua
local Nova = loadstring(readfile("NovaUI.lua"))()

local win = Nova.new({
    Title    = "NOVA",
    Subtitle = "Interface Suite",
    Brand    = "Lev Hub",
    StartOpen = true,
})

-- 主侧边栏
local combat = win:Primary("Combat", "shield")
-- 副侧边栏（属于 Combat）
local main = combat:Secondary("Main", "settings")
-- 分组
local sec = main:Section("General")
-- 控件
sec:Toggle({
    Title   = "Enable",
    Desc    = "开启总开关",
    Default = false,
    Callback = function(v)
        print("toggle ->", v)
    end,
})
```

---

## 3. 层级结构

```
Nova.new(config)            → 窗口对象 win
└── win:Primary(name, icon)         主侧边栏（左侧竖排，可上下滑动）
    └── primary:Secondary(name, icon)  副侧边栏（顶排单行标签，可左右滑动）
        └── secondary:Section(title)   分组卡片
            └── section:Toggle/Slider/...  控件
```

- **一个主侧边栏可以挂多个副侧边栏**，每个主栏只显示自己那组副标签，切换主栏时自动切换对应副栏。
- 分组卡片会自动分栏（由 `Columns` 决定列数），并按添加顺序排列。

---

## 4. 初始化配置 `Nova.new`

`Nova.new(cfg)` 返回窗口对象。所有字段都可省略，省略时用下方默认值。

| 参数 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `Title` | string | `"Nova"` | 窗口标题 |
| `Subtitle` | string | `""` | 标题下副标题 |
| `Brand` | string | `"Lev Hub"` | 悬浮胶囊上显示的品牌名 |
| `Icon` | string / nil | `nil` | 品牌图。支持三种写法：网络图片 URL、`rbxassetid://xxx`、内置图标名。悬浮徽标 + 左上角 logo 共用 |
| `FloatingIcon` | string / nil | `nil` | 只给悬浮胶囊单独用图，留空则跟 `Icon` 走 |
| `FloatLetter` | string / nil | `nil` | 取不到品牌图时，悬浮徽标显示的字母（默认取品牌名首字母） |
| `PlayerName` | string / nil | `nil` | 左上角玩家名，默认取 Roblox 显示名 |
| `PlayerSubtitle` | string | `"Premium Edition"` | 玩家名下方小字 |
| `Avatar` | string / nil | `nil` | 玩家头像，默认取 Roblox 头像；可传 URL / `rbxassetid://` |
| `Accent` | Color3 | 白 `(255,255,255)` | 主强调色 |
| `Accent2` | Color3 | 浅灰 `(178,178,186)` | 渐变尾色 |
| `ToggleKey` | Enum.KeyCode | `RightShift` | 显示 / 隐藏窗口的快捷键 |
| `Columns` | number | `2` | 分组卡片分栏列数 |
| `Width` | number | `1060` | 基准宽（实际会按设备视口自适应缩放） |
| `Height` | number | `660` | 基准高 |
| `MinScale` | number | `0.60` | 缩放下限 |
| `MaxScale` | number | `1.40` | 缩放上限 |
| `StartOpen` | boolean | `true` | 是否启动即展开主界面 |

示例：

```lua
local win = Nova.new({
    Title          = "NOVA",
    Subtitle       = "Interface Suite",
    Brand          = "Lev Hub",
    Icon           = "https://example.com/logo.png",  -- 网络图，下载一次即缓存
    FloatLetter    = "L",
    PlayerName     = "Past Owl",
    PlayerSubtitle = "Till: 1 mar 2026",
    ToggleKey      = Enum.KeyCode.RightShift,
    Columns        = 2,
    StartOpen      = true,
})
```

---

## 5. 主侧边栏 / 副侧边栏

### 5.1 主侧边栏 `win:Primary(name, iconName)`

| 参数 | 说明 |
| --- | --- |
| `name` | 主栏名字（也用作悬浮提示文字） |
| `iconName` | 图标，内置图标名或 `rbxassetid://`，可省略 |

```lua
local combat  = win:Primary("Combat", "shield")
local visuals = win:Primary("Visuals", "eye")
local aim     = win:Primary("Aim", "target")
```

**返回值**：主栏对象（`PrimaryPane`）。

### 5.2 副侧边栏 `primary:Secondary(name, iconName)`

挂在某个主栏下。**一个主栏可以建多个副栏**，它们排成顶部一行，可左右滑动。

```lua
local sMain    = combat:Secondary("Main", "settings")
local sTarget  = combat:Secondary("Targeting", "target")
local sTrigger = combat:Secondary("Trigger", "bolt")
```

**返回值**：副栏对象（`SecondaryPane`）。

### 5.3 主栏额外方法

| 方法 | 说明 |
| --- | --- |
| `primary:Select()` | 以代码方式选中该主栏 |
| `primary:SelectSecondary(index)` | 选中该主栏下第 `index` 个副栏 |

```lua
combat:SelectSecondary(2)
```

| 副栏方法 | 说明 |
| --- | --- |
| `secondary:Select()` | 以代码方式选中该副栏 |
| `secondary:Filter(query)` | 按关键字过滤该副栏内的控件（窗口顶部搜索框会自动调用） |

---

## 6. 分组 Section

`secondary:Section(title)` 创建一个分组卡片，返回分组对象。

```lua
local general = sMain:Section("General settings")
local params  = sMain:Section("Parameters")
```

所有控件都挂在分组对象上，按调用顺序从上到下排列。

---

## 7. 控件详解

> 通用字段（几乎每个控件都支持）：
> - `Title`：主标题文字
> - `Desc`：副描述小字（可省略）
> - `Flag`：标志名，交给 [Flags](#8-标志系统-flags) 系统
> - `Callback`：值变化 / 点击时的回调函数

### 7.1 Toggle 开关

```lua
local t = sec:Toggle({
    Title    = "Enable feature",
    Desc     = "开启后生效",
    Default  = false,
    Flag     = "Feature",
    Callback = function(v) print("now:", v) end,
    -- Menu：右侧「⋮」弹出菜单（可选）
    Menu = {
        { Name = "重置", Callback = function() t:Set(false, true) end },
        { Name = "说明", Callback = function() win:Notify({ Title = "说明", Desc = "..." }) end },
    },
})
```

| 字段 | 说明 |
| --- | --- |
| `Default` | 初始状态，`true` / `false` |
| `Menu` | 可选。数组，每项 `{ Name = "文字", Callback = function() end }`，`Selected = true` 可让某项高亮 |

**返回对象**：

| 成员 | 说明 |
| --- | --- |
| `t.Value` | 当前布尔值 |
| `t:Set(v, fire)` | 设置值；`fire = true` 时触发 `Callback` |

### 7.2 Slider 滑块

```lua
local s = sec:Slider({
    Title    = "FOV radius",
    Desc     = "检测半径",
    Min      = 10,
    Max      = 500,
    Step     = 5,
    Default  = 120,
    Suffix   = "°",                             -- 数值后缀
    Format   = function(v) return v .. " deg" end, -- 完全自定义显示（优先级高于 Suffix）
    Flag     = "FOV",
    Callback = function(v) print(v) end,
})
```

| 字段 | 默认 | 说明 |
| --- | --- | --- |
| `Min` / `Max` | `0` / `100` | 范围（`Max <= Min` 时自动修正） |
| `Step` | `1` | 步长，`Step < 1` 时显示一位小数 |
| `Default` | `Min` | 初始值 |
| `Suffix` | `""` | 数值后缀，如 `"%"`、`"ms"` |
| `Format` | — | `function(value) -> string`，自定义显示文案 |

**返回对象**：

| 成员 | 说明 |
| --- | --- |
| `s.Value` | 当前数值（已按步长对齐） |
| `s:Set(v, fire)` | 设置值 |
| `s:Render()` | 仅重绘（一般不需要手动调） |

### 7.3 Dropdown 下拉框

```lua
local d = sec:Dropdown({
    Title    = "Priority",
    Desc     = "目标优先级",
    Options  = { "Distance", "Health", "Angle" },
    Default  = "Distance",
    Flag     = "Prio",
    Callback = function(v) print(v) end,
})
```

**返回对象**：

| 成员 | 说明 |
| --- | --- |
| `d.Value` | 当前选中项 |
| `d:Set(v, fire)` | 设置选中项 |

### 7.4 Button 按钮

```lua
local btn = sec:Button({
    Title    = "Apply",
    Desc     = "应用设置",
    Text     = "Execute",          -- 按钮上的文字，默认 "Execute"
    Callback = function() print("clicked") end,
})
```

**返回值**：按钮本体（`TextButton`），可自行改属性。
注意：Button **没有** `Flag`。

### 7.5 Label 文本

```lua
sec:Label({
    Text = "以下功能处于实验阶段，可能不稳定。",
    Desc = "Experimental features",   -- 可选说明
})
```

**返回值**：`TextLabel`，支持自动换行、自动高度。

### 7.6 Divider 分割线

```lua
sec:Divider()
```

**返回值**：分割线 `Frame`。

### 7.7 Keybind 按键绑定

```lua
local kb = sec:Keybind({
    Title    = "Hold key",
    Desc     = "触发按键",
    Default  = Enum.KeyCode.E,
    Callback = function(key) print("bound:", key) end,
})
```

| 成员 | 说明 |
| --- | --- |
| `kb.Value` | 当前绑定的 `Enum.KeyCode` |
| `kb.Listening` | 是否正在监听按键 |
| `kb:Set(key, fire)` | 直接设置绑定键（如 `Enum.KeyCode.Q`） |

点击控件后显示 “Press a key...”，按下想要的键即完成绑定。

### 7.8 Input 输入框

```lua
local inp = sec:Input({
    Title       = "Config name",
    Desc        = "配置名",
    Default     = "",
    Placeholder = "my-config",
    Callback    = function(text) print("input:", text) end,  -- 失焦时触发
})
```

| 成员 | 说明 |
| --- | --- |
| `inp.Value` | 当前文本 |
| `inp:Set(v)` | 直接写入文本 |

`Callback` 在输入框失去焦点时触发。

---

## 8. 标志系统 Flags

`Nova.Flags` 是一个全局表。给控件传 `Flag = "名字"` 后，用同一个名字即可读取值：

```lua
sec:Toggle({ Title = "Auto", Flag = "AutoFire", Default = true })
sec:Slider({ Title = "Speed", Flag = "Speed", Min = 1, Max = 100, Default = 16 })

print(Nova.Flags.AutoFire)  -- true
print(Nova.Flags.Speed)     -- 16
```

说明：
- 创建时写入初始值；用户交互（点击 / 拖动 / 选择）时会实时同步。
- 支持 `Flag` 的控件：**Toggle、Slider、Dropdown**。

---

## 9. 图标与图片自定义

### 9.1 三处可自定义的图

| 位置 | 配置项 | 运行时修改 |
| --- | --- | --- |
| 悬浮胶囊徽标 + 左上角 logo | `Icon` | `win:SetIcon(v)` |
| 仅悬浮胶囊 | `FloatingIcon` | `win:SetFloatingIcon(v)` |
| 玩家头像 | `Avatar` | `win:SetAvatar(v)` |
| 悬浮徽标回退字母 | `FloatLetter` | `win:SetFloatLetter(v)` |

### 9.2 取值写法（三种都行）

```lua
Icon = "https://example.com/logo.png"   -- 网络图片：下载一次后本地缓存
Icon = "rbxassetid://1234567890"        -- Roblox 资源 ID
Icon = "shield"                         -- 内置矢量图标名（见第 12 节）
Icon = nil                              -- 不设置，用字母徽标
```

**网络图片的完整流程**（库内自动完成）：
1. 首次用到时下载 → 写入 `NovaUI/assets/` 缓存目录（文件名由 URL 哈希生成，避免重复下载）；
2. 之后直接读本地缓存；
3. 若执行器缺少 `request` / `writefile` / `getcustomasset`，或下载失败 → **自动回退到字母徽标**，不报错、不卡界面。

### 9.3 运行时切换

```lua
win:SetIcon("https://example.com/new-logo.png")
win:SetFloatingIcon("bolt")
win:SetAvatar("https://example.com/avatar.png")
win:SetFloatLetter("N")
win:SetBrand("Lev Hub")
win:SetPlayerName("Past Owl")
win:SetPlayerSubtitle("Till: 1 mar 2026")
```

---

## 10. 通知 Notify

```lua
win:Notify({
    Title    = "Config",
    Desc     = "已保存",
    Icon     = "check",                  -- 内置图标名，默认 "info"
    Color    = nil,                      -- 强调色，默认用主题 Accent
    Duration = 2,                        -- 自动关闭秒数，默认 4
})
```

- 通知从左上角滑入，底部有进度条；
- 点击通知可立即关闭；
- `Duration` 秒后自动关闭；
- 返回通知卡片对象。

---

## 11. 运行时窗口控制 API

| 方法 | 说明 |
| --- | --- |
| `win:Open()` | 展开主界面 |
| `win:Close()` | 收起主界面（悬浮胶囊仍在） |
| `win:Toggle()` | 展开 / 收起切换 |
| `win:IsOpen()` | 返回当前是否展开 |
| `win:Destroy()` | 销毁整个 UI 并断开所有连接 |
| `win:Notify(cfg)` | 发通知，见第 10 节 |
| `win:SetIcon(v)` / `SetFloatingIcon(v)` / `SetAvatar(v)` / `SetFloatLetter(v)` / `SetBrand(v)` / `SetPlayerName(v)` / `SetPlayerSubtitle(v)` | 运行时修改外观 |

```lua
-- 常用组合
win:Notify({ Title = "Ready", Desc = "已加载完成", Icon = "power", Duration = 3 })
task.delay(5, function() win:Close() end)
```

---

## 12. 内置图标名列表

全部用 Frame / UIStroke 现场绘制，不依赖字体与 emoji，任何分辨率都清晰。可直接作为 `iconName` / `Notify.Icon` / `Icon` 使用：

```
default, shield, eye, target, hand, cursor, folder, settings, sliders,
layers, search, close, minimize, check, chevron, chevronRight, dot,
more, star, bolt, lock, user, code, link, refresh, clock, flag, plus,
palette, info, warn, power, home, grid
```

用法示例：

```lua
local players = win:Primary("Player", "hand")
win:Notify({ Title = "Warn", Icon = "warn" })
win:SetFloatingIcon("bolt")
```

---

## 13. 主题自定义

主题表是 `Nova.Theme`（全局，所有窗口共用）。可在 `Nova.new` 之前改：

```lua
Nova.Theme.Bad  = Color3.fromRGB(255, 80, 90)   -- 覆盖某个颜色
Nova.Theme.Good = Color3.fromRGB(90, 230, 150)
```

常用字段：

| 字段 | 说明 |
| --- | --- |
| `Window` `Sidebar` `Header` `Panel` `Card` `CardHover` `Element` `ElementHover` | 各层背景色 |
| `Ink` | 白色块上的深色内容 |
| `Stroke` / `StrokeT` / `StrokeT2` | 描边色与透明度 |
| `Text` / `TextDim` / `TextMuted` | 三级文字色 |
| `Good` `Warn` `Bad` | 状态色 |

主强调色建议通过 `Nova.new({ Accent = ..., Accent2 = ... })` 传，会覆盖主题里的对应项。

---

## 14. 完整示例

```lua
local Nova = loadstring(readfile("NovaUI.lua"))()

local win = Nova.new({
    Title    = "NOVA",
    Subtitle = "Interface Suite",
    Brand    = "Lev Hub",
    Icon     = "",                 -- 留空用字母徽标；也可填网络图 / rbxassetid / 图标名
    FloatLetter = "L",
    Columns  = 2,
    ToggleKey = Enum.KeyCode.RightShift,
    StartOpen = true,
})

--============ 主栏 ============
local combat  = win:Primary("Combat", "shield")
local visuals = win:Primary("Visuals", "eye")
local setting = win:Primary("Settings", "settings")

--============ 副栏 ============
local sMain   = combat:Secondary("Main", "settings")
local sTarget = combat:Secondary("Targeting", "target")
local vRender = visuals:Secondary("Render", "eye")
local stGen   = setting:Secondary("General", "settings")

--============ Combat / Main ============
local general = sMain:Section("General settings")
general:Toggle({
    Title    = "Enable combat",
    Desc     = "总开关",
    Default  = false,
    Flag     = "Combat",
    Callback = function(v)
        win:Notify({ Title = "Combat", Desc = v and "已开启" or "已关闭", Icon = "power", Duration = 2 })
    end,
})

local params = sMain:Section("Parameters")
params:Dropdown({
    Title   = "Mode",
    Options = { "Balanced", "Aggressive", "Stealth" },
    Default = "Balanced",
    Flag    = "Mode",
})
params:Slider({
    Title   = "Sensitivity",
    Min     = 0, Max = 100, Step = 1, Default = 50,
    Suffix  = "%",
    Flag    = "Sens",
    Callback = function(v) print("sens:", v) end,
})

--============ Combat / Targeting ============
local targeting = sTarget:Section("Targeting & Detection")
targeting:Toggle({ Title = "Enable targeting", Desc = "锁定最近目标", Default = false })
targeting:Slider({ Title = "FOV radius", Desc = "检测半径", Min = 10, Max = 500, Step = 5, Default = 120, Suffix = "°" })
targeting:Divider()
targeting:Button({
    Title    = "Refresh list",
    Text     = "Refresh",
    Callback = function() win:Notify({ Title = "Done", Desc = "列表已刷新", Icon = "refresh" }) end,
})

--============ Visuals / Render ============
local vr = vRender:Section("Render options")
vr:Toggle({ Title = "Player highlights", Desc = "高亮玩家", Default = true })
vr:Slider({ Title = "Opacity", Min = 0, Max = 100, Step = 1, Default = 65, Suffix = "%" })
vr:Label({ Text = "部分视觉效果在低配设备上可能影响帧率。" })

--============ Settings / General ============
local gSec = stGen:Section("Interface")
gSec:Keybind({ Title = "Menu key", Desc = "呼出菜单", Default = Enum.KeyCode.RightShift })
gSec:Input({
    Title       = "Config name",
    Placeholder = "my-config",
    Callback    = function(v) print("[config]", v) end,
})
gSec:Button({
    Title    = "Save config",
    Text     = "Save",
    Callback = function()
        win:Notify({ Title = "Config", Desc = "已保存", Icon = "check", Duration = 2 })
    end,
})

--============ 默认选中 ============
combat:Select()
```

---

## 15. 常见问题

**Q：主界面在不同设备上尺寸不对？**
库已根据视口自动计算缩放（受 `MinScale` / `MaxScale` 限制）。只需按比例改 `Width` / `Height` 基准值即可，不要写死像素。

**Q：悬浮窗在深色场景里看不见？**
悬浮胶囊是纯黑底 + 白描边，默认停在屏幕正中顶端，可拖动。若被其他 UI 遮住，检查是否有更高 `DisplayOrder` 的 ScreenGui。

**Q：网络图标没显示？**
执行器需支持 `request`（或 `HttpGet`）/ `writefile` / `getcustomasset`。任一缺失或下载失败会自动回退字母徽标。可用 `win:SetFloatLetter("L")` 指定回退字母。

**Q：切换主栏后副栏内容不对？**
副栏是挂在该主栏下的，切换主栏会自动切回它自己的第一个副栏。用 `primary:SelectSecondary(index)` 可指定默认副栏。

**Q：搜索框过滤的是全部内容吗？**
只过滤**当前副栏**内的控件，匹配 `Title` 和 `Desc`。

**Q：想彻底移除 UI？**

```lua
win:Destroy()
```

---

> 提示：不确定某个控件支持哪些字段时，对照第 7 节对应控件的表格即可，字段名与本教程一致。