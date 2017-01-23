include("config.lua")

function ulx.urlmenu( calling_ply )
	if ( useULXPermissions ) then
		net.Start("openurlMenu")
			net.WriteEntity( calling_ply )
		net.Send( calling_ply )
	else
		calling_ply:ChatPrint("This command has been disabled")
	end
end
local urlmenu = ulx.command( "OpenURL", "ulx urlmenu", ulx.urlmenu, "/url" )
urlmenu:defaultAccess( ULib.ACCESS_ALL )
urlmenu:help( "Allows access to the URL menu." )