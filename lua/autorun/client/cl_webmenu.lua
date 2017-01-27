-- Copyright 2017 viral32111. https://github.com/viral32111/openurl/blob/master/LICENCE

if ( SERVER ) then return false end

concommand.Add("openurlweb", function( player, command, args )
	if ( args[1] == nil or args[2] == nil or args[3] == nil or args[4] == nil ) then return false end

	if ( args[3] == "true" ) then
		if ( string.find( args[1], "http://" ) or string.find( args[1], "https://" ) ) then
			gui.OpenURL( args[1] )
		else
			gui.OpenURL( "http://" .. args[1] )
		end
	else
		if ( args[4] == "true" ) then
			if ( string.find( args[1], "embed/", 1, false ) ) then
				embedURL = args[1]
			else
				embedURL = string.Replace( args[1], "watch?v=", "embed/") .. "?autoplay=1&controls=0&showinfo=0"
			end

			local youtubeFrame = vgui.Create( "DFrame" )
			youtubeFrame:SetTitle( "" )
			youtubeFrame:SetSize( ScrW(), ScrH() )
			youtubeFrame:ShowCloseButton( true )
			youtubeFrame:SetVisible( true )
			youtubeFrame:SetDraggable( false )
			youtubeFrame:Center()
			youtubeFrame:MakePopup()
			function youtubeFrame:Paint( w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 0 ) )
			end

			local youtubeHTML = vgui.Create( "HTML", youtubeFrame )
			youtubeHTML:Dock( FILL )
			youtubeHTML:OpenURL( embedURL )
		else
			local webFrame = vgui.Create( "DFrame" )
			webFrame:SetTitle( args[2] )
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
	end
end )