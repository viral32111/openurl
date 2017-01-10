if ( SERVER ) then return false end

concommand.Add("OpenURL_SelectMenu", function()
	local ply = LocalPlayer()

	if not ( ply:IsAdmin() ) then
		chat.AddText( Color( 0, 255, 255 ), "You must be admin or higher to open this menu!")
		return false
	end

	local selectMenuFrame = vgui.Create( "DFrame" )
	selectMenuFrame:SetPos( ScrW()/2-250, ScrH()/2-150 )
	selectMenuFrame:SetSize( 500, 300 )
	selectMenuFrame:SetTitle( "OpenURL - Selection" )
	selectMenuFrame:SetVisible( true )
	selectMenuFrame:SetDraggable( false )
	selectMenuFrame:SetBackgroundBlur( true )
	selectMenuFrame:ShowCloseButton( true )
	selectMenuFrame:MakePopup()

	local selectMenuPlayerLabel = vgui.Create( "DLabel", selectMenuFrame )
	selectMenuPlayerLabel:SetPos( 180, 30 )
	selectMenuPlayerLabel:SetSize( 250, 30 )
	selectMenuPlayerLabel:SetFont( "TargetIDSmall" )
	selectMenuPlayerLabel:SetText( "Please select a player" )

	local selectMenuPlayerList = vgui.Create( "DListView", selectMenuFrame )
	selectMenuPlayerList:SetMultiSelect( false )
	selectMenuPlayerList:SetPos( 10, 30 )
	selectMenuPlayerList:SetSize( 160, 260 )
	selectMenuPlayerList:AddColumn( "Player" )
	selectMenuPlayerList.OnRowSelected = function( panel, line )
		selectedPlayer = panel:GetLine( line ):GetValue( 1 )
		selectMenuPlayerLabel:SetText( "You have selected: " .. panel:GetLine( line ):GetValue( 1 ) )
	end

	for k, v in pairs( player.GetAll() ) do
		selectMenuPlayerList:AddLine( v:Nick() )
	end

	local selectMenuURLBox = vgui.Create( "DTextEntry", selectMenuFrame )
	selectMenuURLBox:SetPos( 180, 65 )
	selectMenuURLBox:SetSize( 310, 25 )
	selectMenuURLBox:SetText( "Enter the URL you wish to open on the player" )

	local selectMenuTitleBox = vgui.Create( "DTextEntry", selectMenuFrame )
	selectMenuTitleBox:SetPos( 180, 105 )
	selectMenuTitleBox:SetSize( 310, 25 )
	selectMenuTitleBox:SetText( "Enter the title of the window" )

	local selectMenuRunButton = vgui.Create( "DButton", selectMenuFrame )
	selectMenuRunButton:SetText( "Open URL on player" )
	selectMenuRunButton:SetPos( 180, 145 )
	selectMenuRunButton:SetSize( 310, 35 )
	selectMenuRunButton.DoClick = function()
		local StrippedString = string.Replace( selectMenuURLBox:GetValue(), "https://", "www." ) or string.Replace( selectMenuURLBox:GetValue(), "http://", "www." ) or string.Replace( selectMenuURLBox:GetValue(), "https://www.", "www." ) or string.Replace( selectMenuURLBox:GetValue(), "http://www.", "www." )
		for k, v in pairs( player.GetAll() ) do
			if ( v:Nick() == selectedPlayer ) then
				v:ConCommand('OpenURL_WebMenu "' ..  StrippedString .. '" "' .. selectMenuTitleBox:GetValue() .. '"' )
			else
				return false
			end
		end
	end

	local selectMenuAuthorLabel = vgui.Create( "DLabel", selectMenuFrame )
	selectMenuAuthorLabel:SetPos( 230, 270 )
	selectMenuAuthorLabel:SetSize( 250, 30 )
	selectMenuAuthorLabel:SetFont( "DebugFixed" )
	selectMenuAuthorLabel:SetText( "Addon created by viral32111" )
end )