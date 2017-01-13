if ( SERVER ) then return false end

concommand.Add("OpenURL_AuthMenu", function( player, command, args )
	if ( args[1] == nil or args[2] == nil or args[3] == nil or args[4] == nil ) then return false end

	local ply = LocalPlayer()

	local authFrame = vgui.Create( "DFrame" )
	if ( args[4] == "true" ) then
		authFrame:SetTitle( "OpenURL - Allow website to be opened on you? (In the Steam overlay)" )
	else
		authFrame:SetTitle( "OpenURL - Allow website to be opened on you? (In the game browser)" )
	end
	authFrame:SetSize( ScrW() * 0.55, ScrH() * 0.09 )
	authFrame:SetBackgroundBlur( true )
	authFrame:SetDraggable( true )
	authFrame:SetVisible( true )
	authFrame:ShowCloseButton( false )
	authFrame:Center()
	authFrame:MakePopup()

	local authFrameLabel = vgui.Create( "DLabel", authFrame )
	authFrameLabel:SetPos( 10, 30 )
	authFrameLabel:SetSize( 1000, 32 )
	authFrameLabel:SetFont( "TargetIDSmall" )
	if ( args[4] == "true" ) then
		authFrameLabel:SetText( args[1] .. " wants to open this website on you: " .. args[2] .. "\nAllow this menu to be opened?")
	else
		authFrameLabel:SetText( args[1] .. " wants to open this website on you: " .. args[2] .. " (" .. args[3] .. ")\nAllow this menu to be opened?")
	end

	local authFrameAllowButton = vgui.Create( "DButton", authFrame )
	authFrameAllowButton:SetText( "Allow" )
	authFrameAllowButton:SetPos( 10, 64 )
	authFrameAllowButton:SetSize( 120, 25 )
	authFrameAllowButton.DoClick = function()
		ply:ConCommand('OpenURL_WebMenu "' ..  args[2] .. '" "' .. args[3] .. '" "' .. args[4] .. '"')
		authFrame:Close()
	end

	local authFrameDisallowButton = vgui.Create( "DButton", authFrame )
	authFrameDisallowButton:SetText( "Disallow" )
	authFrameDisallowButton:SetPos( 150, 64 )
	authFrameDisallowButton:SetSize( 120, 25 )
	authFrameDisallowButton.DoClick = function()
		authFrame:Close()
		return false
	end
end )