-- Copyright 2017 viral32111. https://github.com/viral32111/openurl/blob/master/LICENCE

if ( SERVER ) then return false end

concommand.Add("openurllauncher", function()
	local ply = LocalPlayer()

	title = "Enter the title of the window"

	local selectMenuFrame = vgui.Create( "DFrame" )
	selectMenuFrame:SetPos( ScrW()/2-250, ScrH()/2-150 )
	selectMenuFrame:SetSize( 500, 300 )
	selectMenuFrame:SetTitle( "Website Launcher" )
	selectMenuFrame:SetVisible( true )
	selectMenuFrame:SetDraggable( true )
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
	local selectMenuOpenInOverlayCheckbox = vgui.Create( "DCheckBox", selectMenuFrame )
	local selectMenuOpenInYouTubeCheckbox = vgui.Create( "DCheckBox", selectMenuFrame )

	local selectMenuPlayerList = vgui.Create( "DListView", selectMenuFrame )
	selectMenuPlayerList:SetMultiSelect( false )
	selectMenuPlayerList:SetPos( 10, 30 )
	selectMenuPlayerList:SetSize( 160, 260 )
	selectMenuPlayerList:AddColumn( "Player" )
	selectMenuPlayerList.OnRowSelected = function( panel, line )
		selectedPlayer = panel:GetLine( line ):GetValue( 1 )
		selectMenuPlayerLabel:SetText( "Will run on: " .. selectedPlayer )
		selectMenuRunButton:SetText( "Open URL on " .. selectedPlayer )
		selectMenuRunButton:SetEnabled( true )
		selectMenuURLBox:SetEnabled( true )
		selectMenuURLBox:SetText( "Enter the URL you wish to open on the player" )
		selectMenuTitleBox:SetEnabled( true )
		selectMenuTitleBox:SetText( "Enter an easy to recognize title" )
		selectMenuOpenInOverlayCheckbox:SetEnabled( true )
		selectMenuOpenInYouTubeCheckbox:SetEnabled( true )
	end

	for k, v in pairs( player.GetAll() ) do
		selectMenuPlayerList:AddLine( v:Nick() )
	end
	
	selectMenuURLBox:SetPos( 180, 60 )
	selectMenuURLBox:SetSize( 310, 25 )
	selectMenuURLBox:SetEnabled( false )
	selectMenuURLBox:SetText( "Please click on a player first" )

	selectMenuTitleBox:SetPos( 180, 95 )
	selectMenuTitleBox:SetSize( 310, 25 )
	selectMenuTitleBox:SetEnabled( false )
	selectMenuTitleBox:SetText( "Please click on a player first" )
	function selectMenuTitleBox:OnChange()
		title = selectMenuTitleBox:GetValue()
	end

	selectMenuOpenInOverlayCheckbox:SetPos( 180, 130 )
	selectMenuOpenInOverlayCheckbox:SetValue( 0 )
	selectMenuOpenInOverlayCheckbox:SetEnabled( false )
	function selectMenuOpenInOverlayCheckbox:OnChange( bVal )
		if ( bVal ) then
			selectMenuTitleBox:SetEnabled( false )
			selectMenuTitleBox:SetText( "Cannot have title with steam web browser" )
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
	selectMenuOpenInOverlayLabel:SetText( "Open in Steam Web Browser?" )

	selectMenuOpenInYouTubeCheckbox:SetPos( 180, 150 )
	selectMenuOpenInYouTubeCheckbox:SetValue( 0 )
	selectMenuOpenInYouTubeCheckbox:SetEnabled( false )
	function selectMenuOpenInYouTubeCheckbox:OnChange( bVal )
		if ( bVal ) then
			selectMenuOpenInOverlayCheckbox:SetEnabled( false )
			selectMenuOpenInOverlayCheckbox:SetChecked( false )
		else
			if ( selectedPlayer == nil ) then
				selectMenuOpenInOverlayCheckbox:SetEnabled( false )
			else
				selectMenuOpenInOverlayCheckbox:SetEnabled( true )
				selectMenuOpenInOverlayCheckbox:SetChecked( false )
			end
		end
	end

	local selectMenuOpenInOYouTubeLabel = vgui.Create( "DLabel", selectMenuFrame )
	selectMenuOpenInOYouTubeLabel:SetPos( 200, 143 )
	selectMenuOpenInOYouTubeLabel:SetSize( 300, 30 )
	selectMenuOpenInOYouTubeLabel:SetFont( "TargetIDSmall" )
	selectMenuOpenInOYouTubeLabel:SetText( "Open in YouTube?" )

	selectMenuRunButton:SetText( "Please click on a player first" )
	selectMenuRunButton:SetPos( 180, 255 )
	selectMenuRunButton:SetSize( 310, 35 )
	selectMenuRunButton:SetEnabled( false )
	selectMenuRunButton.DoClick = function()
		selectMenuFrame:Close()
		net.Start("openurlRequest", false)
			net.WriteString( selectedPlayer )
			net.WriteString( ply:Nick() )
			net.WriteString( selectMenuURLBox:GetValue() )
			net.WriteString( selectMenuTitleBox:GetValue() )
			net.WriteBool( selectMenuOpenInOverlayCheckbox:GetChecked() )
			net.WriteBool( selectMenuOpenInYouTubeCheckbox:GetChecked() )
		net.SendToServer()
	end
end )