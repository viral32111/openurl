local addonVersion = "1.1.2"

if ( SERVER ) then
	util.AddNetworkString("OpenURLAuthMenu")

    print("Loading OpenURL...")
    print("Author: viral32111")
    print("Version: " .. addonVersion )
    print("Issues: www.github.com/viral32111/openurl/issues")
    print("Steam: www.steamcommunity.com/id/viral32111")
    print("Contact: viral32111@hotmail.com")
    print("Wiki: www.github.com/viral32111/openurl/wiki")

    AddCSLuaFile("autorun/client/cl_web_menu.lua")
    include("autorun/client/cl_web_menu.lua")
    AddCSLuaFile("autorun/client/cl_auth_menu.lua")
    include("autorun/client/cl_auth_menu.lua")
    AddCSLuaFile("autorun/client/cl_select_menu.lua")
    include("autorun/client/cl_select_menu.lua")
    
    include("autorun/server/sv_commands.lua")
    include("autorun/server/sv_run.lua")

    print("Finished loading OpenURL!")
end

if ( CLIENT ) then
    print("This server is using OpenURL (" .. addonVersion .. ") (Created by viral32111)")
end

hook.Add("OnGamemodeLoaded", "addonLoaded", function()
	http.Fetch( "https://raw.githubusercontent.com/viral32111/openurl/master/VERSION.md",
        function( body, len, headers, code )
            local formattedBody = string.gsub( body, "\n", "")
            if ( formattedBody == addonVersion ) then
                print("You are running the most recent version of OpenURL!")
            else
                print("You are using outdated version of OpenURL! (Latest: " .. formattedBody .. ", Yours: " .. addonVersion .. ")" )
            end
        end,
        function( error )
            print("Error: Failed to get version")
        end
    )
end )