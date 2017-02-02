-- Copyright 2017 viral32111. https://github.com/viral32111/openurl/blob/master/LICENCE

hook.Add("PlayerSay", "openurlMenuCommand", function( ply, text, public )
	text = string.lower( text )
	if ( text == "/url" ) then
		ply:ConCommand("openurlselectionmenu")
		print("[OpenURL] " .. ply:Nick() .. " opened the selection menu")
	           return ""
        	end
end )
