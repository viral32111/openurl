-- Copyright 2017 viral32111. https://github.com/viral32111/openurl/blob/master/LICENCE

if ( SERVER ) then return false end

concommand.Add("openurlrequest", function( player, command, args )
	if ( args[1] == nil or args[2] == nil or args[3] == nil or args[4] == nil or args[5] == nil ) then return false end

	local ply = LocalPlayer()

	local authFrame = vgui.Create( "DFrame" )
	authFrame:SetPos( ScrW()/2-528, ScrH()/2-48 )
	authFrame:SetSize( 1056, 97 )
	authFrame:SetTitle( "Request from " .. args[1] )
	authFrame:SetVisible( true )
	authFrame:SetDraggable( true )
	authFrame:SetBackgroundBlur( true )
	authFrame:ShowCloseButton( false )
	authFrame:MakePopup()

	local authFrameLabel = vgui.Create( "DLabel", authFrame )
	authFrameLabel:SetPos( 10, 30 )
	authFrameLabel:SetSize( 1000, 32 )
	authFrameLabel:SetFont( "TargetIDSmall" )
	if ( args[4] == "true" ) then
		authFrameLabel:SetText( args[1] .. " wants to open this website on you: " .. args[2] .. "\nAllow this website to be opened?")
	else
		if ( args[5] == "true" ) then
			authFrameLabel:SetText( args[1] .. " wants to open this YouTube video on you: " .. args[3] .. "\nAllow this website to be opened?")
		else
			authFrameLabel:SetText( args[1] .. " wants to open this website on you: " .. args[2] .. " (" .. args[3] .. ")\nAllow this website to be opened?")
		end
	end

	local authFrameAllowButton = vgui.Create( "DButton", authFrame )
	authFrameAllowButton:SetText( "Accept" )
	authFrameAllowButton:SetPos( 10, 64 )
	authFrameAllowButton:SetSize( 120, 25 )
	authFrameAllowButton.DoClick = function()
		ply:ConCommand('openurlweb "' ..  args[2] .. '" "' .. args[3] .. '" "' .. args[4] .. '" "' .. args[5] .. '"')
		authFrame:Close()
	end

	local authFrameDisallowButton = vgui.Create( "DButton", authFrame )
	authFrameDisallowButton:SetText( "Deny" )
	authFrameDisallowButton:SetPos( 150, 64 )
	authFrameDisallowButton:SetSize( 120, 25 )
	authFrameDisallowButton.DoClick = function()
		authFrame:Close()
		return false
	end
end )