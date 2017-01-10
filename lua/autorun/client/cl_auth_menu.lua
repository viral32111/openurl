if ( SERVER ) then return false end

concommand.Add("OpenURL_AuthMenu", function( player, command, args )
	if ( args[1] == nil or args[2] == nil or args[3] == nil ) then print("Invalid arguments supplied in command") return false end

	local ply = LocalPlayer()

	local authFrame = vgui.Create( "DFrame" )
	authFrame:SetTitle( "Allow website to be opened on you?" )
	authFrame:SetSize( ScrW() * 0.40, ScrH() * 0.09 )
	authFrame:SetBackgroundBlur( true )
	authFrame:Center()
	authFrame:MakePopup()

	local authFrameLabel = vgui.Create( "DLabel", authFrame )
	authFrameLabel:SetPos( 10, 30 )
	authFrameLabel:SetSize( 750, 32 )
	authFrameLabel:SetFont( "TargetIDSmall" )
	authFrameLabel:SetText( args[1] .. " wants to open this webpage on you: " .. args[2] .. "\nAllow this menu to be opened?")

	local authFrameAllowButton = vgui.Create( "DButton", authFrame )
	authFrameAllowButton:SetText( "Allow" )
	authFrameAllowButton:SetPos( 10, 64 )
	authFrameAllowButton:SetSize( 120, 25 )
	authFrameAllowButton.DoClick = function()
		ply:ConCommand('OpenURL_WebMenu "' ..  args[2] .. '" "' .. args[3] .. '"' )
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