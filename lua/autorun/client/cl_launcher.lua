--[[-------------------------------------------------------------------------
Copyright 2017 viral32111

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
---------------------------------------------------------------------------]]

if ( SERVER ) then return false end

concommand.Add("OpenURLLauncher", function()
	local ply = LocalPlayer()

	title = "Enter the title of the window"
	buttonText = "Please click on a player first"
	buttonTextColor = Color( 220, 220, 220 )

	local selectMenuFrame = vgui.Create( "DFrame" )
	selectMenuFrame:SetPos( ScrW()/2-250, ScrH()/2-150 )
	selectMenuFrame:SetSize( 500, 300 )
	selectMenuFrame:SetTitle( "OpenURL" )
	selectMenuFrame:SetVisible( true )
	selectMenuFrame:SetDraggable( false )
	selectMenuFrame:SetSizable( false )
	selectMenuFrame:SetBackgroundBlur( false )
	selectMenuFrame:ShowCloseButton( true )
	selectMenuFrame:MakePopup()
	function selectMenuFrame:Paint( w, h )
		draw.RoundedBox( 2, 0, 0, w, h, Color( 50, 50, 50, 255 ) ) -- Body
		draw.RoundedBox( 2, 0, 0, w, 24, Color( 0, 164, 219, 255 ) ) -- Header
		draw.RoundedBox( 0, 0, 24, w, 1, Color( 230, 230, 230, 230 ) ) -- Line
	end

	local selectMenuPlayerLabel = vgui.Create( "DLabel", selectMenuFrame )
	selectMenuPlayerLabel:SetPos( 180, 30 )
	selectMenuPlayerLabel:SetSize( 300, 30 )
	selectMenuPlayerLabel:SetFont( "TargetIDSmall" )
	selectMenuPlayerLabel:SetColor( Color( 200, 200, 200 ) )
	selectMenuPlayerLabel:SetText( "Please select a player on the left to continue" )

	local selectMenuRunButton = vgui.Create( "DButton", selectMenuFrame )
	local selectMenuURLBox = vgui.Create( "DTextEntry", selectMenuFrame )
	local selectMenuTitleBox = vgui.Create( "DTextEntry", selectMenuFrame )
	local selectMenuOpenInOverlayCheckbox = vgui.Create( "DCheckBox", selectMenuFrame )
	local selectMenuOpenInYouTubeCheckbox = vgui.Create( "DCheckBox", selectMenuFrame )
	local selectMenuOpenInOverlayLabel = vgui.Create( "DLabel", selectMenuFrame )
	local selectMenuOpenInYouTubeLabel = vgui.Create( "DLabel", selectMenuFrame )

	local selectMenuPlayerList = vgui.Create( "DListView", selectMenuFrame )
	selectMenuPlayerList:SetMultiSelect( false )
	selectMenuPlayerList:SetPos( 10, 30 )
	selectMenuPlayerList:SetSize( 160, 260 )
	selectMenuPlayerList:AddColumn( "Player" )
	selectMenuPlayerList.OnRowSelected = function( panel, line )
		selectedPlayer = panel:GetLine( line ):GetValue( 1 )
		selectMenuPlayerLabel:SetText( "Selected: " .. selectedPlayer )
		selectMenuPlayerLabel:SetColor( Color( 255, 255, 255 ) )
		buttonText = "Open on " .. selectedPlayer
		buttonTextColor = Color( 255, 255, 255 )
		selectMenuRunButton:SetEnabled( true )
		selectMenuURLBox:SetEnabled( true )
		selectMenuURLBox:SetText( "Enter the URL you wish to open on the player" )
		selectMenuTitleBox:SetEnabled( true )
		selectMenuTitleBox:SetText( "Enter an easy to recognize title" )
		selectMenuOpenInOverlayCheckbox:SetEnabled( true )
		selectMenuOpenInYouTubeCheckbox:SetEnabled( true )
		selectMenuOpenInOverlayLabel:SetColor( Color( 255, 255, 255 ) )
		selectMenuOpenInYouTubeLabel:SetColor( Color( 255, 255, 255 ) )
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

	selectMenuOpenInOverlayLabel:SetPos( 200, 123 )
	selectMenuOpenInOverlayLabel:SetSize( 300, 30 )
	selectMenuOpenInOverlayLabel:SetFont( "TargetIDSmall" )
	selectMenuOpenInOverlayLabel:SetColor( Color( 200, 200, 200 ) )
	selectMenuOpenInOverlayLabel:SetText( "Open in Steam Web Browser?" )

	selectMenuOpenInYouTubeCheckbox:SetPos( 180, 150 )
	selectMenuOpenInYouTubeCheckbox:SetValue( 0 )
	selectMenuOpenInYouTubeCheckbox:SetEnabled( false )

	selectMenuOpenInYouTubeLabel:SetPos( 200, 143 )
	selectMenuOpenInYouTubeLabel:SetSize( 300, 30 )
	selectMenuOpenInYouTubeLabel:SetFont( "TargetIDSmall" )
	selectMenuOpenInYouTubeLabel:SetColor( Color( 200, 200, 200 ) )
	selectMenuOpenInYouTubeLabel:SetText( "Open in YouTube?" )

	selectMenuRunButton:SetText( "" )
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
	function selectMenuRunButton:Paint( w, h )
		draw.RoundedBox( 2, 0, 0, w, h, Color( 0, 164, 219, 255 ) )
		draw.DrawText( buttonText, "TargetIDSmall", w/2, 10, buttonTextColor, TEXT_ALIGN_CENTER )
	end
end )