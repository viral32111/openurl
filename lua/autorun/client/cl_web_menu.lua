if ( SERVER ) then return false end

concommand.Add("OpenURL_WebMenu", function( player, command, args )
	if ( args[1] == nil or args[2] == nil ) then print('Invalid arguments supplied in command, Example: website_menu www.google.com "This would be the title"') return false end

	local WebFrame = vgui.Create( "DFrame" )
	WebFrame:SetTitle( "Website Menu - " .. args[2] )
	WebFrame:SetSize( ScrW() * 0.90, ScrH() * 0.90 )
	WebFrame:SetBackgroundBlur( true )
	WebFrame:Center()
	WebFrame:MakePopup()

	local WebHTML = vgui.Create( "HTML", WebFrame )
	WebHTML:Dock( FILL )
	WebHTML:OpenURL( args[1] )

	--local HTMLControls = vgui.Create( "DHTMLControls", WebHTML )
	--HTMLControls:SetHTML( WebHTML )
end )