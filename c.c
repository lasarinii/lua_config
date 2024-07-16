#include <stdio.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

int main(void)
{
    lua_State *L = luaL_newstate();
    luaL_openlibs(L);

    if (luaL_loadfile(L, "config.lua") || lua_pcall(L, 0, 0, 0))
    {
        printf("error %s\n", lua_tostring(L, -1));
        lua_pop(L, 1);
        return 1;
    }

    lua_getglobal(L, "mtx");
    if (!lua_istable(L, -1))
    {
        printf("error Invalid Configuration.\n");
        return 1;
    }

    lua_getfield(L, -1, "x");
    if (!lua_isnumber(L, -1))
    {
        printf("error\n");
        lua_close(L);
        return 1;
    }
    int x = lua_tointeger(L, -1);
    lua_pop(L, 1);

    lua_getfield(L, -1, "y");
    if (!lua_isnumber(L, -1))
    {
        printf("error\n");
        lua_close(L);
        return 1;
    }
    int y = lua_tointeger(L, -1);

    lua_pop(L, 2);

    printf("%d %d\n", x, y);
    lua_close(L);
    return 0;
}
