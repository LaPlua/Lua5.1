// Celest 库验证：fengari(Lua5.1) + 严格 Roblox 模拟
const fs = require('fs');
const path = require('path');
const { lua, lauxlib, lualib, to_luastring, to_jsstring } = require('/tmp/luacheck/node_modules/fengari');

const L = lauxlib.luaL_newstate();
lualib.luaL_openlibs(L);

function runFile(file) {
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
  return 1; // 返回值留在栈顶
}

runFile('/workspace/.aethertest/prelude.lua');
lua.lua_settop(L, 0);

// 加载库并把它设为全局 Celest
runFile('/workspace/Celest.lua');
lua.lua_setglobal(L, to_luastring('Celest'));
lua.lua_settop(L, 0);
console.log('  [1] Celest.lua 加载 OK');

runFile('/workspace/.aethertest/celest_lib_test.lua');
lua.lua_settop(L, 0);
console.log('  [2] 库交互验证完成');

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
readGlobalArray('__REPORT').forEach(s => console.log('      ' + s));
const errs = readGlobalArray('__ERR');
if (errs.length > 0) {
  console.log('FAIL（' + errs.length + ' 处）：');
  errs.slice(0, 40).forEach(s => console.log('      ' + s));
  process.exit(4);
}
console.log('PASS：Celest.lua');