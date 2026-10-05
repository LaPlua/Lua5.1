# AETHER UI · 以太界面框架 · 使用教程

> 版本 **1.0.0** ｜ 纯黑玻璃 + 霓虹描边 + HUD 卡尺的「设备化」Roblox UI 库
> 设计目标：把界面做成一台**有生命、会自检、可操控**的终端，而不是一堆静态方块。

---

## 目录

1. [它和普通 UI 库有什么不同](#1-它和普通-ui-库有什么不同)
2. [三分钟上手](#2-三分钟上手)
3. [Aether.new 配置项](#3-aethernew-配置项)
4. [界面结构：Page / Tab / Section](#4-界面结构page--tab--section)
5. [控件全表](#5-控件全表)
6. [图标名清单](#6-图标名清单)
7. [主题系统](#7-主题系统)
8. [通知与提示](#8-通知与提示)
9. [独有系统](#9-独有系统)
10. [公开 API 速查](#10-公开-api-速查)
11. [快捷键](#11-快捷键)
12. [配置持久化](#12-配置持久化)
13. [常见问题 / 兼容性](#13-常见问题--兼容性)

---

## 1. 它和普通 UI 库有什么不同

AETHER 不是「换个皮的开关集合」，它内置了一整套**系统的仪式感**：

| 系统 | 作用 |
| --- | --- |
| **Boot 开机自检** | 启动时逐行打字 + 进度条 + 能力探测，像设备冷启动 |
| **Palette 指令面板** | `Ctrl+K` 呼出，模糊搜索全库指令，回车直接触发 / 定位 |
| **Radial 环形菜单** | 按住 `ALT`，鼠标指向扇区选择「固定」的控件，松手触发 |
| **Telemetry 遥测 HUD** | 右上角浮窗实时显示 FPS / Ping 曲线、信号条、时钟 |
| **Console 内置 REPL** | `F8` 呼出，直接执行 Lua，彩色输出、历史记录 |
| **Config 持久化** | 主题、控件值、窗口位置自动落盘（执行器支持时） |
| **右键菜单** | 任意控件右键：重置 / 复制 / 固定到快捷栏 |

视觉细节全部是代码生成的矢量图形：**四角卡尺、扫描线、网格底纹、描边流光、标题乱码重组**，不依赖任何图片资源。

---

## 2. 三分钟上手

**第一步：加载库本体**

```lua
-- 方式一：执行器里直接 loadstring
local Aether = loadstring(game:HttpGet("你的 Aether.lua 原始链接"))()

-- 方式二：把 Aether.lua 源码粘贴执行后，直接使用全局 Aether
```

**第二步：创建实例并搭界面**

```lua
local lib = Aether.new({
    Name = "AETHER",     -- 顶栏标题 / 悬浮窗品牌名
    Theme = "void",      -- 初始主题
})

-- 左侧主侧边栏：一个「页面」
local page = lib:Page("作战", "target")

-- 顶部副侧边栏：页面下的「标签页」
local tab = page:Tab("基础", "power")

-- 内容卡片
local section = tab:Section({
    Title = "核心模块",
    Desc  = "运行时开关与状态",
    Icon  = "power",
})

-- 往卡片里放控件
section:Toggle({
    Title = "自动瞄准",
    Desc  = "锁定最近目标",
    Default = false,
    Flag  = "aimbot",
    Callback = function(v)
        lib:Notify({ Title = v and "已开启" or "已关闭", Icon = "target" })
    end,
})

lib:Select(page, tab)          -- 选中默认页
lib:Notify({ Title = "就绪", Desc = "Ctrl+K 指令面板" })
```

> 完整可运行示例见同目录 `Aether-Demo.lua`：先执行 `Aether.lua`，再执行 `Aether-Demo.lua`。

---

## 3. Aether.new 配置项

```lua
local lib = Aether.new({
    Name      = "AETHER",                        -- 品牌名（顶栏 + 悬浮窗 + 配置文件同名）
    Icon      = "https://xxx/logo.png",          -- 自定义图标：网络图片 URL（可选）
    Theme     = "void",                           -- 初始主题：void/neon/ember/arctic/mono
    Scale     = 1,                                -- 手动缩放；不填则按视口自适应(0.8~1.22)
    Boot      = true,                             -- 是否播放开机自检（false = 直接打开）
    Persist   = true,                             -- 是否启用配置持久化（false = 关闭）
    RadialKey = Enum.KeyCode.LeftAlt,             -- 环形菜单呼出键
})
```

**关于 `Icon`（自定义图标）**

- 传入图片 URL 后，库会异步下载 → 缓存到本地 → 应用到**主界面左上角 Logo** 和**悬浮窗图标**。
- 缓存文件名按 URL 哈希生成，同一张图只下载一次，存在 `Aether/` 文件夹内。
- 若执行器**缺少 `request` / `getcustomasset`** 或**下载失败**，会**静默回退**为「首字母徽标」，绝不报错、绝不卡界面。

---

## 4. 界面结构：Page / Tab / Section

```
主窗口
├── 左侧主侧边栏（Page：垂直排列，每个 Page 一个图标按钮）
│   └── 顶部副侧边栏（Tab：只显示当前 Page 自己的 Tab，横向可滑动）
│       └── 内容区
│           └── Section（卡片，可折叠 / 计数 / 右键菜单）
│               ├── Toggle / Slider / Dropdown …
│               └── Button / Label / Divider …
```

**层级链式调用：**

```lua
local page = lib:Page("页面名", "图标名")      -- 左侧主侧边栏
local tab  = page:Tab("标签名", "图标名")      -- 顶部副侧边栏（属于该 Page）
local sec  = tab:Section({ Title="卡片名", Desc="描述", Icon="图标名", Collapsed=false })
```

**说明**

- **每个 Page 拥有自己独立的 Tab 集合**，切换 Page 时副侧边栏自动换成该 Page 的 Tab。
- 副侧边栏数量多时**横向滑动**，不占纵向空间。
- `Section` 支持折叠：点击卡片头部折叠/展开，标题会有「乱码重组」动画。

**其他卡片级用法：**

```lua
sec:SetCollapsed(true)     -- 折叠卡片
sec:Pulse(row)             -- 让某一行闪一下高亮（一般配合指令面板跳转）
local item = sec:Toggle({...})   -- 所有控件都会返回 item
item:Set(true)             -- 代码里改值（不触发 Callback 之外的连锁）
local v = item:Get()       -- 读取当前值
```

---

## 5. 控件全表

所有控件都支持通用字段：`Title`、`Desc`、`Flag`（用于持久化 + `Aether.Flags[Flag]` 读取）、`Callback`、`RightClick=false`（关掉该控件右键菜单）。

### Toggle 开关

```lua
sec:Toggle({ Title="自动瞄准", Desc="锁定最近目标", Default=false, Flag="aimbot",
    Callback=function(v) print(v) end })
```

### Slider 滑条

```lua
sec:Slider({
    Title = "瞄准阻尼", Desc = "0.05 - 1.00",
    Min = 0.05, Max = 1, Step = 0.05, Default = 0.35,
    Suffix = "x",                       -- 数值后缀
    Format = function(v) return v.."x" end,  -- 或完全自定义显示（优先于 Suffix）
    Flag = "smooth",
    Callback = function(v) end,
})
```
> 支持拖动、滚轮微调；拖动时显示数值气泡。

### Segmented 分段选择

```lua
sec:Segmented({ Title="锁定部位", Options={"头部","躯干","最近"}, Default=1, Flag="part",
    Callback=function(text, index) end })   -- 回调返回 (选项文本, 索引)
```

### Dropdown 下拉（单选 / 多选）

```lua
-- 单选
sec:Dropdown({ Title="绘制层", Options={"骨架","方框","信息"}, Default=1, Flag="layer",
    Callback=function(text) end })

-- 多选（Multi=true，Get 返回布尔表）
sec:Dropdown({ Title="绘制层", Options={"骨架","方框","信息","全部"},
    Multi=true, Default={true,true,false,true}, Flag="layers",
    Callback=function(selTable) end })
```

### Keybind 按键绑定

```lua
sec:Keybind({ Title="主功能热键", Desc="点击后按下任意按键", Default=Enum.KeyCode.RightShift,
    Flag="mainkey",
    Callback=function(key) print(key.Name) end })
```
> 点击进入录制，支持 Shift/Ctrl/Alt 组合；按 `Esc` 清空。载入配置后热键会自动重新注册。

### Input 输入框

```lua
sec:Input({ Title="水印文字", Placeholder="输入…", Default="AETHER", Flag="watermark",
    Callback=function(text) end, OnSubmit=function(text) end })   -- OnSubmit 仅回车时触发

-- 数值输入（自动取整/夹取）
sec:Input({ Title="人数", Numeric=true, Min=1, Max=64, Step=1, Flag="count" })
```

### Button 按钮

```lua
sec:Button({ Title="下一个主题", Desc="循环切换", Icon="palette",
    Variant="primary",                       -- primary / ghost / danger
    OnClick=function() lib:CycleTheme() end })

-- 也可以在 title 外单独指定按钮文字
sec:Button({ Title="说明文案", Text="点击执行", OnClick=function() end })
```

### Label 标签 / 数值显示

```lua
local lb = sec:Label({ Title="客户端", Text="AETHER v1.0.0" })
lb:Set("新文本")     -- 动态更新
```

### Progress 进度条

```lua
local pg = sec:Progress({ Title="模型加载", Default=0.62 })
pg:Set(0.8)          -- 0~1
pg:Set("sweep")      -- 无限扫动（不确定进度动画）
```

### Graph 实时曲线

```lua
-- 绑定内置遥测
sec:Graph({ Title="实时帧率", Source="fps" })    -- Source 可为 "fps" 或 "ping"

-- 手动推数据
local g = sec:Graph({ Title="自定义曲线" })
g:Push(123)
```

### ColorPicker 取色器

```lua
sec:ColorPicker({ Title="描边颜色", Default=Color3.fromRGB(0,226,255), Flag="edgecol",
    Callback=function(color) end })
```

### Divider 分隔线 / Note 说明块

```lua
sec:Divider()
sec:Note({ Text="遥测数据每 0.5s 采样一次；HUD 可在右上角拖动。" })
```

---

## 6. 图标名清单

控件、页面、标签的 `Icon` 字段**只接受下列名称**（内置矢量图标，无需图片）：

```
dot  diamond  ring  cross  target  shield  eye  bolt  layers  gear
user  terminal  key  clock  chip  search  close  check  chevron  down
plus  more  wifi  grid  folder  globe  wave  palette  home  expand
lock  scan  power
```

> 想要自定义图片图标，请使用 `Aether.new({ Icon = "URL" })`（作用于窗口 Logo 与悬浮窗），而不是控件的 `Icon` 字段。

---

## 7. 主题系统

内置 5 套主题：

| 名称 | 风格 |
| --- | --- |
| `void` | 深空黑 + 青蓝霓虹（默认） |
| `neon` | 紫黑 + 品红霓虹 |
| `ember` | 暗褐 + 熔橙 |
| `arctic` | 冷灰蓝 + 冰蓝 |
| `mono` | 纯黑白 |

```lua
lib:SetTheme("neon")     -- 切换主题（全界面 0.35s 平滑过渡）
lib:CycleTheme()         -- 按字母顺序循环切换
```

切主题时，所有注册过主题绑定的实例（卡片、描边、文字、控件）会**平滑染色**，不是生硬跳变。

---

## 8. 通知与提示

```lua
lib:Notify({
    Title    = "自动瞄准 已开启",
    Desc     = "右下角堆叠卡片",
    Icon     = "target",        -- 图标名
    Kind     = "warn",          -- 可选：默认 / "warn" 黄 / "bad" 红
    Color    = Color3.fromRGB(255,0,0),  -- 可选：直接指定强调色（优先于 Kind）
    Duration = 4.2,             -- 秒；默认 4.2
})
```

- 通知从右侧滑入，**自动堆叠**，进度条走完或点击即消失。
- 鼠标悬停在顶栏按钮上会显示**浮动提示**（tooltip）。

---

## 9. 独有系统

### 9.1 指令面板 Palette（`Ctrl+K`）

- 模糊搜索**全库指令**：所有控件、页面切换、主题切换等。
- 支持键盘 `↑/↓` 选择、`Enter` 执行、`Esc` 关闭。
- 执行后会**自动跳转到对应页面/标签/卡片**并高亮该行（`_Reveal` + `Pulse`）。

```lua
lib:Palette()          -- 代码呼出
```

### 9.2 内置控制台 Console（`F8`）

```lua
lib:Console()                       -- 呼出控制台
lib:ConsoleRun("print(1+1)")        -- 直接执行一段 Lua
lib:Log("来自脚本的日志", "ok")      -- 写一行彩色输出（kind: ok/err/warn/accent）
```
> 控制台支持历史记录（`↑/↓`），执行结果与报错彩色区分。

### 9.3 环形放射菜单 Radial（按住 `ALT`）

- 按住 `Alt` 呼出，鼠标指向扇区选择，**松手触发**。
- 菜单项来自「固定到快捷栏」的控件：在任意控件上**右键 → 固定到快捷栏**。
- 也可代码固定：

```lua
lib:Pinned(item)          -- item 是控件创建时的返回值
lib:RadialOpen()          -- 代码强制呼出
lib:RadialClose()         -- 代码关闭
```

### 9.4 遥测 HUD Telemetry

- 右上角浮窗：FPS 大数字 + 迷你折线 + Ping + 信号条 + 时钟。
- **可拖动**，会自动吸附在屏幕内。

```lua
lib:HudToggle()           -- 显示 / 隐藏 HUD
```

### 9.5 右键菜单（任意控件）

控件上点右键即可：

- **重置为默认**
- **复制当前值**（到剪贴板）
- **固定到快捷栏**

卡片头部右键还可以「折叠 / 展开」「复制卡片标题」。

### 9.6 开机自检 Boot

启动时播放逐行打字 + 进度条 + 能力探测（打印检测到的执行器能力）：

```lua
Aether.new({ Boot = true })     -- 默认开启
Aether.new({ Boot = false })    -- 跳过，直接打开主界面
```

### 9.7 悬浮窗 Launcher

- 屏幕**顶端居中**的纯黑胶囊条，白描边，始终可见。
- 文字随主界面状态切换：主界面打开时显示 `CLOSE`，关闭时显示 `OPEN`。
- 状态点带呼吸动画，颜色随开 / 关变化。
- **可拖动**，位置会被持久化。

### 9.8 主界面开关

```lua
lib:Toggle()          -- 切换
lib:Toggle(true)      -- 强制打开
lib:Toggle(false)     -- 强制收起
```

---

## 10. 公开 API 速查

| API | 说明 |
| --- | --- |
| `Aether.new(cfg)` | 创建实例 |
| `lib:Page(title, icon)` | 新建页面（左侧主侧边栏） |
| `page:Tab(title, icon)` | 新建标签页（顶部副侧边栏） |
| `tab:Section(cfg)` | 新建卡片 |
| `sec:Toggle/Slider/Segmented/Dropdown/Keybind/Input/Button/Label/Progress/Graph/ColorPicker/Divider/Note(cfg)` | 各类控件，返回 `item` |
| `item:Set(v)` / `item:Get()` | 读写控件值 |
| `sec:SetCollapsed(bool)` / `sec:Pulse(row)` | 折叠 / 高亮 |
| `lib:Select(page, tab)` | 切换页面与标签 |
| `lib:Toggle(force)` | 打开 / 收起主界面 |
| `lib:Notify(cfg)` | 发送通知 |
| `lib:SetTheme(name)` / `lib:CycleTheme()` | 主题切换 |
| `lib:Palette()` | 呼出指令面板 |
| `lib:Console()` / `lib:ConsoleRun(code)` / `lib:Log(text, kind)` | 控制台 |
| `lib:RadialOpen()` / `lib:RadialClose()` / `lib:Pinned(item)` | 环形菜单 |
| `lib:HudToggle()` | 遥测 HUD 开关 |
| `Aether.Flags[flag]` | 按 `Flag` 读取所有控件当前值 |
| `Aether.Version` | 版本号 |

---

## 11. 快捷键

| 按键 | 功能 |
| --- | --- |
| `Ctrl + K` | 指令面板 |
| `F8` | 控制台 |
| `F2` | 打开 / 收起主界面 |
| `Alt`（可自定义） | 按住呼出环形菜单 |
| `Esc` | 关闭指令面板 / 控制台 / 键位录制 |
| `↑ / ↓` | 指令面板、控制台历史导航 |

---

## 12. 配置持久化

- 触发保存的时机：修改控件、切换主题、拖动窗口、拖动 HUD。
- 保存内容：**主题名 + 所有带 `Flag` 的控件值 + 窗口位置**。
- 存储位置：`Aether/<Name>.cfg`（`Name` 取自 `Aether.new`）。
- 读取：下次创建实例时自动回填，控件状态、按键热键全部恢复。

```lua
Aether.new({ Persist = false })     -- 不想落盘时关闭
```

> 执行器缺少 `writefile / readfile / isfile` 时，持久化自动禁用，不影响其它功能。

---

## 13. 常见问题 / 兼容性

**Q：执行器报「未知错误」？**
A：本库所有执行器专有能力（`request`、`getcustomasset`、`writefile`、`loadstring`、`gethui`）均做**能力探测**，缺失即降级，不会因此报错。若仍报错，请确认加载的是完整 `Aether.lua`。

**Q：左上角图标不显示图片？**
A：说明当前执行器不支持 `request` / `getcustomasset`，或图片下载失败。此时会自动显示**首字母徽标**（这是设计内的降级行为，不是 bug）。

**Q：字体发糊？**
A：本库刻意**不使用 `CanvasGroup`**（那会把子树渲染成纹理再缩放，导致文字发糊），淡入淡出用同色遮罩实现，正文保持矢量清晰。

**Q：内容超出窗口？**
A：主窗口已开启 `ClipsDescendants`，任何子元素都被硬裁剪在窗口矩形内。

**Q：界面太小 / 太大？**
A：默认按视口自适应（限制在 `0.8 ~ 1.22`）。需要固定可传 `Scale = 1`。

**Q：怎么调试控件值？**
A：`Ctrl+K` 搜到控件回车定位，`F8` 控制台里直接 `print(Aether.Flags["你的Flag"])`。

---

> **AETHER · 以太界面框架** — 「把界面做成一台会呼吸的设备。」