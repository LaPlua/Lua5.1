--==============================================================================
--  AETHER UI  ·  以太界面框架
--  一款“设备化”的 Roblox UI 库：开机自检 → 神经同步 → 全息座舱
--
--  设计语言
--    · 纯黑玻璃 + 霓虹描边 + 四角卡尺（HUD 准星）
--    · 扫描线扫过、网格底纹、描边流光、标题乱码重组
--    · 所有颜色都绑定主题，切主题时全界面 0.35s 平滑过渡
--
--  独有系统
--    · Boot      开机自检序列（逐行打字 + 进度 + 乱码揭示）
--    · Palette   指令面板（Ctrl+K，模糊搜索全库指令，键盘导航）
--    · Radial    环形放射菜单（按住方向键，扇区选择，松手触发）
--    · Telemetry HUD 遥测（FPS / Ping 实时曲线 + 时钟 + 水印）
--    · Console   内置 REPL（直接跑 Lua，留档彩色输出）
--    · Config    配置持久化（执行器支持时自动写入本地）
--
--  兼容：Roblox Luau（可运行于多数执行器），不依赖 CanvasGroup（避免纹理缩放发糊）
--==============================================================================

local Aether = {}
Aether.__index = Aether
Aether.Flags = {}
Aether.Version = "1.0.0"
Aether.Theme = {}
Aether.Themes = {}

--==============================================================================
-- 服务
--==============================================================================
local Players      = game:GetService("Players")
local UIS          = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService   = game:GetService("RunService")
local CoreGui      = game:GetService("CoreGui")
local Stats        = game:GetService("Stats")
local LocalPlayer  = Players.LocalPlayer
local Camera       = workspace.CurrentCamera

--==============================================================================
-- 执行器能力探测（缺失一律降级，绝不报错）
--==============================================================================
local GLOB = (type(getgenv) == "function" and getgenv()) or _G

local function api(name)
	local fn = GLOB[name]
	if type(fn) == "function" then return fn end
	return nil
end

local HttpRequest  = api("request")
local WriteFile    = api("writefile")
local ReadFile     = api("readfile")
local IsFile       = api("isfile")
local MakeFolder   = api("makefolder")
local IsFolder     = api("isfolder")
local ListFiles    = api("listfiles")
local DelFile      = api("delfile")
local ToAsset      = api("getcustomasset")
local LoadString   = api("loadstring") or rawget(_G, "loadstring")

local function parentGui(sg)
	local gethui = api("gethui")
	if gethui then
		local ok, h = pcall(gethui)
		if ok and h then sg.Parent = h; return end
	end
	local ok = pcall(function() sg.Parent = CoreGui end)
	if not ok then
		pcall(function() sg.Parent = LocalPlayer:WaitForChild("PlayerGui") end)
	end
end

--==============================================================================
-- 基础工具
--==============================================================================
local function create(class, props)
	local inst = Instance.new(class)
	if props then
		for k, v in pairs(props) do
			if k ~= "Parent" then pcall(function() inst[k] = v end) end
		end
		if props.Parent then inst.Parent = props.Parent end
	end
	return inst
end

local function tween(inst, props, time, style, dir)
	if not inst then return nil end
	local info = TweenInfo.new(time or 0.22, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out)
	local ok, tw = pcall(function() return TweenService:Create(inst, info, props) end)
	if ok and tw then tw:Play(); return tw end
	for k, v in pairs(props) do pcall(function() inst[k] = v end) end
	return nil
end

local function corner(inst, r)
	local c = inst:FindFirstChildOfClass("UICorner")
	if not c then c = create("UICorner", { Parent = inst }) end
	c.CornerRadius = UDim.new(0, r or 10)
	return c
end

local function stroke(inst, color, thickness, trans)
	local s = inst:FindFirstChildOfClass("UIStroke")
	if not s then s = create("UIStroke", { Parent = inst }) end
	s.Thickness = thickness or 1
	s.Color = color or Color3.fromRGB(255, 255, 255)
	s.Transparency = trans or 0
	pcall(function() s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border end)
	return s
end

local function gradient(inst, c1, c2, rot, t1, t2)
	local g = inst:FindFirstChildOfClass("UIGradient")
	if not g then g = create("UIGradient", { Parent = inst }) end
	g.Color = ColorSequence.new(c1, c2)
	g.Rotation = rot or 0
	if t1 or t2 then
		g.Transparency = NumberSequence.new(t1 or 0, t2 or 0)
	end
	return g
end

local function padding(inst, t, b, l, r)
	local p = inst:FindFirstChildOfClass("UIPadding")
	if not p then p = create("UIPadding", { Parent = inst }) end
	p.PaddingTop = UDim.new(0, t or 0)
	p.PaddingBottom = UDim.new(0, b or 0)
	p.PaddingLeft = UDim.new(0, l or 0)
	p.PaddingRight = UDim.new(0, r or 0)
	return p
end

local function list(inst, dir, pad, halign)
	local l = inst:FindFirstChildOfClass("UIListLayout")
	if not l then l = create("UIListLayout", { Parent = inst }) end
	l.FillDirection = dir or Enum.FillDirection.Vertical
	l.Padding = UDim.new(0, pad or 8)
	l.SortOrder = Enum.SortOrder.LayoutOrder
	l.HorizontalAlignment = halign or Enum.HorizontalAlignment.Left
	l.VerticalAlignment = Enum.VerticalAlignment.Top
	return l
end

local _ord = 0
local function order(inst, n)
	_ord = _ord + 1
	inst.LayoutOrder = n or _ord
	return inst
end

local function clamp(v, lo, hi) return math.max(lo, math.min(hi, v)) end
local function lerp(a, b, t) return a + (b - a) * t end
local function round(v, step)
	if not step or step <= 0 then return v end
	return math.floor(v / step + 0.5) * step
end

local function rgb(r, g, b) return Color3.fromRGB(r, g, b) end

local function fmtNum(v, step)
	if step and step >= 1 then
		return string.format("%d", math.floor(v + 0.5))
	end
	local s = string.format("%.2f", v)
	s = string:gsub("%.?0+$", "")  -- 去掉尾部多余的 0
	if s == "" or s == "-" then s = "0" end
	return s
end

local function debounce(fn, wait)
	local last = 0
	return function(...)
		local now = os.clock()
		if now - last >= (wait or 0.4) then
			last = now
			return fn(...)
		end
	end
end

local GLYPHS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789#$%&@*<>/\\|=+-~^"

-- 乱码重组：文字从随机字符收敛到目标文本
local function scramble(label, text, dur, cps)
	if not label then return end
	local target = tostring(text or "")
	local total = #target
	local elapsed = 0
	local step = 1 / (cps or 34)
	local conn
	conn = RunService.RenderStepped:Connect(function(dt)
		elapsed = elapsed + dt
		local settled = math.floor(elapsed / step * 1.6)
		local out = {}
		for i = 1, total do
			local ch = string.sub(target, i, i)
			if i <= settled or ch == " " then
				out[i] = ch
			else
				local r = math.random(1, #GLYPHS)
				out[i] = string.sub(GLYPHS, r, r)
			end
		end
		label.Text = table.concat(out)
		if settled >= total then
			label.Text = target
			if conn then conn:Disconnect() end
		end
	end)
	task.delay((dur or 0.6) + 0.6, function()
		if conn then conn:Disconnect() end
		if label and label.Parent then label.Text = target end
	end)
end

local function typewriter(label, text, cps, done)
	local target = tostring(text or "")
	local i = 0
	local conn
	conn = RunService.RenderStepped:Connect(function()
		i = i + 3
		label.Text = string.sub(target, 1, i)
		if i >= #target then
			label.Text = target
			if conn then conn:Disconnect() end
			if done then done() end
		end
	end)
end

local function cursorPos()
	local v = UIS:GetMouseLocation()
	if Camera then
		return Vector2.new(v.X, v.Y - 36)
	end
	return v
end

--==============================================================================
-- 主题
--==============================================================================
Aether.Themes = {
	void = {
		Label = "VOID", Bg = rgb(6, 7, 11), Panel = rgb(12, 14, 20),
		Card = rgb(17, 20, 28), Element = rgb(24, 28, 38), Stroke = rgb(72, 84, 110),
		Text = rgb(238, 244, 255), Muted = rgb(126, 138, 162),
		Accent = rgb(0, 226, 255), Accent2 = rgb(126, 92, 255), Ink = rgb(4, 8, 14),
		Ok = rgb(74, 222, 158), Warn = rgb(250, 190, 90), Bad = rgb(255, 92, 112),
	},
	neon = {
		Label = "NEON", Bg = rgb(7, 4, 12), Panel = rgb(15, 8, 24),
		Card = rgb(22, 12, 34), Element = rgb(32, 18, 48), Stroke = rgb(120, 70, 160),
		Text = rgb(246, 238, 255), Muted = rgb(146, 124, 176),
		Accent = rgb(255, 64, 190), Accent2 = rgb(96, 92, 255), Ink = rgb(12, 4, 20),
		Ok = rgb(112, 240, 176), Warn = rgb(255, 196, 96), Bad = rgb(255, 84, 132),
	},
	ember = {
		Label = "EMBER", Bg = rgb(10, 6, 5), Panel = rgb(20, 12, 10),
		Card = rgb(28, 17, 14), Element = rgb(40, 24, 19), Stroke = rgb(128, 76, 52),
		Text = rgb(255, 244, 236), Muted = rgb(168, 130, 112),
		Accent = rgb(255, 138, 48), Accent2 = rgb(255, 74, 74), Ink = rgb(14, 6, 4),
		Ok = rgb(160, 222, 120), Warn = rgb(255, 200, 96), Bad = rgb(255, 96, 88),
	},
	arctic = {
		Label = "ARCTIC", Bg = rgb(8, 11, 15), Panel = rgb(16, 22, 30),
		Card = rgb(22, 30, 40), Element = rgb(30, 41, 54), Stroke = rgb(96, 124, 152),
		Text = rgb(242, 249, 255), Muted = rgb(134, 156, 180),
		Accent = rgb(140, 214, 255), Accent2 = rgb(96, 148, 255), Ink = rgb(6, 12, 20),
		Ok = rgb(120, 226, 200), Warn = rgb(250, 206, 130), Bad = rgb(255, 118, 138),
	},
	mono = {
		Label = "MONO", Bg = rgb(9, 9, 10), Panel = rgb(16, 16, 17),
		Card = rgb(22, 22, 24), Element = rgb(30, 30, 33), Stroke = rgb(84, 84, 90),
		Text = rgb(246, 246, 248), Muted = rgb(140, 140, 148),
		Accent = rgb(255, 255, 255), Accent2 = rgb(178, 178, 186), Ink = rgb(10, 10, 10),
		Ok = rgb(180, 180, 184), Warn = rgb(214, 214, 218), Bad = rgb(255, 255, 255),
	},
}

for k, v in pairs(Aether.Themes.void) do
	if k ~= "Label" then Aether.Theme[k] = v end
end
Aether.ThemeName = "void"

-- 主题绑定：任何注册过的实例都会在切主题时平滑过渡
local Binds = {}
local function tb(inst, prop, key)
	if not inst then return inst end
	Binds[#Binds + 1] = { i = inst, p = prop, k = key }
	local v = Aether.Theme[key]
	if v then pcall(function() inst[prop] = v end) end
	return inst
end

local function applyTheme(name, instant)
	local t = Aether.Themes[name]
	if not t then return false end
	Aether.ThemeName = name
	for k, v in pairs(t) do
		if k ~= "Label" then Aether.Theme[k] = v end
	end
	for _, b in ipairs(Binds) do
		local target = Aether.Theme[b.k]
		if target and b.i and b.i.Parent then
			if instant then
				pcall(function() b.i[b.p] = target end)
			else
				tween(b.i, { [b.p] = target }, 0.35, Enum.EasingStyle.Quad)
			end
		end
	end
	return true
end

--==============================================================================
-- 内置矢量图标（24×24 逻辑坐标，纯矩形/胶囊拼装，不依赖任何图片资源）
--   每一项: { cx, cy, w, h, rot, round }
--==============================================================================
local ICONS = {
	dot      = { {12, 12, 7, 7, 0, 1} },
	diamond  = { {12, 12, 12, 12, 45, 0} },
	ring     = { {12, 12, 16, 16, 0, 1}, {12, 12, 7, 7, 0, 1} },
	cross    = { {12, 4, 2.4, 7, 0, 1}, {12, 20, 2.4, 7, 0, 1}, {4, 12, 7, 2.4, 0, 1}, {20, 12, 7, 2.4, 0, 1}, {12, 12, 3.4, 3.4, 0, 1} },
	target   = { {12, 12, 17, 17, 0, 1}, {12, 12, 13, 13, 0, 1}, {12, 3, 2.6, 5, 0, 1}, {12, 21, 2.6, 5, 0, 1}, {3, 12, 5, 2.6, 0, 1}, {21, 12, 5, 2.6, 0, 1} },
	shield   = { {12, 4, 17, 8, 0, 1}, {12, 9, 15, 8, 0, 1}, {12, 14, 11, 7, 0, 1}, {12, 18, 6, 5, 0, 1} },
	eye      = { {12, 12, 20, 9, 0, 1}, {12, 12, 7, 7, 0, 1} },
	bolt     = { {9, 8, 3.6, 9, 30, 1}, {15, 16, 3.6, 9, 30, 1}, {12, 12, 9, 3.2, -22, 1} },
	layers   = { {12, 7, 18, 5, 0, 1}, {12, 12, 18, 5, 0, 1}, {12, 17, 18, 5, 0, 1} },
	gear     = { {12, 12, 7, 7, 0, 1}, {12, 12, 15, 15, 0, 1}, {12, 3.4, 3.2, 4, 0, 1}, {12, 20.6, 3.2, 4, 0, 1}, {3.4, 12, 4, 3.2, 0, 1}, {20.6, 12, 4, 3.2, 0, 1}, {5.8, 5.8, 4, 3, 45, 1}, {18.2, 18.2, 4, 3, 45, 1}, {18.2, 5.8, 4, 3, -45, 1}, {5.8, 18.2, 4, 3, -45, 1} },
	user     = { {12, 8, 7.5, 7.5, 0, 1}, {12, 18, 14, 8, 0, 1} },
	terminal = { {5, 9, 6, 2.4, 45, 1}, {5, 15, 6, 2.4, -45, 1}, {15, 16, 9, 2.4, 0, 1}, {12, 4, 20, 17, 0, 1} },
	key      = { {8, 8, 9, 9, 0, 1}, {13, 13, 10, 2.6, 45, 1}, {17, 17, 5, 2.6, 135, 1} },
	clock    = { {12, 12, 19, 19, 0, 1}, {12, 8, 2.4, 8, 0, 1}, {15, 13, 7, 2.4, 0, 1} },
	chip     = { {12, 12, 15, 15, 0, 0}, {12, 12, 7, 7, 0, 0}, {12, 1.6, 2.4, 4, 0, 1}, {12, 22.4, 2.4, 4, 0, 1}, {1.6, 12, 4, 2.4, 0, 1}, {22.4, 12, 4, 2.4, 0, 1} },
	search   = { {10, 10, 14, 14, 0, 1}, {18, 18, 8, 2.6, 45, 1} },
	close    = { {12, 12, 15, 2.6, 45, 1}, {12, 12, 15, 2.6, -45, 1} },
	check    = { {8, 13, 8, 2.6, 45, 1}, {15, 9, 14, 2.6, -45, 1} },
	chevron  = { {9, 12, 8, 2.6, 45, 1}, {15, 12, 8, 2.6, -45, 1} },
	down     = { {12, 10, 9, 2.6, 45, 1}, {12, 10, 9, 2.6, -45, 1} },
	plus     = { {12, 12, 14, 2.6, 0, 1}, {12, 12, 2.6, 14, 0, 1} },
	more     = { {5, 12, 3.6, 3.6, 0, 1}, {12, 12, 3.6, 3.6, 0, 1}, {19, 12, 3.6, 3.6, 0, 1} },
	wifi     = { {12, 5, 6, 3, 0, 1}, {12, 10, 12, 3, 0, 1}, {12, 15, 18, 3, 0, 1}, {12, 20, 3.4, 3.4, 0, 1} },
	grid     = { {7.5, 7.5, 8, 8, 0, 0}, {16.5, 7.5, 8, 8, 0, 0}, {7.5, 16.5, 8, 8, 0, 0}, {16.5, 16.5, 8, 8, 0, 0} },
	folder   = { {12, 14, 19, 12, 0, 1}, {7, 7, 9, 5, 0, 1} },
	globe    = { {12, 12, 19, 19, 0, 1}, {12, 12, 2.2, 19, 0, 0}, {12, 12, 19, 2.2, 0, 0} },
	wave     = { {6, 13, 2.8, 9, 0, 1}, {10.5, 9, 2.8, 17, 0, 1}, {15, 12, 2.8, 11, 0, 1}, {19.5, 15, 2.8, 6, 0, 1} },
	palette  = { {12, 12, 18, 18, 0, 1}, {8, 9, 3.4, 3.4, 0, 1}, {12, 7.5, 3.4, 3.4, 0, 1}, {16, 10.5, 3.4, 3.4, 0, 1} },
	home     = { {12, 15, 15, 12, 0, 0}, {12, 7.5, 4, 4, 45, 0}, {12, 7.5, 4, 4, -45, 0} },
	expand   = { {7, 7, 8, 2.4, 0, 1}, {7, 7, 2.4, 8, 0, 1}, {17, 17, 8, 2.4, 0, 1}, {17, 17, 2.4, 8, 0, 1} },
	lock     = { {12, 15, 14, 10, 0, 1}, {12, 9, 9, 9, 0, 1} },
	scan     = { {12, 6, 16, 2.2, 0, 1}, {12, 12, 16, 2.2, 0, 1}, {12, 18, 16, 2.2, 0, 1}, {4, 12, 2.2, 16, 0, 1}, {20, 12, 2.2, 16, 0, 1} },
	power    = { {12, 13, 15, 15, 0, 1}, {12, 7, 2.6, 8, 0, 1} },
}

local function icon(parent, name, size, color, props)
	local def = ICONS[name] or ICONS.dot
	props = props or {}
	local box = create("Frame", {
		Name = "Icon_" .. tostring(name),
		BackgroundTransparency = 1,
		Size = props.Size or UDim2.fromOffset(size, size),
		Position = props.Position or UDim2.fromScale(0.5, 0.5),
		AnchorPoint = props.AnchorPoint or Vector2.new(0.5, 0.5),
		ZIndex = props.ZIndex or 5,
		Parent = parent,
	})
	local k = size / 24
	for i = 1, #def do
		local s = def[i]
		local w, h = s[3] * k, s[4] * k
		local f = create("Frame", {
			Name = "p" .. i,
			BackgroundColor3 = color,
			BorderSizePixel = 0,
			Size = UDim2.fromOffset(w, h),
			Position = UDim2.fromOffset(s[1] * k - w / 2, s[2] * k - h / 2),
			Rotation = s[5] or 0,
			ZIndex = props.ZIndex or 5,
			Parent = box,
		})
		if s[6] == 1 then
			corner(f, math.min(w, h) / 2)
		else
			corner(f, props.Radius or 1.5)
		end
		box[i] = f
	end
	return box
end

local function tint(ic, color)
	if not ic then return end
	for _, c in ipairs(ic:GetChildren()) do
		if c:IsA("Frame") then c.BackgroundColor3 = color end
	end
end

--==============================================================================
-- 遥测采样（FPS / Ping）
--==============================================================================
local Telemetry = {
	Fps = 60, Ping = 0,
	FpsHist = {}, PingHist = {},
	Listeners = {},
	_frames = 0, _acc = 0, _pingT = 0,
}

local function push(list, v, cap)
	list[#list + 1] = v
	while #list > (cap or 48) do table.remove(list, 1) end
end

for i = 1, 48 do
	Telemetry.FpsHist[i] = 60
	Telemetry.PingHist[i] = 0
end

RunService.RenderStepped:Connect(function(dt)
	Telemetry._frames = Telemetry._frames + 1
	Telemetry._acc = Telemetry._acc + dt
	if Telemetry._acc >= 0.5 then
		Telemetry.Fps = Telemetry._frames / Telemetry._acc
		Telemetry._frames = 0
		Telemetry._acc = 0
		push(Telemetry.FpsHist, Telemetry.Fps)
		Telemetry._pingT = Telemetry._pingT + 1
		if Telemetry._pingT >= 2 then
			Telemetry._pingT = 0
			local ok, v = pcall(function()
				return Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
			end)
			if ok and type(v) == "number" then
				Telemetry.Ping = v
				push(Telemetry.PingHist, v)
			end
		end
		for i = 1, #Telemetry.Listeners do
			pcall(Telemetry.Listeners[i], Telemetry.Fps, Telemetry.Ping)
		end
	end
end)

--==============================================================================
-- 视觉零件
--==============================================================================

-- 四角卡尺（HUD 准星角）
local function brackets(parent, color, size, inset, thick, z)
	size, inset, thick = size or 12, inset or 6, thick or 1.5
	local holder = create("Frame", {
		Name = "Brackets", BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1), ZIndex = z or 4, Parent = parent,
	})
	local function L(x, y, ax, ay)
		local h = create("Frame", {
			BackgroundColor3 = color, BorderSizePixel = 0,
			Size = UDim2.fromOffset(size, thick),
			Position = UDim2.new(x, ax * -size, y, ay * -size),
			AnchorPoint = Vector2.new(x, y),
			ZIndex = z or 4, Parent = holder,
		})
		local v = create("Frame", {
			BackgroundColor3 = color, BorderSizePixel = 0,
			Size = UDim2.fromOffset(thick, size),
			Position = UDim2.new(x, ax * -size, y, ay * -size),
			AnchorPoint = Vector2.new(x, y),
			ZIndex = z or 4, Parent = holder,
		})
		local px = (x == 0) and -inset or inset
		local py = (y == 0) and -inset or inset
		h.Position = UDim2.new(x, px, y, py + (py > 0 and -thick or 0))
		v.Position = UDim2.new(x, px + (px > 0 and -thick or 0), y, py)
		return h, v
	end
	local a1 = L(0, 0, -1, -1)
	local a2 = L(1, 0, 1, -1)
	local a3 = L(0, 1, -1, 1)
	local a4 = L(1, 1, 1, 1)
	holder.Corner = { a1, a2, a3, a4 }
	return holder
end

-- 扫描线：一道横光自上而下循环扫过
local function scanline(parent, color, height, z, speed)
	local line = create("Frame", {
		Name = "Scan", BackgroundColor3 = color, BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, height or 90),
		Position = UDim2.new(0, 0, 0, 0),
		BackgroundTransparency = 0.94,
		ZIndex = z or 6, Parent = parent,
	})
	local g = create("UIGradient", { Parent = line })
	g.Rotation = 90
	g.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.5, 0.55),
		NumberSequenceKeypoint.new(1, 1),
	})
	g.Color = ColorSequence.new(color)
	local tw = TweenService:Create(line, TweenInfo.new(speed or 5.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {
		Position = UDim2.fromScale(0, 1),
	})
	local tw2 = TweenService:Create(line, TweenInfo.new(speed or 5.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {
		Position = UDim2.fromScale(0, -0.05),
	})
	tw:Play()
	return line, g
end

-- 网格底纹
local function gridPattern(parent, color, gap, z)
	gap = gap or 34
	local holder = create("Frame", {
		Name = "Grid", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1),
		ZIndex = z or 3, Parent = parent,
	})
	for i = 1, 40 do
		create("Frame", {
			BackgroundColor3 = color, BorderSizePixel = 0,
			BackgroundTransparency = 0.965,
			Size = UDim2.new(0, 1, 1, 0), Position = UDim2.fromOffset(i * gap, 0),
			ZIndex = z or 3, Parent = holder,
		})
	end
	for i = 1, 30 do
		create("Frame", {
			BackgroundColor3 = color, BorderSizePixel = 0,
			BackgroundTransparency = 0.965,
			Size = UDim2.new(1, 0, 0, 1), Position = UDim2.fromOffset(0, i * gap),
			ZIndex = z or 3, Parent = holder,
		})
	end
	return holder
end

-- 信号条（按 ping 实时着色）
local function signalBars(parent, w, h)
	local holder = create("Frame", {
		Name = "Signal", BackgroundTransparency = 1,
		Size = UDim2.fromOffset(w or 22, h or 14), Parent = parent,
	})
	local bars = {}
	for i = 1, 4 do
		local bh = (h or 14) * (0.34 + 0.22 * i)
		local b = create("Frame", {
			BackgroundColor3 = Aether.Theme.Accent, BorderSizePixel = 0,
			Size = UDim2.new(0, (w or 22) / 4 - 2, 0, bh),
			Position = UDim2.new(0, (i - 1) * ((w or 22) / 4), 1, 0),
			AnchorPoint = Vector2.new(0, 1),
			ZIndex = 22, Parent = holder,
		})
		corner(b, 1)
		bars[i] = b
	end
	local obj = {
		Holder = holder,
		Set = function(ping)
			local level = 4
			if ping > 220 then level = 1
			elseif ping > 140 then level = 2
			elseif ping > 70 then level = 3 end
			local col = Aether.Theme.Ok
			if level <= 1 then col = Aether.Theme.Bad
			elseif level == 2 then col = Aether.Theme.Warn end
			if level >= 3 then col = Aether.Theme.Accent end
			for i = 1, 4 do
				local on = i <= level
				tween(bars[i], {
					BackgroundColor3 = on and col or Aether.Theme.Stroke,
					BackgroundTransparency = on and 0.1 or 0.75,
				}, 0.3)
			end
		end,
	}
	obj.Set(Telemetry.Ping)
	return obj
end

-- 迷你折线（柱状）图
local function sparkline(parent, w, h, color, cap)
	cap = cap or 34
	local host = create("Frame", {
		Name = "Spark", BackgroundTransparency = 1,
		Size = UDim2.fromOffset(w, h), Parent = parent,
	})
	local gapv = 1.5
	local bw = (w - gapv * (cap - 1)) / cap
	if bw < 1 then bw = 1 end
	local bars = {}
	for i = 1, cap do
		local b = create("Frame", {
			BackgroundColor3 = color, BorderSizePixel = 0,
			BackgroundTransparency = 0.25,
			Size = UDim2.new(0, bw, 0, 1),
			Position = UDim2.new(0, (i - 1) * (bw + gapv), 1, 0),
			AnchorPoint = Vector2.new(0, 1),
			ZIndex = 22, Parent = host,
		})
		corner(b, bw / 2)
		bars[i] = b
	end
	local data = {}
	for i = 1, cap do data[i] = 0 end
	local obj = { Host = host }

	local function render()
		local lo, hi = math.huge, -math.huge
		for i = 1, cap do
			local v = data[i]
			if v < lo then lo = v end
			if v > hi then hi = v end
		end
		if hi - lo < 0.001 then hi = lo + 1 end
		for i = 1, cap do
			local t = (data[i] - lo) / (hi - lo)
			bars[i].Size = UDim2.new(0, bw, 0, math.max(1, t * h))
		end
	end

	function obj:Push(v)
		for i = 1, cap - 1 do data[i] = data[i + 1] end
		data[cap] = v
		render()
	end
	function obj:Fill(v)
		for i = 1, cap do data[i] = v end
		render()
	end
	return obj
end

--==============================================================================
-- 提示气泡
--==============================================================================
local function showTip(lib, text, pos, accent)
	local layer = lib.Layers.Tip
	if not layer then return end
	layer.Visible = true
	local tip = layer:FindFirstChild("Tip")
	if not tip then
		tip = create("Frame", {
			Name = "Tip", BackgroundColor3 = Aether.Theme.Panel,
			BackgroundTransparency = 0.02,
			Size = UDim2.fromOffset(10, 24),
			AutomaticSize = Enum.AutomaticSize.X,
			BorderSizePixel = 0, ZIndex = 5, Parent = layer,
		})
		corner(tip, 7)
		stroke(tip, Aether.Theme.Accent, 1, 0.6)
		padding(tip, 5, 5, 9, 9)
		create("TextLabel", {
			Name = "T", BackgroundTransparency = 1, Text = "",
			Font = Enum.Font.GothamMedium, TextSize = 11.5,
			TextColor3 = Aether.Theme.Text,
			Size = UDim2.new(1, 0, 0, 24), Parent = tip,
		})
	end
	tip.TextLabel.Text = tostring(text)
	tip.TextLabel.TextColor3 = Aether.Theme.Text
	local p = pos or cursorPos()
	tip.Position = UDim2.fromOffset(p.X + 14, p.Y + 16)
end

local function hideTip(lib)
	local layer = lib.Layers.Tip
	if layer then layer.Visible = false end
end

local function attachTip(lib, inst, text, accent)
	local token = 0
	inst.MouseEnter:Connect(function()
		token = token + 1
		local my = token
		task.delay(0.32, function()
			if my == token and inst.Parent then showTip(lib, text, nil, accent) end
		end)
	end)
	inst.MouseLeave:Connect(function()
		token = token + 1
		hideTip(lib)
	end)
end

--==============================================================================
-- 通知（右下角堆叠）
--==============================================================================
local function notify(lib, cfg)
	cfg = cfg or {}
	local layer = lib.Layers.Toast
	if not layer then return end
	local accent = cfg.Color or (cfg.Kind == "bad" and Aether.Theme.Bad) or (cfg.Kind == "warn" and Aether.Theme.Warn) or Aether.Theme.Accent
	local card = create("Frame", {
		Name = "Toast", BackgroundColor3 = Aether.Theme.Panel,
		BackgroundTransparency = 0.02,
		Size = UDim2.fromOffset(312, 62),
		Position = UDim2.new(1, 340, 1, -14),
		BorderSizePixel = 0, ZIndex = 5, Parent = layer,
	})
	corner(card, 12)
	stroke(card, Aether.Theme.Stroke, 1, 0.72)
	create("Frame", {
		Name = "Bar", BackgroundColor3 = accent, BorderSizePixel = 0,
		Size = UDim2.new(0, 3, 1, -18), Position = UDim2.fromOffset(0, 9),
		ZIndex = 6, Parent = card,
	})
	corner(card:FindFirstChild("Bar"), 2)
	local ic = icon(card, cfg.Icon or "scan", 16, accent, {
		Position = UDim2.fromOffset(18, 22), AnchorPoint = Vector2.new(0, 0.5), ZIndex = 7,
	})
	create("TextLabel", {
		Name = "T", BackgroundTransparency = 1, Text = tostring(cfg.Title or "AETHER"),
		Font = Enum.Font.GothamBold, TextSize = 12.5, TextColor3 = Aether.Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
		Size = UDim2.new(1, -74, 0, 15), Position = UDim2.fromOffset(42, 13),
		ZIndex = 7, Parent = card,
	})
	create("TextLabel", {
		Name = "D", BackgroundTransparency = 1, Text = tostring(cfg.Desc or ""),
		Font = Enum.Font.Gotham, TextSize = 10.5, TextColor3 = Aether.Theme.Muted,
		TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
		Size = UDim2.new(1, -74, 0, 14), Position = UDim2.fromOffset(42, 30),
		ZIndex = 7, Parent = card,
	})
	local prog = create("Frame", {
		Name = "Prog", BackgroundColor3 = accent, BorderSizePixel = 0,
		BackgroundTransparency = 0.4,
		Size = UDim2.new(0, 0, 0, 2), Position = UDim2.fromOffset(12, 57),
		ZIndex = 7, Parent = card,
	})
	corner(prog, 1)

	local dur = cfg.Duration or 4.2
	local idx = #lib.Toasts + 1
	lib.Toasts[idx] = card

	local function relayout()
		local n = 0
		for i = 1, #lib.Toasts do
			local c = lib.Toasts[i]
			if c and c.Parent then
				tween(c, { Position = UDim2.new(1, -14, 1, -14 - n * 72) }, 0.3, Enum.EasingStyle.Quint)
				n = n + 1
			end
		end
	end

	card.Position = UDim2.new(1, 340, 1, -14 - (#lib.Toasts - 1) * 72)
	relayout()
	tween(prog, { Size = UDim2.new(1, -24, 0, 2) }, dur, Enum.EasingStyle.Linear)

	local closed = false
	local function dismiss()
		if closed then return end
		closed = true
		for i = 1, #lib.Toasts do
			if lib.Toasts[i] == card then table.remove(lib.Toasts, i) break end
		end
		tween(card, { Position = UDim2.new(1, 340, card.Position.Y.Scale, card.Position.Y.Offset), BackgroundTransparency = 1 }, 0.28)
		task.delay(0.32, function() pcall(function() card:Destroy() end) end)
		relayout()
	end

	local btn = create("TextButton", {
		Text = "", BackgroundTransparency = 1, AutoButtonColor = false,
		Size = UDim2.fromScale(1, 1), ZIndex = 8, Parent = card,
	})
	btn.MouseButton1Click:Connect(dismiss)
	task.delay(dur, dismiss)
	return dismiss
end

--==============================================================================
-- 右键菜单
--==============================================================================
local function contextMenu(lib, x, y, items)
	local layer = lib.Layers.Overlay
	if not layer then return end
	local old = layer:FindFirstChild("Ctx")
	if old then old:Destroy() end

	local back = create("TextButton", {
		Name = "CtxBack", Text = "", AutoButtonColor = false,
		BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.55,
		Size = UDim2.fromScale(1, 1), ZIndex = 4, Parent = layer,
	})
	local panel = create("Frame", {
		Name = "Ctx", BackgroundColor3 = Aether.Theme.Panel,
		BackgroundTransparency = 0.02, BorderSizePixel = 0,
		Size = UDim2.fromOffset(196, 0), AutomaticSize = Enum.AutomaticSize.Y,
		Position = UDim2.fromOffset(x, y), ZIndex = 5, Parent = layer,
	})
	corner(panel, 11)
	stroke(panel, Aether.Theme.Accent, 1, 0.66)
	padding(panel, 6, 6, 6, 6)
	list(panel, Enum.FillDirection.Vertical, 3)
	brackets(panel, Aether.Theme.Accent, 8, 5, 1.4, 6)

	local total = 0
	for i = 1, #items do
		local it = items[i]
		local rowBtn = create("TextButton", {
			Text = "", AutoButtonColor = false, BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 28), ZIndex = 7, Parent = panel,
		})
		order(rowBtn, i)
		corner(rowBtn, 7)
		local col = it.Danger and Aether.Theme.Bad or Aether.Theme.Text
		local ic = icon(rowBtn, it.Icon or "dot", 13, it.Danger and Aether.Theme.Bad or Aether.Theme.Muted, {
			Position = UDim2.fromOffset(12, 14), AnchorPoint = Vector2.new(0, 0.5), ZIndex = 8,
		})
		local lb = create("TextLabel", {
			BackgroundTransparency = 1, Text = tostring(it.Label or ""),
			Font = Enum.Font.GothamMedium, TextSize = 11.5, TextColor3 = col,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, -40, 1, 0), Position = UDim2.fromOffset(30, 0),
			ZIndex = 8, Parent = rowBtn,
		})
		local hint
		if it.Hint then
			hint = create("TextLabel", {
				BackgroundTransparency = 1, Text = tostring(it.Hint),
				Font = Enum.Font.Code, TextSize = 10, TextColor3 = Aether.Theme.Muted,
				TextXAlignment = Enum.TextXAlignment.Right,
				Size = UDim2.new(1, -50, 1, 0), Position = UDim2.fromOffset(0, 0),
				ZIndex = 8, Parent = rowBtn,
			})
		end
		rowBtn.MouseEnter:Connect(function()
			tween(rowBtn, { BackgroundTransparency = 0.9, BackgroundColor3 = Aether.Theme.Accent }, 0.14)
			tint(ic, Aether.Theme.Accent)
			lb.TextColor3 = Aether.Theme.Accent
		end)
		rowBtn.MouseLeave:Connect(function()
			tween(rowBtn, { BackgroundTransparency = 1 }, 0.14)
			tint(ic, it.Danger and Aether.Theme.Bad or Aether.Theme.Muted)
			lb.TextColor3 = col
		end)
		rowBtn.MouseButton1Click:Connect(function()
			pcall(function() back:Destroy() end)
			pcall(function() panel:Destroy() end)
			if it.OnClick then pcall(it.OnClick) end
		end)
		total = total + 31
	end
	back.MouseButton1Click:Connect(function()
		pcall(function() back:Destroy() end)
		pcall(function() panel:Destroy() end)
	end)

	local vp = Camera and Camera.ViewportSize or Vector2.new(1280, 720)
	local ph = total + 16
	panel.Position = UDim2.fromOffset(
		clamp(x, 8, vp.X - 212),
		clamp(y, 8, vp.Y - ph - 8)
	)
	return panel
end

--==============================================================================
-- 卡片（Section）与控件
--==============================================================================
local Section = {}
Section.__index = Section

function Section.new(lib, cfg)
	local self = setmetatable({}, Section)
	self.Library = lib
	self.Cfg = cfg or {}
	self.Items = {}
	self.Rows = {}
	self._n = 0
	self:_Build()
	return self
end

function Section:Refresh()
	local on, total = 0, 0
	for i = 1, #self.Items do
		local it = self.Items[i]
		if it.Active then
			total = total + 1
			if it.Active() then on = on + 1 end
		end
	end
	if self.Count then
		self.Count.Text = string.format("%d/%d", on, total)
		self.Count.TextColor3 = on > 0 and Aether.Theme.Accent or Aether.Theme.Muted
	end
end

function Section:_Build()
	local lib, T = self.Library, Aether.Theme
	local cfg = self.Cfg

	local card = create("Frame", {
		Name = "Section", BackgroundColor3 = T.Card, BackgroundTransparency = 0.04,
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		BorderSizePixel = 0, ZIndex = 12, Parent = cfg.Parent,
	})
	corner(card, 14)
	local st = stroke(card, T.Stroke, 1, 0.78)
	tb(st, "Color", "Stroke")
	brackets(card, T.Accent, 10, 6, 1.4, 13)
	list(card, Enum.FillDirection.Vertical, 0)
	self.Card = card

	local glow = create("Frame", {
		Name = "Glow", BackgroundColor3 = T.Accent, BorderSizePixel = 0,
		BackgroundTransparency = 0.3,
		Size = UDim2.new(1, -32, 0, 1), Position = UDim2.fromOffset(16, 0),
		ZIndex = 14, Parent = card,
	})
	local gg = gradient(glow, T.Accent, T.Accent2, 0)
	gg.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.5, 0.25),
		NumberSequenceKeypoint.new(1, 1),
	})

	-- 头部
	local head = create("TextButton", {
		Name = "Head", Text = "", AutoButtonColor = false,
		BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 44),
		ZIndex = 15, Parent = card,
	})
	order(head, 1)
	self.Head = head

	local chip = create("Frame", {
		Name = "Chip", BackgroundColor3 = T.Accent, BackgroundTransparency = 0.9,
		Size = UDim2.fromOffset(20, 20), Position = UDim2.fromOffset(14, 12),
		BorderSizePixel = 0, ZIndex = 16, Parent = head,
	})
	corner(chip, 6)
	local cstroke = stroke(chip, T.Accent, 1, 0.5)
	tb(cstroke, "Color", "Accent")
	local dot = icon(chip, cfg.Icon or "dot", 11, T.Accent, { ZIndex = 17 })
	self.ChipIcon = dot

	local title = create("TextLabel", {
		Name = "Title", BackgroundTransparency = 1, Text = tostring(cfg.Title or "SECTION"),
		Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = T.Text,
		TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
		Size = UDim2.new(1, -160, 0, 16), Position = UDim2.fromOffset(44, cfg.Desc and 7 or 14),
		ZIndex = 16, Parent = head,
	})
	tb(title, "TextColor3", "Text")
	self.Title = title
	scramble(title, cfg.Title or "SECTION", 0.5)

	if cfg.Desc then
		local sub = create("TextLabel", {
			Name = "Desc", BackgroundTransparency = 1, Text = tostring(cfg.Desc),
			Font = Enum.Font.Gotham, TextSize = 10.5, TextColor3 = T.Muted,
			TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
			Size = UDim2.new(1, -160, 0, 13), Position = UDim2.fromOffset(44, 23),
			ZIndex = 16, Parent = head,
		})
		tb(sub, "TextColor3", "Muted")
	end

	local count = create("TextLabel", {
		Name = "Count", BackgroundTransparency = 1, Text = "0/0",
		Font = Enum.Font.Code, TextSize = 10.5, TextColor3 = T.Muted,
		TextXAlignment = Enum.TextXAlignment.Right,
		Size = UDim2.fromOffset(58, 16), Position = UDim2.new(1, -54, 0, 14),
		ZIndex = 16, Parent = head,
	})
	self.Count = count

	local chev = icon(head, "down", 12, T.Muted, {
		Position = UDim2.new(1, -22, 0, 22), AnchorPoint = Vector2.new(1, 0.5), ZIndex = 17,
	})

	-- 折叠容器
	local clip = create("Frame", {
		Name = "Clip", BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0), ClipsDescendants = true,
		ZIndex = 13, Parent = card,
	})
	order(clip, 2)
	local body = create("Frame", {
		Name = "Body", BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		ZIndex = 13, Parent = clip,
	})
	padding(body, 2, 10, 12, 12)
	list(body, Enum.FillDirection.Vertical, 0)
	self.Body = body
	self.Clip = clip
	self.Chev = chev

	self.Collapsed = cfg.Collapsed == true
	if self.Collapsed then
		clip.Size = UDim2.new(1, 0, 0, 0)
		chev.Rotation = -90
	end

	local syncing = false
	body:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		if syncing or self.Collapsed then return end
		syncing = true
		clip.Size = UDim2.new(1, 0, 0, body.AbsoluteSize.Y)
		syncing = false
	end)

	local function toggle()
		self.Collapsed = not self.Collapsed
		local h = body.AbsoluteSize.Y
		if self.Collapsed then
			tween(clip, { Size = UDim2.new(1, 0, 0, 0) }, 0.24, Enum.EasingStyle.Quint)
			tween(chev, { Rotation = -90 }, 0.24, Enum.EasingStyle.Quint)
		else
			clip.Size = UDim2.new(1, 0, 0, h)
			clip.Size = UDim2.new(1, 0, 0, 0)
			tween(clip, { Size = UDim2.new(1, 0, 0, h) }, 0.28, Enum.EasingStyle.Quint)
			tween(chev, { Rotation = 0 }, 0.28, Enum.EasingStyle.Quint)
			scramble(title, cfg.Title or "", 0.42)
		end
	end
	head.MouseButton1Click:Connect(toggle)
	head.MouseButton2Click:Connect(function()
		contextMenu(lib, cursorPos().X, cursorPos().Y, {
			{ Label = "折叠 / 展开", Icon = "layers", OnClick = toggle },
			{ Label = "复制卡片标题", Icon = "check", OnClick = function()
				if setclipboard then setclipboard(tostring(cfg.Title)) end
			end },
		})
	end)
	head.MouseEnter:Connect(function()
		tween(chip, { BackgroundTransparency = 0.78 }, 0.16)
	end)
	head.MouseLeave:Connect(function()
		tween(chip, { BackgroundTransparency = 0.9 }, 0.16)
	end)

	task.defer(function() Section.Refresh(self) end)
end

-- 行容器
function Section:_Row(cfg, height, title, desc, reserve)
	cfg = cfg or {}
	local T = Aether.Theme
	self._n = self._n + 1
	local idx = self._n

	local row = create("Frame", {
		Name = "Row", BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, height), ZIndex = 15, Parent = self.Body,
	})
	order(row, idx)
	self.Rows[#self.Rows + 1] = row

	if idx > 1 and not cfg.Bare then
		local dv = create("Frame", {
			Name = "Div", BackgroundColor3 = T.Stroke, BackgroundTransparency = 0.93,
			Size = UDim2.new(1, 0, 0, 1), BorderSizePixel = 0,
			ZIndex = 15, Parent = row,
		})
		tb(dv, "BackgroundColor3", "Stroke")
	end

	local rs = reserve or 176
	if title then
		local tl = create("TextLabel", {
			Name = "T", BackgroundTransparency = 1, Text = tostring(title),
			Font = Enum.Font.GothamMedium, TextSize = 12.5, TextColor3 = T.Text,
			TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
			Size = UDim2.new(1, -rs, 0, 15),
			Position = UDim2.fromOffset(0, desc and 9 or (height - 15) / 2),
			ZIndex = 16, Parent = row,
		})
		tb(tl, "TextColor3", "Text")
	end
	if desc then
		local dl = create("TextLabel", {
			Name = "D", BackgroundTransparency = 1, Text = tostring(desc),
			Font = Enum.Font.Gotham, TextSize = 10.5, TextColor3 = T.Muted,
			TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
			Size = UDim2.new(1, -rs, 0, 13), Position = UDim2.fromOffset(0, 25),
			ZIndex = 16, Parent = row,
		})
		tb(dl, "TextColor3", "Muted")
	end

	row.MouseEnter:Connect(function()
		tween(row, { BackgroundColor3 = Aether.Theme.Accent, BackgroundTransparency = 0.94 }, 0.16)
	end)
	row.MouseLeave:Connect(function()
		tween(row, { BackgroundTransparency = 1 }, 0.16)
	end)

	local entry = { Row = row, Title = string.lower(tostring(title or "")), Desc = string.lower(tostring(desc or "")) }
	return row, entry
end

-- 行被“定位”时的高亮脉冲（指令面板跳转时用）
function Section:Pulse(row)
	if not row then return end
	local hl = create("Frame", {
		Name = "Pulse", BackgroundColor3 = Aether.Theme.Accent,
		BackgroundTransparency = 0.6, BorderSizePixel = 0,
		Size = UDim2.new(1, 12, 1, 0), Position = UDim2.fromOffset(-6, 0),
		ZIndex = 14, Parent = row,
	})
	corner(hl, 8)
	tween(hl, { BackgroundTransparency = 1, Size = UDim2.new(1, 26, 1, 0) }, 0.75, Enum.EasingStyle.Quint)
	task.delay(0.8, function() pcall(function() hl:Destroy() end) end)
end

-- 让控件支持：右键菜单 / 指令面板注册 / 配置保存
function Section:_Wire(item, cfg, kind, api_tbl)
	cfg = cfg or {}
	item.Kind = kind
	item.Config = cfg
	item.Set = api_tbl.Set
	item.Get = api_tbl.Get
	item.Run = api_tbl.Run
	item.OnChange = cfg.Callback
	item.Flag = cfg.Flag
	-- 按键绑定：让“载入配置”也能真正注册热键（原控件仅在被手动录入时才绑定）
	if kind == "keybind" and type(api_tbl.Set) == "function" and type(api_tbl.Get) == "function" then
		local rawSet = api_tbl.Set
		local rebind = function()
			local k = api_tbl.Get()
			if k then
				self.Library:_Bind(k, {}, function()
					if cfg.Callback then task.spawn(cfg.Callback, k) end
				end)
			end
		end
		api_tbl.Set = function(v, fire)
			rawSet(v, false)
			rebind()
			if fire then
				self.Library:_AutoSave()
				if cfg.Callback then task.spawn(cfg.Callback, api_tbl.Get()) end
			end
		end
		item.Set = api_tbl.Set
	end
	if cfg.Flag then
		item.Active = api_tbl.Active
		Aether.Flags[cfg.Flag] = api_tbl.Get and api_tbl.Get()
	end
	self.Items[#self.Items + 1] = item

	if cfg.Flag and api_tbl.Set then
		self.Library._Setters[cfg.Flag] = function(v, fire)
			pcall(function() api_tbl.Set(v, fire) end)
		end
		-- 若本地配置里存过该开关，则在控件注册后回填
		local saved = self.Library._saved
		if saved and saved[cfg.Flag] ~= nil then
			local sv = saved[cfg.Flag]
			task.defer(function()
				pcall(function() api_tbl.Set(sv, false) end)
			end)
		end
	end
	if api_tbl.Command ~= false then
		self.Library:_Register({
			Title = cfg.Title or cfg.Flag or kind,
			Page = self.Cfg.Page,
			Section = self.Cfg.Title,
			Kind = kind,
			Get = api_tbl.Get,
			Set = api_tbl.Set,
			Run = api_tbl.Run,
			Flag = cfg.Flag,
			Row = item.Row,
			SectionRef = self,
		})
	end
	if cfg.RightClick ~= false then
		item.Row.MouseButton2Click:Connect(function()
			contextMenu(self.Library, cursorPos().X, cursorPos().Y, {
				{ Label = "重置为默认", Icon = "power", OnClick = function()
					if api_tbl.Reset then api_tbl.Reset() end
				end },
				{ Label = "复制当前值", Icon = "check", OnClick = function()
					local v = api_tbl.Get and api_tbl.Get()
					if setclipboard then setclipboard(tostring(v)) end
					notify(self.Library, { Title = "已复制", Desc = tostring(v), Icon = "check" })
				end },
				{ Label = "固定到快捷栏", Icon = "bolt", OnClick = function()
					self.Library:Pinned(item)
				end },
			})
		end)
	end
	local function refresh()
		Section.Refresh(self)
		if cfg.Callback then
			task.spawn(cfg.Callback, api_tbl.Get and api_tbl.Get())
		end
	end
	item._Refresh = refresh
	return item
end

--=== 开关 ===
function Section:Toggle(cfg)
	cfg = cfg or {}
	local T = Aether.Theme
	local row, entry = self:_Row(cfg, 46, cfg.Title, cfg.Desc, 74)
	local on = cfg.Default == true

	local sw = create("TextButton", {
		Name = "Sw", Text = "", AutoButtonColor = false,
		BackgroundColor3 = T.Element,
		Size = UDim2.fromOffset(44, 24),
		Position = UDim2.new(1, -14, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5),
		ZIndex = 16, Parent = row,
	})
	corner(sw, 12)
	local sst = stroke(sw, T.Stroke, 1, 0.85)
	tb(sst, "Color", "Stroke")
	local grad = gradient(sw, T.Accent, T.Accent2, 0)
	grad.Transparency = NumberSequence.new(1)

	local knob = create("Frame", {
		Name = "Knob", BackgroundColor3 = Color3.fromRGB(238, 242, 250),
		Size = UDim2.fromOffset(18, 18), Position = UDim2.fromOffset(3, 3),
		BorderSizePixel = 0, ZIndex = 17, Parent = sw,
	})
	corner(knob, 9)

	local item = { Row = row, Entry = entry }

	local function paint(animate)
		if animate then
			tween(knob, {
				Position = on and UDim2.fromOffset(23, 3) or UDim2.fromOffset(3, 3),
				BackgroundColor3 = on and T.Ink or Color3.fromRGB(238, 242, 250),
				Size = on and UDim2.fromOffset(16, 16) or UDim2.fromOffset(18, 18),
			}, 0.26, Enum.EasingStyle.Back)
			tween(knob, { Position = on and UDim2.fromOffset(23, 4) or UDim2.fromOffset(3, 3) }, 0.3, Enum.EasingStyle.Quad)
			tween(sw, { BackgroundColor3 = on and T.Accent or T.Element }, 0.22)
			tween(sst, { Transparency = on and 0.25 or 0.85 }, 0.22)
		else
			knob.Position = on and UDim2.fromOffset(23, 4) or UDim2.fromOffset(3, 3)
			knob.BackgroundColor3 = on and T.Ink or Color3.fromRGB(238, 242, 250)
			sw.BackgroundColor3 = on and T.Accent or T.Element
			sst.Transparency = on and 0.25 or 0.85
		end
		grad.Transparency = NumberSequence.new(on and 0 or 1)
	end
	paint(false)

	function item:Set(v, fire)
		on = v and true or false
		paint(true)
		if cfg.Flag then Aether.Flags[cfg.Flag] = on end
		Section.Refresh(self)
		if fire then
			self.Library:_AutoSave()
			if cfg.Callback then task.spawn(cfg.Callback, on) end
		end
	end
	function item:Get() return on end

	sw.MouseButton1Click:Connect(function()
		item:Set(not on, true)
		self:Pulse(row)
	end)
	sw.MouseEnter:Connect(function() tween(sw, { BackgroundTransparency = 0 }, 0.15) end)

	self:_Wire(item, cfg, "toggle", {
		Set = item.Set, Get = item.Get,
		Run = function() item:Set(not on, true) end,
		Reset = function() item:Set(cfg.Default == true, true) end,
		Active = function() return on end,
	})
	return item
end

--=== 滑条 ===
function Section:Slider(cfg)
	cfg = cfg or {}
	local T = Aether.Theme
	local min = cfg.Min or 0
	local max = cfg.Max or 100
	local step = cfg.Step or 1
	local val = clamp(cfg.Default or min, min, max)

	local row, entry = self:_Row(cfg, 46, cfg.Title, cfg.Desc, 210)

	local valLb = create("TextLabel", {
		Name = "Val", BackgroundTransparency = 1,
		Text = (cfg.Format and cfg.Format(val)) or (fmtNum(val, step) .. (cfg.Suffix or "")),
		Font = Enum.Font.GothamMedium, TextSize = 12, TextColor3 = T.Accent,
		TextXAlignment = Enum.TextXAlignment.Right,
		Size = UDim2.fromOffset(52, 18), Position = UDim2.new(1, -14, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5), ZIndex = 16, Parent = row,
	})
	tb(valLb, "TextColor3", "Accent")

	local host = create("Frame", {
		Name = "Host", BackgroundTransparency = 1,
		Size = UDim2.fromOffset(128, 30),
		Position = UDim2.new(1, -72, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5),
		ZIndex = 16, Parent = row,
	})

	local track = create("Frame", {
		Name = "Track", BackgroundColor3 = T.Element, BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 6), Position = UDim2.new(0, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5), ZIndex = 17, Parent = host,
	})
	corner(track, 3)
	local tst = stroke(track, T.Stroke, 1, 0.86)
	tb(tst, "Color", "Stroke")

	local fill = create("Frame", {
		Name = "Fill", BackgroundColor3 = T.Accent, BorderSizePixel = 0,
		Size = UDim2.new(0, 0, 0, 6), Position = UDim2.new(0, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5), ZIndex = 18, Parent = host,
	})
	corner(fill, 3)
	local fg = gradient(fill, T.Accent, T.Accent2, 0)
	Aether.Theme._fillGrad = fg

	local ticks = create("Frame", {
		Name = "Ticks", BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 6), Position = UDim2.new(0, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5), ZIndex = 19, Parent = host,
	})
	local n = math.floor((max - min) / step)
	if n >= 2 and n <= 14 then
		for i = 1, n do
			local fr = i / n
			create("Frame", {
				BackgroundColor3 = T.Ink, BackgroundTransparency = 0.55,
				BorderSizePixel = 0, Size = UDim2.new(0, 1, 1, 0),
				Position = UDim2.new(fr, -0.5, 0, 0), ZIndex = 19, Parent = ticks,
			})
		end
	end

	local handle = create("Frame", {
		Name = "Handle", BackgroundColor3 = T.Text, BorderSizePixel = 0,
		Size = UDim2.fromOffset(9, 18), Position = UDim2.new(0, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5), ZIndex = 20, Parent = host,
	})
	corner(handle, 4)
	local hst = stroke(handle, T.Accent, 1.4, 0.1)
	tb(hst, "Color", "Accent")
	tb(handle, "BackgroundColor3", "Text")

	local bubble = create("Frame", {
		Name = "Bubble", BackgroundColor3 = T.Accent, BorderSizePixel = 0,
		Size = UDim2.fromOffset(46, 20), Position = UDim2.new(0, 0, 0, -14),
		AnchorPoint = Vector2.new(0.5, 1), ZIndex = 22, Visible = false, Parent = host,
	})
	corner(bubble, 6)
	create("TextLabel", {
		Name = "B", BackgroundTransparency = 1, Text = "",
		Font = Enum.Font.GothamBold, TextSize = 11, TextColor3 = T.Ink,
		Size = UDim2.fromScale(1, 1), ZIndex = 23, Parent = bubble,
	})

	local item = { Row = row, Entry = entry }
	local dragging = false

	local function paint(animate)
		local t = (val - min) / (max - min)
		if t ~= t then t = 0 end
		t = clamp(t, 0, 1)
		local target = UDim2.new(t, 0, 0, 6)
		local hp = UDim2.new(t, 0, 0.5, 0)
		if animate then
			tween(fill, { Size = target }, 0.16, Enum.EasingStyle.Quart)
			tween(handle, { Position = hp }, 0.16, Enum.EasingStyle.Quart)
		else
			fill.Size = target
			handle.Position = hp
		end
		local txt = (cfg.Format and cfg.Format(val)) or (fmtNum(val, step) .. (cfg.Suffix or ""))
		valLb.Text = txt
		bubble.B.Text = txt
		bubble.Position = UDim2.new(t, 0, 0, -14)
	end
	paint(false)

	local function apply(fromX)
		local abs = host.AbsolutePosition
		local w = host.AbsoluteSize.X
		if w <= 0 then return end
		local t = clamp((fromX - abs.X) / w, 0, 1)
		local nv = round(min + t * (max - min), step)
		nv = clamp(nv, min, max)
		if nv ~= val then
			val = nv
			paint(true)
			if cfg.Flag then Aether.Flags[cfg.Flag] = val end
		end
	end

	local function finish(fire)
		if not dragging then return end
		dragging = false
		tween(bubble, { BackgroundTransparency = 1 }, 0.2)
		tween(handle, { Size = UDim2.fromOffset(9, 18) }, 0.2, Enum.EasingStyle.Back)
		task.delay(0.22, function() bubble.Visible = false end)
		Section.Refresh(self)
		if fire then
			self.Library:_AutoSave()
			if cfg.Callback then task.spawn(cfg.Callback, val) end
		end
	end

	host.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			bubble.Visible = true
			tween(bubble, { BackgroundTransparency = 0 }, 0.15)
			tween(handle, { Size = UDim2.fromOffset(11, 22) }, 0.18, Enum.EasingStyle.Back)
			apply(input.Position.X)
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if not dragging then return end
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			apply(input.Position.X)
		end
	end)
	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			finish(true)
		end
	end)

	local hovering = false
	host.MouseEnter:Connect(function() hovering = true end)
	host.MouseLeave:Connect(function() hovering = false end)
	UIS.InputChanged:Connect(function(input)
		if not hovering or dragging then return end
		if input.UserInputType == Enum.UserInputType.MouseWheel then
			val = clamp(round(val + input.Position.Z * step, step), min, max)
			paint(true)
			if cfg.Flag then Aether.Flags[cfg.Flag] = val end
			self.Library:_AutoSave()
			if cfg.Callback then task.spawn(cfg.Callback, val) end
			Section.Refresh(self)
		end
	end)

	function item:Set(v, fire)
		val = clamp(round(tonumber(v) or min, step), min, max)
		paint(true)
		if cfg.Flag then Aether.Flags[cfg.Flag] = val end
		Section.Refresh(self)
		if fire then
			if cfg.Callback then task.spawn(cfg.Callback, val) end
		end
	end
	function item:Get() return val end

	self:_Wire(item, cfg, "slider", {
		Set = item.Set, Get = item.Get,
		Run = function() end,
		Reset = function() item:Set(cfg.Default or min, true) end,
		Active = function() return val ~= (cfg.Default or min) end,
	})
	return item
end

--=== 分段选择 ===
function Section:Segmented(cfg)
	cfg = cfg or {}
	local T = Aether.Theme
	local opts = cfg.Options or { "A", "B" }
	local idx = cfg.Default or 1
	local w = math.max(160, #opts * 62 + 8)
	local row, entry = self:_Row(cfg, 46, cfg.Title, cfg.Desc, w + 18)

	local host = create("Frame", {
		Name = "Seg", BackgroundColor3 = T.Element, BorderSizePixel = 0,
		Size = UDim2.fromOffset(w, 28), Position = UDim2.new(1, -14, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5), ZIndex = 16, Parent = row,
	})
	corner(host, 9)
	local hst = stroke(host, T.Stroke, 1, 0.88)
	tb(hst, "Color", "Stroke")

	local hl = create("Frame", {
		Name = "HL", BackgroundColor3 = T.Accent, BorderSizePixel = 0,
		Size = UDim2.new(1 / #opts, -4, 1, -4), Position = UDim2.fromOffset(2, 2),
		ZIndex = 17, Parent = host,
	})
	corner(hl, 7)

	local labels = {}
	for i = 1, #opts do
		local lb = create("TextButton", {
			Name = "O" .. i, Text = "", AutoButtonColor = false, BackgroundTransparency = 1,
			Size = UDim2.new(1 / #opts, 0, 1, 0), Position = UDim2.new((i - 1) / #opts, 0, 0, 0),
			ZIndex = 18, Parent = host,
		})
		local t = create("TextLabel", {
			BackgroundTransparency = 1, Text = tostring(opts[i]),
			Font = Enum.Font.GothamMedium, TextSize = 11.5, TextColor3 = T.Muted,
			Size = UDim2.fromScale(1, 1), ZIndex = 19, Parent = lb,
		})
		labels[i] = t
		lb.MouseButton1Click:Connect(function()
			if idx == i then return end
			idx = i
			local item = self.Items[#self.Items]
			item:Set(idx, true)
			self:Pulse(row)
		end)
	end

	local item = { Row = row, Entry = entry }

	local function paint(animate)
		local pos = UDim2.new((idx - 1) / #opts, 2, 0, 2)
		local size = UDim2.new(1 / #opts, -4, 1, -4)
		if animate then
			tween(hl, { Position = pos, Size = size }, 0.26, Enum.EasingStyle.Quint)
		else
			hl.Position = pos
			hl.Size = size
		end
		for i = 1, #labels do
			labels[i].TextColor3 = (i == idx) and T.Ink or T.Muted
			labels[i].Font = (i == idx) and Enum.Font.GothamBold or Enum.Font.GothamMedium
		end
	end

	function item:Set(v, fire)
		local n = tonumber(v) or 1
		if type(v) == "string" then
			for i = 1, #opts do
				if tostring(opts[i]) == v then n = i end
			end
		end
		idx = clamp(math.floor(n), 1, #opts)
		paint(true)
		if cfg.Flag then Aether.Flags[cfg.Flag] = opts[idx] end
		Section.Refresh(self)
		if fire then
			self.Library:_AutoSave()
			if cfg.Callback then task.spawn(cfg.Callback, opts[idx], idx) end
		end
	end
	function item:Get() return opts[idx], idx end
	paint(false)

	self:_Wire(item, cfg, "segmented", {
		Set = item.Set, Get = item.Get,
		Run = function() item:Set(idx % #opts + 1, true) end,
		Reset = function() item:Set(cfg.Default or 1, true) end,
		Active = function() return idx ~= (cfg.Default or 1) end,
	})
	return item
end

--=== 下拉 ===
function Section:Dropdown(cfg)
	cfg = cfg or {}
	local T = Aether.Theme
	local items = cfg.Options or {}
	local multi = cfg.Multi == true
	local sel = cfg.Default or (multi and {} or 1)

	local row, entry = self:_Row(cfg, 46, cfg.Title, cfg.Desc, 206)
	local field = create("TextButton", {
		Name = "Field", Text = "", AutoButtonColor = false,
		BackgroundColor3 = T.Element,
		Size = UDim2.fromOffset(178, 28), Position = UDim2.new(1, -14, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5), ZIndex = 16, Parent = row,
	})
	corner(field, 9)
	local fst = stroke(field, T.Stroke, 1, 0.86)
	tb(fst, "Color", "Stroke")
	local lbl = create("TextLabel", {
		BackgroundTransparency = 1, Text = "—",
		Font = Enum.Font.GothamMedium, TextSize = 11.5, TextColor3 = T.Text,
		TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
		Size = UDim2.new(1, -34, 1, 0), Position = UDim2.fromOffset(11, 0),
		ZIndex = 17, Parent = field,
	})
	tb(lbl, "TextColor3", "Text")
	local chev = icon(field, "down", 11, T.Muted, {
		Position = UDim2.new(1, -18, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5), ZIndex = 17,
	})

	local item = { Row = row, Entry = entry }

	local function label()
		if multi then
			local n = 0
			for i = 1, #items do if sel[i] then n = n + 1 end end
			lbl.Text = n == 0 and "未选择" or string.format("%d 项已选", n)
		else
			lbl.Text = tostring(items[sel] or "—")
		end
		if cfg.Flag then
			Aether.Flags[cfg.Flag] = multi and sel or items[sel]
		end
	end
	label()

	local openPop
	field.MouseButton1Click:Connect(function()
		local layer = self.Library.Layers.Pop
		if self.Library._popClose then pcall(self.Library._popClose) end
		if openPop and openPop() then return end

		local h = math.min(#items * 30 + 12, 232)
		local panel = create("Frame", {
			Name = "Drop", BackgroundColor3 = T.Panel, BackgroundTransparency = 0.02,
			Size = UDim2.fromOffset(178, h),
			BorderSizePixel = 0, ZIndex = 4, Parent = layer,
		})
		corner(panel, 10)
		local pst = stroke(panel, T.Accent, 1, 0.68)
		padding(panel, 5, 5, 5, 5)
		local scroll = create("ScrollingFrame", {
			BackgroundTransparency = 1, BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1), CanvasSize = UDim2.fromOffset(0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollingDirection = Enum.ScrollingDirection.Y, ScrollBarThickness = 2,
			ScrollBarImageColor3 = T.Stroke, ScrollBarImageTransparency = 0.4,
			ZIndex = 5, Parent = panel,
		})
		list(scroll, Enum.FillDirection.Vertical, 2)

		local function close()
			pcall(function() panel:Destroy() end)
			pcall(function() self.Library._popBack:Destroy() end)
			self.Library._popClose = nil
		end
		local back = create("TextButton", {
			Text = "", AutoButtonColor = false, BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1), ZIndex = 3, Parent = layer,
		})
		self.Library._popBack = back
		back.MouseButton1Click:Connect(close)
		self.Library._popClose = close
		openPop = function() return panel.Parent ~= nil end

		for i = 1, #items do
			local on = multi and sel[i] or (sel == i)
			local b = create("TextButton", {
				Name = "I" .. i, Text = "", AutoButtonColor = false,
				BackgroundColor3 = T.Accent, BackgroundTransparency = on and 0.88 or 1,
				Size = UDim2.new(1, 0, 0, 28), ZIndex = 6, Parent = scroll,
			})
			order(b, i)
			corner(b, 7)
			local t = create("TextLabel", {
				BackgroundTransparency = 1, Text = tostring(items[i]),
				Font = on and Enum.Font.GothamBold or Enum.Font.GothamMedium,
				TextSize = 11.5, TextColor3 = on and T.Accent or T.Text,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextTruncate = Enum.TextTruncate.AtEnd,
				Size = UDim2.new(1, -30, 1, 0), Position = UDim2.fromOffset(10, 0),
				ZIndex = 7, Parent = b,
			})
			if on then
				icon(b, "check", 12, T.Accent, { Position = UDim2.new(1, -18, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5), ZIndex = 7 })
			end
			b.MouseEnter:Connect(function()
				if not on then tween(b, { BackgroundTransparency = 0.94 }, 0.14) end
			end)
			b.MouseLeave:Connect(function()
				if not on then tween(b, { BackgroundTransparency = 1 }, 0.14) end
			end)
			b.MouseButton1Click:Connect(function()
				if multi then
					sel[i] = not sel[i]
					label()
					if cfg.Callback then task.spawn(cfg.Callback, sel) end
					self.Library:_AutoSave()
					tween(b, { BackgroundTransparency = sel[i] and 0.88 or 1 }, 0.15)
					t.TextColor3 = sel[i] and T.Accent or T.Text
				else
					sel = i
					label()
					close()
					Section.Refresh(self)
					self.Library:_AutoSave()
					if cfg.Callback then task.spawn(cfg.Callback, items[i]) end
					self:Pulse(row)
				end
			end)
		end

		local anchor = field.AbsolutePosition
		local hs = field.AbsoluteSize
		local vp = Camera and Camera.ViewportSize or Vector2.new(1280, 720)
		local y = anchor.Y + hs.Y + 6
		if y + h > vp.Y - 10 then y = anchor.Y - h - 6 end
		panel.Position = UDim2.fromOffset(clamp(anchor.X + hs.X - 178, 8, vp.X - 186), clamp(y, 8, vp.Y - h - 8))
		panel.Size = UDim2.fromOffset(178, 0)
		tween(panel, { Size = UDim2.fromOffset(178, h) }, 0.22, Enum.EasingStyle.Quint)
	end)

	function item:Set(v, fire)
		if multi and type(v) == "table" then
			for i = 1, #items do sel[i] = v[i] end
		else
			sel = tonumber(v) or v
			if type(v) == "string" then
				for i = 1, #items do
					if tostring(items[i]) == v then sel = i end
				end
			end
		end
		label()
		Section.Refresh(self)
		if fire and cfg.Callback then task.spawn(cfg.Callback, self:Get()) end
	end
	function item:Get() return multi and sel or items[sel] end

	self:_Wire(item, cfg, "dropdown", {
		Set = item.Set, Get = item.Get,
		Run = function()
			if multi then return end
			item:Set(sel % #items + 1, true)
		end,
		Reset = function() item:Set(cfg.Default or 1, true) end,
		Active = function() return sel ~= (cfg.Default or 1) end,
	})
	return item
end

--=== 按键绑定 ===
function Section:Keybind(cfg)
	cfg = cfg or {}
	local T = Aether.Theme
	local row, entry = self:_Row(cfg, 46, cfg.Title, cfg.Desc, 146)
	local key = cfg.Default or Enum.KeyCode.RightShift
	local mods = {}

	local btn = create("TextButton", {
		Name = "Key", Text = "", AutoButtonColor = false,
		BackgroundColor3 = T.Element,
		Size = UDim2.fromOffset(118, 28), Position = UDim2.new(1, -14, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5), ZIndex = 16, Parent = row,
	})
	corner(btn, 9)
	local bst = stroke(btn, T.Stroke, 1, 0.86)
	tb(bst, "Color", "Stroke")
	local lbl = create("TextLabel", {
		BackgroundTransparency = 1, Text = "",
		Font = Enum.Font.Code, TextSize = 11.5, TextColor3 = T.Text,
		Size = UDim2.fromScale(1, 1), ZIndex = 17, Parent = btn,
	})
	tb(lbl, "TextColor3", "Text")

	local item = { Row = row, Entry = entry }
	local capturing = false

	local function keyName(k)
		if not k then return "NONE" end
		local s = tostring(k):gsub("Enum.KeyCode.", "")
		return string.upper(s)
	end
	local function label()
		local parts = {}
		for i = 1, #mods do parts[#parts + 1] = string.upper(mods[i]) end
		parts[#parts + 1] = keyName(key)
		lbl.Text = table.concat(parts, "+")
	end
	label()

	local token = 0
	btn.MouseButton1Click:Connect(function()
		if capturing then return end
		capturing = true
		token = token + 1
		local my = token
		lbl.Text = "按下按键…"
		local pulse = tween(bst, { Transparency = 0.2, Thickness = 1.6 }, 0.3, Enum.EasingStyle.Quart)
		local ticks = 0
		local conn
		conn = RunService.Heartbeat:Connect(function()
			if not capturing or my ~= token then
				if conn then conn:Disconnect() end
				return
			end
			ticks = ticks + 1
			if ticks % 22 == 0 then
				bst.Transparency = 0.2
				tween(bst, { Transparency = 0.75 }, 0.4)
			end
		end)
		task.delay(6, function()
			if capturing and my == token then
				capturing = false
				if conn then conn:Disconnect() end
				label()
				bst.Transparency = 0.86
				bst.Thickness = 1
			end
		end)
	end)

	UIS.InputBegan:Connect(function(input, gpe)
		if not capturing then return end
		local k = input.KeyCode
		if k == Enum.KeyCode.Unknown then return end
		if k == Enum.KeyCode.Escape then
			capturing = false
			key = nil
			mods = {}
			label()
			bst.Transparency = 0.86
			bst.Thickness = 1
			return
		end
		if k == Enum.KeyCode.LeftShift or k == Enum.KeyCode.RightShift or k == Enum.KeyCode.LeftControl
			or k == Enum.KeyCode.RightControl or k == Enum.KeyCode.LeftAlt or k == Enum.KeyCode.RightAlt then
			return
		end
		capturing = false
		key = k
		mods = {}
		if UIS:IsKeyDown(Enum.KeyCode.LeftShift) or UIS:IsKeyDown(Enum.KeyCode.RightShift) then mods[#mods + 1] = "shift" end
		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.RightControl) then mods[#mods + 1] = "ctrl" end
		if UIS:IsKeyDown(Enum.KeyCode.LeftAlt) or UIS:IsKeyDown(Enum.KeyCode.RightAlt) then mods[#mods + 1] = "alt" end
		label()
		bst.Transparency = 0.86
		bst.Thickness = 1
		self.Library:_Bind(key, mods, function()
			if cfg.Callback then task.spawn(cfg.Callback, key) end
		end)
		self.Library:_AutoSave()
		self:Pulse(row)
		Section.Refresh(self)
	end)

	function item:Set(v, fire)
		if type(v) == "string" then
			local ok, k = pcall(function()
				return Enum.KeyCode[v:gsub("^Enum.KeyCode.", "")]
			end)
			key = ok and k or nil
		else
			key = v
		end
		label()
		if fire and cfg.Callback then task.spawn(cfg.Callback, key) end
	end
	function item:Get() return key end

	self:_Wire(item, cfg, "keybind", {
		Set = item.Set, Get = item.Get,
		Run = function() end,
		Reset = function() item:Set(cfg.Default, true) end,
		Active = function() return key ~= cfg.Default end,
	})
	return item
end

--=== 输入框 ===
function Section:Input(cfg)
	cfg = cfg or {}
	local T = Aether.Theme
	local row, entry = self:_Row(cfg, 46, cfg.Title, cfg.Desc, 206)
	local box = create("TextBox", {
		Name = "In", BackgroundColor3 = T.Element, BorderSizePixel = 0,
		Text = cfg.Default and tostring(cfg.Default) or "",
		PlaceholderText = cfg.Placeholder or "输入…",
		PlaceholderColor3 = T.Muted,
		Font = Enum.Font.GothamMedium, TextSize = 11.5, TextColor3 = T.Text,
		TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false,
		Size = UDim2.fromOffset(178, 28), Position = UDim2.new(1, -14, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5), ZIndex = 16, Parent = row,
	})
	pcall(function() box.TextEditable = true end)
	padding(box, 0, 0, 11, 11)
	corner(box, 9)
	local bst = stroke(box, T.Stroke, 1, 0.86)
	tb(bst, "Color", "Stroke")
	local tb2 = tb(box, "TextColor3", "Text")

	local item = { Row = row, Entry = entry }

	box.Focused:Connect(function()
		tween(bst, { Transparency = 0.15, Thickness = 1.5, Color = Aether.Theme.Accent }, 0.2)
	end)
	box.FocusLost:Connect(function(enter)
		tween(bst, { Transparency = 0.86, Thickness = 1, Color = Aether.Theme.Stroke }, 0.2)
		if enter and cfg.OnSubmit then task.spawn(cfg.OnSubmit, box.Text) end
		if enter then self.Library:_AutoSave() end
	end)
	box:GetPropertyChangedSignal("Text"):Connect(function()
		if cfg.Numeric then
			local n = tonumber(box.Text)
			if n then
				n = clamp(round(n, cfg.Step or 1), cfg.Min or -math.huge, cfg.Max or math.huge)
				if cfg.Flag then Aether.Flags[cfg.Flag] = n end
				Section.Refresh(self)
			end
		else
			if cfg.Flag then Aether.Flags[cfg.Flag] = box.Text end
		end
		if cfg.Callback then task.spawn(cfg.Callback, box.Text) end
	end)
	box.FocusLost:Connect(function()
		if cfg.Numeric then
			local n = tonumber(box.Text)
			if n then
				n = clamp(round(n, cfg.Step or 1), cfg.Min or -math.huge, cfg.Max or math.huge)
				box.Text = fmtNum(n, cfg.Step)
			end
		end
	end)

	function item:Set(v, fire)
		box.Text = tostring(v or "")
		if fire and cfg.Callback then task.spawn(cfg.Callback, box.Text) end
	end
	function item:Get() return box.Text end

	self:_Wire(item, cfg, "input", {
		Set = item.Set, Get = item.Get,
		Run = function() end,
		Reset = function() item:Set(cfg.Default or "", true) end,
		Active = function() return box.Text ~= tostring(cfg.Default or "") and box.Text ~= "" end,
		Command = false,
	})
	return item
end

--=== 按钮 ===
function Section:Button(cfg)
	cfg = cfg or {}
	local T = Aether.Theme
	local kind = cfg.Variant or "primary"
	local row, entry = self:_Row(cfg, 46, cfg.Title, cfg.Desc, 176)
	local accent = kind == "danger" and T.Bad or (kind == "ghost" and T.Element or T.Accent)
	local ink = kind == "primary" and T.Ink or T.Text

	local btn = create("TextButton", {
		Name = "Btn", Text = "", AutoButtonColor = false,
		BackgroundColor3 = accent,
		BackgroundTransparency = kind == "ghost" and 0.35 or 0,
		Size = UDim2.fromOffset(148, 28), Position = UDim2.new(1, -14, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5), ZIndex = 16, Parent = row,
	})
	corner(btn, 9)
	local bst = stroke(btn, accent, 1, kind == "ghost" and 0.6 or 0.2)
	local lbl = create("TextLabel", {
		BackgroundTransparency = 1, Text = tostring(cfg.Text or cfg.Title or "执行"),
		Font = Enum.Font.GothamBold, TextSize = 11.5, TextColor3 = ink,
		Size = UDim2.fromScale(1, 1), ZIndex = 17, Parent = btn,
	})
	local sheen = create("Frame", {
		Name = "Sheen", BackgroundColor3 = Color3.new(1, 1, 1),
		BackgroundTransparency = 1, BorderSizePixel = 0,
		Size = UDim2.new(0, 26, 1, 0), Position = UDim2.fromOffset(-30, 0),
		ZIndex = 18, Parent = btn,
	})
	local sg = gradient(sheen, Color3.new(1, 1, 1), Color3.new(1, 1, 1), 0)
	sg.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.5, 0.86),
		NumberSequenceKeypoint.new(1, 1),
	})
	pcall(function() sheen.ClipsDescendants = true end)

	local item = { Row = row, Entry = entry }
	btn.MouseButton1Click:Connect(function()
		sheen.Position = UDim2.fromOffset(-30, 0)
		tween(sheen, { Position = UDim2.new(1, 10, 0, 0) }, 0.4, Enum.EasingStyle.Quart)
		tween(btn, { BackgroundTransparency = 0.25 }, 0.08)
		task.delay(0.1, function() tween(btn, { BackgroundTransparency = kind == "ghost" and 0.35 or 0 }, 0.2) end)
		if cfg.OnClick then task.spawn(cfg.OnClick) end
		self:Pulse(row)
	end)
	btn.MouseEnter:Connect(function() tween(btn, { BackgroundTransparency = math.max(0, btn.BackgroundTransparency - 0.12) }, 0.15) end)

	function item:Set() end
	function item:Get() return nil end

	self:_Wire(item, cfg, "button", {
		Set = function() end, Get = function() return nil end,
		Run = function()
			if cfg.OnClick then task.spawn(cfg.OnClick) end
		end,
		Active = nil,
	})
	return item
end

--=== 标签 / 数值 ===
function Section:Label(cfg)
	cfg = cfg or {}
	local T = Aether.Theme
	local row, entry = self:_Row(cfg, cfg.Height or 38, cfg.Title, cfg.Desc, 150)
	local lb = create("TextLabel", {
		Name = "Val", BackgroundTransparency = 1, Text = tostring(cfg.Text or "—"),
		Font = Enum.Font.Code, TextSize = 12, TextColor3 = T.Muted,
		TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtEnd,
		Size = UDim2.new(1, -14 - (cfg.Title and 150 or 0), 1, 0),
		ZIndex = 16, Parent = row,
	})
	if cfg.Title then
		lb.Size = UDim2.new(0, 150, 1, 0)
		lb.Position = UDim2.new(1, -14, 0, 0)
		lb.AnchorPoint = Vector2.new(1, 0)
	end
	tb(lb, "TextColor3", "Muted")

	local item = { Row = row, Entry = entry }
	function item:Set(v) lb.Text = tostring(v) end
	function item:Get() return lb.Text end
	return item
end

--=== 进度条 ===
function Section:Progress(cfg)
	cfg = cfg or {}
	local T = Aether.Theme
	local row, entry = self:_Row(cfg, 42, cfg.Title, cfg.Desc, 200)
	local val = cfg.Default or 0

	local host = create("Frame", {
		Name = "Host", BackgroundTransparency = 1,
		Size = UDim2.fromOffset(126, 8), Position = UDim2.new(1, -70, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5), ZIndex = 16, Parent = row,
	})
	local back = create("Frame", {
		BackgroundColor3 = T.Element, BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1), ZIndex = 17, Parent = host,
	})
	corner(back, 4)
	local brd = stroke(back, T.Stroke, 1, 0.88)
	tb(brd, "Color", "Stroke")
	local fill = create("Frame", {
		BackgroundColor3 = T.Accent, BorderSizePixel = 0,
		Size = UDim2.new(0, 0, 1, 0), ZIndex = 18, Parent = host,
	})
	corner(fill, 4)
	gradient(fill, T.Accent, T.Accent2, 0)

	local pct = create("TextLabel", {
		BackgroundTransparency = 1, Text = "0%",
		Font = Enum.Font.Code, TextSize = 11.5, TextColor3 = T.Accent,
		TextXAlignment = Enum.TextXAlignment.Right,
		Size = UDim2.fromOffset(52, 16), Position = UDim2.new(1, -14, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5), ZIndex = 16, Parent = row,
	})
	tb(pct, "TextColor3", "Accent")

	local item = { Row = row, Entry = entry }
	local sweeping = false
	local sweepConn

	local function stopSweep()
		sweeping = false
		if sweepConn then sweepConn:Disconnect() sweepConn = nil end
	end

	function item:Set(v, fire)
		if v == "sweep" or (type(v) == "string" and v:lower() == "sweep") then
			if sweeping then return end
			sweeping = true
			pct.Text = "···"
			local t = 0
			sweepConn = RunService.Heartbeat:Connect(function(dt)
				if not sweeping then return end
				t = (t + dt * 0.9) % 1
				fill.Size = UDim2.new(0.32, 0, 1, 0)
				fill.Position = UDim2.fromScale(t * 1.3 - 0.3, 0)
			end)
			return
		end
		stopSweep()
		fill.Position = UDim2.fromScale(0, 0)
		val = clamp(tonumber(v) or 0, 0, 1)
		tween(fill, { Size = UDim2.new(val, 0, 1, 0) }, 0.3, Enum.EasingStyle.Quart)
		pct.Text = string.format("%d%%", math.floor(val * 100 + 0.5))
		if fire and cfg.Callback then task.spawn(cfg.Callback, val) end
	end
	function item:Get() return val end
	item:Set(cfg.Default or 0)

	self:_Wire(item, cfg, "progress", {
		Set = item.Set, Get = item.Get,
		Run = function() item:Set("sweep") end,
		Active = nil, Command = false,
	})
	return item
end

--=== 实时曲线 ===
function Section:Graph(cfg)
	cfg = cfg or {}
	local T = Aether.Theme
	local row, entry = self:_Row(cfg, 46, cfg.Title, cfg.Desc, 190)
	local sp = sparkline(row, 126, 30, T.Accent, 30)
	sp.Host.Position = UDim2.new(1, -70, 0.5, 0)
	sp.Host.AnchorPoint = Vector2.new(1, 0.5)
	local box = create("Frame", {
		BackgroundTransparency = 1, Size = UDim2.fromOffset(126, 30),
		Position = UDim2.new(1, -70, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5),
		ZIndex = 20, Parent = row,
	})
	create("Frame", {
		BackgroundColor3 = T.Stroke, BackgroundTransparency = 0.86, BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 1), Position = UDim2.fromScale(0, 0.5), ZIndex = 21, Parent = box,
	})

	local item = { Row = row, Entry = entry }
	local src = cfg.Source
	if src == "fps" or src == "ping" then
		Telemetry.Listeners[#Telemetry.Listeners + 1] = function(fps, ping)
			sp:Push(src == "fps" and fps or ping)
		end
	end

	function item:Push(v) sp:Push(v) end
	function item:Set(v) sp:Fill(v) end
	function item:Get() return nil end

	self:_Wire(item, cfg, "graph", {
		Set = item.Set, Get = item.Get, Run = function() end, Active = nil, Command = false,
	})
	return item
end

--=== 取色器 ===
function Section:ColorPicker(cfg)
	cfg = cfg or {}
	local T = Aether.Theme
	local row, entry = self:_Row(cfg, 46, cfg.Title, cfg.Desc, 190)
	local col = cfg.Default or Color3.fromRGB(0, 226, 255)

	local sw = create("TextButton", {
		Name = "Sw", Text = "", AutoButtonColor = false,
		BackgroundColor3 = col,
		Size = UDim2.fromOffset(126, 28), Position = UDim2.new(1, -14, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5), ZIndex = 16, Parent = row,
	})
	corner(sw, 9)
	local sst = stroke(sw, T.Stroke, 1, 0.7)
	local hexLb = create("TextLabel", {
		BackgroundTransparency = 1, Text = "",
		Font = Enum.Font.Code, TextSize = 11, TextColor3 = Color3.new(1, 1, 1),
		Size = UDim2.fromScale(1, 1), ZIndex = 17, Parent = sw,
	})
	local function hex(c)
		return string.format("#%02X%02X%02X", math.floor(c.R * 255 + 0.5), math.floor(c.G * 255 + 0.5), math.floor(c.B * 255 + 0.5))
	end
	hexLb.Text = hex(col)

	local item = { Row = row, Entry = entry }

	sw.MouseButton1Click:Connect(function()
		local layer = self.Library.Layers.Pop
		local W, H = 190, 236
		local panel = create("Frame", {
			Name = "Picker", BackgroundColor3 = T.Panel, BackgroundTransparency = 0.01,
			Size = UDim2.fromOffset(W, 0), BorderSizePixel = 0, ZIndex = 4, Parent = layer,
		})
		corner(panel, 12)
		stroke(panel, T.Accent, 1, 0.66)
		padding(panel, 10, 10, 10, 10)

		local sv = create("Frame", {
			BackgroundColor3 = col, BorderSizePixel = 0,
			Size = UDim2.fromOffset(W - 20, 112), ZIndex = 6, Parent = panel,
		})
		corner(sv, 8)
		gradient(sv, Color3.new(1, 1, 1), col, 0)
		local dark = create("Frame", {
			BackgroundColor3 = Color3.new(0, 0, 0), BorderSizePixel = 0,
			Size = UDim2.fromScale(1, 1), ZIndex = 7, Parent = sv,
		})
		corner(dark, 8)
		gradient(dark, Color3.new(0, 0, 0), Color3.new(0, 0, 0), 90, 0, 1)

		local hue = create("Frame", {
			BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0,
			Size = UDim2.fromOffset(W - 20, 12), Position = UDim2.fromOffset(0, 122), ZIndex = 6, Parent = panel,
		})
		corner(hue, 6)
		local hg = create("UIGradient", { Parent = hue })
		hg.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
			ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
			ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
			ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
			ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
			ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0)),
		})
		local svMark = create("Frame", {
			BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0,
			Size = UDim2.fromOffset(12, 12), ZIndex = 9, Parent = sv,
		})
		corner(svMark, 6)
		stroke(svMark, Color3.new(0, 0, 0), 1.5, 0.3)
		local hueMark = create("Frame", {
			BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0,
			Size = UDim2.fromOffset(8, 18), Position = UDim2.fromOffset(0, 119), ZIndex = 9, Parent = panel,
		})
		corner(hueMark, 4)
		stroke(hueMark, Color3.new(0, 0, 0), 1.5, 0.3)

		local hsv = { Color3.toHSV(col) }
		local function refresh()
			local c = Color3.fromHSV(hsv[1], hsv[2], hsv[3])
			sv.BackgroundColor3 = Color3.fromHSV(hsv[1], 1, 1)
			gradient(sv, Color3.new(1, 1, 1), Color3.fromHSV(hsv[1], 1, 1), 0)
			svMark.Position = UDim2.new(hsv[2], -6, 1 - hsv[3], -6)
			svMark.BackgroundColor3 = c
			hueMark.Position = UDim2.fromOffset(hsv[1] * (W - 28), 119)
			col = c
			sw.BackgroundColor3 = c
			hexLb.Text = hex(c)
			hexLb.TextColor3 = (hsv[3] > 0.6 and hsv[2] < 0.5) and Color3.new(0, 0, 0) or Color3.new(1, 1, 1)
			if cfg.Flag then Aether.Flags[cfg.Flag] = c end
		end
		refresh()

		local function dragS(inst, fn)
			local on = false
			inst.InputBegan:Connect(function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
					on = true
					fn(i.Position.X, i.Position.Y)
				end
			end)
			UIS.InputChanged:Connect(function(i)
				if on and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
					fn(i.Position.X, i.Position.Y)
				end
			end)
			UIS.InputEnded:Connect(function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
					on = false
				end
			end)
		end
		dragS(sv, function(x, y)
			local a = sv.AbsolutePosition
			local s = sv.AbsoluteSize
			hsv[2] = clamp((x - a.X) / s.X, 0, 1)
			hsv[3] = 1 - clamp((y - a.Y) / s.Y, 0, 1)
			refresh()
		end)
		dragS(hue, function(x)
			local a = hue.AbsolutePosition
			local s = hue.AbsoluteSize
			hsv[1] = clamp((x - a.X) / s.X, 0, 1)
			refresh()
		end)

		local hexBox = create("TextBox", {
			BackgroundColor3 = T.Element, BorderSizePixel = 0,
			Text = hex(col), Font = Enum.Font.Code, TextSize = 11, TextColor3 = T.Text,
			PlaceholderText = "#RRGGBB", ClearTextOnFocus = false,
			Size = UDim2.fromOffset(W - 20, 26), Position = UDim2.fromOffset(0, 144),
			ZIndex = 6, Parent = panel,
		})
		corner(hexBox, 7)
		padding(hexBox, 0, 0, 9, 9)
		hexBox.FocusLost:Connect(function()
			local s = hexBox.Text:gsub("#", "")
			local ok, r, g, b = pcall(function()
				return tonumber(s:sub(1, 2), 16), tonumber(s:sub(3, 4), 16), tonumber(s:sub(5, 6), 16)
			end)
			if ok and r and g and b then
				col = Color3.fromRGB(r, g, b)
				hsv = { Color3.toHSV(col) }
				refresh()
				if cfg.Callback then task.spawn(cfg.Callback, col) end
			else
				hexBox.Text = hex(col)
			end
		end)

		local preset = { }
		local pal = { rgb(255, 255, 255), rgb(0, 226, 255), rgb(126, 92, 255), rgb(74, 222, 158), rgb(250, 190, 90), rgb(255, 92, 112) }
		for i = 1, #pal do
			local pb = create("TextButton", {
				Text = "", AutoButtonColor = false, BackgroundColor3 = pal[i],
				Size = UDim2.fromOffset(24, 20), Position = UDim2.fromOffset((i - 1) * 28, 178),
				ZIndex = 6, Parent = panel,
			})
			corner(pb, 6)
			pb.MouseButton1Click:Connect(function()
				col = pal[i]
				hsv = { Color3.toHSV(col) }
				refresh()
				if cfg.Callback then task.spawn(cfg.Callback, col) end
			end)
		end

		local back = create("TextButton", {
			Text = "", AutoButtonColor = false, BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1), ZIndex = 3, Parent = layer,
		})
		back.MouseButton1Click:Connect(function()
			pcall(function() back:Destroy() end)
			pcall(function() panel:Destroy() end)
			self.Library:_AutoSave()
			Section.Refresh(self)
		end)

		local anchor = sw.AbsolutePosition
		local vp = Camera and Camera.ViewportSize or Vector2.new(1280, 720)
		local px = clamp(anchor.X + sw.AbsoluteSize.X - W, 8, vp.X - W - 8)
		local py = anchor.Y + 34
		if py + H > vp.Y - 8 then py = anchor.Y - H - 6 end
		panel.Position = UDim2.fromOffset(px, py)
		TweenService:Create(panel, TweenInfo.new(0.24, Enum.EasingStyle.Quint), { Size = UDim2.fromOffset(W, H) }):Play()
	end)

	function item:Set(v, fire)
		if typeof and typeof(v) == "Color3" then col = v else
			col = Color3.fromHSV(0, 0, 0)
		end
		sw.BackgroundColor3 = col
		hexLb.Text = hex(col)
		if cfg.Flag then Aether.Flags[cfg.Flag] = col end
		if cfg.Callback and fire ~= false then task.spawn(cfg.Callback, col) end
	end
	function item:Get() return col end

	self:_Wire(item, cfg, "color", {
		Set = item.Set, Get = item.Get, Run = function() end, Active = nil, Command = false,
	})
	return item
end

--=== 分隔 / 注释 ===
function Section:Divider(cfg)
	cfg = cfg or {}
	local T = Aether.Theme
	local row = create("Frame", {
		Name = "Divider", BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 14), ZIndex = 15, Parent = self.Body,
	})
	self._n = self._n + 1
	order(row, self._n)
	local ln = create("Frame", {
		BackgroundColor3 = T.Stroke, BackgroundTransparency = 0.9, BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 1), Position = UDim2.fromScale(0, 0.5), ZIndex = 15, Parent = row,
	})
	tb(ln, "BackgroundColor3", "Stroke")
	return { Row = row }
end

function Section:Note(cfg)
	cfg = cfg or {}
	local T = Aether.Theme
	local row = create("Frame", {
		Name = "Note", BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, ZIndex = 15, Parent = self.Body,
	})
	self._n = self._n + 1
	order(row, self._n)
	local lb = create("TextLabel", {
		BackgroundTransparency = 1, Text = tostring(cfg.Text or ""),
		Font = Enum.Font.Gotham, TextSize = 10.5, TextColor3 = T.Muted,
		TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true,
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		ZIndex = 15, Parent = row,
	})
	tb(lb, "TextColor3", "Muted")
	return { Row = row, Label = lb }
end

--==============================================================================
-- 配置持久化 · 序列化（只支持基础类型 / Color3 / EnumItem / 数组 / 字典）
--==============================================================================
local buildBoot, buildPalette, buildRadial, buildHud, buildConsole

local function typeofOf(v)
	if type(typeof) == "function" then
		local ok, t = pcall(typeof, v)
		if ok then return t end
	end
	return type(v)
end

local function serVal(v, depth)
	depth = depth or 0
	local t = type(v)
	if t == "nil" then return "nil" end
	if t == "boolean" or t == "number" then return tostring(v) end
	if t == "string" then return string.format("%q", v) end
	local rt = typeofOf(v)
	if rt == "Color3" then
		return string.format("Color3.fromRGB(%d,%d,%d)",
			math.floor(v.R * 255 + 0.5), math.floor(v.G * 255 + 0.5), math.floor(v.B * 255 + 0.5))
	end
	if rt == "EnumItem" then
		return string.format("Enum.%s.%s", v.EnumType.Name, v.Name)
	end
	if t == "table" then
		if depth > 4 then return "nil" end
		local parts = {}
		for k, val in pairs(v) do
			if type(k) == "number" then
				parts[#parts + 1] = string.format("[%d]=%s", k, serVal(val, depth + 1))
			elseif type(k) == "string" then
				parts[#parts + 1] = string.format("[%q]=%s", k, serVal(val, depth + 1))
			end
		end
		return "{" .. table.concat(parts, ",") .. "}"
	end
	return "nil"
end

-- 把一段“表字面量”文本还原成 Lua 值
local function deserVal(text)
	if not text or text == "" then return nil end
	local fn = LoadString or loadstring
	if not fn then return nil end
	local ok, chunk = pcall(fn, "return " .. text)
	if not ok or not chunk then return nil end
	local ok2, val = pcall(chunk)
	if not ok2 then return nil end
	return val
end

--==============================================================================
-- 拖拽 / 边界约束
--==============================================================================
local function keepOnScreen(target, parent)
	parent = parent or target.Parent
	local vp = (parent and parent.AbsoluteSize) or (Camera and Camera.ViewportSize) or Vector2.new(1280, 720)
	if vp.X <= 0 or vp.Y <= 0 then return end
	local sz = target.AbsoluteSize
	local ap = target.AnchorPoint
	local p = target.AbsolutePosition
	local lo_x, lo_y = -sz.X * ap.X + 4, -sz.Y * ap.Y + 4
	local hi_x = vp.X - sz.X * (1 - ap.X) - 4
	local hi_y = vp.Y - sz.Y * (1 - ap.Y) - 4
	if hi_x < lo_x then hi_x = lo_x end
	if hi_y < lo_y then hi_y = lo_y end
	local x = clamp(p.X, lo_x, hi_x)
	local y = clamp(p.Y, lo_y, hi_y)
	target.Position = UDim2.fromOffset(x + sz.X * ap.X, y + sz.Y * ap.Y)
end

-- 返回一个 moved() 判定函数，用于区分“拖动”与“点击”
local function dragify(handle, target, parent)
	local dragging, startInput, startPos, moved = false, nil, nil, false
	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging, moved = true, false
			startInput = input.Position
			startPos = target.Position
			keepOnScreen(target, parent)
			startPos = target.Position
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if not dragging then return end
		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then
			local d = input.Position - startInput
			if math.abs(d.X) + math.abs(d.Y) > 4 then moved = true end
			target.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + d.X,
				startPos.Y.Scale, startPos.Y.Offset + d.Y)
			keepOnScreen(target, parent)
		end
	end)
	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
	return function() return moved end
end

--==============================================================================
-- 页面（左侧主侧边栏） / 标签页（顶部副侧边栏）
--==============================================================================
local Page = {}
Page.__index = Page
local Tab = {}
Tab.__index = Tab

function Page.new(lib, cfg)
	cfg = cfg or {}
	local self = setmetatable({}, Page)
	self.Library = lib
	self.Title = tostring(cfg.Title or "PAGE")
	self.Icon = cfg.Icon or "dot"
	self.Tabs = {}
	lib.Pages[#lib.Pages + 1] = self
	self:_BuildButton()
	return self
end

function Page:_BuildButton()
	local lib = self.Library
	local b = create("TextButton", {
		Name = "Page", Text = "", AutoButtonColor = false,
		BackgroundColor3 = Aether.Theme.Accent, BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 60), ZIndex = 22, Parent = lib.RailList,
	})
	order(b, #lib.Pages)
	corner(b, 11)
	local bar = create("Frame", {
		Name = "Bar", BackgroundColor3 = Aether.Theme.Accent, BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 3, 0, 22), Position = UDim2.new(0, -2, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5), ZIndex = 24, Parent = b,
	})
	corner(bar, 2)
	local ic = icon(b, self.Icon, 20, Aether.Theme.Muted, {
		Position = UDim2.new(0.5, 0, 0, 20), ZIndex = 24,
	})
	local lb = create("TextLabel", {
		Name = "T", BackgroundTransparency = 1, Text = self.Title,
		Font = Enum.Font.GothamMedium, TextSize = 9.5, TextColor3 = Aether.Theme.Muted,
		TextTruncate = Enum.TextTruncate.AtEnd, TextXAlignment = Enum.TextXAlignment.Center,
		Size = UDim2.new(1, -8, 0, 12), Position = UDim2.new(0.5, 0, 0, 37),
		AnchorPoint = Vector2.new(0.5, 0), ZIndex = 24, Parent = b,
	})
	self.Button, self.Bar, self.Icon1, self.Label = b, bar, ic, lb
	b.MouseEnter:Connect(function()
		if lib.ActivePage ~= self then tween(b, { BackgroundTransparency = 0.9 }, 0.14) end
	end)
	b.MouseLeave:Connect(function()
		if lib.ActivePage ~= self then tween(b, { BackgroundTransparency = 1 }, 0.14) end
	end)
	b.MouseButton1Click:Connect(function()
		lib:Select(self, self.Tabs[1])
	end)
end

function Page:Tab(title, icon)
	return Tab.new(self, { Title = title, Icon = icon })
end

function Page:Select()
	self.Library:Select(self, self.Tabs[1])
	return self
end

function Tab.new(page, cfg)
	cfg = cfg or {}
	local self = setmetatable({}, Tab)
	self.Page = page
	self.Library = page.Library
	self.Title = tostring(cfg.Title or "TAB")
	self.Icon = cfg.Icon or "dot"
	self._sec = 0
	page.Tabs[#page.Tabs + 1] = self
	self:_BuildButton()
	self:_BuildContainer()
	return self
end

function Tab:_BuildButton()
	local lib = self.Library
	local b = create("TextButton", {
		Name = "Tab", Text = "", AutoButtonColor = false,
		BackgroundColor3 = Aether.Theme.Accent, BackgroundTransparency = 1,
		Size = UDim2.new(0, 0, 0, 30), AutomaticSize = Enum.AutomaticSize.X,
		ZIndex = 22, Parent = lib.StripList,
	})
	order(b, #self.Page.Tabs)
	corner(b, 9)
	padding(b, 0, 0, 13, 15)
	create("UIListLayout", {
		Parent = b, FillDirection = Enum.FillDirection.Horizontal,
		Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = Enum.VerticalAlignment.Center,
	})
	local ic = icon(b, self.Icon, 15, Aether.Theme.Muted, { ZIndex = 24 })
	order(ic, 1)
	local lb = create("TextLabel", {
		Name = "T", BackgroundTransparency = 1, Text = self.Title,
		Font = Enum.Font.GothamMedium, TextSize = 11, TextColor3 = Aether.Theme.Muted,
		Size = UDim2.new(0, 0, 0, 14), AutomaticSize = Enum.AutomaticSize.X,
		ZIndex = 24, Parent = b,
	})
	order(lb, 2)
	self.Button, self.Icon1, self.Label = b, ic, lb
	b.MouseEnter:Connect(function()
		if lib.ActiveTab ~= self then tween(b, { BackgroundTransparency = 0.92 }, 0.14) end
	end)
	b.MouseLeave:Connect(function()
		if lib.ActiveTab ~= self then tween(b, { BackgroundTransparency = 1 }, 0.14) end
	end)
	b.MouseButton1Click:Connect(function() lib:Select(self.Page, self) end)
end

function Tab:_BuildContainer()
	local c = create("Frame", {
		Name = "Tab_" .. self.Title, BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		Visible = false, ZIndex = 12, Parent = self.Library.ContentList,
	})
	order(c, #self.Page.Tabs)
	list(c, Enum.FillDirection.Vertical, 12)
	self.Container = c
	self.Sections = {}
end

-- 在标签页里放一张卡片（Section）
function Tab:Section(cfg)
	cfg = cfg or {}
	cfg.Parent = self.Container
	cfg.Page = self
	local sec = Section.new(self.Library, cfg)
	self._sec = self._sec + 1
	self.Sections[#self.Sections + 1] = sec
	order(sec.Card, self._sec)
	return sec
end

-- 供指令面板跳转时展开卡片
function Section:SetCollapsed(v)
	v = v and true or false
	if self.Collapsed == v then return end
	self.Collapsed = v
	local h = self.Body.AbsoluteSize.Y
	if v then
		tween(self.Clip, { Size = UDim2.new(1, 0, 0, 0) }, 0.24, Enum.EasingStyle.Quint)
		tween(self.Chev, { Rotation = -90 }, 0.24, Enum.EasingStyle.Quint)
	else
		self.Clip.Size = UDim2.new(1, 0, 0, 0)
		tween(self.Clip, { Size = UDim2.new(1, 0, 0, h) }, 0.28, Enum.EasingStyle.Quint)
		tween(self.Chev, { Rotation = 0 }, 0.28, Enum.EasingStyle.Quint)
	end
end

--==============================================================================
-- 实例构建 · 图层
--==============================================================================
function Aether:_BuildLayers()
	local sg = create("ScreenGui", {
		Name = "Aether", ResetOnSpawn = false, IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	})
	sg.DisplayOrder = 2147483000
	parentGui(sg)
	self.Gui = sg

	local function layer(name, z)
		return create("Frame", {
			Name = name, BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1), ZIndex = z, Parent = sg,
		})
	end
	self.Layers = {
		Window  = layer("L_Window", 1000),
		Hud     = layer("L_Hud", 1050),
		Pop     = layer("L_Pop", 1100),
		Tip     = layer("L_Tip", 1200),
		Toast   = layer("L_Toast", 1250),
		Overlay = layer("L_Overlay", 1300),
		Boot    = layer("L_Boot", 1400),
	}
end

--==============================================================================
-- 实例构建 · 自定义图标（网络图片 → 本地缓存 → 圆角贴图）
--   执行器缺 request / getcustomasset 或下载失败时，静默回退字母或矢量徽标
--==============================================================================
local function hashName(s)
	local h = 5381
	for i = 1, #s do
		h = (h * 33 + string.byte(s, i)) % 2147483647
	end
	return string.format("ic_%x", h)
end
local function iconPath(url)
	if not (WriteFile and ReadFile and MakeFolder and IsFolder) then return nil end
	local folder = "Aether"
	if not IsFolder(folder) then pcall(MakeFolder, folder) end
	return folder .. "/" .. hashName(tostring(url)) .. ".png"
end
local function fetchIcon(url, apply)
	if type(url) ~= "string" or url == "" or type(apply) ~= "function" then return end
	local path = iconPath(url)
	local function use(p)
		if not ToAsset then return false end
		local ok, asset = pcall(ToAsset, p)
		if not ok or type(asset) ~= "string" then return false end
		pcall(apply, asset)
		return true
	end
	if path and IsFile and IsFile(path) and use(path) then return end
	if not HttpRequest then return end
	task.spawn(function()
		local ok, res = pcall(HttpRequest, { Url = url, Method = "GET" })
		local body = ok and res or nil
		if type(body) == "table" then body = body.Body end
		if type(body) ~= "string" or body == "" or not path then return end
		if not pcall(WriteFile, path, body) then return end
		task.defer(function() use(path) end)
	end)
end

--==============================================================================
-- 实例构建 · 主窗口
--==============================================================================
function Aether:_BuildWindow()
	local T = Aether.Theme
	local cfg = self.Cfg

	local win = create("Frame", {
		Name = "Window", BackgroundColor3 = T.Bg, BackgroundTransparency = 0.02,
		Size = UDim2.fromOffset(920, 580), Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5), BorderSizePixel = 0,
		ClipsDescendants = true, Visible = false, ZIndex = 10,
		Parent = self.Layers.Window,
	})
	corner(win, 18)
	local wst = stroke(win, T.Stroke, 1, 0.45)
	tb(wst, "Color", "Stroke")
	gridPattern(win, T.Stroke, 34, 3)
	scanline(win, T.Accent, 130, 6, 6.5)
	brackets(win, T.Accent, 14, 9, 1.6, 8)
	self.ScaleObj = create("UIScale", { Parent = win, Scale = self.Scale })
	self.Window = win

	-- 淡入遮罩（用普通 Frame 而非 CanvasGroup，保证文字矢量清晰）
	local fade = create("Frame", {
		Name = "Fade", BackgroundColor3 = T.Bg, BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1), ZIndex = 60, Parent = win,
	})
	corner(fade, 18)
	self.Fade = fade

	---------------------------------------------------------------- 顶栏
	local bar = create("Frame", {
		Name = "Bar", BackgroundColor3 = T.Panel, BackgroundTransparency = 0.3,
		Size = UDim2.new(1, 0, 0, 56), BorderSizePixel = 0, ZIndex = 12, Parent = win,
	})
	local bl = create("Frame", {
		Name = "Line", BackgroundColor3 = T.Accent, BorderSizePixel = 0,
		BackgroundTransparency = 0.35,
		Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 1, -1),
		ZIndex = 14, Parent = bar,
	})
	local blg = gradient(bl, T.Accent, T.Accent2, 0)
	blg.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.5, 0.25),
		NumberSequenceKeypoint.new(1, 1),
	})

	local logo = create("Frame", {
		Name = "Logo", BackgroundColor3 = T.Ink,
		Size = UDim2.fromOffset(32, 32), Position = UDim2.fromOffset(16, 12),
		BorderSizePixel = 0, ZIndex = 15, Parent = bar,
	})
	corner(logo, 10)
	local lst = stroke(logo, T.Accent, 1.2, 0.4)
	tb(lst, "Color", "Accent")
	self.Logo = logo

	local initial = tostring(cfg.Name or "AETHER"):sub(1, 1):upper()
	local letter = create("TextLabel", {
		Name = "Letter", BackgroundTransparency = 1, Text = initial,
		Font = Enum.Font.GothamBold, TextSize = 15, TextColor3 = T.Accent,
		Size = UDim2.fromScale(1, 1), ZIndex = 17, Parent = logo,
	})
	tb(letter, "TextColor3", "Accent")
	self.LogoLetter = letter

	-- 自定义图标：下载/缓存成功后覆盖字母徽标；任何失败都保留字母
	fetchIcon(cfg.Icon, function(asset)
		local img = logo:FindFirstChild("LogoImg")
		if not img then
			img = create("ImageLabel", {
				Name = "LogoImg", BackgroundTransparency = 1, Image = asset,
				Size = UDim2.fromScale(1, 1), ZIndex = 17, Parent = logo,
			})
			corner(img, 10)
			pcall(function() img.ScaleType = Enum.ScaleType.Crop end)
		end
		img.Image = asset
		letter.Visible = false
	end)

	local barTitle = create("TextLabel", {
		Name = "Title", BackgroundTransparency = 1, Text = tostring(cfg.Name or "AETHER"),
		Font = Enum.Font.GothamBold, TextSize = 13.5, TextColor3 = T.Text,
		TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
		Size = UDim2.new(1, -470, 0, 16), Position = UDim2.fromOffset(58, 11),
		ZIndex = 15, Parent = bar,
	})
	tb(barTitle, "TextColor3", "Text")
	scramble(barTitle, cfg.Name or "AETHER", 0.7)

	local barSub = create("TextLabel", {
		Name = "Sub", BackgroundTransparency = 1,
		Text = string.format("以太界面框架  ·  v%s", Aether.Version),
		Font = Enum.Font.Code, TextSize = 10, TextColor3 = T.Muted,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, -470, 0, 13), Position = UDim2.fromOffset(58, 29),
		ZIndex = 15, Parent = bar,
	})
	tb(barSub, "TextColor3", "Muted")

	-- 顶栏右侧按钮
	local function barBtn(i, iconName, tip, fn)
		local b = create("TextButton", {
			Name = "B" .. iconName, Text = "", AutoButtonColor = false,
			BackgroundColor3 = T.Element, BackgroundTransparency = 0.4,
			Size = UDim2.fromOffset(30, 30),
			Position = UDim2.new(1, -46 - (i - 1) * 36, 0, 13),
			ZIndex = 16, Parent = bar,
		})
		corner(b, 9)
		local bs = stroke(b, T.Stroke, 1, 0.7)
		tb(bs, "Color", "Stroke")
		local ic = icon(b, iconName, 14, T.Muted, { ZIndex = 17 })
		attachTip(self, b, tip)
		b.MouseEnter:Connect(function()
			tween(b, { BackgroundTransparency = 0 }, 0.14)
			tint(ic, T.Accent)
		end)
		b.MouseLeave:Connect(function()
			tween(b, { BackgroundTransparency = 0.4 }, 0.14)
			tint(ic, Aether.Theme.Muted)
		end)
		b.MouseButton1Click:Connect(fn)
		return b
	end
	self.ThemeBtn = barBtn(1, "palette", "切换主题", function() self:CycleTheme() end)
	self.ConsoleBtn = barBtn(2, "terminal", "控制台  (F8)", function() self:Console() end)
	self.HudBtn = barBtn(3, "wave", "遥测 HUD", function() self:HudToggle() end)
	dragify(bar, win, self.Layers.Window)
	barBtn(4, "close", "收起主界面  (F2)", function() self:Toggle(false) end)

	---------------------------------------------------------------- 左侧主侧边栏
	local rail = create("ScrollingFrame", {
		Name = "Rail", BackgroundColor3 = T.Panel, BackgroundTransparency = 0.55,
		Size = UDim2.fromOffset(82, 496), Position = UDim2.fromOffset(0, 56),
		CanvasSize = UDim2.fromOffset(0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y, ScrollBarThickness = 0,
		BorderSizePixel = 0, ZIndex = 12, Parent = win,
	})
	padding(rail, 8, 10, 8, 8)
	list(rail, Enum.FillDirection.Vertical, 6)
	self.RailList = rail
	create("Frame", {
		Name = "RailLine", BackgroundColor3 = T.Stroke, BackgroundTransparency = 0.75,
		BorderSizePixel = 0, Size = UDim2.new(0, 1, 0, 496),
		Position = UDim2.fromOffset(82, 56), ZIndex = 13, Parent = win,
	})

	---------------------------------------------------------------- 顶部副侧边栏
	local strip = create("ScrollingFrame", {
		Name = "Strip", BackgroundTransparency = 1,
		Size = UDim2.new(1, -82, 0, 46), Position = UDim2.fromOffset(82, 56),
		CanvasSize = UDim2.fromOffset(0, 0), AutomaticCanvasSize = Enum.AutomaticSize.X,
		ScrollingDirection = Enum.ScrollingDirection.X, ScrollBarThickness = 2,
		ScrollBarImageColor3 = T.Stroke, ScrollBarImageTransparency = 0.5,
		BorderSizePixel = 0, ZIndex = 12, Parent = win,
	})
	padding(strip, 0, 0, 14, 14)
	local sl = list(strip, Enum.FillDirection.Horizontal, 8)
	sl.VerticalAlignment = Enum.VerticalAlignment.Center
	self.StripList = strip

	---------------------------------------------------------------- 内容区
	local content = create("ScrollingFrame", {
		Name = "Content", BackgroundTransparency = 1,
		Size = UDim2.new(1, -102, 1, -144), Position = UDim2.fromOffset(90, 108),
		CanvasSize = UDim2.fromOffset(0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y, ScrollBarThickness = 3,
		ScrollBarImageColor3 = T.Stroke, ScrollBarImageTransparency = 0.35,
		BorderSizePixel = 0, ZIndex = 12, Parent = win,
	})
	padding(content, 4, 16, 4, 12)
	list(content, Enum.FillDirection.Vertical, 12)
	self.Content = content
	self.ContentList = content

	---------------------------------------------------------------- 底栏
	local foot = create("Frame", {
		Name = "Foot", BackgroundColor3 = T.Panel, BackgroundTransparency = 0.4,
		Size = UDim2.new(1, 0, 0, 28), Position = UDim2.new(0, 0, 1, -28),
		BorderSizePixel = 0, ZIndex = 13, Parent = win,
	})
	local fl = create("Frame", {
		Name = "Line", BackgroundColor3 = T.Stroke, BackgroundTransparency = 0.7,
		BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 1), ZIndex = 14, Parent = foot,
	})
	create("TextLabel", {
		Name = "WM", BackgroundTransparency = 1, Text = "AETHER  //  " .. Aether.Version,
		Font = Enum.Font.Code, TextSize = 10, TextColor3 = T.Muted,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.fromOffset(200, 28), Position = UDim2.fromOffset(16, 0),
		ZIndex = 15, Parent = foot,
	})
	self.FootHint = create("TextLabel", {
		Name = "Hint", BackgroundTransparency = 1,
		Text = "Ctrl+K 指令面板     F8 控制台     ALT 环形菜单     F2 收起",
		Font = Enum.Font.Code, TextSize = 10, TextColor3 = T.Muted,
		Size = UDim2.new(1, -400, 1, 0), Position = UDim2.fromOffset(200, 0),
		ZIndex = 15, Parent = foot,
	})
	tb(self.FootHint, "TextColor3", "Muted")
	self.Clock = create("TextLabel", {
		Name = "Clock", BackgroundTransparency = 1, Text = "--:--:--",
		Font = Enum.Font.Code, TextSize = 11, TextColor3 = T.Accent,
		TextXAlignment = Enum.TextXAlignment.Right,
		Size = UDim2.fromOffset(220, 28), Position = UDim2.new(1, -232, 0, 0),
		ZIndex = 15, Parent = foot,
	})
	tb(self.Clock, "TextColor3", "Accent")

	-- 底栏实时数据
	local function tick()
		while win.Parent do
			local t = os.date("*t")
			self.Clock.Text = string.format("%02d:%02d:%02d  ·  %d FPS  ·  %dms",
				t.hour, t.min, t.sec, math.floor(Telemetry.Fps + 0.5), math.floor(Telemetry.Ping + 0.5))
			task.wait(1)
		end
	end
	task.spawn(tick)
end

--==============================================================================
-- 实例构建 · 悬浮胶囊（始终可见）
--==============================================================================
function Aether:_BuildLauncher()
	local shell = create("Frame", {
		Name = "Launcher", BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		Size = UDim2.fromOffset(158, 40), Position = UDim2.new(0.5, -79, 0, 16),
		AnchorPoint = Vector2.new(0, 0), BorderSizePixel = 0,
		ZIndex = 30, Parent = self.Layers.Hud,
	})
	corner(shell, 20)
	local sst = stroke(shell, Color3.fromRGB(255, 255, 255), 1.2, 0.12)
	local pulse = create("Frame", {
		Name = "Pulse", BackgroundColor3 = Aether.Theme.Accent, BorderSizePixel = 0,
		Size = UDim2.fromOffset(6, 6), Position = UDim2.fromOffset(18, 17),
		ZIndex = 32, Parent = shell,
	})
	corner(pulse, 3)
	local iconBox = icon(shell, "power", 15, Color3.fromRGB(255, 255, 255), {
		Position = UDim2.fromOffset(40, 20), ZIndex = 33,
	})
	-- 自定义图标覆盖矢量徽标（失败则保留矢量）
	local launchImg = create("ImageLabel", {
		Name = "LogoImg", BackgroundTransparency = 1, Visible = false,
		Size = UDim2.fromOffset(20, 20), Position = UDim2.fromOffset(30, 10),
		ZIndex = 33, Parent = shell,
	})
	corner(launchImg, 6)
	fetchIcon(self.Cfg.Icon, function(asset)
		launchImg.Image = asset
		launchImg.Visible = true
		iconBox.Visible = false
	end)
	local label = create("TextLabel", {
		Name = "T", BackgroundTransparency = 1, Text = "OPEN",
		Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, -62, 1, 0), Position = UDim2.fromOffset(58, 0),
		ZIndex = 33, Parent = shell,
	})
	self.Launcher, self.LauncherText, self.LauncherDot = shell, label, pulse

	-- 呼吸动画
	task.spawn(function()
		while pulse.Parent do
			tween(pulse, { BackgroundTransparency = 0.7, Size = UDim2.fromOffset(11, 11) }, 0.9, Enum.EasingStyle.Sine)
			task.wait(0.9)
			tween(pulse, { BackgroundTransparency = 0, Size = UDim2.fromOffset(6, 6) }, 0.9, Enum.EasingStyle.Sine)
			task.wait(0.9)
		end
	end)

	local moved = dragify(shell, shell, self.Layers.Hud)
	local btn = create("TextButton", {
		Name = "Click", Text = "", AutoButtonColor = false, BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1), ZIndex = 34, Parent = shell,
	})
	btn.MouseButton1Click:Connect(function()
		if moved() then return end
		self:Toggle()
	end)
	btn.MouseEnter:Connect(function() tween(sst, { Transparency = 0.45 }, 0.15) end)
	btn.MouseLeave:Connect(function() tween(sst, { Transparency = 0.12 }, 0.15) end)
end

--==============================================================================
-- 导航
--==============================================================================
function Aether:Select(page, tab)
	if not page then return end
	self.ActivePage = page
	tab = tab or page.Tabs[1]

	for _, p in ipairs(self.Pages) do
		local on = (p == page)
		tween(p.Button, { BackgroundTransparency = on and 0.85 or 1 }, 0.2)
		tween(p.Bar, { BackgroundTransparency = on and 0 or 1 }, 0.2)
		tint(p.Icon1, on and Aether.Theme.Accent or Aether.Theme.Muted)
		p.Label.TextColor3 = on and Aether.Theme.Text or Aether.Theme.Muted
		for _, t in ipairs(p.Tabs) do
			t.Button.Visible = on
		end
	end

	if tab then
		self.ActiveTab = tab
		for _, t in ipairs(page.Tabs) do
			local on = (t == tab)
			t.Container.Visible = on
			tween(t.Button, { BackgroundTransparency = on and 0.85 or 1 }, 0.18)
			tint(t.Icon1, on and Aether.Theme.Accent or Aether.Theme.Muted)
			t.Label.TextColor3 = on and Aether.Theme.Text or Aether.Theme.Muted
		end
		self.Content.CanvasPosition = Vector2.new(0, 0)
		self:_Flash()
	end
	self.RailList.CanvasPosition = Vector2.new(0, 0)
end

function Aether:_Flash()
	local fl = create("Frame", {
		Name = "Flash", BackgroundColor3 = Aether.Theme.Accent, BorderSizePixel = 0,
		BackgroundTransparency = 0.45, Size = UDim2.new(0, 220, 0, 1.6),
		Position = UDim2.fromOffset(90, 108), ZIndex = 40, Parent = self.Window,
	})
	corner(fl, 1)
	tween(fl, { Position = UDim2.fromOffset(90 + 560, 108), BackgroundTransparency = 1 }, 0.5, Enum.EasingStyle.Quint)
	task.delay(0.6, function() pcall(function() fl:Destroy() end) end)
end

-- 指令面板跳转到某个命令所在的行
function Aether:_Reveal(cmd)
	if not cmd then return end
	local tab = cmd.Page
	if tab and tab.Page then
		self:Select(tab.Page, tab)
	elseif tab and tab.Select then
		tab:Select()
	end
	if cmd.SectionRef then cmd.SectionRef:SetCollapsed(false) end
	task.defer(function()
		local row = cmd.Row
		if not row or not row.Parent then return end
		local sp = row.Parent
		while sp and not sp:IsA("ScrollingFrame") do sp = sp.Parent end
		if sp then
			local target = row.AbsolutePosition.Y - sp.AbsolutePosition.Y + sp.CanvasPosition.Y - 70
			tween(sp, { CanvasPosition = Vector2.new(0, math.max(0, target)) }, 0.35, Enum.EasingStyle.Quint)
		end
		if cmd.SectionRef then cmd.SectionRef:Pulse(row) end
	end)
end

--==============================================================================
-- 显示 / 隐藏
--==============================================================================
function Aether:Toggle(force)
	local open = (force ~= nil) and force or (not self.WindowOpen)
	self.WindowOpen = open
	local win, sc = self.Window, self.Scale
	if open then
		win.Visible = true
		self.Fade.BackgroundTransparency = 0
		self.ScaleObj.Scale = sc * 0.94
		tween(self.ScaleObj, { Scale = sc }, 0.28, Enum.EasingStyle.Quint)
		tween(self.Fade, { BackgroundTransparency = 1 }, 0.32)
	else
		tween(self.ScaleObj, { Scale = sc * 0.94 }, 0.2, Enum.EasingStyle.Quad)
		tween(self.Fade, { BackgroundTransparency = 0.04 }, 0.2)
		task.delay(0.22, function() win.Visible = false end)
	end
	if self.LauncherText then
		self.LauncherText.Text = open and "CLOSE" or "OPEN"
	end
	if self.LauncherDot then
		tween(self.LauncherDot, { BackgroundColor3 = open and Aether.Theme.Warn or Aether.Theme.Ok }, 0.25)
	end
	return self
end

--==============================================================================
-- 主题 / 通知 / 侧边栏
--==============================================================================
function Aether:Notify(cfg)
	return notify(self, cfg)
end

function Aether:SetTheme(name)
	if applyTheme(name, false) then
		self:_AutoSave()
		notify(self, { Title = "主题已切换", Desc = tostring(name):upper(), Icon = "palette" })
		return true
	end
	return false
end

function Aether:CycleTheme()
	local names = {}
	for k in pairs(Aether.Themes) do names[#names + 1] = k end
	table.sort(names)
	local idx = 1
	for i, n in ipairs(names) do if n == Aether.ThemeName then idx = i break end end
	idx = idx % #names + 1
	self:SetTheme(names[idx])
end

function Aether:Page(title, icon)
	return Page.new(self, { Title = title, Icon = icon })
end

--==============================================================================
-- 指令注册表 / 快捷键 / 固定
--==============================================================================
function Aether:_Register(cmd)
	self.Commands[#self.Commands + 1] = cmd
	return cmd
end

local function currentMods()
	local m = {}
	if UIS:IsKeyDown(Enum.KeyCode.LeftShift) or UIS:IsKeyDown(Enum.KeyCode.RightShift) then m[#m + 1] = "shift" end
	if UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.RightControl) then m[#m + 1] = "ctrl" end
	if UIS:IsKeyDown(Enum.KeyCode.LeftAlt) or UIS:IsKeyDown(Enum.KeyCode.RightAlt) then m[#m + 1] = "alt" end
	table.sort(m)
	return m
end

local function keySig(key, mods)
	local parts = {}
	for _, v in ipairs(mods or {}) do parts[#parts + 1] = v end
	if key then parts[#parts + 1] = key.Name end
	return table.concat(parts, "+")
end

function Aether:_Bind(key, mods, fn)
	if not key then return end
	local sig = keySig(key, mods)
	for i = #self.Binds, 1, -1 do
		if self.Binds[i].sig == sig then table.remove(self.Binds, i) end
	end
	self.Binds[#self.Binds + 1] = { sig = sig, key = key, mods = mods, fn = fn }
end

function Aether:Pinned(item)
	if not item then return end
	for i = 1, #self.Pins do
		if self.Pins[i] == item then
			notify(self, { Title = "已在快捷栏中", Desc = "可按住 ALT 呼出环形菜单", Icon = "check", Kind = "warn" })
			return
		end
	end
	self.Pins[#self.Pins + 1] = item
	notify(self, {
		Title = "已固定到快捷栏",
		Desc = (item.Config and item.Config.Title) or "控件",
		Icon = "bolt",
	})
end

--==============================================================================
-- 输入总入口
--==============================================================================
function Aether:_BindInput()
	local lib = self
	lib.RadialKey = lib.Cfg.RadialKey or Enum.KeyCode.LeftAlt

	UIS.InputBegan:Connect(function(input, gpe)
		if UIS:GetFocusedTextBox() then return end
		if input.KeyCode == Enum.KeyCode.K
			and (UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.RightControl)) then
			lib:Palette()
			return
		end
		if input.KeyCode == Enum.KeyCode.F8 then lib:Console() return end
		if input.KeyCode == Enum.KeyCode.F2 then lib:Toggle() return end
		if input.KeyCode == lib.RadialKey then
			lib:RadialOpen()
		end
		local sig = keySig(input.KeyCode, currentMods())
		for i = 1, #lib.Binds do
			local b = lib.Binds[i]
			if b.sig == sig and b.fn then task.spawn(b.fn) end
		end
	end)

	UIS.InputEnded:Connect(function(input)
		if input.KeyCode == lib.RadialKey then lib:RadialClose() end
	end)
end

--==============================================================================
-- 配置持久化
--==============================================================================
function Aether:_ConfigPath()
	if not (WriteFile and ReadFile) then return nil end
	if self._cfgFile then return self._cfgFile end
	local folder = "Aether"
	if MakeFolder and IsFolder and not IsFolder(folder) then pcall(MakeFolder, folder) end
	local name = tostring(self.Cfg.Name or "AETHER"):gsub("[^%w_%-]", "") 
	if name == "" then name = "AETHER" end
	self._cfgFile = folder .. "/" .. name .. ".cfg"
	return self._cfgFile
end

function Aether:_AutoSave()
	if self.Cfg.Persist == false or not WriteFile then return end
	self._saveTok = (self._saveTok or 0) + 1
	local tok = self._saveTok
	task.delay(0.7, function()
		if tok ~= self._saveTok then return end
		self:_WriteConfig()
	end)
end

function Aether:_WriteConfig()
	local path = self:_ConfigPath()
	if not path then return end
	local flags = {}
	for k, v in pairs(Aether.Flags) do flags[k] = v end
	local data = string.format("{theme=%q,flags=%s,winpos={%d,%d}}",
		tostring(Aether.ThemeName), serVal(flags),
		math.floor(self.Window.Position.X.Offset), math.floor(self.Window.Position.Y.Offset))
	pcall(WriteFile, path, data)
end

function Aether:_LoadConfig()
	local path = self:_ConfigPath()
	if not path or not (IsFile and IsFile(path)) then return end
	local ok, text = pcall(ReadFile, path)
	if not ok or not text then return end
	local tbl = deserVal(text)
	if type(tbl) ~= "table" then return end
	if tbl.theme and Aether.Themes[tbl.theme] then applyTheme(tbl.theme, true) end
	if type(tbl.flags) == "table" then
		self._saved = tbl.flags
		for flag, val in pairs(tbl.flags) do
			local setter = self._Setters[flag]
			if setter then pcall(setter, val, false) end
			Aether.Flags[flag] = val
		end
	else
		self._saved = {}
	end
	if type(tbl.winpos) == "table" and self.Window then
		self.Window.Position = UDim2.fromOffset(tbl.winpos[1] or 0, tbl.winpos[2] or 0)
		keepOnScreen(self.Window, self.Layers.Window)
	end
end

--==============================================================================
-- 构造入口
--==============================================================================
function Aether.new(cfg)
	cfg = cfg or {}
	local self = setmetatable({}, Aether)
	self.Cfg = cfg
	self.Pages = {}
	self.Commands = {}
	self.Binds = {}
	self.Pins = {}
	self.Toasts = {}
	self._Setters = {}
	self._saved = {}
	self._popClose = nil
	self.WindowOpen = false
	self.Version = Aether.Version

	local vp = (Camera and Camera.ViewportSize) or Vector2.new(1280, 720)
	local sc = cfg.Scale or math.min(vp.X / 1360, vp.Y / 800)
	self.Scale = clamp(sc, 0.8, 1.22)

	self:_BuildLayers()
	self:_BuildWindow()
	self:_BuildLauncher()
	self:_BindInput()
	self:_LoadConfig()

	buildHud(self)
	buildConsole(self)
	buildPalette(self)
	buildRadial(self)

	if cfg.Boot == false then
		self:Toggle(true)
	else
		buildBoot(self)
	end
	return self
end

--==============================================================================
-- 公共小工具
--==============================================================================
local KIND_ICON = {
	toggle = "power", slider = "layers", dropdown = "down", keybind = "key",
	input = "terminal", button = "bolt", colorpicker = "palette",
	segmented = "grid", label = "dot", graph = "wave", progress = "scan",
}
local function iconFor(kind) return KIND_ICON[kind] or "dot" end
local function labelOf(x)
	if not x then return "" end
	return tostring((x.Config and x.Config.Title) or x.Title or "控件")
end
local function shortText(s, n)
	s = tostring(s or "")
	if #s <= (n or 9) then return s end
	return s:sub(1, n or 9) .. "…"
end
local function screenPos(p)
	if Camera then return Vector2.new(p.X, p.Y - 36) end
	return p
end

--==============================================================================
-- 遥测 HUD
--==============================================================================
buildHud = function(lib)
	local layer = lib.Layers.Hud
	local T = Aether.Theme

	local hud = create("Frame", {
		Name = "Hud", BackgroundColor3 = T.Panel, BackgroundTransparency = 0.06,
		Size = UDim2.fromOffset(216, 116), Position = UDim2.new(1, -232, 0, 66),
		BorderSizePixel = 0, ZIndex = 20, Parent = layer,
	})
	corner(hud, 14)
	local st = stroke(hud, T.Stroke, 1, 0.6)
	tb(st, "Color", "Stroke")
	brackets(hud, T.Accent, 9, 5, 1.4, 22)

	create("TextLabel", {
		Name = "Title", BackgroundTransparency = 1, Text = "AETHER // 遥测链路",
		Font = Enum.Font.Code, TextSize = 9.5, TextColor3 = T.Muted,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, -24, 0, 12), Position = UDim2.fromOffset(12, 9),
		ZIndex = 24, Parent = hud,
	})

	local fpsV = create("TextLabel", {
		Name = "Fps", BackgroundTransparency = 1, Text = "60",
		Font = Enum.Font.Code, TextSize = 20, TextColor3 = T.Accent,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.fromOffset(56, 24), Position = UDim2.fromOffset(12, 26),
		ZIndex = 24, Parent = hud,
	})
	tb(fpsV, "TextColor3", "Accent")
	create("TextLabel", {
		Name = "FpsCap", BackgroundTransparency = 1, Text = "FPS",
		Font = Enum.Font.Code, TextSize = 9, TextColor3 = T.Muted,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.fromOffset(56, 11), Position = UDim2.fromOffset(12, 47),
		ZIndex = 24, Parent = hud,
	})

	local sp = sparkline(hud, 126, 30, T.Accent, 30)
	sp.Host.Position = UDim2.fromOffset(74, 25)
	sp.Host.ZIndex = 24
	for _, b in ipairs(sp.Host:GetChildren()) do
		if b:IsA("Frame") then b.ZIndex = 24 end
	end

	local pingV = create("TextLabel", {
		Name = "Ping", BackgroundTransparency = 1, Text = "PING  --ms",
		Font = Enum.Font.Code, TextSize = 11, TextColor3 = T.Muted,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.fromOffset(120, 15), Position = UDim2.fromOffset(12, 68),
		ZIndex = 24, Parent = hud,
	})
	tb(pingV, "TextColor3", "Muted")

	local bars = signalBars(hud, 24, 14)
	bars.Holder.Position = UDim2.fromOffset(178, 68)
	bars.Holder.ZIndex = 24

	local clock = create("TextLabel", {
		Name = "Clock", BackgroundTransparency = 1, Text = "--:--:--",
		Font = Enum.Font.Code, TextSize = 13, TextColor3 = T.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, -24, 0, 16), Position = UDim2.fromOffset(12, 88),
		ZIndex = 24, Parent = hud,
	})
	tb(clock, "TextColor3", "Text")

	Telemetry.Listeners[#Telemetry.Listeners + 1] = function(fps, ping)
		if not hud.Parent then return end
		fpsV.Text = string.format("%d", math.floor(fps + 0.5))
		sp:Push(fps)
		pingV.Text = string.format("PING  %dms", math.floor(ping + 0.5))
		bars.Set(ping)
	end

	task.spawn(function()
		while hud.Parent do
			local t = os.date("*t")
			clock.Text = string.format("%02d:%02d:%02d", t.hour, t.min, t.sec)
			task.wait(1)
		end
	end)

	dragify(hud, hud, lib.Layers.Hud)
	bars.Set(Telemetry.Ping)
	lib.Hud = hud
	lib._hudToggle = function()
		hud.Visible = not hud.Visible
		notify(lib, { Title = hud.Visible and "遥测 HUD 已开启" or "遥测 HUD 已隐藏", Icon = "wave", Duration = 2 })
	end
end

--==============================================================================
-- 内置控制台（REPL）
--==============================================================================
buildConsole = function(lib)
	local layer = lib.Layers.Overlay
	local T = Aether.Theme

	local root = create("Frame", {
		Name = "Console", BackgroundColor3 = T.Bg, BackgroundTransparency = 0.04,
		Size = UDim2.fromOffset(660, 380), Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5), BorderSizePixel = 0, Visible = false,
		ZIndex = 48, Parent = layer,
	})
	corner(root, 16)
	local rst = stroke(root, T.Accent, 1, 0.55)
	tb(rst, "Color", "Accent")
	brackets(root, T.Accent, 11, 6, 1.5, 52)

	-- 标题栏
	local bar = create("Frame", {
		Name = "Bar", BackgroundColor3 = T.Panel, BackgroundTransparency = 0.3,
		Size = UDim2.new(1, 0, 0, 40), BorderSizePixel = 0, ZIndex = 50, Parent = root,
	})
	create("TextLabel", {
		Name = "T", BackgroundTransparency = 1, Text = "AETHER CONSOLE",
		Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = T.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.fromOffset(240, 16), Position = UDim2.fromOffset(14, 8),
		ZIndex = 52, Parent = bar,
	})
	create("TextLabel", {
		Name = "S", BackgroundTransparency = 1, Text = "内置 REPL  ·  以本机身份执行 Lua",
		Font = Enum.Font.Code, TextSize = 9.5, TextColor3 = T.Muted,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.fromOffset(320, 12), Position = UDim2.fromOffset(14, 23),
		ZIndex = 52, Parent = bar,
	})

	local out = create("ScrollingFrame", {
		Name = "Out", BackgroundTransparency = 1,
		Size = UDim2.new(1, -20, 1, -94), Position = UDim2.fromOffset(10, 46),
		CanvasSize = UDim2.fromOffset(0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y, ScrollBarThickness = 3,
		ScrollBarImageColor3 = T.Stroke, ScrollBarImageTransparency = 0.4,
		BorderSizePixel = 0, ZIndex = 50, Parent = root,
	})
	padding(out, 2, 2, 4, 6)
	list(out, Enum.FillDirection.Vertical, 3)

	local function addLine(text, kind)
		local col = T.Text
		if kind == "ok" then col = T.Ok
		elseif kind == "err" then col = T.Bad
		elseif kind == "warn" then col = T.Warn
		elseif kind == "dim" then col = T.Muted
		elseif kind == "accent" then col = T.Accent end
		local lb = create("TextLabel", {
			BackgroundTransparency = 1, Text = tostring(text),
			Font = Enum.Font.Code, TextSize = 11.5, TextColor3 = col,
			TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true,
			Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
			ZIndex = 52, Parent = out,
		})
		out.CanvasPosition = Vector2.new(0, 1e6)
		return lb
	end

	-- 输入行
	local inputRow = create("Frame", {
		Name = "InputRow", BackgroundColor3 = T.Element, BackgroundTransparency = 0.3,
		Size = UDim2.new(1, -20, 0, 38), Position = UDim2.new(0, 10, 1, -44),
		BorderSizePixel = 0, ZIndex = 51, Parent = root,
	})
	corner(inputRow, 9)
	local irs = stroke(inputRow, T.Stroke, 1, 0.6)
	tb(irs, "Color", "Stroke")
	create("TextLabel", {
		BackgroundTransparency = 1, Text = "›",
		Font = Enum.Font.Code, TextSize = 15, TextColor3 = T.Accent,
		Size = UDim2.fromOffset(22, 38), Position = UDim2.fromOffset(8, 0),
		ZIndex = 52, Parent = inputRow,
	})
	local input = create("TextBox", {
		Name = "Cmd", BackgroundTransparency = 1, Text = "",
		PlaceholderText = "输入 Lua 代码，回车执行；↑ ↓ 翻阅历史",
		PlaceholderColor3 = T.Muted, ClearTextOnFocus = false,
		Font = Enum.Font.Code, TextSize = 12, TextColor3 = T.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, -40, 1, 0), Position = UDim2.fromOffset(30, 0),
		ZIndex = 52, Parent = inputRow,
	})
	tb(input, "TextColor3", "Text")

	-- 关闭 / 清空 按钮
	local function miniBtn(i, iconName, fn)
		local b = create("TextButton", {
			Text = "", AutoButtonColor = false, BackgroundTransparency = 1,
			Size = UDim2.fromOffset(26, 26),
			Position = UDim2.new(1, -8 - (i - 1) * 30, 0, 7),
			ZIndex = 52, Parent = bar,
		})
		corner(b, 7)
		local ic = icon(b, iconName, 12, T.Muted, { ZIndex = 53 })
		b.MouseEnter:Connect(function() tween(b, { BackgroundTransparency = 0.85 }, 0.13); tint(ic, T.Accent) end)
		b.MouseLeave:Connect(function() tween(b, { BackgroundTransparency = 1 }, 0.13); tint(ic, Aether.Theme.Muted) end)
		b.MouseButton1Click:Connect(fn)
		return b
	end

	local history, hIdx = {}, 1
	local env = setmetatable({}, {
		__index = _G,
		__newindex = function(_, k, v) rawset(env, k, v); pcall(function() GLOB[k] = v end) end,
	})
	local function joinArgs(...)
		local parts = {}
		for i = 1, select("#", ...) do parts[#parts + 1] = tostring(select(i, ...)) end
		return table.concat(parts, "\t")
	end
	env.print = function(...) addLine(joinArgs(...), "text") end
	env.warn = function(...) addLine(joinArgs(...), "warn") end
	env.error = function(...) addLine(joinArgs(...), "err") end

	local function run(code)
		code = tostring(code or "")
		if code:gsub("%s", "") == "" then return end
		history[#history + 1] = code
		hIdx = #history + 1
		addLine("› " .. code, "accent")
		if not LoadString then
			addLine("[x] 当前执行器未提供 loadstring，无法执行。", "err")
			return
		end
		local fn, err = LoadString(code, "aether_console")
		if not fn then
			addLine("[x] 语法错误：" .. tostring(err), "err")
			return
		end
		if setfenv then pcall(setfenv, fn, env) end
		local res = table.pack(pcall(fn))
		if not res[1] then
			addLine("[x] " .. tostring(res[2]), "err")
		else
			for i = 2, res.n do addLine("[=] " .. tostring(res[i]), "ok") end
		end
	end

	input.FocusLost:Connect(function(enter)
		if enter then
			run(input.Text)
			input.Text = ""
		end
	end)

	local function toggle(v)
		local on = (v ~= nil) and v or (not root.Visible)
		root.Visible = on
		if on then
			brackets(root, Aether.Theme.Accent, 11, 6, 1.5, 52)
			root.Size = UDim2.fromOffset(660 * 0.95, 380 * 0.95)
			tween(root, { Size = UDim2.fromOffset(660, 380) }, 0.22, Enum.EasingStyle.Quint)
			task.defer(function() pcall(function() input:CaptureFocus() end) end)
		else
			pcall(function() input:ReleaseFocus() end)
		end
	end

	UIS.InputBegan:Connect(function(inp)
		if not root.Visible then return end
		if inp.KeyCode == Enum.KeyCode.Escape then toggle(false) return end
		if UIS:GetFocusedTextBox() ~= input then return end
		if inp.KeyCode == Enum.KeyCode.Up then
			hIdx = math.max(1, hIdx - 1)
			input.Text = history[hIdx] or ""
		elseif inp.KeyCode == Enum.KeyCode.Down then
			hIdx = math.min(#history + 1, hIdx + 1)
			input.Text = history[hIdx] or ""
		end
	end)

	miniBtn(1, "close", function() toggle(false) end)
	miniBtn(2, "layers", function()
		for _, c in ipairs(out:GetChildren()) do
			if c:IsA("TextLabel") then c:Destroy() end
		end
		addLine("// 已清空", "dim")
	end)

	dragify(bar, root, lib.Layers.Overlay)

	addLine("AETHER CONSOLE  v" .. Aether.Version, "accent")
	addLine("直接输入 Lua 并回车执行；↑ ↓ 翻阅历史，ESC 关闭。", "dim")

	lib._console = toggle
	lib._run = run
	lib._log = addLine
end

--==============================================================================
-- 指令面板（Ctrl+K）
--==============================================================================
buildPalette = function(lib)
	local layer = lib.Layers.Overlay
	local T = Aether.Theme

	local root = create("Frame", {
		Name = "Palette", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1),
		Visible = false, ZIndex = 42, Parent = layer,
	})
	local back = create("TextButton", {
		Name = "Back", Text = "", AutoButtonColor = false,
		BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.45,
		Size = UDim2.fromScale(1, 1), ZIndex = 42, Parent = root,
	})
	local panel = create("Frame", {
		Name = "Panel", BackgroundColor3 = T.Panel, BackgroundTransparency = 0.02,
		Size = UDim2.fromOffset(600, 384), Position = UDim2.new(0.5, -300, 0, 86),
		BorderSizePixel = 0, ZIndex = 44, Parent = root,
	})
	corner(panel, 16)
	local pst = stroke(panel, T.Accent, 1, 0.5)
	tb(pst, "Color", "Accent")
	brackets(panel, T.Accent, 12, 7, 1.5, 46)
	gridPattern(panel, T.Stroke, 40, 44)
	padding(panel, 12, 12, 12, 12)
	list(panel, Enum.FillDirection.Vertical, 10)

	-- 搜索行
	local sr = create("Frame", {
		Name = "Search", BackgroundColor3 = T.Element, BackgroundTransparency = 0.3,
		Size = UDim2.new(1, 0, 0, 40), BorderSizePixel = 0, ZIndex = 48, Parent = panel,
	})
	corner(sr, 10)
	local srs = stroke(sr, T.Stroke, 1, 0.55)
	tb(srs, "Color", "Stroke")
	icon(sr, "search", 15, T.Muted, { Position = UDim2.fromOffset(16, 20), ZIndex = 50 })
	local search = create("TextBox", {
		Name = "Q", BackgroundTransparency = 1, Text = "",
		PlaceholderText = "搜索指令、开关、按钮…  ( ↑ ↓ 选择 · 回车执行 )",
		PlaceholderColor3 = T.Muted, ClearTextOnFocus = false,
		Font = Enum.Font.GothamMedium, TextSize = 12.5, TextColor3 = T.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, -50, 1, 0), Position = UDim2.fromOffset(40, 0),
		ZIndex = 50, Parent = sr,
	})
	tb(search, "TextColor3", "Text")

	local res = create("ScrollingFrame", {
		Name = "Res", BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 288), BorderSizePixel = 0,
		CanvasSize = UDim2.fromOffset(0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y, ScrollBarThickness = 3,
		ScrollBarImageColor3 = T.Stroke, ScrollBarImageTransparency = 0.4,
		ZIndex = 48, Parent = panel,
	})
	padding(res, 2, 2, 2, 6)
	list(res, Enum.FillDirection.Vertical, 3)

	local empty = create("TextLabel", {
		Name = "Empty", BackgroundTransparency = 1, Text = "没有匹配的指令",
		Font = Enum.Font.Code, TextSize = 11.5, TextColor3 = T.Muted,
		Size = UDim2.new(1, 0, 0, 40), ZIndex = 50, Visible = false, Parent = res,
	})

	local score
	do
		local function breadcrumb(c)
			local path = tostring(c.Section or "")
			if c.Page and c.Page.Title then
				path = tostring(c.Page.Title) .. (path ~= "" and (" / " .. path) or "")
			end
			return path
		end
		local function hay(c)
			return string.lower(table.concat({
				tostring(c.Title or ""), breadcrumb(c), tostring(c.Kind or ""),
				tostring(c.Flag or ""),
			}, " "))
		end
		score = function(q, c)
			if q == "" then return 1 end
			local h = hay(c)
			local s, pos = 0, 1
			for i = 1, #q do
				local ch = q:sub(i, i)
				local f = h:find(ch, pos, true)
				if not f then return -1 end
				s = s + (f == pos and 3 or 1)
				pos = f + 1
			end
			return s - #h * 0.001
		end
	end

	local results, rows, sel = {}, {}, 1
	local runSel

	local function clearRows()
		for i = 1, #rows do pcall(function() rows[i]:Destroy() end) end
		rows = {}
	end

	local function highlight()
		for i = 1, #rows do
			local on = (i == sel)
			tween(rows[i], {
				BackgroundTransparency = on and 0.86 or 1,
				BackgroundColor3 = on and T.Accent or T.Accent,
			}, 0.1)
		end
		if rows[sel] then
			local y = (sel - 1) * 37
			if y < res.CanvasPosition.Y or y > res.CanvasPosition.Y + res.AbsoluteSize.Y - 40 then
				tween(res, { CanvasPosition = Vector2.new(0, math.max(0, y - 80)) }, 0.2)
			end
		end
	end

	local function makeRow(c, idx)
		local r = create("TextButton", {
			Name = "R", Text = "", AutoButtonColor = false,
			BackgroundColor3 = T.Accent, BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 34), ZIndex = 50, Parent = res,
		})
		order(r, idx)
		corner(r, 9)
		local ic = icon(r, iconFor(c.Kind), 13, T.Muted, { Position = UDim2.fromOffset(13, 17), ZIndex = 52 })
		create("TextLabel", {
			Name = "T", BackgroundTransparency = 1, Text = tostring(c.Title or "命令"),
			Font = Enum.Font.GothamMedium, TextSize = 11.5, TextColor3 = T.Text,
			TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
			Size = UDim2.new(1, -220, 1, 0), Position = UDim2.fromOffset(32, 0),
			ZIndex = 52, Parent = r,
		})
		local path = ""
		if c.Page and c.Page.Title then
			path = tostring(c.Page.Title) .. (c.Section and (" / " .. tostring(c.Section)) or "")
		end
		create("TextLabel", {
			Name = "B", BackgroundTransparency = 1, Text = path,
			Font = Enum.Font.Code, TextSize = 9.5, TextColor3 = T.Muted,
			TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtStart,
			Size = UDim2.fromOffset(120, 34), Position = UDim2.new(1, -158, 0, 0),
			ZIndex = 52, Parent = r,
		})
		local val = ""
		if c.Get then
			local ok, v = pcall(c.Get)
			if ok and v ~= nil then val = shortText(tostring(v), 12) end
		end
		create("TextLabel", {
			Name = "V", BackgroundTransparency = 1, Text = val,
			Font = Enum.Font.Code, TextSize = 10.5, TextColor3 = T.Accent,
			TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtEnd,
			Size = UDim2.fromOffset(52, 34), Position = UDim2.new(1, -56, 0, 0),
			ZIndex = 52, Parent = r,
		})
		r.MouseEnter:Connect(function() sel = idx; highlight() end)
		r.MouseButton1Click:Connect(function() sel = idx; if runSel then runSel() end end)
		rows[idx] = r
		if idx == sel then r.BackgroundTransparency = 0.86 end
		return r
	end

	local function render(q)
		results = {}
		for i = 1, #lib.Commands do
			local c = lib.Commands[i]
			local s = score(q, c)
			if s >= 0 then results[#results + 1] = { c = c, s = s } end
		end
		table.sort(results, function(a, b) return a.s > b.s end)
		clearRows()
		local n = math.min(#results, 60)
		for i = 1, n do makeRow(results[i].c, i) end
		empty.Visible = (n == 0)
		sel = clamp(sel, 1, math.max(1, n))
		highlight()
	end

	local function close()
		root.Visible = false
		pcall(function() search:ReleaseFocus() end)
	end

	runSel = function()
		local r = results[sel]
		if not r then return end
		local c = r.c
		close()
		task.defer(function()
			if c.Run then pcall(c.Run) end
			lib:_Reveal(c)
		end)
	end

	local function open()
		root.Visible = true
		sel = 1
		search.Text = ""
		render("")
		task.defer(function() pcall(function() search:CaptureFocus() end) end)
	end

	search:GetPropertyChangedSignal("Text"):Connect(function()
		sel = 1
		render(string.lower(search.Text or ""))
	end)
	back.MouseButton1Click:Connect(close)

	UIS.InputBegan:Connect(function(inp)
		if not root.Visible then return end
		if inp.KeyCode == Enum.KeyCode.Escape then close() return end
		if inp.KeyCode == Enum.KeyCode.Down then
			sel = sel + 1
			if sel > #results then sel = 1 end
			highlight()
		elseif inp.KeyCode == Enum.KeyCode.Up then
			sel = sel - 1
			if sel < 1 then sel = math.max(1, #results) end
			highlight()
		elseif inp.KeyCode == Enum.KeyCode.Return or inp.KeyCode == Enum.KeyCode.KeypadEnter then
			runSel()
		end
	end)

	lib._palette = open
end

--==============================================================================
-- 环形放射菜单（按住 ALT）
--==============================================================================
buildRadial = function(lib)
	local layer = lib.Layers.Overlay
	local T = Aether.Theme

	local root = create("Frame", {
		Name = "Radial", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1),
		Visible = false, ZIndex = 45, Parent = layer,
	})
	create("Frame", {
		Name = "Dim", BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.5, Size = UDim2.fromScale(1, 1),
		ZIndex = 45, Parent = root,
	})

	local chips, items, center, active, conn, reticle = {}, {}, Vector2.new(0, 0), 0, nil, nil

	local function collect()
		items = {}
		for i = 1, #lib.Pins do
			local it = lib.Pins[i]
			if it and it.Run then items[#items + 1] = it end
			if #items >= 6 then break end
		end
		if #items < 6 then
			for i = 1, #lib.Commands do
				if #items >= 6 then break end
				local c = lib.Commands[i]
				if c.Run and (c.Kind == "toggle" or c.Kind == "button") then
					local dup = false
					for j = 1, #items do
						if c.Flag and items[j].Flag == c.Flag and items[j].Flag ~= nil then dup = true end
					end
					if not dup then items[#items + 1] = c end
				end
			end
		end
	end

	local function highlight(i)
		active = i
		for k = 1, #chips do
			local on = (k == i)
			tween(chips[k].chip, {
				BackgroundTransparency = on and 0.82 or 0.05,
				BackgroundColor3 = on and T.Accent or T.Panel,
			}, 0.12)
			tint(chips[k].ic, on and T.Text or Aether.Theme.Muted)
			chips[k].tl.TextColor3 = on and T.Text or Aether.Theme.Muted
		end
		if chips[i] then
			pcall(function() chips[i].chip.Size = UDim2.fromOffset(78, 50) end)
		end
		for k = 1, #chips do
			if k ~= i then pcall(function() chips[k].chip.Size = UDim2.fromOffset(70, 46) end) end
		end
	end

	local function clear()
		if conn then conn:Disconnect() conn = nil end
		for i = 1, #chips do pcall(function() chips[i].chip:Destroy() end) end
		chips = {}
		if reticle then pcall(function() reticle:Destroy() end) reticle = nil end
		active = 0
	end

	local function open()
		if root.Visible then return end
		collect()
		if #items == 0 then
			notify(lib, { Title = "环形菜单为空", Desc = "右键任意控件 → 固定到快捷栏", Icon = "bolt", Kind = "warn" })
			return
		end
		root.Visible = true
		center = cursorPos()

		local ret = create("Frame", {
			Name = "Reticle", BackgroundTransparency = 1,
			Size = UDim2.fromOffset(54, 54),
			Position = UDim2.fromOffset(center.X - 27, center.Y - 27),
			ZIndex = 47, Parent = root,
		})
		local ring = create("Frame", {
			BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1),
			ZIndex = 47, Parent = ret,
		})
		corner(ring, 27)
		stroke(ring, T.Accent, 1.4, 0.3)
		icon(ring, "target", 16, T.Accent, { ZIndex = 48 })
		reticle = ret

		local n = #items
		local R = 108
		for i = 1, n do
			local ang = math.rad(-90 + (i - 1) * 360 / n)
			local x = math.cos(ang) * R
			local y = math.sin(ang) * R
			local chip = create("Frame", {
				Name = "Chip", BackgroundColor3 = T.Panel, BackgroundTransparency = 0.05,
				Size = UDim2.fromOffset(70, 46),
				Position = UDim2.fromOffset(center.X + x - 35, center.Y + y - 23),
				BorderSizePixel = 0, ZIndex = 48, Parent = root,
			})
			corner(chip, 12)
			local cs = stroke(chip, T.Stroke, 1, 0.6)
			tb(cs, "Color", "Stroke")
			local ic = icon(chip, iconFor(items[i].Kind), 15, Aether.Theme.Muted, {
				Position = UDim2.new(0.5, 0, 0, 13), ZIndex = 50,
			})
			local tl = create("TextLabel", {
				BackgroundTransparency = 1, Text = shortText(labelOf(items[i]), 9),
				Font = Enum.Font.GothamMedium, TextSize = 9, TextColor3 = Aether.Theme.Muted,
				TextTruncate = Enum.TextTruncate.AtEnd, TextXAlignment = Enum.TextXAlignment.Center,
				Size = UDim2.new(1, -8, 0, 12), Position = UDim2.new(0.5, 0, 0, 29),
				AnchorPoint = Vector2.new(0.5, 0), ZIndex = 50, Parent = chip,
			})
			chips[i] = { chip = chip, ic = ic, tl = tl, ang = math.deg(ang) }
		end
		active = 0

		conn = UIS.InputChanged:Connect(function(inp)
			if not root.Visible then return end
			if inp.UserInputType ~= Enum.UserInputType.MouseMovement
				and inp.UserInputType ~= Enum.UserInputType.Touch then return end
			local v = screenPos(inp.Position) - center
			if v.Magnitude < 26 then highlight(0) return end
			local a = math.deg(math.atan2(v.Y, v.X))
			local best, bd = 0, 1e9
			for i = 1, n do
				if chips[i] then
					local d = math.abs(((a - chips[i].ang + 180) % 360) - 180)
					if d < bd then bd = d; best = i end
				end
			end
			highlight(best)
		end)
	end

	local function close()
		if not root.Visible then return end
		local picked = (active > 0 and items[active]) or nil
		root.Visible = false
		clear()
		if picked and picked.Run then
			task.defer(function() pcall(picked.Run) end)
		end
	end

	lib._radialOpen = open
	lib._radialClose = close
end

--==============================================================================
-- 开机自检序列
--==============================================================================
buildBoot = function(lib)
	local layer = lib.Layers.Boot
	local T = Aether.Theme

	local root = create("Frame", {
		Name = "Boot", BackgroundColor3 = T.Bg, Size = UDim2.fromScale(1, 1),
		BorderSizePixel = 0, ZIndex = 1400, Parent = layer,
	})
	gridPattern(root, T.Stroke, 42, 1402)

	local col = create("Frame", {
		Name = "Col", BackgroundTransparency = 1,
		Size = UDim2.fromOffset(540, 0), AutomaticSize = Enum.AutomaticSize.Y,
		Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5),
		ZIndex = 1404, Parent = root,
	})
	list(col, Enum.FillDirection.Vertical, 8)

	-- 标识
	local head = create("Frame", {
		Name = "Head", BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 42), ZIndex = 1406, Parent = col,
	})
	local mark = create("Frame", {
		BackgroundColor3 = T.Accent, Size = UDim2.fromOffset(30, 30),
		Position = UDim2.fromOffset(2, 4), ZIndex = 1408, Parent = head,
	})
	corner(mark, 8)
	icon(mark, "diamond", 16, T.Ink, { ZIndex = 1409 })
	local title = create("TextLabel", {
		BackgroundTransparency = 1, Text = "AETHER",
		Font = Enum.Font.GothamBold, TextSize = 22, TextColor3 = T.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, -50, 0, 26), Position = UDim2.fromOffset(44, 0),
		ZIndex = 1408, Parent = head,
	})
	tb(title, "TextColor3", "Text")
	scramble(title, "AETHER", 0.8)
	create("TextLabel", {
		BackgroundTransparency = 1, Text = "以太界面框架  ·  正在建立神经链路",
		Font = Enum.Font.Code, TextSize = 10, TextColor3 = T.Muted,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, -50, 0, 13), Position = UDim2.fromOffset(44, 27),
		ZIndex = 1408, Parent = head,
	})

	-- 日志
	local logF = create("Frame", {
		Name = "Log", BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		ZIndex = 1406, Parent = col,
	})
	list(logF, Enum.FillDirection.Vertical, 3)

	-- 进度
	local prog = create("Frame", {
		Name = "Prog", BackgroundColor3 = T.Element, BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 6), ZIndex = 1406, Parent = col,
	})
	corner(prog, 3)
	local fill = create("Frame", {
		Name = "Fill", BackgroundColor3 = T.Accent, BorderSizePixel = 0,
		Size = UDim2.new(0, 0, 1, 0), ZIndex = 1407, Parent = prog,
	})
	corner(fill, 3)
	gradient(fill, T.Accent, T.Accent2, 0)
	local pcap = create("TextLabel", {
		Name = "Cap", BackgroundTransparency = 1, Text = "初始化…  0%",
		Font = Enum.Font.Code, TextSize = 10, TextColor3 = T.Muted,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, 0, 0, 14), ZIndex = 1406, Parent = col,
	})

	local function log(text, kind)
		local col_ = T.Muted
		if kind == "ok" then col_ = T.Ok
		elseif kind == "bad" then col_ = T.Muted
		elseif kind == "text" then col_ = T.Text
		elseif kind == "accent" then col_ = T.Accent end
		local lb = create("TextLabel", {
			BackgroundTransparency = 1, Text = "",
			Font = Enum.Font.Code, TextSize = 11.5, TextColor3 = col_,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, 0, 0, 15), ZIndex = 1408, Parent = logF,
		})
		typewriter(lb, text, nil)
		return lb
	end

	task.spawn(function()
		local caps = {
			{ "request", HttpRequest }, { "writefile", WriteFile }, { "readfile", ReadFile },
			{ "getcustomasset", ToAsset }, { "loadstring", LoadString },
			{ "gethui", api("gethui") }, { "setclipboard", api("setclipboard") },
		}
		log("> 引导内核 AETHER KERNEL v" .. Aether.Version, "accent")
		task.wait(0.32)
		log("> 探测执行器能力矩阵", "text")
		task.wait(0.3)
		local online = 0
		for i = 1, #caps do
			local nm, fn = caps[i][1], caps[i][2]
			local lb = log(string.format("   %-16s", nm), "text")
			task.wait(0.07)
			local ok = fn ~= nil
			if ok then online = online + 1 end
			local tag = create("TextLabel", {
				BackgroundTransparency = 1,
				Text = ok and "[ 就绪 ]" or "[ 降级 ]",
				Font = Enum.Font.Code, TextSize = 11,
				TextColor3 = ok and T.Ok or T.Muted,
				TextXAlignment = Enum.TextXAlignment.Left,
				Size = UDim2.fromOffset(90, 15), Position = UDim2.fromOffset(210, 0),
				ZIndex = 1409, Parent = lb,
			})
			local _ = tag
			task.wait(0.05)
		end
		task.wait(0.2)
		log(string.format("> 能力就绪 %d / %d", online, #caps), online > 0 and "ok" or "bad")
		task.wait(0.28)
		log("> 装载主题 " .. tostring(Aether.ThemeName):upper(), "text")
		task.wait(0.24)
		log("> 校准遥测总线 · 挂载界面图层", "text")
		task.wait(0.24)
		log("> 安全信道握手完成", "ok")
		task.wait(0.3)

		local steps = {
			"编译 HUD …", "注入事件总线 …", "生成矢量图标 …", "同步配置 …", "完成",
		}
		for i = 1, #steps do
			pcap.Text = string.format("%s  %d%%", steps[i], math.floor(i / #steps * 100))
			tween(fill, { Size = UDim2.new(i / #steps, 0, 1, 0) }, 0.22, Enum.EasingStyle.Quart)
			task.wait(0.24)
		end

		-- 白场过渡
		local wipe = create("Frame", {
			Name = "Wipe", BackgroundColor3 = T.Accent, BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1), ZIndex = 1420, Parent = root,
		})
		tween(wipe, { BackgroundTransparency = 0.05 }, 0.22, Enum.EasingStyle.Quart)
		task.wait(0.24)
		pcall(function() root:Destroy() end)
		lib:Toggle(true)
		notify(lib, {
			Title = "AETHER 已就绪",
			Desc = "Ctrl+K 指令面板 · F8 控制台 · 按住 ALT 呼出环形菜单",
			Icon = "power",
			Duration = 5.5,
		})
	end)
end

--==============================================================================
-- 公共功能入口
--==============================================================================
function Aether:Palette() if self._palette then self._palette() end end
function Aether:Console() if self._console then self._console() end end
function Aether:ConsoleRun(code) if self._run then self._run(code) end end
function Aether:Log(text, kind) if self._log then self._log(text, kind) end end
function Aether:RadialOpen() if self._radialOpen then self._radialOpen() end end
function Aether:RadialClose() if self._radialClose then self._radialClose() end end
function Aether:HudToggle() if self._hudToggle then self._hudToggle() end end

Aether.Section = Section

-- 导出全局，方便「库里一份、示例一份」分开执行时也能拿到 Aether
if type(getgenv) == "function" then pcall(function() getgenv().Aether = Aether end) end
pcall(function() _G.Aether = Aether end)
if type(getgenv) == "function" and getgenv().Aether ~= Aether then
	-- 某些执行器 getgenv 不可写，兜底写 _G
	pcall(function() _G.Aether = Aether end)
end


--==============================================================================
--  AETHER UI · 示例 Example
--  最小可运行骨架：两页、三卡片、常用控件全覆盖。
--  用法：先执行 Aether.lua（库本体），再执行本文件。
--==============================================================================
if not Aether then
	error("[AETHER] 请先加载 Aether.lua 库本体，再运行本示例。")
end

-- 1) 创建实例 ---------------------------------------------------------------
local lib = Aether.new({
	Name  = "AETHER",
	-- Icon  = "https://example.com/logo.png",  -- 可选：自定义左上角 / 悬浮窗图标（网络图）
	Theme = "void",
	-- Boot = false,      -- 跳过开机自检
	-- Persist = false,   -- 关闭配置持久化
})

-- 2) 左侧主侧边栏：一个页面 -------------------------------------------------
local pageMain = lib:Page("主页", "home")
local tabCore  = pageMain:Tab("核心", "power")
local tabLook  = pageMain:Tab("外观", "palette")

-- 3) 卡片 + 控件 ------------------------------------------------------------
local sec1 = tabCore:Section({ Title = "功能开关", Desc = "点击即时生效", Icon = "bolt" })

sec1:Toggle({
	Title = "示例开关", Desc = "带配置存档的布尔项", Default = false, Flag = "demo_toggle",
	Callback = function(v)
		lib:Notify({ Title = v and "示例开关 已开启" or "示例开关 已关闭", Icon = "power", Duration = 2 })
	end,
})

sec1:Slider({
	Title = "示例滑条", Desc = "拖动 / 滚轮均可调", Min = 0, Max = 100, Step = 5,
	Default = 50, Suffix = "%", Flag = "demo_slider",
})

sec1:Dropdown({
	Title = "示例下拉", Options = { "选项 A", "选项 B", "选项 C" }, Default = 1,
	Flag = "demo_dropdown",
})

sec1:Keybind({
	Title = "示例热键", Desc = "点击后按任意按键", Flag = "demo_key",
	Callback = function(key) lib:Log("热键触发：" .. tostring(key and key.Name), "accent") end,
})

local sec2 = tabLook:Section({ Title = "外观示例", Icon = "palette" })

sec2:ColorPicker({ Title = "示例颜色", Default = Color3.fromRGB(0, 226, 255), Flag = "demo_color" })
sec2:Segmented({ Title = "示例分段", Options = { "低", "中", "高" }, Default = 2, Flag = "demo_seg" })
sec2:Progress({ Title = "示例进度", Default = 0.4 })
sec2:Graph({ Title = "实时帧率", Source = "fps" })  -- 绑定内置遥测

local sec3 = tabLook:Section({ Title = "操作示例", Icon = "terminal" })
sec3:Button({ Title = "切换主题", Icon = "palette", Callback = function() lib:CycleTheme() end })
sec3:Button({ Title = "指令面板 (Ctrl+K)", Icon = "search", Callback = function() lib:Palette() end })
sec3:Button({ Title = "控制台 (F8)", Desc = "直接执行 Lua", Icon = "terminal",
	Variant = "ghost", Callback = function() lib:Console() end })
sec3:Label({ Title = "版本", Text = "AETHER v" .. Aether.Version })
sec3:Divider()
sec3:Note({ Text = "右键任意控件：重置 / 复制 / 固定到快捷栏；固定后按住 ALT 用环形菜单触发。" })

-- 4) 第二个页面（可选，演示多页切换） ---------------------------------------
local pageAbout = lib:Page("关于", "user")
local tabInfo = pageAbout:Tab("信息", "scan")
local secInfo = tabInfo:Section({ Title = "关于本库", Icon = "globe" })
secInfo:Label({ Title = "框架", Text = "AETHER 以太界面框架" })
secInfo:Label({ Title = "主题数", Text = "5 套" })
secInfo:Button({ Title = "发送一条通知", Icon = "bolt",
	Callback = function()
		lib:Notify({ Title = "来自示例的通知", Desc = "右下角堆叠卡片", Icon = "check" })
	end,
})

-- 5) 收尾 -------------------------------------------------------------------
lib:Select(pageMain, tabCore)
lib:Notify({ Title = "示例已加载", Desc = "Ctrl+K 指令面板 · F8 控制台 · ALT 环形菜单", Duration = 5 })