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
	selectMenuPlayerLabel:SetSize( 300, 30 )
	selectMenuPlayerLabel:SetFont( "TargetIDSmall" )
	selectMenuPlayerLabel:SetText( "Please select a player on the left to continue" )

	local selectMenuRunButton = vgui.Create( "DButton", selectMenuFrame )
	local selectMenuURLBox = vgui.Create( "DTextEntry", selectMenuFrame )
	local selectMenuTitleBox = vgui.Create( "DTextEntry", selectMenuFrame )

	local selectMenuPlayerList = vgui.Create( "DListView", selectMenuFrame )
	selectMenuPlayerList:SetMultiSelect( false )
	selectMenuPlayerList:SetPos( 10, 30 )
	selectMenuPlayerList:SetSize( 160, 260 )
	selectMenuPlayerList:AddColumn( "Player" )
	selectMenuPlayerList.OnRowSelected = function( panel, line )
		selectedPlayer = panel:GetLine( line ):GetValue( 1 )
		selectMenuPlayerLabel:SetText( "You have selected: " .. selectedPlayer )
		selectMenuRunButton:SetText( "Open URL on " .. selectedPlayer )
		selectMenuRunButton:SetEnabled( true )
		selectMenuURLBox:SetEnabled( true )
		selectMenuURLBox:SetText( "Enter the URL you wish to open on the player" )
		selectMenuTitleBox:SetEnabled( true )
	selectMenuTitleBox:SetText( "Enter the title of the window" )
	end

	for k, v in pairs( player.GetAll() ) do
		selectMenuPlayerList:AddLine( v:Nick() )
	end
	
	selectMenuURLBox:SetPos( 180, 65 )
	selectMenuURLBox:SetSize( 310, 25 )
	selectMenuURLBox:SetEnabled( false )
	selectMenuURLBox:SetText( "Please click on a player first" )

	selectMenuTitleBox:SetPos( 180, 100 )
	selectMenuTitleBox:SetSize( 310, 25 )
	selectMenuTitleBox:SetEnabled( false )
	selectMenuTitleBox:SetText( "Please click on a player first" )
	function selectMenuTitleBox:OnChange()
		title = selectMenuTitleBox:GetValue()
	end

	local selectMenuOpenInOverlayCheckbox = vgui.Create( "DCheckBox", selectMenuFrame )
	selectMenuOpenInOverlayCheckbox:SetPos( 180, 130 )
	selectMenuOpenInOverlayCheckbox:SetValue( 0 )
	function selectMenuOpenInOverlayCheckbox:OnChange( bVal )
		if ( bVal ) then
			selectMenuTitleBox:SetEnabled( false )
			selectMenuTitleBox:SetText( "Cannot have title with overlay mode on" )
		else
			if ( selectedPlayer == nil ) then
				selectMenuTitleBox:SetEnabled( false )
				selectMenuTitleBox:SetText( "Please click on a player first" )
			else
				selectMenuTitleBox:SetEnabled( true )
				selectMenuTitleBox:SetText( title )
			end
		end
	end

	local selectMenuOpenInOverlayLabel = vgui.Create( "DLabel", selectMenuFrame )
	selectMenuOpenInOverlayLabel:SetPos( 200, 123 )
	selectMenuOpenInOverlayLabel:SetSize( 300, 30 )
	selectMenuOpenInOverlayLabel:SetFont( "TargetIDSmall" )
	selectMenuOpenInOverlayLabel:SetText( "Open in overlay? (steam web browser)" )

	selectMenuRunButton:SetText( "Please click on a player first" )
	selectMenuRunButton:SetPos( 180, 255 )
	selectMenuRunButton:SetSize( 310, 35 )
	selectMenuRunButton:SetEnabled( false )
	selectMenuRunButton.DoClick = function()
		selectMenuFrame:Close()
		local StrippedString = string.Replace( selectMenuURLBox:GetValue(), "https://", "www." ) or string.Replace( selectMenuURLBox:GetValue(), "http://", "www." ) or string.Replace( selectMenuURLBox:GetValue(), "https://www.", "www." ) or string.Replace( selectMenuURLBox:GetValue(), "http://www.", "www." )
		for k, v in pairs( player.GetAll() ) do
			if ( v:Nick() == selectedPlayer ) then
				v:ConCommand('OpenURL_AuthMenu "' .. ply:Nick() ..  '" "' ..  StrippedString .. '" "' .. selectMenuTitleBox:GetValue() .. '" "' .. tostring( selectMenuOpenInOverlayCheckbox:GetChecked() ) .. '"' )
			else
				return false
			end
		end
	end
end )