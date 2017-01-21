hook.Add("PlayerSay", "OpenURLSelectMenu", function( ply, text, public )
	text = string.lower( text )
	if ( text == "/url" ) then
		if ( ply:IsAdmin() ) then
			ply:ConCommand("openurlselect")
			print("[OpenURL] " .. ply:Nick() .. " opened the selection menu")
			return ""
		else
			ply:ChatPrint("You must be admin or higher to access this menu!")
			print("[OpenURL] " .. ply:Nick() .. " tried to open the selection menu but failed.")
			return ""
		end
	end
end )