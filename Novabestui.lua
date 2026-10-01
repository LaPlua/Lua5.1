--[[
================================================================================
  Nova UI  ·  现代化 Roblox UI 库
--------------------------------------------------------------------------------
  版本 : 1.5.1
  语法 : 兼容 Lua 5.1 / Roblox Luau
  特性 :
    · 黑白配色，无彩色渐变、无外发光，边缘干净
    · 悬浮窗：纯黑胶囊条 + 白描边（深色场景下也不会隐身）+ 品牌名，默认停靠屏幕正中顶端，可拖动
    · 品牌图自定义：Icon = "https://xxx/logo.png"，自动下载并缓存，悬浮胶囊徽标 + 左上角 logo 共用同一张
      （执行器缺 writefile/getcustomasset/request 或下载失败 → 自动回退字母徽标，不报错不卡界面）
    · 主侧边栏（可上下滑动）+ 副侧边栏（顶部单行标签，每个主栏只显示自己的那组附属标签，可左右滑动）
    · 左上角玩家头像 + 玩家名字（均可自定义）
    · 内置矢量图标库（纯 Frame/UIStroke 绘制，无字体与 emoji 依赖），也可用 rbxassetid 覆盖
    · 开关 / 滑块（长方形推子） / 下拉 / 按钮 / 标签 / 分割线 / 按键绑定 / 输入框
    · 卡片分栏布局、实时搜索、悬浮提示、通知中心
    · 自适应分辨率（主界面大小随设备视口动态计算，始终完整显示）
================================================================================
]]

--==============================================================================
-- 服务
--==============================================================================
local Players          = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local CoreGui          = game:GetService("CoreGui")
local LocalPlayer      = Players.LocalPlayer

local Nova = {}
Nova.__index = Nova
Nova.Version = "1.5.1"
Nova.Flags   = {}

--==============================================================================
-- 主题
--==============================================================================
Nova.Theme = {
	Window      = Color3.fromRGB(10, 10, 11),
	Sidebar     = Color3.fromRGB(6, 6, 7),
	Header      = Color3.fromRGB(10, 10, 11),
	Panel       = Color3.fromRGB(16, 16, 18),
	Card        = Color3.fromRGB(20, 20, 23),
	CardHover   = Color3.fromRGB(25, 25, 28),
	Element     = Color3.fromRGB(31, 31, 35),
	ElementHover= Color3.fromRGB(42, 42, 47),

	Ink         = Color3.fromRGB(9, 9, 10),   -- 白色块上的深色内容

	Stroke      = Color3.fromRGB(255, 255, 255),
	StrokeT     = 0.9,
	StrokeT2    = 0.86,

	Text        = Color3.fromRGB(244, 244, 246),
	TextDim     = Color3.fromRGB(150, 150, 158),
	TextMuted   = Color3.fromRGB(98, 98, 106),

	Good        = Color3.fromRGB(120, 220, 160),
	Warn        = Color3.fromRGB(230, 200, 130),
	Bad         = Color3.fromRGB(235, 120, 120),
}

--==============================================================================
-- 内置矢量图标注册表
--   全部用 Frame / UIStroke 现场绘制，不依赖字体、没有 emoji、任何分辨率都清晰
--   用法：icon(parent, "shield", 18, color)  也可传 "rbxassetid://xxx" 用图片
--==============================================================================
Nova.Icons = {
	default = true, shield = true, eye = true, target = true, hand = true,
	cursor = true, folder = true, settings = true, sliders = true, layers = true,
	search = true, close = true, minimize = true, check = true, chevron = true,
	chevronRight = true, dot = true, more = true, star = true, bolt = true,
	lock = true, user = true, code = true, link = true, refresh = true,
	clock = true, flag = true, plus = true, palette = true, info = true,
	warn = true, power = true, home = true, grid = true,
}

--==============================================================================
-- 默认配置
--==============================================================================
Nova.Defaults = {
	Title          = "Nova",
	Subtitle       = "",
	Brand          = "Lev Hub",            -- 悬浮胶囊上的品牌名
	-- 品牌图：三种写法都行，悬浮胶囊徽标 + 侧边栏左上角 logo 共用同一张
	--   "https://xxx/logo.png"  网络图片（下载一次后本地缓存）
	--   "rbxassetid://123456"   Roblox 资源
	--   "shield"                内置矢量图标名
	Icon           = nil,
	FloatLetter    = nil,                  -- 取不到品牌图时悬浮徽标显示的字母（默认取品牌名首字母）
	PlayerName     = nil,                  -- 默认取显示名
	PlayerSubtitle = "Premium Edition",
	Avatar         = nil,                  -- 默认取 Roblox 头像
	FloatingIcon   = nil,                  -- 只给悬浮胶囊用的图（留空则跟 Icon 走）
	Accent         = Color3.fromRGB(255, 255, 255),   -- 主色：黑白方案，白色为强调
	Accent2        = Color3.fromRGB(178, 178, 186),   -- 辅色：浅灰（渐变尾）
	ToggleKey      = Enum.KeyCode.RightShift,
	Columns        = 2,
	Width          = 1060,                 -- 基准宽（实际大小会按设备视口自适应）
	Height         = 660,                  -- 基准高
	MinScale       = 0.60,
	MaxScale       = 1.40,
	StartOpen      = true,
}

--==============================================================================
-- 基础工具
--==============================================================================
local function clamp(v, lo, hi)
	if v < lo then return lo end
	if v > hi then return hi end
	return v
end

local function create(class, props)
	local inst = Instance.new(class)
	local parent
	if props then
		for k, v in pairs(props) do
			if k == "Parent" then
				parent = v
			elseif v ~= nil then
				inst[k] = v
			end
		end
	end
	if parent then inst.Parent = parent end
	return inst
end

local function corner(inst, r)
	create("UICorner", { CornerRadius = UDim.new(0, r or 8), Parent = inst })
	return inst
end

local function stroke(inst, color, thickness, transparency)
	local s = create("UIStroke", {
		Color = color or Nova.Theme.Stroke,
		Thickness = thickness or 1,
		Transparency = transparency or Nova.Theme.StrokeT,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = inst,
	})
	return s
end

local function padding(inst, t, b, l, r)
	create("UIPadding", {
		PaddingTop = UDim.new(0, t or 0),
		PaddingBottom = UDim.new(0, b or 0),
		PaddingLeft = UDim.new(0, l or 0),
		PaddingRight = UDim.new(0, r or 0),
		Parent = inst,
	})
	return inst
end

local function list(inst, direction, gap, halign, valign)
	create("UIListLayout", {
		FillDirection = direction or Enum.FillDirection.Vertical,
		Padding = UDim.new(0, gap or 0),
		HorizontalAlignment = halign or Enum.HorizontalAlignment.Left,
		VerticalAlignment = valign or Enum.VerticalAlignment.Top,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = inst,
	})
	return inst
end

local function gradient(inst, c1, c2, rotation)
	create("UIGradient", {
		Color = ColorSequence.new(c1, c2),
		Rotation = rotation or 0,
		Parent = inst,
	})
	return inst
end

local function tween(inst, props, time, style, dir)
	local info = TweenInfo.new(
		time or 0.16,
		style or Enum.EasingStyle.Quad,
		dir or Enum.EasingDirection.Out
	)
	local t = TweenService:Create(inst, info, props)
	t:Play()
	return t
end

local function isAsset(v)
	if type(v) ~= "string" then return false end
	return v:sub(1, 10) == "rbxassetid" or v:sub(1, 8) == "rbxthumb"
end

--==============================================================================
-- 自定义品牌图：Icon = "https://xxx/logo.png"
--   request → writefile → getcustomasset
--   下载一次后缓存在 NovaUI/assets/，下次启动直接读本地（秒加载）
--   执行器缺能力 / 下载失败 → 自动回退字母徽标，不会报错也不会卡住界面
--==============================================================================
local function pickHttpGet()
	if type(request) == "function" then return request end
	local ok1, synT = pcall(function() return syn end)
	if ok1 and type(synT) == "table" and type(synT.request) == "function" then return synT.request end
	local ok2, httpReq = pcall(function() return http_request end)
	if ok2 and type(httpReq) == "function" then return httpReq end
	return nil
end

local function toCustomAsset(path)
	if type(getcustomasset) == "function" then
		local ok, v = pcall(getcustomasset, path)
		if ok and v then return v end
	end
	if type(getsynasset) == "function" then
		local ok, v = pcall(getsynasset, path)
		if ok and v then return v end
	end
	return nil
end

local function hasFileApi()
	return type(writefile) == "function"
		and type(isfile) == "function"
		and type(makefolder) == "function"
end

local function isHttpUrl(v)
	if type(v) ~= "string" then return false end
	return v:sub(1, 7) == "http://" or v:sub(1, 8) == "https://"
end

local HttpGet = pickHttpGet()
local ImageCache = {}   -- url -> 已解析的 asset 路径

-- 用 URL 做 hash 当文件名：同图只下一次，换 URL 必然重新下载
local function imageFileName(url)
	local h = 5381
	for i = 1, #url do
		h = (h * 33 + string.byte(url, i)) % 4294967296
	end
	local ext = string.lower(url:match("%.([%a%d]+)$") or "png")
	if ext ~= "png" and ext ~= "jpg" and ext ~= "jpeg"
		and ext ~= "webp" and ext ~= "gif" then
		ext = "png"
	end
	return ("nv_%d.%s"):format(h, ext)
end

-- 返回能直接赋给 ImageLabel.Image 的路径；nil 表示拿不到（调用方自行回退）
local function resolveImage(url)
	if not isHttpUrl(url) then return nil end
	local hit = ImageCache[url]
	if hit then return hit end
	if not HttpGet or not hasFileApi() then return nil end

	local dir = "NovaUI/assets"
	local path = dir .. "/" .. imageFileName(url)

	pcall(function()
		if type(isfolder) == "function" and not isfolder(dir) then
			makefolder(dir)
		end
	end)

	-- 命中本地缓存 → 不再联网
	local exist = false
	pcall(function() exist = isfile(path) end)
	if exist then
		local asset = toCustomAsset(path)
		if asset then
			ImageCache[url] = asset
			return asset
		end
	end

	-- 下载 → 落盘 → 转 asset
	local body
	local okReq = pcall(function()
		local res = HttpGet({ Url = url, Method = "GET" })
		if type(res) == "table" then
			body = res.Body or res.body
		elseif type(res) == "string" then
			body = res
		end
	end)
	if not okReq or type(body) ~= "string" or #body == 0 then return nil end

	local okWrite = pcall(writefile, path, body)
	if not okWrite then return nil end

	local asset = toCustomAsset(path)
	if asset then
		ImageCache[url] = asset
		return asset
	end
	return nil
end

-- 在 24×24 逻辑坐标里绘制矢量图标：只用 Frame + UICorner + UIStroke
-- 坐标全部 ×k 缩放到目标尺寸，因此任意大小都清晰、不糊、不依赖字体
local IconPainters = setmetatable({}, { __mode = "k" }) -- 实例 -> 可着色部件（弱键，自动回收）

local function vIcon(parent, name, size, color, props)
	size = size or 16
	color = color or Nova.Theme.Text
	local k = size / 24

	local box = create("Frame", {
		Name = "Icon",
		BackgroundTransparency = 1,
		ClipsDescendants = false,
		Size = UDim2.fromOffset(size, size),
		Parent = parent,
	})
	local paints, z = {}, 0

	local function bar(x, y, w, h, r, rot, alpha)
		z = z + 1
		local f = create("Frame", {
			BackgroundColor3 = color,
			BackgroundTransparency = alpha or 0,
			Size = UDim2.fromOffset(w * k, h * k),
			Position = UDim2.fromOffset(x * k, y * k),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BorderSizePixel = 0,
			ZIndex = z,
			Parent = box,
		})
		corner(f, (r or 0) * k)
		if rot then f.Rotation = rot end
		paints[#paints + 1] = { kind = "bg", inst = f }
		return f
	end

	local function outline(x, y, w, h, r, thick, alpha)
		z = z + 1
		local f = create("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(w * k, h * k),
			Position = UDim2.fromOffset(x * k, y * k),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BorderSizePixel = 0,
			ZIndex = z,
			Parent = box,
		})
		corner(f, (r or 0) * k)
		local s = create("UIStroke", {
			Color = color,
			Thickness = (thick or 2) * k,
			Transparency = alpha or 0,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Parent = f,
		})
		paints[#paints + 1] = { kind = "stroke", inst = s }
		return f
	end

	local function circle(x, y, d, alpha)
		return bar(x, y, d, d, d / 2, 0, alpha)
	end

	local function draw(n)
		if n == "close" then
			bar(12, 12, 14, 2.4, 1.2, 45)
			bar(12, 12, 14, 2.4, 1.2, -45)
		elseif n == "minimize" then
			bar(12, 12, 13, 2.4, 1.2)
		elseif n == "check" then
			bar(9, 14.4, 6.4, 2.6, 1.3, 45)
			bar(14.6, 11.9, 11.4, 2.6, 1.3, -50)
		elseif n == "plus" then
			bar(12, 12, 14, 2.4, 1.2)
			bar(12, 12, 2.4, 14, 1.2)
		elseif n == "chevron" then
			bar(9.5, 12.4, 7, 2.4, 1.2, 45)
			bar(14.5, 12.4, 7, 2.4, 1.2, -45)
		elseif n == "chevronRight" then
			bar(12.4, 9.5, 7, 2.4, 1.2, 45)
			bar(12.4, 14.5, 7, 2.4, 1.2, -45)
		elseif n == "dot" then
			circle(12, 12, 5)
		elseif n == "more" then
			circle(7, 12, 3.4)
			circle(12, 12, 3.4)
			circle(17, 12, 3.4)
		elseif n == "search" then
			outline(11, 11, 13.5, 13.5, 6.75, 2.2)
			bar(16.8, 16.8, 6.4, 2.4, 1.2, 45)
		elseif n == "grid" then
			bar(8, 8, 6, 6, 1.8)
			bar(16, 8, 6, 6, 1.8)
			bar(8, 16, 6, 6, 1.8)
			bar(16, 16, 6, 6, 1.8)
		elseif n == "sliders" then
			bar(12, 6.5, 16, 2.1, 1.05, 0, 0.5)
			bar(8, 6.5, 4.6, 4.6, 2.3)
			bar(12, 12, 16, 2.1, 1.05, 0, 0.5)
			bar(15.5, 12, 4.6, 4.6, 2.3)
			bar(12, 17.5, 16, 2.1, 1.05, 0, 0.5)
			bar(9.5, 17.5, 4.6, 4.6, 2.3)
		elseif n == "settings" then
			outline(12, 12, 13, 13, 6.5, 2.4)
			bar(12, 4.6, 3, 4.4, 1.5)
			bar(12, 19.4, 3, 4.4, 1.5)
			bar(4.6, 12, 4.4, 3, 1.5)
			bar(19.4, 12, 4.4, 3, 1.5)
			circle(12, 12, 3.2)
		elseif n == "layers" then
			bar(12, 6.5, 11, 11, 1.8, 45, 0.34)
			bar(12, 12, 11, 11, 1.8, 45, 0.6)
			bar(12, 17.5, 11, 11, 1.8, 45)
		elseif n == "folder" then
			bar(8.6, 7.4, 8, 3.4, 1.5)
			bar(12, 14, 16.5, 11.5, 2.4)
		elseif n == "user" then
			circle(12, 8.4, 7.6)
			bar(12, 18.6, 15.4, 9, 4.5)
		elseif n == "hand" then
			bar(12, 16.5, 13, 8.4, 2.8)
			bar(8.5, 9.5, 2.6, 9, 1.3)
			bar(12, 8, 2.6, 12, 1.3)
			bar(15.5, 9.5, 2.6, 9, 1.3)
			bar(5.6, 14, 2.6, 6.4, 1.3, -32)
		elseif n == "cursor" then
			bar(10, 10, 3.2, 14.5, 1.6)
			bar(15.2, 16.2, 7.4, 3.2, 1.6, 48)
		elseif n == "shield" then
			bar(12, 9.6, 15, 10.4, 3, 0)
			bar(12, 15, 10.7, 10.7, 1.7, 45)
		elseif n == "eye" then
			outline(12, 12, 18, 11, 5.5, 2)
			circle(12, 12, 5.6)
		elseif n == "target" then
			outline(12, 12, 17.5, 17.5, 8.75, 2.1)
			circle(12, 12, 4.2)
		elseif n == "star" then
			bar(12, 12, 3, 17, 1.5)
			bar(12, 12, 17, 3, 1.5)
			circle(12, 12, 3)
		elseif n == "bolt" then
			bar(13.4, 8.6, 3.6, 8.4, 1.3, 18)
			bar(10.6, 15.4, 3.6, 8.4, 1.3, 18)
			bar(12, 12, 4.2, 2.6, 1.3, -18)
		elseif n == "lock" then
			outline(12, 9, 9.4, 9.4, 4.7, 2.3)
			bar(12, 15.4, 13.6, 10.4, 2.4)
		elseif n == "warn" then
			bar(12, 11, 2.6, 9.4, 1.3)
			circle(12, 18.6, 2.6)
		elseif n == "info" then
			outline(12, 12, 16.5, 16.5, 8.25, 2.1)
			circle(12, 8.2, 2.4)
			bar(12, 14.6, 2.4, 7, 1.2)
		elseif n == "clock" then
			outline(12, 12, 17, 17, 8.5, 2.1)
			bar(12, 9.6, 2.1, 6, 1.05)
			bar(14.4, 13.6, 5.4, 2.1, 1.05, 45)
		elseif n == "refresh" then
			outline(12, 12, 15, 15, 7.5, 2.2)
			bar(17.2, 6.4, 4, 4, 1.4, 45)
		elseif n == "link" then
			bar(7.6, 12, 8.4, 6, 3, 0, 0.35)
			bar(16.4, 12, 8.4, 6, 3, 0, 0.35)
			bar(12, 12, 7.6, 2.4, 1.2)
		elseif n == "code" then
			bar(8.2, 12, 6, 2.4, 1.2, 45)
			bar(8.2, 12, 6, 2.4, 1.2, -45)
			bar(15.8, 12, 6, 2.4, 1.2, 45)
			bar(15.8, 12, 6, 2.4, 1.2, -45)
			bar(12, 12, 2.2, 7, 1.1)
		elseif n == "flag" then
			bar(7, 12.5, 2.4, 17, 1.2)
			bar(13.6, 9, 9, 8, 1.7, -8)
		elseif n == "home" then
			bar(9.2, 9.8, 7, 2.4, 1.2, 45)
			bar(14.8, 9.8, 7, 2.4, 1.2, -45)
			bar(12, 16.4, 13, 8.4, 1.6)
		elseif n == "power" then
			outline(12, 12.6, 15, 15, 7.5, 2.3)
			bar(12, 7.6, 2.4, 7.6, 1.2)
		elseif n == "palette" then
			outline(12, 12, 17, 17, 8.5, 2.1)
			circle(9, 9.8, 2.6)
			circle(14.4, 9.4, 2.6)
			circle(8.6, 14.6, 2.6)
		else -- default：菱形
			bar(12, 12, 13, 13, 3, 45)
		end
	end

	draw(Nova.Icons[name] and name or "default")

	IconPainters[box] = paints

	if props then
		for kk, vv in pairs(props) do
			if kk ~= "Size" then box[kk] = vv end -- 矢量图标尺寸由 size 决定
		end
	end
	return box
end

-- 渲染图标：rbxassetid/rbxthumb -> 图片；其它为矢量图标名（未知则用 default）
local function icon(parent, name, size, color, props)
	size = size or 16
	if isAsset(name) then
		local img = create("ImageLabel", {
			Name = "Icon",
			Image = name,
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(size, size),
			ImageColor3 = color or Nova.Theme.Text,
			Parent = parent,
		})
		if props then
			for kk, vv in pairs(props) do img[kk] = vv end
		end
		return img
	end
	return vIcon(parent, name, size, color, props)
end

-- 统一给图标上色（矢量 / 文本 / 图片通用）
local function tint(ic, c)
	if not ic then return end
	local paints = IconPainters[ic]
	if paints then
		for i = 1, #paints do
			local p = paints[i]
			if p.kind == "bg" then
				p.inst.BackgroundColor3 = c
			else
				p.inst.Color = c
			end
		end
		return
	end
	if ic:IsA("TextLabel") then
		ic.TextColor3 = c
	elseif ic:IsA("ImageLabel") then
		ic.ImageColor3 = c
	end
end

local function findGuiParent()
	local ok, hui = pcall(function()
		return gethui and gethui()
	end)
	if ok and hui then return hui end

	ok = pcall(function()
		local sg = Instance.new("ScreenGui")
		sg.Parent = CoreGui
		sg:Destroy()
	end)
	if ok then return CoreGui end

	return LocalPlayer:WaitForChild("PlayerGui")
end

--==============================================================================
-- 前置声明（这三个类在后面定义，但会被更早的函数引用）
--==============================================================================
local PrimaryPane, SecondaryPane, Section

--==============================================================================
-- 构造
--==============================================================================
function Nova.new(config)
	local self = setmetatable({}, Nova)

	local cfg = {}
	for k, v in pairs(Nova.Defaults) do cfg[k] = v end
	for k, v in pairs(config or {}) do cfg[k] = v end
	self.Config = cfg

	local theme = {}
	for k, v in pairs(Nova.Theme) do theme[k] = v end
	theme.Accent = cfg.Accent
	theme.Accent2 = cfg.Accent2
	self.Theme = theme

	self.Scale       = 1
	self.PrimaryTabs = {}
	self.Sections    = {}
	self._conns      = {}
	self._popupClose = nil
	self._popup      = nil
	self._visible    = false
	self.SearchQuery = ""
	self._iconAsset  = nil
	self._iconToken  = 0

	self:_BuildRoot()
	self:_BuildFloating()
	self:_BuildWindow()
	self:_BuildNotificationHost()
	self:_ApplyScale()
	self:_HookViewport()
	self:_HookKeybind()
	self:_LoadIcon()

	if cfg.StartOpen then
		self:Open()
	end

	return self
end

--==============================================================================
-- 根节点
--==============================================================================
function Nova:_BuildRoot()
	self.Root = create("ScreenGui", {
		Name = "NovaUI",
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 9999,
		Parent = findGuiParent(),
	})

	-- 弹层容器（下拉 / 菜单 / 提示）
	self.PopupLayer = create("Frame", {
		Name = "PopupLayer",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 50,
		Parent = self.Root,
	})

	-- 悬浮提示层：挂在根节点，主侧边栏滚动裁剪时提示不会被切掉
	self.Tip = create("Frame", {
		Name = "Tip",
		BackgroundColor3 = self.Theme.Card,
		Size = UDim2.fromOffset(0, 26),
		BackgroundTransparency = 1,
		Visible = false,
		ZIndex = 60,
		Parent = self.Root,
	})
	corner(self.Tip, 7)
	stroke(self.Tip, self.Theme.Stroke, 1, 0.9)
	self.TipLabel = create("TextLabel", {
		Name = "Text",
		Text = "",
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		TextColor3 = self.Theme.Text,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		Size = UDim2.new(1, -18, 1, 0),
		Position = UDim2.fromOffset(9, 0),
		ZIndex = 61,
		Parent = self.Tip,
	})

	-- 窗口外层（负责阴影与整体缩放定位）
	self.Holder = create("Frame", {
		Name = "Holder",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(self.Config.Width, self.Config.Height),
		Visible = false,
		ZIndex = 10,
		Parent = self.Root,
	})

	-- 阴影：只在窗口下方压一层极淡的紧贴暗影，避免边缘出现一圈灰雾
	local sh = create("Frame", {
		Name = "Shadow",
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.55,
		Size = UDim2.new(1, 6, 1, 8),
		Position = UDim2.fromOffset(-3, -2),
		ZIndex = 8,
		Parent = self.Holder,
	})
	corner(sh, 18)
	create("UIGradient", {
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.6),
			NumberSequenceKeypoint.new(0.5, 1),
			NumberSequenceKeypoint.new(1, 0.62),
		}),
		Rotation = 90,
		Parent = sh,
	})

	-- 窗口主体
	-- 必须是普通 Frame，不能用 CanvasGroup：CanvasGroup 会把整棵子树渲染成一张纹理，
	-- 外层 UIScale 放大后（大屏 Scale 会到 1.2~1.4）文字被插值缩放，就是“糊”的根源。
	self.Window = create("Frame", {
		Name = "Window",
		BackgroundColor3 = self.Theme.Window,
		BackgroundTransparency = 0,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 10,
		Parent = self.Holder,
	})
	corner(self.Window, 14)
	stroke(self.Window, self.Theme.Stroke, 1, 0.86)

	-- 淡入淡出遮罩：与窗口同色同圆角，盖在最顶层，只靠它的透明度做开关动画。
	-- 这样正文始终是矢量渲染，清晰不糊；遮罩是普通 Frame 不吃输入，不影响点击。
	self.Fade = create("Frame", {
		Name = "Fade",
		BackgroundColor3 = self.Theme.Window,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 200,
		Parent = self.Holder,
	})
	corner(self.Fade, 14)

	self.UIScale = create("UIScale", { Scale = 1, Parent = self.Holder })
end

--==============================================================================
-- 悬浮窗（黑白胶囊条）
--==============================================================================
function Nova:_BuildFloating()
	local W, H = 176, 44

	-- 用普通 Frame（不用 CanvasGroup）：实心黑底 + 白描边，任何设备 / 背景上都清晰可见
	self.Floating = create("Frame", {
		Name = "Floating",
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0,
		Size = UDim2.fromOffset(W, H),
		Position = UDim2.new(0.5, 0, 0, 16),   -- 初始位置：屏幕正中顶端
		AnchorPoint = Vector2.new(0.5, 0),
		ZIndex = 30,
		Parent = self.Root,
	})
	corner(self.Floating, H / 2)
	-- 白色描边给足对比度，纯黑胶囊在深色场景里也不会「隐身」
	self.FloatingStroke = stroke(self.Floating, Color3.fromRGB(255, 255, 255), 1.5, 0.1)

	self.FloatingIconHolder = create("Frame", {
		Name = "IconHolder",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 2,
		Parent = self.Floating,
	})
	self:_RenderFloatingIcon()

	-- 悬停反馈：只提亮描边，不缩放、不发光
	self.Floating.MouseEnter:Connect(function()
		tween(self.FloatingStroke, { Transparency = 0 }, 0.18)
	end)
	self.Floating.MouseLeave:Connect(function()
		tween(self.FloatingStroke, { Transparency = 0.1 }, 0.18)
	end)

	-- 拖动 + 点击
	local dragging, dragStart, startPos, moved = false, nil, nil, false
	self.Floating.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			moved = false
			dragStart = input.Position
			startPos = self.Floating.Position
		end
	end)
	self._conns[#self._conns + 1] = UserInputService.InputChanged:Connect(function(input)
		if not dragging then return end
		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then
			local d = input.Position - dragStart
			if math.abs(d.X) > 4 or math.abs(d.Y) > 4 then moved = true end
			self.Floating.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + d.X,
				startPos.Y.Scale, startPos.Y.Offset + d.Y
			)
		end
	end)
	self._conns[#self._conns + 1] = UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			if dragging and not moved then
				self:Toggle()
			end
			dragging = false
			self:_ClampFloating()
		end
	end)
end

function Nova:_RenderFloatingIcon()
	local holder = self.FloatingIconHolder
	if not holder then return end
	for _, c in ipairs(holder:GetChildren()) do c:Destroy() end
	self.FloatingLabel = nil
	self.FloatingMark = nil
	self.FloatingDot = nil

	local brand = self.Config.Brand or "Lev Hub"
	local T = self.Theme

	-- 左侧品牌徽标：白底圆角方块 + 图片 / 首字母（Icon 或 FloatingIcon 有图就用图）
	local mark = create("Frame", {
		Name = "Mark",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		Size = UDim2.fromOffset(32, 32),
		Position = UDim2.new(0, 7, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		ClipsDescendants = true,   -- 图片铺满时按圆角裁切，四角不会方出来
		ZIndex = 3,
		Parent = holder,
	})
	corner(mark, 10)
	gradient(mark, Color3.fromRGB(255, 255, 255), Color3.fromRGB(186, 186, 194), 45)
	self.FloatingMark = mark

	local img = self:_FloatImage()
	if img then
		-- 铺满整个白色圆角方块：ScaleType.Crop 保证不留白边，UICorner 跟着方块圆角裁切
		local pic = create("ImageLabel", {
			Name = "Img",
			Image = img,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Position = UDim2.fromScale(0, 0),
			ScaleType = Enum.ScaleType.Crop,
			ZIndex = 4,
			Parent = mark,
		})
		corner(pic, 10)
	else
		-- 取不到图 → 回退字母徽标（FloatLetter 优先，否则品牌名首字母）
		local letter = self.Config.FloatLetter
		if type(letter) ~= "string" or letter == "" then
			letter = string.sub(brand, 1, 1)
		end
		create("TextLabel", {
			Name = "Letter",
			Text = string.upper(string.sub(letter, 1, 1)),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBlack,
			TextColor3 = T.Ink,
			TextSize = 15,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 4,
			Parent = mark,
		})
	end

	-- 品牌名（左对齐、垂直居中，位置写死，不会因触摸/缩放而漂移）
	create("TextLabel", {
		Name = "Brand",
		Text = brand,
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Size = UDim2.fromOffset(68, 18),
		Position = UDim2.new(0, 44, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		ZIndex = 3,
		Parent = holder,
	})

	-- 右侧状态：白字 Open / Close，随主界面开关切换
	local state = create("TextLabel", {
		Name = "State",
		Text = self._visible and "Close" or "Open",
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextYAlignment = Enum.TextYAlignment.Center,
		Size = UDim2.fromOffset(46, 18),
		Position = UDim2.new(1, -8, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		ZIndex = 3,
		Parent = holder,
	})
	self.FloatingLabel = state
	return state
end

function Nova:_UpdateFloatingLabel()
	if self.FloatingLabel then
		self.FloatingLabel.Text = self._visible and "Close" or "Open"
		tween(self.FloatingLabel, {
			TextColor3 = self._visible and Color3.fromRGB(255, 255, 255)
				or Color3.fromRGB(150, 150, 160),
		}, 0.18)
	end
end

--==============================================================================
-- 主窗口
--==============================================================================
function Nova:_BuildWindow()
	local T = self.Theme
	local W = self.Window

	-- 主侧边栏
	self.Sidebar = create("Frame", {
		Name = "Sidebar",
		BackgroundColor3 = T.Sidebar,
		Size = UDim2.new(0, 68, 1, 0),
		ZIndex = 11,
		Parent = W,
	})
	corner(self.Sidebar, 14)
	create("Frame", {
		Name = "EdgeMask",
		BackgroundColor3 = T.Sidebar,
		Size = UDim2.new(0, 20, 1, 0),
		Position = UDim2.new(1, -20, 0, 0),
		BorderSizePixel = 0,
		ZIndex = 11,
		Parent = self.Sidebar,
	})
	create("Frame", {
		Name = "RightEdge",
		BackgroundColor3 = T.Stroke,
		BackgroundTransparency = 0.9,
		Size = UDim2.new(0, 1, 1, -28),
		Position = UDim2.new(1, -1, 0, 14),
		BorderSizePixel = 0,
		ZIndex = 12,
		Parent = self.Sidebar,
	})

	-- 侧边栏 logo（白底黑标）
	local logo = create("Frame", {
		Name = "Logo",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		Size = UDim2.fromOffset(36, 36),
		Position = UDim2.new(0, 16, 0, 12),
		ZIndex = 13,
		Parent = self.Sidebar,
	})
	corner(logo, 11)
	gradient(logo, Color3.fromRGB(255, 255, 255), Color3.fromRGB(196, 196, 204), 45)
	self.LogoPlate = logo
	-- 内容单独放一层：重绘时只清这一层，绝不动 plate 上的 UICorner / UIGradient（否则圆角会被删掉）
	self.LogoContent = create("Frame", {
		Name = "Content",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ClipsDescendants = true,   -- 品牌图铺满时按圆角裁切
		ZIndex = 13,
		Parent = logo,
	})
	self:_RenderLogo()

	-- 主栏按钮容器（图标多了可以上下滑动）
	self.PrimaryHolder = create("ScrollingFrame", {
		Name = "PrimaryHolder",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, -74),
		Position = UDim2.fromOffset(0, 62),
		CanvasSize = UDim2.fromOffset(0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		ScrollBarThickness = 0,
		ElasticBehavior = Enum.ElasticBehavior.Never,
		ZIndex = 13,
		Parent = self.Sidebar,
	})
	padding(self.PrimaryHolder, 8, 10, 0, 0)
	list(self.PrimaryHolder, Enum.FillDirection.Vertical, 8, Enum.HorizontalAlignment.Center)

	-- 右侧主区域
	local main = create("Frame", {
		Name = "Main",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -68, 1, 0),
		Position = UDim2.fromOffset(68, 0),
		ZIndex = 11,
		Parent = W,
	})

	-- 顶栏
	local header = create("Frame", {
		Name = "Header",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 60),
		ZIndex = 12,
		Parent = main,
	})
	create("Frame", {
		Name = "HeaderLine",
		BackgroundColor3 = T.Stroke,
		BackgroundTransparency = 0.93,
		Size = UDim2.new(1, -28, 0, 1),
		Position = UDim2.new(0, 14, 1, -1),
		BorderSizePixel = 0,
		ZIndex = 12,
		Parent = header,
	})

	-- 左上角：玩家头像
	self.AvatarHolder = create("Frame", {
		Name = "AvatarHolder",
		BackgroundColor3 = T.Element,
		Size = UDim2.fromOffset(34, 34),
		Position = UDim2.new(0, 14, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		ZIndex = 13,
		Parent = header,
	})
	corner(self.AvatarHolder, 10)
	stroke(self.AvatarHolder, T.Accent, 1.5, 0.35)
	self:_RenderAvatar()

	-- 左上角：玩家名字 + 副标题
	self.NameLabel = create("TextLabel", {
		Name = "PlayerName",
		Text = self:_PlayerName(),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextColor3 = T.Text,
		TextSize = 13.5,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(0, 200, 0, 16),
		Position = UDim2.fromOffset(58, 12),
		ZIndex = 13,
		Parent = header,
	})
	self.SubLabel = create("TextLabel", {
		Name = "PlayerSubtitle",
		Text = self.Config.PlayerSubtitle,
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextColor3 = T.TextMuted,
		TextSize = 10.5,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(0, 200, 0, 13),
		Position = UDim2.fromOffset(58, 28),
		ZIndex = 13,
		Parent = header,
	})

	-- 搜索框（原来的「最小化 / 关闭」按钮已去掉：开关界面统一走悬浮窗）
	local searchBox = create("Frame", {
		Name = "SearchBox",
		BackgroundColor3 = T.Element,
		BackgroundTransparency = 0.35,
		Size = UDim2.fromOffset(160, 28),
		Position = UDim2.new(1, -10, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		ZIndex = 13,
		Parent = header,
	})
	corner(searchBox, 8)
	local sbStroke = stroke(searchBox, T.Stroke, 1, 0.88)
	icon(searchBox, "search", 13, T.TextMuted, {
		Position = UDim2.fromOffset(9, 7),
		ZIndex = 14,
		Size = UDim2.fromOffset(13, 13),
	})
	local searchInput = create("TextBox", {
		Name = "Input",
		Text = "",
		PlaceholderText = "Search...",
		PlaceholderColor3 = T.TextMuted,
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextColor3 = T.Text,
		TextSize = 11.5,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false,
		Size = UDim2.new(1, -28, 1, 0),
		Position = UDim2.fromOffset(27, 0),
		ZIndex = 14,
		Parent = searchBox,
	})
	searchInput.Focused:Connect(function()
		tween(sbStroke, { Transparency = 0.45 }, 0.15)
	end)
	searchInput.FocusLost:Connect(function()
		tween(sbStroke, { Transparency = 0.88 }, 0.15)
	end)
	self.SearchBox = searchInput
	searchInput:GetPropertyChangedSignal("Text"):Connect(function()
		self.SearchQuery = string.lower(searchInput.Text)
		self:_ApplyFilter()
	end)

	--==========================================================================
	-- 副侧边栏：单行标签条（图标 + 名字），可左右滑动，高度固定
	--==========================================================================
	local TAB_H = 30
	local TABBAR_H = TAB_H + 14
	local TABBAR_Y = 68
	local CONTENT_Y = TABBAR_Y + TABBAR_H + 12

	local tabBar = create("Frame", {
		Name = "TabBar",
		BackgroundColor3 = T.Panel,
		BackgroundTransparency = 0.45,
		Size = UDim2.new(1, -28, 0, TABBAR_H),
		Position = UDim2.fromOffset(14, TABBAR_Y),
		ZIndex = 12,
		Parent = main,
	})
	corner(tabBar, 10)
	self.TabBar = tabBar
	self.TabH = TAB_H
	self.TabBarY = TABBAR_Y
	self.ContentY = CONTENT_Y
	self.ContentYNoTab = 14

	-- 单行横向滚动：原生滚轮 / 触摸拖动，只有标签超出宽度时才需要滑动
	local tabScroll = create("ScrollingFrame", {
		Name = "TabScroll",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, -12, 0, TAB_H),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		CanvasSize = UDim2.fromOffset(0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.X,
		ScrollingDirection = Enum.ScrollingDirection.X,
		ScrollBarThickness = 0,
		ElasticBehavior = Enum.ElasticBehavior.Never,
		ClipsDescendants = true,
		ZIndex = 12,
		Parent = tabBar,
	})
	self.TabScroll = tabScroll
	create("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 8),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = tabScroll,
	})

	-- 内容区（位置固定写死，不再依赖标签条实测高度）
	-- 位置/尺寸各预留 2px：卡片描边是向外溢出的，贴边会被 ScrollingFrame 裁掉，
	-- 导致最左侧那张卡的左边框看起来“没描边”。补偿后视觉边距仍是 14。
	self.Content = create("ScrollingFrame", {
		Name = "Content",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, -24, 1, -(CONTENT_Y + 10)),
		Position = UDim2.fromOffset(12, CONTENT_Y - 2),
		CanvasSize = UDim2.fromOffset(0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = T.Stroke,
		ScrollBarImageTransparency = 0.55,
		ElasticBehavior = Enum.ElasticBehavior.Never,
		ZIndex = 12,
		Parent = main,
	})
	padding(self.Content, 2, 2, 2, 2)
end

--==============================================================================
-- 顶部副侧边栏（附属标签）
-- 每个主侧边栏只管自己的那组附属标签：切换主栏时整条标签条会跟着换内容
--==============================================================================
function Nova:_RefreshTabs()
	local primary = self.ActivePrimary
	local shown = 0
	if primary then
		for i = 1, #primary.Secondaries do
			if primary.Secondaries[i].Button.Visible then
				shown = shown + 1
			end
		end
	end

	-- 当前主栏没有任何附属标签时，整条标签条隐藏，内容区上移
	local hasTabs = shown > 0
	self.TabBar.Visible = hasTabs
	local y = hasTabs and self.ContentY or self.ContentYNoTab
	self.Content.Position = UDim2.fromOffset(14, y)
	self.Content.Size = UDim2.new(1, -28, 1, -(y + 14))
	self.TabScroll.CanvasPosition = Vector2.new(0, 0)
end

function Nova:_PlayerName()
	if self.Config.PlayerName then return self.Config.PlayerName end
	if LocalPlayer then
		local ok, name = pcall(function() return LocalPlayer.DisplayName end)
		if ok and name then return name end
	end
	return "Player"
end

--==============================================================================
-- 品牌图 / 侧边栏 logo
--==============================================================================
-- 当前可用的品牌图路径（网络图优先，其次 rbxassetid/rbxthumb），没有则 nil
function Nova:_BrandImage()
	if self._iconAsset then return self._iconAsset end
	local v = self.Config.Icon
	if isAsset(v) then return v end
	return nil
end

-- 悬浮胶囊专用的图：FloatingIcon 优先，其次跟 Icon 走
function Nova:_FloatImage()
	if self._iconAsset then return self._iconAsset end
	local f = self.Config.FloatingIcon
	if isAsset(f) then return f end
	if isAsset(self.Config.Icon) then return self.Config.Icon end
	return nil
end

-- 网络图异步加载：先出字母徽标，拿到图再替换，绝不卡住界面
function Nova:_LoadIcon()
	self._iconAsset = nil
	local url = self.Config.Icon
	if not isHttpUrl(url) then return end

	-- 递增令牌：中途换图时，旧请求回来的结果会被丢弃
	self._iconToken = (self._iconToken or 0) + 1
	local token = self._iconToken

	task.spawn(function()
		local asset = resolveImage(url)
		if not asset then return end
		if self._iconToken ~= token then return end
		if not self.Root or not self.Root.Parent then return end
		self._iconAsset = asset
		self:_RenderLogo()
		self:_RenderFloatingIcon()
	end)
end

function Nova:_RenderLogo()
	local holder = self.LogoContent
	if not holder then return end
	for _, c in ipairs(holder:GetChildren()) do c:Destroy() end

	local T = self.Theme
	local img = self:_BrandImage()
	if img then
		-- 铺满整个 logo 方块（和悬浮胶囊一致），不留白边
		local pic = create("ImageLabel", {
			Name = "Img",
			Image = img,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Position = UDim2.fromScale(0, 0),
			ScaleType = Enum.ScaleType.Crop,
			ZIndex = 14,
			Parent = holder,
		})
		corner(pic, 11)
		return
	end

	local iconCfg = self.Config.Icon
	-- 网络图还没下载完时不画图标：先用首字母占位，避免闪一个不相干的矢量图
	if iconCfg and not isHttpUrl(iconCfg) and iconCfg ~= "default" and iconCfg ~= "" then
		icon(holder, iconCfg, 20, T.Ink, {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			ZIndex = 14,
			Size = UDim2.fromOffset(20, 20),
		})
		return
	end

	-- 没自定义图标时用标题首字母，比一个没有含义的菱形清楚
	create("TextLabel", {
		Name = "Mark",
		Text = string.upper(string.sub(self.Config.Title or "N", 1, 1)),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBlack,
		TextColor3 = T.Ink,
		TextSize = 17,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 14,
		Parent = holder,
	})
end

function Nova:_RenderAvatar()
	local holder = self.AvatarHolder
	local old = holder:FindFirstChild("I")
	if old then old:Destroy() end

	local src = self.Config.Avatar
	if not src then
		local uid = 1
		if LocalPlayer then
			local ok, v = pcall(function() return LocalPlayer.UserId end)
			if ok and v then uid = v end
		end
		src = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(uid) .. "&w=150&h=150"
	end

	if isAsset(src) then
		create("ImageLabel", {
			Name = "I",
			Image = src,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 14,
			Parent = holder,
		})
	else
		icon(holder, src, 18, self.Theme.Text, {
			Name = "I",
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			ZIndex = 14,
			Size = UDim2.fromOffset(18, 18),
		})
	end
	local lbl = holder:FindFirstChild("I")
	if lbl then corner(lbl, 12) end
end

--==============================================================================
-- 通知中心
--==============================================================================
function Nova:_BuildNotificationHost()
	self.NotifyHost = create("Frame", {
		Name = "NotifyHost",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.new(1, -20, 1, -20),
		Size = UDim2.fromOffset(300, 400),
		ZIndex = 60,
		Parent = self.Root,
	})
	local l = create("UIListLayout", {
		FillDirection = Enum.FillDirection.Vertical,
		Padding = UDim.new(0, 10),
		HorizontalAlignment = Enum.HorizontalAlignment.Right,
		VerticalAlignment = Enum.VerticalAlignment.Bottom,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = self.NotifyHost,
	})
	self.NotifyLayout = l
end

function Nova:Notify(cfg)
	cfg = cfg or {}
	local T = self.Theme
	local order = #self.NotifyHost:GetChildren()

	local card = create("CanvasGroup", {
		Name = "Notify",
		BackgroundColor3 = T.Card,
		Size = UDim2.fromOffset(300, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Position = UDim2.fromOffset(60, 0),
		GroupTransparency = 1,
		LayoutOrder = order,
		ZIndex = 61,
		Parent = self.NotifyHost,
	})
	corner(card, 12)
	stroke(card, T.Stroke, 1, T.StrokeT2)

	local accent = create("Frame", {
		Name = "Accent",
		BackgroundColor3 = cfg.Color or T.Accent,
		Size = UDim2.new(0, 3, 1, -20),
		Position = UDim2.fromOffset(0, 10),
		BorderSizePixel = 0,
		ZIndex = 62,
		Parent = card,
	})
	corner(accent, 2)

	local body = create("Frame", {
		Name = "Body",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -22, 0, 0),
		Position = UDim2.fromOffset(14, 10),
		AutomaticSize = Enum.AutomaticSize.Y,
		ZIndex = 62,
		Parent = card,
	})

	icon(body, cfg.Icon or "info", 18, cfg.Color or T.Accent, {
		Position = UDim2.fromOffset(0, 2),
		ZIndex = 63,
		Size = UDim2.fromOffset(18, 18),
	})

	local title = create("TextLabel", {
		Name = "Title",
		Text = cfg.Title or "Notification",
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextColor3 = T.Text,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
		Size = UDim2.new(1, -28, 0, 17),
		Position = UDim2.fromOffset(26, 1),
		ZIndex = 63,
		Parent = body,
	})
	local desc = create("TextLabel", {
		Name = "Desc",
		Text = cfg.Desc or "",
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextColor3 = T.TextDim,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
		AutomaticSize = Enum.AutomaticSize.Y,
		Size = UDim2.new(1, -28, 0, 14),
		Position = UDim2.fromOffset(26, 20),
		ZIndex = 63,
		Parent = body,
	})
	create("Frame", {
		Name = "Pad",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 6),
		Position = UDim2.new(0, 0, 1, 0),
		ZIndex = 62,
		Parent = body,
	})

	-- 进度条
	local bar = create("Frame", {
		Name = "Bar",
		BackgroundColor3 = cfg.Color or T.Accent,
		BackgroundTransparency = 0.4,
		Size = UDim2.new(1, 0, 0, 2),
		Position = UDim2.new(0, 0, 1, -2),
		BorderSizePixel = 0,
		ZIndex = 63,
		Parent = card,
	})

	-- 入场
	tween(card, { GroupTransparency = 0, Position = UDim2.fromOffset(0, 0) }, 0.28, Enum.EasingStyle.Quint)

	local duration = cfg.Duration or 4
	if bar then
		tween(bar, { Size = UDim2.new(0, 0, 0, 2) }, duration, Enum.EasingStyle.Linear)
	end

	local function dismiss()
		tween(card, { GroupTransparency = 1, Position = UDim2.fromOffset(60, 0) }, 0.22)
		task.delay(0.24, function()
			card:Destroy()
		end)
	end

	card.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dismiss()
		end
	end)

	task.delay(duration, function()
		if card and card.Parent then dismiss() end
	end)

	return card
end

--==============================================================================
-- 弹层
--==============================================================================
function Nova:_ClosePopup()
	if self._popupClose then
		self._popupClose:Disconnect()
		self._popupClose = nil
	end
	if self._popup then
		local p = self._popup
		self._popup = nil
		tween(p, { Position = UDim2.fromOffset(p.AbsolutePosition.X, p.AbsolutePosition.Y + 6), BackgroundTransparency = 1, GroupTransparency = 1 }, 0.12)
		task.delay(0.14, function()
			p:Destroy()
		end)
	end
	if self._catcher then
		self._catcher:Destroy()
		self._catcher = nil
	end
end

function Nova:_Popup(anchor, width, items, onPick)
	self:_ClosePopup()
	local T = self.Theme

	local catcher = create("TextButton", {
		Name = "Catcher",
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 50,
		Modal = true,
		Parent = self.PopupLayer,
	})
	self._catcher = catcher

	local height = math.max(#items * 30 + 10, 34)
	local x = anchor.AbsolutePosition.X
	local y = anchor.AbsolutePosition.Y + anchor.AbsoluteSize.Y + 6

	-- 兜底：超出屏幕则向上弹
	local vp = self:_Viewport()
	if y + height > vp.Y - 10 then
		y = anchor.AbsolutePosition.Y - height - 6
	end
	if x + width > vp.X - 10 then
		x = vp.X - width - 10
	end

	local pop = create("CanvasGroup", {
		Name = "Popup",
		BackgroundColor3 = T.Card,
		Size = UDim2.fromOffset(width, height),
		Position = UDim2.fromOffset(x, y + 6),
		GroupTransparency = 1,
		ZIndex = 51,
		Parent = self.PopupLayer,
	})
	corner(pop, 10)
	stroke(pop, T.Stroke, 1, T.StrokeT2)
	self._popup = pop

	local holder = create("Frame", {
		Name = "Items",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -10, 1, -10),
		Position = UDim2.fromOffset(5, 5),
		ZIndex = 52,
		Parent = pop,
	})
	list(holder, Enum.FillDirection.Vertical, 2)

	for i = 1, #items do
		local item = items[i]
		local name = item.Name or tostring(item)
		local btn = create("TextButton", {
			Name = "Item" .. i,
			Text = "",
			AutoButtonColor = false,
			BackgroundColor3 = T.Element,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 28),
			LayoutOrder = i,
			ZIndex = 53,
			Parent = holder,
		})
		corner(btn, 7)
		local lbl = create("TextLabel", {
			Text = name,
			BackgroundTransparency = 1,
			Font = Enum.Font.Gotham,
			TextColor3 = T.TextDim,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, -20, 1, 0),
			Position = UDim2.fromOffset(10, 0),
			ZIndex = 54,
			Parent = btn,
		})
		if item.Selected then
			lbl.TextColor3 = T.Accent
			icon(btn, "check", 13, T.Accent, {
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, -8, 0.5, 0),
				ZIndex = 54,
				Size = UDim2.fromOffset(13, 13),
			})
		end
		btn.MouseEnter:Connect(function()
			tween(btn, { BackgroundTransparency = 0.86 }, 0.12)
			lbl.TextColor3 = T.Text
		end)
		btn.MouseLeave:Connect(function()
			tween(btn, { BackgroundTransparency = 1 }, 0.12)
			lbl.TextColor3 = item.Selected and T.Accent or T.TextDim
		end)
		btn.MouseButton1Click:Connect(function()
			self:_ClosePopup()
			if item.Callback then task.spawn(item.Callback) end
			if onPick then task.spawn(onPick, item) end
		end)
	end

	tween(pop, { GroupTransparency = 0, Position = UDim2.fromOffset(x, y) }, 0.16, Enum.EasingStyle.Quart)

	local conn = catcher.MouseButton1Click:Connect(function()
		self:_ClosePopup()
	end)
	self._popupClose = conn
	return pop
end

--==============================================================================
-- 开关动画
--==============================================================================
function Nova:Open()
	if self._visible then return end
	self._visible = true
	self:_UpdateFloatingLabel()
	self.Holder.Visible = true
	if self.Fade then self.Fade.BackgroundTransparency = 0 end
	self.Holder.Size = UDim2.fromOffset(self.Config.Width * 0.94, self.Config.Height * 0.94)
	tween(self.Fade, { BackgroundTransparency = 1 }, 0.22, Enum.EasingStyle.Quart)
	tween(self.Holder, {
		Size = UDim2.fromOffset(self.Config.Width, self.Config.Height),
	}, 0.3, Enum.EasingStyle.Quart)
end

function Nova:Close()
	if not self._visible then return end
	self._visible = false
	self:_UpdateFloatingLabel()
	self:_ClosePopup()
	if self.Fade then tween(self.Fade, { BackgroundTransparency = 0 }, 0.16) end
	tween(self.Holder, {
		Size = UDim2.fromOffset(self.Config.Width * 0.95, self.Config.Height * 0.95),
	}, 0.18, Enum.EasingStyle.Quart)
	task.delay(0.2, function()
		if not self._visible then
			self.Holder.Visible = false
			self.Holder.Size = UDim2.fromOffset(self.Config.Width, self.Config.Height)
		end
	end)
end

function Nova:Toggle()
	if self._visible then
		self:Close()
	else
		self:Open()
	end
end

function Nova:IsOpen()
	return self._visible
end

--==============================================================================
-- 外部设置
--==============================================================================
function Nova:SetFloatingIcon(v)
	self.Config.FloatingIcon = v
	self:_RenderFloatingIcon()
end

function Nova:SetAvatar(v)
	self.Config.Avatar = v
	self:_RenderAvatar()
end

-- 运行时换品牌图：悬浮胶囊徽标 + 侧边栏左上角 logo 一起换
-- 传 "https://xxx.png" / "rbxassetid://xxx" / 内置图标名 / nil（还原默认）
function Nova:SetIcon(v)
	self.Config.Icon = v
	self._iconAsset = nil
	self:_LoadIcon()
	self:_RenderLogo()
	self:_RenderFloatingIcon()
end

-- 运行时换悬浮徽标的回退字母
function Nova:SetFloatLetter(v)
	self.Config.FloatLetter = v
	self:_RenderFloatingIcon()
end

function Nova:SetPlayerName(name)
	self.Config.PlayerName = name
	if self.NameLabel then self.NameLabel.Text = name or self:_PlayerName() end
end

function Nova:SetPlayerSubtitle(text)
	self.Config.PlayerSubtitle = text
	if self.SubLabel then self.SubLabel.Text = text or "" end
end

function Nova:SetBrand(text)
	self.Config.Brand = text
	self:_RenderFloatingIcon()
end

--==============================================================================
-- 悬浮提示（提示层挂在根节点，不受侧边栏滚动裁剪影响）
--==============================================================================
function Nova:_TextWidth(text, size, font)
	local w = 0
	pcall(function()
		local ts = game:GetService("TextService")
		w = ts:GetTextSize(text, size, font, Vector2.new(400, 60)).X
	end)
	if w <= 0 then
		w = #text * size * 0.58
	end
	return w
end

function Nova:_ShowTip(text, gui)
	if not self.Tip then return end
	-- 触摸设备不弹提示：手指抬起后不会触发 MouseLeave，提示会一直糊在屏幕上
	local ok, last = pcall(function() return UserInputService:GetLastInputType() end)
	if ok and last == Enum.UserInputType.Touch then return end
	self._tipToken = (self._tipToken or 0) + 1
	local w = self:_TextWidth(text, 11, Enum.Font.GothamMedium) + 20
	self.Tip.Size = UDim2.fromOffset(w, 26)
	self.TipLabel.Text = text
	local vp = self:_Viewport()
	local x = gui.AbsolutePosition.X + gui.AbsoluteSize.X + 10
	local y = gui.AbsolutePosition.Y + gui.AbsoluteSize.Y / 2
	x = math.min(x, math.max(4, vp.X - w - 6))
	y = clamp(y, 16, math.max(16, vp.Y - 16))
	self.Tip.AnchorPoint = Vector2.new(0, 0.5)
	self.Tip.Position = UDim2.fromOffset(x, y)
	self.Tip.Visible = true
	self.Tip.BackgroundTransparency = 1
	tween(self.Tip, { BackgroundTransparency = 0.02 }, 0.14)
end

function Nova:_HideTip()
	if not self.Tip then return end
	self._tipToken = (self._tipToken or 0) + 1
	local token = self._tipToken
	tween(self.Tip, { BackgroundTransparency = 1 }, 0.1)
	task.delay(0.14, function()
		if self.Tip and self._tipToken == token then
			self.Tip.Visible = false
		end
	end)
end

--==============================================================================
-- 自适应
--==============================================================================
function Nova:_Viewport()
	local cam = workspace.CurrentCamera
	if cam then
		return cam.ViewportSize
	end
	return Vector2.new(1280, 720)
end

-- 主界面大小完全跟随设备视口动态计算：基准 1560×880 作参考，
-- 屏幕越大界面越大、越小界面越小，并始终保证完整显示在屏幕内
function Nova:_ApplyScale()
	local vp = self:_Viewport()
	local w, h = self.Config.Width, self.Config.Height

	local s = math.min(vp.X / 1560, vp.Y / 880)
	s = clamp(s, self.Config.MinScale, self.Config.MaxScale)

	-- 兜底：无论什么设备都不允许超出视口
	local fit = math.min((vp.X - 28) / w, (vp.Y - 28) / h)
	if fit < s then s = math.max(fit, 0.4) end

	self.Scale = s
	if self.UIScale then
		self.UIScale.Scale = s
	end
	self:_ClampFloating()
end

function Nova:_ClampFloating()
	if not self.Floating then return end
	local vp = self:_Viewport()
	local pos = self.Floating.Position
	local ap = self.Floating.AnchorPoint
	local w = self.Floating.AbsoluteSize.X
	local h = self.Floating.AbsoluteSize.Y
	if w <= 0 then w = 176 end
	if h <= 0 then h = 44 end
	local x = pos.X.Scale * vp.X + pos.X.Offset
	local y = pos.Y.Scale * vp.Y + pos.Y.Offset
	-- 把 AnchorPoint 一起算进来，保证整颗胶囊都留在屏幕内
	local minX, minY = w * ap.X + 4, h * ap.Y + 4
	x = clamp(x, minX, math.max(minX, vp.X - w * (1 - ap.X) - 4))
	y = clamp(y, minY, math.max(minY, vp.Y - h * (1 - ap.Y) - 4))
	self.Floating.Position = UDim2.fromOffset(x, y)
end

function Nova:_HookViewport()
	local cam = workspace.CurrentCamera
	if cam then
		self._conns[#self._conns + 1] = cam:GetPropertyChangedSignal("ViewportSize"):Connect(function()
			self:_ApplyScale()
		end)
	end
	self._conns[#self._conns + 1] = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
		self:_ApplyScale()
	end)
end

function Nova:_HookKeybind()
	local key = self.Config.ToggleKey
	if not key then return end
	self._conns[#self._conns + 1] = UserInputService.InputBegan:Connect(function(input, processed)
		if processed then return end
		if input.KeyCode == key then
			self:Toggle()
		end
	end)
end

--==============================================================================
-- 搜索过滤
--==============================================================================
function Nova:_ApplyFilter()
	local q = self.SearchQuery or ""
	for i = 1, #self.PrimaryTabs do
		local tab = self.PrimaryTabs[i]
		for j = 1, #tab.Secondaries do
			tab.Secondaries[j]:Filter(q)
		end
	end
end

--==============================================================================
-- 销毁
--==============================================================================
function Nova:Destroy()
	for i = 1, #self._conns do
		pcall(function()
			self._conns[i]:Disconnect()
		end)
	end
	self._conns = {}
	if self.Root then self.Root:Destroy() end
end

--==============================================================================
-- 主侧边栏（PrimaryPane）
--==============================================================================
PrimaryPane = {}
PrimaryPane.__index = PrimaryPane

function Nova:Primary(name, iconName)
	local tab = setmetatable({}, PrimaryPane)
	tab.Library = self
	tab.Name = name
	tab.IconName = iconName
	tab.Secondaries = {}

	local T = self.Theme
	local btn = create("TextButton", {
		Name = "Primary_" .. name,
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = T.Element,
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(44, 44),
		LayoutOrder = #self.PrimaryTabs + 1,
		ZIndex = 14,
		Parent = self.PrimaryHolder,
	})
	corner(btn, 13)
	tab.Button = btn

	local accent = create("Frame", {
		Name = "Accent",
		BackgroundColor3 = T.Accent,
		Size = UDim2.new(0, 3, 0, 0),
		Position = UDim2.new(0, -8, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		ZIndex = 16,
		Parent = btn,
	})
	corner(accent, 2)
	tab.Accent = accent

	local ic = icon(btn, iconName, 20, T.TextMuted, {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		ZIndex = 15,
		Size = UDim2.fromScale(1, 1),
	})
	tab.Icon = ic

	btn.MouseEnter:Connect(function()
		if self.ActivePrimary == tab then return end
		tween(btn, { BackgroundTransparency = 0.88 }, 0.14)
		tint(ic, T.Text)
	end)
	btn.MouseLeave:Connect(function()
		if self.ActivePrimary == tab then return end
		tween(btn, { BackgroundTransparency = 1 }, 0.14)
		tint(ic, T.TextMuted)
	end)
	btn.MouseButton1Click:Connect(function()
		tab:Select()
	end)

	-- 悬浮提示（挂在根节点的提示层里，主侧边栏滚动裁剪也不会被切掉）
	btn.MouseEnter:Connect(function()
		self:_ShowTip(name, btn)
	end)
	btn.MouseLeave:Connect(function()
		self:_HideTip()
	end)

	self.PrimaryTabs[#self.PrimaryTabs + 1] = tab

	if not self.ActivePrimary then
		tab:Select()
	end
	return tab
end

function PrimaryPane:Secondary(name, iconName)
	local lib = self.Library
	local pane = setmetatable({}, SecondaryPane)
	pane.Library = lib
	pane.Primary = self
	pane.Name = name
	pane.IconName = iconName
	pane.Sections = {}
	pane.Columns = {}

	local T = lib.Theme

	-- 副标签按钮（宽度按文字实测写死，避免 AutomaticSize 在横向列表里算错）
	local tabH = lib.TabH or 30
	local labelW = math.floor(lib:_TextWidth(name, 12, Enum.Font.GothamMedium) + 0.5)
	local btnW = math.max(70, 11 + 13 + 6 + labelW + 11)

	local btn = create("TextButton", {
		Name = "Secondary_" .. name,
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(btnW, tabH),
		LayoutOrder = #self.Secondaries + 1,
		-- 默认隐藏：只有自己的主侧边栏被选中时才显示（每个主栏只展示自己的附属标签）
		Visible = false,
		ZIndex = 13,
		Parent = lib.TabScroll,
	})
	corner(btn, tabH / 2)
	list(btn, Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)

	local ic = icon(btn, iconName, 13, T.TextMuted, {
		LayoutOrder = 1,
		ZIndex = 14,
		Size = UDim2.fromOffset(13, 13),
	})
	pane.Icon = ic
	local lbl = create("TextLabel", {
		Text = name,
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		TextColor3 = T.TextMuted,
		TextSize = 12,
		Size = UDim2.fromOffset(labelW, 15),
		LayoutOrder = 2,
		ZIndex = 14,
		Parent = btn,
	})
	pane.Button = btn
	pane.Label = lbl

	btn.MouseEnter:Connect(function()
		if lib.ActiveSecondary == pane then return end
		tween(btn, { BackgroundTransparency = 0.92 }, 0.14)
		tween(lbl, { TextColor3 = T.Text }, 0.14)
		tint(ic, T.Text)
	end)
	btn.MouseLeave:Connect(function()
		if lib.ActiveSecondary == pane then return end
		tween(btn, { BackgroundTransparency = 1 }, 0.14)
		tween(lbl, { TextColor3 = T.TextMuted }, 0.14)
		tint(ic, T.TextMuted)
	end)
	btn.MouseButton1Click:Connect(function()
		pane:Select()
	end)

	-- 页面容器
	local page = create("Frame", {
		Name = "Page",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Visible = false,
		ZIndex = 12,
		Parent = lib.Content,
	})
	create("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		Padding = UDim.new(0, 14),
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		Parent = page,
	})
	pane.Page = page

	local cols = math.max(1, lib.Config.Columns)
	for i = 1, cols do
		pane.Columns[i] = create("Frame", {
			Name = "Column" .. i,
			BackgroundTransparency = 1,
			Size = UDim2.new(1 / cols, -(14 * (cols - 1)) / cols, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			LayoutOrder = i,
			ZIndex = 12,
			Parent = page,
		})
		list(pane.Columns[i], Enum.FillDirection.Vertical, 12)
	end

	self.Secondaries[#self.Secondaries + 1] = pane

	-- 这个附属标签属于当前正在展示的主栏 → 立刻显示出来
	if lib.ActivePrimary == self then
		btn.Visible = true
	end
	lib:_RefreshTabs()

	if not lib.ActiveSecondary then
		pane:Select()
	end
	return pane
end

function PrimaryPane:Select()
	local lib = self.Library
	if lib.ActivePrimary == self then
		if lib.ActiveSecondary and lib.ActiveSecondary.Primary ~= self then
			lib.ActiveSecondary:Select()
		end
		return
	end

	local T = lib.Theme
	local prev = lib.ActivePrimary
	if prev then
		tween(prev.Button, { BackgroundTransparency = 1 }, 0.16)
		tween(prev.Accent, { BackgroundTransparency = 1, Size = UDim2.new(0, 3, 0, 0) }, 0.16)
		tint(prev.Icon, T.TextMuted)
		-- 收起上一个主栏的附属标签和内容页
		for i = 1, #prev.Secondaries do
			prev.Secondaries[i].Button.Visible = false
			prev.Secondaries[i].Page.Visible = false
		end
	end

	lib.ActivePrimary = self
	tween(self.Button, { BackgroundColor3 = T.Accent, BackgroundTransparency = 0.86 }, 0.18)
	tween(self.Accent, { BackgroundTransparency = 0, Size = UDim2.new(0, 3, 0, 18) }, 0.22, Enum.EasingStyle.Quint)
	tint(self.Icon, T.Text)

	-- 顶部标签条换成这个主栏自己的附属标签
	for i = 1, #self.Secondaries do
		self.Secondaries[i].Button.Visible = true
	end
	lib:_RefreshTabs()

	if self.Secondaries[1] then
		self.Secondaries[1]:Select()
	elseif lib.ActiveSecondary then
		lib.ActiveSecondary.Page.Visible = false
		lib.ActiveSecondary = nil
	end
end

function PrimaryPane:SelectSecondary(index)
	local pane = self.Secondaries[index]
	if pane then pane:Select() end
end

--==============================================================================
-- 副侧边栏（SecondaryPane）
--==============================================================================
SecondaryPane = {}
SecondaryPane.__index = SecondaryPane

function SecondaryPane:Section(title)
	local lib = self.Library
	local T = lib.Theme

	local index = #self.Sections + 1
	local count = #self.Columns
	local target = self.Columns[((index - 1) % count) + 1]

	local card = create("Frame", {
		Name = "Section_" .. (title or index),
		BackgroundColor3 = T.Card,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		LayoutOrder = index,
		ZIndex = 13,
		Parent = target,
	})
	corner(card, 12)
	stroke(card, T.Stroke, 1, T.StrokeT)
	padding(card, 12, 12, 12, 12)
	list(card, Enum.FillDirection.Vertical, 8)

	-- 卡片头
	local head = create("Frame", {
		Name = "Head",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 20),
		LayoutOrder = 1,
		ZIndex = 14,
		Parent = card,
	})
	create("Frame", {
		Name = "Dot",
		BackgroundColor3 = T.Accent,
		Size = UDim2.fromOffset(5, 5),
		Position = UDim2.new(0, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BorderSizePixel = 0,
		ZIndex = 15,
		Parent = head,
	})
	local dot = head:FindFirstChild("Dot")
	corner(dot, 2.5)
	create("TextLabel", {
		Name = "Title",
		Text = title or "Section",
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextColor3 = T.Text,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, -14, 1, 0),
		Position = UDim2.fromOffset(12, 0),
		ZIndex = 15,
		Parent = head,
	})

	local rows = create("Frame", {
		Name = "Rows",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		LayoutOrder = 2,
		ZIndex = 14,
		Parent = card,
	})
	list(rows, Enum.FillDirection.Vertical, 0)

	local section = setmetatable({}, Section)
	section.Library = lib
	section.Pane = self
	section.Title = title
	section.Card = card
	section.Rows = rows
	section.RowList = {}
	section.Index = index

	self.Sections[index] = section
	return section
end

function SecondaryPane:Select()
	local lib = self.Library
	local T = lib.Theme
	if lib.ActiveSecondary == self then return end

	local prev = lib.ActiveSecondary
	if prev then
		tween(prev.Button, { BackgroundTransparency = 1 }, 0.16)
		tween(prev.Label, { TextColor3 = T.TextMuted }, 0.16)
		tint(prev.Icon, T.TextMuted)
		prev.Page.Visible = false
	end

	lib.ActiveSecondary = self
	tween(self.Button, { BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.87 }, 0.18)
	tween(self.Label, { TextColor3 = T.Text }, 0.18)
	tint(self.Icon, T.Text)
	self.Page.Visible = true

	lib.Content.CanvasPosition = Vector2.new(0, 0)
	lib:_ApplyFilter()
end

function SecondaryPane:Filter(query)
	local visibleSections = 0
	for i = 1, #self.Sections do
		local sec = self.Sections[i]
		local count = sec:_Filter(query)
		if count > 0 then
			visibleSections = visibleSections + 1
			sec.Card.Visible = true
		else
			sec.Card.Visible = false
		end
	end
	return visibleSections
end

--==============================================================================
-- 分组（Section）
--==============================================================================
Section = {}
Section.__index = Section

local rowCounter = 0

function Section:_Row(cfg, height, title, desc, mode)
	local T = self.Library.Theme
	rowCounter = rowCounter + 1
	local plain = (mode == "plain" or mode == "bare")

	local row = create("Frame", {
		Name = "Row",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, height),
		LayoutOrder = rowCounter,
		ZIndex = 14,
		Parent = self.Rows,
	})

	if #self.RowList > 0 and mode ~= "bare" then
		create("Frame", {
			Name = "Divider",
			BackgroundColor3 = T.Stroke,
			BackgroundTransparency = 0.94,
			Size = UDim2.new(1, 0, 0, 1),
			Position = UDim2.fromOffset(0, 0),
			BorderSizePixel = 0,
			ZIndex = 14,
			Parent = row,
		})
	end

	if title and not plain then
		create("TextLabel", {
			Name = "Title",
			Text = title,
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamMedium,
			TextColor3 = T.Text,
			TextSize = 12.5,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Size = UDim2.new(1, -150, 0, 15),
			Position = UDim2.fromOffset(0, desc and 8 or (height - 15) / 2),
			ZIndex = 15,
			Parent = row,
		})
	end
	if desc and not plain then
		create("TextLabel", {
			Name = "Desc",
			Text = desc,
			BackgroundTransparency = 1,
			Font = Enum.Font.Gotham,
			TextColor3 = T.TextMuted,
			TextSize = 10.5,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Size = UDim2.new(1, -150, 0, 13),
			Position = UDim2.fromOffset(0, 23),
			ZIndex = 15,
			Parent = row,
		})
	end

	local right = create("Frame", {
		Name = "Right",
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(10, height),
		Position = UDim2.new(1, 0, 0, 0),
		AnchorPoint = Vector2.new(1, 0),
		ZIndex = 15,
		Parent = row,
	})

	local entry = {
		Row = row,
		Title = string.lower(title or ""),
		Desc = string.lower(desc or ""),
	}
	self.RowList[#self.RowList + 1] = entry
	return row, right, entry
end

function Section:_Filter(query)
	if not query or query == "" then
		for i = 1, #self.RowList do
			self.RowList[i].Row.Visible = true
		end
		return #self.RowList
	end
	local shown = 0
	for i = 1, #self.RowList do
		local e = self.RowList[i]
		local hit = string.find(e.Title, query, 1, true) or string.find(e.Desc, query, 1, true)
		e.Row.Visible = hit ~= nil
		if hit then shown = shown + 1 end
	end
	return shown
end

--=== 开关 ===
function Section:Toggle(cfg)
	cfg = cfg or {}
	local lib = self.Library
	local T = lib.Theme

	local row, right = self:_Row(cfg, cfg.Menu and 50 or 46, cfg.Title, cfg.Desc)

	local menuIcon
	if cfg.Menu then
		local mb = create("TextButton", {
			Name = "Menu",
			Text = "",
			AutoButtonColor = false,
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(24, 24),
			Position = UDim2.new(1, -46, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			ZIndex = 16,
			Parent = row,
		})
		menuIcon = icon(mb, "more", 14, T.TextMuted, {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			ZIndex = 17,
			Size = UDim2.fromOffset(14, 14),
		})
		mb.MouseEnter:Connect(function()
			tint(menuIcon, T.Text)
		end)
		mb.MouseLeave:Connect(function()
			tint(menuIcon, T.TextMuted)
		end)
		mb.MouseButton1Click:Connect(function()
			lib:_Popup(mb, 170, cfg.Menu)
		end)
	end

	local switch = create("TextButton", {
		Name = "Switch",
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = T.Element,
		Size = UDim2.fromOffset(40, 22),
		Position = UDim2.new(1, 0, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		ZIndex = 16,
		Parent = row,
	})
	corner(switch, 11)
	stroke(switch, T.Stroke, 1, 0.9)
	local swGrad = create("UIGradient", {
		Color = ColorSequence.new(T.Accent, T.Accent2),
		Rotation = 0,
		Transparency = NumberSequence.new(1),
		Parent = switch,
	})
	-- 推子：16×16，四周各留 3px，左右滑动都不会越出轨道
	local knob = create("Frame", {
		Name = "Knob",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.15,
		Size = UDim2.fromOffset(16, 16),
		Position = UDim2.fromOffset(3, 3),
		ZIndex = 17,
		Parent = switch,
	})
	corner(knob, 8)

	local obj = {}
	obj.Value = cfg.Default == true
	obj.Callback = cfg.Callback
	obj.Flag = cfg.Flag
	obj.Switch = switch
	obj.Knob = knob
	obj.Gradient = swGrad

	function obj:Set(v, fire)
		self.Value = v and true or false
		tween(knob, {
			Position = self.Value and UDim2.fromOffset(21, 3) or UDim2.fromOffset(3, 3),
			BackgroundColor3 = self.Value and T.Ink or Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = self.Value and 0 or 0.12,
		}, 0.18, Enum.EasingStyle.Quart)
		tween(switch, { BackgroundColor3 = self.Value and T.Accent or T.Element }, 0.18)
		self.Gradient.Transparency = NumberSequence.new(self.Value and 0 or 1)
		if fire and self.Callback then
			task.spawn(self.Callback, self.Value)
		end
	end

	obj:Set(obj.Value, false)
	if cfg.Flag then Nova.Flags[cfg.Flag] = obj.Value end

	switch.MouseEnter:Connect(function()
		if not obj.Value then tween(switch, { BackgroundColor3 = T.ElementHover }, 0.14) end
	end)
	switch.MouseLeave:Connect(function()
		if not obj.Value then tween(switch, { BackgroundColor3 = T.Element }, 0.14) end
	end)
	switch.MouseButton1Click:Connect(function()
		obj:Set(not obj.Value, true)
		if cfg.Flag then Nova.Flags[cfg.Flag] = obj.Value end
	end)

	return obj
end

--=== 滑块 ===
function Section:Slider(cfg)
	cfg = cfg or {}
	local lib = self.Library
	local T = lib.Theme

	local min = cfg.Min or 0
	local max = cfg.Max or 100
	if max <= min then max = min + 1 end
	local step = cfg.Step or 1
	local default = cfg.Default or min

	local row, right = self:_Row(cfg, 54, cfg.Title, cfg.Desc)

	local valueLabel = create("TextLabel", {
		Name = "Value",
		Text = "",
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		TextColor3 = T.TextDim,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Right,
		Size = UDim2.fromOffset(58, 16),
		Position = UDim2.new(1, -6, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		ZIndex = 16,
		Parent = row,
	})

	local track = create("Frame", {
		Name = "Track",
		BackgroundColor3 = T.Element,
		Size = UDim2.fromOffset(150, 10),
		Position = UDim2.new(1, -70, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		BorderSizePixel = 0,
		ZIndex = 16,
		Parent = row,
	})
	corner(track, 3)
	stroke(track, T.Stroke, 1, 0.9)

	local fill = create("Frame", {
		Name = "Fill",
		BackgroundColor3 = T.Accent,
		Size = UDim2.new(0, 0, 1, 0),
		BorderSizePixel = 0,
		ZIndex = 17,
		Parent = track,
	})
	corner(fill, 3)
	gradient(fill, T.Accent, T.Accent2, 0)

	-- 长方形推子：白底轨上深色块，灰轨上也看得清
	local knob = create("Frame", {
		Name = "Knob",
		BackgroundColor3 = T.Ink,
		Size = UDim2.fromOffset(12, 20),
		Position = UDim2.new(0, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		ZIndex = 18,
		Parent = track,
	})
	corner(knob, 4)
	stroke(knob, Color3.fromRGB(255, 255, 255), 1.5, 0.25)

	local function fmt(v)
		if cfg.Format then return cfg.Format(v) end
		local s
		if step >= 1 then
			s = string.format("%d", math.floor(v + 0.5))
		else
			s = string.format("%.1f", v)
		end
		return s .. (cfg.Suffix or "")
	end

	local obj = {}
	obj.Value = default
	obj.Callback = cfg.Callback
	obj.Flag = cfg.Flag

	function obj:Render()
		local alpha = (self.Value - min) / (max - min)
		fill.Size = UDim2.new(alpha, 0, 1, 0)
		knob.Position = UDim2.new(alpha, 0, 0.5, 0)
		valueLabel.Text = fmt(self.Value)
	end

	function obj:Set(v, fire)
		v = clamp(v, min, max)
		if step > 0 then
			v = min + math.floor((v - min) / step + 0.5) * step
			v = clamp(v, min, max)
		end
		self.Value = v
		self:Render()
		if fire and self.Callback then
			task.spawn(self.Callback, v)
		end
	end

	obj:Render()
	if cfg.Flag then Nova.Flags[cfg.Flag] = obj.Value end

	local dragging = false
	local function fromInput(x)
		local rel = x - track.AbsolutePosition.X
		if track.AbsoluteSize.X <= 0 then return end
		rel = clamp(rel / track.AbsoluteSize.X, 0, 1)
		obj:Set(min + rel * (max - min), true)
		if cfg.Flag then Nova.Flags[cfg.Flag] = obj.Value end
	end

	local hit = create("TextButton", {
		Name = "Hit",
		Text = "",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 14),
		Position = UDim2.new(0, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		ZIndex = 19,
		Parent = track,
	})
	hit.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			fromInput(input.Position.X)
			tween(knob, { Size = UDim2.fromOffset(12, 22) }, 0.12, Enum.EasingStyle.Back)
			tween(valueLabel, { TextColor3 = T.Accent }, 0.12)
		end
	end)
	hit.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
			tween(knob, { Size = UDim2.fromOffset(12, 20) }, 0.14, Enum.EasingStyle.Back)
			tween(valueLabel, { TextColor3 = T.TextDim }, 0.14)
		end
	end)
	lib._conns[#lib._conns + 1] = UserInputService.InputChanged:Connect(function(input)
		if not dragging then return end
		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then
			fromInput(input.Position.X)
		end
	end)
	track.MouseEnter:Connect(function()
		tween(valueLabel, { TextColor3 = T.Text }, 0.12)
	end)
	track.MouseLeave:Connect(function()
		if not dragging then tween(valueLabel, { TextColor3 = T.TextDim }, 0.12) end
	end)

	return obj
end

--=== 下拉框 ===
function Section:Dropdown(cfg)
	cfg = cfg or {}
	local lib = self.Library
	local T = lib.Theme
	local options = cfg.Options or {}

	local row, right = self:_Row(cfg, 54, cfg.Title, cfg.Desc)

	local field = create("TextButton", {
		Name = "Field",
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = T.Element,
		Size = UDim2.fromOffset(150, 32),
		Position = UDim2.new(1, 0, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		ZIndex = 16,
		Parent = row,
	})
	corner(field, 9)
	local fieldStroke = stroke(field, T.Stroke, 1, 0.9)

	local valueLabel = create("TextLabel", {
		Name = "Value",
		Text = "",
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextColor3 = T.Text,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Size = UDim2.new(1, -34, 1, 0),
		Position = UDim2.fromOffset(12, 0),
		ZIndex = 17,
		Parent = field,
	})
	local chev = icon(field, "chevron", 12, T.TextMuted, {
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -10, 0.5, 0),
		ZIndex = 17,
		Size = UDim2.fromOffset(12, 12),
	})

	local obj = {}
	obj.Value = cfg.Default or options[1]
	obj.Callback = cfg.Callback
	obj.Flag = cfg.Flag

	local function render()
		valueLabel.Text = tostring(obj.Value or "None")
	end

	function obj:Set(v, fire)
		self.Value = v
		render()
		if fire and self.Callback then
			task.spawn(self.Callback, v)
		end
	end

	render()
	if cfg.Flag then Nova.Flags[cfg.Flag] = obj.Value end

	field.MouseEnter:Connect(function()
		tween(field, { BackgroundColor3 = T.ElementHover }, 0.14)
	end)
	field.MouseLeave:Connect(function()
		tween(field, { BackgroundColor3 = T.Element }, 0.14)
	end)
	field.MouseButton1Click:Connect(function()
		local items = {}
		for i = 1, #options do
			items[i] = {
				Name = tostring(options[i]),
				Selected = (options[i] == obj.Value),
				Callback = function()
					obj:Set(options[i], true)
					if cfg.Flag then Nova.Flags[cfg.Flag] = obj.Value end
				end,
			}
		end
		lib:_Popup(field, 170, items)
	end)

	return obj
end

--=== 按钮 ===
function Section:Button(cfg)
	cfg = cfg or {}
	local T = self.Library.Theme

	local row = self:_Row(cfg, 50, cfg.Title, cfg.Desc)

	local btn = create("TextButton", {
		Name = "Button",
		Text = cfg.Text or "Execute",
		AutoButtonColor = false,
		BackgroundColor3 = T.Accent,
		Font = Enum.Font.GothamBold,
		TextColor3 = T.Ink,
		TextSize = 12,
		Size = UDim2.fromOffset(100, 30),
		Position = UDim2.new(1, 0, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		ZIndex = 16,
		Parent = row,
	})
	corner(btn, 9)
	local grad = gradient(btn, T.Accent, T.Accent2, 0)
	local bStroke = stroke(btn, Color3.fromRGB(0, 0, 0), 1, 0.82)

	btn.MouseEnter:Connect(function()
		grad.Transparency = NumberSequence.new(0.12)
		tween(bStroke, { Transparency = 0.6 }, 0.12)
	end)
	btn.MouseLeave:Connect(function()
		grad.Transparency = NumberSequence.new(0)
		tween(bStroke, { Transparency = 0.82 }, 0.12)
	end)
	btn.MouseButton1Click:Connect(function()
		if cfg.Callback then task.spawn(cfg.Callback) end
	end)

	return btn
end

--=== 标签 ===
function Section:Label(cfg)
	cfg = cfg or {}
	local T = self.Library.Theme

	local row = self:_Row(cfg, 0, cfg.Text or "", cfg.Desc, "plain")
	row.Size = UDim2.new(1, 0, 0, 0)
	row.AutomaticSize = Enum.AutomaticSize.Y

	local lbl = create("TextLabel", {
		Name = "Text",
		Text = cfg.Text or "",
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextColor3 = T.TextDim,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		TextWrapped = true,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		ZIndex = 15,
		Parent = row,
	})
	return lbl
end

--=== 分割线 ===
function Section:Divider(cfg)
	cfg = cfg or {}
	local T = self.Library.Theme
	local row = self:_Row(cfg, 12, nil, nil, "bare")
	local line = create("Frame", {
		Name = "Line",
		BackgroundColor3 = T.Stroke,
		BackgroundTransparency = 0.9,
		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.new(0, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BorderSizePixel = 0,
		ZIndex = 15,
		Parent = row,
	})
	return line
end

--=== 按键绑定 ===
function Section:Keybind(cfg)
	cfg = cfg or {}
	local lib = self.Library
	local T = lib.Theme

	local row = self:_Row(cfg, 54, cfg.Title, cfg.Desc)

	local box = create("TextButton", {
		Name = "Key",
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = T.Element,
		Size = UDim2.fromOffset(110, 30),
		Position = UDim2.new(1, 0, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		ZIndex = 16,
		Parent = row,
	})
	corner(box, 9)
	local boxStroke = stroke(box, T.Stroke, 1, 0.9)

	local label = create("TextLabel", {
		Text = "None",
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		TextColor3 = T.Text,
		TextSize = 12,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 17,
		Parent = box,
	})

	local obj = {}
	obj.Value = cfg.Default
	obj.Callback = cfg.Callback
	obj.Listening = false

	local function render()
		if obj.Listening then
			label.Text = "Press a key..."
			label.TextColor3 = T.Accent
		elseif obj.Value then
			label.Text = tostring(obj.Value.Name or obj.Value)
			label.TextColor3 = T.Text
		else
			label.Text = "None"
			label.TextColor3 = T.TextDim
		end
	end
	render()

	function obj:Set(key, fire)
		self.Value = key
		self.Listening = false
		render()
		if fire and self.Callback then
			task.spawn(self.Callback, key)
		end
	end

	box.MouseButton1Click:Connect(function()
		obj.Listening = true
		render()
		tween(boxStroke, { Transparency = 0.35 }, 0.14)
	end)

	lib._conns[#lib._conns + 1] = UserInputService.InputBegan:Connect(function(input, processed)
		if not obj.Listening then return end
		if input.KeyCode == Enum.KeyCode.Unknown then return end
		obj:Set(input.KeyCode, true)
		tween(boxStroke, { Transparency = 0.9 }, 0.14)
	end)

	return obj
end

--=== 输入框 ===
function Section:Input(cfg)
	cfg = cfg or {}
	local T = self.Library.Theme

	local row = self:_Row(cfg, 54, cfg.Title, cfg.Desc)

	local box = create("Frame", {
		Name = "InputBox",
		BackgroundColor3 = T.Element,
		Size = UDim2.fromOffset(170, 32),
		Position = UDim2.new(1, 0, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		ZIndex = 16,
		Parent = row,
	})
	corner(box, 9)
	local boxStroke = stroke(box, T.Stroke, 1, 0.9)

	local inner = create("TextBox", {
		Name = "Input",
		Text = cfg.Default or "",
		PlaceholderText = cfg.Placeholder or "Type here...",
		PlaceholderColor3 = T.TextMuted,
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextColor3 = T.Text,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false,
		Size = UDim2.new(1, -20, 1, 0),
		Position = UDim2.fromOffset(10, 0),
		ZIndex = 17,
		Parent = box,
	})

	local obj = {}
	obj.Value = cfg.Default or ""

	inner.Focused:Connect(function()
		tween(boxStroke, { Transparency = 0.4 }, 0.14)
	end)
	inner.FocusLost:Connect(function()
		tween(boxStroke, { Transparency = 0.9 }, 0.14)
		obj.Value = inner.Text
		if cfg.Callback then task.spawn(cfg.Callback, inner.Text) end
	end)

	function obj:Set(v)
		self.Value = v or ""
		inner.Text = self.Value
	end

	return obj
end

return Nova
