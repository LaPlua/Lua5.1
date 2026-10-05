const { lua, lauxlib, lualib, to_luastring, to_jsstring } = require('/tmp/luacheck/node_modules/fengari');
const L = lauxlib.luaL_newstate(); lualib.luaL_openlibs(L);
lauxlib.luaL_dostring(L, to_luastring('__REPORT = {"a","b"}; __ERR = {}'));
lua.lua_getglobal(L, to_luastring('__REPORT'));
console.log('type=', lua.lua_type(L,-1), 'LUA_TTABLE=', lua.LUA_TTABLE, 'rawlen=', lua.lua_rawlen(L,-1), 'len=', lua.luaL_len ? 'has luaL_len' : 'no');
console.log('typeof lua_rawlen =', typeof lua.lua_rawlen);
