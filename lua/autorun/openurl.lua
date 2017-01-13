local addonVersion = "1.1.3"

local function addServer( File )
	print("[OpenURL] Include: " .. File )
    include("autorun/server/" .. File )
end

local function addClient( File )
	print("[OpenURL] Added: " .. File )
	AddCSLuaFile("autorun/client/" .. File )
	print("[OpenURL] Include: " .. File )
    include("autorun/client/" .. File )
end

if ( SERVER ) then
	util.AddNetworkString("OpenURLAuthMenu")

    print("[OpenURL] Loading OpenURL...")
    print("[OpenURL] Author: viral32111")
    print("[OpenURL] Version: " .. addonVersion )

    addServer("sv_commands.lua")
    addServer("sv_authmenu.lua")

    addClient("cl_webmenu.lua")
    addClient("cl_authmenu.lua")
    addClient("cl_selectmenu.lua")

    print("[OpenURL] Finished loading OpenURL!")
end

if ( CLIENT ) then
    print("[OpenURL] This server is using OpenURL! (Version: " .. addonVersion .. ") (Created by viral32111)")
end

hook.Add("OnGamemodeLoaded", "loaded", function()
	http.Fetch( "https://raw.githubusercontent.com/viral32111/openurl/master/VERSION.md",
        function( body, len, headers, code )
            local formattedBody = string.gsub( body, "\n", "")
            if ( formattedBody == addonVersion ) then
                print("[OpenURL] You are running the most recent version of OpenURL!")
            else
                print("[OpenURL] You are using outdated version of OpenURL! (Latest: " .. formattedBody .. ", Yours: " .. addonVersion .. ")" )
            end
        end,
        function( error )
            print("[OpenURL] Error: Failed to get addon version")
        end
    )
end )