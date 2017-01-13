local addonVersion = "1.1.2"

function consolePrint( text )
	MsgC( Color(0, 255, 255), "[OpenURL] " .. text .. "\n")
end

function consoleAlert( text )
	MsgC( Color(255, 255, 0), "[OpenURL] " .. text .. "\n")
end

function consoleError( text )
	MsgC( Color(255, 0, 0), "[OpenURL] " .. text .. "\n")
end

function consoleGood( text )
	MsgC( Color(0, 255, 0), "[OpenURL] " .. text .. "\n")
end

if ( SERVER ) then
    consolePrint("Loading OpenURL...")
    consolePrint("Author: viral32111")
    consolePrint("Version: " .. addonVersion )
    consolePrint("Issues: www.github.com/viral32111/openurl/issues")
    consolePrint("Steam: www.steamcommunity.com/id/viral32111")
    consolePrint("Contact: viral32111@hotmail.com")
    consolePrint("Wiki: www.github.com/viral32111/openurl/wiki")

    AddCSLuaFile("autorun/client/cl_web_menu.lua")
    include("autorun/client/cl_web_menu.lua")
    AddCSLuaFile("autorun/client/cl_auth_menu.lua")
    include("autorun/client/cl_auth_menu.lua")
    AddCSLuaFile("autorun/client/cl_select_menu.lua")
    include("autorun/client/cl_select_menu.lua")
    
    include("autorun/server/sv_commands.lua")

    consolePrint("Finished loading OpenURL!")
end

if ( CLIENT ) then
    consolePrint("This server is using OpenURL (" .. addonVersion .. ") (Created by viral32111)")
end

hook.Add("OnGamemodeLoaded", "addonLoaded", function()
	http.Fetch( "https://raw.githubusercontent.com/viral32111/openurl/master/VERSION.md",
        function( body, len, headers, code )
            local formattedBody = string.gsub( body, "\n", "")
            if ( formattedBody == addonVersion ) then
                consoleGood("You are running the most recent version of OpenURL!")
            else
                consoleAlert("You are using outdated version of OpenURL! (Latest: " .. formattedBody .. ", Yours: " .. addonVersion .. ")" )
            end
        end,
        function( error )
            consoleError("Error: Failed to get version")
        end
    )
end )