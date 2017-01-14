net.Receive("OpenURLAuthMenu", function()
	local selectedPlayer = net.ReadString()
	local playerName = net.ReadString()
	local URL = net.ReadString()
	local Title = net.ReadString()
	local OverlayMode = tostring( net.ReadBool() )

	for k, v in pairs( player.GetAll() ) do
		if ( v:Nick() == selectedPlayer ) then
			v:ConCommand('OpenURL_AuthMenu "' .. playerName ..  '" "' .. URL .. '" "' .. Title .. '" "' .. OverlayMode .. '"' )
			print("[OpenURL] " .. playerName .. " sent a website request to " .. selectedPlayer .. " with arguments: (URL: " .. URL .. ") (Title: " .. Title .. ") (Overlay: " .. OverlayMode .. ")")
		else
			return false
		end
	end
end )