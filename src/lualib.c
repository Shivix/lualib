#include <lua.h>
#include <lauxlib.h>
#include <sys/stat.h>

int dir_exists(lua_State *L) {
    const char *path = luaL_checkstring(L, 1);
    struct stat st;
    if (stat(path, &st) == 0 && S_ISDIR(st.st_mode)) {
        lua_pushboolean(L, 1);
    } else {
        lua_pushboolean(L, 0);
    }
    return 1;
}

int luaopen_lualib_core(lua_State *L) {
    luaL_Reg funcs[] = {
        {"dir_exists", dir_exists},
        {NULL, NULL}
    };
    luaL_newlib(L, funcs);
    return 1;
}
