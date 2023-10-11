
--
--dofile("dev/game-warnings.lua")			


-- BE WARNED:
--  These functions are all non-deterministic!!

-- Function to kill an enemy with a given id
function KillEntity( nr )
	local entity = Entity_FromID( nr );
	Entity_Destroy( entity );
end

function dbBreak( filename, line )
	if( filename == nil ) then
		Scar_DoString("dbBreak()")
	else
		Scar_DoString( "dbAddBreak([[DATA:Scenarios\\SP\\"..filename.."]],"..line..")" )
	end
end

function KillMousedEntity()
	if( Misc_IsMouseOverEntity() ) then
		local entityID = Misc_GetMouseOverEntity()
		Entity_Destroy( entityID )
	end
end

function BurnMousedEntity()
	
	if( Misc_IsMouseOverEntity() ) then
		local entityID = Misc_GetMouseOverEntity()
		Entity_DoBurnDamage( entityID, 0.1 )
	end

end

-- moves entity under the mouse to a position offset by its squad position
function ScatterMousedEntity( radius )
	Scar_DoString(
	[[
		if( Misc_IsMouseOverEntity() ) then
			local entityID = Misc_GetMouseOverEntity()
			Entity_ScatterFromSquad( entityID, ]]..radius..[[ )
		end
	]]
	)
end

-----------------------------------------------------------------

s_animatorDebugEntityID = nil
s_animatorDebugMask = 0															-- all flags off
s_animatorDebugOffset = 0
s_animatorDebugLock = 0


rawset(_G, "animator_debug_update", nil )
rawset(_G, "animator_debug", nil )
rawset(_G, "animator_debug_mask", nil )
rawset(_G, "animator_debug_offset", nil )

function animator_debug_update()

	local debug_entity = nil
	local new_debug_entity = Entity_GetDebugEntity()

	if (new_debug_entity == nil) then
		new_debug_entity = Misc_GetMouseOverEntity()
	end
	
	-- retrieve entity* from ID if it previously existed
	if( s_animatorDebugEntityID ~= nil and Entity_IsValid(s_animatorDebugEntityID) ) then
		debug_entity = Entity_FromID( s_animatorDebugEntityID )
	else
		s_animatorDebugEntityID = nil
	end
	
	if(s_animatorDebugMask == 0) then
		-- if animator debug mask is 0, then turn off all debugging and reset debug entity
		if( debug_entity ~= nil ) then
			set_animator_debug_state( debug_entity, 0, 0 )
			s_animatorDebugEntityID = nil
		end
	elseif (new_debug_entity ~= nil) then
		if( debug_entity ~= nil and new_debug_entity ~= debug_entity ) then
			-- turn off old debug info
			set_animator_debug_state( debug_entity, 0, 0 )						
		end

		-- force propagate debug mask update
		set_animator_debug_state( new_debug_entity, s_animatorDebugMask, s_animatorDebugOffset )
		
		-- remember this entity as our debug animator
		s_animatorDebugEntityID = Entity_GetID(new_debug_entity)
			
	end
end

function animator_debug_enable( bEnable )

	if ( bEnable ) then
		timer_add("animator_debug_update", 0.125)
		bind("CONTROL+ALT+LEFT", "animator_debug_scroll(true)")
		bind("CONTROL+ALT+RIGHT", "animator_debug_scroll(false)")
	else
		s_animatorDebugLock = 0
		timer_del("animator_debug_update")
		unbind("CONTROL+ALT+LEFT")
		unbind("CONTROL+ALT+RIGHT")
	end

end

--? @shortdesc Toggle mouse over changing the current animator for debug
--? @extdesc ...
--? @args <none>
--? @result <none>
function animator_debug_lock_selection()
	if ( s_animatorDebugLock == 1 ) then
		s_animatorDebugLock = 0
	else
		s_animatorDebugLock = 1
	end
	
	animator_debug_update()
end

--? @shortdesc Toggles animator debug information rendering (all flags)
--? @extdesc ...
--? @args <none>
--? @result integer
function animator_debug()
	if( s_animatorDebugMask ~= 0 ) then
		s_animatorDebugMask = 0;												-- all flags off
		animator_debug_enable( false )
	else
		s_animatorDebugMask = 15;												-- some flags on
		animator_debug_enable( true )
	end
	animator_debug_update()
	
	return s_animatorDebugMask
end

--? @shortdesc Toggles animator debug information rendering byt means of a mask
--? @extdesc ...
--? @args <none>
--? @result <none>
function animator_debug_mask( mask )
	s_animatorDebugMask = mask;
	if ( s_animatorDebugMask == 0 ) then
		animator_debug_enable( false )
	else
		animator_debug_enable( true )
	end

	animator_debug_update()
end

--? @shortdesc Jumps to the next set of animator debug information
--? @extdesc ...
--? @args <none>
--? @result <none>
function animator_debug_increment()
	if(s_animatorDebugMask < 1) then
		s_animatorDebugMask = 1
	elseif(s_animatorDebugMask < 2) then
		s_animatorDebugMask = 2
	elseif(s_animatorDebugMask < 4) then
		s_animatorDebugMask = 4
	elseif(s_animatorDebugMask < 8) then
		s_animatorDebugMask = 8
	elseif(s_animatorDebugMask < 16) then
		s_animatorDebugMask = 16
	elseif(s_animatorDebugMask < 32) then
		s_animatorDebugMask = 32
	elseif(s_animatorDebugMask < 64) then
		s_animatorDebugMask = 64
	elseif(s_animatorDebugMask < 128) then
		s_animatorDebugMask = 128
	else
		s_animatorDebugMask = 0
	end

	if ( s_animatorDebugMask == 0 ) then
		animator_debug_enable( false )
	else
		animator_debug_enable( true )
	end
	
end

--? @shortdesc Toggles animator debug information rendering byt means of a mask
--? @extdesc ...
--? @args <none>
--? @result <none>
function animator_debug_offset( offset )
	s_animatorDebugOffset = offset;

	animator_debug_update()
end

addkeyword( "animator_debug" )
addkeyword( "animator_debug_mask" )
addkeyword( "animator_debug_increment" )
addkeyword( "animator_debug_offset" )
addkeyword( "animator_debug_lock_selection" )

timer_del("animator_debug_update")


-----------------------------------------------------------------
-- Flashes designer warning count onscreen
dr_setautoclear( "warnings", 0 )
s_togglewarningcol = 0
s_warning_timer = 40 * 4  -- (times 4 becauses its run 4 times/sec)

g_designers_warning_count_start = 0
g_designers_warning_count = 0
g_physics_warning_count = 0
g_art_warning_count = 0

rawset(_G,"show_warnings", nil)

function show_warnings()
	
	dr_clear( "warnings" )
	
	if (s_warning_timer < 0) then
		timer_del("show_warnings")
		-- save the number of warnings we had when we exit
		g_designers_warning_count_start = g_designers_warning_count
		
		-- this adds a timer to look for new warnings being added at runtime(not needed?)
		-- timer_del("warning_count_change_check")
		-- timer_add("warning_count_change_check", 1)
		return
	end
	
	s_warning_timer = s_warning_timer - 1
	
	g_designers_warning_count = app_warningscount()
	g_art_warning_count = app_artwarningscount()
	g_physics_warning_count = app_physicswarningscount()
		
	if (g_designers_warning_count == 0) then
		return
	end
	
	if (g_designers_warning_count>0) then
		s_togglewarningcol = 1-s_togglewarningcol
	end
	
	local col = {{200, 200, 255},{255, 0, 100}}
	local fcol = col[1+s_togglewarningcol]
	
	if (g_art_warning_count > 0) then
		local artstr = "ART-Warnings:"..g_art_warning_count
		dr_text2d( "warnings", 0.16, 0.07, artstr, fcol[1], fcol[2], fcol[3] )
	end
		
	if (g_physics_warning_count > 0) then
		local physstr = "PHYSICS-Warnings:"..g_physics_warning_count
		dr_text2d( "warnings", 0.30, 0.07, physstr, fcol[1], fcol[2], fcol[3] )
	end
	
	if (g_designers_warning_count > 0) then
		local str = "DATA-Warnings:"..g_designers_warning_count
		dr_text2d( "warnings", 0.02, 0.07, str, fcol[1], fcol[2], fcol[3] )
	end

end

function warning_count_change_check()
	
	g_designers_warning_count = app_warningscount()
	g_art_warning_count = app_artwarningscount()
	g_physics_warning_count = app_physicswarningscount()
	
	if (g_designers_warning_count > g_designers_warning_count_start) then
		
		s_warning_timer = 10*4
		timer_del("show_warnings")
		timer_add("show_warnings",0.25)
		timer_del("warning_count_change_check")
	end

end

function turn_off_warnings()
	timer_del("show_warnings")
	dr_clear( "warnings" )
	
	unbind( "ALT+C" )
end

if (getbuildtype() ~= "RTM") then
	bind( "ALT+C", "turn_off_warnings()" )
end

timer_del("show_warnings")

-- only add this if g_demo is not set
if (g_demo == false and getbuildtype() ~= "RTM") then
	timer_add("show_warnings",0.25)
end

---------------------------------------------------------------------------------------------
-- Unit Count display
dr_setautoclear( "unit_count", 0 )
s_bShowUnitCounts = false

function toggle_unit_counts()
	s_bShowUnitCounts = not s_bShowUnitCounts
	
	dr_clear("unit_count")
	timer_del("show_unit_counts")
	
	if s_bShowUnitCounts == true then
		show_unit_counts()
		timer_add("show_unit_counts", 1.0)
	end
end

function show_unit_counts()

	if s_bShowUnitCounts == false then
		return
	end
	
	dr_clear("unit_count")
	
	local xpos = 0.50
	local ypos = 0.4
	
	-- each player
	local playercount = World_GetPlayerCount()
	local total_squadcount = 0
	local total_unitcount = 0
	local total_vehiclecount = 0
	local total_heavyweaponcount = 0
	local total_othercount = 0
	
	for i = 1, playercount do
		
		local thisplayer = World_GetPlayerAt(i)
		local thisplayer_name = Player_GetRaceName(thisplayer)
		local thisplayer_squadcount = Player_GetSquadCount(thisplayer)
		local thisplayer_entitycount = Player_GetEntityCount(thisplayer)
		local sgroupID = Player_GetSquads(thisplayer)
		
		local thisplayer_unitcount = 0
		local thisplayer_vehiclecount = 0
		local thisplayer_heavyweaponcount = 0
		local thisplayer_othercount = 0
		
		local thisplayer_backgroundsquadcount = 0
		local thisplayer_backgroundunitcount = 0
		
		-- count each squad
		local _EachSquad = function(gid, idx, sid)
			-- check the composition of this squad
			local thissquad_specialcount = 0
			for i = 1, Squad_Count(sid) do
				local entity = Squad_EntityAt(sid, i - 1)
				if Entity_IsVehicle(entity) then
					-- note that heavy weapons are also reported as vehicles
					thissquad_specialcount = thissquad_specialcount + 1
				end
			end

			local thissquad_entitycount = Squad_Count(sid)
			local thissquad_vehiclecount = 0
			local thissquad_heavyweaponcount = 0
			local isInBackground = Squad_IsInBackground(sid)
		
			if (isInBackground) then
				thisplayer_backgroundsquadcount = thisplayer_backgroundsquadcount + 1
				thisplayer_backgroundunitcount = thisplayer_backgroundunitcount + thissquad_entitycount
			end

			if( thissquad_specialcount > 0 ) then
				if( thissquad_entitycount == 1 ) then
					-- a "vehicle" that only has only one entity in the squad, likely a real vehicle
					thissquad_entitycount = 0
					thissquad_vehiclecount = thissquad_specialcount
				else
					-- a "vehicle" that only has more than one entity in the squad, likely a heavy weapon
					thissquad_entitycount = thissquad_entitycount - thissquad_specialcount
					thissquad_heavyweaponcount = thissquad_specialcount
				end
			else
				-- no "vehicle" in this squad, leave the entity count as is
			end

			thisplayer_unitcount = thisplayer_unitcount + thissquad_entitycount
			thisplayer_vehiclecount = thisplayer_vehiclecount + thissquad_vehiclecount
			thisplayer_heavyweaponcount = thisplayer_heavyweaponcount + thissquad_heavyweaponcount
		end
		
		SGroup_ForEach(sgroupID, _EachSquad)
		
		-- player total
		thisplayer_othercount = thisplayer_entitycount - (thisplayer_unitcount + thisplayer_heavyweaponcount + thisplayer_vehiclecount) 
		local thisplayer_foregroundsquadcount = thisplayer_squadcount - thisplayer_backgroundsquadcount
		local thisplayer_foregroundunitcount = thisplayer_unitcount - thisplayer_backgroundunitcount
		
		-- display
		local str = "Player " .. tostring(i) .. ": " .. thisplayer_name .. ": " .. thisplayer_squadcount .. " squads (" .. thisplayer_foregroundsquadcount .. "/" .. thisplayer_backgroundsquadcount .. "), " .. thisplayer_unitcount .. " units (" .. thisplayer_foregroundunitcount .. "/" .. thisplayer_backgroundunitcount .. ")"
		if thisplayer_heavyweaponcount > 0 then
			str = str .. ", " .. thisplayer_heavyweaponcount .. " heavy weapons"
		end
		if thisplayer_vehiclecount > 0 then
			str = str .. ", " .. thisplayer_vehiclecount .. " vehicles"
		end
		str = str .. ", " .. thisplayer_othercount .. " other"

		dr_text2d("unit_count", xpos, ypos, str, 255, 255, 255)
		ypos = ypos + 0.02
		
		-- world total
		total_squadcount = total_squadcount + thisplayer_squadcount
		total_unitcount = total_unitcount + thisplayer_unitcount
		total_vehiclecount = total_vehiclecount + thisplayer_vehiclecount
		total_heavyweaponcount = total_heavyweaponcount + thisplayer_heavyweaponcount
		total_othercount = total_othercount + thisplayer_othercount
	end
	
	ypos = ypos + 0.02

	-- player totals
	local total_str = "Total: " .. total_squadcount .. " squads, " .. total_unitcount .. " entities, " .. total_heavyweaponcount .. " heavy weapons, " .. total_vehiclecount .. " vehicles, " .. total_othercount .. " other"

	dr_text2d("unit_count", xpos, ypos, total_str, 255, 255, 255)
	ypos = ypos + 0.02
	
	-- weighted totals
	local weighted_str = "Weighted Total: " .. (total_unitcount + (3 * total_heavyweaponcount) + (5 * total_vehiclecount) + (0.5 * total_othercount))

	dr_text2d("unit_count", xpos, ypos, weighted_str, 255, 255, 255)
	ypos = ypos + 0.02
	
	-- leftover world-owned entities
	local world_entitycount = World_GetNumEntities() - ( total_unitcount + total_heavyweaponcount + total_vehiclecount )
	
	local world_str = "World-owned entities: " .. world_entitycount
	dr_text2d("unit_count", xpos, ypos, world_str, 255, 255, 255)
	ypos = ypos + 0.02
	
end

if (getbuildtype() ~= "RTM") then
	bind( "CONTROL+ALT+E", "toggle_unit_counts()" )
end

---------------------------------------------------------------------------------------------

function Debug_FallBackToGarrisonBuilding( sgroupid, radius )

	-- check if the sgroup is empty or not
	if ( SGroup_CountSpawned( sgroupid ) == 0 ) then
		
		print("*** WARNING in Util_FallBackToGarrisonBuilding: SGroup is empty ***")
		
	else
		-- get the first squad of the sgroup 
		local squad = SGroup_GetSpawnedSquadAt( sgroupid, 1 )
		
		-- get the sgroup owner player
		local player = Squad_GetPlayerOwner(squad)
		
		-- get sgroup centre position
		local centre = SGroup_GetPosition( sgroupid )
		
		-- find all loadable buildings within the radius
		local eg = EGroup_Create( "temp" )
		World_GetEntitiesNearPoint( player, eg, centre, radius, OT_Neutral )
		World_GetEntitiesNearPoint( player, eg, centre, radius, OT_Ally )
		
		--print( "Entities found: "..EGroup_Count( eg ) )
		
		local building = nil
		
		local CheckEntity = function( groupid, itemindex, itemid )
			
			-- skip entities that are not loadable
			if ( Entity_CanLoadSquad( itemid, squad, true, false ) == false ) then
				--print( "Entity cannot load squad. Next!" )
				return false
			end
			
			local sg = SGroup_Create( "temp" )
			
			-- find the number of enemies near the building
			local numEnemies = World_GetSquadsNearPoint( player, sg, Entity_GetPosition( itemid ), radius, OT_Enemy )
			
			SGroup_Destroy( "temp" )		
			
			-- If the building doesn't have enemy near it, then the squad is save to load
			if ( numEnemies == 0 ) then
				
				-- print( "No enemy found nearby. Garrisoning..." )
				
				-- save the building EntityID
				building = itemid 
				
				local eg_building = EGroup_Create( "temp2" )
				EGroup_Add( eg_building, itemid )
				
				-- garrison this building here
				Command_SquadEntityLoad(player, sgroupid, SCMD_Load, eg_building, false, false)
				
				EGroup_Destroy( eg_building )
				
				-- do not continue the for loop
				return true
			end
			
			-- print( "Enemy nearby the building. Next!" )
			
			return false
		end
		
		EGroup_ForEach( eg, CheckEntity )
		
		EGroup_Destroy( eg )
		
		return building
		
	end
	
end

function GarrisonNearbyStructure()
	if( Misc_IsMouseOverEntity() ) then
		local entityID = Misc_GetMouseOverEntity()
		local squadID = Entity_GetSquad(entityID)
		if squadID ~= nil then
			local __garrisonNearGroup = SGroup_Create("__garrisonNearGroup")
			SGroup_Add(__garrisonNearGroup, squadID)
			Debug_FallBackToGarrisonBuilding(__garrisonNearGroup, 50)
			SGroup_Clear(__garrisonNearGroup)
		end
	end
end

function MakeWreckMousedEntity()
	if( Misc_IsMouseOverEntity() ) then
		local entityID = Misc_GetMouseOverEntity()
		ModMisc_MakeWreckAction( entityID )
	end
end

function MakeCasualtyMousedEntity()
	if( Misc_IsMouseOverEntity() ) then
		local entityID = Misc_GetMouseOverEntity()
		ModMisc_MakeCasualtyAction( entityID )
	end
end

function OOCMousedEntity()
	if( Misc_IsMouseOverEntity() ) then
		local entityID = Misc_GetMouseOverEntity()
		ModMisc_OOCAction( entityID )
	end
end

function KnockbackMousedEntity()
	if( Misc_IsMouseOverEntity() ) then
		local entityID = Misc_GetMouseOverEntity()
		ModMisc_DebugKnockbackAction( entityID )
	end
end

function MousedAbility( abilitybp, doenenmyability )
	local playerid = Player_FromId(getlocalplayer())
	
	if doenenmyability == true then
		playerid = Player_FindFirstEnemyPlayer( playerid )
	end
	
	local pos = Misc_GetMouseOnTerrain()
	local direction = World_Pos(World_GetRand(0,100) / 100,0,World_GetRand(0,100) / 100)
	
	if not ( Player_HasAbility( playerid, abilitybp )) then
		Player_AddAbility( playerid, abilitybp )
	end
	Command_PlayerPosDirAbility( playerid, playerid, pos, direction, abilitybp, true )
end

function DropMortarAtMousePosition()

	local pid = World_GetPlayerAt(1)
	local abp = BP_GetAbilityBlueprint("off_map_artillery")
	local pos = Misc_GetMouseOnTerrain()
	
	Player_AddAbility(pid, abp)
	Command_PlayerPosAbility( pid, pid, pos, abp, true) 
	
end

function DropArtyOneShotAtMousePosition()

	local pid = World_GetPlayerAt(1)
	local abp = BP_GetAbilityBlueprint("off_map_arty_single_shot_instant")
	local pos = Misc_GetMouseOnTerrain()
	
	Player_AddAbility(pid, abp)
	Command_PlayerPosAbility( pid, pid, pos, abp, true) 
	
end

function AddUpgradeToMousedEntity(blueprintName)
	Entity_CompleteUpgrade(Misc_GetMouseOverEntity(), BP_GetUpgradeBlueprint(blueprintName))
end

function AddUpgradeToMousedSquad(blueprintName)
	Squad_CompleteUpgrade(Misc_GetMouseOverSquad(), BP_GetUpgradeBlueprint(blueprintName))
end

function RemoveHintPoint( idx )
	HintPoint_Remove( idx )
end

function AddHintPointToEntity(eGroupName)
	if (Misc_IsMouseOverEntity() ) then
		local entityID = Misc_GetMouseOverEntity()
		local eGroupID = EGroup_Create(eGroupName)
		EGroup_Add(eGroupID, entityID)
		HintPoint_AddToEGroup(eGroupID, 0, 50, true, HintPoint_Remove, 38073, 38073, 38073)
	end
end

function AddHintPointToEntityGroup(eGroupName)
	if (EGroup_FromName(eGroupName)) then
		local eGroupID = EGroup_FromName(eGroupName)
		HintPoint_AddToEGroup(eGroupID, 0, 50, true, HintPoint_Remove, 38073, 38073, 38073)
	end
end

function AddHintPointToSquad(eSquadName)
	if (Misc_IsMouseOverEntity()) then
		local entityID = Misc_GetMouseOverEntity()
		local squadID = Entity_GetSquad(entityID)
		local sGroupID = SGroup_Create(eSquadName)
		SGroup_Add(sGroupID, squadID)
		HintPoint_AddToSGroup(sGroupID, 0, 50, true, HintPoint_Remove, 38073, 38073, 38073)
	end
end

function AddHintPointToSquadGroup(eSquadName)
	if (SGroup_FromName(eSquadName)) then
		local sGroupID = SGroup_FromName(eSquadName)
		HintPoint_AddToSGroup(sGroupID, 0, 50, true, HintPoint_Remove, 38073, 38073, 38073)
	end
end

function AddHintPointToMarker(markerName)
	if (Marker_FromName(markerName, "basic_marker")) then
		local markerID = Marker_FromName(markerName, "basic_marker")
		HintPoint_AddToPosition(Marker_GetPosition(markerID), 0, 50, false, HintPoint_Remove, 38073, 38073, 38073)
	end
end

	
function CanSeeEGroup(EGroupName)
	local egroupid = EGroup_FromName(EGroupName)
	local playerid = getlocalplayer()
	Player_CanSeeEGroup(playerid, egroupid, false)
end


------------------------------------------------------------------
-- Memory helper funcs
function MemDumpEnd()
	memstatsstop()	
	print("Stoptime:"..World_GetGameTime() )
	memstatslogtemps()
	memstatsreset()
end

function MemDumpTemp()
	print("Starttime:"..World_GetGameTime() )
	memstatsstart()
	timer_addonce( "MemDumpEnd", 10 )
end

------------------------------------------------------------------
-- Territory render funcs

function ShowTerritoryInfo()
	
	dr_clear( "territory-debug" )
	dr_setautoclear( "territory-debug", false )
	
	local col = {200, 200, 255}
	
	local playerid = getlocalplayer()
	
	local pplayer = Player_FromId( playerid )
	
	local teamid = Player_GetTeam( pplayer )
	
	local area = World_GetTeamsSuppliedTerritoryArea( teamid )
	
	local manpower_rate = Player_GetTerritoryBaseRate( pplayer, area )
	
	local lowerb = Player_GetTerritoryLowerBand( pplayer, area )
	local upperb = Player_GetTerritoryUpperBand( pplayer, area )
	
	local tstr = "TerritoryDebug"
	dr_text2d( "territory-debug", 0.8, 0.35, tstr, col[1], col[2], col[3] )
	tstr = "TeamID: "..teamid.." Area: "..area
	dr_text2d( "territory-debug", 0.81, 0.38, tstr, col[1], col[2], col[3] )
	tstr = "MP-rate/sec: "..manpower_rate
	dr_text2d( "territory-debug", 0.81, 0.41, tstr, col[1], col[2], col[3] )
	tstr = "Bands: "..lowerb.." -> "..upperb
	dr_text2d( "territory-debug", 0.81, 0.44, tstr, col[1], col[2], col[3] )
	
	
end

		
function Territory_Info()

	dr_clear( "territory-debug" )
	if (s_territory_info == nil) then
		timer_del("ShowTerritoryInfo")
		timer_add("ShowTerritoryInfo",0.25)
		s_territory_info = true
	else
		timer_del("ShowTerritoryInfo")
		s_territory_info = nil
	end
end

function showbuildnumber( bShow )

	dr_clear("buildnumber")

	if ( bShow ) then
		local bn_str = "Build: "..getbuildnumber()
		dr_setautoclear( "buildnumber", false )
		dr_text2d( "buildnumber", 0.02, 0.03, bn_str, 255, 255, 255 )
	end
end

if (getbuildtype() ~= "RTM") then
	showbuildnumber(false)
end

