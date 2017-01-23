-- Copyright 2017 viral32111. https://github.com/viral32111/openurl/blob/master/LICENCE

hook.Add("PlayerSay", "openurlMenuCommand", function( ply, text, public )
        text = string.lower( text )
        if ( text == "/url" ) then
                if ( ply:IsAdmin() ) then
                        net.Start("openurlMenu")
                                net.WriteEntity( ply )
                        net.Send( ply )
                        print("[OpenURL] " .. ply:Nick() .. " opened the selection menu")
                        return ""
                else
                        ply:ChatPrint("You must be admin or higher to access this menu!")
                        print("[OpenURL] " .. ply:Nick() .. " tried to open the selection menu but failed.")
                        return ""
                end
        end
end )