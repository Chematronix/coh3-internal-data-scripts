
print("running localexec.lua")

--------------------------------------------------------------------------------
 -- This file contains:
 
 -- timer_gameadd( strFunc )
   -- adds a timer for the duration of the game
 
 -- AddGameTimer()  
   -- this function adds a game timer to the screen

--------------------------------------------------------------------------------
 
 

-- list of function names that will be deleted when the game is over
g_gameover = {}

-- add a function so that when the game is over - all of these functions
-- will be called automatically
function del_ongameover( funcStrName )
	print("inserting "..funcStrName)
	table.insert( g_gameover, funcStrName )
end

-- function called by autoexec_end.lua when the game is over
function ongameover()
	print("ongameover")
	
	-- this is the functor that deletes the timer in ongameover
	function delete_gametimer( key, value )
		print("deleting "..value)
		timer_del( value )
	end
	
	if (g_gameover) then
		for k,v in g_gameover do
			delete_gametimer(k,v)
		end		
	end
end

--------------------------------------------------------------------------------
-- this function adds the specified function for the duration of a single game
function timer_gameadd( strFunc )
	
	-- add function to timer event system
	timer_add( strFunc, 0.25 )
	-- remove this timer when the game ends
	del_ongameover( strFunc )
	
end

-----------------------------------------------------------------------------------
-- Time Display functions
-----------------------------------------------------------------------------------

g_showtime = 0

-- return the time in HH:MM:SS string format
function GetDisplayTime( totalseconds )
	totalseconds = math.floor( totalseconds )
	local seconds = math.fmod( totalseconds, 60 )
	totalseconds = totalseconds - seconds
	local minutes = math.fmod( totalseconds/60, 60 )
	totalseconds = totalseconds - minutes*60
	local hours = totalseconds/(60*60)
	
	if (seconds < 10) then
	 seconds = "0"..seconds
	end
	if (minutes < 10) then
	 minutes = "0"..minutes
	end
	if (hours < 10) then
	 hours = "0"..hours
	end
	
	return ( hours..":"..minutes ..":"..seconds )

end

g_overload_offset = 0

-- draw the time onscreen
function ShowTime()

	dr_clear( "timeframe" )
	
	if ( g_showtime == 0 ) then
		return
	end
	
	local timeStr = GetDisplayTime( World_GetGameTime() - g_overload_offset )
	
	dr_text2d( "timeframe", 0.7, 0.02, timeStr, 200, 200, 255 )
	dr_text2d( "timeframe", 0.8, 0.02, "simrate:"..getsimrate(), 200, 200, 255 )
	
end

rawset(_G,"ToggleShowTime", nil)

-- turn the the timer on and off
function ToggleShowTime()
	
	if (g_showtime == 1) then
		g_showtime = 0
		dr_clear( "timeframe" )
		timer_del( "ShowTime" )
	else
		g_showtime = 1
		timer_gameadd( "ShowTime", 1 )
	end
	
end

-- adds the game timer (should be called at the beginning of everygame)
function AddGameTimer()
	dr_setautoclear( "timeframe", 0 )
	-- bind timer to F11 key
	bind( "F11", "ToggleShowTime()" )
	if ( g_showtime == 1 ) then
		-- add the timer to get it going
		timer_gameadd( "ShowTime", 1 )
	end
end

function AnimatorDebugCycle()
	
end
