-- Copyright 2017 viral32111. https://github.com/viral32111/openurl/blob/master/LICENCE

local addonVersion = "1.1.7"
local versionchecked = false

if ( SERVER ) then
	print("[OpenURL] Loading OpenURL...")
	print("[OpenURL] Author: viral32111")
	print("[OpenURL] Version: " .. addonVersion )

	util.AddNetworkString("OpenURLRequest")

	include("autorun/server/sv_commands.lua")
	include("autorun/server/sv_request.lua")

	AddCSLuaFile("autorun/client/cl_webmenu.lua")
	include("autorun/client/cl_webmenu.lua")
	AddCSLuaFile("autorun/client/cl_requestmenu.lua")
	include("autorun/client/cl_requestmenu.lua")
	AddCSLuaFile("autorun/client/cl_selectmenu.lua")
	include("autorun/client/cl_selectmenu.lua")

	print("[OpenURL] Finished loading OpenURL!")
end

if ( CLIENT ) then
	print("[OpenURL] This server is using OpenURL! (Version: " .. addonVersion .. ") (Created by viral32111)")
end

hook.Add("PlayerConnect", "openurlCheckVersion", function()
	if not ( versionchecked ) then
		versionchecked = true
		http.Fetch( "https://raw.githubusercontent.com/viral32111/openurl/master/VERSION.md",
		function( body, len, headers, code )
			local formattedBody = string.gsub( body, "\n", "")
			if ( formattedBody == addonVersion ) then
				print("[OpenURL] You are running the most recent version of OpenURL!")
			elseif ( formattedBody == "404: Not Found" ) then
				Error("[OpenURL] Error: Version page does not exist\n")
			else
				print("[OpenURL] You are using outdated version of OpenURL! (Latest: " .. formattedBody .. ", Yours: " .. addonVersion .. ")" )
			end
		end,
		function( error )
			Error("[OpenURL] Error: Failed to get addon version\n")
		end
		)
	end
end )