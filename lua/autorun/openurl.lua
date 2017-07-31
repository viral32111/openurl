--[[-------------------------------------------------------------------------
Copyright 2017 viral32111

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
---------------------------------------------------------------------------]]

local OpenURLVersion = "1.2.3"
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

hook.Add("PlayerConnect", "OpenURLVersionCheck", function()
	if not ( OpenURLVersionChecked ) then
		OpenURLVersionChecked = true
		http.Fetch( "https://raw.githubusercontent.com/viral32111/openurl/master/VERSION.txt",
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