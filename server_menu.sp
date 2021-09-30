#include <sourcemod>

public Plugin:myinfo = 
{
    name        = "Server menu",
    author      = "GGSERV.NET",
    description = "Server menu",
    version     = "1.0.2",
    url         = "https://github.com/ggserv-net/server_menu"
}

new Handle: g_about_menu;
new Handle: g_rules_menu;
new Handle: g_main_menu;
new Handle: g_skins_menu;

public OnPluginStart()
{
    RegConsoleCmd("sm_cmds", Command_OpenMenu_main_menu);
    RegConsoleCmd("sm_commands", Command_OpenMenu_main_menu);
    RegConsoleCmd("sm_menu", Command_OpenMenu_main_menu);
    RegConsoleCmd("sm_help", Command_OpenMenu_main_menu);

    RegConsoleCmd("sm_rules", Command_OpenMenu_rules_menu);
    RegConsoleCmd("sm_pravila", Command_OpenMenu_rules_menu);

    RegConsoleCmd("sm_skin", Command_OpenMenu_skins_menu);
    RegConsoleCmd("sm_skins", Command_OpenMenu_skins_menu);

    RegConsoleCmd("sm_about", Command_OpenMenu_about_menu);
    RegConsoleCmd("sm_socials", Command_OpenMenu_about_menu);
    RegConsoleCmd("sm_links", Command_OpenMenu_about_menu);

    g_about_menu = CreateMenu(Handler_about_menu);
    SetMenuTitle(g_about_menu, "О проекте GGSERV.NET")
    AddMenuItem(g_about_menu, "1", "Telegram: http://go.ggserv.net/tg", ITEMDRAW_DISABLED)
    AddMenuItem(g_about_menu, "2", "Vkontakte: http://go.ggserv.net/vk", ITEMDRAW_DISABLED)
    AddMenuItem(g_about_menu, "3", "Discord: http://go.ggserv.net/discord", ITEMDRAW_DISABLED)
    AddMenuItem(g_about_menu, "4", "Steam: http://go.ggserv.net/steam", ITEMDRAW_DISABLED)
    SetMenuExitBackButton(g_about_menu, true);

    g_rules_menu = CreateMenu(Handler_rules_menu);
    SetMenuTitle(g_rules_menu, "Правила проекта:")
    AddMenuItem(g_rules_menu, "1", "Ведите себя хорошо ^_^", ITEMDRAW_DISABLED)
    AddMenuItem(g_rules_menu, "2", "Полный текст правил тут: https://go.ggserv.net/r", ITEMDRAW_DISABLED)
    SetMenuExitBackButton(g_rules_menu, true);

    g_main_menu = CreateMenu(Handler_main_menu);
    SetMenuTitle(g_main_menu, "Меню сервера:")
    AddMenuItem(g_main_menu, "1", "Правила")
    AddMenuItem(g_main_menu, "2", "VIP меню")
    AddMenuItem(g_main_menu, "3", "Статистика игрока")
    AddMenuItem(g_main_menu, "4", "Скины")
    AddMenuItem(g_main_menu, "5", "Обнулить счет")
    AddMenuItem(g_main_menu, "6", "Список админов")
    AddMenuItem(g_main_menu, "7", "О проекте")

    g_skins_menu = CreateMenu(Handler_skins_menu);
    SetMenuTitle(g_skins_menu, "Меню скинов:")
    AddMenuItem(g_skins_menu, "1", "Скины оружия")
    AddMenuItem(g_skins_menu, "2", "Ножи")
    AddMenuItem(g_skins_menu, "3", "Перчатки")
    SetMenuExitBackButton(g_skins_menu, true);
}


public Action:Command_OpenMenu_about_menu(client, argc)
{
    DisplayMenu(g_about_menu, client, MENU_TIME_FOREVER);
    return Plugin_Handled;
}
public Action:Command_OpenMenu_rules_menu(client, argc)
{
    DisplayMenu(g_rules_menu, client, MENU_TIME_FOREVER);
    return Plugin_Handled;
}
public Action:Command_OpenMenu_main_menu(client, argc)
{
    DisplayMenu(g_main_menu, client, MENU_TIME_FOREVER);
    return Plugin_Handled;
}
public Action:Command_OpenMenu_skins_menu(client, argc)
{
    DisplayMenu(g_skins_menu, client, MENU_TIME_FOREVER);
    return Plugin_Handled;
}

public Handler_about_menu(Handle:menu, MenuAction:action, client, slot)
{
    switch (action)
    {
        case MenuAction_Select:
        {
            decl String:info[64];
            GetMenuItem(menu, slot, info, sizeof(info));
            
        }
        case MenuAction_Cancel:
        {
            if (slot == MenuCancel_ExitBack)
            {
                DisplayMenu(g_main_menu, client, MENU_TIME_FOREVER);
            }
        }
    }
}

public Handler_rules_menu(Handle:menu, MenuAction:action, client, slot)
{
    switch (action)
    {
        case MenuAction_Select:
        {
            decl String:info[64];
            GetMenuItem(menu, slot, info, sizeof(info));
            
        }
        case MenuAction_Cancel:
        {
            if (slot == MenuCancel_ExitBack)
            {
                DisplayMenu(g_main_menu, client, MENU_TIME_FOREVER);
            }
        }
    }
}

public Handler_main_menu(Handle:menu, MenuAction:action, client, slot)
{
    switch (action)
    {
        case MenuAction_Select:
        {
            decl String:info[64];
            GetMenuItem(menu, slot, info, sizeof(info));
            
            if (StrEqual(info, "1"))
            {
                FakeClientCommand(client, "sm_rules");
            }
            else if (StrEqual(info, "2"))
            {
                FakeClientCommand(client, "sm_vip");
            }
            else if (StrEqual(info, "3"))
            {
                FakeClientCommand(client, "sm_stats");
            }
            else if (StrEqual(info, "4"))
            {
                FakeClientCommand(client, "sm_skins");
            }
            else if (StrEqual(info, "5"))
            {
                FakeClientCommand(client, "say !rs");
            }
            else if (StrEqual(info, "6"))
            {
                FakeClientCommand(client, "sm_admins");
            }
            else if (StrEqual(info, "7"))
            {
                FakeClientCommand(client, "sm_about");
            }
        }
    }
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
                FakeClientCommand(client, "sm_gloves");
            }
        }
        case MenuAction_Cancel:
        {
            if (slot == MenuCancel_ExitBack)
            {
                DisplayMenu(g_main_menu, client, MENU_TIME_FOREVER);
            }
        }
    }
}

