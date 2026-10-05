// 运行 Celest 示例：模拟 game:HttpGet 返回库源码，验证文档示例端到端可跑
// 可用 CELEST_TARGET=/workspace/Celest-Demo.lua 指定其它示例
const fs = require('fs');
const path = require('path');
const { lua, lauxlib, lualib, to_luastring, to_jsstring } = require('/tmp/luacheck/node_modules/fengari');

const TARGET = process.env.CELEST_TARGET || '/workspace/Celest-Example.lua';

const L = lauxlib.luaL_newstate();
lualib.luaL_openlibs(L);

function runFile(file, expectReturn) {
  const code = fs.readFileSync(file, 'utf8');
  let st = lauxlib.luaL_loadbuffer(L, to_luastring(code), code.length, to_luastring(path.basename(file)));
  if (st !== lua.LUA_OK) { console.log('SYNTAX_ERROR ' + file + '\n  ' + to_jsstring(lua.lua_tostring(L, -1))); process.exit(2); }
  lua.lua_getglobal(L, to_luastring('debug'));
  lua.lua_getfield(L, -1, to_luastring('traceback'));
  lua.lua_remove(L, -2);
  lua.lua_insert(L, -2);
  st = lua.lua_pcall(L, 0, expectReturn ? 1 : 0, 1);
  if (st !== lua.LUA_OK) { console.log('RUNTIME_ERROR ' + file + '\n' + to_jsstring(lua.lua_tostring(L, -1))); process.exit(3); }
}

runFile('/workspace/.aethertest/prelude.lua', false);
lua.lua_settop(L, 0);

// 把库源码塞进全局，供示例的 game:HttpGet 返回
lua.lua_pushstring(L, to_luastring(fs.readFileSync('/workspace/Celest.lua', 'utf8')));
lua.lua_setglobal(L, to_luastring('__CELEST_SRC'));
lauxlib.luaL_dostring(L, to_luastring(
  'function game:HttpGet(url) return __CELEST_SRC end\n' +
  '__ERR = {}\n' +
  'local ok, err = xpcall(function() __drain(6000) end, function(e) return debug.traceback(tostring(e),2) end)\n' +
  'if not ok then __ERR[#__ERR+1] = tostring(err) end'
));
lua.lua_settop(L, 0);

// 直接执行示例（内含 loadstring(game:HttpGet(...)) 建窗）
runFile(TARGET, false);

lauxlib.luaL_dostring(L, to_luastring('__drain(6000)'));
lua.lua_settop(L, 0);

lauxlib.luaL_dostring(L, to_luastring(`
local CoreGui = game:GetService("CoreGui")
local gui
for _, d in ipairs(CoreGui:GetChildren()) do if d.Name == "CelestUI" then gui = d end end
local stars, cats, brand = 0, 0, false
if gui then
	for _, d in ipairs(gui:GetDescendants()) do
		if d.Name == "CelestBrand" then brand = d end
		if d.Name == "CelestMap" then
			for _, e in ipairs(d:GetDescendants()) do
				if e.Name == "CelestCategory" then cats = cats + 1
				elseif e.Name == "CelestStar" then stars = stars + 1 end
			end
		end
	end
end
__REPORT = {
	"示例建窗=" .. tostring(gui ~= nil),
	"内环分类星点=" .. tostring(cats) .. "（应为 4）",
	"当前分类功能星节点=" .. tostring(stars),
	"开环后品牌可见=" .. tostring(brand and brand.Visible),
}
`));
lua.lua_settop(L, 0);

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
console.log('PASS：' + path.basename(TARGET) + ' 端到端');