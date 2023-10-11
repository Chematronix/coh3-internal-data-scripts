
s_enabled = 0

function toggle_menu()
 	s_enabled = 1-s_enabled
 	enable_menu( s_enabled );
end

bind( "CONTROL+ENTER", "toggle_menu()" );

function menu_prevmenu()
	
	CheatMenu_PreviousMenu()
	
	-- special case since the prev menu may disable menu
	if (CheatMenu_IsEnabled() == false) then
		enable_menu( 0 )
	end

end

function menu_leftmenu()
	
	CheatMenu_DoItemLeft()
	
	-- special case since the prev menu may disable menu
	if (CheatMenu_IsEnabled() == false) then
		enable_menu( 0 )
	end

end

rawset( _G, "enable_menu", nil )

function enable_menu( bEnable )
	
	s_enabled = bEnable
	
	CheatMenu_Enable(s_enabled)
	
	if (s_enabled == 1) then
		
		bind( "DOWN", "CheatMenu_NextItem()" );
		bind( "UP", "CheatMenu_PreviousItem()" );
		bind( "RIGHT", "CheatMenu_DoItemRight()" );
		bind( "LEFT", "menu_leftmenu()" );
		bind("ENTER", "CheatMenu_DoItemAction()" );
		bind("SPACE", "CheatMenu_DoItemAction()" );
		bind("CONTROL+SHIFT+BACKSPACE", "CheatMenu_ClearSearch()" );
		bind("CONTROL+F", "CheatMenu_ToggleSearch()" );
		bind("PAGEUP", "for i=0,5 do CheatMenu_PreviousItem() end" );
		bind("PAGEDOWN", "for i=0,5 do CheatMenu_NextItem() end" );
		
	else
		
		unbind( "DOWN" );
		unbind( "UP" );
		unbind( "RIGHT" );
		unbind( "LEFT" );
		unbind("ENTER")
		unbind("SPACE")
		unbind("PAGEUP")
		unbind("PAGEDOWN")
		unbind("CONTROL+BACKSPACE");
	end
end