--[[
================================================================================
  RedUI  ·  现代化悬浮窗 UI 库
  版本 : 1.0.0
  语法 : 兼容 Lua 5.1 / Roblox Luau
  说明 : 单文件 UI 库。包含
         · 悬浮窗（可拖动，点击开/关主界面，图片可自定义）
         · 主界面（左上角玩家头像 + 玩家名字，图片可自定义）
         · 主侧边栏（左侧竖排图标）
         · 副侧边栏（顶部横排图标，一个主侧边栏可挂多个副侧边栏）
         · 控件：Toggle / Slider / Dropdown / Button / Label / Section
         · 内置图标库（Library.Icons，可用图标名或 rbxassetid 覆盖）
         · 自适应分辨率（按屏幕尺寸自动缩放主界面大小）
================================================================================
 使用示例
--------------------------------------------------------------------------------
  local Library = loadstring(game:HttpGet("你的地址/RedUI.lua"))()

  local lib = Library.new({
      BrandName       = "Brand name",
      BrandSlogan     = "The slogan, if there is one.",
      BrandIcon       = nil,                 -- 右上角圆形图片（可自定义）
      PlayerName      = "Past Owl",           -- 左上角玩家名字
      PlayerSubtitle  = "Till: 1 mar 2026",   -- 名字下方小字
      Avatar          = nil,                 -- 左上角玩家头像图片（可自定义）
      FloatingIcon    = nil,                 -- 悬浮窗图片（可自定义）
      -- 上面三个图片都支持: "rbxassetid://123" 或 "http://..." 或 直接留空用内置字形
  })

  -- 主侧边栏
  local combat = lib:Primary("Combat", "shield")

  -- 副侧边栏（一个主侧边栏可以加很多个）
  local recoil = combat:Secondary("Recoil", "target")

  -- 分组
  local sec = recoil:Section("Recoil control system")

  sec:Toggle({
      Title = "Enable recoil",
      Desc  = "Activates weapon recoil for realistic shooting mechanics.",
      Default = false,
      Callback = function(value) print("recoil", value) end,
  })

  sec:Toggle({
      Title = "Use horizontal jitter exploit",
      Desc  = "Eliminates vertical recoil using horizontal shaking patterns.",
      Default = false,
      Menu = {                       -- 右上角 "..." 菜单（可选）
          { Name = "Reset", Callback = function() end },
      },
      Callback = function(v) end,
  })

  sec:Slider({
      Title = "Vertical offset",
      Desc  = "Adjusts weapon's upward recoil compensation amount.",
      Min = 0, Max = 100, Step = 1, Default = 50,
      Callback = function(v) end,
  })

  sec:Dropdown({
      Title = "Selected primary weapon",
      Desc  = "Picks main firearm for modification application.",
      Options = { "None", "ACE", "M4A1", "AK47" },
      Default = "None",
      Callback = function(v) end,
  })

  sec:Button({ Title = "Apply settings", Callback = function() end })

  -- 运行时修改
  lib:SetFloatingIcon("rbxassetid://000")
  lib:SetAvatar("rbxassetid://000")
  lib:SetPlayerName("New name")
  lib:Open()      -- 打开
  lib:Close()     -- 关闭
  lib:Toggle()    -- 切换
================================================================================
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local Library = {}
Library.__index = Library
Library.Version = "1.0.0"
Library._instances = {}

--==============================================================================
-- 基础工具
--==============================================================================

local function clamp(v, lo, hi)
	if v < lo then return lo end
	if v > hi then return hi end
	return v
end

local function round(v, step)
	if not step or step <= 0 then return v end
	return math.floor(v / step + 0.5) * step
end

local function new(class, props, children)
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
	if children then
		for i = 1, #children do
			children[i].Parent = inst
		end
	end
	if parent then
		inst.Parent = parent
	end
	return inst
end

local function corner(parent, radius)
	return new("UICorner", { CornerRadius = UDim.new(0, radius), Parent = parent })
end

local function stroke(parent, color, thickness, transparency)
	return new("UIStroke", {
		Color = color,
		Thickness = thickness or 1,
		Transparency = transparency or 0,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = parent,
	})
end

local function padding(parent, top, right, bottom, left)
	return new("UIPadding", {
		PaddingTop = UDim.new(0, top or 0),
		PaddingRight = UDim.new(0, right or top or 0),
		PaddingBottom = UDim.new(0, bottom or top or 0),
		PaddingLeft = UDim.new(0, left or right or top or 0),
		Parent = parent,
	})
end

local TWEEN_INFO = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function tween(inst, props, info)
	local t = TweenService:Create(inst, info or TWEEN_INFO, props)
	t:Play()
	return t
end

local function isImage(value)
	if type(value) ~= "string" then return false end
	if string.find(value, "rbxassetid://", 1, true) then return true end
	if string.find(value, "rbxasset://", 1, true) then return true end
	if string.sub(value, 1, 4) == "http" then return true end
	return false
end

-- 生成一个图标实例：有图片地址就用 ImageLabel，否则用内置字形 TextLabel
local function createIcon(icon, size, color, parent, textSize)
	local value = Library.Icons[icon] or icon or "●"
	local obj
	if isImage(value) then
		obj = new("ImageLabel", {
			BackgroundTransparency = 1,
			Image = value,
			ImageColor3 = color or Color3.fromRGB(255, 255, 255),
			Size = UDim2.fromOffset(size, size),
			ScaleType = Enum.ScaleType.Fit,
			Parent = parent,
		})
	else
		obj = new("TextLabel", {
			BackgroundTransparency = 1,
			Text = value,
			Font = Enum.Font.GothamMedium,
			TextColor3 = color or Color3.fromRGB(255, 255, 255),
			TextSize = textSize or math.floor(size * 0.9),
			Size = UDim2.fromOffset(size, size),
			TextScaled = false,
			Parent = parent,
		})
	end
	return obj
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

local function makeDraggable(frame, handle, conns, onMove)
	handle = handle or frame
	local dragging = false
	local dragStart, startPos

	local function update(input)
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
		if onMove then onMove() end
	end

	local c1 = handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
		end
	end)

	local c2 = UserInputService.InputChanged:Connect(function(input)
		if not dragging then return end
		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then
			update(input)
		end
	end)

	local c3 = UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)

	if conns then
		conns[#conns + 1] = c1
		conns[#conns + 1] = c2
		conns[#conns + 1] = c3
	end
end

--==============================================================================
-- 主题 & 图标库
--==============================================================================

Library.Theme = {
	Background    = Color3.fromRGB(9, 9, 11),
	Panel         = Color3.fromRGB(20, 20, 25),
	PanelBorder   = Color3.fromRGB(38, 38, 46),
	Surface       = Color3.fromRGB(28, 28, 34),
	SurfaceHover  = Color3.fromRGB(38, 38, 46),
	Sidebar       = Color3.fromRGB(15, 15, 19),
	Track         = Color3.fromRGB(42, 42, 51),
	Divider       = Color3.fromRGB(30, 30, 37),
	Text          = Color3.fromRGB(237, 237, 241),
	TextMuted     = Color3.fromRGB(150, 150, 163),
	TextDesc      = Color3.fromRGB(112, 112, 126),
	Accent        = Color3.fromRGB(229, 72, 77),
	AccentSoft    = Color3.fromRGB(255, 105, 110),
	Icon          = Color3.fromRGB(126, 126, 140),
	IconHover     = Color3.fromRGB(190, 190, 200),
	IconActive    = Color3.fromRGB(255, 255, 255),
	ToggleOff     = Color3.fromRGB(50, 50, 60),
	ToggleKnob    = Color3.fromRGB(255, 255, 255),
	ActivePill    = Color3.fromRGB(40, 40, 48),
	Shadow        = Color3.fromRGB(0, 0, 0),
}

-- 内置图标库（默认字形，可用图片地址覆盖）
Library.Icons = {
	shield       = "⛨",
	eye          = "◎",
	target       = "⌖",
	hand         = "☝",
	cursor       = "➤",
	folder       = "▤",
	settings     = "⚙",
	search       = "⌕",
	chevronRight = "›",
	chevronDown  = "⌄",
	chevronLeft  = "‹",
	dots         = "⋯",
	lightning    = "↯",
	user         = "▣",
	star         = "★",
	heart        = "♥",
	info         = "◇",
	lock         = "▦",
	ban          = "✕",
	check        = "✓",
	plus         = "+",
	minus        = "−",
	skull        = "☠",
	palette      = "❈",
	flame        = "▲",
	home         = "⌂",
	book         = "▭",
	chart        = "▥",
	bell         = "◔",
	key          = "⚿",
	wand         = "✦",
	globe        = "◍",
	copy         = "❐",
	power        = "⏻",
	link         = "⛓",
	clock        = "◷",
	grid         = "▦",
	dot          = "•",
	circle       = "●",
	square       = "■",
	triangle     = "▲",
	diamond      = "◆",
	arrow        = "→",
	play         = "▶",
}

--==============================================================================
-- 默认配置
--==============================================================================

local DEFAULTS = {
	BrandName      = "Brand name",
	BrandSlogan    = "The slogan, if there is one.",
	BrandIcon      = nil,
	PlayerName     = "Player",
	PlayerSubtitle = "Till: 1 mar 2026",
	Avatar         = nil,
	FloatingIcon   = nil,
	ToggleKey      = Enum.KeyCode.RightShift,
	Accent         = Color3.fromRGB(229, 72, 77),
	Columns        = 2,
	StartOpen      = false,
}

local DESIGN_W = 1180
local DESIGN_H = 700
local REF_W = 1240
local REF_H = 760

--==============================================================================
-- Library 核心
--==============================================================================

function Library.new(config)
	config = config or {}
	for k, v in pairs(DEFAULTS) do
		if config[k] == nil then config[k] = v end
	end
	if config.Accent then
		Library.Theme.Accent = config.Accent
		Library.Theme.AccentSoft = Color3.new(
			math.min(config.Accent.R * 1.15, 1),
			math.min(config.Accent.G * 1.15, 1),
			math.min(config.Accent.B * 1.15, 1)
		)
	end

	local self = setmetatable({}, Library)
	self.Config = config
	self.Theme = Library.Theme
	self.PrimaryTabs = {}
	self.ActivePrimary = nil
	self.ActiveSecondary = nil
	self.Scale = 1
	self.SearchActive = false
	self.SearchQuery = ""
	self._popup = nil
	self._conns = {}
	self._visible = false

	self:_BuildRoot()
	self:_BuildFloating()
	self:_BuildWindow()
	self:_ApplyScale()
	self:_HookViewport()

	if config.StartOpen then
		self:Open()
	end

	return self
end

function Library:new(config)
	return Library.new(config)
end

function Library:_BuildRoot()
	local parent = findGuiParent()
	self.Root = new("ScreenGui", {
		Name = "RedUI",
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 9999,
		Parent = parent,
	})
	self.Overlay = new("Frame", {
		Name = "Overlay",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ClipsDescendants = false,
		ZIndex = 100,
		Parent = self.Root,
	})
end

function Library:_Viewport()
	local cam = workspace.CurrentCamera
	if cam then
		return cam.ViewportSize
	end
	return Vector2.new(1280, 720)
end

function Library:_ApplyScale()
	local vp = self:_Viewport()
	local s = math.min((vp.X * 0.96) / REF_W, (vp.Y * 0.94) / REF_H)
	s = clamp(s, 0.5, 1.25)
	self.Scale = s
	if self.UIScale then
		self.UIScale.Scale = s
	end
	if self.Floating then
		local fp = self.Floating.AbsolutePosition
		local fs = self.Floating.AbsoluteSize
		if fs.X > 0 and fs.Y > 0 then
			local x = clamp(fp.X, 4, math.max(4, vp.X - fs.X - 4))
			local y = clamp(fp.Y, 4, math.max(4, vp.Y - fs.Y - 4))
			self.Floating.Position = UDim2.fromOffset(x, y)
		end
	end
end

function Library:_HookViewport()
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

--==============================================================================
-- 悬浮窗
--==============================================================================

function Library:_BuildFloating()
	local vp = self:_Viewport()
	local SIZE = 56

	local float = new("Frame", {
		Name = "Floating",
		BackgroundColor3 = self.Theme.Panel,
		Size = UDim2.fromOffset(SIZE, SIZE),
		Position = UDim2.fromOffset(vp.X - SIZE - 28, math.floor(vp.Y * 0.5)),
		Parent = self.Root,
		ZIndex = 90,
	})
	corner(float, 18)
	self._floatStroke = stroke(float, self.Theme.Accent, 1.2, 0.35)
	new("UIGradient", {
		Rotation = 90,
		Color = ColorSequence.new(Color3.fromRGB(34, 34, 42), Color3.fromRGB(18, 18, 23)),
		Parent = float,
	})

	self.Floating = float

	self.FloatingIconHolder = new("Frame", {
		Name = "Icon",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(SIZE - 16, SIZE - 16),
		Parent = float,
	})
	self:_RenderFloatingIcon()

	-- 悬浮窗上的图片可自定义：有 asset 就图片，否则字形
	float.MouseEnter:Connect(function()
		tween(float, { BackgroundColor3 = self.Theme.SurfaceHover })
		tween(self._floatStroke, { Transparency = 0 })
	end)
	float.MouseLeave:Connect(function()
		tween(float, { BackgroundColor3 = self.Theme.Panel })
		tween(self._floatStroke, { Transparency = 0.35 })
	end)

	-- 点击开/关，拖动则移动
	local dragging = false
	local moved = false
	local dragStart, startPos

	float.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			moved = false
			dragStart = input.Position
			startPos = float.Position
		end
	end)

	self._conns[#self._conns + 1] = UserInputService.InputChanged:Connect(function(input)
		if not dragging then return end
		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then
			local delta = input.Position - dragStart
			if math.abs(delta.X) > 3 or math.abs(delta.Y) > 3 then
				moved = true
			end
			if moved then
				float.Position = UDim2.new(
					startPos.X.Scale,
					startPos.X.Offset + delta.X,
					startPos.Y.Scale,
					startPos.Y.Offset + delta.Y
				)
			end
		end
	end)

	self._conns[#self._conns + 1] = UserInputService.InputEnded:Connect(function(input)
		if not dragging then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
			if not moved then
				self:Toggle()
			end
		end
	end)
end

function Library:_RenderFloatingIcon()
	if self.FloatingIconHolder:FindFirstChild("I") then
		self.FloatingIconHolder.I:Destroy()
	end
	local value = self.Config.FloatingIcon
	local obj
	if isImage(value) then
		obj = new("ImageLabel", {
			Name = "I",
			BackgroundTransparency = 1,
			Image = value,
			Size = UDim2.fromScale(1, 1),
			ScaleType = Enum.ScaleType.Fit,
			Parent = self.FloatingIconHolder,
		})
	else
		obj = new("TextLabel", {
			Name = "I",
			BackgroundTransparency = 1,
			Text = value or "✦",
			Font = Enum.Font.GothamBold,
			TextColor3 = self.Theme.Accent,
			TextSize = 26,
			Size = UDim2.fromScale(1, 1),
			Parent = self.FloatingIconHolder,
		})
	end
	return obj
end

--==============================================================================
-- 主窗口
--==============================================================================

function Library:_BuildWindow()
	local T = self.Theme

	local win = new("CanvasGroup", {
		Name = "Window",
		BackgroundColor3 = T.Background,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(DESIGN_W, DESIGN_H),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		ClipsDescendants = false,
		GroupTransparency = 1,
		Visible = false,
		Parent = self.Root,
		ZIndex = 50,
	})
	corner(win, 22)
	stroke(win, T.PanelBorder, 1, 0.15)
	self.Window = win
	self.UIScale = new("UIScale", { Scale = 1, Parent = win })

	-- 顶部栏
	self.Topbar = new("Frame", {
		Name = "Topbar",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 88),
		Parent = win,
	})

	-- 左上：玩家头像 + 玩家名字
	self.AvatarHolder = new("Frame", {
		Name = "Avatar",
		BackgroundColor3 = T.Surface,
		Size = UDim2.fromOffset(48, 48),
		Position = UDim2.fromOffset(22, 20),
		Parent = self.Topbar,
	})
	corner(self.AvatarHolder, 13)
	stroke(self.AvatarHolder, T.PanelBorder, 1, 0.3)
	self:_RenderAvatar()

	new("TextLabel", {
		Name = "PlayerName",
		BackgroundTransparency = 1,
		Text = self.Config.PlayerName,
		Font = Enum.Font.GothamBold,
		TextColor3 = T.Text,
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(84, 26),
		Size = UDim2.new(0, 320, 0, 18),
		Parent = self.Topbar,
	})
	self.PlayerSubtitleLabel = new("TextLabel", {
		Name = "PlayerSubtitle",
		BackgroundTransparency = 1,
		Text = self.Config.PlayerSubtitle,
		Font = Enum.Font.Gotham,
		TextColor3 = T.TextDesc,
		TextSize = 12.5,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(84, 47),
		Size = UDim2.new(0, 320, 0, 15),
		Parent = self.Topbar,
	})

	-- 右上：品牌名 + 圆形图片
	self.BrandIconHolder = new("Frame", {
		Name = "BrandIcon",
		BackgroundColor3 = T.Text,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -22, 0, 18),
		Size = UDim2.fromOffset(52, 52),
		Parent = self.Topbar,
	})
	corner(self.BrandIconHolder, 26)
	self:_RenderBrandIcon()

	new("TextLabel", {
		Name = "BrandName",
		BackgroundTransparency = 1,
		Text = self.Config.BrandName,
		Font = Enum.Font.GothamBold,
		TextColor3 = T.Text,
		TextSize = 15,
		TextXAlignment = Enum.TextXAlignment.Right,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -86, 0, 26),
		Size = UDim2.new(0, 300, 0, 17),
		Parent = self.Topbar,
	})
	new("TextLabel", {
		Name = "BrandSlogan",
		BackgroundTransparency = 1,
		Text = self.Config.BrandSlogan,
		Font = Enum.Font.Gotham,
		TextColor3 = T.TextDesc,
		TextSize = 12.5,
		TextXAlignment = Enum.TextXAlignment.Right,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -86, 0, 46),
		Size = UDim2.new(0, 300, 0, 15),
		Parent = self.Topbar,
	})

	-- 主体：左侧主侧边栏 + 右侧内容
	local body = new("Frame", {
		Name = "Body",
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(16, 88),
		Size = UDim2.new(1, -32, 1, -104),
		Parent = win,
	})

	-- 主侧边栏
	self.Sidebar = new("Frame", {
		Name = "Sidebar",
		BackgroundColor3 = T.Sidebar,
		Size = UDim2.new(0, 72, 1, 0),
		Parent = body,
	})
	corner(self.Sidebar, 20)
	stroke(self.Sidebar, T.PanelBorder, 1, 0.45)
	new("UIListLayout", {
		FillDirection = Enum.FillDirection.Vertical,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		VerticalAlignment = Enum.VerticalAlignment.Top,
		Padding = UDim.new(0, 10),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = self.Sidebar,
	})
	padding(self.Sidebar, 16, 0, 16, 0)

	-- 右侧区域
	self.Main = new("Frame", {
		Name = "Main",
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(88, 0),
		Size = UDim2.new(1, -88, 1, 0),
		Parent = body,
	})

	-- 副侧边栏行 + 搜索
	self.TabbarRow = new("Frame", {
		Name = "TabbarRow",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 64),
		Parent = self.Main,
	})

	self.PillScroll = new("ScrollingFrame", {
		Name = "Pills",
		BackgroundColor3 = T.Sidebar,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(96, 64),
		CanvasSize = UDim2.fromOffset(0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.None,
		ScrollingDirection = Enum.ScrollingDirection.X,
		ScrollBarThickness = 0,
		ElasticBehavior = Enum.ElasticBehavior.Never,
		ClipsDescendants = true,
		Parent = self.TabbarRow,
	})
	corner(self.PillScroll, 20)
	stroke(self.PillScroll, T.PanelBorder, 1, 0.45)
	self.PillLayout = new("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		Padding = UDim.new(0, 14),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = self.PillScroll,
	})
	padding(self.PillScroll, 0, 16, 0, 16)

	-- 搜索按钮
	self.SearchBtn = new("TextButton", {
		Name = "Search",
		BackgroundColor3 = T.Sidebar,
		Text = "",
		Size = UDim2.fromOffset(56, 56),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, 0, 0.5, 0),
		AutoButtonColor = false,
		Parent = self.TabbarRow,
	})
	corner(self.SearchBtn, 18)
	stroke(self.SearchBtn, T.PanelBorder, 1, 0.45)
	local searchIcon = createIcon("search", 22, T.Icon, self.SearchBtn)
	searchIcon.AnchorPoint = Vector2.new(0.5, 0.5)
	searchIcon.Position = UDim2.fromScale(0.5, 0.5)

	self.SearchBtn.MouseEnter:Connect(function()
		tween(self.SearchBtn, { BackgroundColor3 = T.SurfaceHover })
	end)
	self.SearchBtn.MouseLeave:Connect(function()
		tween(self.SearchBtn, { BackgroundColor3 = T.Sidebar })
	end)
	self.SearchBtn.MouseButton1Click:Connect(function()
		self:_ToggleSearch()
	end)

	-- 搜索栏
	self.SearchBar = new("Frame", {
		Name = "SearchBar",
		BackgroundColor3 = T.Panel,
		Size = UDim2.new(1, 0, 0, 0),
		Position = UDim2.new(0, 0, 0, 72),
		ClipsDescendants = true,
		Visible = false,
		Parent = self.Main,
	})
	corner(self.SearchBar, 14)
	stroke(self.SearchBar, T.PanelBorder, 1, 0.4)
	self.SearchBox = new("TextBox", {
		Name = "Input",
		BackgroundTransparency = 1,
		PlaceholderText = "搜索设置项...",
		PlaceholderColor3 = T.TextDesc,
		Text = "",
		ClearTextOnFocus = false,
		Font = Enum.Font.Gotham,
		TextColor3 = T.Text,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.fromOffset(16, 0),
		Size = UDim2.new(1, -32, 1, 0),
		Parent = self.SearchBar,
	})
	self.SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
		self:_ApplyFilter(self.SearchBox.Text)
	end)

	-- 内容滚动区
	self.Content = new("ScrollingFrame", {
		Name = "Content",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, -78),
		Position = UDim2.new(0, 0, 0, 78),
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = T.PanelBorder,
		ScrollBarImageTransparency = 0.1,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		ElasticBehavior = Enum.ElasticBehavior.Never,
		Parent = self.Main,
	})
	padding(self.Content, 0, 10, 12, 0)

	-- 拖拽窗口（顶部栏）
	makeDraggable(win, self.Topbar, self._conns, function()
		self:_ClosePopup()
	end)

	-- 快捷键
	if self.Config.ToggleKey then
		self._conns[#self._conns + 1] = UserInputService.InputBegan:Connect(function(input, processed)
			if processed then return end
			if input.KeyCode == self.Config.ToggleKey then
				self:Toggle()
			end
		end)
	end
end

function Library:_RenderAvatar()
	local holder = self.AvatarHolder
	if holder:FindFirstChild("I") then holder.I:Destroy() end
	local value = self.Config.Avatar
	if isImage(value) then
		local img = new("ImageLabel", {
			Name = "I",
			BackgroundTransparency = 1,
			Image = value,
			Size = UDim2.fromScale(1, 1),
			ScaleType = Enum.ScaleType.Crop,
			Parent = holder,
		})
		corner(img, 13)
	else
		local ic = createIcon("user", 22, self.Theme.TextMuted, holder)
		ic.Name = "I"
		ic.AnchorPoint = Vector2.new(0.5, 0.5)
		ic.Position = UDim2.fromScale(0.5, 0.5)
	end
end

function Library:_RenderBrandIcon()
	local holder = self.BrandIconHolder
	if holder:FindFirstChild("I") then holder.I:Destroy() end
	local value = self.Config.BrandIcon
	if isImage(value) then
		local img = new("ImageLabel", {
			Name = "I",
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			Image = value,
			Size = UDim2.fromScale(1, 1),
			ScaleType = Enum.ScaleType.Crop,
			Parent = holder,
		})
		corner(img, 26)
	else
		local lbl = new("TextLabel", {
			Name = "I",
			BackgroundTransparency = 1,
			Text = value or "R",
			Font = Enum.Font.GothamBlack,
			TextColor3 = self.Theme.Accent,
			TextSize = 24,
			Size = UDim2.fromScale(1, 1),
			Parent = holder,
		})
		lbl.Name = "I"
	end
end

-- 副侧边栏胶囊容器宽度跟随数量变化（数量多时可横向滚动）
function Library:_UpdatePillWidth()
	local n = 0
	for i = 1, #self.PrimaryTabs do
		n = n + #self.PrimaryTabs[i].Secondaries
	end
	local PAD, ITEM, GAP = 16, 46, 14
	local needed = PAD * 2 + n * ITEM + math.max(0, n - 1) * GAP
	local available = DESIGN_W - 32 - 88 - 68
	local w = math.max(64, math.min(needed, available))
	self.PillScroll.Size = UDim2.fromOffset(w, 64)
	self.PillScroll.CanvasSize = UDim2.fromOffset(needed, 0)
end

--==============================================================================
-- 打开 / 关闭 / 自适应
--==============================================================================

function Library:Open()
	if self._visible then return end
	self._visible = true
	self.Window.Visible = true
	self.UIScale.Scale = self.Scale * 0.94
	tween(self.Window, { GroupTransparency = 0 })
	tween(self.UIScale, { Scale = self.Scale }, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out))
end

function Library:Close()
	if not self._visible then return end
	self._visible = false
	self:_ClosePopup()
	self:_ToggleSearch(false)
	tween(self.Window, { GroupTransparency = 1 })
	tween(self.UIScale, { Scale = self.Scale * 0.94 })
	task.delay(0.16, function()
		if not self._visible then
			self.Window.Visible = false
		end
	end)
end

function Library:Toggle()
	if self._visible then
		self:Close()
	else
		self:Open()
	end
end

function Library:IsOpen()
	return self._visible
end

--==============================================================================
-- 自定义项
--==============================================================================

function Library:SetFloatingIcon(v)
	self.Config.FloatingIcon = v
	self:_RenderFloatingIcon()
end

function Library:SetAvatar(v)
	self.Config.Avatar = v
	self:_RenderAvatar()
end

function Library:SetPlayerName(name)
	self.Config.PlayerName = name
	self.Topbar.PlayerName.Text = name
end

function Library:SetPlayerSubtitle(text)
	self.Config.PlayerSubtitle = text
	self.PlayerSubtitleLabel.Text = text
end

function Library:SetBrandIcon(v)
	self.Config.BrandIcon = v
	self:_RenderBrandIcon()
end

--==============================================================================
-- 弹出层（下拉框 / "..." 菜单）
--==============================================================================

function Library:_ClosePopup()
	if self._popup then
		if self._popup.Conn then
			self._popup.Conn:Disconnect()
		end
		if self._popup.Gui then
			self._popup.Gui:Destroy()
		end
		self._popup = nil
	end
end

function Library:_Popup(anchor, width, items, onPick)
	self:_ClosePopup()
	local T = self.Theme
	local s = self.Scale
	local vp = self:_Viewport()

	local rowH = math.floor(34 * s)
	local gap = math.floor(6 * s)
	local padV = math.floor(6 * s)
	local w = math.floor(width * s)
	local h = #items * rowH + padV * 2 + gap * (#items - 1)

	local pos = anchor.AbsolutePosition
	local size = anchor.AbsoluteSize
	local x = clamp(pos.X, 6, math.max(6, vp.X - w - 6))
	local y = pos.Y + size.Y + gap
	if y + h > vp.Y - 6 then
		y = math.max(6, pos.Y - h - gap)
	end

	local gui = new("CanvasGroup", {
		Name = "Popup",
		BackgroundColor3 = T.Panel,
		Size = UDim2.fromOffset(w, h),
		Position = UDim2.fromOffset(x, y),
		ClipsDescendants = false,
		GroupTransparency = 1,
		ZIndex = 120,
		Parent = self.Overlay,
	})
	corner(gui, math.floor(12 * s))
	stroke(gui, T.PanelBorder, 1, 0.1)

	new("UIListLayout", {
		FillDirection = Enum.FillDirection.Vertical,
		Padding = UDim.new(0, gap),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = gui,
	})
	padding(gui, padV, padV, padV, padV)

	gui.GroupTransparency = 1
	tween(gui, { GroupTransparency = 0 })

	for i = 1, #items do
		local item = items[i]
		local row = new("TextButton", {
			Name = "Item" .. i,
			BackgroundColor3 = T.Surface,
			BackgroundTransparency = 1,
			Text = "",
			Size = UDim2.new(1, 0, 0, rowH),
			AutoButtonColor = false,
			LayoutOrder = i,
			Parent = gui,
		})
		corner(row, math.floor(9 * s))

		new("TextLabel", {
			BackgroundTransparency = 1,
			Text = item.Name or tostring(item),
			Font = Enum.Font.Gotham,
			TextColor3 = T.Text,
			TextSize = math.floor(13 * s),
			TextXAlignment = Enum.TextXAlignment.Left,
			Position = UDim2.fromOffset(math.floor(12 * s), 0),
			Size = UDim2.new(1, -math.floor(24 * s), 1, 0),
			Parent = row,
		})

		row.MouseEnter:Connect(function()
			tween(row, { BackgroundTransparency = 0 })
		end)
		row.MouseLeave:Connect(function()
			tween(row, { BackgroundTransparency = 1 })
		end)
		row.MouseButton1Click:Connect(function()
			if onPick then onPick(item, i) end
		end)
	end

	local conn
	conn = UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1
			and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
		local p = gui.AbsolutePosition
		local sz = gui.AbsoluteSize
		local mp = input.Position
		local inside = mp.X >= p.X and mp.X <= p.X + sz.X and mp.Y >= p.Y and mp.Y <= p.Y + sz.Y
		if not inside then
			self:_ClosePopup()
		end
	end)

	self._popup = { Gui = gui, Conn = conn }
	return gui
end

--==============================================================================
-- 搜索
--==============================================================================

function Library:_ToggleSearch(force)
	local on
	if force == nil then
		on = not self.SearchActive
	else
		on = force
	end
	if on == self.SearchActive then return end
	self.SearchActive = on
	if on then
		self.SearchBar.Visible = true
		tween(self.SearchBar, { Size = UDim2.new(1, 0, 0, 46) })
		tween(self.Content, { Position = UDim2.new(0, 0, 0, 134), Size = UDim2.new(1, 0, 1, -134) })
		self.SearchBox.Text = ""
		self:_ApplyFilter("")
	else
		self:_ApplyFilter("")
		tween(self.SearchBar, { Size = UDim2.new(1, 0, 0, 0) })
		tween(self.Content, { Position = UDim2.new(0, 0, 0, 78), Size = UDim2.new(1, 0, 1, -78) })
		task.delay(0.16, function()
			if not self.SearchActive then
				self.SearchBar.Visible = false
			end
		end)
	end
end

function Library:_ApplyFilter(query)
	query = string.lower(query or "")
	self.SearchQuery = query
	local page = self.ActiveSecondary
	if not page then return end
	for _, sec in ipairs(page.Sections) do
		local any = false
		for _, row in ipairs(sec.Rows) do
			local match = true
			if query ~= "" then
				local title = string.lower(row.Title or "")
				local desc = string.lower(row.Desc or "")
				match = (string.find(title, query, 1, true) ~= nil)
					or (string.find(desc, query, 1, true) ~= nil)
			end
			row.Frame.Visible = match
			if match then any = true end
		end
		if #sec.Rows == 0 then
			sec.Container.Visible = true
		else
			sec.Container.Visible = any
		end
	end
end

--==============================================================================
-- 主侧边栏 / 副侧边栏
--==============================================================================

local Primary = {}
Primary.__index = Primary

local Secondary = {}
Secondary.__index = Secondary

local Section = {}
Section.__index = Section

function Library:Primary(name, icon)
	local p = setmetatable({}, Primary)
	p.Library = self
	p.Name = name or "Tab"
	p.Icon = icon or "square"
	p.Secondaries = {}
	p.Index = #self.PrimaryTabs + 1

	-- 主侧边栏按钮
	local btn = new("TextButton", {
		Name = "P" .. p.Index,
		BackgroundColor3 = self.Theme.Surface,
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(44, 44),
		Text = "",
		AutoButtonColor = false,
		LayoutOrder = p.Index,
		Parent = self.Sidebar,
	})
	corner(btn, 13)
	p.Button = btn

	local icon_ = createIcon(p.Icon, 24, self.Theme.Icon, btn)
	icon_.AnchorPoint = Vector2.new(0.5, 0.5)
	icon_.Position = UDim2.fromScale(0.5, 0.5)
	p.IconLabel = icon_

	-- 激活时的红色竖条（贴在侧边栏左缘）
	local edge = new("Frame", {
		Name = "Edge",
		BackgroundColor3 = self.Theme.Accent,
		Size = UDim2.new(0, 3, 0, 16),
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, -6, 0.5, 0),
		BackgroundTransparency = 1,
		ZIndex = 3,
		Parent = btn,
	})
	corner(edge, 2)
	p.Edge = edge

	btn.MouseEnter:Connect(function()
		if self.ActivePrimary ~= p then
			tween(btn, { BackgroundTransparency = 0.6 })
		end
	end)
	btn.MouseLeave:Connect(function()
		if self.ActivePrimary ~= p then
			tween(btn, { BackgroundTransparency = 1 })
		end
	end)
	btn.MouseButton1Click:Connect(function()
		p:Select()
	end)

	self.PrimaryTabs[#self.PrimaryTabs + 1] = p
	self:_UpdatePillWidth()
	if not self.ActivePrimary then
		p:Select()
	end
	return p
end

function Library:Tab(name, icon)
	return self:Primary(name, icon)
end

function Primary:Secondary(name, icon)
	local lib = self.Library
	local s = setmetatable({}, Secondary)
	s.Library = lib
	s.Primary = self
	s.Name = name or "Sub"
	s.Icon = icon or "circle"
	s.Sections = {}
	s.Index = #self.Secondaries + 1

	-- 副侧边栏图标按钮
	local holder = new("Frame", {
		Name = "S" .. s.Index,
		BackgroundColor3 = lib.Theme.ActivePill,
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(46, 46),
		LayoutOrder = s.Index,
		Parent = lib.PillScroll,
	})
	corner(holder, 14)
	s.Holder = holder

	local icon_ = createIcon(s.Icon, 22, lib.Theme.Icon, holder)
	icon_.AnchorPoint = Vector2.new(0.5, 0.5)
	icon_.Position = UDim2.fromScale(0.5, 0.5)
	s.IconLabel = icon_

	local underline = new("Frame", {
		Name = "Underline",
		BackgroundColor3 = lib.Theme.Accent,
		Size = UDim2.new(0, 22, 0, 3),
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.new(0.5, 0, 1, -3),
		BackgroundTransparency = 1,
		ZIndex = 3,
		Parent = holder,
	})
	corner(underline, 2)
	s.Underline = underline

	local click = new("TextButton", {
		Name = "Click",
		BackgroundTransparency = 1,
		Text = "",
		Size = UDim2.fromScale(1, 1),
		AutoButtonColor = false,
		Parent = holder,
	})

	click.MouseEnter:Connect(function()
		if lib.ActiveSecondary ~= s then
			icon_.TextColor3 = lib.Theme.IconHover
			if icon_.ClassName == "ImageLabel" then
				icon_.ImageColor3 = lib.Theme.IconHover
			end
		end
	end)
	click.MouseLeave:Connect(function()
		if lib.ActiveSecondary ~= s then
			icon_.TextColor3 = lib.Theme.Icon
			if icon_.ClassName == "ImageLabel" then
				icon_.ImageColor3 = lib.Theme.Icon
			end
		end
	end)
	click.MouseButton1Click:Connect(function()
		s:Select()
	end)

	-- 副侧边栏内容页
	local page = new("Frame", {
		Name = "Page",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Visible = false,
		Parent = lib.Content,
	})
	local layout = new("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		VerticalAlignment = Enum.VerticalAlignment.Top,
		Padding = UDim.new(0, 16),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = page,
	})
	s.Page = page
	s.Layout = layout

	local colWidth = lib.Config.Columns > 1 and UDim2.new(0.5, -8, 0, 0) or UDim2.new(1, 0, 0, 0)
	s.Columns = {}
	for i = 1, math.max(1, lib.Config.Columns) do
		local col = new("Frame", {
			Name = "Col" .. i,
			BackgroundTransparency = 1,
			Size = colWidth,
			AutomaticSize = Enum.AutomaticSize.Y,
			LayoutOrder = i,
			Parent = page,
		})
		new("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0, 12),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = col,
		})
		s.Columns[i] = col
	end

	-- 让 page 高度跟随内容
	page.AutomaticSize = Enum.AutomaticSize.Y

	self.Secondaries[#self.Secondaries + 1] = s
	lib:_UpdatePillWidth()

	-- 若该主侧边栏正处于激活状态且当前没有任何副侧边栏被选中，则自动选中它
	if lib.ActivePrimary == self and lib.ActiveSecondary == nil then
		s:Select()
	end
	return s
end

function Primary:Tab(name, icon)
	return self:Secondary(name, icon)
end

function Primary:Select()
	local lib = self.Library
	local T = lib.Theme
	if lib.ActivePrimary == self then
		if not lib.ActiveSecondary and self.Secondaries[1] then
			self.Secondaries[1]:Select()
		end
		return
	end
	local prev = lib.ActivePrimary
	lib.ActivePrimary = self

	if prev then
		tween(prev.Button, { BackgroundTransparency = 1 })
		tween(prev.Edge, { BackgroundTransparency = 1 })
		if prev.IconLabel.ClassName == "ImageLabel" then
			tween(prev.IconLabel, { ImageColor3 = T.Icon })
		else
			tween(prev.IconLabel, { TextColor3 = T.Icon })
		end
	end

	tween(self.Button, { BackgroundTransparency = 0 })
	tween(self.Edge, { BackgroundTransparency = 0 })
	if self.IconLabel.ClassName == "ImageLabel" then
		tween(self.IconLabel, { ImageColor3 = T.IconActive })
	else
		tween(self.IconLabel, { TextColor3 = T.IconActive })
	end

	if self.Secondaries[1] then
		self.Secondaries[1]:Select()
	else
		if prev and prev.Secondaries and lib.ActiveSecondary then
			local was = lib.ActiveSecondary
			if was.Primary == prev then
				was.Page.Visible = false
				was.Holder.BackgroundTransparency = 1
				was.Underline.BackgroundTransparency = 1
				lib.ActiveSecondary = nil
			end
		end
	end
end

function Primary:SelectSecondary(index)
	if self.Secondaries[index] then
		self.Secondaries[index]:Select()
	end
end

function Secondary:Select()
	local lib = self.Library
	local T = lib.Theme
	if lib.ActivePrimary ~= self.Primary then
		lib.ActivePrimary = self.Primary
	end
	local prev = lib.ActiveSecondary
	lib.ActiveSecondary = self

	if prev and prev ~= self then
		prev.Page.Visible = false
		tween(prev.Holder, { BackgroundTransparency = 1 })
		tween(prev.Underline, { BackgroundTransparency = 1 })
		if prev.IconLabel.ClassName == "ImageLabel" then
			tween(prev.IconLabel, { ImageColor3 = T.Icon })
		else
			tween(prev.IconLabel, { TextColor3 = T.Icon })
		end
	end

	self.Page.Visible = true
	tween(self.Holder, { BackgroundTransparency = 0 })
	tween(self.Underline, { BackgroundTransparency = 0 })
	if self.IconLabel.ClassName == "ImageLabel" then
		tween(self.IconLabel, { ImageColor3 = T.IconActive })
	else
		tween(self.IconLabel, { TextColor3 = T.IconActive })
	end

	lib.Content.CanvasPosition = Vector2.new(0, 0)
	lib:_ClosePopup()
	lib:_ApplyFilter(lib.SearchQuery)
end

function Secondary:Section(title, column)
	local s = setmetatable({}, Section)
	s.Page = self
	s.Library = self.Library
	s.Title = title
	s.Rows = {}

	local target
	if column then
		target = self.Columns[column] or self.Columns[1]
	else
		-- 交替放入左右两列，形成两栏布局
		local n = #self.Sections
		local count = #self.Columns
		target = self.Columns[(n % count) + 1]
	end
	s.Column = target

	local container = new("Frame", {
		Name = "Section",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		LayoutOrder = #self.Sections + 1,
		Parent = target,
	})
	new("UIListLayout", {
		FillDirection = Enum.FillDirection.Vertical,
		Padding = UDim.new(0, 0),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = container,
	})
	s.Container = container

	if title then
		local head = new("Frame", {
			Name = "Head",
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 30),
			LayoutOrder = 1,
			Parent = container,
		})
		new("TextLabel", {
			BackgroundTransparency = 1,
			Text = title,
			Font = Enum.Font.GothamMedium,
			TextColor3 = self.Library.Theme.TextMuted,
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			Position = UDim2.fromOffset(6, 4),
			Size = UDim2.new(1, -12, 1, -4),
			Parent = head,
		})
	end

	local card = new("Frame", {
		Name = "Card",
		BackgroundColor3 = self.Library.Theme.Panel,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		LayoutOrder = 2,
		Parent = container,
	})
	corner(card, 16)
	stroke(card, self.Library.Theme.PanelBorder, 1, 0.35)
	padding(card, 6, 0, 6, 0)
	new("UIListLayout", {
		FillDirection = Enum.FillDirection.Vertical,
		Padding = UDim.new(0, 0),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = card,
	})
	s.Card = card
	s._lastDivider = nil

	self.Sections[#self.Sections + 1] = s
	return s
end

function Secondary:Group(title, column)
	return self:Section(title, column)
end

--==============================================================================
-- 行（Row）构造
--==============================================================================

local rowCounter = 0

function Section:_Row(cfg, height, title, desc)
	rowCounter = rowCounter + 1
	local T = self.Library.Theme

	-- 上一条行现在需要分隔线了
	if self._lastDivider then
		self._lastDivider.Visible = true
	end

	local row = new("Frame", {
		Name = "Row",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, height),
		LayoutOrder = rowCounter,
		Parent = self.Card,
	})

	if title then
		new("TextLabel", {
			Name = "Title",
			BackgroundTransparency = 1,
			Text = title,
			Font = Enum.Font.GothamMedium,
			TextColor3 = T.Text,
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Position = UDim2.fromOffset(16, 12),
			Size = UDim2.new(1, -190, 0, 18),
			Parent = row,
		})
	end

	if desc then
		new("TextLabel", {
			Name = "Desc",
			BackgroundTransparency = 1,
			Text = desc,
			Font = Enum.Font.Gotham,
			TextColor3 = T.TextDesc,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextWrapped = false,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Position = UDim2.fromOffset(16, 34),
			Size = UDim2.new(1, -190, 0, 16),
			Parent = row,
		})
	end

	local divider = new("Frame", {
		Name = "Divider",
		BackgroundColor3 = T.Divider,
		Size = UDim2.new(1, -32, 0, 1),
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.new(0.5, 0, 1, 0),
		BackgroundTransparency = 0,
		Visible = false,
		Parent = row,
	})
	self._lastDivider = divider
	divider.Visible = false

	return row, divider
end

--==============================================================================
-- Toggle 开关
--==============================================================================

local ToggleCtl = {}
ToggleCtl.__index = ToggleCtl

function Section:Toggle(cfg)
	cfg = cfg or {}
	local lib = self.Library
	local T = lib.Theme
	local row = self:_Row(cfg, 62, cfg.Title, cfg.Desc)
	local obj = setmetatable({}, ToggleCtl)
	obj.Value = cfg.Default and true or false
	obj.Callback = cfg.Callback
	self.Rows[#self.Rows + 1] = { Frame = row, Title = cfg.Title, Desc = cfg.Desc }

	-- "..." 菜单
	local hasMenu = cfg.Menu and #cfg.Menu > 0
	local dots
	if hasMenu then
		dots = new("TextButton", {
			Name = "Dots",
			BackgroundColor3 = T.Surface,
			BackgroundTransparency = 1,
			Text = "⋯",
			Font = Enum.Font.GothamBold,
			TextColor3 = T.TextMuted,
			TextSize = 16,
			TextXAlignment = Enum.TextXAlignment.Center,
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -76, 0.5, 0),
			Size = UDim2.fromOffset(26, 26),
			AutoButtonColor = false,
			Parent = row,
		})
		corner(dots, 8)
		dots.MouseEnter:Connect(function()
			tween(dots, { BackgroundTransparency = 0 })
		end)
		dots.MouseLeave:Connect(function()
			tween(dots, { BackgroundTransparency = 1 })
		end)
		dots.MouseButton1Click:Connect(function()
			lib:_Popup(dots, 150, cfg.Menu, function(item)
				lib:_ClosePopup()
				if item.Callback then
					task.spawn(item.Callback)
				end
			end)
		end)
	end

	local track = new("TextButton", {
		Name = "Track",
		BackgroundColor3 = obj.Value and T.Accent or T.ToggleOff,
		Text = "",
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -16, 0.5, 0),
		Size = UDim2.fromOffset(44, 24),
		AutoButtonColor = false,
		Parent = row,
	})
	corner(track, 12)

	local knob = new("Frame", {
		Name = "Knob",
		BackgroundColor3 = T.ToggleKnob,
		Size = UDim2.fromOffset(18, 18),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = obj.Value and UDim2.new(1, -12, 0.5, 0) or UDim2.new(0, 12, 0.5, 0),
		Parent = track,
	})
	corner(knob, 9)

	function obj:_Render(animate)
		local info = animate and TWEEN_INFO or TweenInfo.new(0)
		local bg = self.Value and T.Accent or T.ToggleOff
		local pos = self.Value and UDim2.new(1, -12, 0.5, 0) or UDim2.new(0, 12, 0.5, 0)
		if animate then
			tween(track, { BackgroundColor3 = bg }, info)
			tween(knob, { Position = pos }, info)
		else
			track.BackgroundColor3 = bg
			knob.Position = pos
		end
	end

	function obj:Set(v, fire)
		self.Value = v and true or false
		self:_Render(true)
		if fire ~= false and self.Callback then
			task.spawn(self.Callback, self.Value)
		end
	end

	function obj:Get()
		return self.Value
	end

	local function activate()
		obj:Set(not obj.Value)
	end
	track.MouseButton1Click:Connect(activate)

	obj.Track = track
	obj.Row = row
	obj:_Render(false)
	return obj
end

--==============================================================================
-- Slider 滑块
--==============================================================================

local SliderCtl = {}
SliderCtl.__index = SliderCtl

function Section:Slider(cfg)
	cfg = cfg or {}
	local lib = self.Library
	local T = lib.Theme
	local min = tonumber(cfg.Min) or 0
	local max = tonumber(cfg.Max) or 100
	local step = tonumber(cfg.Step) or 1
	local row = self:_Row(cfg, 88, cfg.Title, cfg.Desc)

	local obj = setmetatable({}, SliderCtl)
	obj.Min = min
	obj.Max = max
	obj.Step = step
	obj.Callback = cfg.Callback
	obj.Format = cfg.Format or function(v) return string.format("%.1f", v) end
	self.Rows[#self.Rows + 1] = { Frame = row, Title = cfg.Title, Desc = cfg.Desc }

	local valueLabel = new("TextLabel", {
		Name = "Value",
		BackgroundTransparency = 1,
		Text = "",
		Font = Enum.Font.GothamMedium,
		TextColor3 = T.TextMuted,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Right,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -16, 0, 12),
		Size = UDim2.new(0, 120, 0, 18),
		Parent = row,
	})
	obj.ValueLabel = valueLabel

	local track = new("Frame", {
		Name = "Track",
		BackgroundColor3 = T.Track,
		Position = UDim2.new(0, 16, 0, 56),
		Size = UDim2.new(1, -32, 0, 12),
		Parent = row,
	})
	corner(track, 6)
	obj.Track = track

	local fill = new("Frame", {
		Name = "Fill",
		BackgroundColor3 = T.Accent,
		Size = UDim2.new(0, 0, 1, 0),
		Parent = track,
	})
	corner(fill, 6)
	obj.Fill = fill

	local knob = new("Frame", {
		Name = "Knob",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		Size = UDim2.fromOffset(10, 22),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0, 0, 0.5, 0),
		ZIndex = 3,
		Parent = track,
	})
	corner(knob, 5)
	obj.Knob = knob

	local hit = new("TextButton", {
		Name = "Hit",
		BackgroundTransparency = 1,
		Text = "",
		Position = UDim2.new(0, 0, 0, -8),
		Size = UDim2.new(1, 0, 1, 16),
		AutoButtonColor = false,
		Parent = track,
	})

	function obj:_Apply(value, fire)
		value = clamp(value, min, max)
		value = round(value, step)
		value = clamp(value, min, max)
		self.Value = value
		local pct = 0
		if max > min then
			pct = (value - min) / (max - min)
		end
		self.Fill.Size = UDim2.new(pct, 0, 1, 0)
		self.Knob.Position = UDim2.new(pct, 0, 0.5, 0)
		self.ValueLabel.Text = self.Format(value)
		if fire ~= false and self.Callback then
			task.spawn(self.Callback, value)
		end
	end

	function obj:Set(value)
		self:_Apply(value, true)
	end

	function obj:Get()
		return self.Value
	end

	local dragging = false
	local function fromInput(input)
		local rel = 0
		if track.AbsoluteSize.X > 0 then
			rel = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
		end
		rel = clamp(rel, 0, 1)
		obj:_Apply(min + rel * (max - min), true)
	end

	hit.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			fromInput(input)
			lib:_ClosePopup()
		end
	end)
	local c1 = UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch) then
			fromInput(input)
		end
	end)
	local c2 = UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
	lib._conns[#lib._conns + 1] = c1
	lib._conns[#lib._conns + 1] = c2

	obj.Row = row
	obj:_Apply(tonumber(cfg.Default) or min, false)
	return obj
end

--==============================================================================
-- Dropdown 下拉框
--==============================================================================

local DropdownCtl = {}
DropdownCtl.__index = DropdownCtl

function Section:Dropdown(cfg)
	cfg = cfg or {}
	local lib = self.Library
	local T = lib.Theme
	local options = cfg.Options or {}
	local row = self:_Row(cfg, 62, cfg.Title, nil)

	local obj = setmetatable({}, DropdownCtl)
	obj.Options = options
	obj.Callback = cfg.Callback
	obj.Value = cfg.Default or options[1]
	self.Rows[#self.Rows + 1] = { Frame = row, Title = cfg.Title, Desc = cfg.Desc }

	local btn = new("TextButton", {
		Name = "Dropdown",
		BackgroundColor3 = T.Surface,
		Text = "",
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -16, 0.5, 0),
		Size = UDim2.fromOffset(150, 36),
		AutoButtonColor = false,
		Parent = row,
	})
	corner(btn, 10)
	stroke(btn, T.PanelBorder, 1, 0.3)
	obj.Button = btn

	local text = new("TextLabel", {
		Name = "Value",
		BackgroundTransparency = 1,
		Text = tostring(obj.Value),
		Font = Enum.Font.Gotham,
		TextColor3 = T.Text,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Position = UDim2.fromOffset(12, 0),
		Size = UDim2.new(1, -40, 1, 0),
		Parent = btn,
	})
	obj.ValueLabel = text

	local chev = createIcon("chevronDown", 16, T.TextMuted, btn)
	chev.AnchorPoint = Vector2.new(1, 0.5)
	chev.Position = UDim2.new(1, -12, 0.5, 0)

	btn.MouseEnter:Connect(function()
		tween(btn, { BackgroundColor3 = T.SurfaceHover })
	end)
	btn.MouseLeave:Connect(function()
		tween(btn, { BackgroundColor3 = T.Surface })
	end)

	function obj:Set(value, fire)
		self.Value = value
		self.ValueLabel.Text = tostring(value)
		if fire ~= false and self.Callback then
			task.spawn(self.Callback, value)
		end
	end

	function obj:Get()
		return self.Value
	end

	btn.MouseButton1Click:Connect(function()
		local items = {}
		for i = 1, #options do
			items[i] = { Name = tostring(options[i]), _value = options[i] }
		end
		lib:_Popup(btn, 150, items, function(item)
			lib:_ClosePopup()
			obj:Set(item._value)
		end)
	end)

	obj.Row = row
	return obj
end

--==============================================================================
-- Button 按钮
--==============================================================================

local ButtonCtl = {}
ButtonCtl.__index = ButtonCtl

function Section:Button(cfg)
	cfg = cfg or {}
	local lib = self.Library
	local T = lib.Theme
	local row = self:_Row(cfg, 58, cfg.Title, cfg.Desc)
	local obj = setmetatable({}, ButtonCtl)
	self.Rows[#self.Rows + 1] = { Frame = row, Title = cfg.Title, Desc = cfg.Desc }

	local btn = new("TextButton", {
		Name = "Button",
		BackgroundColor3 = T.Accent,
		Text = cfg.Text or "确认",
		Font = Enum.Font.GothamMedium,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 13,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -16, 0.5, 0),
		Size = UDim2.fromOffset(150, 34),
		AutoButtonColor = false,
		Parent = row,
	})
	corner(btn, 10)
	obj.Button = btn

	btn.MouseEnter:Connect(function()
		tween(btn, { BackgroundColor3 = T.AccentSoft })
	end)
	btn.MouseLeave:Connect(function()
		tween(btn, { BackgroundColor3 = T.Accent })
	end)
	btn.MouseButton1Click:Connect(function()
		if cfg.Callback then
			task.spawn(cfg.Callback)
		end
	end)

	obj.Row = row
	return obj
end

--==============================================================================
-- Label 文本
--==============================================================================

function Section:Label(cfg)
	cfg = cfg or {}
	local lib = self.Library
	local T = lib.Theme
	local row
	if cfg.Title then
		row = self:_Row(cfg, 58, cfg.Title, cfg.Desc)
	else
		row = self:_Row(cfg, 34, nil, nil)
		new("TextLabel", {
			BackgroundTransparency = 1,
			Text = cfg.Text or "",
			Font = Enum.Font.Gotham,
			TextColor3 = T.TextMuted,
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextWrapped = true,
			Position = UDim2.fromOffset(16, 0),
			Size = UDim2.new(1, -32, 1, 0),
			Parent = row,
		})
	end
	self.Rows[#self.Rows + 1] = { Frame = row, Title = cfg.Title or cfg.Text, Desc = cfg.Desc }
	return row
end

--==============================================================================
-- 销毁
--==============================================================================

function Library:Destroy()
	self:_ClosePopup()
	for _, c in ipairs(self._conns) do
		pcall(function() c:Disconnect() end)
	end
	self._conns = {}
	if self.Root then
		self.Root:Destroy()
	end
end

Library.Primary = Primary
Library.Secondary = Secondary
Library.Section = Section

--==============================================================================
-- RedUI 演示（自包含，直接整段粘贴到执行器运行即可）
-- 悬浮窗默认在屏幕右侧中部：点一下打开主界面，再点一下关闭；可拖动。
--==============================================================================

local lib = Library.new({
	BrandName      = "Brand name",
	BrandSlogan    = "The slogan, if there is one.",
	BrandIcon      = nil,                     -- 右上角圆形图片，可填 "rbxassetid://000000"
	PlayerName     = "Past Owl",              -- 左上角玩家名字
	PlayerSubtitle = "Till: 1 mar 2026",
	Avatar         = nil,                     -- 左上角玩家头像，可填 "rbxassetid://000000"
	FloatingIcon   = nil,                     -- 悬浮窗图片，可填 "rbxassetid://000000"
	ToggleKey      = Enum.KeyCode.RightShift, -- 也可按此键开关
	Columns        = 2,
})

-- 主侧边栏
local combat  = lib:Primary("Combat", "shield")
local visual  = lib:Primary("Visuals", "eye")
local aim     = lib:Primary("Aim", "target")
local clicker = lib:Primary("Clicker", "hand")
local cursor  = lib:Primary("Cursor", "cursor")
local config  = lib:Primary("Configs", "folder")
local setting = lib:Primary("Settings", "settings")

-- 副侧边栏（Combat 下挂 5 个，对应截图顶部那一排）
local sMain   = combat:Secondary("Main", "settings")
local sTarget = combat:Secondary("Target", "target")
local sBurst  = combat:Secondary("Burst", "lightning")
local sInput  = combat:Secondary("Input", "hand")
local sOther  = combat:Secondary("Other", "wand")

visual:Secondary("Render", "eye")
aim:Secondary("Lock", "target")
clicker:Secondary("Auto", "hand")
cursor:Secondary("Style", "cursor")
config:Secondary("Slots", "folder")
setting:Secondary("General", "settings")

-- 内容
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
	Menu = { { Name = "Options", Callback = function() end } },
	Callback = function(v) end,
})
misc:Toggle({
	Title = "Fast mode",
	Desc  = "Speeds up the processing interval.",
	Default = false,
	Menu = { { Name = "Options", Callback = function() end } },
	Callback = function(v) end,
})
misc:Slider({
	Title = "Range value",
	Desc  = "Adjusts the effective range of this option.",
	Min = 0, Max = 100, Step = 1, Default = 50,
	Callback = function(v) end,
})

-- 其它副侧边栏的示例内容
sTarget:Section("Targeting & Detection"):Button({
	Title = "Refresh target list",
	Text  = "Refresh",
	Callback = function() print("refresh") end,
})
sTarget:Section("Display"):Label({ Text = "这是一个 Label 文本示例，可换行显示较长说明。" })
sOther:Section("Actions"):Button({
	Title = "Run action",
	Text  = "Run",
	Callback = function() print("run") end,
})

-- 直接打开，方便你一进来就看到主界面
lib:Open()

print("[RedUI] loaded. 悬浮窗：点击开/关；拖动可移动。")