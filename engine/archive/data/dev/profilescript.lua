
function profile_start()

	Profile_SetPosition(0.1,0.1);

  bind( "PERIOD", "Profile_SelectorNextChild()" );
  bind( "COMMA", "Profile_SelectorPrevChild()" );
  bind( "ENTER", "Profile_SelectorGotoChild()" );
  bind( "BACKSPACE", "Profile_GotoParent()" );
	
	Profile_EnableInGame()
end

function profile_end()
	unbind( "PERIOD" );
	unbind( "COMMA" );
	unbind( "ENTER" );
	unbind( "BACKSPACE" );
	Profile_DisableInGame()
end

s_profileIsOn = 0
function profile_toggle()
	if (s_profileIsOn==1) then
		s_profileIsOn = 0
		profile_end()
	else
		s_profileIsOn = 1
		profile_start()
	end
end

-- when this file is first read in, start the profiler
profile_toggle()

-- make sure this is always bound after this file is added
bind( "CONTROL+SHIFT+ENTER", "profile_toggle()" );