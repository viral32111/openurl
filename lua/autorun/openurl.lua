-- Copyright 2017 viral32111. https://github.com/viral32111/openurl/blob/master/LICENCE

local addonVersion = "1.1.5"
include("config.lua")

local function addFile( File, Type )
	if ( Type == "server" ) then
		print("[OpenURL] Include: " .. File )
		include("autorun/" .. Type .. "/" .. File )
	else
		print("[OpenURL] Added: " .. File )
		AddCSLuaFile("autorun/" .. Type .. "/" .. File )
		print("[OpenURL] Include: " .. File )
		include("autorun/" .. Type .. "/" .. File )
	end
end

if ( SERVER ) then
	print("[OpenURL] Loading OpenURL...")
	print("[OpenURL] Author: viral32111")
	print("[OpenURL] Version: " .. addonVersion )

	util.AddNetworkString("OpenURLRequest")
	util.AddNetworkString("openurlMenu")

	addFile("sv_commands.lua", "server")
	addFile("sv_request.lua", "server")
	addFile("sv_versioncheck.lua", "server")
	addFile("cl_webmenu.lua", "client")
	addFile("cl_requestmenu.lua", "client")
	addFile("cl_selectmenu.lua", "client")

	if ( useULXPermissions ) then
		if ( adminOnly ) then
			Error("[OpenURL] Error: The config file has been setup wrong, You WILL get errors")
		end
	end

	print("[OpenURL] Finished loading OpenURL!")
end

if ( CLIENT ) then
	print("[OpenURL] This server is using OpenURL! (Version: " .. addonVersion .. ") (Created by viral32111)")
end