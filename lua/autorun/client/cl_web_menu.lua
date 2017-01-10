if ( SERVER ) then return false end

concommand.Add("OpenURL_WebMenu", function( player, command, args )
	if ( args[1] == nil or args[2] == nil ) then print("Invalid arguments supplied in command") return false end

	local webFrame = vgui.Create( "DFrame" )
	webFrame:SetTitle( "Website Menu - " .. args[2] )
	webFrame:SetSize( ScrW() * 0.90, ScrH() * 0.90 )
	webFrame:SetBackgroundBlur( true )
	webFrame:Center()
	webFrame:MakePopup()

	local webHTML = vgui.Create( "HTML", webFrame )
	webHTML:Dock( FILL )
	webHTML:OpenURL( args[1] )
end )