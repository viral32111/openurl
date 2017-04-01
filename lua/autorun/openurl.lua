-- Copyright 2017 viral32111. https://github.com/viral32111/openurl/blob/master/LICENCE

local OpenURLVersion = "1.2.2"
local OpenURLVersionChecked = false

if ( SERVER ) then
	print("[OpenURL] Loaded! (Author: viral32111) (Version: " .. OpenURLVersion .. ")")

	util.AddNetworkString("OpenURLRequest")

	include("autorun/server/sv_command.lua")
	include("autorun/server/sv_request.lua")

	AddCSLuaFile("autorun/client/cl_web.lua")
	include("autorun/client/cl_web.lua")
	AddCSLuaFile("autorun/client/cl_request.lua")
	include("autorun/client/cl_request.lua")
	AddCSLuaFile("autorun/client/cl_launcher.lua")
	include("autorun/client/cl_launcher.lua")
end

if ( CLIENT ) then
	print("This server is running OpenURL, Created by viral32111! (www.github.com/viral32111)")
end

hook.Add( "PlayerConnect", "OpenURLVersionCheck", function()
	if not ( OpenURLVersionChecked ) then
		OpenURLVersionChecked = true
		http.Fetch( "https://raw.githubusercontent.com/viral32111/openurl/master/VERSION.md",
		function( body, len, headers, code )
			local formattedBody = string.gsub( body, "\n", "")
			if ( formattedBody == OpenURLVersion ) then
				MsgC( Color( 0, 255, 0 ), "[OpenURL] You are running the most recent version of OpenURL!\n")
			elseif ( formattedBody == "404: Not Found" ) then
				MsgC( Color( 255, 0, 0 ), "[OpenURL] Version page does not exist\n")
			else
				MsgC( Color( 255, 255, 0 ), "[OpenURL] You are using outdated version of OpenURL! (Latest: " .. formattedBody .. ", Yours: " .. OpenURLVersion .. ")\n" )
			end
		end,
		function( error )
			MsgC( Color( 255, 0, 0 ), "[OpenURL] Failed to get addon version\n")
		end
		)
	end
end )