--[[
	星 穹 · C E L E S T   —— 无窗体星图 UI 库
	=================================================================
	不依赖任何 UI 库。内环星点选分类，外环出该分类的功能星；
	某类功能多则自动多开几环。电脑 + 手机通用。

	用法：
		local Celest = loadstring(game:HttpGet("https://raw.githubusercontent.com/LaPlua/Lua5.1/main/Celest.lua"))()
		local win = Celest.new({ title = "星穹", subtitle = "C E L E S T", hint = "按住 ALT 呼出 · 松手归寂" })

		local cat = win:Category("兵戈", "✦")
		cat:Toggle("自动瞄准", false, function(on) print(on) end)
		cat:Slider("视野半径", 0, 100, 50, function(v) print(v) end)
		cat:Button("执行一次", function() print("bang") end)

	操作：
		· 电脑：按住 ALT 呼出星图，松手归寂；CTRL + K 低语搜索
		· 手机：点右下角常驻星点呼出，再点归寂
		· 内环星点 = 选分类；点功能星 = 亮/灭；选中数值星后按住左右拖 = 调值
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

function Celest._Cat:Slider(name, min, max, default, cb)
	min, max = min or 0, max or 100
	local d = default or min
	return addItem(self, { kind = "slider", name = name, min = min, max = max, value = d, cb = cb })
end

function Celest._Cat:Button(name, cb)
	return addItem(self, { kind = "button", name = name, cb = cb })
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

	---------------------------------------------------------------- 功能星
	local function makeStar(cat, ci, item, r, deg)
		local node = mk("Frame", { Parent = outerLayer, Size = UDim2.fromOffset(114, 88), BackgroundTransparency = 1, ZIndex = 6 })
		placeOn(node, r, deg)

		local btn = mk("TextButton", {
			Parent = node, Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1, Text = "", AutoButtonColor = false, ZIndex = 6,
		})
		local dot = circle(node, 9, T.star, 1); dot.ZIndex = 6
		paintDot(dot, item.kind == "toggle" and item.value or false, false)

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
		end
		item._ui = { node = node, dot = dot, label = label, val = val, setT = setT }

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
		end
	end
	self._paintCats = paintCats

	local function buildCats()
		for i, c in ipairs(self.cats) do
			local node = mk("Frame", { Parent = catLayer, Size = UDim2.fromOffset(56, 56), BackgroundTransparency = 1, ZIndex = 7 })
			placeOn(node, R_IN, -90 + (i - 1) * (360 / #self.cats))

			local btn = mk("TextButton", {
				Parent = node, Size = UDim2.fromScale(1, 1),
				BackgroundColor3 = T.panel, BackgroundTransparency = .5,
				Text = c.glyph, Font = Enum.Font.Gotham, TextSize = 16,
				TextColor3 = T.dim, TextTransparency = .42, AutoButtonColor = false, ZIndex = 7,
			})
			round(btn, 1)
			local st  = stroke(btn, T.line, 1, .72)
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
			catNodes[i] = { btn = btn, st = st, name = name, dot = dot }
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

	---------------------------------------------------------------- 低语面板
	local whisper = mk("Frame", {
		Parent = root, Size = UDim2.fromOffset(520, 132),
		Position = UDim2.new(.5, 0, 1, -120), AnchorPoint = Vector2.new(.5, 1),
		BackgroundTransparency = 1, Visible = false, ZIndex = 40,
	})
	local wbox = mk("Frame", {
		Parent = whisper, Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = T.panel, BackgroundTransparency = .28, BorderSizePixel = 0, ZIndex = 40,
	})
	round(wbox, 0); stroke(wbox, T.line, 1, .62)
	mk("UIPadding", { Parent = wbox, PaddingTop = UDim.new(0, 14), PaddingLeft = UDim.new(0, 18), PaddingRight = UDim.new(0, 18) })
	local wi = mk("TextBox", {
		Parent = wbox, Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 1,
		Font = Enum.Font.Gotham, TextSize = 15, TextColor3 = T.star, TextTransparency = .05,
		PlaceholderText = "低语一个名字…", PlaceholderColor3 = T.dim,
		Text = "", ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 41,
	})
	local wres = mk("Frame", { Parent = wbox, Size = UDim2.new(1, 0, 0, 78), Position = UDim2.new(0, 0, 0, 40), BackgroundTransparency = 1, ZIndex = 41 })
	local emptyLbl = mk("TextLabel", {
		Parent = wres, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1),
		Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = T.dim, TextTransparency = .72,
		Text = "虚空无应…", TextXAlignment = Enum.TextXAlignment.Left,
	})

	local function closeWhisper() whisper.Visible = false; wi.Text = ""; wi:ReleaseFocus() end
	function self:_openSearch(prefill)
		whisper.Visible = true
		if prefill then wi.Text = prefill end
		wi:CaptureFocus()
	end

	local function renderRes()
		for _, c in ipairs(wres:GetChildren()) do
			if c:IsA("TextButton") then c:Destroy() end
		end
		local q = wi.Text
		local rows = {}
		for ci, cat in ipairs(self.cats) do
			for _, it in ipairs(cat.items) do
				if q == "" or string.find(it.name, q, 1, true) or string.find(cat.name, q, 1, true) then
					rows[#rows + 1] = { ci = ci, it = it, cat = cat.name }
				end
			end
		end
		emptyLbl.Visible = (#rows == 0)
		for i = 1, math.min(#rows, 3) do
			local r = rows[i]
			local b = mk("TextButton", {
				Parent = wres, Size = UDim2.new(1, 0, 0, 26), Position = UDim2.new(0, 0, 0, (i - 1) * 26),
				BackgroundTransparency = 1, AutoButtonColor = false,
				Font = Enum.Font.Gotham, TextSize = 13, TextColor3 = T.dim, TextTransparency = .35,
				Text = r.it.name .. "    " .. r.cat, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 42,
			})
			b.MouseEnter:Connect(function() tw(b, .15, { TextColor3 = T.star, TextTransparency = .05 }) end)
			b.MouseLeave:Connect(function() tw(b, .15, { TextColor3 = T.dim, TextTransparency = .35 }) end)
			b.MouseButton1Click:Connect(function()
				if r.ci ~= self.active then
					self.active = r.ci
					self._paintCatPoints()
					self._renderOuter()
				end
				local it = r.it
				if it.kind == "toggle" then
					it.value = not it.value
					if it._ui then paintDot(it._ui.dot, it.value, false) end
					self:_refreshTrail()
					if it.cb then task.spawn(it.cb, it.value) end
				elseif it.kind == "slider" then
					-- 切到该分类后即可看到，不重复触发回调
				elseif it.kind == "button" then
					if it.cb then task.spawn(it.cb) end
				end
				closeWhisper()
			end)
		end
	end
	wi:GetPropertyChangedSignal("Text"):Connect(renderRes)

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
			and "点右下星点呼出 · 再点归寂\n点星点亮灭 · 选中数值星后拖动调值"
			or  "按住 ALT 呼出 · 松手归寂\n点星点亮灭 · 选数值星后拖动调值 · CTRL+K 低语"),
		TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 20,
	})
	-- 搜索入口（仅开环时出现）
	local searchBtn = mk("TextButton", {
		Parent = brand, Size = UDim2.fromOffset(80, 24),
		Position = UDim2.new(0, 34, 0, 82),
		BackgroundColor3 = T.panel, BackgroundTransparency = .5,
		Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = T.dim, TextTransparency = .3,
		Text = "⌕ 低语", AutoButtonColor = false, ZIndex = 20,
	})
	round(searchBtn, 1); stroke(searchBtn, T.line, 1, .7)
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
		endDrag(); clearSelection()
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

	sigil.MouseButton1Click:Connect(function()
		if self.mapOpen then self.pinned = false; close()
		else self.pinned = true; open() end
	end)
	blank.MouseButton1Click:Connect(function()
		if self.selected then clearSelection(); return end
		if self.pinned then self.pinned = false; close() end
	end)

	---------------------------------------------------------------- 输入
	UIS.InputBegan:Connect(function(input)
		local k = input.KeyCode
		if k == Enum.KeyCode.LeftAlt or k == Enum.KeyCode.RightAlt then
			if not TOUCH then open() end
			return
		end
		if k == Enum.KeyCode.K and (UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.RightControl)) then
			if whisper.Visible then closeWhisper() else self:_openSearch() end
			return
		end
		if k == Enum.KeyCode.Escape then
			if whisper.Visible then closeWhisper()
			elseif self.pinned then self.pinned = false; close() end
			return
		end
	end)
	UIS.InputEnded:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
			if not self.pinned then close() end
		end
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

Celest.Version = "1.0.0"
return Celest