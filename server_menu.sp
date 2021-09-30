#include <sourcemod>
#include <csgo_colors>
#include <morecolors>

public Plugin:myinfo = 
{
    name        = "Server menu",
    author      = "GGSERV.NET",
    description = "Server menu",
    version     = "1.0.5",
    url         = "https://github.com/ggserv-net/server_menu"
}

char g_sPrefix[100] = "{GRAY}[{LIGHTRED}Меню{GRAY}] {DEFAULT}";
bool g_bCSGO;

new Handle: g_about_menu;
new Handle: g_rules_menu;
new Handle: g_main_menu;
new Handle: g_skins_menu;

public OnPluginStart()
{

    g_bCSGO = (GetEngineVersion() == Engine_CSGO);

    /*
     *  COMMANDS
     */

    RegConsoleCmd("sm_cmds", Command_OpenMenu_main_menu);
    RegConsoleCmd("sm_commands", Command_OpenMenu_main_menu);
    RegConsoleCmd("sm_menu", Command_OpenMenu_main_menu);
    RegConsoleCmd("sm_help", Command_OpenMenu_main_menu);

    RegConsoleCmd("sm_skin", Command_OpenMenu_skins_menu);
    RegConsoleCmd("sm_skins", Command_OpenMenu_skins_menu);

    RegConsoleCmd("sm_rules", Command_OpenMenu_rules_menu);
    RegConsoleCmd("sm_pravila", Command_OpenMenu_rules_menu);

    RegConsoleCmd("sm_about", Command_OpenMenu_about_menu);
    RegConsoleCmd("sm_socials", Command_OpenMenu_about_menu);
    RegConsoleCmd("sm_links", Command_OpenMenu_about_menu);

    /*
     *  MENUS
     */

    g_main_menu = CreateMenu(Handler_main_menu);
    SetMenuTitle(g_main_menu, "Меню сервера:")
    AddMenuItem(g_main_menu, "1", "Правила")
    AddMenuItem(g_main_menu, "2", "VIP меню")
    AddMenuItem(g_main_menu, "3", "Статистика игрока")
    AddMenuItem(g_main_menu, "4", "Скины")
    AddMenuItem(g_main_menu, "5", "Обнулить счет")
    AddMenuItem(g_main_menu, "6", "Музыка")
    AddMenuItem(g_main_menu, "7", "Список админов")
    AddMenuItem(g_main_menu, "8", "О проекте")

    g_skins_menu = CreateMenu(Handler_skins_menu);
    SetMenuTitle(g_skins_menu, "Меню скинов:")
    AddMenuItem(g_skins_menu, "1", "Скины оружия")
    AddMenuItem(g_skins_menu, "2", "Ножи")
    AddMenuItem(g_skins_menu, "3", "Перчатки")
    SetMenuExitBackButton(g_skins_menu, true);

    g_rules_menu = CreateMenu(Handler_rules_menu);
    SetMenuTitle(g_rules_menu, "Правила проекта:")
    AddMenuItem(g_rules_menu, "1", "ВНИМАНИЕ!!! Незнание правил не освобождает от ответственности!", ITEMDRAW_DISABLED)
    AddMenuItem(g_rules_menu, "2", " ", ITEMDRAW_DISABLED)
    AddMenuItem(g_rules_menu, "3", "Полный текст правил тут:", ITEMDRAW_DISABLED)
    AddMenuItem(g_rules_menu, "4", "https://go.ggserv.net/r")
    AddMenuItem(g_rules_menu, "5", " ", ITEMDRAW_DISABLED)
    AddMenuItem(g_rules_menu, "6", "Ведите себя хорошо ^_-", ITEMDRAW_DISABLED)
    SetMenuExitBackButton(g_rules_menu, true);

    g_about_menu = CreateMenu(Handler_about_menu);
    SetMenuTitle(g_about_menu, "О проекте GGSERV.NET")
    AddMenuItem(g_about_menu, "1", "Telegram: http://go.ggserv.net/tg")
    AddMenuItem(g_about_menu, "2", "Vkontakte: http://go.ggserv.net/vk")
    AddMenuItem(g_about_menu, "3", "Discord: http://go.ggserv.net/discord")
    AddMenuItem(g_about_menu, "4", "Steam: http://go.ggserv.net/steam")
    SetMenuExitBackButton(g_about_menu, true);
}

/*
 * ACTIONS
 */

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

public Action:Command_OpenMenu_rules_menu(client, argc)
{
    DisplayMenu(g_rules_menu, client, MENU_TIME_FOREVER);
    return Plugin_Handled;
}

public Action:Command_OpenMenu_about_menu(client, argc)
{
    DisplayMenu(g_about_menu, client, MENU_TIME_FOREVER);
    return Plugin_Handled;
}

/*
 * HANDLERS
 */

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
                FakeClientCommand(client, "say \"!rs\"");
            }
            else if (StrEqual(info, "6"))
            {
                FakeClientCommand(client, "sm_res");
            }
            else if (StrEqual(info, "7"))
            {
                FakeClientCommand(client, "sm_admins");
            }
            else if (StrEqual(info, "8"))
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

public Handler_rules_menu(Handle:menu, MenuAction:action, client, slot)
{
    switch (action)
    {
        case MenuAction_Select:
        {
            decl String:info[64];
            GetMenuItem(menu, slot, info, sizeof(info));
            
            if (StrEqual(info, "4"))
            {
                CCPrintToChat(client, "%s Правила проекта: https://go.ggserv.net/r", g_sPrefix);
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

public Handler_about_menu(Handle:menu, MenuAction:action, client, slot)
{
    switch (action)
    {
        case MenuAction_Select:
        {
            decl String:info[64];
            GetMenuItem(menu, slot, info, sizeof(info));

            if (StrEqual(info, "1"))
            {
                CCPrintToChat(client, "%s Telegram: http://go.ggserv.net/tg", g_sPrefix);
            }
            else if (StrEqual(info, "2"))
            {
                CCPrintToChat(client, "%s Vk: http://go.ggserv.net/vk", g_sPrefix);
            }
            else if (StrEqual(info, "3"))
            {
                CCPrintToChat(client, "%s Discord: http://go.ggserv.net/discord", g_sPrefix);
            }
            else if (StrEqual(info, "4"))
            {
                CCPrintToChat(client, "%s Steam: http://go.ggserv.net/steam", g_sPrefix);
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

/*
 *  FUNCTIONS
 */

public void CCPrintToChat(int client, const char[] message, any ...)
{
	char sBuff[256];
	VFormat(sBuff, sizeof(sBuff), message, 3);
	
	if(g_bCSGO) CGOPrintToChat(client, sBuff);
	else CPrintToChat(client, sBuff);
}