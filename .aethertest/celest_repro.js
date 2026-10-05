// 复现：开关打开后，各种点击是否会把它关掉
const fs = require('fs');
const path = require('path');
const { lua, lauxlib, lualib, to_luastring, to_jsstring } = require('/tmp/luacheck/node_modules/fengari');

const L = lauxlib.luaL_newstate();
lualib.luaL_openlibs(L);

function runFile(file) {
  const code = fs.readFileSync(file, 'utf8');
  let st = lauxlib.luaL_loadbuffer(L, to_luastring(code), code.length, to_luastring(path.basename(file)));
  if (st !== lua.LUA_OK) { console.log('SYNTAX_ERROR ' + file + '\n  ' + to_jsstring(lua.lua_tostring(L, -1))); process.exit(2); }
  lua.lua_getglobal(L, to_luastring('debug'));
  lua.lua_getfield(L, -1, to_luastring('traceback'));
  lua.lua_remove(L, -2); lua.lua_insert(L, -2);
  st = lua.lua_pcall(L, 0, 1, 1);
  if (st !== lua.LUA_OK) { console.log('RUNTIME_ERROR ' + file + '\n' + to_jsstring(lua.lua_tostring(L, -1))); process.exit(3); }
}

runFile('/workspace/.aethertest/prelude.lua');
lua.lua_settop(L, 0);
runFile('/workspace/Celest.lua');
lua.lua_setglobal(L, to_luastring('Celest'));
lua.lua_settop(L, 0);

lauxlib.luaL_dostring(L, to_luastring(`
__ERR = {}
local function try(n, f) local ok, e = xpcall(f, function(e) return debug.traceback(tostring(e),2) end); if not ok then __ERR[#__ERR+1] = n.." -> "..tostring(e) end end

local win = Celest.new({ title = "T" })
local c1 = win:Category("兵戈", "✦")
local tg = c1:Toggle("自动瞄准", false)
local sl = c1:Slider("半径", 0, 100, 50)
local c2 = win:Category("观照", "◈")
c2:Toggle("描边", true)

try("drain", function() __drain(6000) end)

local CoreGui = game:GetService("CoreGui")
local gui
for _, d in ipairs(CoreGui:GetChildren()) do if d.Name == "CelestUI" then gui = d end end

local map
for _, d in ipairs(gui:GetDescendants()) do if d.Name == "CelestMap" then map = d end end

win:Open()
try("drain2", function() __drain(2000) end)

local function dotOf(it) return it._ui and it._ui.dot end
local function isOn(it)
	local d = dotOf(it)
	return d and d.BackgroundTransparency == 0 and d.BackgroundColor3.R > 0.5 and d.BackgroundColor3.B > 0.5
end
local function btnOf(it) return it._ui.node:FindFirstChildOfClass("TextButton") end

local log = {}
local function snap(tag)
	log[#log+1] = tag .. " value=" .. tostring(tg.value) .. " dotOn=" .. tostring(isOn(tg))
end

snap("初始")

-- 1) 点开关 → 应为开
try("click-toggle", function() btnOf(tg).MouseButton1Click:Fire() end)
snap("点开关后")

-- 2) 点击空白全屏层
local blank
for _, d in ipairs(gui:GetDescendants()) do
	if d.ClassName == "TextButton" and d.Size and d.Size.X.Scale == 1 and d.Size.Y.Scale == 1 then blank = d end
end
try("click-blank", function() if blank then blank.MouseButton1Click:Fire() end end)
snap("点空白后")

-- 3) 点一个数值星（进入选中态），再点空白
try("select-slider", function() btnOf(sl).MouseButton1Down:Fire() end)
try("click-blank2", function() if blank then blank.MouseButton1Click:Fire() end end)
snap("选数值星+点空白后")

-- 4) 切到观照再切回
try("switch", function()
	for _, d in ipairs(map:GetDescendants()) do
		if d.ClassName == "TextButton" and d.Text == "◈" then d.MouseButton1Click:Fire() end
	end
	__drain(1500)
	for _, d in ipairs(map:GetDescendants()) do
		if d.ClassName == "TextButton" and d.Text == "✦" then d.MouseButton1Click:Fire() end
	end
	__drain(1500)
end)
snap("切分类回来")

-- 5) 松 ALT
try("alt-up", function()
	game:GetService("UserInputService").InputEnded:Fire({ KeyCode = Enum.KeyCode.LeftAlt, UserInputType = Enum.UserInputType.Keyboard })
end)
__drain(1500)
snap("松开ALT后")

__REPORT = log
`));

function readGlobalArray(name) {
  lua.lua_getglobal(L, to_luastring(name));
  const idx = lua.lua_gettop(L);
  if (lua.lua_type(L, idx) !== lua.LUA_TTABLE) { lua.lua_pop(L, 1); return []; }
  const len = lua.lua_rawlen(L, idx);
  const out = [];
  for (let i = 1; i <= len; i++) { lua.lua_rawgeti(L, idx, i); out.push(to_jsstring(lua.lua_tostring(L, -1))); lua.lua_pop(L, 1); }
  lua.lua_pop(L, 1);
  return out;
}
readGlobalArray('__REPORT').forEach(s => console.log('   ' + s));
const errs = readGlobalArray('__ERR');
if (errs.length) { console.log('FAIL：'); errs.forEach(s => console.log('   ' + s)); process.exit(4); }
console.log('done');