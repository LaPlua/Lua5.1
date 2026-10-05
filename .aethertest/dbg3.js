const fs=require('fs');
const { lua, lauxlib, lualib, to_luastring, to_jsstring } = require('/tmp/luacheck/node_modules/fengari');
const L = lauxlib.luaL_newstate(); lualib.luaL_openlibs(L);
function run(file,setG){ const code=fs.readFileSync(file,'utf8'); const st=lauxlib.luaL_loadbuffer(L,to_luastring(code),code.length,to_luastring(file)); if(st!==lua.LUA_OK){console.log('LOADERR',file,to_jsstring(lua.lua_tostring(L,-1)));process.exit(1);} const r=lua.lua_pcall(L,0,1,0); if(r!==lua.LUA_OK){console.log('RUNERR',file,to_jsstring(lua.lua_tostring(L,-1)));process.exit(1);} if(setG) lua.lua_setglobal(L,to_luastring(setG)); lua.lua_settop(L,0); }
function gt(n){ lua.lua_getglobal(L,to_luastring(n)); const t=lua.lua_type(L,-1); let v=t===lua.LUA_TSTRING?to_jsstring(lua.lua_tostring(L,-1)):('type'+t); lua.lua_settop(L,0); return v; }
run('.aethertest/prelude.lua');
run('Aether.lua','Aether');
run('Aether-Example.lua');
run('__MARKPRE = "before-drain"', null);
console.log('__MARKPRE =', gt('__MARKPRE'));
run('.aethertest/drain.lua');
console.log('__REPORT =', gt('__REPORT'));
console.log('Aether   =', gt('Aether'));
