--[[-------------------------------------------------------------------------
Copyright 2017 - 2021 viral32111

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

-- This file is commented af because even i don't understand how to read my own code

if ( SERVER ) then return false end

concommand.Add("OpenURLWeb", function( player, command, args )
	if ( args[1] == nil or args[2] == nil or args[3] == nil or args[4] == nil ) then return false end

	if ( args[3] == "true" ) then -- check to see if open in overlay mode is ticked
		if ( args[4] == "true" ) then -- if you also want it to open in youtube mode in the overlay
			if ( string.find( args[1], "embed/", 1, false ) ) then
				embedURL = args[1] -- lets just hope that the user sending the youtube link to someone else is smart
			else
				embedURL = string.Replace( args[1], "watch?v=", "embed/") .. "?autoplay=1&controls=0&showinfo=0"
			end
			if ( string.find( embedURL, "http://" ) or string.find( embedURL, "https://" ) ) then -- checks to see if provided link has https:// or http://
				gui.OpenURL( embedURL ) -- if it has then proceed to open it in the overlay
			else
				gui.OpenURL( "http://" .. embedURL ) -- if not then give it http://
			end
		else -- if open in youtube mode is not ticked but open in overlay is
			if ( string.find( args[1], "http://" ) or string.find( args[1], "https://" ) ) then -- checks to see if provided link has https:// or http://
				gui.OpenURL( args[1] ) -- if it has then proceed to open it in the overlay
			else
				gui.OpenURL( "http://" .. args[1] ) -- if not then give it http://
			end
		end
	else -- If open in overlay is not ticked
		if ( args[4] == "true" ) then -- check to see if open in youtube mode is ticked
			if ( string.find( args[1], "embed/", 1, false ) ) then
				embedURL = args[1] -- lets just hope that the user sending the youtube link to someone else is smart
			else
				embedURL = string.Replace( args[1], "watch?v=", "embed/") .. "?autoplay=1&controls=0&showinfo=0"
			end

			-- Create the youtube browser
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
		else -- if open in youtube mode is not ticked
			-- Create the normal web browser
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