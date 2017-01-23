-- Copyright 2017 viral32111. https://github.com/viral32111/openurl/blob/master/LICENCE

versionchecked = false

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