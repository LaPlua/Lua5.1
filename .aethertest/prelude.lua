-- Roblox 运行时模拟 · 严格模式（访问实例上不存在的成员即报错，与 Roblox 行为一致）
local function signal()
	local s = {}
	function s:Connect(fn) s._fns = s._fns or {}; table.insert(s._fns, fn); return { Disconnect = function() end } end
	function s:ConnectParallel(fn) return s:Connect(fn) end
	function s:Once(fn) return s:Connect(fn) end
	function s:Wait() end
	function s:Fire(...) if s._fns then for i = 1, #s._fns do s._fns[i](...) end end end
	return s
end

local EVENT = {}
for _, n in ipairs({
	"MouseEnter","MouseLeave","MouseButton1Click","MouseButton2Click",
	"MouseButton1Down","MouseButton1Up","MouseButton2Down","MouseButton2Up",
	"InputBegan","InputChanged","InputEnded","FocusLost","Focused","Changed",
	"Activated","DragBegin","DragEnd","ChildAdded","ChildRemoved","AncestryChanged",
	"SelectionGained","SelectionLost","TextChanged","WindowFocused","WindowFocusReleased",
	"DescendantAdded","DescendantRemoving","TouchTap","TouchLongPress",
}) do EVENT[n] = true end

-- Roblox 合法属性白名单
local VALID = {}
for _, n in ipairs({
	"Name","Parent","ClassName","Archivable",
	"Size","Position","AnchorPoint","Rotation","Visible","ZIndex","LayoutOrder",
	"ClipsDescendants","BorderSizePixel","BorderColor3","BackgroundColor3","BackgroundTransparency",
	"AutomaticSize","AutomaticCanvasSize","CanvasSize","CanvasPosition","ScrollingDirection",
	"ScrollBarThickness","ScrollBarImageColor3","ScrollBarImageTransparency","ScrollingEnabled",
	"ElasticBehavior","VerticalScrollBarInset","HorizontalScrollBarInset",
	"Text","TextSize","TextColor3","TextTransparency","TextStrokeColor3","TextStrokeTransparency",
	"TextXAlignment","TextYAlignment","TextTruncate","TextWrapped","TextScaled","TextFits","RichText",
	"Font","FontFace","LineHeight","MaxVisibleGraphemes","PlaceholderText","PlaceholderColor3",
	"ClearTextOnFocus","MultiLine","TextEditable",
	"Image","ImageColor3","ImageTransparency","ImageRectOffset","ImageRectSize","ScaleType",
	"SliceCenter","SliceScale","TileSize","ResampleMode",
	"CornerRadius","Thickness","Color","Transparency","ApplyStrokeMode","LineJoinMode",
	"FillDirection","Padding","SortOrder","HorizontalAlignment","VerticalAlignment","Wraps",
	"HorizontalFlex","VerticalFlex",
	"PaddingTop","PaddingBottom","PaddingLeft","PaddingRight",
	"Offset","Scale",
	"DisplayOrder","IgnoreGuiInset","ResetOnSpawn","ZIndexBehavior","Enabled","OnTopOfCoreBlur",
	"ClipToDeviceSafeArea","SafeAreaCompatibility","ScreenInsets",
	"Active","AutoButtonColor","Modal","Selected","Style","Selectable","Interactable",
	"AbsoluteSize","AbsolutePosition","AbsoluteContentSize","AbsoluteRotation",
	"AbsoluteCanvasSize","AbsoluteWindowSize","TextBounds","SelectionImageObject",
	"GroupTransparency","Keypoints","Value","LayoutOrder",
	"UserId","DisplayName","Character","Team","AccountAge","MembershipType","PlayerGui","GetMouse",
	"CurrentCamera","FieldOfView","Workspace",
}) do VALID[n] = true end

local V2 = function(x, y) return { X = x or 0, Y = y or 0 } end
local DIM = function() return { X = { Scale = 0, Offset = 0 }, Y = { Scale = 0, Offset = 0 } } end
local COL = function() return { R = 0, G = 0, B = 0 } end

local DEFAULTS = {
	Visible = true, BackgroundTransparency = 0, TextTransparency = 0, ImageTransparency = 0,
	TextStrokeTransparency = 0, Rotation = 0, ZIndex = 1, LayoutOrder = 0,
	Text = "", Image = "", TextSize = 14, Thickness = 1, Transparency = 0, Scale = 1,
	ClipsDescendants = false, AutoButtonColor = true, Interactable = true, Selectable = false,
	Enabled = true, Active = false, BackgroundColor3 = COL(), TextColor3 = { R = 1, G = 1, B = 1 },
	CanvasPosition = V2(), CanvasSize = V2(), AbsoluteCanvasSize = V2(),
	AbsoluteWindowSize = V2(100, 100), AbsoluteSize = V2(100, 30), AbsolutePosition = V2(),
	TextBounds = V2(50, 20), AbsoluteRotation = 0, AbsoluteContentSize = V2(),
	AnchorPoint = V2(), Position = DIM(), Size = DIM(),
}

local CHILDREN = setmetatable({}, { __mode = "k" })

-- 记录非法成员访问（含调用栈位置），随后抛错
__INVALID = {}
local function invalid(kind, k, class)
	local t = debug.traceback("", 4)
	local frame = (t:match("\n[^\n]*") or ""):gsub("^%s+", "")
	__INVALID[#__INVALID + 1] = kind .. " '" .. tostring(k) .. "' on " .. tostring(class) .. "  @  " .. frame
	error(kind .. " '" .. tostring(k) .. "' on " .. tostring(class), 0)
end

local METHODS = {}
function METHODS.Destroy(self) end
function METHODS.ClearAllChildren(self) CHILDREN[self] = {} end
function METHODS.GetChildren(self) return CHILDREN[self] or {} end
function METHODS.GetDescendants(self)
	local out = {}
	local function walk(o) for _, c in ipairs(CHILDREN[o] or {}) do out[#out + 1] = c; walk(c) end end
	walk(self); return out
end
function METHODS.FindFirstChild(self, name)
	for _, c in ipairs(CHILDREN[self] or {}) do if c.Name == name then return c end end
end
function METHODS.FindFirstChildOfClass(self, cls)
	for _, c in ipairs(CHILDREN[self] or {}) do if c.ClassName == cls then return c end end
end
function METHODS.FindFirstChildWhichIsA(self, cls) return METHODS.FindFirstChildOfClass(self, cls) end
function METHODS.WaitForChild(self, name) return METHODS.FindFirstChild(self, name) or newInst("Folder") end
function METHODS.IsA(self, cls) return true end
function METHODS.Clone(self) return newInst(self.ClassName) end
function METHODS.GetPropertyChangedSignal(self, p)
	local st = rawget(self, "__pcs")
	if not st then return signal() end
	return signal()
end
function METHODS.GetAttribute(self, k) return nil end
function METHODS.SetAttribute(self, k, v) end
function METHODS.GetFullName(self) return self.Name end
function METHODS.GetDebugId(self) return "0" end
function METHODS.Release() end
function METHODS.CaptureFocus(self) end
function METHODS.ReleaseFocus(self) end
function METHODS.GetTouches(self) return {} end
function METHODS.IsMouseButtonPressed(self) return false end

function newInst(class)
	local props = { ClassName = class, Name = class }
	local t = {}
	CHILDREN[t] = {}
	setmetatable(t, {
		__index = function(_, k)
			if METHODS[k] then return METHODS[k] end
			if EVENT[k] then props[k] = props[k] or signal(); return props[k] end
			local v = props[k]
			if v ~= nil then return v end
			if DEFAULTS[k] ~= nil then return DEFAULTS[k] end
			if VALID[k] then return nil end
			invalid("INVALID_READ", k, class)
		end,
		__newindex = function(self, k, v)
			if k == "Parent" then
				local old = props.Parent
				if old and CHILDREN[old] then
					for i, c in ipairs(CHILDREN[old]) do if c == self then table.remove(CHILDREN[old], i) break end end
				end
				props.Parent = v
				if v and CHILDREN[v] then CHILDREN[v][#CHILDREN[v] + 1] = self end
				return
			end
			if not (VALID[k] or METHODS[k] or EVENT[k]) then
				error("INVALID_WRITE '" .. tostring(k) .. "' on " .. tostring(class), 0)
			end
			props[k] = v
		end,
		__tostring = function() return class end,
	})
	return t
end

Instance = { new = function(c) return newInst(c) end }

local function enumNS(prefix)
	return setmetatable({}, { __index = function(_, k) return prefix .. "." .. k end })
end
Enum = setmetatable({}, { __index = function(_, k) return enumNS(k) end })

Vector2 = { new = function(x, y) return V2(x, y) end }
Vector3 = { new = function(x, y, z) return { X = x or 0, Y = y or 0, Z = z or 0 } end }
UDim = { new = function(s, o) return { Scale = s or 0, Offset = o or 0 } end }
UDim2 = {
	new = function(xs, xo, ys, yo)
		return setmetatable({ X = UDim.new(xs, xo), Y = UDim.new(ys, yo) }, {
			__add = function(a, b)
				return UDim2.new(a.X.Scale + b.X.Scale, a.X.Offset + b.X.Offset,
					a.Y.Scale + b.Y.Scale, a.Y.Offset + b.Y.Offset)
			end,
			__sub = function(a, b)
				return UDim2.new(a.X.Scale - b.X.Scale, a.X.Offset - b.X.Offset,
					a.Y.Scale - b.Y.Scale, a.Y.Offset - b.Y.Offset)
			end,
		})
	end,
	fromOffset = function(x, y) return UDim2.new(0, x, 0, y) end,
	fromScale = function(x, y) return UDim2.new(x, 0, y, 0) end,
}
Color3 = {
	fromRGB = function(r, g, b) return { R = r / 255, G = g / 255, B = b / 255 } end,
	new = function(r, g, b) return { R = r, G = g, B = b } end,
	fromHSV = function(h, s, v) return { R = v, G = v, B = v } end,
	toHSV = function(c)
		local r, g, b = c.R or 0, c.G or 0, c.B or 0
		local mx, mn = math.max(r, g, b), math.min(r, g, b)
		local d = mx - mn
		local h = 0
		if d > 0 then
			if mx == r then h = ((g - b) / d) % 6
			elseif mx == g then h = (b - r) / d + 2
			else h = (r - g) / d + 4 end
			h = h / 6
		end
		return h, (mx == 0 and 0 or d / mx), mx
	end,
}
ColorSequence = { new = function(a, b) return {} end }
NumberSequence = { new = function(a, b) if type(a) == "table" then return a end return {} end }
NumberSequenceKeypoint = { new = function(t, v) return { Time = t, Value = v } end }
ColorSequenceKeypoint = { new = function(t, c) return { Time = t, Value = c } end }
TweenInfo = { new = function(...) return { ... } end }
Rect = { new = function(...) return {} end }

local CAMERA = { ViewportSize = V2(1280, 720), FieldOfView = 70, CFrame = {} }
function CAMERA:GetPropertyChangedSignal(p) return signal() end
local LP = newInst("Player")
LP.UserId = 1
LP.Name = "Tester"
LP.DisplayName = "Tester"
function LP:GetMouse() return { Hit = Vector3.new(0, 0, 0), Target = nil, UnitRay = {} } end

local SERVICES = {}
local function SVC(name, obj) obj = obj or newInst(name); SERVICES[name] = obj; return obj end

SVC("CoreGui")
SVC("RunService", {
	Heartbeat = signal(), RenderStepped = signal(), Stepped = signal(),
	PreSimulation = signal(), PostSimulation = signal(), PreRender = signal(),
	IsStudio = function() return false end, IsClient = function() return true end,
	IsServer = function() return false end,
})
SVC("TweenService", {
	Create = function(self, inst, info, props) return { Play = function() end, Cancel = function() end, Completed = signal() } end,
})
SVC("UserInputService", {
	InputBegan = signal(), InputChanged = signal(), InputEnded = signal(),
	WindowFocused = signal(), TouchEnabled = false, MouseEnabled = true,
	KeyboardEnabled = true, MouseIconEnabled = true, GamepadEnabled = false,
	GetMouseLocation = function() return V2(640, 360) end,
	GetFocusedTextBox = function() return nil end,
	IsKeyDown = function() return false end,
})
SVC("Players", {
	LocalPlayer = LP, GetPlayers = function() return { LP } end,
	PlayerAdded = signal(), PlayerRemoving = signal(), GetPlayerFromCharacter = function() return nil end,
})
SVC("Stats", {
	Network = { ServerStatsItem = { ["Data Ping"] = { GetValue = function() return 42 end } } },
	GetTotalMemoryUsageMb = function() return 1024 end,
})
SVC("StarterGui", { SetCore = function() end, SetCoreGuiEnabled = function() end })

game = { GetService = function(self, n) return SERVICES[n] or SVC(n) end, PlaceId = 0, JobId = "test", Workspace = nil }
workspace = newInst("Workspace")
workspace.CurrentCamera = CAMERA
game.Workspace = workspace

__COROS = {}
local function cosPawn(fn, ...)
	local co = coroutine.create(fn)
	__COROS[#__COROS + 1] = co
	local ok, err = coroutine.resume(co, ...)
	if not ok then error("TASK_RUNTIME_ERROR: " .. tostring(err), 0) end
end

task = {
	spawn = cosPawn, defer = cosPawn,
	delay = function(_, fn) cosPawn(fn) end,
	wait = function() coroutine.yield() end,
	cancel = function() end,
}

function __drain(maxn)
	local n = 0
	while #__COROS > 0 and n < (maxn or 400000) do
		local alive = {}
		for _, co in ipairs(__COROS) do
			if coroutine.status(co) == "suspended" then
				n = n + 1
				local ok, err = coroutine.resume(co)
				if not ok then error("TASK_RUNTIME_ERROR: " .. tostring(err), 0) end
			end
			if coroutine.status(co) ~= "dead" then alive[#alive + 1] = co end
		end
		__COROS = alive
	end
	return n
end

-- 遍历并触发控件上的鼠标事件（覆盖悬停气泡 / 右键菜单 / 点击回调等路径）
function __fireEvents()
	__ERR = {}
	local function try(name, fn)
		local ok, err = xpcall(fn, function(e) return debug.traceback(tostring(e), 2) end)
		if not ok then __ERR[#__ERR + 1] = name .. " -> " .. tostring(err) end
	end
	local all = game:GetService("CoreGui"):GetDescendants()
	local input = {
		UserInputType = Enum.UserInputType.MouseButton1,
		KeyCode = Enum.KeyCode.Unknown,
		Position = Vector3.new(10, 10, 0),
	}
	local keyInput = {
		UserInputType = Enum.UserInputType.Keyboard,
		KeyCode = Enum.KeyCode.F,
		Position = Vector3.new(0, 0, 0),
	}
	for _, d in ipairs(all) do
		try("MouseEnter:" .. d.ClassName, function() d.MouseEnter:Fire() end)
		try("MouseLeave:" .. d.ClassName, function() d.MouseLeave:Fire() end)
		try("LMB:" .. d.ClassName, function() d.MouseButton1Click:Fire() end)
		try("RMB:" .. d.ClassName, function() d.MouseButton2Click:Fire() end)
		try("DragBegin:" .. d.ClassName, function() d.InputBegan:Fire(input) end)
		try("FocusLost:" .. d.ClassName, function() d.FocusLost:Fire(true) end)
		try("Focused:" .. d.ClassName, function() d.Focused:Fire() end)
	end
	local UIS = game:GetService("UserInputService")
	try("UIS.InputBegan(鼠标)", function() UIS.InputBegan:Fire(input, false) end)
	try("UIS.InputBegan(键盘)", function() UIS.InputBegan:Fire(keyInput, false) end)
	try("UIS.InputChanged", function() UIS.InputChanged:Fire(input) end)
	try("UIS.InputEnded", function() UIS.InputEnded:Fire(input) end)
	__drain(400000)
	return #all
end

function getgenv() return _G end
warn = print
tick = os.clock
loadstring = loadstring or load

table.find = table.find or function(t, v) for i, x in ipairs(t) do if x == v then return i end end end
table.create = table.create or function(n, v) local t = {} for i = 1, (n or 0) do t[i] = v end return t end
table.clear = table.clear or function(t) for k in pairs(t) do t[k] = nil end end
math.clamp = math.clamp or function(x, lo, hi) return math.max(lo, math.min(hi, x)) end
math.round = math.round or function(x) return math.floor(x + 0.5) end
string.split = string.split or function(s, sep) local o = {} for m in string.gmatch(s, "([^" .. sep .. "]+)") do o[#o + 1] = m end return o end
table.pack = table.pack or function(...) return { n = select("#", ...), ... } end
if not table.unpack then
	table.unpack = function(t, i, j)
		i = i or 1; j = j or #t
		if i > j then return end
		return t[i], table.unpack(t, i + 1, j)
	end
end