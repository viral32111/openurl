-- Copyright 2017 viral32111. https://github.com/viral32111/openurl/blob/master/LICENCE

local addonVersion = "1.1.9"
versionchecked = false

if ( SERVER ) then
	print("[OpenURL] Loading OpenURL...")
	print("[OpenURL] Author: viral32111")
	print("[OpenURL] Version: " .. addonVersion )

	util.AddNetworkString("openurlRequest")

	include("autorun/server/sv_command.lua")
	include("autorun/server/sv_request.lua")

	AddCSLuaFile("autorun/client/cl_web.lua")
	include("autorun/client/cl_web.lua")
	AddCSLuaFile("autorun/client/cl_request.lua")
	include("autorun/client/cl_request.lua")
	AddCSLuaFile("autorun/client/cl_launcher.lua")
	include("autorun/client/cl_launcher.lua")

	print("[OpenURL] Finished loading OpenURL!")
end

if ( CLIENT ) then
	print("[OpenURL] Loading OpenURL...")
	print("[OpenURL] Author: viral32111")
	print("[OpenURL] Version: " .. addonVersion )

	print("[OpenURL] Finished loading OpenURL!")
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
				Error("[OpenURL] Version page does not exist\n")
			else
				print("[OpenURL] You are using outdated version of OpenURL! (Latest: " .. formattedBody .. ", Yours: " .. addonVersion .. ")" )
			end
		end,
		function( error )
			Error("[OpenURL] Failed to get addon version\n")
		end
		)
	end
end )