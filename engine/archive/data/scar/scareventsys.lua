-----------------------------------------------------------------------------------------------------------------
-- ScarEventSys.lua 
--		Lua support for the Scar events system.  Scar events system is used mainly for the NISLets.
--
-- Copyright 2016 SEGA Corporation, Developed by Relic Entertainment
--
-- TODO: explain how the CTRL works


--
-- this is just a dummy function
--
function _donothing(...) return end


--
-- create / init CTRL object
--
CTRL  = {}
CTRL._function = _donothing
CTRL._functionname = "_donothing" -- for debug
CTRL._acceptwaits = false
CTRL._acceptsubs = false
CTRL._sublevel = 0


--
-- this function will go into a sub level controller - future waits will not wait on already registered waits.
--
function CTRL.SUB()
	-- need to make sure we are in between a CTRL. and a CTRL.WAIT
	if( CTRL._acceptsubs == false ) then
		error("CTRL.SUB() is only valid after calling a function through a CTRL")
	end
	
	CTRL._sublevel = CTRL._sublevel + 1
end


--
-- exit the sub level
--
function CTRL.END()
	-- should we force the designer to wait?  sure, why not.
	if( CTRL._acceptsubs == true ) then
		error("You need to call CTRL.WAIT() before you can use CTRL.END()")
	end
	
	if( CTRL._sublevel == 0 ) then
		error("You cannot call CTRL.END() from the root level")
	end
	
	CTRL._sublevel = CTRL._sublevel - 1
end


-- 
-- wait for all functions called through the controller and its sub controllers
--
function CTRL.WAIT()
	CTRL._acceptsubs = false
	
	-- throws an error if we are not in a coroutine
	if( not Event.IsInCoroutine( ) ) then error("CTRL can only be used in an event coroutine") end
	
	-- 
	if( Event.GetNumWaits( CTRL._sublevel ) > 0 ) then 	
		
		Event.SetIsWaiting( true )
		--print("yeilding")
		coroutine.yield( 1 )
		
	end
	
end


--
-- This is called whenever a global function is called through the controller ( eg. CTRL.GlobalFunction )
-- The function global function being called is available in the CTRL._function field and the args are passed in using ...
--
function CTRL.Caller( ... )
	
	local arg = {...}
	
	if(CTRL._function == nil) then
		error("this should never happen")
		return
	end
	
	-- once a function has been called through a controller, we can accept subs.  subs are acceptable until a wait is called.
	CTRL._acceptsubs = true
	
	if(type(CTRL._function) ~= "function") then error("this is not a function yo type:"..type(CTRL._function)) end
	
	-- before calling this function, let the system know that we are accepting waits to be registered
	CTRL._acceptwaits = true
		
	local argc = (# arg )
	
	local waits = Event.GetNumWaits(  CTRL._sublevel )
	
	-- call it!
	if( argc == 0 ) then
		CTRL._function( )
	elseif( argc == 1 ) then
		CTRL._function( arg[1] )
	elseif( argc == 2 ) then
		CTRL._function( arg[1], arg[2] )
	elseif( argc == 3 ) then
		CTRL._function( arg[1], arg[2], arg[3] )
	elseif( argc == 4 ) then
		CTRL._function( arg[1], arg[2], arg[3], arg[4] )
	elseif( argc == 5 ) then
		CTRL._function( arg[1], arg[2], arg[3], arg[4], arg[5] )
	elseif( argc == 6 ) then
		CTRL._function( arg[1], arg[2], arg[3], arg[4], arg[5], arg[6] )
	elseif( argc == 7 ) then
		CTRL._function( arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7] )
	elseif( argc == 8 ) then
		CTRL._function( arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8] )
	elseif( argc == 9 ) then
		CTRL._function( arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9] )
		
	else
		error("too many args in _function")
	end
	
	-- verify that waits were added for this function.  if no waits were added then this function should NOT have been called through the controller (it is not compatible)
	if( (not Event.IsSkipping()) and Event.GetNumWaits( CTRL._sublevel ) <= waits and CTRL._function ~= _donothing ) then
		error("Function "..CTRL._functionname.." cannot be called through the CTRL.  It is not compatible" )
	end
	
	-- ok, the call is done, we are no longer accepting waits.
	CTRL._acceptwaits = false
	
end


--
-- this function will get called when indexing a nil key of the CTRL table
-- this makes it possible to detect when a function is getting called through the CTRL table
--
function CTRL_IndexOperator( table, key )

	-- throws an error if we are not in a coroutine
	if( not Event.IsInCoroutine( ) ) then error("CTRL can only be used in an event coroutine") end
	
	
	local v = _G[key]
		
	if("function" == type(v)) then
		CTRL._function = v
		CTRL._functionname = key -- for debug
	else
		error( "function "..key.." does not exist" )
		--CTRL._function = _donothing
		--CTRL._functionname = "_donothing" -- for debug
	end
	
	return CTRL.Caller;
end


--
-- register the index operator AFTER everything is created
--
setmetatable(CTRL, { __index = CTRL_IndexOperator })



