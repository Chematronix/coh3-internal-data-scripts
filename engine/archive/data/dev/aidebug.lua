
s_cachePlayerId = nil

function AIClear()

	-- clear all channels for each player
	for px=1000, 1008 do
		dr_clear("aidebug"..px)
		dr_clear("ai_menu"..px)
	end

end

---------------------------------------------
-- File with a bunch of AI helper functions
	
function AILockStatus( playerId, enable )
	
	print("AILockStatus")
	AIClear()
	AI_SetDebugPlayer( playerId )
	AI_LockStatus( enable )
	
end

function AIThreatMap( playerId, enable )
	
	print("AIThreatMap")
	AIClear()
	AI_SetDebugPlayer( playerId )
	AI_SetThreatMap( enable )
	
end

function AITaskDebug( playerId, enable )
	
	print("AITaskDebug")
	AIClear()
	AI_SetDebugPlayer( playerId )
	AI_EnableTaskRender( enable )
	
end

function AITaskHistoryDebug( playerId, enable )
	
	print("AITaskHistoryDebug")
	AIClear()
	AI_SetDebugPlayer( playerId )
	AI_EnableTaskRender( false )
	
end

function AITacticDebug( playerId, enable )
	
	print("AITacticDebug")
	AIClear()
	AI_SetDebugPlayer( playerId )
	AI_EnableTacticRender( enable )
	
end

function AITargetDebug(playerID, enable)
	print("AITargetDebug")
	AIClear()
	AI_SetDebugPlayer(playerID)
	AI_EnableTargetRender(enable)
end

function AIRenderClumps( playerId, enable )
	
	print("AIRenderClumps")
	AIClear()
	AI_SetDebugPlayer( playerId )
	AI_SetRenderClumps( enable )
	
end

function AIRenderThreatHistory( playerId, enable )
	
	print("AIRenderThreatHistory")
	AIClear()
	AI_SetDebugPlayer( playerId )
	AI_SetRenderThreatHistory( enable )
	
end

function AIObstructions( playerId, enable )
	
	print("AIObstructions")
	AIClear()
	AI_SetDebugPlayer( playerId )
	Sim_SetRenderObstructions( enable )
	
end

function AITaskFilterMax( )
	
	-- value found in AITaskTypes.h  + 1
	return TASK_COUNT
	
end

function AIFlagEnable( playerId, enable, flagname )

	AIClear()

	-- disable the onscreen AI menu system (just in case it was on)
	s_cachePlayerId = nil
	AI_DoString( playerId, "enable_menu(0)" )
	
	if (enable) then
		print("AIFlagEnable:true")
		AI_DoString( playerId, "s_debug_enabled=true" )
		AI_DoString( playerId, flagname.."=true" )
	else
		print("AIFlagEnable:false")
		AI_DoString( playerId, "s_debug_enabled=true" )
		AI_DoString( playerId, flagname.."=false" )
	end
end

s_enable_flags = {}
function AIFlagToggle( playerId, flagname )

	AIClear()
	
	-- create flag
	if (not s_enable_flags[flagname]) then
		s_enable_flags[flagname]=false
	end
	
	-- flip flag value
	s_enable_flags[flagname]=not s_enable_flags[flagname]

	-- set this flag
	AIFlagEnable( playerId, s_enable_flags[flagname], flagname )

end

function AIGetFlag(flagname )

	-- create flag
	if (not s_enable_flags[flagname]) then
		s_enable_flags[flagname]=false
	end
	
	-- return flag value
	return s_enable_flags[flagname]

end

function AISetFlag( playerId, flagname, value )

	AIClear()
	
	-- create flag
	if (not s_enable_flags[flagname]) then
		s_enable_flags[flagname]=false
	end
	
	-- flip flag value
	s_enable_flags[flagname]=value

	-- set this flag
	AIFlagEnable( playerId, s_enable_flags[flagname], flagname )

end

function AIDebugScrollUp()
	-- ignores playerID, we scroll for all players so that whatever is on screen works
	local pcount = World_GetPlayerCount()
	for pi=1, pcount do
		
		local playerid = World_GetPlayerAt( pi )
		
		if (AI_IsAIPlayer( playerid )==true) then
			AI_DoString( playerid, "DebugScrollUp()" )
		end
	end
end

function AIDebugScrollDown()
	-- ignores playerID, we scroll for all players so that whatever is on screen works	
	local pcount = World_GetPlayerCount()
	for pi=1, pcount do
		
		local playerid = World_GetPlayerAt( pi )
		
		if (AI_IsAIPlayer( playerid )==true) then
			AI_DoString( playerid, "DebugScrollDown()" )
		end
	end	
end

s_current_lockstatus_player_idx = 0
function AINextLockStatus()
	local playerid = nil
	local pcount = World_GetPlayerCount()

	s_current_lockstatus_player_idx = s_current_lockstatus_player_idx + 1
		
	if (s_current_lockstatus_player_idx > pcount) then
		s_current_lockstatus_player_idx = 0
	else
		playerid = World_GetPlayerAt( s_current_lockstatus_player_idx )
	end
	
	AILockStatus(playerid, true)
end

s_current_lock_player_debug_idx = 1
function AINextPlayerDebug()
	s_current_lock_player_debug_idx = s_current_lock_player_debug_idx + 1
		
	if (s_current_lock_player_debug_idx > World_GetPlayerCount()) then
		s_current_lock_player_debug_idx = 1
	end

	local player = World_GetPlayerAt( s_current_lock_player_debug_idx )
	
	AIClear()
	AI_LockPlayerDebug( player )
end

function AITogglePlayerDebug(player_idx, enable)
	s_current_lock_player_debug_idx = player_idx
		
	local player = World_GetPlayerAt( s_current_lock_player_debug_idx )

	AIClear()
	AI_LockPlayerDebug( player )
	AI_SetDebugDisplay( player, enable)	
end

----------------------------------------------------------------------------
-- INTERFACE FOR AI DEBUG MENU

function AI_MC1( )
	
	if (s_cachePlayerId and AI_IsAIPlayer( s_cachePlayerId )) then
		AI_DoString( s_cachePlayerId, "menu_change(1)" )
	end
end

function AI_MCNeg1( )
		
	if (s_cachePlayerId and AI_IsAIPlayer( s_cachePlayerId )) then
		AI_DoString( s_cachePlayerId, "menu_change(-1)" )
	end
end

function AI_MCAccept( )
		
	if (s_cachePlayerId and AI_IsAIPlayer( s_cachePlayerId )) then
		AI_DoString( s_cachePlayerId, "menu_run()" )
	end
end

function AI_MCBack( )
		
	if (s_cachePlayerId and AI_IsAIPlayer( s_cachePlayerId )) then
		AI_DoString( s_cachePlayerId, "menu_back()" )
	end
end

function AI_Refresh()
	
	if (s_cachePlayerId and AI_IsAIPlayer( s_cachePlayerId )) then
		AI_DoString( s_cachePlayerId, "menu_refresh()" )
	end
	
end

function AIViewEnable(playerId)
	
	AIClear()
	
	AI_DoString( playerId, "toggle_menu()" )
	
	s_cachePlayerId = playerId
	
	bind("CONTROL+DOWN","AI_MC1()")
	bind("CONTROL+UP","AI_MCNeg1()")
	bind("CONTROL+SPACE","AI_MCAccept()")
	bind("CONTROL+RIGHT","AI_MCAccept()")
	bind("CONTROL+LEFT","AI_MCBack()")
	bind("CONTROL+R","AI_Refresh()")
--~ bind("PAGEUP", "menu_change(-10)")
--~ bind("PAGEDOWN", "menu_change(10)")
	
end

s_lastAISquadID = INVALID_AISQUADID

-- private helper function that finds the next ai-squad given the nextfunc helper function
function AIPriv_FocusNextSquad(playerId, nextfunc) 

	-- this gets the next valid ai-squad-id from the given one (if its not valid it returns the first value or error)
	s_lastAISquadID = nextfunc( playerId, s_lastAISquadID )
	
	-- if its not valid stop here
	if (s_lastAISquadID == INVALID_AISQUADID) then
		return
	end
	
	-- convert id to aisquad-ptr
	local aisquad = AI_FindAISquadByID( playerId, s_lastAISquadID )
	
	-- convert aisquad-ptr to Squad*
	local simsquad = AI_ConvertToSimSquad( aisquad )
	
	-- now have the camera follow this squad
	Camera_FollowSquad( simsquad )
	
end

function AI_FocusNextSquad( playerId )
	AIPriv_FocusNextSquad( playerId, AI_GetAISquadID )
end

function AI_FocusNextUnlockedSquad( playerId )
	AIPriv_FocusNextSquad( playerId, AI_GetUnlockedAISquadID )
end

