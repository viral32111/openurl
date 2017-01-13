if ( SERVER ) then return false end

concommand.Add("OpenURL_WebMenu", function( player, command, args )
	if ( args[1] == nil or args[2] == nil or args[3] == nil ) then return false end

	if ( args[3] == "true" ) then
		gui.OpenURL( args[1] )
	else
		local webFrame = vgui.Create( "DFrame" )
		webFrame:SetTitle( "OpenURL - " .. args[2] )
		webFrame:SetSize( ScrW() * 0.90, ScrH() * 0.90 )
		webFrame:SetBackgroundBlur( true )
		webFrame:ShowCloseButton( true )
		webFrame:SetVisible( true )
		webFrame:SetDraggable( false )
		webFrame:Center()
		webFrame:MakePopup()

		local webHTML = vgui.Create( "HTML", webFrame )
		webHTML:Dock( FILL )
		webHTML:OpenURL( args[1] )
	end
end )