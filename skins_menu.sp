#include <sourcemod>

public Plugin:myinfo = 
{
    name        = "Skins menu",
    author      = "GGSERV.NET",
    description = "Skins menu",
    version     = "1.0",
    url         = "https://ggserv.net"
}

new Handle: g_skins_menu;

public OnPluginStart()
{
    RegConsoleCmd("sm_skins", Command_OpenMenu_skins_menu);

    g_skins_menu = CreateMenu(Handler_skins_menu);
    SetMenuTitle(g_skins_menu, "Выбор скинов:")
    AddMenuItem(g_skins_menu, "1", "Оружие")
    AddMenuItem(g_skins_menu, "2", "Ножи")
    AddMenuItem(g_skins_menu, "3", "Перчатки")
}


public Action:Command_OpenMenu_skins_menu(client, argc)
{
    DisplayMenu(g_skins_menu, client, MENU_TIME_FOREVER);
    return Plugin_Handled;
}

public Handler_skins_menu(Handle:menu, MenuAction:action, client, slot)
{
    switch (action)
    {
        case MenuAction_Select:
        {
            decl String:info[64];
            GetMenuItem(menu, slot, info, sizeof(info));
            
            if (StrEqual(info, "1"))
            {
                FakeClientCommand(client, "sm_ws");
            }
            else if (StrEqual(info, "2"))
            {
                FakeClientCommand(client, "sm_knife");
            }
            else if (StrEqual(info, "3"))
            {
                ServerCommand("sm_gloves");
            }
        }
    }
}

