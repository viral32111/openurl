hook.Add("PlayerSay", "OpenURLSelectMenu", function( ply, text, public )
	text = string.lower( text )
	if ( text == "/url" ) then
		if ( ply:IsAdmin() ) then
			ply:ConCommand("OpenURL_SelectMenu")
			return ""
		else
			ply:SendLua(' chat.AddText( Color( 0, 255, 255 ), "You must be admin or higher to open this menu!") ')
			return ""
		end
	end
end )