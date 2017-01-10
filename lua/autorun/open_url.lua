if ( SERVER ) then
    print("\nLoading OpenURL...")
    print("  Author: viral32111")
    print("  Version: 1.1.1")
    print("  Issues: https://github.com/viral32111/openurl/issues")
    print("  Steam: http://steamcommunity.com/id/viral32111")
    print("  Contact: viral32111@hotmail.com")
    print("  Wiki: https://github.com/viral32111/openurl/wiki")

    include("autorun/client/cl_web_menu.lua")
    include("autorun/client/cl_select_menu.lua")
    include("autorun/server/sv_commands.lua")

    print("Finished loading OpenURL!\n")
end

if ( CLIENT ) then
    print("This server is using OpenURL (v1.1.1) (Created by viral32111)")
end
