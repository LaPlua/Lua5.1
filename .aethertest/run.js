// AETHER 严格运行时验证：fengari(Lua 5.1) + 严格 Roblox 模拟（非法成员访问即报错）
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
  // 错误处理函数：debug.traceback（必须位于被调函数之下）
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
  for (let i = 1; i <= len; i++) {
    lua.lua_rawgeti(L, idx, i);
    out.push(to_jsstring(lua.lua_tostring(L, -1)));
    lua.lua_pop(L, 1);
  }
  lua.lua_pop(L, 1);
  return out;
}

const target = process.argv[2] || '/workspace/Aether-Example.lua';
console.log('== 目标：' + path.basename(target) + ' ==');

runFile('/workspace/.aethertest/prelude.lua');
runFile('/workspace/Aether.lua', 'Aether');
console.log('  [1] 库加载 OK');
runFile(target);
console.log('  [2] 目标脚本执行 OK');
runFile('/workspace/.aethertest/drain.lua');
lua.lua_getglobal(L, to_luastring('__REPORT'));
console.log('DIAG __REPORT type=' + lua.lua_type(L, -1) + ' len=' + lua.lua_rawlen(L, -1));
lua.lua_settop(L, 0);
readGlobalArray('__REPORT').forEach(s => console.log('  ' + s));
console.log('  [3] 异步任务（开机自检）排空 OK');

runFile('/workspace/.aethertest/events.lua');
const errs = readGlobalArray('__ERR');
if (errs.length > 0) {
  console.log('  [4] 事件触发 FAIL（' + errs.length + ' 处）：');
  errs.slice(0, 40).forEach(s => console.log('      ' + s));
  process.exit(4);
}
console.log('  [4] 事件触发（悬停/点击/右键/拖拽/输入）OK');
console.log('PASS：' + path.basename(target));