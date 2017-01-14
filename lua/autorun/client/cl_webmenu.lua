if ( SERVER ) then return false end

concommand.Add("OpenURL_WebMenu", function( player, command, args )
	if ( args[1] == nil or args[2] == nil or args[3] == nil ) then return false end

	if ( args[3] == "true" ) then
		if ( string.find( args[1], "http://" ) or string.find( args[1], "https://" ) ) then
			gui.OpenURL( args[1] )
		else
			gui.OpenURL( "http://" .. args[1] )
		end
	else
		local webFrame = vgui.Create( "DFrame" )
		webFrame:SetTitle( "OpenURL - Website ( " .. args[2] .. " )" )
		webFrame:SetSize( 1728, 972 )
		webFrame:SetBackgroundBlur( true )
		webFrame:ShowCloseButton( true )
		webFrame:SetVisible( true )
		webFrame:SetDraggable( false )
		webFrame:SetPos( ScrW()/2-864, ScrH()/2-486 )
		webFrame:MakePopup()

		local webHTML = vgui.Create( "HTML", webFrame )
		webHTML:Dock( FILL )
		webHTML:OpenURL( args[1] )
	end
end )