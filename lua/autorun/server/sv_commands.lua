hook.Add( "PlayerSay", "OpenURLSelectMenu", function( ply, text, public )
	text = string.lower( text )
	if ( text == "/url" and ply:IsAdmin() ) then
		ply:ConCommand("OpenURL_SelectMenu")
		return ""
	end
end )