--[[
================================================================================
  Nova UI  ·  现代化 Roblox UI 库
--------------------------------------------------------------------------------
  版本 : 1.0.0
  语法 : 兼容 Lua 5.1 / Roblox Luau
  特性 :
    · 悬浮球（图片可自定义，点击开关主界面，可拖动）
    · 主侧边栏 + 副侧边栏（一个主栏可挂多个副栏）
    · 左上角玩家头像 + 玩家名字（均可自定义）
    · 内置图标库，也可用 rbxassetid 覆盖
    · 开关 / 滑块 / 下拉 / 按钮 / 标签 / 分割线 / 按键绑定 / 输入框
    · 卡片分栏布局、实时搜索、悬浮提示、通知中心
    · 自适应分辨率（按视口自动缩放）
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
Nova.Version = "1.0.0"
Nova.Flags   = {}

--==============================================================================
-- 主题
--==============================================================================
Nova.Theme = {
	Window      = Color3.fromRGB(17, 18, 23),
	Sidebar     = Color3.fromRGB(13, 14, 18),
	Header      = Color3.fromRGB(17, 18, 23),
	Panel       = Color3.fromRGB(21, 23, 29),
	Card        = Color3.fromRGB(24, 26, 33),
	CardHover   = Color3.fromRGB(29, 32, 40),
	Element     = Color3.fromRGB(34, 37, 46),
	ElementHover= Color3.fromRGB(44, 48, 59),

	Stroke      = Color3.fromRGB(255, 255, 255),
	StrokeT     = 0.93,
	StrokeT2    = 0.88,

	Text        = Color3.fromRGB(240, 243, 250),
	TextDim     = Color3.fromRGB(154, 161, 176),
	TextMuted   = Color3.fromRGB(103, 110, 126),

	Good        = Color3.fromRGB(88, 214, 148),
	Warn        = Color3.fromRGB(255, 190, 92),
	Bad         = Color3.fromRGB(255, 96, 96),
}

--==============================================================================
-- 内置图标库（用几何符号，避免彩色 emoji；可整体替换为 rbxassetid）
--==============================================================================
Nova.Icons = {
	default       = "◈",
	shield        = "◈",
	eye           = "◎",
	target        = "⊙",
	hand          = "✦",
	cursor        = "✥",
	folder        = "▤",
	settings      = "⚙",
	sliders       = "☰",
	layers        = "▦",
	search        = "⌕",
	close         = "✕",
	minimize      = "－",
	check         = "✓",
	chevron       = "⌄",
	chevronRight  = "›",
	dot           = "•",
	star          = "★",
	bolt          = "⌁",
	lock          = "▣",
	user          = "◉",
	code          = "⌘",
	link          = "⇄",
	refresh       = "↻",
	clock         = "◷",
	flag          = "⚑",
	plus          = "＋",
	palette       = "◐",
	info          = "◍",
	warn          = "△",
	power         = "⏻",
	home          = "⌂",
	grid          = "▩",
}

--==============================================================================
-- 默认配置
--==============================================================================
Nova.Defaults = {
	Title          = "Nova",
	Subtitle       = "",
	Icon           = nil,                  -- 侧边栏顶部 logo（图片/图标名）
	PlayerName     = nil,                  -- 默认取显示名
	PlayerSubtitle = "Premium Edition",
	Avatar         = nil,                  -- 默认取 Roblox 头像
	FloatingIcon   = nil,                  -- 悬浮球图片
	Accent         = Color3.fromRGB(255, 62, 92),
	Accent2        = Color3.fromRGB(255, 130, 76),
	ToggleKey      = Enum.KeyCode.RightShift,
	Columns        = 2,
	Width          = 930,
	Height         = 585,
	MinScale       = 0.62,
	MaxScale       = 1.15,
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

-- 渲染图标：图标名 -> 几何字形；rbxassetid/rbxthumb -> 图片
local function icon(parent, name, size, color, props)
	local glyph = Nova.Icons[name] or name or Nova.Icons.default
	local inst
	if isAsset(glyph) then
		inst = create("ImageLabel", {
			Image = glyph,
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(size, size),
			ImageColor3 = color or Nova.Theme.Text,
			Parent = parent,
		})
	else
		inst = create("TextLabel", {
			Text = glyph,
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamMedium,
			TextColor3 = color or Nova.Theme.Text,
			TextSize = math.floor((size or 16) * 1.05),
			Size = UDim2.fromOffset((size or 16) + 6, size or 16),
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			Parent = parent,
		})
	end
	if props then
		for k, v in pairs(props) do inst[k] = v end
	end
	return inst
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

	self:_BuildRoot()
	self:_BuildFloating()
	self:_BuildWindow()
	self:_BuildNotificationHost()
	self:_ApplyScale()
	self:_HookViewport()
	self:_HookKeybind()

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

	-- 假阴影：两层偏移的深色圆角块
	create("Frame", {
		Name = "Shadow2",
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.72,
		Size = UDim2.new(1, 26, 1, 30),
		Position = UDim2.fromOffset(-13, -6),
		ZIndex = 8,
		Parent = self.Holder,
	})
	create("Frame", {
		Name = "Shadow1",
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.62,
		Size = UDim2.new(1, 14, 1, 16),
		Position = UDim2.fromOffset(-7, -3),
		ZIndex = 9,
		Parent = self.Holder,
	})
	local c1 = self.Holder:FindFirstChild("Shadow2")
	if c1 then corner(c1, 22) end
	local c2 = self.Holder:FindFirstChild("Shadow1")
	if c2 then corner(c2, 18) end

	-- 窗口主体
	self.Window = create("CanvasGroup", {
		Name = "Window",
		BackgroundColor3 = self.Theme.Window,
		Size = UDim2.fromScale(1, 1),
		GroupTransparency = 1,
		ZIndex = 10,
		Parent = self.Holder,
	})
	corner(self.Window, 14)
	stroke(self.Window, self.Theme.Stroke, 1, self.Theme.StrokeT)

	-- 顶部一条 Accent 渐隐光线
	local accentBar = create("Frame", {
		Name = "AccentBar",
		BackgroundColor3 = self.Theme.Accent,
		Size = UDim2.new(0.42, 0, 0, 2),
		Position = UDim2.new(0.5, 0, 0, 0),
		AnchorPoint = Vector2.new(0.5, 0),
		BorderSizePixel = 0,
		BackgroundTransparency = 0.25,
		ZIndex = 12,
		Parent = self.Window,
	})
	gradient(accentBar, self.Theme.Accent, self.Theme.Accent2, 0)

	self.UIScale = create("UIScale", { Scale = 1, Parent = self.Holder })
end

--==============================================================================
-- 悬浮球
--==============================================================================
function Nova:_BuildFloating()
	local SIZE = 54

	self.Floating = create("CanvasGroup", {
		Name = "Floating",
		BackgroundColor3 = self.Theme.Accent,
		Size = UDim2.fromOffset(SIZE, SIZE),
		Position = UDim2.new(1, -(SIZE + 26), 0.5, -SIZE / 2),
		GroupTransparency = 0,
		ZIndex = 30,
		Parent = self.Root,
	})
	corner(self.Floating, SIZE / 2)
	gradient(self.Floating, self.Theme.Accent, self.Theme.Accent2, 45)
	stroke(self.Floating, self.Theme.Stroke, 1, 0.82)

	-- 外发光
	self.FloatingGlow = create("Frame", {
		Name = "Glow",
		BackgroundColor3 = self.Theme.Accent,
		BackgroundTransparency = 0.86,
		Size = UDim2.fromOffset(SIZE + 14, SIZE + 14),
		Position = UDim2.fromOffset(-7, -7),
		ZIndex = 0,
		Parent = self.Floating,
	})
	corner(self.FloatingGlow, (SIZE + 14) / 2)

	self.FloatingIconHolder = create("Frame", {
		Name = "IconHolder",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 2,
		Parent = self.Floating,
	})
	self:_RenderFloatingIcon()

	-- 悬停反馈
	self.Floating.MouseEnter:Connect(function()
		tween(self.Floating, { Size = UDim2.fromOffset(SIZE + 5, SIZE + 5) }, 0.18, Enum.EasingStyle.Back)
		tween(self.FloatingGlow, { BackgroundTransparency = 0.72 }, 0.18)
	end)
	self.Floating.MouseLeave:Connect(function()
		tween(self.Floating, { Size = UDim2.fromOffset(SIZE, SIZE) }, 0.18, Enum.EasingStyle.Back)
		tween(self.FloatingGlow, { BackgroundTransparency = 0.86 }, 0.18)
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
	local old = holder:FindFirstChild("I")
	if old then old:Destroy() end

	local cfg = self.Config.FloatingIcon
	if isAsset(cfg) then
		local img = create("ImageLabel", {
			Name = "I",
			Image = cfg,
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(26, 26),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			ZIndex = 3,
			Parent = holder,
		})
		return img
	end

	local glyph = Nova.Icons[cfg] or Nova.Icons.default
	local lbl = create("TextLabel", {
		Name = "I",
		Text = glyph,
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 24,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(1, 1),
		ZIndex = 3,
		Parent = holder,
	})
	return lbl
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

	-- 侧边栏 logo
	local logo = create("Frame", {
		Name = "Logo",
		BackgroundColor3 = T.Accent,
		Size = UDim2.fromOffset(40, 40),
		Position = UDim2.new(0, 14, 0, 18),
		ZIndex = 13,
		Parent = self.Sidebar,
	})
	corner(logo, 12)
	gradient(logo, T.Accent, T.Accent2, 45)
	if self.Config.Icon and isAsset(self.Config.Icon) then
		create("ImageLabel", {
			Image = self.Config.Icon,
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(20, 20),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			ZIndex = 14,
			Parent = logo,
		})
	else
		icon(logo, self.Config.Icon or "default", 18, Color3.fromRGB(255, 255, 255), {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			ZIndex = 14,
			Size = UDim2.fromScale(1, 1),
		})
	end

	-- 主栏按钮容器
	self.PrimaryHolder = create("Frame", {
		Name = "PrimaryHolder",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, -150),
		Position = UDim2.fromOffset(0, 74),
		ZIndex = 13,
		Parent = self.Sidebar,
	})
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
		Size = UDim2.new(1, 0, 0, 66),
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
		Size = UDim2.fromOffset(38, 38),
		Position = UDim2.new(0, 18, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		ZIndex = 13,
		Parent = header,
	})
	corner(self.AvatarHolder, 12)
	stroke(self.AvatarHolder, T.Accent, 1.5, 0.35)
	self:_RenderAvatar()

	-- 左上角：玩家名字 + 副标题
	self.NameLabel = create("TextLabel", {
		Name = "PlayerName",
		Text = self:_PlayerName(),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextColor3 = T.Text,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(0, 220, 0, 17),
		Position = UDim2.fromOffset(66, 16),
		ZIndex = 13,
		Parent = header,
	})
	self.SubLabel = create("TextLabel", {
		Name = "PlayerSubtitle",
		Text = self.Config.PlayerSubtitle,
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextColor3 = T.TextMuted,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(0, 220, 0, 14),
		Position = UDim2.fromOffset(66, 34),
		ZIndex = 13,
		Parent = header,
	})

	-- 顶栏右侧按钮
	local function headerButton(name, glyph, hoverColor)
		local b = create("TextButton", {
			Name = name,
			Text = "",
			AutoButtonColor = false,
			BackgroundColor3 = T.Element,
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(32, 32),
			AnchorPoint = Vector2.new(1, 0.5),
			ZIndex = 13,
			Parent = header,
		})
		corner(b, 10)
		local ic = icon(b, glyph, 15, T.TextDim, {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			ZIndex = 14,
			Size = UDim2.fromScale(1, 1),
		})
		b.MouseEnter:Connect(function()
			tween(b, { BackgroundTransparency = 0.9 }, 0.14)
			if ic:IsA("TextLabel") then ic.TextColor3 = hoverColor or T.Text end
		end)
		b.MouseLeave:Connect(function()
			tween(b, { BackgroundTransparency = 1 }, 0.14)
			if ic:IsA("TextLabel") then ic.TextColor3 = T.TextDim end
		end)
		return b, ic
	end

	local closeBtn = headerButton("Close", "close", T.Bad)
	closeBtn.Position = UDim2.new(1, -14, 0.5, 0)
	closeBtn.MouseButton1Click:Connect(function() self:Close() end)

	local minBtn = headerButton("Minimize", "minimize", T.Text)
	minBtn.Position = UDim2.new(1, -52, 0.5, 0)

	-- 搜索框
	local searchBox = create("Frame", {
		Name = "SearchBox",
		BackgroundColor3 = T.Element,
		BackgroundTransparency = 0.35,
		Size = UDim2.fromOffset(180, 32),
		Position = UDim2.new(1, -100, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		ZIndex = 13,
		Parent = header,
	})
	corner(searchBox, 10)
	local sbStroke = stroke(searchBox, T.Stroke, 1, 0.88)
	icon(searchBox, "search", 14, T.TextMuted, {
		Position = UDim2.fromOffset(10, 9),
		ZIndex = 14,
		Size = UDim2.fromOffset(14, 14),
	})
	local searchInput = create("TextBox", {
		Name = "Input",
		Text = "",
		PlaceholderText = "Search...",
		PlaceholderColor3 = T.TextMuted,
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham,
		TextColor3 = T.Text,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false,
		Size = UDim2.new(1, -34, 1, 0),
		Position = UDim2.fromOffset(30, 0),
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

	-- 副侧边栏（横向标签条）
	local tabBar = create("Frame", {
		Name = "TabBar",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 42),
		Position = UDim2.fromOffset(0, 66),
		ZIndex = 12,
		Parent = main,
	})
	self.TabScroll = create("ScrollingFrame", {
		Name = "TabScroll",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, -28, 1, 0),
		Position = UDim2.fromOffset(14, 0),
		CanvasSize = UDim2.fromOffset(0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.X,
		ScrollingDirection = Enum.ScrollingDirection.X,
		ScrollBarThickness = 0,
		ElasticBehavior = Enum.ElasticBehavior.Never,
		ZIndex = 12,
		Parent = tabBar,
	})
	list(self.TabScroll, Enum.FillDirection.Horizontal, 6, Enum.HorizontalAlignment.Left, Enum.VerticalAlignment.Center)

	-- 内容区
	self.Content = create("ScrollingFrame", {
		Name = "Content",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, -28, 1, -122),
		Position = UDim2.fromOffset(14, 112),
		CanvasSize = UDim2.fromOffset(0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = T.Accent,
		ScrollBarImageTransparency = 0.55,
		ElasticBehavior = Enum.ElasticBehavior.Never,
		ZIndex = 12,
		Parent = main,
	})
end

function Nova:_PlayerName()
	if self.Config.PlayerName then return self.Config.PlayerName end
	if LocalPlayer then
		local ok, name = pcall(function() return LocalPlayer.DisplayName end)
		if ok and name then return name end
	end
	return "Player"
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
			Size = UDim2.fromScale(1, 1),
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
	self.Holder.Visible = true
	self.Window.GroupTransparency = 1
	self.Holder.Size = UDim2.fromOffset(self.Config.Width * 0.94, self.Config.Height * 0.94)
	tween(self.Window, { GroupTransparency = 0 }, 0.22, Enum.EasingStyle.Quart)
	tween(self.Holder, {
		Size = UDim2.fromOffset(self.Config.Width, self.Config.Height),
	}, 0.3, Enum.EasingStyle.Quart)
	tween(self.Floating, { GroupTransparency = 0.35 }, 0.2)
end

function Nova:Close()
	if not self._visible then return end
	self._visible = false
	self:_ClosePopup()
	tween(self.Window, { GroupTransparency = 1 }, 0.16)
	tween(self.Holder, {
		Size = UDim2.fromOffset(self.Config.Width * 0.95, self.Config.Height * 0.95),
	}, 0.18, Enum.EasingStyle.Quart)
	tween(self.Floating, { GroupTransparency = 0 }, 0.2)
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

function Nova:SetPlayerName(name)
	self.Config.PlayerName = name
	if self.NameLabel then self.NameLabel.Text = name or self:_PlayerName() end
end

function Nova:SetPlayerSubtitle(text)
	self.Config.PlayerSubtitle = text
	if self.SubLabel then self.SubLabel.Text = text or "" end
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

function Nova:_ApplyScale()
	local vp = self:_Viewport()
	local s = math.min(vp.X / 1920, vp.Y / 1080)
	s = clamp(s, self.Config.MinScale, self.Config.MaxScale)
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
	local size = self.Floating.AbsoluteSize
	local x = pos.X.Scale * vp.X + pos.X.Offset
	local y = pos.Y.Scale * vp.Y + pos.Y.Offset
	x = clamp(x, 4, vp.X - 58)
	y = clamp(y, 4, vp.Y - 58)
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
		if ic:IsA("TextLabel") then tween(ic, { TextColor3 = T.Text }, 0.14) end
	end)
	btn.MouseLeave:Connect(function()
		if self.ActivePrimary == tab then return end
		tween(btn, { BackgroundTransparency = 1 }, 0.14)
		if ic:IsA("TextLabel") then tween(ic, { TextColor3 = T.TextMuted }, 0.14) end
	end)
	btn.MouseButton1Click:Connect(function()
		tab:Select()
	end)

	-- 悬浮提示
	tab._tip = create("Frame", {
		Name = "Tip",
		BackgroundColor3 = T.Card,
		Size = UDim2.fromOffset(0, 26),
		Position = UDim2.new(1, 10, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		ZIndex = 40,
		Visible = false,
		Parent = btn,
	})
	corner(tab._tip, 7)
	local tipLabel = create("TextLabel", {
		Text = name,
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		TextColor3 = T.Text,
		TextSize = 11,
		ZIndex = 41,
		Size = UDim2.fromOffset(100, 26),
		Position = UDim2.fromOffset(9, 0),
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = tab._tip,
	})
	tab._tipLabel = tipLabel
	tab._tipWidth = 0
	local textSvc = game:GetService("TextService")
	pcall(function()
		local sz = textSvc:GetTextSize(name, 11, Enum.Font.GothamMedium, Vector2.new(400, 100))
		tab._tipWidth = sz.X + 20
	end)
	if tab._tipWidth <= 0 then
		tab._tipWidth = #name * 6 + 20
	end
	tab._tip.Size = UDim2.fromOffset(tab._tipWidth, 26)

	if btn.Parent then
		btn.MouseEnter:Connect(function()
			tab._tip.Visible = true
			tab._tip.BackgroundTransparency = 1
			tween(tab._tip, { BackgroundTransparency = 0.02 }, 0.14)
		end)
		btn.MouseLeave:Connect(function()
			tween(tab._tip, { BackgroundTransparency = 1 }, 0.1)
			task.delay(0.12, function()
				tab._tip.Visible = false
			end)
		end)
	end

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

	-- 副标签按钮
	local btn = create("TextButton", {
		Name = "Secondary_" .. name,
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = T.Element,
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(0, 30),
		AutomaticSize = Enum.AutomaticSize.X,
		LayoutOrder = #self.Secondaries + 1,
		ZIndex = 13,
		Parent = lib.TabScroll,
	})
	corner(btn, 9)
	padding(btn, 0, 0, 12, 12)
	list(btn, Enum.FillDirection.Horizontal, 7, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)

	icon(btn, iconName, 13, T.TextMuted, {
		LayoutOrder = 1,
		ZIndex = 14,
		Size = UDim2.fromOffset(13, 13),
	})
	local lbl = create("TextLabel", {
		Text = name,
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		TextColor3 = T.TextMuted,
		TextSize = 12,
		Size = UDim2.fromOffset(0, 14),
		AutomaticSize = Enum.AutomaticSize.X,
		LayoutOrder = 2,
		ZIndex = 14,
		Parent = btn,
	})
	pane.Button = btn
	pane.Label = lbl

	local underline = create("Frame", {
		Name = "Underline",
		BackgroundColor3 = T.Accent,
		Size = UDim2.new(1, -16, 0, 2),
		Position = UDim2.new(0.5, 0, 1, -1),
		AnchorPoint = Vector2.new(0.5, 1),
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		ZIndex = 15,
		Parent = btn,
	})
	corner(underline, 1)
	pane.Underline = underline

	btn.MouseEnter:Connect(function()
		if lib.ActiveSecondary == pane then return end
		tween(btn, { BackgroundTransparency = 0.9 }, 0.14)
		tween(lbl, { TextColor3 = T.Text }, 0.14)
	end)
	btn.MouseLeave:Connect(function()
		if lib.ActiveSecondary == pane then return end
		tween(btn, { BackgroundTransparency = 1 }, 0.14)
		tween(lbl, { TextColor3 = T.TextMuted }, 0.14)
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
		list(pane.Columns[i], Enum.FillDirection.Vertical, 14)
	end

	self.Secondaries[#self.Secondaries + 1] = pane

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
		if prev.Icon:IsA("TextLabel") then
			tween(prev.Icon, { TextColor3 = T.TextMuted }, 0.16)
		end
		for i = 1, #prev.Secondaries do
			prev.Secondaries[i].Page.Visible = false
		end
	end

	lib.ActivePrimary = self
	tween(self.Button, { BackgroundColor3 = T.Accent, BackgroundTransparency = 0.86 }, 0.18)
	tween(self.Accent, { BackgroundTransparency = 0, Size = UDim2.new(0, 3, 0, 18) }, 0.22, Enum.EasingStyle.Quint)
	if self.Icon:IsA("TextLabel") then
		tween(self.Icon, { TextColor3 = T.Text }, 0.16)
	end

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
	padding(card, 14, 14, 14, 14)
	list(card, Enum.FillDirection.Vertical, 10)

	-- 卡片头
	local head = create("Frame", {
		Name = "Head",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 22),
		LayoutOrder = 1,
		ZIndex = 14,
		Parent = card,
	})
	create("Frame", {
		Name = "Dot",
		BackgroundColor3 = T.Accent,
		Size = UDim2.fromOffset(6, 6),
		Position = UDim2.new(0, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BorderSizePixel = 0,
		ZIndex = 15,
		Parent = head,
	})
	local dot = head:FindFirstChild("Dot")
	corner(dot, 3)
	create("TextLabel", {
		Name = "Title",
		Text = title or "Section",
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		TextColor3 = T.Text,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, -16, 1, 0),
		Position = UDim2.fromOffset(14, 0),
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
		tween(prev.Underline, { BackgroundTransparency = 1 }, 0.16)
		tween(prev.Label, { TextColor3 = T.TextMuted }, 0.16)
		prev.Page.Visible = false
	end

	lib.ActiveSecondary = self
	tween(self.Button, { BackgroundColor3 = T.Card, BackgroundTransparency = 0.25 }, 0.18)
	tween(self.Underline, { BackgroundTransparency = 0 }, 0.18)
	tween(self.Label, { TextColor3 = T.Text }, 0.18)
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
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Size = UDim2.new(1, -160, 0, 16),
			Position = UDim2.fromOffset(0, desc and 10 or (height - 16) / 2),
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
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Size = UDim2.new(1, -160, 0, 14),
			Position = UDim2.fromOffset(0, 27),
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

	local row, right = self:_Row(cfg, cfg.Menu and 58 or 54, cfg.Title, cfg.Desc)

	local menuIcon
	if cfg.Menu then
		local mb = create("TextButton", {
			Name = "Menu",
			Text = "",
			AutoButtonColor = false,
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(26, 26),
			Position = UDim2.new(1, -112, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			ZIndex = 16,
			Parent = row,
		})
		menuIcon = icon(mb, "dot", 14, T.TextMuted, {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			ZIndex = 17,
			Size = UDim2.fromScale(1, 1),
		})
		menuIcon.Text = "•••"
		mb.MouseEnter:Connect(function()
			tween(menuIcon, { TextColor3 = T.Text }, 0.12)
		end)
		mb.MouseLeave:Connect(function()
			tween(menuIcon, { TextColor3 = T.TextMuted }, 0.12)
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
		Size = UDim2.fromOffset(42, 24),
		Position = UDim2.new(1, 0, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		ZIndex = 16,
		Parent = row,
	})
	corner(switch, 12)
	local swGrad = create("UIGradient", {
		Color = ColorSequence.new(T.Accent, T.Accent2),
		Rotation = 0,
		Transparency = NumberSequence.new(1),
		Parent = switch,
	})
	local knob = create("Frame", {
		Name = "Knob",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.25,
		Size = UDim2.fromOffset(18, 18),
		Position = UDim2.fromOffset(3, 3),
		ZIndex = 17,
		Parent = switch,
	})
	corner(knob, 9)

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
			BackgroundTransparency = self.Value and 0 or 0.25,
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
		Size = UDim2.fromOffset(150, 6),
		Position = UDim2.new(1, -70, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		BorderSizePixel = 0,
		ZIndex = 16,
		Parent = row,
	})
	corner(track, 3)

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

	local knob = create("Frame", {
		Name = "Knob",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		Size = UDim2.fromOffset(16, 16),
		Position = UDim2.new(0, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		ZIndex = 18,
		Parent = track,
	})
	corner(knob, 8)
	stroke(knob, T.Accent, 2, 0.15)

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
			tween(knob, { Size = UDim2.fromOffset(19, 19) }, 0.12, Enum.EasingStyle.Back)
			tween(valueLabel, { TextColor3 = T.Accent }, 0.12)
		end
	end)
	hit.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
			tween(knob, { Size = UDim2.fromOffset(16, 16) }, 0.14, Enum.EasingStyle.Back)
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
		Font = Enum.Font.GothamMedium,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 12,
		Size = UDim2.fromOffset(100, 30),
		Position = UDim2.new(1, 0, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		ZIndex = 16,
		Parent = row,
	})
	corner(btn, 9)
	local grad = gradient(btn, T.Accent, T.Accent2, 0)

	btn.MouseEnter:Connect(function()
		grad.Transparency = NumberSequence.new(0.15)
		tween(btn, { Size = UDim2.fromOffset(102, 31) }, 0.12)
	end)
	btn.MouseLeave:Connect(function()
		grad.Transparency = NumberSequence.new(0)
		tween(btn, { Size = UDim2.fromOffset(100, 30) }, 0.12)
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

--==============================================================================
-- 演示脚本：整段粘贴到执行器即可运行（库本体 + 示例已合并在本文件）
-- 悬浮球默认在屏幕右侧中部：点一下开关主界面，按住可拖动
--==============================================================================

local function showError(msg)
	pcall(function()
		local parent = (gethui and gethui()) or game:GetService("CoreGui")
		local sg = Instance.new("ScreenGui")
		sg.Name = "NovaUI_Error"
		sg.IgnoreGuiInset = true
		sg.ResetOnSpawn = false
		sg.Parent = parent

		local f = Instance.new("Frame")
		f.Name = "Box"
		f.AnchorPoint = Vector2.new(0.5, 0.5)
		f.Position = UDim2.fromScale(0.5, 0.5)
		f.Size = UDim2.new(0, 560, 0, 0)
		f.AutomaticSize = Enum.AutomaticSize.Y
		f.BackgroundColor3 = Color3.fromRGB(26, 12, 14)
		f.Parent = sg

		local c = Instance.new("UICorner")
		c.CornerRadius = UDim.new(0, 12)
		c.Parent = f

		local st = Instance.new("UIStroke")
		st.Color = Color3.fromRGB(255, 82, 82)
		st.Thickness = 1
		st.Parent = f

		local pd = Instance.new("UIPadding")
		pd.PaddingTop = UDim.new(0, 16)
		pd.PaddingBottom = UDim.new(0, 16)
		pd.PaddingLeft = UDim.new(0, 16)
		pd.PaddingRight = UDim.new(0, 16)
		pd.Parent = f

		local title = Instance.new("TextLabel")
		title.BackgroundTransparency = 1
		title.Text = "Nova UI 运行出错，请把下面内容发给开发者："
		title.TextColor3 = Color3.fromRGB(255, 150, 150)
		title.Font = Enum.Font.GothamBold
		title.TextSize = 15
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.Size = UDim2.new(1, 0, 0, 20)
		title.Parent = f

		local body = Instance.new("TextLabel")
		body.BackgroundTransparency = 1
		body.Text = tostring(msg)
		body.TextColor3 = Color3.fromRGB(255, 205, 205)
		body.Font = Enum.Font.Code
		body.TextSize = 13
		body.TextWrapped = true
		body.TextXAlignment = Enum.TextXAlignment.Left
		body.TextYAlignment = Enum.TextYAlignment.Top
		body.Position = UDim2.fromOffset(0, 26)
		body.Size = UDim2.new(1, 0, 0, 0)
		body.AutomaticSize = Enum.AutomaticSize.Y
		body.Parent = f
	end)
end

local ok, err = pcall(function()

	local win = Nova.new({
		Title          = "NOVA",
		Subtitle       = "Interface Suite",
		Icon           = "default",
		PlayerName     = "Past Owl",
		PlayerSubtitle = "Till: 1 mar 2026",
		Avatar         = nil,        -- 改成 "rbxassetid://xxxx" 可自定义头像
		FloatingIcon   = nil,        -- 改成 "rbxassetid://xxxx" 可自定义悬浮球图片
		Accent         = Color3.fromRGB(255, 62, 92),
		Accent2        = Color3.fromRGB(255, 130, 76),
		ToggleKey      = Enum.KeyCode.RightShift,
		Columns        = 2,
		StartOpen      = true,
	})

	--============================================================
	-- 主侧边栏
	--============================================================
	local combat  = win:Primary("Combat", "shield")
	local visual  = win:Primary("Visuals", "eye")
	local aim     = win:Primary("Aim", "target")
	local players = win:Primary("Player", "hand")
	local cursor  = win:Primary("Cursor", "cursor")
	local configs = win:Primary("Configs", "folder")
	local setting = win:Primary("Settings", "settings")

	--============================================================
	-- 副侧边栏（Combat 下挂 5 个，其它主栏各挂 1~2 个）
	--============================================================
	local sMain    = combat:Secondary("Main", "settings")
	local sTarget  = combat:Secondary("Targeting", "target")
	local sTrigger = combat:Secondary("Trigger", "bolt")
	local sMisc    = combat:Secondary("Misc", "layers")
	local sOthers  = combat:Secondary("Others", "grid")

	local vRender  = visual:Secondary("Render", "eye")
	local vEffects = visual:Secondary("Effects", "star")
	local vAbout   = visual:Secondary("About", "info")

	local aLock    = aim:Secondary("Lock", "target")
	local pMove    = players:Secondary("Movement", "hand")
	local cStyle   = cursor:Secondary("Style", "cursor")
	local cfgSlots = configs:Secondary("Slots", "folder")
	local stGen    = setting:Secondary("General", "settings")

	--============================================================
	-- Combat / Main
	--============================================================
	local general = sMain:Section("General settings")
	general:Toggle({
		Title = "Enable module",
		Desc  = "Activates the main module of this section.",
		Default = false,
		Flag = "MainEnabled",
		Callback = function(v)
			win:Notify({
				Title = "Enable module",
				Desc  = v and "已开启" or "已关闭",
				Duration = 2,
				Icon = v and "check" or "close",
			})
		end,
	})
	general:Toggle({
		Title = "Alternative mode",
		Desc  = "Uses an alternative processing pattern.",
		Default = false,
		Menu = {
			{ Name = "Reset to default", Callback = function() end },
			{ Name = "Copy settings", Callback = function() end },
			{ Name = "Paste settings", Callback = function() end },
		},
	})

	local params = sMain:Section("Parameters")
	params:Dropdown({
		Title = "Selected profile",
		Desc  = "Picks the active profile for applying settings.",
		Options = { "None", "ACE", "Balanced", "Aggressive" },
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
	auto:Toggle({ Title = "Auto detect", Desc = "Identifies and tracks targets automatically.", Default = false })
	auto:Toggle({ Title = "Configure range", Desc = "Sets boundaries for the scanning zone.", Default = false })
	auto:Dropdown({
		Title = "Manual selection",
		Desc  = "Lets the user choose a specific target manually.",
		Options = { "ACE", "None" },
		Default = "ACE",
	})

	local miscSec = sMain:Section("Miscellaneous")
	miscSec:Toggle({
		Title = "Stable state",
		Desc  = "Maintains an ideal condition and stats.",
		Default = false,
		Menu = { { Name = "Options", Callback = function() end } },
	})
	miscSec:Toggle({
		Title = "Fast mode",
		Desc  = "Speeds up the processing interval.",
		Default = false,
		Menu = { { Name = "Options", Callback = function() end } },
	})
	miscSec:Slider({
		Title = "Range value",
		Desc  = "Adjusts the effective range of this option.",
		Min = 0, Max = 100, Step = 1, Default = 50,
	})

	--============================================================
	-- Combat / Targeting · Trigger · Misc · Others
	--============================================================
	local targeting = sTarget:Section("Targeting & Detection")
	targeting:Toggle({ Title = "Enable targeting", Desc = "Locks onto the closest valid target.", Default = false })
	targeting:Slider({ Title = "FOV radius", Desc = "Maximum distance for detection.", Min = 10, Max = 500, Step = 5, Default = 120, Suffix = "°" })
	targeting:Dropdown({ Title = "Priority", Desc = "Sorting rule used when picking a target.", Options = { "Distance", "Health", "Angle" }, Default = "Distance" })
	targeting:Divider()
	targeting:Button({ Title = "Refresh target list", Text = "Refresh", Callback = function() end })

	local trigger = sTrigger:Section("Trigger settings")
	trigger:Toggle({ Title = "Auto trigger", Desc = "Fires automatically when a target is in range.", Default = false })
	trigger:Slider({ Title = "Reaction delay", Desc = "Delay before firing, in milliseconds.", Min = 0, Max = 300, Step = 5, Default = 40, Suffix = "ms" })
	trigger:Keybind({ Title = "Hold key", Desc = "Key used to hold the trigger.", Default = Enum.KeyCode.E })

	sMisc:Section("Extra options"):Toggle({ Title = "Silent mode", Desc = "Reduces visual feedback noise.", Default = false })
	sOthers:Section("Experimental"):Label({ Text = "以下功能处于实验阶段，可能不稳定。", Desc = "Experimental features" })

	--============================================================
	-- Visuals
	--============================================================
	local vr = vRender:Section("Render options")
	vr:Toggle({ Title = "Player highlights", Desc = "Draws a highlight box around players.", Default = true })
	vr:Slider({ Title = "Highlight opacity", Desc = "Controls how strong the highlight looks.", Min = 0, Max = 100, Step = 1, Default = 65, Suffix = "%" })
	vEffects:Section("Effects"):Toggle({ Title = "Bloom", Desc = "Adds a soft glow to the scene.", Default = false })
	vAbout:Section("About"):Label({
		Text = "Nova UI v" .. Nova.Version .. " · 主侧边栏 + 副侧边栏 · 自适应分辨率 · 内置图标库。",
		Desc = "About this library",
	})

	--============================================================
	-- 其它主栏
	--============================================================
	aLock:Section("Lock settings"):Slider({
		Title = "Smoothing",
		Desc  = "Higher values feel smoother but slower.",
		Min = 0, Max = 1, Step = 0.05, Default = 0.4,
		Callback = function() end,
	})
	pMove:Section("Movement"):Slider({ Title = "Walk speed", Desc = "Character movement speed.", Min = 8, Max = 80, Step = 1, Default = 16 })
	cStyle:Section("Cursor style"):Dropdown({ Title = "Style", Desc = "Visual style of the cursor.", Options = { "Default", "Dot", "Cross" }, Default = "Default" })

	local cfgSec = cfgSlots:Section("Config slots")
	cfgSec:Input({ Title = "Config name", Placeholder = "my-config", Callback = function(v) print("[config name]", v) end })
	cfgSec:Button({
		Title = "Save current config",
		Text  = "Save",
		Callback = function()
			win:Notify({ Title = "Config", Desc = "已保存", Icon = "check", Duration = 2 })
		end,
	})
	cfgSec:Button({
		Title = "Load selected config",
		Text  = "Load",
		Callback = function()
			win:Notify({ Title = "Config", Desc = "已加载", Icon = "folder", Duration = 2 })
		end,
	})

	local gSec = stGen:Section("Interface")
	gSec:Keybind({ Title = "Toggle menu", Desc = "Keyboard shortcut to open or close this window.", Default = Enum.KeyCode.RightShift })
	gSec:Toggle({ Title = "Watermark", Desc = "Shows a small watermark on screen.", Default = false })
	gSec:Slider({ Title = "Interface scale", Desc = "Manual scale multiplier.", Min = 0.5, Max = 1.5, Step = 0.05, Default = 1, Suffix = "x" })
	gSec:Divider()
	gSec:Button({ Title = "Reset interface", Text = "Reset", Callback = function() end })

	print("[Nova UI] 加载完成 · 悬浮球可拖动，点击开关界面")

	task.delay(0.6, function()
		win:Notify({
			Title = "Nova UI 已加载",
			Desc  = "点击悬浮球或按 RightShift 开关界面。",
			Duration = 4,
			Icon = "check",
		})
	end)
end)

if not ok then
	warn("[Nova UI] 运行出错: " .. tostring(err))
	showError(err)
end