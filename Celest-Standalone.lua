--[[
    星 穹 · C E L E S T   —— 独立示例（不依赖任何 UI 库）
    ---------------------------------------------------------------
    深空冷紫 / 无窗体 / 多环星图（一圈一类，全部同时可见）/ 电脑 + 手机
    · 电脑：按住 ALT 呼出星图，松手归寂
    · 手机：点右下角常驻星点呼出，再点归寂
    · 点功能星 = 亮/灭；选中数值星后拖动 = 调值
    · CTRL + K = 低语（搜索全部功能）
    直接粘进执行器运行，无任何外部依赖。
--]]

local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS          = game:GetService("UserInputService")
local RunService   = game:GetService("RunService")

local LP    = Players.LocalPlayer
local TOUCH = UIS.TouchEnabled and not UIS.MouseEnabled

---------------------------------------------------------------- 主题
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

-- 空心圆环
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

-- 加固：实例已销毁/无父级时安静跳过，避免重复运行后刷屏报错
local function tw(o, t, props, style, dir)
	if not o or not o.Parent then return nil end
	local ti = TweenInfo.new(t, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out)
	local gone, a = pcall(function() return TweenService:Create(o, ti, props) end)
	if not gone or not a then return nil end
	a:Play()
	return a
end

-- 柔光团：多层同心圆近似径向渐变
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

---------------------------------------------------------------- 数据
local DATA = {
	{ glyph = "✦", name = "兵戈", stars = {
		{ n = "自动瞄准", t = "toggle", on = false },
		{ n = "穿墙视野", t = "toggle", on = true  },
		{ n = "无后坐力", t = "toggle", on = false },
		{ n = "弹道预判", t = "toggle", on = true  },
		{ n = "平滑阻尼", t = "value",  v = 0.35 },
		{ n = "视野半径", t = "value",  v = 0.62 },
	}},
	{ glyph = "◈", name = "观照", stars = {
		{ n = "描边高亮", t = "toggle", on = true  },
		{ n = "骨架绘制", t = "toggle", on = false },
		{ n = "方框标记", t = "toggle", on = false },
		{ n = "距离读数", t = "toggle", on = true  },
		{ n = "描边浓度", t = "value",  v = 0.48 },
		{ n = "绘制层数", t = "value",  v = 0.75 },
	}},
	{ glyph = "❖", name = "行止", stars = {
		{ n = "疾行",     t = "toggle", on = false },
		{ n = "二段跃",   t = "toggle", on = false },
		{ n = "凌波",     t = "toggle", on = false },
		{ n = "牵引",     t = "toggle", on = false },
		{ n = "速度倍率", t = "value",  v = 0.40 },
		{ n = "滞空时间", t = "value",  v = 0.20 },
	}},
	{ glyph = "⊙", name = "律令", stars = {
		{ n = "星象",     t = "toggle", on = false },  -- 仅占位，接口预留
		{ n = "低语面板", t = "toggle", on = true  },
		{ n = "星痕常显", t = "toggle", on = true  },
		{ n = "星痕显名", t = "toggle", on = true  },
		{ n = "归寂延时", t = "value",  v = 0.30 },
		{ n = "动效浓度", t = "value",  v = 0.80 },
	}},
}

---------------------------------------------------------------- 根
local gui = mk("ScreenGui", {
	Name = "CelestStandalone",
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	DisplayOrder = 9999,
})
local ok = pcall(function() gui.Parent = game:GetService("CoreGui") end)
if not ok or not gui.Parent then gui.Parent = LP:WaitForChild("PlayerGui") end

-- 根容器全透明：不再有常驻实心背景，游戏画面直接透出
local root = mk("Frame", {
	Parent = gui,
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = T.void,
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
})

---------------------------------------------------------------- 星云
local neb = mk("Frame", { Parent = root, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 1 })
local b1, b2, b3 = blob(neb, 900, T.nebA, .93), blob(neb, 780, T.nebB, .94), blob(neb, 840, T.nebC, .945)
b1.Position = UDim2.fromScale(.28, .30)
b2.Position = UDim2.fromScale(.76, .38)
b3.Position = UDim2.fromScale(.52, .82)

local function drift(o, dx, dy, t)
	local a = tw(o, t, { Position = o.Position + UDim2.fromScale(dx, dy) },
		Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
	if not a then return end
	a.Completed:Connect(function()
		if o.Parent then drift(o, -dx, -dy, t) end
	end)
end
drift(b1, .05, .03, 48)
drift(b2, -.06, .04, 60)
drift(b3, -.04, -.05, 70)

---------------------------------------------------------------- 星场
local field = mk("Frame", { Parent = root, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 2 })
do
	local count = TOUCH and 70 or 140
	for _ = 1, count do
		local sz = (math.random() < 88 and 1 or 2) + (math.random() < 12 and 1 or 0)
		local s = mk("Frame", {
			Parent = field,
			Size = UDim2.fromOffset(sz, sz),
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

---------------------------------------------------------------- 空白承接层
local blank = mk("TextButton", {
	Parent = root, Size = UDim2.fromScale(1, 1),
	BackgroundTransparency = 1, Text = "", AutoButtonColor = false, ZIndex = 3,
})

---------------------------------------------------------------- 星环开启时的幕布（关闭即隐去）
local veil = mk("Frame", {
	Parent = root, Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = T.void, BackgroundTransparency = 1,
	BorderSizePixel = 0, ZIndex = 9,
})

---------------------------------------------------------------- 星图容器（多环：一圈一类，全部同时可见）
-- 半径按「单类最多功能数」自适应，功能多也不会挤在一起
local maxN = 1
for _, c in ipairs(DATA) do if #c.stars > maxN then maxN = #c.stars end end
local RING, R0, STEP_R = {}, math.max(210, 20 * maxN), math.max(100, math.floor(math.max(210, 20 * maxN) * 0.52))
for i = 1, #DATA do RING[i] = R0 + (i - 1) * STEP_R end
local R_OUT = RING[#RING]
local REF = math.ceil((R_OUT + 90) * 2 / 10) * 10

local map = mk("CanvasGroup", {
	Parent = root,
	Size = UDim2.fromOffset(REF, REF),
	Position = UDim2.fromScale(.5, .5),
	AnchorPoint = Vector2.new(.5, .5),
	BackgroundTransparency = 1,
	GroupTransparency = 1,
	Visible = false,
	ZIndex = 10,
})
local mapScale = mk("UIScale", { Parent = map, Scale = 1 })

local function placeOn(node, r, deg)
	local a = math.rad(deg)
	node.Position = UDim2.new(.5, math.cos(a) * r, .5, math.sin(a) * r)
	node.AnchorPoint = Vector2.new(.5, .5)
end

---------------------------------------------------------------- 环 / 刻度 / 星核
local ringLayer = mk("Frame", { Parent = map, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 1 })
do
	for i = 1, #RING do
		local rg = ring(RING[i] * 2, T.line, i == #RING and .88 or .93)
		rg.Parent = ringLayer
	end
	local ticks = mk("Frame", { Parent = ringLayer, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1 })
	for i = 0, 71 do
		local deg  = i / 72 * 360
		local long = (i % 6 == 0)
		local t = mk("Frame", {
			Parent = ticks,
			Size = UDim2.fromOffset(1, long and 12 or 7),
			BackgroundColor3 = T.line,
			BackgroundTransparency = long and .55 or .82,
			BorderSizePixel = 0,
			AnchorPoint = Vector2.new(.5, 0),
		})
		t.Position = UDim2.new(.5, math.cos(math.rad(deg)) * (R_OUT + 2), .5, math.sin(math.rad(deg)) * (R_OUT + 2))
		t.Rotation = deg + 90
	end
end

local core = mk("Frame", {
	Parent = map, Size = UDim2.fromOffset(0, 0),
	Position = UDim2.fromScale(.5, .5), AnchorPoint = Vector2.new(.5, .5),
	BackgroundTransparency = 1, ZIndex = 3,
})
blob(core, 130, T.accent2, .90)
local coreSpin = ring(66, T.accent, .78)
coreSpin.Parent = core
local coreDot = circle(core, 8, T.star, 0)
coreDot.ZIndex = 4
task.spawn(function()
	while coreDot.Parent do
		tw(coreDot, 2.6, { Size = UDim2.fromOffset(11, 11) }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
		task.wait(2.6)
		tw(coreDot, 2.6, { Size = UDim2.fromOffset(7, 7) }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
		task.wait(2.6)
	end
end)
task.spawn(function()
	while coreSpin.Parent do
		coreSpin.Rotation = 0
		tw(coreSpin, 22, { Rotation = 360 }, Enum.EasingStyle.Linear)
		task.wait(22)
	end
end)

-- 分类名与星点同层，星点 ZIndex 更高
local nodeLayer = mk("Frame", { Parent = map, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 5 })

---------------------------------------------------------------- 前向声明（必须在使用者之前）
local SelectValue
local OpenWhisper
local HUDBus = { Refresh = function() end }
local STARS, STAR_BY_NAME = {}, {}

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
		local s = dot:FindFirstChildOfClass("UIStroke")
		if s then s.Color = T.dim; s.Transparency = .62 end
	end
end

---------------------------------------------------------------- 选中高亮
local selected = nil

-- 拖动状态（必须在 makeStar 之前声明，供星点按钮闭包引用）
local dragging, dragMoved, dragCtx = false, false, nil

function SelectValue(node, star, dot)
	if selected and selected.node == node then
		paintDot(dot, false, false)
		selected = nil
		return
	end
	if selected then paintDot(selected.dot, false, false) end
	selected = { star = star, node = node, dot = dot }
	paintDot(dot, false, true)
end

local function clearSelection()
	if selected then
		paintDot(selected.dot, false, false)
		selected = nil
	end
end

---------------------------------------------------------------- 拖动（帧同步，稳定可靠）
local dragConn = nil

local function endDrag()
	if dragConn then dragConn:Disconnect(); dragConn = nil end
	-- 按下后没有真正移动 → 视为轻点，切换该数值星的选中状态
	if dragging and dragCtx and not dragMoved and dragCtx.canToggle then
		SelectValue(dragCtx.node, dragCtx.star, dragCtx.dot)
	end
	dragging, dragMoved, dragCtx = false, false, nil
end

-- setV(v)：由数值星提供，负责同时刷新百分比文字与数值条
-- noToggle=true 时（从大热区按下），原地松手不会取消选中
local function beginDrag(node, star, dot, setV, noToggle)
	local wasSel = (selected ~= nil and selected.node == node)
	dragging, dragMoved = true, false
	dragCtx = { node = node, star = star, dot = dot, setV = setV }
	dragCtx.canToggle = (not noToggle) and wasSel
	if not wasSel then SelectValue(node, star, dot) end
	if dragConn then dragConn:Disconnect(); dragConn = nil end
	if not TOUCH then
		-- 电脑：每帧读取鼠标绝对位置，避免 InputChanged 被 GUI 吞掉
		local baseX, baseV = UIS:GetMouseLocation().X, star.v
		dragConn = RunService.RenderStepped:Connect(function()
			local dx = UIS:GetMouseLocation().X - baseX
			if math.abs(dx) < .5 then return end
			dragMoved = true
			dragCtx.setV(math.clamp(baseV + dx / 420, 0, 1))
		end)
	end
end

---------------------------------------------------------------- 功能星
local function makeStar(cat, star, r, deg)
	local node = mk("Frame", {
		Parent = nodeLayer,
		Size = UDim2.fromOffset(114, 88),
		BackgroundTransparency = 1,
		ZIndex = 6,
	})
	placeOn(node, r, deg)

	local btn = mk("TextButton", {
		Parent = node, Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1, Text = "", AutoButtonColor = false, ZIndex = 6,
	})
	local dot = circle(node, 9, T.star, 1)  -- 居中，正好落在环线上
	dot.ZIndex = 6
	paintDot(dot, star.t == "toggle" and star.on, false)

	local label = mk("TextLabel", {
		Parent = node, BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 16), Position = UDim2.new(.5, 0, .5, 10),
		AnchorPoint = Vector2.new(.5, 0),
		Font = Enum.Font.Gotham, TextSize = 12,
		TextColor3 = T.dim, TextTransparency = .62,
		Text = star.n, ZIndex = 6,
	})

	local val, setV
	if star.t == "value" then
		val = mk("TextLabel", {
			Parent = node, BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 12), Position = UDim2.new(.5, 0, .5, 26),
			AnchorPoint = Vector2.new(.5, 0),
			Font = Enum.Font.Gotham, TextSize = 10,
			TextColor3 = T.dim, TextTransparency = .7,
			Text = tostring(math.floor(star.v * 100)) .. "%", ZIndex = 6,
		})
		local track = mk("Frame", {
			Parent = node, Size = UDim2.fromOffset(58, 3),
			Position = UDim2.new(.5, 0, .5, 40), AnchorPoint = Vector2.new(.5, 0),
			BackgroundColor3 = T.dim, BackgroundTransparency = .72,
			BorderSizePixel = 0, ZIndex = 6,
		})
		round(track, 1)
		local fill = mk("Frame", {
			Parent = track, Size = UDim2.fromScale(star.v, 1),
			BackgroundColor3 = T.accent, BackgroundTransparency = .05,
			BorderSizePixel = 0, ZIndex = 7,
		})
		round(fill, 1)
		setV = function(v)
			star.v = v
			val.Text = tostring(math.floor(v * 100)) .. "%"
			fill.Size = UDim2.fromScale(v, 1)
		end
	end

	local function ripple(bright)
		local rr = circle(node, 9, bright and T.star or T.accent, 1)
		stroke(rr, bright and T.star or T.accent, 1, .2)
		rr.ZIndex = 5
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

	-- 数值星：按下即选中并进入拖动；原地轻点则开/关选择
	btn.MouseButton1Down:Connect(function()
		if star.t ~= "value" then return end
		beginDrag(node, star, dot, setV, false)
	end)

	btn.MouseButton1Click:Connect(function()
		if star.t ~= "toggle" then return end
		if star.n == "星象" then OpenWhisper("星象"); return end
		star.on = not star.on
		paintDot(dot, star.on, false)
		ripple(star.on)
		HUDBus.Refresh()
	end)

	local entry = { star = star, node = node, dot = dot, setV = setV, cat = cat }
	STARS[#STARS + 1] = entry
	STAR_BY_NAME[star.n] = entry
	return node
end

---------------------------------------------------------------- 分类名（各环正上方）
local function buildLabels()
	for i, cat in ipairs(DATA) do
		local pill = mk("Frame", {
			Parent = nodeLayer, Size = UDim2.fromOffset(100, 22),
			BackgroundColor3 = T.panel, BackgroundTransparency = .38,
			BorderSizePixel = 0, ZIndex = 5,
		})
		round(pill, 1)
		stroke(pill, T.line, 1, .7)
		placeOn(pill, RING[i], -90)
		mk("TextLabel", {
			Parent = pill, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1),
			Font = Enum.Font.Gotham, TextSize = 12,
			TextColor3 = T.star, TextTransparency = .12,
			Text = cat.glyph .. "  " .. cat.name, ZIndex = 6,
		})
	end
end

---------------------------------------------------------------- 全部功能星（所有环同时显示）
local function buildStars()
	for i, cat in ipairs(DATA) do
		local n    = #cat.stars
		local step = 360 / n
		for j, s in ipairs(cat.stars) do
			-- 顶部留出分类名位置 → 从半格偏移开始排
			makeStar(cat, s, RING[i], -90 + step / 2 + (j - 1) * step)
		end
	end
end

---------------------------------------------------------------- 星痕（右上）
local trailBox = mk("Frame", {
	Parent = root,
	Size = UDim2.fromOffset(160, 22),
	Position = UDim2.new(1, -34, 0, 30),
	AnchorPoint = Vector2.new(1, 0),
	BackgroundTransparency = 1, ZIndex = 20,
})
local trailRow = mk("Frame", { Parent = trailBox, Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1 })
mk("UIListLayout", {
	Parent = trailRow, FillDirection = Enum.FillDirection.Horizontal,
	HorizontalAlignment = Enum.HorizontalAlignment.Right,
	VerticalAlignment = Enum.VerticalAlignment.Center,
	Padding = UDim.new(0, 9),
})
local trailTip = mk("TextLabel", {
	Parent = trailBox,
	Size = UDim2.fromOffset(420, 30),
	Position = UDim2.new(1, 0, 0, 30), AnchorPoint = Vector2.new(1, 0),
	BackgroundColor3 = T.panel, BackgroundTransparency = 1,
	Font = Enum.Font.Gotham, TextSize = 12,
	TextColor3 = T.dim, TextTransparency = 1, Text = "",
	ZIndex = 21,
})
round(trailTip, 0)
stroke(trailTip, T.line, 1, 1)

local function isMeta(n)
	return n == "星象" or n == "低语面板" or n == "星痕常显" or n == "星痕显名"
end

function HUDBus.Refresh()
	for _, c in ipairs(trailRow:GetChildren()) do
		if c:IsA("Frame") then c:Destroy() end
	end
	local names = {}
	for _, cat in ipairs(DATA) do
		for _, s in ipairs(cat.stars) do
			if s.t == "toggle" and s.on and not isMeta(s.n) then
				names[#names + 1] = s.n
			end
		end
	end
	for i = 1, math.min(#names, 6) do
		local d = circle(trailRow, 6, T.accent, .12)
		d.LayoutOrder = i
		task.spawn(function()
			while d.Parent do
				tw(d, 1.7, { BackgroundTransparency = .55, Size = UDim2.fromOffset(5, 5) }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
				task.wait(1.7)
				tw(d, 1.7, { BackgroundTransparency = .08, Size = UDim2.fromOffset(7, 7) }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
				task.wait(1.7)
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

---------------------------------------------------------------- 常驻星点
local sigil = mk("TextButton", {
	Parent = root,
	Size = UDim2.fromOffset(44, 44),
	Position = UDim2.new(1, -30, 1, -30), AnchorPoint = Vector2.new(1, 1),
	BackgroundTransparency = 1, Text = "", AutoButtonColor = false, ZIndex = 30,
})
do
	local r = ring(30, T.line, .72); r.Parent = sigil
	local d = circle(sigil, 7, T.accent, .1)
	task.spawn(function()
		while d.Parent do
			tw(d, 2.2, { BackgroundTransparency = .45, Size = UDim2.fromOffset(5, 5) }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
			task.wait(2.2)
			tw(d, 2.2, { BackgroundTransparency = .05, Size = UDim2.fromOffset(8, 8) }, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
			task.wait(2.2)
		end
	end)
end

---------------------------------------------------------------- 呼出 / 归寂
local mapOpen, pinned = false, false

local function OpenMap()
	if mapOpen then return end
	mapOpen = true
	map.Visible = true
	tw(veil, .42, { BackgroundTransparency = .18 })
	tw(map, .42, { GroupTransparency = 0 })
end

local function CloseMap()
	if not mapOpen then return end
	mapOpen = false
	endDrag()
	clearSelection()
	tw(veil, .34, { BackgroundTransparency = 1 })
	local a = tw(map, .34, { GroupTransparency = 1 })
	if a then
		a.Completed:Connect(function()
			if not mapOpen then map.Visible = false end
		end)
	else
		map.Visible = false
	end
end

sigil.MouseButton1Click:Connect(function()
	if mapOpen then pinned = false; CloseMap()
	else pinned = true; OpenMap() end
end)

blank.MouseButton1Click:Connect(function()
	if selected then clearSelection(); return end
	if pinned then pinned = false; CloseMap() end
end)

---------------------------------------------------------------- 低语面板
local whisper = mk("Frame", {
	Parent = root,
	Size = UDim2.fromOffset(520, 132),
	Position = UDim2.new(.5, 0, 1, -120), AnchorPoint = Vector2.new(.5, 1),
	BackgroundTransparency = 1, Visible = false, ZIndex = 40,
})
local wbox = mk("Frame", {
	Parent = whisper, Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = T.panel, BackgroundTransparency = .28,
	BorderSizePixel = 0, ZIndex = 40,
})
round(wbox, 0)
stroke(wbox, T.line, 1, .62)
mk("UIPadding", { Parent = wbox, PaddingTop = UDim.new(0, 14), PaddingLeft = UDim.new(0, 18), PaddingRight = UDim.new(0, 18) })
local wi = mk("TextBox", {
	Parent = wbox, Size = UDim2.new(1, 0, 0, 30),
	BackgroundTransparency = 1,
	Font = Enum.Font.Gotham, TextSize = 15,
	TextColor3 = T.star, TextTransparency = .05,
	PlaceholderText = "低语一个名字…", PlaceholderColor3 = T.dim,
	Text = "", ClearTextOnFocus = false,
	TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 41,
})
local wres = mk("Frame", { Parent = wbox, Size = UDim2.new(1, 0, 0, 78), Position = UDim2.new(0, 0, 0, 40), BackgroundTransparency = 1, ZIndex = 41 })
local emptyLbl = mk("TextLabel", {
	Parent = wres, BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1),
	Font = Enum.Font.Gotham, TextSize = 12, TextColor3 = T.dim, TextTransparency = .72,
	Text = "虚空无应…", TextXAlignment = Enum.TextXAlignment.Left,
})

local function closeWhisper()
	whisper.Visible = false
	wi.Text = ""
	wi:ReleaseFocus()
end

function OpenWhisper(prefill)
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
	for ci, cat in ipairs(DATA) do
		for _, s in ipairs(cat.stars) do
			if q == "" or string.find(s.n, q, 1, true) or string.find(cat.name, q, 1, true) then
				rows[#rows + 1] = { ci = ci, s = s, cat = cat.name }
			end
		end
	end
	emptyLbl.Visible = (#rows == 0)
	for i = 1, math.min(#rows, 3) do
		local r = rows[i]
		local b = mk("TextButton", {
			Parent = wres,
			Size = UDim2.new(1, 0, 0, 26), Position = UDim2.new(0, 0, 0, (i - 1) * 26),
			BackgroundTransparency = 1, AutoButtonColor = false,
			Font = Enum.Font.Gotham, TextSize = 13,
			TextColor3 = T.dim, TextTransparency = .35,
			Text = r.s.n .. "    " .. r.cat, TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = 42,
		})
		b.MouseEnter:Connect(function() tw(b, .15, { TextColor3 = T.star, TextTransparency = .05 }) end)
		b.MouseLeave:Connect(function() tw(b, .15, { TextColor3 = T.dim, TextTransparency = .35 }) end)
		b.MouseButton1Click:Connect(function()
			local e = STAR_BY_NAME[r.s.n]
			if e then
				if e.star.t == "toggle" then
					e.star.on = not e.star.on
					paintDot(e.dot, e.star.on, false)
					HUDBus.Refresh()
				elseif e.setV then
					SelectValue(e.node, e.star, e.dot)
				end
			end
			closeWhisper()
		end)
	end
end
wi:GetPropertyChangedSignal("Text"):Connect(renderRes)

---------------------------------------------------------------- 输入
UIS.InputBegan:Connect(function(input)
	local k = input.KeyCode
	if k == Enum.KeyCode.LeftAlt or k == Enum.KeyCode.RightAlt then
		if not TOUCH then OpenMap() end
		return
	end
	if k == Enum.KeyCode.K and (UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.RightControl)) then
		if whisper.Visible then closeWhisper() else OpenWhisper() end
		return
	end
	if k == Enum.KeyCode.Escape then
		if whisper.Visible then closeWhisper()
		elseif pinned then pinned = false; CloseMap() end
		return
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
		if not pinned then CloseMap() end
	end
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		endDrag()
	end
end)

UIS.InputChanged:Connect(function(input)
	-- 电脑端由 RenderStepped 处理；这里只服务触屏
	if not TOUCH or not dragging or not dragCtx then return end
	if input.UserInputType == Enum.UserInputType.Touch then
		local dx = input.Delta.X
		if dx == 0 then return end
		dragMoved = true
		dragCtx.setV(math.clamp(dragCtx.star.v + dx / 420, 0, 1))
	end
end)

---------------------------------------------------------------- 缩放
local function resize()
	local vp = Vector2.new(1280, 720)
	local cam = workspace.CurrentCamera
	if cam then vp = cam.ViewportSize end
	mapScale.Scale = math.clamp(math.min(vp.X, vp.Y) / REF * (TOUCH and 1.06 or 1.02), .3, 1.15)
end
resize()
if workspace.CurrentCamera then
	workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(resize)
end

---------------------------------------------------------------- 入场：星辰汇聚（1 秒）
local function gather()
	local box = mk("Frame", {
		Parent = root,
		Size = UDim2.fromOffset(REF, REF),
		Position = UDim2.fromScale(.5, .5), AnchorPoint = Vector2.new(.5, .5),
		BackgroundTransparency = 1, ZIndex = 8,
	})
	mk("UIScale", { Parent = box, Scale = mapScale.Scale })
	for _ = 1, 56 do
		local d = circle(box, 4, T.star, 1)
		local ang = math.random() * math.pi * 2
		local r   = 240 + math.random() * 380
		d.Position = UDim2.new(.5, math.cos(ang) * r, .5, math.sin(ang) * r)
		task.spawn(function()
			tw(d, .12, { BackgroundTransparency = 0 })
			task.wait(math.random() * .06)
			tw(d, .88, {
				Position = UDim2.new(.5, 0, .5, 0),
				Size = UDim2.fromOffset(2, 2),
				BackgroundTransparency = 1,
			}, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
			task.wait(.95)
			if d.Parent then d:Destroy() end
		end)
	end
	task.delay(1.05, function() if box.Parent then box:Destroy() end end)
end

---------------------------------------------------------------- 启动
buildLabels()
buildStars()
HUDBus.Refresh()
gather()

---------------------------------------------------------------- 品牌 & 提示
mk("TextLabel", {
	Parent = root, BackgroundTransparency = 1,
	Size = UDim2.fromOffset(300, 30), Position = UDim2.new(0, 34, 0, 26),
	Font = Enum.Font.GothamMedium, TextSize = 22,
	TextColor3 = T.star, TextTransparency = .1,
	Text = "星 穹", TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 20,
})
mk("TextLabel", {
	Parent = root, BackgroundTransparency = 1,
	Size = UDim2.fromOffset(320, 16), Position = UDim2.new(0, 36, 0, 54),
	Font = Enum.Font.Gotham, TextSize = 10,
	TextColor3 = T.dim, TextTransparency = .58,
	Text = "C E L E S T   ·   独立示例", TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 20,
})
mk("TextLabel", {
	Parent = root, BackgroundTransparency = 1,
	Size = UDim2.fromOffset(520, 40), Position = UDim2.new(0, 30, 1, -58), AnchorPoint = Vector2.new(0, 1),
	Font = Enum.Font.Gotham, TextSize = 11,
	TextColor3 = T.dim, TextTransparency = .62,
	Text = TOUCH
		and "点右下星点呼出 · 再点归寂\n点星点亮灭 · 选中数值星后拖动调值"
		or  "按住 ALT 呼出 · 松手归寂\n点星点亮灭 · 选数值星后拖动调值 · CTRL+K 低语",
	TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 20,
})