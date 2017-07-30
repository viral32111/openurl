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

concommand.Add("OpenURLRequest", function( player, command, args )
	if ( args[1] == nil or args[2] == nil or args[3] == nil or args[4] == nil or args[5] == nil ) then return false end

	local ply = LocalPlayer()

	local authFrame = vgui.Create( "DFrame" )
	authFrame:SetPos( ScrW()/2-528, ScrH()/2-48 )
	authFrame:SetSize( 1056, 105 )
	authFrame:SetTitle( "OpenURL" )
	authFrame:SetVisible( true )
	authFrame:SetDraggable( false )
	authFrame:SetSizable( false )
	authFrame:SetBackgroundBlur( false )
	authFrame:ShowCloseButton( false )
	authFrame:MakePopup()
	function authFrame:Paint( w, h )
		draw.RoundedBox( 2, 0, 0, w, h, Color( 50, 50, 50, 255 ) ) -- Body
		draw.RoundedBox( 2, 0, 0, w, 24, Color( 0, 164, 219, 255 ) ) -- Header
		draw.RoundedBox( 0, 0, 24, w, 1, Color( 230, 230, 230, 230 ) ) -- Line
	end

	local authFrameLabel = vgui.Create( "DLabel", authFrame )
	authFrameLabel:SetPos( 10, 23 )
	authFrameLabel:SetSize( 1000, 32 )
	authFrameLabel:SetFont( "TargetIDSmall" )
	authFrameLabel:SetColor( Color( 255, 255, 255) )
	if ( args[4] == "true" ) then
		authFrameLabel:SetText( args[1] .. " wants to open this website on you: " .. args[2] )
	else
		if ( args[5] == "true" ) then
			authFrameLabel:SetText( args[1] .. " wants to open this YouTube video on you: " .. args[3] )
		else
			authFrameLabel:SetText( args[1] .. " wants to open this website on you: " .. args[2] .. " (" .. args[3] .. ")")
		end
	end

	local authFrameAskLabel = vgui.Create( "DLabel", authFrame )
	authFrameAskLabel:SetPos( authFrame:GetWide()/2-150, 41 )
	authFrameAskLabel:SetSize( 300, 32 )
	authFrameAskLabel:SetFont( "TargetIDSmall" )
	authFrameAskLabel:SetColor( Color( 255, 255, 255) )
	authFrameAskLabel:SetText( "Allow this website to be opened?" )

	local authFrameAllowButton = vgui.Create( "DButton", authFrame )
	authFrameAllowButton:SetText( "" )
	authFrameAllowButton:SetPos( 10, 72 )
	authFrameAllowButton:SetSize( 510, 25 )
	authFrameAllowButton.DoClick = function()
		ply:ConCommand('OpenURLWeb "' ..  args[2] .. '" "' .. args[3] .. '" "' .. args[4] .. '" "' .. args[5] .. '"')
		authFrame:Close()
	end
	function authFrameAllowButton:Paint( w, h )
		draw.RoundedBox( 2, 0, 0, w, h, Color( 0, 164, 219, 255 ) )
		draw.DrawText( "Yes", "TargetIDSmall", w/2, 5, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
	end

	local authFrameDisallowButton = vgui.Create( "DButton", authFrame )
	authFrameDisallowButton:SetText( "" )
	authFrameDisallowButton:SetPos( 535, 72 )
	authFrameDisallowButton:SetSize( 510, 25 )
	authFrameDisallowButton.DoClick = function()
		authFrame:Close()
		return false
	end
	function authFrameDisallowButton:Paint( w, h )
		draw.RoundedBox( 2, 0, 0, w, h, Color( 0, 164, 219, 255 ) )
		draw.DrawText( "No", "TargetIDSmall", w/2, 5, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER )
	end
end )