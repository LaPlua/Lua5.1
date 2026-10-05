--[[
	星 穹 · C E L E S T   —— 无窗体星图 UI 库
	=================================================================
	不依赖任何 UI 库。内环星点选分类，外环出该分类的功能星；
	某类功能多则自动多开几环。电脑 + 手机通用。

	用法：
		local Celest = loadstring(game:HttpGet("https://raw.githubusercontent.com/LaPlua/Lua5.1/main/Celest.lua"))()
		local win = Celest.new({ title = "星穹", subtitle = "C E L E S T", hint = "按 ALT 呼出 / 再按归寂" })

		local cat = win:Category("兵戈", "sword")   -- glyph 可用内置矢量图标名，如 sword / eye / gear
		cat:Toggle("自动瞄准", false, function(on) print(on) end)
		cat:Slider("视野半径", 0, 100, 50, function(v) print(v) end)
		cat:Dropdown("模式", { "平衡", "激进" }, "平衡", function(v) print(v) end)
		cat:Button("执行一次", function() print("bang") end)

	操作：
		· 电脑：按 ALT 呼出星图，再按归寂；CTRL + K 低语搜索
		· 手机：点右下角常驻星点呼出，再点归寂
		· 内环星点 = 选分类；功能星 = 开关；数值星拖动调值；
		  下拉星展开选择；带箭头的星点一次执行；点空白只取消选中，绝不丢状态
--]]

local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS          = game:GetService("UserInputService")
local RunService   = game:GetService("RunService")

local LP    = Players.LocalPlayer
local TOUCH = UIS.TouchEnabled and not UIS.MouseEnabled

local Celest = {}
Celest.__index = Celest

---------------------------------------------------------------- 主题（可被 new 覆盖）
local T = {
	void    = Color3.fromRGB(5, 3, 10),
	panel   = Color3.fromRGB(10, 7, 22),
	nebA    = Color3.fromRGB(43, 26, 82),
	nebB    = Color3.fromRGB(20, 29, 84),
	nebC    = Color3.fromRGB(58, 28, 80),
	star    = Color3.fromRGB(233, 230, 255),
	accent  = Color3.fromRGB(183, 157, 255),
	accent2 = Color3.fromRGB(138, 107, 255),
	line    = Color3.fromRGB(169, 139, 255),
	dim     = Color3.fromRGB(205, 198, 255),
}

---------------------------------------------------------------- 小工具
local function mk(cls, props)
	local o = Instance.new(cls)
	local p = props and props.Parent
	for k, v in pairs(props or {}) do
		if k ~= "Parent" then o[k] = v end
	end
	if p then o.Parent = p end
	return o
end

local function round(o, r)
	return mk("UICorner", { Parent = o, CornerRadius = UDim.new(r or 1, 0) })
end

local function stroke(o, color, th, tr)
	return mk("UIStroke", { Parent = o, Color = color, Thickness = th or 1, Transparency = tr or 0 })
end

local function circle(parent, size, color, tr)
	local f = mk("Frame", {
		Parent = parent,
		Size = UDim2.fromOffset(size, size),
		Position = UDim2.fromScale(.5, .5),
		AnchorPoint = Vector2.new(.5, .5),
		BackgroundColor3 = color,
		BackgroundTransparency = tr or 0,
		BorderSizePixel = 0,
	})
	round(f, 1)
	return f
end

local function ring(size, color, tr)
	local f = mk("Frame", {
		Size = UDim2.fromOffset(size, size),
		Position = UDim2.fromScale(.5, .5),
		AnchorPoint = Vector2.new(.5, .5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})
	round(f, 1)
	stroke(f, color, 1, tr or .9)
	return f
end

local function tw(o, t, props, style, dir)
	if not o or not o.Parent then return nil end
	local ti = TweenInfo.new(t, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out)
	local ok, a = pcall(function() return TweenService:Create(o, ti, props) end)
	if not ok or not a then return nil end
	a:Play()
	return a
end

local function blob(parent, size, color, base)
	local holder = mk("Frame", {
		Parent = parent,
		Size = UDim2.fromOffset(size, size),
		Position = UDim2.fromScale(.5, .5),
		AnchorPoint = Vector2.new(.5, .5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	})
	for i = 6, 1, -1 do
		local s = size * (0.42 + 0.58 * (i / 6))
		local c = circle(holder, s, color, math.min(.995, base + (i - 1) * 0.018))
		c.ZIndex = 0
	end
	return holder
end

local function placeOn(node, r, deg)
	local a = math.rad(deg)
	node.Position = UDim2.new(.5, math.cos(a) * r, .5, math.sin(a) * r)
	node.AnchorPoint = Vector2.new(.5, .5)
end

local function vpSize()
	local cam = workspace.CurrentCamera
	return cam and cam.ViewportSize or Vector2.new(1280, 720)
end

---------------------------------------------------------------- 图标库（纯矢量绘制，不依赖字体）
-- 图标全部用 Frame / UIStroke 现场画，任何执行器与分辨率都不会出现方框或乱码。
local function bar(parent, w, h, color, x, y, rot, r)
	local f = mk("Frame", {
		Parent = parent, Size = UDim2.fromOffset(w, h),
		Position = UDim2.new(.5, x or 0, .5, y or 0), AnchorPoint = Vector2.new(.5, .5),
		BackgroundColor3 = color, BackgroundTransparency = 0, BorderSizePixel = 0,
		Rotation = rot or 0,
	})
	round(f, r == nil and 1 or r)
	return f
end

local function obox(parent, w, h, color, tr, th, r, x, y)
	local f = mk("Frame", {
		Parent = parent, Size = UDim2.fromOffset(w, h),
		Position = UDim2.new(.5, x or 0, .5, y or 0), AnchorPoint = Vector2.new(.5, .5),
		BackgroundTransparency = 1, BorderSizePixel = 0,
	})
	round(f, r == nil and 1 or r)
	stroke(f, color, th or 1.6, tr or 0)
	return f
end

local ICONS = {}

ICONS.dot = function(h, c) bar(h, 5, 5, c) end

ICONS.sword = function(h, c)
	bar(h, 2, 17, c, 0, 0, 45)
	bar(h, 2, 17, c, 0, 0, -45)
	bar(h, 9, 2, c, 0, 7, 0)
end

ICONS.shield = function(h, c)
	obox(h, 14, 17, c, 0, 1.6, .32)
	bar(h, 2, 9, c, 0, 1)
end

ICONS.eye = function(h, c)
	obox(h, 20, 12, c, 0, 1.5, 1)
	bar(h, 4, 4, c)
end

ICONS.target = function(h, c)
	obox(h, 19, 19, c, 0, 1.5, 1)
	obox(h, 10, 10, c, 0, 1.5, 1)
	bar(h, 3, 3, c)
end

ICONS.crosshair = function(h, c)
	obox(h, 13, 13, c, 0, 1.5, 1)
	bar(h, 2, 5, c, 0, -9)
	bar(h, 2, 5, c, 0, 9)
	bar(h, 5, 2, c, -9, 0)
	bar(h, 5, 2, c, 9, 0)
end

ICONS.bolt = function(h, c)
	bar(h, 3, 9, c, -3, -4, -48)
	bar(h, 3, 9, c, 3, 4, -48)
	bar(h, 8, 3, c, 0, 0)
end

ICONS.gear = function(h, c)
	obox(h, 13, 13, c, 0, 1.5, 1)
	for i = 0, 5 do
		local a = math.rad(i * 60)
		bar(h, 2.5, 5, c, math.cos(a) * 8.5, math.sin(a) * 8.5, i * 60)
	end
end

ICONS.layers = function(h, c)
	for i = -1, 1 do bar(h, 16, 2.4, c, 0, i * 5) end
end

ICONS.search = function(h, c)
	obox(h, 12, 12, c, 0, 1.6, 1, -3, -3)
	bar(h, 2, 8, c, 5, 5, 45)
end

ICONS.star = function(h, c)
	bar(h, 2, 18, c, 0, 0, 0, 1)
	bar(h, 2, 18, c, 0, 0, 90, 1)
	bar(h, 2, 18, c, 0, 0, 45, 1)
	bar(h, 2, 18, c, 0, 0, -45, 1)
end

ICONS.run = function(h, c)
	bar(h, 13, 2.6, c, -1, 0, 0, 1)
	bar(h, 7, 2.6, c, 3, -4, -42, 1)
	bar(h, 7, 2.6, c, 3, 4, 42, 1)
end

ICONS.wave = function(h, c)
	bar(h, 2.6, 6, c, -6, 1, 0, 1)
	bar(h, 2.6, 13, c, 0, 0, 0, 1)
	bar(h, 2.6, 9, c, 6, 0, 0, 1)
end

ICONS.list = function(h, c)
	for i = -1, 1 do
		bar(h, 3, 3, c, -7, i * 5)
		bar(h, 12, 2.2, c, 2, i * 5, 0, 1)
	end
end

ICONS.check = function(h, c)
	bar(h, 2.4, 9, c, -3.5, 3, 45, 1)
	bar(h, 2.4, 15, c, 4, -1, -45, 1)
end

ICONS.lock = function(h, c)
	obox(h, 9, 9, c, 0, 1.5, 1, 0, -3)
	obox(h, 14, 11, c, 0, 1.5, .25, 0, 4)
end

ICONS.power = function(h, c)
	obox(h, 16, 16, c, 0, 1.6, 1)
	bar(h, 2, 9, c, 0, -5, 0, 1)
end

ICONS.plus = function(h, c)
	bar(h, 2.6, 14, c, 0, 0, 0, 1)
	bar(h, 14, 2.6, c, 0, 0, 0, 1)
end

ICONS.box = function(h, c)
	obox(h, 15, 15, c, 0, 1.5, .25)
	bar(h, 3, 3, c)
end

ICONS.flag = function(h, c)
	bar(h, 2, 18, c, -5, 0, 0, 1)
	bar(h, 10, 3, c, 1, -5, 0, 1)
	bar(h, 7, 3, c, .5, -1, 0, 1)
end

ICONS.home = function(h, c)
	bar(h, 2.4, 9, c, 0, 3, 0, 1)
	bar(h, 10, 2.4, c, -4, -3, 45, 1)
	bar(h, 10, 2.4, c, 4, -3, -45, 1)
end

ICONS.info = function(h, c)
	obox(h, 17, 17, c, 0, 1.5, 1)
	bar(h, 3, 3, c, 0, -4)
	bar(h, 2, 6, c, 0, 2, 0, 1)
end

ICONS.warn = function(h, c)
	bar(h, 2.4, 13, c, -4, 2, 20, 1)
	bar(h, 2.4, 13, c, 4, 2, -20, 1)
	bar(h, 13, 2.4, c, 0, 8, 0, 1)
	bar(h, 3, 3, c, 0, -1)
end

ICONS.sound = function(h, c)
	bar(h, 3, 7, c, -6, 0, 0, 1)
	bar(h, 3, 12, c, -1, 0, 0, 1)
	bar(h, 3, 17, c, 4, 0, 0, 1)
end

ICONS.code = function(h, c)
	bar(h, 2.4, 7, c, -4, -4, 45, 1)
	bar(h, 2.4, 7, c, -4, 4, -45, 1)
	bar(h, 2.4, 7, c, 4, -4, -45, 1)
	bar(h, 2.4, 7, c, 4, 4, 45, 1)
end

ICONS.text = function(h, c)
	bar(h, 15, 2.4, c, 0, -6, 0, 1)
	bar(h, 11, 2.4, c, -1, 0, 0, 1)
	bar(h, 7, 2.4, c, -3, 6, 0, 1)
end

ICONS.radar = function(h, c)
	obox(h, 19, 19, c, 0, 1.5, 1)
	obox(h, 11, 11, c, 0, 1.3, 1)
	bar(h, 2, 8, c, 3, -3, 45, 1)
end

local function drawIcon(name, parent, color, box)
	local fn = ICONS[name]
	if not fn then return nil end
	local h = mk("Frame", {
		Parent = parent, Size = UDim2.fromOffset(box or 24, box or 24),
		Position = UDim2.fromScale(.5, .5), AnchorPoint = Vector2.new(.5, .5),
		BackgroundTransparency = 1, ZIndex = 9,
	})
	fn(h, color)
	local parts = {}
	for _, d in ipairs(h:GetDescendants()) do
		if d:IsA("Frame") or d:IsA("UIStroke") then parts[#parts + 1] = d end
	end
	return h, parts
end

-- 圆环分段参数（环距已在原示例基础上收紧）
local PER_RING = 8
local R_IN     = 172
local R_FIRST  = 286
local STEP_R   = 106

---------------------------------------------------------------- 单窗口实例
local win   -- 当前窗口（本库按单窗口使用）

local function newWindow(cfg)
	cfg = cfg or {}
	for k, v in pairs(cfg.theme or {}) do T[k] = v end
	if cfg.accent then
		T.accent  = cfg.accent
		T.accent2 = cfg.accent
		T.line    = cfg.accent
	end

	local self = setmetatable({}, Celest)
	self.cfg      = cfg
	self.cats     = {}
	self.items    = {}      -- name -> item
	self.active   = 1
	self.shell    = nil
	self.mapOpen, self.pinned = false, false
	self.selected = nil
	self.dragging, self.dragMoved, self.dragCtx = false, false, nil
	self.visible  = false
	return self
end

---------------------------------------------------------------- 数据层 API
function Celest:Category(name, glyph)
	local c = { name = name, glyph = glyph or "✦", items = {} }
	self.cats[#self.cats + 1] = c
	self:_dirty()
	return setmetatable({ win = self, data = c, name = c.name, items = c.items }, { __index = Celest._Cat })
end

Celest._Cat = {}
Celest._Cat.__index = Celest._Cat

local function addItem(cat, item)
	cat.data.items[#cat.data.items + 1] = item
	cat.win.items[item.name] = item
	cat.win:_dirty()
	return item
end

function Celest._Cat:Toggle(name, default, cb)
	return addItem(self, { kind = "toggle", name = name, value = default and true or false, cb = cb })
end

-- onCb 可选：滑块星点按开 / 关时触发 onCb(on)；cb 仍只在调值时触发
function Celest._Cat:Slider(name, min, max, default, cb, onCb)
	min, max = min or 0, max or 100
	local d = default or min
	return addItem(self, { kind = "slider", name = name, min = min, max = max, value = d, cb = cb, on = true, onCb = onCb })
end

function Celest._Cat:Button(name, cb)
	return addItem(self, { kind = "button", name = name, cb = cb })
end

-- 下拉框：options 为字符串数组，value 为当前选中项
function Celest._Cat:Dropdown(name, options, default, cb)
	options = options or {}
	local d = default
	if d == nil then d = options[1] end
	return addItem(self, { kind = "dropdown", name = name, options = options, value = d, cb = cb })
end

function Celest:_dirty()
	if self._pending then return end
	self._pending = true
	task.defer(function()
		self._pending = false
		self:_build()
	end)
end

function Celest:Select(name)
	for i, c in ipairs(self.cats) do
		if c.name == name then
			self.active = i
			if self.shell then self:_renderOuter() end
			return
		end
	end
end

function Celest:Open()  if self.shell then self:_open()  end end
function Celest:Close() if self.shell then self:_close() end end
function Celest:Search(prefill) if self.shell then self:_openSearch(prefill) end end

function Celest:Destroy()
	if self.shell then
		self.shell.gui:Destroy()
		self.shell = nil
	end
	if win == self then win = nil end
end

---------------------------------------------------------------- 构建 GUI
function Celest:_build()
	if self.shell then
		self.shell.gui:Destroy()
		self.shell = nil
	end
	if #self.cats == 0 then return end

	local cfg = self.cfg

	-- 几何：按「单类功能数」决定最多几环
	local maxSegs = 1
	for _, c in ipairs(self.cats) do
		maxSegs = math.max(maxSegs, math.ceil(#c.items / PER_RING))
	end
	local R_OUT = R_FIRST + (maxSegs - 1) * STEP_R
	local REF   = math.ceil((R_OUT + 80) * 2 / 10) * 10

	local gui = mk("ScreenGui", {
		Name = "CelestUI", ResetOnSpawn = false, IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 9999,
	})
	local ok = pcall(function() gui.Parent = game:GetService("CoreGui") end)
	if not ok or not gui.Parent then gui.Parent = LP:WaitForChild("PlayerGui") end

	local root = mk("Frame", {
		Parent = gui, Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = T.void, BackgroundTransparency = 1, BorderSizePixel = 0,
	})

	-- 星云
	local neb = mk("Frame", { Parent = root, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false, ZIndex = 1 })
	local b1, b2, b3 = blob(neb, 900, T.nebA, .93), blob(neb, 780, T.nebB, .94), blob(neb, 840, T.nebC, .945)
	b1.Position = UDim2.fromScale(.28, .30)
	b2.Position = UDim2.fromScale(.76, .38)
	b3.Position = UDim2.fromScale(.52, .82)
	local function drift(o, dx, dy, t)
		local a = tw(o, t, { Position = o.Position + UDim2.fromScale(dx, dy) }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
		if not a then return end
		a.Completed:Connect(function() if o.Parent then drift(o, -dx, -dy, t) end end)
	end
	drift(b1, .05, .03, 48); drift(b2, -.06, .04, 60); drift(b3, -.04, -.05, 70)

	-- 星场
	local field = mk("Frame", { Parent = root, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false, ZIndex = 2 })
	do
		local count = TOUCH and 70 or 140
		for _ = 1, count do
			local sz = (math.random() < 88 and 1 or 2) + (math.random() < 12 and 1 or 0)
			local s = mk("Frame", {
				Parent = field, Size = UDim2.fromOffset(sz, sz),
				Position = UDim2.fromScale(math.random(), math.random()),
				BackgroundColor3 = T.star,
				BackgroundTransparency = .35 + math.random() * .5,
				BorderSizePixel = 0,
			})
			round(s, 1)
			if math.random() < .42 then
				task.spawn(function()
					task.wait(math.random() * 5)
					while s.Parent do
						local d = .6 + math.random() * .8
						tw(s, d, { BackgroundTransparency = .85 }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
						task.wait(d)
						tw(s, d, { BackgroundTransparency = .25 }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
						task.wait(d)
					end
				end)
			end
		end
	end

	local blank = mk("TextButton", {
		Parent = root, Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1, Text = "", AutoButtonColor = false, Visible = false, ZIndex = 3,
	})
	local veil = mk("Frame", {
		Parent = root, Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = T.void, BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 9,
	})

	-- 星图
	local map = mk("Frame", {
		Name = "CelestMap",
		Parent = root, Size = UDim2.fromOffset(REF, REF),
		Position = UDim2.fromScale(.5, .5), AnchorPoint = Vector2.new(.5, .5),
		BackgroundTransparency = 1, Visible = false, ZIndex = 10,
	})
	local mapScale  = mk("UIScale", { Parent = map, Scale = 1 })
	local baseScale = 1

	local ringLayer = mk("Frame", { Parent = map, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 1 })
	local rg = ring(R_IN * 2, T.line, .90); rg.Parent = ringLayer
	local ticks = mk("Frame", { Parent = ringLayer, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1 })
	for i = 0, 71 do
		local deg  = i / 72 * 360
		local long = (i % 6 == 0)
		local t = mk("Frame", {
			Parent = ticks, Size = UDim2.fromOffset(1, long and 12 or 7),
			BackgroundColor3 = T.line, BackgroundTransparency = long and .55 or .82,
			BorderSizePixel = 0, AnchorPoint = Vector2.new(.5, 0),
		})
		t.Position = UDim2.new(.5, math.cos(math.rad(deg)) * (R_OUT + 2), .5, math.sin(math.rad(deg)) * (R_OUT + 2))
		t.Rotation = deg + 90
	end

	local core = mk("Frame", {
		Parent = map, Size = UDim2.fromOffset(0, 0),
		Position = UDim2.fromScale(.5, .5), AnchorPoint = Vector2.new(.5, .5),
		BackgroundTransparency = 1, ZIndex = 3,
	})
	blob(core, 130, T.accent2, .90)
	local coreSpin = ring(66, T.accent, .78); coreSpin.Parent = core
	local coreDot = circle(core, 8, T.star, 0); coreDot.ZIndex = 4
	task.spawn(function()
		while coreDot.Parent do
			tw(coreDot, 2.6, { Size = UDim2.fromOffset(11, 11) }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut); task.wait(2.6)
			tw(coreDot, 2.6, { Size = UDim2.fromOffset(7, 7) }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);  task.wait(2.6)
		end
	end)
	task.spawn(function()
		while coreSpin.Parent do
			coreSpin.Rotation = 0
			tw(coreSpin, 22, { Rotation = 360 }, Enum.EasingStyle.Linear)
			task.wait(22)
		end
	end)

	local outerLayer = mk("Frame", { Parent = map, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 4 })
	local catLayer   = mk("Frame", { Parent = map, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 7 })

	---------------------------------------------------------------- 星点视觉
	local function paintDot(dot, on, sel)
		if sel then
			dot.BackgroundColor3 = T.star;   dot.BackgroundTransparency = 0
			local s = dot:FindFirstChildOfClass("UIStroke"); if s then s.Transparency = 0 end
		elseif on then
			dot.BackgroundColor3 = T.accent; dot.BackgroundTransparency = 0
			local s = dot:FindFirstChildOfClass("UIStroke"); if s then s.Transparency = 0 end
		else
			dot.BackgroundColor3 = T.star;   dot.BackgroundTransparency = 1
			local s = dot:FindFirstChildOfClass("UIStroke"); if s then s.Transparency = .35 end
		end
	end

	local function clearSelection()
		if self.selected then
			paintDot(self.selected.dot, false, false)
			self.selected = nil
		end
	end

	---------------------------------------------------------------- 拖动
	local dragConn = nil
	local function endDrag()
		if dragConn then dragConn:Disconnect(); dragConn = nil end
		if self.dragging and self.dragCtx and not self.dragMoved and self.dragCtx.canToggle then
			local c = self.dragCtx
			if self.selected and self.selected.node == c.node then
				paintDot(c.dot, false, false); self.selected = nil
			else
				if self.selected then paintDot(self.selected.dot, false, false) end
				self.selected = { star = c.star, node = c.node, dot = c.dot }
				paintDot(c.dot, false, true)
			end
		end
		self.dragging, self.dragMoved, self.dragCtx = false, false, nil
	end

	local function beginDrag(node, item, dot, setT)
		local wasSel = (self.selected ~= nil and self.selected.node == node)
		self.dragging, self.dragMoved = true, false
		self.dragCtx = { node = node, star = item, dot = dot, setT = setT, canToggle = wasSel }
		if not wasSel then
			if self.selected then paintDot(self.selected.dot, false, false) end
			self.selected = { star = item, node = node, dot = dot }
			paintDot(dot, false, true)
		end
		if dragConn then dragConn:Disconnect(); dragConn = nil end
		if not TOUCH then
			local baseX, baseV = UIS:GetMouseLocation().X, item.value
			local span = (item.max - item.min)
			dragConn = RunService.RenderStepped:Connect(function()
				local dx = UIS:GetMouseLocation().X - baseX
				if math.abs(dx) < .5 then return end
				self.dragMoved = true
				setT(baseV + dx / 420 * span * 0.9)
			end)
		end
	end

	---------------------------------------------------------------- 下拉框弹层
	local ddPopup = nil
	local function closeDropdown()
		if ddPopup then ddPopup:Destroy(); ddPopup = nil end
	end
	local function openDropdown(item, ox, oy)
		closeDropdown()
		local vp    = vpSize()
		local scale = mapScale.Scale or 1
		local cx    = vp.X / 2 + ox * scale
		local cy    = vp.Y / 2 + oy * scale
		local n     = math.max(1, #item.options)
		local w, rowH, pad = 156, 28, 6
		local h  = n * rowH + pad * 2
		local px = math.clamp(cx - w / 2, 8, math.max(8, vp.X - w - 8))
		local py = math.clamp(cy + 24, 8, math.max(8, vp.Y - h - 8))
		local box = mk("Frame", {
			Parent = root, Size = UDim2.fromOffset(w, h), Position = UDim2.fromOffset(px, py),
			BackgroundColor3 = T.panel, BackgroundTransparency = .1, BorderSizePixel = 0, ZIndex = 60,
		})
		round(box, 0); stroke(box, T.line, 1, .5)
		mk("UIListLayout", { Parent = box, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 0) })
		mk("UIPadding", { Parent = box, PaddingTop = UDim.new(0, pad), PaddingBottom = UDim.new(0, pad) })
		for i, opt in ipairs(item.options) do
			local txt = tostring(opt)
			local on  = (opt == item.value)
			local b = mk("TextButton", {
				Parent = box, Size = UDim2.new(1, 0, 0, rowH), LayoutOrder = i,
				BackgroundTransparency = 1, AutoButtonColor = false, Text = "", ZIndex = 61,
			})
			-- 横向排布：竖线标记 + 文字，由布局器分配间距，绝不重叠
			mk("UIListLayout", {
				Parent = b, FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8),
			})
			mk("UIPadding", { Parent = b, PaddingLeft = UDim.new(0, 10) })
			local mark = mk("Frame", {
				Parent = b, Size = UDim2.fromOffset(3, 12), LayoutOrder = 1,
				BackgroundColor3 = T.accent, BackgroundTransparency = on and .05 or 1,
				BorderSizePixel = 0, ZIndex = 61,
			})
			round(mark, 1)
			local label = mk("TextLabel", {
				Parent = b, Size = UDim2.fromOffset(w - 21, rowH), LayoutOrder = 2,
				BackgroundTransparency = 1,
				Font = Enum.Font.Gotham, TextSize = 13, Text = txt,
				TextColor3 = on and T.star or T.dim, TextTransparency = on and .02 or .34,
				TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 61,
			})
			b.MouseEnter:Connect(function() tw(label, .12, { TextColor3 = T.star, TextTransparency = .03 }) end)
			b.MouseLeave:Connect(function()
				if opt ~= item.value then tw(label, .12, { TextColor3 = T.dim, TextTransparency = .34 }) end
			end)
			b.MouseButton1Click:Connect(function()
				item.value = opt
				if item._ui and item._ui.val then item._ui.val.Text = txt end
				if item.cb then task.spawn(item.cb, opt) end
				closeDropdown()
			end)
		end
		ddPopup = box
	end

	---------------------------------------------------------------- 功能星
	local function makeStar(cat, ci, item, r, deg)
		local node = mk("Frame", { Parent = outerLayer, Size = UDim2.fromOffset(114, 88), BackgroundTransparency = 1, ZIndex = 6 })
		placeOn(node, r, deg)

		local btn = mk("TextButton", {
			Name = "CelestStar",
			Parent = node, Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1, Text = "", AutoButtonColor = false, ZIndex = 6,
		})
		local dot = circle(node, 9, T.star, 1); dot.ZIndex = 6
		paintDot(dot, (item.kind == "toggle" and item.value) or (item.kind == "slider" and item.on) or false, false)

		local label = mk("TextLabel", {
			Parent = node, BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 16), Position = UDim2.new(.5, 0, .5, 10), AnchorPoint = Vector2.new(.5, 0),
			Font = Enum.Font.Gotham, TextSize = 12,
			TextColor3 = T.dim, TextTransparency = .62, Text = item.name, ZIndex = 6,
		})

		local val, setT = nil, nil
		if item.kind == "slider" then
			local span = (item.max - item.min)
			local function norm() return (item.value - item.min) / span end
			val = mk("TextLabel", {
				Parent = node, BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 12), Position = UDim2.new(.5, 0, .5, 26), AnchorPoint = Vector2.new(.5, 0),
				Font = Enum.Font.Gotham, TextSize = 10,
				TextColor3 = T.dim, TextTransparency = .7,
				Text = tostring(math.floor(item.value)), ZIndex = 6,
			})
			local track = mk("Frame", {
				Parent = node, Size = UDim2.fromOffset(58, 3),
				Position = UDim2.new(.5, 0, .5, 40), AnchorPoint = Vector2.new(.5, 0),
				BackgroundColor3 = T.dim, BackgroundTransparency = .72, BorderSizePixel = 0, ZIndex = 6,
			})
			round(track, 1)
			local fill = mk("Frame", {
				Parent = track, Size = UDim2.fromScale(norm(), 1),
				BackgroundColor3 = T.accent, BackgroundTransparency = .05, BorderSizePixel = 0, ZIndex = 7,
			})
			round(fill, 1)
			setT = function(v)
				v = math.clamp(v, item.min, item.max)
				item.value = v
				val.Text = tostring(math.floor(v))
				fill.Size = UDim2.fromScale(norm(), 1)
				if item.cb then task.spawn(item.cb, v) end
			end
		elseif item.kind == "dropdown" then
			val = mk("TextLabel", {
				Parent = node, BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 12), Position = UDim2.new(.5, 0, .5, 26), AnchorPoint = Vector2.new(.5, 0),
				Font = Enum.Font.Gotham, TextSize = 10,
				TextColor3 = T.accent, TextTransparency = .18,
				Text = tostring(item.value), ZIndex = 6,
			})
			-- 小箭头，提示可展开
			local chv = mk("Frame", {
				Parent = node, Size = UDim2.fromOffset(12, 12),
				Position = UDim2.new(.5, 0, .5, 42), AnchorPoint = Vector2.new(.5, .5),
				BackgroundTransparency = 1, ZIndex = 6,
			})
			bar(chv, 2, 5, T.accent, -2, -1, 40, 1)
			bar(chv, 2, 5, T.accent, 2, -1, -40, 1)
		elseif item.kind == "button" then
			-- 一次性动作星：用箭头图标区分于开关星
			local ic = select(1, drawIcon("run", node, T.accent, 14))
			if ic then ic.Position = UDim2.new(.5, 0, .5, 32) end
		end
		local ox, oy = math.cos(math.rad(deg)) * r, math.sin(math.rad(deg)) * r
		item._ui = { node = node, dot = dot, label = label, val = val, setT = setT, ox = ox, oy = oy }

		local function ripple(bright)
			local rr = circle(node, 9, bright and T.star or T.accent, 1)
			stroke(rr, bright and T.star or T.accent, 1, .2); rr.ZIndex = 5
			tw(rr, .9, { Size = UDim2.fromOffset(84, 84) }, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			local s = rr:FindFirstChildOfClass("UIStroke")
			if s then tw(s, .9, { Transparency = 1 }) end
			task.delay(.95, function() if rr.Parent then rr:Destroy() end end)
		end

		local function focus(on)
			tw(label, .22, { TextColor3 = on and T.star or T.dim, TextTransparency = on and .04 or .62 })
			tw(dot, .22, { Size = UDim2.fromOffset(on and 12 or 9, on and 12 or 9) })
		end
		btn.MouseEnter:Connect(function() focus(true) end)
		btn.MouseLeave:Connect(function() focus(false) end)

		if item.kind == "slider" then
			btn.MouseButton1Down:Connect(function() beginDrag(node, item, dot, setT) end)
		end
		btn.MouseButton1Click:Connect(function()
			if item.kind == "toggle" then
				item.value = not item.value
				paintDot(dot, item.value, false)
				ripple(item.value)
				self:_refreshTrail()
				if item.cb then task.spawn(item.cb, item.value) end
			elseif item.kind == "button" then
				ripple(true)
				if item.cb then task.spawn(item.cb) end
			elseif item.kind == "dropdown" then
				ripple(false)
				openDropdown(item, ox, oy)
			elseif item.kind == "slider" then
				-- 单击（未拖动）→ 像开关一样切换启用 / 停用；拖动仍由 setT 调值
				if not self.dragMoved then
					item.on = not item.on
					paintDot(dot, item.on, false)
					ripple(item.on)
					self:_refreshTrail()
					if item.onCb then task.spawn(item.onCb, item.on) end
				end
			end
		end)
		return node
	end

	---------------------------------------------------------------- 内环 · 分类星点
	local catNodes = {}
	local function paintCats()
		for i, c in ipairs(catNodes) do
			local on = (i == self.active)
			tw(c.btn, .24, {
				TextColor3 = on and T.star or T.dim,
				TextTransparency = on and 0 or .42,
				BackgroundTransparency = on and .12 or .55,
			})
			tw(c.st, .24, { Transparency = on and .22 or .72 })
			tw(c.name, .24, { TextTransparency = on and .04 or .9 })
			tw(c.dot, .24, { Size = UDim2.fromOffset(on and 10 or 6, on and 10 or 6) })
			if c.iconParts then
				for _, p in ipairs(c.iconParts) do
					if p:IsA("UIStroke") then tw(p, .24, { Color = on and T.star or T.dim })
					else tw(p, .24, { BackgroundColor3 = on and T.star or T.dim }) end
				end
			end
		end
	end
	self._paintCats = paintCats

	local function buildCats()
		for i, c in ipairs(self.cats) do
			local node = mk("Frame", { Parent = catLayer, Size = UDim2.fromOffset(56, 56), BackgroundTransparency = 1, ZIndex = 7 })
			placeOn(node, R_IN, -90 + (i - 1) * (360 / #self.cats))

			local useIcon = ICONS[c.glyph]
			local btn = mk("TextButton", {
				Name = "CelestCategory",
				Parent = node, Size = UDim2.fromScale(1, 1),
				BackgroundColor3 = T.panel, BackgroundTransparency = .5,
				Text = useIcon and "" or tostring(c.glyph or "✦"),
				Font = Enum.Font.Gotham, TextSize = 16,
				TextColor3 = T.dim, TextTransparency = .42, AutoButtonColor = false, ZIndex = 7,
			})
			round(btn, 1)
			local st  = stroke(btn, T.line, 1, .72)
			local iconParts = nil
			if useIcon then _, iconParts = drawIcon(c.glyph, btn, T.dim, 26) end
			local dot = circle(node, 6, T.accent, 1)
			dot.Position = UDim2.new(.5, 0, 1, -2); dot.ZIndex = 8
			local name = mk("TextLabel", {
				Parent = node, BackgroundTransparency = 1,
				Size = UDim2.fromOffset(130, 16), Position = UDim2.new(.5, 0, 0, -18), AnchorPoint = Vector2.new(.5, 1),
				Font = Enum.Font.Gotham, TextSize = 13,
				TextColor3 = T.dim, TextTransparency = .9, Text = c.name, ZIndex = 8,
			})
			btn.MouseEnter:Connect(function() tw(name, .2, { TextTransparency = .18 }) end)
			btn.MouseButton1Click:Connect(function()
				if self.active == i then return end
				self.active = i
				clearSelection()
				paintCats()
				self:_renderOuter()
			end)
			catNodes[i] = { btn = btn, st = st, name = name, dot = dot, iconParts = iconParts }
		end
		paintCats()
	end
	self._paintCatPoints = paintCats

	---------------------------------------------------------------- 外环 · 当前分类的功能星
	local function renderOuter()
		for _, ch in ipairs(outerLayer:GetChildren()) do
			if ch:IsA("GuiObject") then ch:Destroy() end
		end
		local cat  = self.cats[self.active]
		if not cat then return end
		local n    = #cat.items
		local segs = math.max(1, math.ceil(n / PER_RING))
		for s = 1, segs do
			local r = R_FIRST + (s - 1) * STEP_R
			local rr = ring(r * 2, T.line, .90); rr.Parent = outerLayer
			local seg = {}
			for k = (s - 1) * PER_RING + 1, math.min(s * PER_RING, n) do seg[#seg + 1] = cat.items[k] end
			local m, step = #seg, 360 / math.max(1, #seg)
			for j, it in ipairs(seg) do
				makeStar(cat, self.active, it, r, -90 + step / 2 + (j - 1) * step)
			end
		end
	end
	self._renderOuter = renderOuter

	---------------------------------------------------------------- 星痕（右上，仅开环时出现）
	local trailBox = mk("Frame", {
		Parent = root, Size = UDim2.fromOffset(160, 22),
		Position = UDim2.new(1, -34, 0, 30), AnchorPoint = Vector2.new(1, 0),
		BackgroundTransparency = 1, Visible = false, ZIndex = 20,
	})
	local trailRow = mk("Frame", { Parent = trailBox, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1 })
	mk("UIListLayout", {
		Parent = trailRow, FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Right,
		VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 9),
	})
	local trailTip = mk("TextLabel", {
		Parent = trailBox, Size = UDim2.fromOffset(420, 30),
		Position = UDim2.new(1, 0, 0, 30), AnchorPoint = Vector2.new(1, 0),
		BackgroundColor3 = T.panel, BackgroundTransparency = 1,
		Font = Enum.Font.Gotham, TextSize = 12,
		TextColor3 = T.dim, TextTransparency = 1, Text = "", ZIndex = 21,
	})
	round(trailTip, 0); stroke(trailTip, T.line, 1, 1)

	function self:_refreshTrail()
		for _, c in ipairs(trailRow:GetChildren()) do
			if c:IsA("Frame") then c:Destroy() end
		end
		local names = {}
		for _, cat in ipairs(self.cats) do
			for _, it in ipairs(cat.items) do
				if it.kind == "toggle" and it.value then names[#names + 1] = it.name end
			end
		end
		for i = 1, math.min(#names, 6) do
			local d = circle(trailRow, 6, T.accent, .12); d.LayoutOrder = i
			task.spawn(function()
				while d.Parent do
					tw(d, 1.7, { BackgroundTransparency = .55, Size = UDim2.fromOffset(5, 5) }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut); task.wait(1.7)
					tw(d, 1.7, { BackgroundTransparency = .08, Size = UDim2.fromOffset(7, 7) }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut); task.wait(1.7)
				end
			end)
		end
		trailTip.Text = #names > 0 and table.concat(names, " · ") or "无星亮起"
	end

	local function tipShow(on)
		tw(trailTip, .2, { TextTransparency = on and .05 or 1, BackgroundTransparency = on and .35 or 1 })
		local s = trailTip:FindFirstChildOfClass("UIStroke")
		if s then tw(s, .2, { Transparency = on and .72 or 1 }) end
	end
	trailBox.MouseEnter:Connect(function() if trailTip.Text ~= "无星亮起" then tipShow(true) end end)
	trailBox.MouseLeave:Connect(function() tipShow(false) end)

	---------------------------------------------------------------- 常驻星点（召唤）
	local sigil = mk("TextButton", {
		Parent = root, Size = UDim2.fromOffset(44, 44),
		Position = UDim2.new(1, -30, 1, -30), AnchorPoint = Vector2.new(1, 1),
		BackgroundTransparency = 1, Text = "", AutoButtonColor = false, ZIndex = 30,
	})
	do
		local rr = ring(30, T.line, .72); rr.Parent = sigil
		local d = circle(sigil, 7, T.accent, .1)
		task.spawn(function()
			while d.Parent do
				tw(d, 2.2, { BackgroundTransparency = .45, Size = UDim2.fromOffset(5, 5) }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut); task.wait(2.2)
				tw(d, 2.2, { BackgroundTransparency = .05, Size = UDim2.fromOffset(8, 8) }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut); task.wait(2.2)
			end
		end)
	end

	---------------------------------------------------------------- 低语面板（搜索全部功能）
	local whisper = mk("Frame", {
		Parent = root, Size = UDim2.fromOffset(580, 300),
		Position = UDim2.new(.5, 0, 1, -26), AnchorPoint = Vector2.new(.5, 1),
		BackgroundTransparency = 1, Visible = false, ZIndex = 40,
	})
	local wbox = mk("Frame", {
		Parent = whisper, Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = T.panel, BackgroundTransparency = .16, BorderSizePixel = 0, ZIndex = 40,
	})
	round(wbox, 0); stroke(wbox, T.line, 1, .55)
	mk("UIPadding", {
		Parent = wbox, PaddingTop = UDim.new(0, 12), PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 16),
	})

	-- 搜索入口图标
	local wIcon = mk("Frame", {
		Parent = wbox, Size = UDim2.fromOffset(18, 18),
		Position = UDim2.new(0, 0, 0, 6), BackgroundTransparency = 1, ZIndex = 41,
	})
	drawIcon("search", wIcon, T.dim, 18)

	local wi = mk("TextBox", {
		Parent = wbox, Size = UDim2.new(1, -28, 0, 30), Position = UDim2.new(0, 28, 0, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.Gotham, TextSize = 15, TextColor3 = T.star, TextTransparency = .05,
		PlaceholderText = "低语一个名字…", PlaceholderColor3 = T.dim,
		Text = "", ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 41,
	})
	mk("Frame", {
		Parent = wbox, Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 0, 36),
		BackgroundColor3 = T.line, BackgroundTransparency = .68, BorderSizePixel = 0, ZIndex = 41,
	})

	-- 结果列表（可滚动，键盘上下选择）
	local wres = mk("ScrollingFrame", {
		Parent = wbox, Size = UDim2.new(1, 0, 1, -70), Position = UDim2.new(0, 0, 0, 44),
		BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 41,
		ScrollBarThickness = 3, ScrollBarImageColor3 = T.line, ScrollBarImageTransparency = .4,
		CanvasSize = UDim2.new(0, 0, 0, 0),
	})
	mk("UIListLayout", { Parent = wres, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 2) })
	local emptyLbl = mk("TextLabel", {
		Parent = wres, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 40), LayoutOrder = 0,
		Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = T.dim, TextTransparency = .72,
		Text = "虚空无应…", TextXAlignment = Enum.TextXAlignment.Left,
	})
	mk("TextLabel", {
		Parent = wbox, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 16),
		Position = UDim2.new(0, 0, 1, -18), AnchorPoint = Vector2.new(0, 1),
		Font = Enum.Font.Gotham, TextSize = 10, TextColor3 = T.dim, TextTransparency = .5,
		Text = "↑ ↓ 选择 · Enter 执行 · Esc 关闭", TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 42,
	})

	local wRows, wButtons, wSel = {}, {}, 1
	local renderRes, activate, closeWhisper, wMove, wRun

	local function kindState(it)
		if it.kind == "toggle" then return it.value and "已亮" or "已灭"
		elseif it.kind == "slider" then return tostring(math.floor(it.value)) .. " / " .. tostring(it.max)
		elseif it.kind == "dropdown" then return tostring(it.value)
		elseif it.kind == "button" then return "点击执行" end
		return ""
	end
	local function kindIcon(it)
		if it.kind == "slider" then return "wave"
		elseif it.kind == "dropdown" then return "list"
		elseif it.kind == "button" then return "run" end
		return "dot"
	end

	local function highlight()
		for i, b in ipairs(wButtons) do
			local on = (i == wSel)
			tw(b.btn, .12, { BackgroundTransparency = on and .86 or 1 })
			tw(b.name, .12, { TextColor3 = on and T.star or T.dim, TextTransparency = on and .04 or .4 })
			tw(b.state, .12, { TextTransparency = on and .08 or .5 })
		end
	end

	local function scrollTo(i)
		local rowH = 32
		local view = 180
		local av = wres.AbsoluteWindowSize
		if av then view = av.Y end
		local y = math.clamp((i - 1) * rowH - view / 2 + rowH / 2, 0, math.max(0, #wRows * rowH - view))
		wres.CanvasPosition = Vector2.new(0, y)
	end

	closeWhisper = function()
		whisper.Visible = false
		wi.Text = ""
		wi:ReleaseFocus()
	end

	renderRes = function(keepSel)
		for _, c in ipairs(wres:GetChildren()) do
			if c:IsA("TextButton") then c:Destroy() end
		end
		wRows, wButtons = {}, {}
		local q = wi.Text
		for ci, cat in ipairs(self.cats) do
			for _, it in ipairs(cat.items) do
				if q == "" or string.find(it.name, q, 1, true) or string.find(cat.name, q, 1, true) then
					wRows[#wRows + 1] = { ci = ci, it = it, cat = cat }
				end
			end
		end
		emptyLbl.Visible = (#wRows == 0)
		for i, r in ipairs(wRows) do
			local it = r.it
			local b = mk("TextButton", {
				Parent = wres, Size = UDim2.new(1, 0, 0, 30), LayoutOrder = i,
				BackgroundColor3 = T.accent, BackgroundTransparency = 1, AutoButtonColor = false,
				Text = "", ZIndex = 42,
			})
			round(b, 1)
			local ic = mk("Frame", {
				Parent = b, Size = UDim2.fromOffset(16, 16),
				Position = UDim2.new(0, 10, .5, 0), AnchorPoint = Vector2.new(0, .5),
				BackgroundTransparency = 1, ZIndex = 43,
			})
			drawIcon(kindIcon(it), ic, T.accent, 16)
			local nameLbl = mk("TextLabel", {
				Parent = b, BackgroundTransparency = 1, Size = UDim2.new(1, -190, 1, 0),
				Position = UDim2.new(0, 34, 0, 0), Font = Enum.Font.Gotham, TextSize = 13,
				TextColor3 = T.dim, TextTransparency = .4, Text = it.name,
				TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 43,
			})
			local stateLbl = mk("TextLabel", {
				Parent = b, BackgroundTransparency = 1, Size = UDim2.new(1, -190, 1, 0),
				Position = UDim2.new(0, 34, 0, 0), Font = Enum.Font.Gotham, TextSize = 12,
				TextColor3 = T.accent, TextTransparency = .5,
				Text = tostring(r.cat.name) .. "  ·  " .. kindState(it),
				TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 43,
			})
			wButtons[i] = { btn = b, name = nameLbl, state = stateLbl }
			b.MouseEnter:Connect(function() wSel = i; highlight() end)
			b.MouseButton1Click:Connect(function() wSel = i; activate(r) end)
		end
		wres.CanvasSize = UDim2.new(0, 0, 0, math.max(1, #wRows) * 32)
		if keepSel then wSel = math.clamp(wSel, 1, math.max(1, #wRows)) else wSel = 1 end
		highlight()
	end

	activate = function(r)
		local it, ci = r.it, r.ci
		if ci ~= self.active then
			self.active = ci
			self._paintCatPoints()
			self._renderOuter()
		end
		if it.kind == "toggle" then
			it.value = not it.value
			if it._ui then paintDot(it._ui.dot, it.value, false) end
			self:_refreshTrail()
			if it.cb then task.spawn(it.cb, it.value) end
			renderRes(true)                      -- 就地刷新状态，面板保持打开
		elseif it.kind == "button" then
			if it.cb then task.spawn(it.cb) end
		elseif it.kind == "dropdown" then
			if self._open then self._open() end
			closeWhisper()
			if it._ui and it._ui.ox then
				task.defer(function() openDropdown(it, it._ui.ox, it._ui.oy) end)
			end
		elseif it.kind == "slider" then
			if self._open then self._open() end
			closeWhisper()
			if it._ui and it._ui.node then
				if self.selected then paintDot(self.selected.dot, false, false) end
				self.selected = { star = it, node = it._ui.node, dot = it._ui.dot }
				paintDot(it._ui.dot, false, true)
			end
		end
	end

	wMove = function(dy)
		if #wRows == 0 then return end
		wSel = math.clamp(wSel + dy, 1, #wRows)
		highlight(); scrollTo(wSel)
	end
	wRun = function()
		if wRows[wSel] then activate(wRows[wSel]) end
	end

	function self:_openSearch(prefill)
		if self._open then self._open() end
		whisper.Visible = true
		wi.Text = prefill or ""
		renderRes(false)
		wi:CaptureFocus()
	end
	wi:GetPropertyChangedSignal("Text"):Connect(function() renderRes(false) end)

	---------------------------------------------------------------- 品牌 & 提示（仅开环时可见）
	local brand = mk("Frame", { Name = "CelestBrand", Parent = root, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false, ZIndex = 20 })
	mk("TextLabel", {
		Parent = brand, BackgroundTransparency = 1,
		Size = UDim2.fromOffset(300, 30), Position = UDim2.new(0, 34, 0, 26),
		Font = Enum.Font.GothamMedium, TextSize = 22, TextColor3 = T.star, TextTransparency = .1,
		Text = cfg.title or "星 穹", TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 20,
	})
	mk("TextLabel", {
		Parent = brand, BackgroundTransparency = 1,
		Size = UDim2.fromOffset(320, 16), Position = UDim2.new(0, 36, 0, 54),
		Font = Enum.Font.Gotham, TextSize = 10, TextColor3 = T.dim, TextTransparency = .58,
		Text = cfg.subtitle or "C E L E S T", TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 20,
	})
	local hintLbl = mk("TextLabel", {
		Parent = brand, BackgroundTransparency = 1,
		Size = UDim2.fromOffset(520, 40), Position = UDim2.new(0, 30, 1, -58), AnchorPoint = Vector2.new(0, 1),
		Font = Enum.Font.Gotham, TextSize = 11, TextColor3 = T.dim, TextTransparency = .62,
		Text = cfg.hint or (TOUCH
			and "点右下星点呼出 · 再点归寂\n点星点亮灭 · 数值星拖动调值 · 下拉星选择"
			or  "按 ALT 呼出 / 再按归寂\n点星点亮灭 · 数值星拖动调值 · 下拉星选择 · CTRL+K 低语"),
		TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 20,
	})
	-- 搜索入口（仅开环时出现）
	local searchBtn = mk("TextButton", {
		Parent = brand, Size = UDim2.fromOffset(92, 26),
		Position = UDim2.new(0, 34, 0, 82),
		BackgroundColor3 = T.panel, BackgroundTransparency = .5,
		Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = T.dim, TextTransparency = .3,
		Text = "低语", TextXAlignment = Enum.TextXAlignment.Left,
		AutoButtonColor = false, ZIndex = 20,
	})
	round(searchBtn, 1); stroke(searchBtn, T.line, 1, .7)
	local sIcon = mk("Frame", {
		Parent = searchBtn, Size = UDim2.fromOffset(13, 13),
		Position = UDim2.new(0, 11, .5, 0), AnchorPoint = Vector2.new(0, .5),
		BackgroundTransparency = 1, ZIndex = 21,
	})
	drawIcon("search", sIcon, T.dim, 13)
	mk("UIPadding", { Parent = searchBtn, PaddingLeft = UDim.new(0, 30) })
	searchBtn.MouseButton1Click:Connect(function() self:_openSearch() end)

	---------------------------------------------------------------- 开 / 关
	local function resize()
		local vp = Vector2.new(1280, 720)
		local cam = workspace.CurrentCamera
		if cam then vp = cam.ViewportSize end
		baseScale = math.clamp(math.min(vp.X, vp.Y) / REF * (TOUCH and 1.0 or .98), .3, 1.2)
		mapScale.Scale = baseScale
	end
	resize()
	if workspace.CurrentCamera then
		workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(resize)
	end

	local function open()
		if self.mapOpen then return end
		self.mapOpen = true
		self.pinned  = true
		blank.Visible, field.Visible, neb.Visible = true, true, true
		brand.Visible  = true
		trailBox.Visible = true
		map.Visible = true
		mapScale.Scale = baseScale * .9
		tw(mapScale, .38, { Scale = baseScale })
		tw(veil, .42, { BackgroundTransparency = .18 })
		self:_refreshTrail()
	end
	local function close()
		if not self.mapOpen then return end
		self.mapOpen = false
		self.pinned  = false
		endDrag(); clearSelection(); closeDropdown()
		if whisper.Visible then closeWhisper() end
		tw(veil, .34, { BackgroundTransparency = 1 })
		brand.Visible = false      -- 关环后不再显示任何常驻文字
		trailBox.Visible = false
		local function hide()
			if self.mapOpen then return end
			map.Visible = false
			blank.Visible = false  -- 关环后不再全屏拦截点击
			field.Visible = false
			neb.Visible = false
		end
		local a = tw(mapScale, .32, { Scale = baseScale * .9 })
		if a then a.Completed:Connect(hide) else hide() end
	end
	self._open, self._close = open, close

	local function toggleMap()
		if self.mapOpen then close() else open() end
	end

	sigil.MouseButton1Click:Connect(toggleMap)
	-- 点空白只取消选中 / 收起下拉，绝不关闭星图（避免误触丢状态）
	blank.MouseButton1Click:Connect(function()
		if ddPopup then closeDropdown(); return end
		if self.selected then clearSelection() end
	end)

	---------------------------------------------------------------- 输入
	UIS.InputBegan:Connect(function(input)
		local k = input.KeyCode
		if whisper.Visible then
			-- 低语面板打开时，方向键 / 回车用于选择与执行
			if k == Enum.KeyCode.Up or k == Enum.KeyCode.W then wMove(-1); return end
			if k == Enum.KeyCode.Down or k == Enum.KeyCode.S then wMove(1); return end
			if k == Enum.KeyCode.Return or k == Enum.KeyCode.KeypadEnter then wRun(); return end
		end
		if k == Enum.KeyCode.LeftAlt or k == Enum.KeyCode.RightAlt then
			if not TOUCH then toggleMap() end     -- ALT 改为切换式：按一次开启，再按关闭
			return
		end
		if k == Enum.KeyCode.K and (UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.RightControl)) then
			if whisper.Visible then closeWhisper() else self:_openSearch() end
			return
		end
		if k == Enum.KeyCode.Escape then
			if whisper.Visible then closeWhisper()
			elseif ddPopup then closeDropdown()
			elseif self.mapOpen then close() end
			return
		end
	end)
	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			endDrag()
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if not TOUCH or not self.dragging or not self.dragCtx then return end
		if input.UserInputType == Enum.UserInputType.Touch then
			local dx = input.Delta.X
			if dx == 0 then return end
			self.dragMoved = true
			local c = self.dragCtx
			c.setT(c.star.value + dx / 420 * (c.star.max - c.star.min) * 0.9)
		end
	end)

	---------------------------------------------------------------- 入场：星辰汇聚
	local function gather()
		local box = mk("Frame", {
			Parent = root, Size = UDim2.fromOffset(REF, REF),
			Position = UDim2.fromScale(.5, .5), AnchorPoint = Vector2.new(.5, .5),
			BackgroundTransparency = 1, ZIndex = 8,
		})
		mk("UIScale", { Parent = box, Scale = mapScale.Scale })
		for _ = 1, 56 do
			local d = circle(box, 4, T.star, 1)
			local ang = math.random() * math.pi * 2
			local rr  = 180 + math.random() * (REF / 2 - 200)
			d.Position = UDim2.new(.5, math.cos(ang) * rr, .5, math.sin(ang) * rr)
			task.spawn(function()
				tw(d, .12, { BackgroundTransparency = 0 })
				task.wait(math.random() * .06)
				tw(d, .88, { Position = UDim2.new(.5, 0, .5, 0), Size = UDim2.fromOffset(2, 2), BackgroundTransparency = 1 },
					Enum.EasingStyle.Quart, Enum.EasingDirection.In)
				task.wait(.95)
				if d.Parent then d:Destroy() end
			end)
		end
		task.delay(1.05, function() if box.Parent then box:Destroy() end end)
	end

	self.shell = {
		gui = gui, root = root, map = map, mapScale = mapScale,
		veil = veil, blank = blank, field = field, neb = neb, brand = brand,
	}
	self.mapOpen, self.pinned = false, false

	buildCats()
	renderOuter()
	self:_refreshTrail()
	gather()
end

---------------------------------------------------------------- 入口
function Celest.new(cfg)
	win = newWindow(cfg)
	return win
end

Celest.Version = "1.3.0"
Celest.Icons   = ICONS          -- 内置矢量图标表：name -> 绘制函数
do
	local names = {}
	for k in pairs(ICONS) do names[#names + 1] = k end
	table.sort(names)
	Celest.IconNames = names     -- 可用图标名列表
end
return Celest