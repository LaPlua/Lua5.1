const fs=require('fs');
const { lua, lauxlib, lualib, to_luastring, to_jsstring } = require('/tmp/luacheck/node_modules/fengari');
const L = lauxlib.luaL_newstate(); lualib.luaL_openlibs(L);
function run(code,name,nres){ const st=lauxlib.luaL_loadbuffer(L,to_luastring(code),code.length,to_luastring(name)); if(st!==lua.LUA_OK){console.log('LOADERR',to_jsstring(lua.lua_tostring(L,-1)));process.exit(1);} const r=lua.lua_pcall(L,0,nres||0,0); if(r!==lua.LUA_OK){console.log('RUNERR',name,to_jsstring(lua.lua_tostring(L,-1)));process.exit(1);} }
function g(n){ lua.lua_getglobal(L,to_luastring(n)); const t=lua.lua_type(L,-1); const v=t===lua.LUA_TNIL?null:to_jsstring(lua.lua_tostring(L,-1)); lua.lua_settop(L,0); return [t,v]; }
run(fs.readFileSync('.aethertest/prelude.lua','utf8'),'prelude');
run('__PROBE = 123', 'probe1');
console.log('after prelude-only probe:', g('__PROBE'));
run(fs.readFileSync('Aether.lua','utf8'),'Aether',1);
lua.lua_setglobal(L,to_luastring('Aether'));
run('__PROBE2 = 456', 'probe2');
console.log('after library probe2:', g('__PROBE2'));
console.log('Aether global type:', g('Aether')[0]);
