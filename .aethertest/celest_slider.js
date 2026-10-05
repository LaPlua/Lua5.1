// 滑块「点按开/关」回归：fengari(Lua5.1) + 严格 Roblox 模拟
const fs = require('fs');
const path = require('path');
const { lua, lauxlib, lualib, to_luastring, to_jsstring } = require('/tmp/luacheck/node_modules/fengari');

const L = lauxlib.luaL_newstate();
lualib.luaL_openlibs(L);

function runFile(file, setGlobal) {
  const code = fs.readFileSync(file, 'utf8');
  let st = lauxlib.luaL_loadbuffer(L, to_luastring(code), code.length, to_luastring(path.basename(file)));
  if (st !== lua.LUA_OK) {
    console.log('SYNTAX_ERROR  ' + path.basename(file) + '\n  ' + to_jsstring(lua.lua_tostring(L, -1)));
    process.exit(2);
  }
  lua.lua_getglobal(L, to_luastring('debug'));
  lua.lua_getfield(L, -1, to_luastring('traceback'));
  lua.lua_remove(L, -2);
  lua.lua_insert(L, -2);
  st = lua.lua_pcall(L, 0, 1, 1);
  if (st !== lua.LUA_OK) {
    console.log('RUNTIME_ERROR  ' + path.basename(file) + '\n' + to_jsstring(lua.lua_tostring(L, -1)));
    process.exit(3);
  }
  if (setGlobal) lua.lua_setglobal(L, to_luastring(setGlobal));
  lua.lua_settop(L, 0);
}

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

runFile('/workspace/.aethertest/prelude.lua');
runFile('/workspace/Celest.lua', 'Celest');
runFile('/workspace/.aethertest/celest_slider_test.lua');
readGlobalArray('__REPORT').forEach(s => console.log('      ' + s));
const errs = readGlobalArray('__ERR');
if (errs.length > 0) {
  console.log('FAIL（' + errs.length + ' 处）：');
  errs.slice(0, 40).forEach(s => console.log('      ' + s));
  process.exit(4);
}
console.log('PASS：滑块点按开关回归');