# 星穹 Celest 使用教程

> 版本 1.0.0 · 兼容 Lua 5.1 / Roblox Luau · 深空冷紫 · 无窗体星图 · 电脑 + 手机通用

---

## 目录

1. [文件说明与加载方式](#1-文件说明与加载方式)
2. [快速开始（最小可运行示例）](#2-快速开始最小可运行示例)
3. [交互方式](#3-交互方式)
4. [初始化配置 `Celest.new`](#4-初始化配置-celestnew)
5. [分类 Category](#5-分类-category)
6. [控件详解](#6-控件详解)
7. [星图布局与环](#7-星图布局与环)
8. [运行时控制 API](#8-运行时控制-api)
9. [主题自定义](#9-主题自定义)
10. [完整示例](#10-完整示例)
11. [常见问题](#11-常见问题)

---

## 1. 文件说明与加载方式

| 文件 | 作用 |
| --- | --- |
| `Celest.lua` | 纯 UI 库本体，末尾 `return Celest`，供其他脚本加载 |
| `Celest-Example.lua` | 完整注释示例，从远程加载库本体（推荐照着改） |
| `Celest-Demo.lua` | 库 + 演示界面，直接运行即可看到效果 |
| `Celest-Standalone.lua` | 不依赖任何库的独立单文件示例 |

**方式 A：远程加载库（推荐）**

```lua
local Celest = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/LaPlua/Lua5.1/main/Celest.lua"))()
```

**方式 B：本地文件**

```lua
local Celest = loadstring(readfile("Celest.lua"))()
```

拿到 `Celest` 后按第 2 节建界面即可。

---

## 2. 快速开始（最小可运行示例）

```lua
local Celest = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/LaPlua/Lua5.1/main/Celest.lua"))()

local win = Celest.new({
	title    = "星 穹",
	subtitle = "C E L E S T",
})

local combat = win:Category("兵戈", "✦")
combat:Toggle("自动瞄准", false, function(on) print("自动瞄准", on) end)
combat:Slider("视野半径", 0, 100, 50, function(v) print("半径", v) end)
combat:Button("执行一次", function() print("bang") end)
```

运行后：电脑按住 `ALT` 呼出星图，手机点右下角常驻星点呼出。

---

## 3. 交互方式

| 操作 | 电脑 | 手机 |
| --- | --- | --- |
| 呼出星图 | 按住 `ALT`（松手归寂）；点右下角星点可钉住常亮 | 点右下角常驻星点（再点归寂） |
| 切换分类 | 点内环的类别星点 | 同左 |
| 开关功能 | 点功能星 | 同左 |
| 调数值 | **先单击选中数值星，再按住左右拖动** | 选中后按住左右拖 |
| 搜索 | `CTRL` + `K`（低语面板），或点左上「⌕ 低语」 | 点左上「⌕ 低语」 |
| 关闭搜索 | `ESC` | 点结果外区域 |

右上角的「星痕」会实时显示当前所有亮起的开关名，鼠标悬停可展开完整列表。

---

## 4. 初始化配置 `Celest.new`

`Celest.new(cfg)` 返回窗口对象。所有字段均可省略。

| 参数 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `title` | string | `"星 穹"` | 左上角标题 |
| `subtitle` | string | `"C E L E S T"` | 标题下方小字 |
| `hint` | string | 自动 | 左下角操作提示文字（不传按设备自动生成） |
| `accent` | Color3 | 冷紫 | 一键换强调色（同时作用于强调色、渐变尾色、描边色） |
| `theme` | table | — | 覆盖主题任意字段，见[第 9 节](#9-主题自定义) |

示例：

```lua
local win = Celest.new({
	title    = "星 穹",
	subtitle = "C E L E S T   ·   示例",
	accent   = Color3.fromRGB(120, 200, 255),   -- 冰蓝主题
})
```

---

## 5. 分类 Category

`win:Category(name, glyph)` 创建一个分类，返回值用于挂载控件。

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | string | 分类名（显示在内环类别星点下方） |
| `glyph` | string | 类别星点上显示的字符，默认 `"✦"` |

```lua
local combat = win:Category("兵戈", "✦")
local visual = win:Category("观照", "◈")
local move   = win:Category("行止", "❖")
local system = win:Category("律令", "⊙")
```

- 一个分类对应**内环上的一个星点**；
- 点击类别星点即切换到该分类，外环随之换成它的功能星；
- 分类一般在建窗后一次性创建（分类数量建议 3 ~ 6 个，内环会按数量均分角度）。

---

## 6. 控件详解

所有控件挂在**分类对象**上，按调用顺序排布到外环。

### 6.1 Toggle 开关

```lua
local t = combat:Toggle("自动瞄准", false, function(on)
	print("自动瞄准 ->", on)
end)
```

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | string | 功能名（星点下方文字） |
| `default` | boolean | 初始状态，省略为 `false` |
| `cb` | function | `cb(on)`，点击切换时触发 |

**返回的 item**：`{ kind = "toggle", name, value, cb }`，可用 `t.value` 读当前状态。

### 6.2 Slider 数值

```lua
local s = combat:Slider("视野半径", 0, 100, 50, function(v)
	print("半径 ->", v)
end)
```

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | string | 功能名 |
| `min` / `max` | number | 范围，省略为 `0` / `100` |
| `default` | number | 初始值，省略取 `min` |
| `cb` | function | `cb(v)`，**拖动时实时触发** |

**返回的 item**：`{ kind = "slider", name, min, max, value, cb }`，可用 `s.value` 读当前值。
操作：先单击数值星选中，再按住左右拖动调值。

### 6.3 Button 按钮

```lua
combat:Button("执行一次", function()
	print("bang")
end)
```

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| `name` | string | 按钮名 |
| `cb` | function | 点击时触发一次 |

**返回的 item**：`{ kind = "button", name, cb }`。

---

## 7. 星图布局与环

- **内环**固定放分类星点（半径 `R_IN`）；
- **外环**放当前选中分类的功能星，每环最多 `PER_RING = 8` 个；
- 某分类功能星超过 8 个时，**自动多开一环**（第 2、3… 环依此类推）；
- 环半径常量（库内 `Celest.lua`）：

| 常量 | 值 | 含义 |
| --- | --- | --- |
| `PER_RING` | 8 | 每环最多放几个功能星 |
| `R_IN` | 172 | 内环（分类）半径 |
| `R_FIRST` | 286 | 第一道外环半径 |
| `STEP_R` | 106 | 外环之间的间距 |

- 星图整体按视口自动缩放（电脑 / 手机自适应），无需手动处理分辨率。

---

## 8. 运行时控制 API

| 方法 | 说明 |
| --- | --- |
| `win:Open()` | 展开星图 |
| `win:Close()` | 收合星图（右下角常驻星点仍在） |
| `win:Search(prefill)` | 打开「低语」搜索面板，可预填关键字 |
| `win:Select(name)` | 按分类名切换当前分类 |
| `win:Destroy()` | 销毁整个 UI 并断开连接 |

```lua
-- 常用组合
print(Celest.Version)                -- 版本号，如 "1.0.0"
win:Select("观照")                    -- 切到「观照」分类
win:Search("描边")                    -- 打开搜索并预填「描边」
task.delay(3, function() win:Close() end)
```

---

## 9. 主题自定义

主题字段可通过 `Celest.new({ theme = { ... } })` 覆盖。常用字段：

| 字段 | 说明 |
| --- | --- |
| `void` | 遮罩底色 |
| `panel` | 面板 / 星点底 |
| `nebA` `nebB` `nebC` | 星云三色 |
| `star` | 星辰白 |
| `accent` `accent2` | 强调色 / 渐变尾色 |
| `line` | 环线与描边色 |
| `dim` | 次级文字色 |

```lua
local win = Celest.new({
	theme = {
		accent = Color3.fromRGB(120, 200, 255),
		line   = Color3.fromRGB(120, 200, 255),
		star   = Color3.fromRGB(235, 245, 255),
	},
})
```

> 只改强调色时，直接用 `accent = ...` 更省事，它会同时覆盖 `accent`、`accent2`、`line`。

---

## 10. 完整示例

见同目录 [`Celest-Example.lua`](Celest-Example.lua)，涵盖：

- 远程加载库 → 建窗 → 四个分类 → Toggle / Slider / Button；
- 每类功能超过 8 个时自动多开环的写法；
- 运行时 `Select` / `Search` / `Close` 的调用。

---

## 11. 常见问题

**Q：关环后还有元素挡住游戏界面？**
库已做分层处理：关环时 `星场`（浮游光点）、`星云`、`品牌/提示文字`、`全屏拦截层`会一并隐藏，不再拦截点击。若仍被遮挡，检查是否有其它更高 `DisplayOrder` 的 ScreenGui。

**Q：文字发虚 / 模糊？**
星图容器使用普通 `Frame` + `UIScale`（非 CanvasGroup），文字为矢量渲染，缩放时保持清晰。

**Q：手机点右下角没反应？**
确认执行器 `UserInputService.TouchEnabled` 为真；星图会按触摸设备自动启用触屏拖动逻辑。

**Q：想启动就展开星图？**
Celest 没有 `StartOpen` 开关，建完界面后自行调用：

```lua
win:Open()
```

**Q：数值星拖不动？**
数值星需要**先单击选中**（星点变亮），再按住左右拖动；松手不移动仍视为一次选中。

**Q：分类太多挤在一起？**
内环按分类数量均分 360°，建议控制在 3 ~ 6 个；过多可拆成多层或改用搜索（`CTRL + K`）。

**Q：想彻底移除 UI？**

```lua
win:Destroy()
```

---

> 提示：本库为「数据层 + 星图 UI」两层结构，建窗与加控件都是即时生效的，不需要手动「提交」。对照第 5、6 节的参数表即可上手。