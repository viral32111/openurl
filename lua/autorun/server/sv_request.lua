net.Receive("OpenURLRequest", function()
	local selectedPlayer = net.ReadString()
	local playerName = net.ReadString()
	local URL = net.ReadString()
	local Title = net.ReadString()
	local OverlayMode = tostring( net.ReadBool() )
	local YouTubeMode = tostring( net.ReadBool() )

	for k, v in pairs( player.GetAll() ) do
		if ( v:Nick() == selectedPlayer ) then
			v:ConCommand('openurlrequestmenu "' .. playerName ..  '" "' .. URL .. '" "' .. Title .. '" "' .. OverlayMode .. '" "' .. YouTubeMode .. '"' )
			print("[OpenURL] " .. playerName .. " sent a request to " .. selectedPlayer .. " with arguments: (URL: " .. URL .. ") (Title: " .. Title .. ") (Overlay: " .. OverlayMode .. ") (YouTube: " .. YouTubeMode .. ")")
		end
	end
end )