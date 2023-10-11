-- menu system + all bindings
import("dev/autoutil.lua")				--
import("dev/autoentityinfo.lua")		--
import("dev/nisrecorder.lua")			--
import("dev/gen_menu.lua")				-- add cheatmenu bind keys
import("dev/debug_spawn.lua")
import("dev/aidebug.lua")
import("dev/debugscript.lua")

bind("Control+PageUp", "RulesProfiler_ScrollUp(20)")
bind("Control+PageDown", "RulesProfiler_ScrollDown(20)")
bind("CONTROL+SPACE", "RequestSimulationStep()")
------------------------------------------------
-- If an item below has a NO_MP label on it, that
-- means it is not available in MP games. This
-- is here to prevent users from using commands
-- that might alter the simulation which would 
-- cause a sync error
------------------------------------------------
NO_MP = 1

local spawn_offset = 0.0

-- add the game timer - can be toggled with F11
if (getbuildtype() ~= "RTM") then
	AddGameTimer()
end

-- IF YOU EDIT THIS FILE, UPDATE THE WIKI PAGE --

function poolwatch()
	
	if (init_poolwatch == nil) then
		import("dev/poolwatch.lua")
		-- initialize poolwatch system
		init_poolwatch();
	end
	
	-- toggle it (first time turns it on)
	toggle_poolwatch()

end

drawOverlayFlag = 0
function toggle_terrainoverlay( )
	dirt_debugtoggle("nograss")
	if(drawOverlayFlag == 0) then
		dirt_showoverlay(1)
		drawOverlayFlag = 1
	else
		dirt_showoverlay(0)
		drawOverlayFlag = 0
	end
end

function toggle_astarfill( )
	if(pf_getdebug() > 0) then
		pf_debug(0)
	else
		pf_debug(1)
	end
end

function ToggleAnimationProfiler()
	showAnimationProfiler(not isAnimationProfilerEnabled())
end
-- passing in a playerid (1000-1007) return the spot this player occupies in the world's player-list
function find_worldid_from_playerid( player_simid )
	
	local maxplayers = World_GetPlayerCount()
	
	for i=1, maxplayers do 
		local player_ptr = World_GetPlayerAt( i )
		local pid = Player_GetID( player_ptr )
		if (player_simid == pid) then
			return i
		end
	end
	
	return 0
end

function previous_player()

	-- the current player_simid (value between 1000-1007)
	local currentplayer = getlocalplayer()
	
	-- the total number of players in this game
	local maxplayers = World_GetPlayerCount()
	
	-- find the worldid of this player (zero is an error)
	local cur_worldid = find_worldid_from_playerid( currentplayer )
	if (cur_worldid == 0) then
		print("ERROR: previous_player() could not find player")
		return;
	end

	-- get prev player making sure it doesn't drop below 1 (since range is 1->maxplayers)
	local prev_worldid = cur_worldid - 1
	if (prev_worldid < 1) then
		prev_worldid = maxplayers
	end

	local player_ptr = World_GetPlayerAt( prev_worldid )
	local previousplayer = Player_GetID( player_ptr )
	
	local isSinglePlayerGame = not World_IsMultiplayerGame()
	if isSinglePlayerGame then
		-- save state of ai player we're taking over
		Scar_DoString("AISave_SaveAIPlayerForSwitchPlayer("..previousplayer..")")
	end
	
	switchplayer( previousplayer )
	
	if isSinglePlayerGame then
		-- restore ai state of player we switched off of
		Scar_DoString("AISave_DelayedRestoreAIPlayerAfterSwitch("..currentplayer..")")
	end
end

function next_player()
	
	-- the current player_simid (value between 1000-1007)
	local currentplayer = getlocalplayer()
	
	-- the total number of players in this game
	local maxplayers = World_GetPlayerCount()
	
	-- find the worldid of this player (zero is an error)
	local cur_worldid = find_worldid_from_playerid( currentplayer )
	if (cur_worldid == 0) then
		print("ERROR: next_player() could not find player")
		return;
	end
	
	-- determine what the 'next_player' is indexing the world's playerlist (range 1->maxplayers)
	local next_worldid = cur_worldid + 1
	if (next_worldid > maxplayers) then
		next_worldid = 1
	end
	
	local player_ptr = World_GetPlayerAt( next_worldid )
	local nextplayer = Player_GetID( player_ptr )
	
	local isSinglePlayerGame = not World_IsMultiplayerGame()
	if isSinglePlayerGame then
		-- save state of ai player we're taking over
		Scar_DoString("AISave_SaveAIPlayerForSwitchPlayer("..nextplayer..")")
	end
	
	switchplayer( nextplayer )
	
	if isSinglePlayerGame then
		-- restore ai state of player we switched off of
		Scar_DoString("AISave_DelayedRestoreAIPlayerAfterSwitch("..currentplayer..")")
	end
end

pathRendering = 0
function path_togglepathrendering()
	if( pathRendering == 0 ) then
		-- Path_DrawPath()
		-- drawPathCurrent = 1
		animator_boundvolume(1)
		dirt_debugtoggle("nodecals")
		-- statgraph()
		-- statgraph_channel("fps")
		-- statgraph_channel("pathTimeTotal")
		-- statgraph_channel("gameSim")
		-- statgraph_channel("pathMemUsage")
		-- turbo()
	else
		-- Path_DrawPath()
		-- drawPathCurrent = 0
		animator_boundvolume(0)
		dirt_debugtoggle("nodecals")
		-- statgraph_clear()
		-- turbo()
	end

	-- toggle it
	pathRendering = 1 - pathRendering
end

function inc_debug_pass_type()
	Path_IncDebugPassType()
end

turnDebugOutput = 0
function path_toggleturnoutput()
	if( turnDebugOutput == 0 ) then
		turnDebugOutput = 1
		WarningSet("TURN", 1)
	else
		turnDebugOutput = 0
		WarningSet("TURN", 0)
	end
end


function turbo()
	rate = getsimrate()
	
	if not( math.abs(rate - 1000.0) < 1.0 ) then
		rate = 1000.0
	else
		rate = 8.0
	end
	
	setsimrate(rate)
end

function slow()
	rate = getsimrate()
	
	if not( math.abs(rate - 1.0) < 1.0 ) then
		rate = 1.0
	else
		rate = 8.0
	end
	
	setsimrate(rate)
end

------------------------------------------------

simratetable = 
{
	1,2,4,8,16,32,64,256
}

g_simrateLocked = 0

function getsimrateindex( )
	local rate = getsimrate()
	local index = 1
	for k,v in pairs(simratetable) do
		if (math.abs(v - rate) < 0.1) then
			break
		end
		
		index = index + 1
	end
	
	return index
end

function SimRateLockUpdate()

	if (g_simrateLocked == 1) then
		local rate = getsimrate()
		if (rate >= 8) then
			setsimframecap( rate / 8 )
		end
	else
		setsimframecap( 1 )
	end

end

function SimRateToggle( )

	g_simrateLocked = 1 - g_simrateLocked 
	
	SimRateLockUpdate()
	
end

function SimRateSlower()
	
	local index = getsimrateindex()
	
	if (index > 1) then
		index = index - 1
	end

	local newrate = simratetable[ index ]
	setsimrate( newrate )
	
	-- updates the sim frame cap
	SimRateLockUpdate()
end

function SimRateFaster()
	
	local index = getsimrateindex()
	
	if (index < (#simratetable) ) then
		index = index + 1
	end

	local newrate = simratetable[ index ]
	setsimrate( simratetable[ index ] )
	
	-- updates the sim frame cap
	SimRateLockUpdate()
	
end

------------------------------------------------

timerratetable = 
{
	0.1, 0.2, 0.5, 1, 2, 5, 12, 32
}

g_TimerRate = 1

function gettimerrateindex( )
	local rate = g_TimerRate
	local index = 1
	for k,v in pairs(timerratetable) do
		if (math.abs(v - rate) < 0.1) then
			break
		end
		
		index = index + 1
	end
	
	return index
end

function SlowDownTimers()
	
	local index = gettimerrateindex()
	
	if (index > 1) then
		index = index - 1
	end

	local newrate = timerratetable[ index ]
	g_TimerRate = newrate
	Scar_DoString("SetTimerRate([[" .. newrate .. "]])")
end

function SpeedUpTimers()
	
	local index = gettimerrateindex()
	
	if (index < (#timerratetable) ) then
		index = index + 1
	end

	local newrate = timerratetable[ index ]
	g_TimerRate = newrate	
	Scar_DoString("SetTimerRate([[" .. newrate .. "]])")
end


-- loads profile scripts and starts it up
function profile()
	import("dev/profilescript.lua")
	
	-- start it right away
	Profile_ToggleInGame()
	
end

b_updateprecise = 0

updateprecise = function()
	Path_DrawPathMap(1)
end

toggleupdateprecise = function()
	if(b_updateprecise == 0) then
		b_updateprecise = 1
		timer_add("updateprecise", 0.125)
		Path_DrawPathMap(1)
	else
		b_updateprecise = 0
		timer_del("updateprecise")
		Path_DrawPathMap(0)
	end
end

TagDebugEntity = function()
	local entity = Misc_GetMouseOverEntity()
	if(entity ~= nil) then
		Entity_TagDebug(entity)
	else
		Entity_ClearTagDebug()
	end
end

KillMouseOverObject = function()
	if (Is_Mouse_Over_Destructible_Cell ~= nil and Is_Mouse_Over_Destructible_Cell()) then
		Destroy_Mouse_Over_Cell()
	else
		KillMouseOverEntity()
	end
end

KillMouseOverEntity = function()
	if (Misc_IsMouseOverEntity()) then
		local entity = Misc_GetMouseOverEntity()

		if(entity ~= 0) then
			if World_IsCampaignMetamapGame() then
				if Entity_IsOfType(entity, "capture") then
					-- Don't kill capture points on the campaign map as scripts typically assume they are invulnerable
					return
				end
			end
			Entity_Kill(entity)
		end
	end
end		

KillMouseOverSquad = function()
	if (Misc_IsMouseOverEntity()) then
		local entity = Misc_GetMouseOverEntity()
		-- first check to see if entity is part of a squad
		if (Entity_IsPartOfSquad( entity )) then
				local squad = Entity_GetSquad(entity)
				Squad_Kill(squad)
		end
	end
end

KillAllSquadsFromMouseover = function()
	if (Misc_IsMouseOverEntity()) then
		local entity = Misc_GetMouseOverEntity()
		-- first check to see if entity is part of a squad
		if (Entity_IsPartOfSquad( entity ) and World_OwnsEntity(entity) == false) then
			local player = Entity_GetPlayerOwner(entity)
			local sgroup = Player_GetSquads(player)
			local kill = function(gid, idx, squad)
				Squad_Kill(squad)
			end
			SGroup_ForEach(sgroup, kill)
			SGroup_Destroy(sgroup)
		end
	end
end

GiveExperienceToSquad = function()

	if (Misc_IsMouseOverEntity()) then
		local entity = Misc_GetMouseOverEntity()
		-- first check to see if entity is part of a squad
		if (Entity_IsPartOfSquad( entity )) then
				local squad = Entity_GetSquad(entity)
				local oldRank = Squad_GetVeterancyRank(squad)
				--Squad_IncreaseVeterancyExperience(squad)
				Squad_IncreaseVeterancyRank(squad, 1, false )
				--Squad_IncreaseHeroLevel(squad, 1)
				local maxRank = Squad_GetMaxVeterancyRank(squad)
				if (maxRank > 0) then 
					local newRank = Squad_GetVeterancyRank(squad)
					if (newRank ~= oldRank) and (newRank >= maxRank) then
						Player_SetStateModelSquadTarget(Game_GetLocalPlayer(), "officer_recipient", squad)
					end
		end
		end
	end
end

GiveResourcesToSquad = function()
	if (Misc_IsMouseOverEntity()) then
		local entity = Misc_GetMouseOverEntity()
		-- first check to see if entity is part of a squad
		if (Entity_IsPartOfSquad( entity )) then
			local squad = Entity_GetSquad(entity)
			Squad_AddAllResources(squad, 1000)
		end
	end
end

GiveSuppressionToSquad = function()

	if (Misc_IsMouseOverEntity()) then
		local entity = Misc_GetMouseOverEntity()
		-- first check to see if entity is part of a squad
		if (Entity_IsPartOfSquad( entity )) then
				local squad = Entity_GetSquad(entity)
				--Squad_IncreaseVeterancyExperience(squad)
				local suppression = Squad_GetSuppression(squad)
				Squad_SetSuppression(squad, suppression + 0.25)
		end
	end
end	

DecreaseSupply = function()
	if Misc_IsMouseOverEntity() then
		local entity = Misc_GetMouseOverEntity()
		if Entity_IsPartOfSquad(entity) then
			local squad = Entity_GetSquad(entity)
			local turns_since_out_of_supply = Squad_GetStateModelInt(squad, "turns_since_out_of_supply")
			local turns_till_supply_attrition = Squad_GetStateModelInt(squad, "turns_till_supply_attrition")
			
			Squad_SetStateModelInt(squad, "turns_since_out_of_supply", turns_since_out_of_supply + 1)
			Squad_SetStateModelInt(squad, "turns_till_supply_attrition", turns_till_supply_attrition - 1)
		end
	end
end

ToggleSelectedSquadsInvulnerable = function()

	local selectedSquadsGroup = SGroup_Create("SelectedSquadsGroup")
	Misc_GetSelectedSquads(selectedSquadsGroup, false)
	
	local ToggleSquadInvunlerable = function( groupid, itemindex, curSquad )
		if (Squad_GetInvulnerableMinCap(curSquad) > 0) then
			Squad_SetInvulnerableMinCap(curSquad, 0, -1)
		else
			Squad_SetInvulnerableMinCap(curSquad, Squad_GetHealthPercentage(curSquad, false), -1)
		end
	end
	
	SGroup_ForEach(selectedSquadsGroup, ToggleSquadInvunlerable)
	SGroup_Destroy(selectedSquadsGroup)
end
	
MakeSquadInvulnerable = function()

	if (Misc_IsMouseOverEntity()) then
		local entity = Misc_GetMouseOverEntity()
		-- first check to see if entity is part of a squad
		if (Entity_IsPartOfSquad( entity )) then
			local squad = Entity_GetSquad(entity)
			Squad_SetInvulnerableMinCap(squad, Squad_GetHealthPercentage(squad, false), -1)
		end
	end
end

MakeSquadVulnerable = function()

	if (Misc_IsMouseOverEntity()) then
		local entity = Misc_GetMouseOverEntity()
		-- first check to see if entity is part of a squad
		if (Entity_IsPartOfSquad( entity )) then
			local squad = Entity_GetSquad(entity)
			Squad_SetInvulnerableMinCap(squad, 0, -1)
		end
	end
end

ReinforceSelectedSquads = function()
	local sgroup = SGroup_Create("ReinforceSelectedSquadsSGroup")
	Misc_GetSelectedSquads(sgroup, false)
	if SGroup_Count(sgroup) > 0 then
		LocalCommand_Squad(
			Squad_GetPlayerOwner(SGroup_GetSpawnedSquadAt( sgroup, 1 )),
			sgroup,
			SCMD_InstantReinforceUnit,
			false
			)
	end
	SGroup_Destroy(sgroup)
end
	
FaceSelectedSquads = function()
	local sgroup = SGroup_Create("FaceSelectedSquadsGroup")
	Misc_GetSelectedSquads(sgroup, false)
	SGroup_FacePosition(sgroup, Misc_GetMouseOnTerrain())
	SGroup_Destroy(sgroup)
end

function SetRenderObstructions(b)
	Sim_SetRenderObstructions(b)
end

function GetRenderObstructions()
	return Sim_GetRenderObstructions(b)
end

rawset(_G,"GetMouseOverEntityBPName", nil )

function GetMouseOverEntityBPName()
	
	dr_clear("entity-info");
	dr_setautoclear("entity-info",0);
	
	local bpname = "EntityBP:"
	local exts = "Extensions:\n"
	local sqexts = nil
		
	if (Misc_IsMouseOverEntity()) then
		local entity = Misc_GetMouseOverEntity()
		if(entity ~= 0) then
			bpname = bpname..BP_GetName(Entity_GetBlueprint(entity))
			
			local numentityexts = Entity_ExtensionCount()
			for j=0,(numentityexts-1) do
				
				if (Entity_ExtensionEnabled( entity, j )) then
					
					local executing = nil
					if (Entity_ExtensionExecuting( entity, j )) then
						executing = " executing "
					else
						executing = " NOT executing "
					end
					
					exts = exts.." "..j..":"..Entity_ExtensionName( entity, j )..executing.."\n"
				end
			end
			
			if (Entity_IsPartOfSquad(entity)) then
				local squad = Entity_GetSquad( entity )
				sqexts = "SqExtensions:\n"
				local numsquadexts = Squad_ExtensionCount()
				for j=0,(numsquadexts-1) do
					if (Squad_ExtensionEnabled( squad, j )) then
						
						sqexts = sqexts.." "..j..":"..Squad_ExtensionName( squad, j ).."\n"
					end
				end
			end
			
		end
	end
	
	dr_text2d( "entity-info", 0.03, 0.20, bpname, 255, 255, 255 )
	dr_text2d( "entity-info", 0.03, 0.24, exts, 255, 255, 255 )
	
	if (sqexts) then
		dr_text2d( "entity-info", 0.40, 0.20, sqexts, 255, 255, 255 )
	end
end

g_entityInfoToggle = 0

function ToggleEntityInfo()
	
	g_entityInfoToggle = 1-g_entityInfoToggle
	
	-- need to call this so it clears the screen
	dr_clear("entity-info");
	
	timer_del( "GetMouseOverEntityBPName()" );
	if (g_entityInfoToggle==1) then
		timer_add( "GetMouseOverEntityBPName()", 0.25 )
	end
end

-----------------------------------------------------------
function toggle_cool_designer_debug( )
	if g_dev_fowIsRevealed == nil then
		g_dev_fowIsRevealed = false
	end
--~ 	Sim_SquadSuppression()
--~ 	Cursor_WeaponRanges()
--~ 	Cursor_WeaponInfo()
	
	g_dev_fowIsRevealed = not g_dev_fowIsRevealed
	UI_SetUIReveallAll(g_dev_fowIsRevealed)
end

rawset( _G, "CleanUpTheDead", nil )

function CleanUpTheDead()

	local j = World_GetPlayerCount();

	-- get the hq for all players and place them in the commanders table.
	for i = 1, j

	do
		-- this player
		local player = World_GetPlayerAt(i);

		--get all players entities, check for hq
		playerentities = Player_GetEntities( player );

		local CheckForHQ = function( egroupid, itemindex, entityID )
					
								if (Entity_IsAlive( entityID ) == 0 or Entity_GetHealth( entityID ) == 0) then
									Entity_Destroy( entityID )
								end
								
							end

		-- find the hq
		EGroup_ForEach( playerentities, CheckForHQ );

	end

end


-- start the game with fast simrate version on
SimRateToggle()

function GivePlayerAbility(ability)
	if (ability == null) then
		error("cheat menu GivePlayerAbility expected a string")
	else
		abilityBP = BP_GetAbilityBlueprint(ability)
		
		if (abilityBP == null) then
			error("cheat menu GivePlayerAbility could not find requested abilityBP: " + ability)
		else
			if (Player_HasAbility(Game_GetLocalPlayer(), abilityBP)) then
				-- Player already has this ability.
			else
				Player_AddAbility(Game_GetLocalPlayer(), abilityBP)
			end
		end
	end
end

function GivePlayerUpgrade(upgrade)

	if (upgrade == null) then
		error("cheat menu GivePlayerUpgrade expected a string")
	else
		upgradeBP = BP_GetUpgradeBlueprint(upgrade)
		
		if (upgradeBP == null) then
			error("cheat menu GivePlayerUpgrade could not find requested upgradeBP: " + upgrade)
		else
			if (Player_HasUpgrade(Game_GetLocalPlayer(), upgradeBP ) ) then
				-- Player already has this upgrade.
			else
				LocalCommand_PlayerUpgrade(Game_GetLocalPlayer(), upgradeBP, true, false)
			end
		end
	end
end

RagDollMouseOverObject = function()
	if (Misc_IsMouseOverEntity()) then
		local entity = Misc_GetMouseOverEntity()
		if(entity ~= 0) then
			Entity_RagDoll(entity)
		end
	end
end		


ToggleVehiclePhysicsDebugMouseOverObject = function()
	if (Misc_IsMouseOverEntity()) then
		local entity = Misc_GetMouseOverEntity()
		if(entity ~= 0) then
			phy_toggle_vehicle_physics_debug(entity)
		end
	end
end		

------------------------------------------------
--
--
function CreateHierarchicalMenu()
	
	-- Note that "root" references the items of the top-level menu, while "subMenuItems" is a table
	-- mapping the "path" of each submenu to its items.
	return { root = {}, subMenuItems = {} }
	
end

function SplitPath(path)
	
	local i = string.len(path)
	while (i >= 1) do
		if (string.sub(path, i, i) == "\\") then
			return string.sub(path, 1, i - 1), string.sub(path, i + 1)
		end
		
		i = i - 1
	end
	
	return "", path
	
end

function GetHierarchicalSubmenu(hierarchicalMenu, path)

	local menuItems = hierarchicalMenu.root
	local parentMenuItems = hierarchicalMenu.root
	local partialPath = ""
	for folder in string.gmatch(path, "([^\\]+)") do
		partialPath = partialPath .. "\\" .. folder
		
		menuItems = hierarchicalMenu.subMenuItems[partialPath]
		if (menuItems == nil) then
			menuItems = {}
			local subMenu = {
				name = folder,
				type = SubMenu,
				SubMenuItems = menuItems
			}

			table.insert(parentMenuItems, subMenu)
			hierarchicalMenu.subMenuItems[partialPath] = menuItems
		end
		
		parentMenuItems = menuItems
	end
	
	return menuItems	
	
end

function SortHierarchicalMenu(hierarchicalMenu)
	
	local function sortMenuItems(menuItem1, menuItem2)
		if (menuItem1.type == menuItem2.type) then
			return menuItem1.name < menuItem2.name
		end
		
		return menuItem1.type == SubMenu
	end
	
	table.sort(hierarchicalMenu.root, sortMenuItems)

	for _, v in pairs(hierarchicalMenu.subMenuItems) do
		table.sort(v, sortMenuItems)
	end
	
end

function AddHierarchicalMenuItem( menu, path, hotkey, cmdstring, enableInMP )
	
	local folder, itemName = SplitPath(path)
	local subMenu = GetHierarchicalSubmenu(menu, folder)
	
	table.insert(subMenu, newelement( itemName, hotkey, cmdstring, enableInMP ))
	
end

function AddHierarchicalMenuItemBoolean( menu, path, hotkey, getString, setString)
	
	-- adds menus with boolean items instead of simple command items
	local folder, itemName = SplitPath(path)
	local subMenu = GetHierarchicalSubmenu(menu, folder)
	
	table.insert(subMenu, newboolean( itemName, getString, setString))
end

------------------------------------------------
--
--
function GetSpawnSquadMenuTable( filter )

	local squadblueprint_menu = CreateHierarchicalMenu()
	-- find the number of squad blueprint bags
	local count = BP_GetPropertyBagGroupCount( PBG_SquadProperties )
	local id = 0
	
	-- fill out the table with the all squad blueprint bags
	for id = 0, count-1 do
		local name = BP_GetPropertyBagGroupPathName( PBG_SquadProperties, id )
		
		name = string.lower(name)
		
		local a,b = string.find( name, filter )
		
		-- only allow certain types of squads on the list
		if ( b ~= nil ) then
			local newname = string.sub( name, b + 1 )
			AddHierarchicalMenuItem(squadblueprint_menu, newname, "", "SpawnSquadAtMouse(BP_GetSquadBlueprint([["..name.."]]))", NO_MP)
		end
		
	end

	-- sort the table alphabetically
	SortHierarchicalMenu(squadblueprint_menu)
	 
	return squadblueprint_menu.root
	
end

------------------------------------------------
--
--
function GetSpawnEntityMenuTableFiltered( filter )

	local entityblueprint_menu = CreateHierarchicalMenu()
	-- find the number of entity blueprint bags
	local count = BP_GetPropertyBagGroupCount( PBG_EntityProperties )
	local id = 0
	
	-- fill out the table with the all entity blueprint bags
	for id = 0, count-1 do
		local name = BP_GetPropertyBagGroupPathName( PBG_EntityProperties, id )
		
		name = string.lower(name)
		
		local a,b = string.find( name, filter )
		
		-- only allow certain types of entities on the list
		if ( b ~= nil ) then
			local newname = string.sub( name, b + 1 )
			AddHierarchicalMenuItem(entityblueprint_menu, newname, "", "SpawnEntityAtMouse(BP_GetEntityBlueprint([["..name.."]]))", NO_MP );
		end
		
	end

	-- sort the table alphabetically
	SortHierarchicalMenu(entityblueprint_menu)
	 
	return entityblueprint_menu.root
	
end

------------------------------------------------
--
--
function GetEntityCosmeticMenuTableFiltered( filter )

	local entityblueprint_menu = {}
	-- find the number of entity blueprint bags
	local count = BP_GetPropertyBagGroupCount( PBG_EntityProperties )
	local id = 0
	local index = 1
	
	-- fill out the table with the all entity blueprint bags
	for id = 0, count-1 do
		local bpName = BP_GetPropertyBagGroupPathName( PBG_EntityProperties, id )
		
		bpName = string.lower(bpName)
		
		local a,b = string.find( bpName, filter )
		
		-- only show entities that match the filter
		if ( b ~= nil ) then
			local newname = string.sub( bpName, b + 1 )
			
			local cosmetics = GetSpawnEntityCosmeticsTable( bpName )
			if (next(cosmetics) ~= nil) then
				entityblueprint_menu[index] =
				{
					name = newname,
					type = SubMenu,
					SubMenuItems = cosmetics
				}
				index = index + 1
			end
		end
		
	end

	-- sort the table alphabetically
	table.sort(entityblueprint_menu, function(a,b) return a.name<b.name end)
	 
	return entityblueprint_menu
	
end

------------------------------------------------
--
--
function GetSpawnEntityCosmeticsTable( bpName )

	local squadCosmeticsMenu = {}
	-- find the number of squad cosmetics
	local count = Entity_GetCosmeticAttachmentListCount( bpName )
	local id = 0
	local index = 1
	
	-- fill out the table with the all squad cosmetics
	for id = 0, count-1 do
		local cosmeticName = Entity_GetCosmeticAttachmentListAtIndex( bpName, id )
		squadCosmeticsMenu[index] = newboolean( cosmeticName, "GetIsLocalPlayerCosmeticActive([["..cosmeticName.."]])", "ToggleLocalPlayerCosmetic([["..cosmeticName.."]])")
		index = index + 1
	end

	-- sort the table alphabetically
	table.sort(squadCosmeticsMenu, function(a,b) return a.name<b.name end)
	
	return squadCosmeticsMenu
	
end

------------------------------------------------
--
--
function ToggleLocalPlayerCosmetic( cosmeticName )

	local localplayer = Game_GetLocalPlayer()
	Player_ToggleAttachmentListCosmeticRemapping(localplayer, cosmeticName);
	
end

------------------------------------------------
--
--
function GetIsLocalPlayerCosmeticActive( cosmeticName )

	local localplayer = Game_GetLocalPlayer()
	return Player_IsAttachmentListCosmeticActive(localplayer, cosmeticName);
	
end

------------------------------------------------
--
--
function GetCosmeticBundleTable( race, filter )
	
	local armySkinMenu = CreateHierarchicalMenu()
	-- find the number of squad cosmetics
	local count = Entity_GetArmySkinCount( race )
	local id = 0
	local index = 1
	
	-- fill out the table with the all squad cosmetics
	for id = 0, count-1 do
		
		-- cosmeticPathName is filepath of each cosmetic EX.  devils_brigade/infantry/devils_brigade_scout
		-- cosmeticName is the last word in the path / the armyskin name
		-- cosmeticBundleName is the first word in path / the armyskin bundle name
		local cosmeticPathName = Entity_GetArmySkinFilenameAtIndex( race, id )
		local cosmeticName = string.match(cosmeticPathName, "([^\\]+)$")
		local cosmeticBundleName = string.match(cosmeticPathName, "([^\\]+)")
		
		name = string.lower(cosmeticPathName)
		-- skips ArmySkin if default
		if string.find(cosmeticName, "default") then goto continue end
		
		-- Adds & organizes ArmySkin according to filepath
		local firstIndex, lastIndex = string.find( name, filter )

		if ( lastIndex ~= nil ) then
			local filteredPath = string.sub( name, lastIndex + 1 )
			AddHierarchicalMenuItemBoolean(armySkinMenu, filteredPath, "", "GetIsLocalPlayerArmySkinActive([["..cosmeticName.."]])", "SetLocalPlayerArmySkin([["..cosmeticName.."]], %s)")
		end	
		
		::continue::
	end

	-- sort the table alphabetically
	SortHierarchicalMenu(armySkinMenu)
	 
	return armySkinMenu.root
	
end

------------------------------------------------
--
--
function AddCosmeticBundleSelectButton( race , filter )
	
	-- gets each cosmetic bundle and associated skins, and creating a button per bundle to select all skins within bundle.
	local bundleSelectMenu = {}
	local allBundles = {}
	-- find the number of squad cosmetics
	local count = Entity_GetArmySkinCount( race )
	local id = 0
	
	for id = 0, count-1 do
		
		-- cosmeticPathName is filepath of each cosmetic
		local cosmeticPathName = Entity_GetArmySkinFilenameAtIndex( race, id )
		local name = string.lower(cosmeticPathName)
		local firstIndex, lastIndex = string.find( name, filter )
		if ( lastIndex ~= nil ) then
			
			local filteredPath = string.sub( name, lastIndex + 1 )
			-- cosmeticName is the last word in the path / the armyskin name
			-- cosmeticBundleName is the first word in path / the armyskin bundle name
			local cosmeticName = string.match(filteredPath, "([^\\]+)$")
			local cosmeticBundleName = string.match(filteredPath, "([^\\]+)")
		
			-- skips ArmySkin if default
			if not string.find(cosmeticName, "default") then
				
				-- key: bundle name , value: string of skin names together (format of name\name\name)
				if (allBundles[cosmeticBundleName] ~= nil) then
					-- insert straight into bundle names
					allBundles[cosmeticBundleName] = allBundles[cosmeticBundleName].."\\"..cosmeticName
				else
					-- create new bundle names string
					allBundles[cosmeticBundleName] = cosmeticName
				end
			end
		end
	end
	
	local index = 1
	--	for each cosmetic bundle, make button and run through SetLocalPlayerArmySkin
	for bundle, cosmetics in pairs(allBundles) do
		bundleSelectMenu[index] = newboolean( bundle, "GetIsLocalPlayerCosmeticBundleActive([["..cosmetics.."]])", "SetLocalPlayerArmySkinBundle([["..cosmetics.."]], %s)")
		--bundleSelectMenu[index] = newelement( bundle, "", "SetLocalPlayerArmySkinBundle([["..cosmetics.."]], %s)", NO_MP)
		index = index + 1
	end
	
	-- sort the table alphabetically
	table.sort(bundleSelectMenu, function(a,b) return a.name<b.name end)
	
	return bundleSelectMenu
end


function newBundleButton( txt, cmdstring )
	
	-- is enabled if NOT an MP game or if it is, then this is only enabled if the NO_MP flag has not been specified
	
	return {name = txt, type = Command, command = cmdstring}
	
end

------------------------------------------------
--
--
function GetIsLocalPlayerCosmeticBundleActive( cosmeticNames )
-- pass in table of cosmetic names, and check if all are active .
	local localplayer = Game_GetLocalPlayer()
	
	for cosmeticName in string.gmatch(cosmeticNames, "([^\\]+)") do
		if not Player_IsArmySkinActive(localplayer, cosmeticName) then
			return false
		end
	end
	
	return true
	
end

------------------------------------------------
--
--
function SetLocalPlayerArmySkinBundle( cosmeticNames, enabled )
-- pass in table of cosmetic names, and SetLocalPlayerArmySkin for all.
	local localplayer = Game_GetLocalPlayer()
	
	for cosmeticName in string.gmatch(cosmeticNames, "([^\\]+)") do
		Player_SetArmySkinRemapping(localplayer, cosmeticName, enabled);
	end
end 


------------------------------------------------
--
--
function GetIsLocalPlayerArmySkinActive( cosmeticName )

	local localplayer = Game_GetLocalPlayer()
	return Player_IsArmySkinActive(localplayer, cosmeticName);
	
end

------------------------------------------------
--
--
function SetLocalPlayerArmySkin( cosmeticName, enabled )

	local localplayer = Game_GetLocalPlayer()
	Player_SetArmySkinRemapping(localplayer, cosmeticName, enabled);
	
end

------------------------------------------------
--
--
function GetSpawnEntityMenuTable()

	local entityblueprint_menu = {}
	
	-- find the number of squad blueprint bags
	local count = BP_GetPropertyBagGroupCount( PBG_EntityProperties )
	local id = 0
	local offset = (#entityblueprint_menu)
	local index = offset+1
	
	-- fill out the table with the all squad blueprint bags
	for id = 0, count-1 do
		local name = BP_GetPropertyBagGroupPathName( PBG_EntityProperties, id )
		
		name = string.lower(name)
		
		-- only allow certain types of entities on the list
		if ( string.find( name, "ebps\\" ) ~= nil or
			string.find( name, "ebps\\props\\" ) ~= nil or
			string.find( name, "ebps\\races\\civ_prototype\\units\\" ) ~= nil or
			string.find( name, "ebps\\races\\civ_prototype\\buildings\\" ) ~= nil or
			string.find( name, "ebps\\races\\core\\units\\" ) ~= nil or
			string.find( name, "ebps\\races\\core\\buildings\\" ) ~= nil or
			string.find( name, "ebps\\races\\neutral\\buildings\\" ) ~= nil or
			string.find( name, "ebps\\gameplay\\" ) ~= nil ) then
			 
			entityblueprint_menu[index] = newelement( name, "", "SpawnEntityAtMouse(BP_GetEntityBlueprint([["..name.."]]))", NO_MP )
			index = index + 1
			
		end
	end

	-- sort the table alphabetically
	table.sort(entityblueprint_menu, function(a,b) return a.name<b.name end)
	
	return entityblueprint_menu
	
end

------------------------------------------------
--
--
function GetSpawnEntityEnvironmentsMenuTable()

	local entityblueprint_menu = CreateHierarchicalMenu()
	
	-- find the number of squad blueprint bags
	local count = BP_GetPropertyBagGroupCount( PBG_EntityProperties )
	local id = 0
	
	-- fill out the table with the all squad blueprint bags
	for id = 0, count-1 do
		local name = BP_GetPropertyBagGroupPathName( PBG_EntityProperties, id )
		
		name = string.lower(name)
		
		-- only allow certain types of entities on the list
		if ( string.find( name, "ebps\\environment" ) ~= nil or
			string.find( name, "ebps\\environment\\non_tree_resources" ) ~= nil or
			string.find( name, "ebps\\environment\\resources" ) ~= nil or
			string.find( name, "ebps\\environment\\trees" ) ~= nil ) then
			
			local a,b = string.find( name, "ebps\\environment" )
			local newname = string.sub( name, b + 1 )
			AddHierarchicalMenuItem(entityblueprint_menu, newname, "", "SpawnEntityAtMouse(BP_GetEntityBlueprint([["..name.."]]))", NO_MP)
			
		end
	end

	-- sort the table alphabetically
	SortHierarchicalMenu(entityblueprint_menu)
	
	return entityblueprint_menu.root
	
end


------------------------------------------------
--
--
function GetSpawnEBPMenu( filter, filterb )

	local entityblueprint_menu = CreateHierarchicalMenu()

	-- find the number of squad blueprint bags
	local count = BP_GetPropertyBagGroupCount( PBG_EntityProperties )
	local id = 0
	
	-- fill out the table with the all squad blueprint bags
	for id = 0, count-1 do
		local name = BP_GetPropertyBagGroupPathName( PBG_EntityProperties, id )
		
		name = string.lower(name)
		
		local a,b = string.find( name, filter )
		
		if (a==nil and filterb) then
			a,b = string.find( name, filterb )
		end
		
		-- only allow certain types of entities on the list
		if ( b ~= nil ) then
			local newname = string.sub( name, b + 1 )
			AddHierarchicalMenuItem(entityblueprint_menu, newname, "", "SpawnEntityAtMouseAdv(BP_GetEntityBlueprint([["..name.."]]))", NO_MP)
		end
	end

	-- sort the table alphabetically
	SortHierarchicalMenu(entityblueprint_menu)
	
	return entityblueprint_menu.root
	
end

function SpawnEntityAtMouseAdv(bpName)
	local name = bpName
	
	if g_cheatmenu_spawn_with_construction then
		local mousePos = Misc_GetMouseOnTerrain()
		mousePos.y = mousePos.y + spawn_offset
		local ent = nil
		local localplayer = Game_GetLocalPlayer()
		if g_cheatmenu_spawn_as_enemy == true then
			local enemyplayer = Player_FindFirstEnemyPlayer(localplayer)
			if enemyplayer ~= nil then
				ent = Entity_Create(name, enemyplayer, mousePos, false)
			else
				ent = Entity_Create(name, localplayer, mousePos, false)
			end
		elseif g_cheatmenu_spawn_as_neutral then
			ent = Entity_CreateENV(name, mousePos, false)
		else
			ent = Entity_Create(name, localplayer, mousePos, false)
		end
		
		Entity_Spawn(ent)
		Entity_ForceConstruct(ent)
	else
		SpawnEntityAtMouse(name)
	end
end


function DestroyWorldEntities()
	local worldEntities = EGroup_Create("worldEntities")
	local numWorldEntities = World_GetEntitiesNearPoint(World_GetPlayerAt(1), worldEntities, World_Pos(0, 0, 0), math.max(World_GetWidth(), World_GetLength()), OT_Neutral)
	
	print("Found " .. numWorldEntities .. " entities. Destroying...")
	
	local _KillEntity = function (gid, idx, eid)
		Entity_Kill(eid)
	end
	
	EGroup_ForEachEx(worldEntities, _KillEntity, true, true)
	EGroup_Destroy(worldEntities)
end

------------------------------------------------

function gameshowallui()
	game_showcomponentflags()
	game_showvisualflags()
end

function gamehideallui()
	game_hidecomponentflags()
	game_hidevisualflags()
	game_showentitycolors()
end


------------------------------------------------

function game_showchallengeui()
	local debugData = Game_RetrieveTableData("debug", false)
	debugData.showChallengeUI = true
	Game_StoreTableData("debug", debugData)
end

function game_hidechallengeui()
	local debugData = Game_RetrieveTableData("debug", false)
	debugData.showChallengeUI = false
	Game_StoreTableData("debug", debugData)
end

function newboolean( label, getstr, setstr )
	return {
		name = label,
		type = Variable,
		get = getstr,
		set = setstr,
		var_type = Boolean,
	}
end

function newelement( txt, hotkey, cmdstring, enableInMP )
	
	-- is enabled if NOT an MP game or if it is, then this is only enabled if the NO_MP flag has not been specified
	local bEnabled = (not g_isMPGame or enableInMP ~= NO_MP);
	
	local tempcmd = nil
	local fullname = txt
	if (bEnabled) then
		-- is there a hotkey define - if so bind it and append it to the name
		if (hotkey ~= nil and hotkey ~= "") then 
			bind( hotkey, cmdstring )
			fullname = fullname .. "......." .. hotkey
		end
		tempcmd = cmdstring
		
	else
		-- JWANG AUG 2015 DESYNC WORK AROUND:
		-- Cheatmenu.lua gets loaded into the global lua state at mission load
		-- but is never unloaded in any fashion, so not binding NO_MP functions only works
		-- if you never go into a skirmish game, otherwise afterwards you'll be able to use
		-- these cheats again, at least via hotkeys.  For now everytime the lua script is
		-- loaded, just try and unbind any existing function if it isn't enabled
		if (hotkey ~= nil and hotkey ~= "") then 
			unbind( hotkey )
		end
	end
			
	return {name = fullname, type = Command, command = tempcmd}
	
end

function newseperator(title)
	return {name = "----" .. tostring(title or "--------") .. "----",	type = Separator,}
end

function statgraph_item(channel_name, full_name)
	
	local tempname = "Toggle "..channel_name
	if (full_name) then
		tempname = full_name
	end
	
	return {
					name = tempname,
					type = Variable,
					get = "statgraph_channel_get_enabled(\""..channel_name.."\")",
					set = "statgraph_channel_set_enabled(\""..channel_name.."\", %s)",
					var_type = Boolean,
			}
end



function animator_toggle( mode )

	if ( animator_debug() ~= 0 ) then 
		animator_debug_mask(mode) 
	end
	
end


function apply_skin_override( skin )
	local selectedEG = EGroup_Create("SelectedForSkinApplication")
	Misc_GetSelectedEntities(selectedEG, false)
	
	local EGSetSkin = function( groupid, itemindex, curEntity )
		Entity_SetAnimatorActionParameter( curEntity, "skinOverride", skin )
		Entity_SetAnimatorActionParameter( curEntity, "forceTextureLoad", "true" )
		Entity_SetAnimatorAction( curEntity, "ui/apply_custom_skin" )
	end
	
	EGroup_ForEach( selectedEG, EGSetSkin )
	
	EGroup_Destroy(selectedEG )
	
	local selectedSG = SGroup_Create("SelectedForSkinApplication")
	Misc_GetSelectedSquads(selectedSG, false )
	
	local SGSetSkin = function( groupid, itemindex, curSquad )
		for entityIdx = 0, Squad_Count(curSquad)-1 do
			Entity_SetAnimatorActionParameter( Squad_EntityAt( curSquad, entityIdx ), "skinOverride", skin )
			Entity_SetAnimatorActionParameter( Squad_EntityAt( curSquad, entityIdx ), "forceTextureLoad", "true" )
			Entity_SetAnimatorAction( Squad_EntityAt( curSquad, entityIdx ), "ui/apply_custom_skin" )
		end
	end
	
	SGroup_ForEach( selectedSG, SGSetSkin )
	
	SGroup_Destroy( selectedSG )
end

function CheatToggleFOWRender()
	if __b_fowRender == nil or __b_fowRender == false then
		__b_fowRender = true
		FOW_UIRevealAll()
	elseif __b_fowRender == true then
		__b_fowRender = false
		FOW_UIUnRevealAll()
	end
end

function frameDump_Start()
	__frameDump_name = "Default_Frame_Dump"
	
	capturemoviesavedeferredbuffers(true)
	
	app_moviemodeframerate(60)
	
	capturemoviesavedeferredbuffers(true)
	capturemoviestart(0)
	
	print("***NIS FRAME DUMP STARTING, SAVING TO "..__frameDump_name.." ***")
end

function frameDump_Stop()
	capturemoviestop()
	app_moviemodeframerate(60)
	
	print("***ENDING FRAME DUMP AS "..__frameDump_name.." ***")
end

------------------------------------------------
--
--

function enemy_spawn_toggle()
	g_cheatmenu_spawn_as_enemy = (not g_cheatmenu_spawn_as_enemy)
	if g_cheatmenu_spawn_as_enemy == true then
		g_cheatmenu_spawn_as_neutral = false
	end
end

function neutral_spawn_toggle()
	g_cheatmenu_spawn_as_neutral = (not g_cheatmenu_spawn_as_neutral)
	if g_cheatmenu_spawn_as_neutral == true then
		g_cheatmenu_spawn_as_enemy = false
	end
end

function on_hex_spawn_toggle()
	g_cheatmenu_spawn_on_hex = (not g_cheatmenu_spawn_on_hex)
end

function force_construction_toggle()
	g_cheatmenu_spawn_with_construction = (not g_cheatmenu_spawn_with_construction)
end

function aitoggle()
	local pcount = World_GetPlayerCount()
	for pi=1, pcount do
		
		local playerid = World_GetPlayerAt( pi )
		
		if (AI_IsAIPlayer( playerid )==true) then
			AI_Enable( playerid, not AI_IsEnabled(playerid) )
		end
	end	
end

------------------------------------------------
--
--

bind("CONTROL+SHIFT+DELETE", "enemy_spawn_toggle()")
bind("CONTROL+SHIFT+HOME", "neutral_spawn_toggle()")

------------------------------------------------
--
--

function Weapon_Debug()
	Weapon_ScatterInfo()
	Weapon_Info()
	Weapon_Tracking()
	Weapon_AttackRadii()
end

------------------------------------------------
--
--
function GetAllWeaponHitPBGNames()
    local results = {}
    local count = BP_GetPropertyBagGroupCount( PBG_Weapon )
    local id = 0
    for id = 0, count-1 do
        local name = BP_GetPropertyBagGroupPathName( PBG_Weapon, id )
		name = string.lower(name)
		table.insert(results, name)
	end
	
	table.sort(results)
	return results
end

function AddWeaponHitToMenuTree(tree, weaponName, split_name, current_depth, max_depth, hitFxType )
    --leaf node, add an entry
    if current_depth >= max_depth or current_depth >= #split_name then
		--remaining name from left over entry in the split name table
        local remainingName = ""
        for i = current_depth, #split_name do
            remainingName = remainingName .. split_name[i]
            if i < #split_name then
                remainingName = remainingName .. "\\"
            end
        end
        --add single entry to menu
		if hitFxType == "penetrated" then
			table.insert( tree, newelement( remainingName, "", "WeaponHitMousedEntity(BP_GetWeaponBlueprint([["..weaponName.."]]), true)", NO_MP )) -- penetrated
		elseif hitFxType == "deflected" then
			table.insert( tree, newelement( remainingName, "", "WeaponHitMousedEntity(BP_GetWeaponBlueprint([["..weaponName.."]]), false)", NO_MP )) -- deflected				
		end
    else
    	local subMenuIndex = nil
    	
		--find subfolder if it exists
		for index,v in pairs(tree) do
			if v.name == split_name[current_depth] then
				subMenuIndex = index
				break
			end
    	end
	
	    --or create one
	    if subMenuIndex == nil then
	        table.insert(tree, {
							name = split_name[current_depth],
							type = SubMenu,
							SubMenuItems = {},
						})
	        subMenuIndex = #tree
	   end
        
        AddWeaponHitToMenuTree(tree[subMenuIndex].SubMenuItems, weaponName, split_name, current_depth + 1, max_depth, hitFxType)
    end
end

function GetWeaponHitMenuTable(hitFxType, filter, depth )
	
	-- get all weapon bags
	local allWeaponBags = GetAllWeaponHitPBGNames()
	local depth = 4
	
    local weapon_tree = {}
    for _, weaponName in pairs(allWeaponBags) do
        
        local _, filterEndIndex = string.find( weaponName, filter )
		-- only allow certain types of entities on the list
		if ( filterEndIndex ~= nil ) then
		    local nameWithoutFilter = string.sub( weaponName, filterEndIndex + 1 )
            local split_name = {}
            for token in string.gmatch(nameWithoutFilter, "[^\\]+") do
                table.insert(split_name, token)
            end
            
            AddWeaponHitToMenuTree(weapon_tree, weaponName, split_name, 1, depth, hitFxType)
        end
    end
    
    return weapon_tree
end

------------------------------------------------
--
--
cheatmenu_spawnenemyability = false
function GetAbilityMenuTable()
	local ability_menu = {}
	
	local ability_types =
	{
		"dev\\cheatmode\\cheats\\dev_cheat_menu_trigger_stun",
	}   
	
	for i=1, (#ability_types) do
		local name = "abilities\\" .. ability_types[i]
		if i < 10 then
			table.insert(ability_menu, newelement( name, "CONTROL+NUMPAD"..i, "MousedAbility(BP_GetAbilityBlueprint([["..name.."]]), cheatmenu_spawnenemyability)", NO_MP ))
		else
			table.insert(ability_menu, newelement( name, "", "MousedAbility(BP_GetAbilityBlueprint([["..name.."]]), cheatmenu_spawnenemyability)", NO_MP ))
		end
	end
	
	-- sort the table alphabetically
	local function sortabilities(a,b) 
		return a.name<b.name 
	end

--~ 	table.sort(ability_menu, sortabilities)
	
	return ability_menu
end


------------------------------------------------
--
--

function ToggleSettlementDebug()
	if NEUTRALSETTLEMENT_DEBUGUI then
		NEUTRALSETTLEMENT_DEBUGUI = false
	else
		NEUTRALSETTLEMENT_DEBUGUI = true
	end
end

function GetSpawnEBPMenuWithCover( filter, bCoverCheck )

	local entityblueprint_menu = {}

	-- find the number of squad blueprint bags
	local count = BP_GetPropertyBagGroupCount( PBG_EntityProperties )
	local id = 0
	local index = 1
	
	-- fill out the table with the all squad blueprint bags
	for id = 0, count-1 do
		local name = BP_GetPropertyBagGroupPathName( PBG_EntityProperties, id )
		
		name = string.lower(name)
		
		local a,b = string.find( name, filter )
		
		-- only allow certain types of entities on the list
		if ( b ~= nil ) then
			
			local ebp = BP_GetEntityBlueprint( name )
			local hasCover = Entity_IsEBPObjCover( ebp );
			
			if (hasCover == bCoverCheck) then
				local newname = string.sub( name, b + 1 )
				entityblueprint_menu[index] = newelement( newname, "", "SpawnEntityAtMouse(BP_GetEntityBlueprint([["..name.."]]))", NO_MP )
				index = index + 1
			end
			
		end
	end

	-- sort the table alphabetically
	table.sort(entityblueprint_menu, function(a,b) return a.name<b.name end)
	
	return entityblueprint_menu
	
end

------------------------------------------------
--
--
function GetCameraListMenuTable( filter )

	local camerablueprint_menu = {}
	-- find the number of squad blueprint bags
	local count = BP_GetPropertyBagGroupCount( PBG_Camera )
	local id = 0
	local index = 1
	
	-- fill out the table with the all squad blueprint bags
	for id = 0, count-1 do
		local name = BP_GetPropertyBagGroupPathName( PBG_Camera, id )
		
		name = string.lower(name)
		
		local a,b = string.find( name, filter )
		
		-- only allow certain types of entities on the list
		if ( b ~= nil ) then
			local newname = string.sub( name, b + 1 )
			camerablueprint_menu[index] = newelement( newname, "", "Camera_PushKeepState(GetCameraNameFromPBGName([[".. name .. "]]))" );
			index = index + 1
		end
		
	end

	-- sort the table alphabetically
	table.sort(camerablueprint_menu, function(a,b) return a.name<b.name end)
	 
	return camerablueprint_menu
	
end

function TakeSuperScreenShot()

	ToggleScreenshotMode( false )
	Misc_SuperScreenshot()
	ToggleScreenshotMode( true )
	
end

local _isScreenFaded = false
function ToggleBlackScreen(opacity)
	if _isScreenFaded then
		Scar_DoString("UI_ScreenFade(0, 0, 0, 0, 0, true)")
		_isScreenFaded = false
	else
		Scar_DoString("UI_ScreenFade(0, 0, 0, " ..opacity .. ", 0, true)")
		_isScreenFaded = true
	end
end

function AddInfluenceValue5(character_name, influence_value)
	-- If in campaign map
	if World_IsCampaignMetamapGame() then
		local cheat_influence_value = World_GetNarrativeInfluenceValueToUse(character_name) + influence_value
		World_SetNarrativeInfluenceValueToUse(Game_GetLocalPlayer(), character_name, cheat_influence_value)
	else
	-- If in mission
		local campaign = Game_RetrieveTableData("campaign", false)
		if campaign == nil then
			return
		end
		character_name = string.lower(character_name)
		local previous_influence_value = campaign.narrative_influence[character_name]
		campaign.narrative_influence[character_name] = previous_influence_value + influence_value
		Game_StoreTableData("campaign", campaign)
	end
end

function PurchaseNextPossibleNarrativeInfluenceReward(character_name)
	if World_IsCampaignMetamapGame() then
		local local_player = Game_GetLocalPlayer()
		World_PurchaseNextPossibleNarrativeInfluenceReward(local_player, character_name)
	else
		print("Cannot purchase influence reward outside of campaign map")
	end
end

function CreateEncounterSelectionMenu()
	local menu = {}
	local index = 1
	local behaviourType = AI_GetEncounterSelectionBehaviourTypeName(index);
	while behaviourType do
		menu[index] = {
			name = "Include "..behaviourType,
			type = Variable,
			get = "AI_GetEncounterSelectionBehaviourTypeFilter("..index..")",
			set = "AI_ToggleEncounterSelectionBehaviourTypeFilter("..index..")",
			var_type = Boolean,
		}	
		
		index = index + 1;
		behaviourType = AI_GetEncounterSelectionBehaviourTypeName(index);
	end
	
	menu[index] = {
		name = "Toggle Encounter Selection Debug",
		type = Variable,
		get = "AI_GetEncounterSelectionDebug()",
		set = "AI_ToggleEncounterSelectionDebug()",
		var_type = Boolean,
	}
	
	index = index + 1;
	menu[index] = {
			name = "Toggle Military Target Debug",
			type = Variable,
			get = "AI_GetMilitaryTargetDebug()",
			set = "AI_ToggleMilitaryTargetDebug()",
			var_type = Boolean,
	}
	
	index = index + 1;
	menu[index] = {
			name = "Toggle Encounter Scoring Debug",
			type = Variable,
			get = "AI_GetEncounterScoringDebug()",
			set = "AI_ToggleEncounterScoringDebug()",
			var_type = Boolean,
	}
	
	index = index + 1;
	menu[index] = {
			name = "Toggle Detailed Encounter Scoring Debug",
			type = Variable,
			get = "AI_GetEncounterScoringDetailedDebug()",
			set = "AI_ToggleEncounterScoringDetailedDebug()",
			var_type = Boolean,
	}
	
	index = index + 1;
	menu[index] = {
			name = "Toggle AI Prefab Debug",
			type = Variable,
			get = "AI_GetDrawAIPrefab()",
			set = "AI_ToggleDrawAIPrefab()",
			var_type = Boolean,
	}
	
	
	index = index + 1;
	menu[index] = {
			name = "Toggle Squad Assignment Selection",
			type = Variable,
			get = "AI_GetDrawSquadAssignmentSelection()",
			set = "AI_SetDrawSquadAssignmentSelection(%s)",
			var_type = Boolean,
	}
	
	index = index + 1;
	menu[index] = newelement( "Toggle Squad Assignment Selection UP", "", "AI_DecrementSquadAssignmentTrackID()" )
	
	index = index + 1; 													     
	menu[index] = newelement( "Toggle Squad Assignment Selection Down", "", "AI_IncrementSquadAssignmentTrackID()" )
	
		index = index + 1;
	menu[index] = newelement( "Scroll Squad Assignment Selection UP", "", "AI_ScrollSquadAssignmentSelectionUp()" )
	
	index = index + 1; 													     
	menu[index] = newelement( "Scroll Squad Assignment Selection Down", "", "AI_ScrollSquadAssignmentSelectionDown()" )
	
	index = index + 1;
	menu[index] = {
			name = "Toggle Squad Assignment Debug",
			type = Variable,
			get = "AI_GetDrawSquadAssignment()",
			set = "AI_SetDrawSquadAssignment(%s)",
			var_type = Boolean,
	}

	index = index + 1;
	menu[index] = {
			name = "Toggle Verbose Encounter Logging",
			type = Variable,
			get = "AI_GetVerboseEncounterLogging()",
			set = "AI_SetVerboseEncounterLogging(%s)",
			var_type = Boolean,
	}
	
	return menu;
end

function CreateAIMenu( isMPGame )
	local ai_table = 
	{
		newelement( "Toggle AI On/Off", "CONTROL+F3", "aitoggle()" ),
		newelement( "AI Control Local Player", "SHIFT+ALT+P", "Misc_AIControlLocalPlayer()" ),
		bind("ALT+SHIFT+E", "AI_ToggleEncounterSelectionDebug()"),
		bind("ALT+SHIFT+M", "AI_ToggleMilitaryTargetDebug()"),
		bind("ALT+SHIFT+V", "AI_ToggleVisionBoxDebug()"),
		bind("ALT+SHIFT+G", "AI_ToggleDrawProduction()"),
		bind("ALT+SHIFT+T", "AI_ToggleDrawDetailedProductionScoring()"),
		bind("ALT+SHIFT+H", "AI_ToggleDrawAIPrefab()"),
		newseperator(),
		{
			name = "Enable Debugging",
			type = Variable,
			get = "AI_GetAIDebugging()",
			set = "AI_SetAIDebugging(%s)",
			var_type = Boolean,
		},				
		{
			name = "Unit Debug",
			type = Variable,
			get = "AI_GetUnitStatus()",
			set = "AI_SetUnitStatus(%s)",
			var_type = Boolean,
		},
		{
			name = "Encounter Combat Fitness Debug",
			type = Variable,
			get = "AI_GetEncounterDebugCombatFitnessMode()",
			set = "AI_ToggleEncounterDebugCombatFitnessMode()",
			var_type = Boolean,
		},
		{
			name = "Debug Text Options",
			type = SubMenu,
			SubMenuItems =
			{
				{
					name = "Debug Text Above Units",
					type = Variable,
					get = "AI_GetDebugTextAboveUnits()",
					set = "AI_SetDebugTextAboveUnits(%s)",
					var_type = Boolean,
				},
				newelement("AI_DebugText_Scroll_Increment", "CONTROL+SHIFT+ALT+UP",	"AI_DebugTextScroll_Increment()" ),
				newelement("AI_DebugText_Scroll_Decrement ", "CONTROL+SHIFT+ALT+DOWN", "AI_DebugTextScroll_Decrement()" ),		
			}
		},
		{
			name = "Capture Point Debug",
			type = Variable,
			get = "AI_GetCapturePointDebug()",
			set = "AI_SetCapturePointDebug(%s)",
			var_type = Boolean,
		},
		{
			name = "Gather Point Debug",
			type = Variable,
			get = "AI_GetGatherPointDebug()",
			set = "AI_SetGatherPointDebug(%s)",
			var_type = Boolean,
		},
		{
			name = "Military Point Debug",
			type = Variable,
			get = "AI_GetMilitaryPointDebug()",
			set = "AI_SetMilitaryPointDebug(%s)",
			var_type = Boolean,
		},
		{
			name = "Encounter Selection Debug",
			type = SubMenu,
			SubMenuItems = CreateEncounterSelectionMenu()
		},
		{
			name = "Combat Rating Debug",
			type = Variable,
			get = "AI_GetCombatRatingDebug()",
			set = "AI_SetCombatRatingDebug(%s)",
			var_type = Boolean,
		},
		{
			name = "Exclusion Areas Debug",
			type = Variable,
			get = "AI_GetExclusionAreasDebug()",
			set = "AI_SetExclusionAreasDebug(%s)",
			var_type = Boolean,
		},
		{
			name = "AI Squad Data Dictionary Debug",
			type = Variable,
			get = "AI_GetAISquadDataDictionaryDebug()",
			set = "AI_SetAISquadDataDictionaryDebug(%s)",
			var_type = Boolean,
		},
		{
			name = "AI Object Management Debug",
			type = Variable,
			get = "AI_GetDrawAIObjectManagement()",
			set = "AI_SetDrawAIObjectManagement(%s)",
			var_type = Boolean,
		},
		{
			name = "State Model Debug",
			type = SubMenu,
			SubMenuItems =
			{
				{
					name = "AIPlayer State Model",
					type = Variable,
					get = "AI_GetDrawAIPlayerStateModel()",
					set = "AI_SetDrawAIPlayerStateModel(%s)",
					var_type = Boolean,
				},
				{
					name = "CustomContext State Model",
					type = Variable,
					get = "AI_GetDrawCustomContextStateModel()",
					set = "AI_SetDrawCustomContextStateModel(%s)",
					var_type = Boolean,
				},
				{
					name = "AISquad State Model",
					type = Variable,
					get = "AI_GetDrawAISquadStateModel()",
					set = "AI_SetDrawAISquadStateModel(%s)",
					var_type = Boolean,
				},
			}
		},
		{
			name = "State Tree Debug",
			type = SubMenu,
			SubMenuItems =
			{
				{
					name = "AI Strategizer State Tree Debug",
					type = Variable,
					get = "AI_GetDrawAIPlayerStrategizerStateTree()",
					set = "AI_SetDrawAIPlayerStrategizerStateTree(%s)",
					var_type = Boolean,
				},
				{
					name = "AI Strategizer Set Strategy",
					type = SubMenu,
					SubMenuItems = 
					{
						{
							name = "Offensive",
							type = Variable,
							get = "AI_GetStrategy(1)",
							set = "AI_SetStrategy(1)",
							var_type = Boolean,
						},
						{
							name = "Economic",
							type = Variable,
							get = "AI_GetStrategy(2)",
							set = "AI_SetStrategy(2)",
							var_type = Boolean,
						},
					}
				},
				{
					name = "AI Planner State Tree Debug",
					type = Variable,
					get = "AI_GetDrawAIPlayerPlannerStateTree()",
					set = "AI_SetDrawAIPlayerPlannerStateTree(%s)",
					var_type = Boolean,
				},
				{
					name = "Production State Tree",
					type = SubMenu,
					SubMenuItems = 
					{
						{
							name = "Production State Tree Debug",
							type = Variable,
							get = "AI_GetProductionStateTreeDebug()",
							set = "AI_SetProductionStateTreeDebug(%s)",
							var_type = Boolean,
						},
						{
							name = "Toggle Prune Tree for Selected",
							type = Variable,
							get = "AI_GetPruneProductionStateTreeForSelected()",
							set = "AI_SetPruneProductionStateTreeForSelected(%s)",
							var_type = Boolean,
						},
					}
				}
			}
		},
		{
			name = "HomeBase Debug",
			type = Variable,
			get = "AI_GetDrawHomeBase()",
			set = "AI_SetDrawHomeBase(%s)",
			var_type = Boolean,
		},
		{
			name = "Scouting Debug",
			type = Variable,
			get = "AI_GetDrawScouting()",
			set = "AI_SetDrawScouting(%s)",
			var_type = Boolean,
		},	
		{
			name = "Tasks",
			type = SubMenu,
			SubMenuItems = 
			{
				{
					name = "Debug All Task Children",
					type = Variable,
					get = "AI_DebugRenderAllTaskChildrenIsEnabled()",
					set = "AI_DebugRenderAllTaskChildrenEnable(%s)",
					var_type = Boolean,
				},
				{
					name = "Attack Encounter Position Scoring Debug",
					type = Variable,
					get = "AI_DebugAttackEncounterPositionScoringIsEnabled()",
					set = "AI_DebugAttackEncounterPositionScoringEnable(%s)",
					var_type = Boolean,
				},
			}
		},				
		{
			name = "Skirmish",
			type = SubMenu,
			SubMenuItems = 
			{
				{
					name = "Forward Deploy Debug",
					type = Variable,
					get = "AI_DebugSkirmishForwardDeployIsEnabled()",
					set = "AI_DebugSkirmishForwardDeployEnable(%s)",
					var_type = Boolean,
				}						
			}
		},
		{
			name = "Island Map",
			type = SubMenu,
			SubMenuItems = 
			{
				{
					name = "Island Info",
					type = Variable,
					get = "AI_GetDrawAIIslandInfo()",
					set = "AI_SetDrawAIIslandInfo(%s)",
					var_type = Boolean,
				},
				{
					name = "Island Overlay",
					type = Variable,
					get = "AI_GetDrawAIIslandOverlay()",
					set = "AI_SetDrawAIIslandOverlay(%s)",
					var_type = Boolean,
				},
				{
					name = "Island Minimap",
					type = Variable,
					get = "AI_GetDrawAIIslandMinimap()",
					set = "AI_SetDrawAIIslandMinimap(%s)",
					var_type = Boolean,
				},
				{
					name = "Island Indices",
					type = Variable,
					get = "AI_GetDrawAIIslandIndices()",
					set = "AI_SetDrawAIIslandIndices(%s)",
					var_type = Boolean,
				},
				{
					name = "Island Body Indices",
					type = Variable,
					get = "AI_GetDrawAIIslandBodyIndices()",
					set = "AI_SetDrawAIIslandBodyIndices(%s)",
					var_type = Boolean,
				},
				{
					name = "Island Impass Indices",
					type = Variable,
					get = "AI_GetDrawAIIslandImpassIndices()",
					set = "AI_SetDrawAIIslandImpassIndices(%s)",
					var_type = Boolean,
				},
				{
					name = "Island Coastal Indices",
					type = Variable,
					get = "AI_GetDrawAIIslandCoastalIndices()",
					set = "AI_SetDrawAIIslandCoastalIndices(%s)",
					var_type = Boolean,
				},
				{
					name = "Island Body Perimeter",
					type = Variable,
					get = "AI_GetDrawAIIslandBodyPerimeter()",
					set = "AI_SetDrawAIIslandBodyPerimeter(%s)",
					var_type = Boolean,
				},
				{
					name = "Island Closest Water Indices",
					type = Variable,
					get = "AI_GetDrawAIIslandClosestWaterIndices()",
					set = "AI_SetDrawAIIslandClosestWaterIndices(%s)",
					var_type = Boolean,
				},
				{
					name = "Island Probe Disagreements",
					type = Variable,
					get = "AI_GetDrawAIIslandProbeDisagreement()",
					set = "AI_SetDrawAIIslandProbeDisagreement(%s)",
					var_type = Boolean,
				},
			}
		},
		{
			name = "Constraints",
			type = SubMenu,
			SubMenuItems = 
			{
				{
					name = "Can gather here debug",
					type = Variable,
					get = "AI_GetDrawConstraintCanGather()",
					set = "AI_SetDrawConstraintCanGather(%s)",
					var_type = Boolean,
				},
				{
					name = "Can squad gather debug",
					type = Variable,
					get = "AI_GetDrawConstraintSquadGather()",
					set = "AI_SetDrawConstraintSquadGather(%s)",
					var_type = Boolean,
				},
				{
					name = "Can build here debug",
					type = Variable,
					get = "AI_GetDrawConstraintCanBuild()",
					set = "AI_SetDrawConstraintCanBuild(%s)",
					var_type = Boolean,
				},
				{
					name = "Can squad build debug",
					type = Variable,
					get = "AI_GetDrawConstraintSquadBuild()",
					set = "AI_SetDrawConstraintSquadBuild(%s)",
					var_type = Boolean,
				}		
			}
		},
		{
			name = "Threat Map",
			type = SubMenu,
			SubMenuItems = 
			{
				{
					name = "Threat Map History Debug",
					type = Variable,
					get = "AI_GetRenderThreatHistory()",
					set = "AI_SetRenderThreatHistory(%s)",
					var_type = Boolean,
				},
				{
					name = "Threat Overlay",
					type = Variable,
					get = "AI_GetThreatMap()",
					set = "AI_SetThreatMap(%s)",
					var_type = Boolean,
				},
				{
					name = "Avoidance Overlay",
					type = Variable,
					get = "AI_GetAvoidanceMap()",
					set = "AI_SetAvoidanceMap(%s)",
					var_type = Boolean,
				},
				{
					name = "Total Ally Traffic Overlay",
					type = Variable,
					get = "AI_GetTotalAllyTrafficMap()",
					set = "AI_SetTotalAllyTrafficMap(%s)",
					var_type = Boolean,
				},
				{
					name = "Total Enemy Traffic Overlay",
					type = Variable,
					get = "AI_GetTotalEnemyTrafficMap()",
					set = "AI_SetTotalEnemyTrafficMap(%s)",
					var_type = Boolean,
				},
				{
					name = "Total Combined Traffic Overlay",
					type = Variable,
					get = "AI_GetTotalCombinedTrafficMap()",
					set = "AI_SetTotalCombinedTrafficMap(%s)",
					var_type = Boolean,
				},
				{
					name = "Total Decayed Combined Traffic Overlay",
					type = Variable,
					get = "AI_GetTotalDecayedCombinedTrafficMap()",
					set = "AI_SetTotalDecayedCombinedTrafficMap(%s)",
					var_type = Boolean,
				},
				{
					name = "Clusters",
					type = Variable,
					get = "AI_GetAIThreatMapClusters()",
					set = "AI_SetAIThreatMapClusters(%s)",
					var_type = Boolean,
				},
			}
		},
		{
			name = "Tactics Debug",
			type = Variable,
			get = "AI_GetTacticRenderFlag()",
			set = "AI_SetTacticRenderFlag(%s)",
			var_type = Boolean,
		},				
		{
			name = "Rating Debug",
			type = Variable,
			get = "AI_DebugRatingIsEnabled()",
			set = "AI_DebugRatingEnable(%s)",
			var_type = Boolean,
		},
		{
			name = "Threat Clumps Debug",
			type = SubMenu,
			SubMenuItems = 
			{
				{
					name = "Enemy Clumps",
					type = Variable,
					get = "AI_GetRenderEnemyClumps()",
					set = "AI_SetRenderEnemyClumps(%s)",
					var_type = Boolean,
				},
				{
					name = "Ally Clumps",
					type = Variable,
					get = "AI_GetRenderAllyClumps()",
					set = "AI_SetRenderAllyClumps(%s)",
					var_type = Boolean,
				}
			}				
		},
		{
			name = "Obstruction Map Debug",
			type = Variable,
			get = "AI_GetRenderObstructions()",
			set = "AI_SetRenderObstructions(%s)",
			var_type = Boolean,
		},
		{
			name = "Lua Debug",
			type = Variable,
			get = "AI_DebugLuaIsEnabled()",
			set = "AI_DebugLuaEnable(%s)",
			var_type = Boolean,
		},
		{
			name = "Lua Rules Profiler",
			type = Variable,
			get = "RulesProfiler_IsActive()",
			set = "RulesProfiler_Activate(%s)",
			var_type = Boolean,
		},
		{
			name = "Gathering Manager Debug",
			type = SubMenu,
			SubMenuItems = 
			{
				{
					name = "Draw GatheringManager",
					type = Variable,
					get = "AI_GetDrawGatheringManager()",
					set = "AI_SetDrawGatheringManager(%s)",
					var_type = Boolean,
				},
				{
					name = "Draw deposit text",
					type = Variable,
					get = "AI_GetDrawGatheringDepositText()",
					set = "AI_SetDrawGatheringDepositText(%s)",
					var_type = Boolean,
				},				
				{
					name = "Draw safe gathering tests",
					type = Variable,
					get = "AI_GetDrawSafeGatheringTests()",
					set = "AI_SetDrawSafeGatheringTests(%s)",
					var_type = Boolean,
				},				
			}
		},
		{
			name = "Production Debug",
			type = SubMenu,
			SubMenuItems = 
			{
				{
					name = "Draw Production",
					type = Variable,
					get = "AI_GetDrawProduction()",
					set = "AI_SetDrawProduction(%s)",
					var_type = Boolean,
				},
				{
					name = "Draw Detailed Score Debug",
					type = Variable,
					get = "AI_GetDrawDetailedProductionScoring()",
					set = "AI_SetDrawDetailedProductionScoring(%s)",
					var_type = Boolean,
				},
				{
					name = "Draw Production Combat Fitness",
					type = Variable,
					get = "AI_GetDrawCombatFitness()",
					set = "AI_SetDrawCombatFitness(%s)",
					var_type = Boolean,
				},
				{
					name = "Draw Production Counter Scores",
					type = Variable,
					get = "AI_GetDrawCounterScores()",
					set = "AI_SetDrawCounterScores(%s)",
					var_type = Boolean,
				},
				{
					name = "Draw Requested Production",
					type = Variable,
					get = "AI_GetDrawRequestedProduction()",
					set = "AI_SetDrawRequestedProduction(%s)",
					var_type = Boolean,
				},
			}				
		},
		{
			name = "Structure Placement Debug",
			type = SubMenu,
			SubMenuItems = 
			{
				{
					name = "Draw StructurePlacementCache",
					type = Variable,
					get = "AI_GetDrawStructurePlacementCache()",
					set = "AI_SetDrawStructurePlacementCache(%s)",
					var_type = Boolean,
				},
				{
					name = "Draw AIStructurePlacementQuery",
					type = Variable,
					get = "AI_GetDrawAIStructurePlacementQuery()",
					set = "AI_SetDrawAIStructurePlacementQuery(%s)",
					var_type = Boolean,
				},
				{
					name = "Draw CheckCanBuildInRadius",
					type = Variable,
					get = "AI_GetDrawCheckCanBuildInRadius()",
					set = "AI_SetDrawCheckCanBuildInRadius(%s)",
					var_type = Boolean,
				},
				{
					name = "SPQ Force Refresh",
					type = Variable,
					get = "AI_GetStructurePlacementQueryForceRefresh()",
					set = "AI_SetStructurePlacementQueryForceRefresh(%s)",
					var_type = Boolean,
				},
				{
					name = "SPQ Use Immediate Overlay",
					type = Variable,
					get = "AI_GetStructurePlacementUseImmediateOverlay()",
					set = "AI_SetStructurePlacementUseImmediateOverlay(%s)",
					var_type = Boolean,
				},
				newelement( "Toggle Structure Placement PBG Up", "CONTROL+SHIFT+ALT+O", "AI_ToggleStructurePlacementPBGUp()" ),
				newelement( "Toggle Structure Placement PBG Down", "CONTROL+SHIFT+ALT+L", "AI_ToggleStructurePlacementPBGDown()" ),
			}				
		},
		newelement( "Toggle Debug AI Player", "CONTROL+ALT+P", "AI_ToggleDebugAIPlayer()" ),
		{
			name = "Territory Maps",
			type = SubMenu,
			SubMenuItems = 
			{
				{
					name = "Draw Enemy Territory",
					type = Variable,
					get = "AI_GetDrawEnemyTerritory()",
					set = "AI_SetDrawEnemyTerritory(%s)",
					var_type = Boolean,
				},
				{
					name = "Draw Friendly Territory",
					type = Variable,
					get = "AI_GetDrawFriendlyTerritory()",
					set = "AI_SetDrawFriendlyTerritory(%s)",
					var_type = Boolean,
				}
			}
		},
		{
			name = "Draw Strategic Intention",
			type = Variable,
			get = "AI_GetDrawStrategicIntention()",
			set = "AI_SetDrawStrategicIntention(%s)",
			var_type = Boolean,
		},
		{
			name = "Draw Strategic Island Decisions",
			type = Variable,
			get = "AI_GetDrawStrategicIslandDecisions()",
			set = "AI_SetDrawStrategicIslandDecisions(%s)",
			var_type = Boolean,
		},
		{
			name = "Draw Resource Importance Map",
			type = Variable,
			get = "AI_GetDrawResourceImportanceMap()",
			set = "AI_SetDrawResourceImportanceMap(%s)",
			var_type = Boolean,
		},
		{
			name = "Draw Military Area Scores",
			type = Variable,
			get = "AI_GetDrawMilitaryAreaScores()",
			set = "AI_SetDrawMilitaryAreaScores(%s)",
			var_type = Boolean,
		},
		{
			name = "Draw Trade Routes",
			type = Variable,
			get = "AI_GetDrawTradeRoutes()",
			set = "AI_SetDrawTradeRoutes(%s)",
			var_type = Boolean,
		},
		{
			name = "Draw Scripted Stats Target",
			type = Variable,
			get = "AI_GetDrawScriptedStatsTarget()",
			set = "AI_SetDrawScriptedStatsTarget(%s)",
			var_type = Boolean,
		},
		{
			name = "Update Manager",
			type = SubMenu,
			SubMenuItems = 
			{
				{
					name = "Show Info",
					type = Variable,
					get = "AI_GetDrawAIUpdateManager()",
					set = "AI_SetDrawAIUpdateManager(%s)",
					var_type = Boolean,
				},
				{
					name = "Enable Schedules",
					type = Variable,
					get = "AI_GetEnableAIUpdateManager()",
					set = "AI_SetEnableAIUpdateManager(%s)",
					var_type = Boolean,
				},
				{
					name = "Enable Dynamic Updates",
					type = Variable,
					get = "AI_GetEnableDynamicUpdate()",
					set = "AI_SetEnableDynamicUpdate(%s)",
					var_type = Boolean,
				},
				{
					name = "Forced Schedule",
					type = SubMenu,
					SubMenuItems = 
					{
						newelement( "Reset Index", "", "AI_ResetForcedScheduleIndex" ),
						newelement( "Toggle Index Up", "", "AI_ToggleForcedScheduleIndexUp" ),
						newelement( "Toggle Index Down", "", "AI_ToggleForcedScheduleIndexDown" )
					}
				}
			}
		},
		{
			name = "Draw Scored Positions Debug",
			type = Variable,
			get = "AI_GetDrawScoredPositionsDebug()",
			set = "AI_SetDrawScoredPositionsDebug(%s)",
			var_type = Boolean,
		},
	}
	
	local ai_index = (#ai_table) + 1
	
	local pcount = World_GetPlayerCount()
	
	if (isMPGame) then
		return ai_table
	end
	
	ai_table[ai_index] = newseperator()
	ai_index = ai_index + 1

	for pi=1, pcount do
		
		local playerid = World_GetPlayerAt( pi )
		
		if (AI_IsAIPlayer( playerid )==true) then
			ai_table[ai_index] = CreateAIPlayerSubMenu( pi )
			ai_index = ai_index + 1
		end
	end

	return ai_table
end

function CreateAIPlayerSubMenu( playerId )

	return 
	{	
		name = "AI"..Player_GetID(World_GetPlayerAt(playerId)).." T:"..Player_GetTeam(World_GetPlayerAt(playerId)).." LOD:"..AI_GetDifficulty(World_GetPlayerAt(playerId)),
		type = SubMenu,
		
		SubMenuItems = 
			{
				{
				name = "Enable AI",
				type = Variable,
				get = "AI_IsEnabled(World_GetPlayerAt("..playerId.."))",
				set = "AI_Enable(World_GetPlayerAt("..playerId.."), %s)",
				var_type = Boolean,
				},
				{
				name = "Debug Toggle",
				type = Variable,
				get = "AI_IsDebugDisplay(World_GetPlayerAt("..playerId.."))",
				set = "AI_SetDebugDisplay(World_GetPlayerAt("..playerId.."), %s)",
				var_type = Boolean,
				},
				{
				name = "Lua AI Summary Toggle",
				type = Variable,
				get = [[AIGetFlag("s_printsummary")]],
				set = "AISetFlag(World_GetPlayerAt("..playerId..[[), "s_printsummary", %s)]],
				var_type = Boolean,
				},				
				newelement( "Restore Default Personality Settings", "", "AI_RestoreDefaultPersonalitySettings(World_GetPlayerAt("..playerId.."))" ),				
			},
	}

end


function MissionCheat_ClearMenuItems()

	SubMenuItems.MissionCheats.SubMenuItems = {
		Events = {
			name = "Events",
			type = SubMenu,
			SubMenuItems =
			{
			
			},
		},
	}

end
function MissionCheat_RegisterMenuItem(title, mode, value)

	table.insert(SubMenuItems.MissionCheats.SubMenuItems, newelement(title, "", "MissionCheat_ActivateMenuItem([[" .. mode .. "]], [[" .. value .. "]])"))
	CheatMenu_ReloadFromContext()

end
function MissionCheat_RegisterMenuItem_Event(title, mode, value)

	table.insert(SubMenuItems.MissionCheats.SubMenuItems.Events.SubMenuItems, newelement(title, "", "MissionCheat_ActivateMenuItem([[" .. mode .. "]], [[" .. value .. "]])"))
	CheatMenu_ReloadFromContext()

end
function MissionCheat_ActivateMenuItem(mode, value)

	Scar_DoString("CheatMenu_ActivateMenuItem([[" .. mode .. "]], [[" .. value .. "]])")
	
end


function GetOfficerListTable()
	local officers = World_GetAvailableOfficerList()
	local sub_menu = {}
	for _, officer in pairs(officers) do
		table.insert(sub_menu, newelement(officer.name, "", "AddOfficerToSquad("..officer.id..")", NO_MP))
	end
	return sub_menu
end

function AddOfficerToSquad(officer_id)
	if Misc_IsMouseOverEntity() then
		local entity = Misc_GetMouseOverEntity()
		if Entity_IsPartOfSquad(entity) then
			local squad = Entity_GetSquad(entity)
			Squad_AddOfficer(squad, officer_id)
		end
	end
end


function TriggerDesync()
	Game_UnLockRandom()
	World_GetRand(0,1)
end
local all_interactive_stages_visibility = false
function Cheat_ToggleAllInteractiveStagesVisibility()
	
	all_interactive_stages_visibility = not all_interactive_stages_visibility
	
	World_SetAllInteractiveStagesVisibility(all_interactive_stages_visibility)
	
end

------------------------------------------------
--
--

-- show/hide the watcher.  automatically adds the showall filter for you.
toggle_scar_watcher = "LCWatcher_SelectState('SCAR'); LCWatcher_AddFilter('SCAR',''); LCWatcher_Activate(not LCWatcher_IsActive());";
-- use this to quickly add/remove the showall filter
toggle_all_vars = "if LCWatcher_FilterExists('SCAR', '') then LCWatcher_RemoveFilter('SCAR','') else LCWatcher_AddFilter('SCAR','') end";

-- cache value: is this an MP game
g_isMPGame = false
if not issinglehumangame() then
    g_isMPGame = true
end

 if (g_isMPGame) then
	print( "This is an MP game" )
else
	print( "This is not an MP game" )
end


------------------------------------------------
--
--


------------------------------------------------
--
--

function GetBasicSubMenu()
	return
		{
			newelement( "Toggle Mod Debug Test (SLOW)", "", "Debug_ToggleDebugTest()" ),
			newelement( "Toggle Control All", "CONTROL+F2", "Debug_ToggleControlAll()" ),
			newelement( "Next Player", "CONTROL+RBRACKET", "next_player(); CheatMenu_ReloadFromFile()", NO_MP ),
			newelement( "Previous Player", "CONTROL+LBRACKET", "previous_player(); CheatMenu_ReloadFromFile()", NO_MP ),
			newelement( "Terrain Overlay", "CONTROL+F5", "toggle_terrainoverlay()" ),
			newelement( "Tag Debug Entity", "INSERT", "TagDebugEntity()"),
			newelement( "Cycle the existing list for tagged entity", "CONTROL+INSERT", "Entity_CycleDebug()"),
			newelement( "Build a new list of entities from the tagged entities attachment for cycling with CONTROL+INSERT", "SHIFT+INSERT", "Entity_BuildCycleList()"),
			newelement( "Teleport selected squads to cursor", "CONTROL+Z", "TeleportSelected(false)", NO_MP),
			newelement( "Teleport tagged debug entity to cursor", "CONTROL+X", "TeleportTagged()", NO_MP),
			newseperator(),
			newelement( "Take Super Screenshot", "CONTROL+SHIFT+INSERT", "TakeSuperScreenShot()", NO_MP ),
			newelement( "Toggle Black Screen", "ALT+SHIFT+F", "ToggleBlackScreen(1)"),
			newelement( "Toggle Darkened Screen", "ALT+SHIFT+D", "ToggleBlackScreen(0.8)"),
			{
				name = "Toggle Designer Splats",
				type = Variable,
				get = "Misc_GetDesignerSplatsVisibility()",
				set = "Misc_SetDesignerSplatsVisibility(%s)",
				var_type = Boolean,
			},
			newseperator(),
			newelement( "QUIT", "ALT+F4", "quit()" ),
			newelement( "Quit", "", "quit()" ),
			newelement( "Toggle Debug background Opacity", "CONTROL+O", "ToggleDebugBackgroundOpacity()" ),
			newelement( "Reduce Debug Text Font Scale", "SHIFT+ALT+MINUS", "ReduceDebugFontScale()" ),
			newelement( "Increase Debug Text Font Scale", "SHIFT+ALT+EQUAL", "IncreaseDebugFontScale()" ),
			newelement( "Show Hotkey Window", "CONTROL+ALT+H", "ToggleHotkeyWindow()" ),
		}
end

function GetDamageSubMenu()
	return
		{
			{
				name = "Weapon Hit FX",
				type = SubMenu,
				SubMenuItems = 
				{
					newboolean( "Do Entity Damage On Weapon Hit", "g_DoDamageOnWeaponHit", "g_DoDamageOnWeaponHit=%s" ),
					newboolean( "Apply Simulation Actions On Weapon Hit", "g_applySimPenetrateOrDeflectActionsOnWeaponHit", "g_applySimPenetrateOrDeflectActionsOnWeaponHit=%s" ),
					newboolean( "Use Horizontal Hit Direction", "g_useHorizontalDirectionOnWeaponHit", "g_useHorizontalDirectionOnWeaponHit=%s" ),
					newseperator(),
					{
						name = "Deflect FX",
						type = SubMenu,
						SubMenuItems = GetWeaponHitMenuTable("deflected", "weapon\\")
					},
					{
						name = "Penetrate FX",
						type = SubMenu,
						SubMenuItems = GetWeaponHitMenuTable("penetrated", "weapon\\")
					},
				},
			},

			newseperator(),
			newelement( "Kill tagged entity", "ALT+U",	"Entity_TaggedEntityKill()", NO_MP),
			newelement( "Kill mouse over entity", "CONTROL+D",	"KillMouseOverObject()", NO_MP),
			newelement( "Kill mouse over squad", "CONTROL+SHIFT+K", "KillMouseOverSquad()", NO_MP),
			newelement( "Kill all squads from mouse-over player", "CONTROL+ALT+SHIFT+K", "KillAllSquadsFromMouseover()", NO_MP),
			newseperator(),
			newelement( "Damage mouse over entity", "CONTROL+K", "ApplyHealthPercentMousedEntity(-10)", NO_MP),
			newelement( "Heal mouse over entity", "ALT+K", "ApplyHealthPercentMousedEntity(10)", NO_MP),
			-- note: this will crash if there's no mouse over entity
			newelement( "Burn mouse over entity", "", "BurnMouseOverEntity()", NO_MP ),
			newseperator(),
			newelement("Toggle DOT Render",			"",					"Sim_ToggleDrawDOTs()" ),
			newelement("Toggle Area of Effect Drawing", "",				"Sim_ToggleDrawAOE()"),
		}
end

function GetSimSubMenu()
	return
		{
			{
				name = "Speed",
				type = SubMenu,
				SubMenuItems = 
				{
					newelement("turbo", 			"CONTROL+T", 	"turbo()", NO_MP),
					newelement("slow", 				"CONTROL+S", 	"slow()", NO_MP),
					newelement("Slow Down Sim", 	"CONTROL+SHIFT+Z", "SimRateSlower()", NO_MP),
					newelement("Speed Up Sim", 		"CONTROL+SHIFT+X", "SimRateFaster()", NO_MP),
					newelement("SuperSpeed Mode", 	"", "SimRateToggle()", NO_MP),
					newelement("Slow Down Timers", 	"", "SlowDownTimers()", NO_MP),
					newelement("Speed Up Timers", 	"", "SpeedUpTimers()", NO_MP),
				}
			},
			{
				name = "Cheat",
				type = SubMenu,
				SubMenuItems = 
				{
					newelement("cheat all resources", 			"CONTROL+F1", 		"cheat_resources(1000)", NO_MP),
					newelement("cheat all resources (Focus Player)", "", 			"cheat_resourcesFocusPlayer(1000)", NO_MP),
					newelement("cheat all resources for moused-over squad", "CONTROL+SHIFT+S", "GiveResourcesToSquad()", NO_MP),
					newelement("cheat skip costs", 				"CONTROL+L", 		"cheat_ignorecosts()", NO_MP),
					newelement("cheat commandpoint resources", 	"CONTROL+ALT+X", 	"cheat_resource(RT_Command, 1)", NO_MP),
					newelement("cheat Local Player PopCap", 	"CONTROL+P", 				"Player_SetPopCapOverride(Game_GetLocalPlayer(), 9999)", NO_MP ),
					newelement("cheat buildtime",				"CONTROL+SHIFT+F1", "cheat_buildtime()", NO_MP ),
					newelement("Kill Self", 					"", 				"cheat_killself()"),
					newelement("Trigger Desync", 					"", 				"TriggerDesync()"),
				}
			},
			{
				name = "FOW",
				type = SubMenu,
				SubMenuItems = 
				{
					newelement("Fow Sight Info",				"",					"toggle_fow_info()", NO_MP ),
					newelement("Reveal All for all players",	"CONTROL+SHIFT+D", 				"CheatToggleFOWRender()", NO_MP),
					newelement("Reveal All for local player",	"", 				"FOW_PlayerRevealAll(Player_FromId(getlocalplayer()))", NO_MP),
					newelement("UI Reveal All",					"", 				"UI_SetUIReveallAll(true)", NO_MP),
					newelement("UI Unreveal All",				"",					"UI_SetUIReveallAll(false)", NO_MP),
					newseperator(),
					newelement("Fow Blockers",					"",					"FOW_Blockers()", NO_MP),
				}
			},
			{
				name = "OBBs",
				type = SubMenu,
				SubMenuItems = 
				{
					newelement("Sim_SimBox",				"CONTROL+SHIFT+B", 	"Sim_SimBox()" ),
					newelement("Sim_EntityOBB",				"CONTROL+SHIFT+O",	"Sim_EntityOBB()" ),
					newelement("Sim_EntityCrusherOBB",		"CONTROL+ALT+C",	"Sim_DrawEntityCrusherOBB()" ),
					newelement("Sim_ShotBlockers",			"CONTROL+ALT+B",	"Sim_ShotBlockers()" ),
				}
			},
			{
				name = "Squad",
				type = SubMenu,
				SubMenuItems = 
				{
					newelement("Sim_SquadInfo",				"CONTROL+SHIFT+Q", 	"Sim_SquadInfo()" ),
					newelement("Sim_SquadStateTree",		"CONTROL+SHIFT+N",					"Sim_SquadStateTreeToggle()" ),
					newelement("Sim_SquadSuppression",		"", 	"Sim_SquadSuppression()"),
					newelement("Sim_SquadMorale", "", "Sim_SquadMorale()"),
					newelement( "Make squad invunerable", 	"CONTROL+SHIFT+U", 	"MakeSquadInvulnerable()", NO_MP),
					newelement( "Reinforce Selected Squads", "ALT+SHIFT+R", "ReinforceSelectedSquads()"),
					newelement( "Toggle selected squads invunerability", 	"CONTROL+ALT+SHIFT+U", 	"ToggleSelectedSquadsInvulnerable()", NO_MP),
					newelement( "Sim_PassiveChargeInfo", "CONTROL+SHIFT+ALT+P", "Sim_PassiveChargeInfo()"),
					newelement("Sim_SquadStateModelProperties",			"",		"Sim_SquadStateModelProperties()"),
					newseperator(),
					newelement("Veterancy Info",			"",					"Sim_DebugVeterancy()" ),
					newelement( "Give experience to squad", "CONTROL+V", 	"GiveExperienceToSquad()", NO_MP),
					newelement( "Give suppression to squad", "CONTROL+SHIFT+0", "GiveSuppressionToSquad()", NO_MP),
					newelement("Decrease supply of mouseover squad", "", "DecreaseSupply()", NO_MP),
					newboolean( "Squad Targeting Debug", "sim_squad_targeting_debug_get()", "sim_squad_targeting_debug_set(%s)"),
					{
						name = "Add officer to squad",
						type = SubMenu,
						SubMenuItems = GetOfficerListTable(),
					},
				}
			},
			{
				name = "Entity",
				type = SubMenu,
				SubMenuItems = 
				{
					newelement("Toggle Entity Info", 		"CONTROL+E",		"ToggleEntityInfo()"),
					newelement("Sim_EntityInfo",			"CONTROL+SHIFT+E", 	"Sim_EntityInfo()" ),
					newelement("Sim_EntityModifier",		"CONTROL+SHIFT+M", 	"Sim_EntityModifier()" ),
					newelement("Sim_EntityStimulus",		"CONTROL+ALT+L", 	"Sim_EntityStimulusToggle()" ),
					newelement("Sim_EntityAbility",			"", 				"Sim_EntityAbility()" ),
					newelement("Sim_EntityUpgrades",		"", 				"Sim_EntityUpgrades()" ),
					newelement("Sim_EntityStateTree",		"CONTROL+SHIFT+V",					"Sim_EntityStateTreeToggle()" ),
					newelement("Sim_EntityStateModelProperties",	"",					"Sim_EntityStateModelProperties()" ),
					newelement("Sim_EntityTargetFiredInfo",	"CONTROL+ALT+W", 	"Sim_EntityTargetFiredInfo()" ),
					newelement("Sim_DrawAttention",			"CONTROL+ALT+T", 	"Sim_DrawAttention()" ),
					newelement("Sim_DrawEntityHitMarkers",	"",					"Sim_ToggleDrawEntityHitMarkers()"),
					newboolean("Sim_DrawEntityRoadMarkers",	"Sim_GetDrawEntityRoadMarkers()", "Sim_SetDrawEntityRoadMarkers(%s)"),
					newelement("Sim_DrawAutoTargetArea",    "",					"Sim_DrawAutoTargetArea()"),
					newelement("Sim_EntityAttackMovePriority", "CONTROL+ALT+SHIFT+Q", "Sim_EntityAttackMovePriority()"),
					newelement("Sim_EntityIdleTargetingPriority", "", "Sim_EntityIdleTargetingPriority()"),
					newboolean("Targeting Debug", "sim_entity_targeting_debug_get()", "sim_entity_targeting_debug_set(%s)"),
					newelement("Toggle scan for targets track info for debug entity", "", "Toggle_Scanning_Info()"),
					newelement("Change entity owner to Local", "",	"ChangeEntityOwnerToLocal()", NO_MP),
					newelement("Change entity owner to neutral", "", "ChangeEntityOwnerToWorld()", NO_MP),
					newelement("Change entity owner to Enemy", "",	"ChangeEntityOwnerToEnemy()", NO_MP),
				}
			},
			{
				name = "Weapon",
				type = SubMenu,
				SubMenuItems = 
				{
					newelement("Weapon Info", 				"CONTROL+N",  			"Weapon_Info()"),
					newelement("Weapon_Debug",				"CONTROL+SHIFT+W",		"Weapon_Debug()"),
					newelement("Weapon_ProjectileInfo",		"",						"Weapon_ProjectileInfo()"),
					newelement("Cycle Weapon",				"CONTROL+SHIFT+UP",		"IncrWeaponIndex()"),
					newelement("Weapon_HardPointInfo",		"CONTROL+SHIFT+H",		"Weapon_HardPointInfo()" ),
					newelement("Weapon Priority Info",		"",						"Weapon_PriorityInfo()"),
					newelement("Cursor_WeaponInfo",			"",						"Cursor_WeaponInfo()"),
					newelement("Cursor_WeaponRanges",		"CONTROL+SHIFT+R",		"Cursor_WeaponRanges()" ),
					{
						name = "Cursor_DrawShotHistory",
						type = Variable,
						get = "Cursor_GetDrawWeaponShotHistory()",
						set = "Cursor_SetDrawWeaponShotHistory(%s)",
						var_type = Boolean,
					},
					{
						name = "Cursor_ClearShotHistory",
						type = Variable,
						get = "Cursor_GetClearWeaponShotHistory()",
						set = "Cursor_SetClearWeaponShotHistory(%s)",
						var_type = Boolean,
					},					
				}
			},
			{
				name = "Market and Trade Routes",
				type = SubMenu,
				SubMenuItems = 
				{
					{
						name = "Sim_DrawMarketInfo",
						type = Variable,
						get = "Sim_GetDrawMarketInfo()",
						set = "Sim_SetDrawMarketInfo(%s)",
						var_type = Boolean,
					},
					{
						name = "Sim_DrawTradeRouteInfo",
						type = Variable,
						get = "Sim_GetDrawTradeRouteInfo()",
						set = "Sim_SetDrawTradeRouteInfo(%s)",
						var_type = Boolean,
					},
				}
			},
			{
				name = "Influence Progression",
				type = SubMenu,
				SubMenuItems =
				{
					newelement("Add Buckram Influence with 5 influence value", "", "AddInfluenceValue5(\"Buckram\", 5)"),
					newelement("Purchase Next Possible Influence Reward for Buckram", "", "PurchaseNextPossibleNarrativeInfluenceReward(\"Buckram\")"),
					newelement("Add Norton Influence with 5 influence value", "", "AddInfluenceValue5(\"Norton\", 5)"),
					newelement("Purchase Next Possible Influence Reward for Norton", "", "PurchaseNextPossibleNarrativeInfluenceReward(\"Norton\")"),
					newelement("Add Valenti Influence with 5 influence value", "", "AddInfluenceValue5(\"Valenti\", 5)"),
					newelement("Purchase Next Possible Influence Reward for Valenti", "", "PurchaseNextPossibleNarrativeInfluenceReward(\"Valenti\")"),
				},
			},
		
			newseperator(),
			newelement("Toggle Interactive Stages Visibility", "", "Cheat_ToggleAllInteractiveStagesVisibility()"),

			newseperator(),
			newboolean( "StateTree Debug", "sim_state_tree_debug_get()", "sim_state_tree_debug_set(%s)"),

			newseperator(),
			newelement("Sim_CollisionSystemDraw", 	"", 	            "Sim_CollisionSystemDraw()" ),
			
			newseperator(),
			newelement("Sim_WorldStateModelProperties","",	"Sim_WorldStateModelProperties()" ),

			newseperator(),
			newelement("Sim_PlayerInfo", 			"", 	            "Sim_PlayerInfo()" ),
            newelement("Sim_PlayerStateModelProperties", 			"",	"Sim_PlayerStateModelProperties()" ),
            newelement("Sim_PlayerStateModelPropertiesNextPlayer", 			"",	"Sim_PlayerStateModelPropertiesNextPlayer()" ),
			newelement("Sim_PlayerStateModelPropertiesScroll_Increment", 			"SHIFT+ALT+UP",		"Sim_PlayerStateModelPropertiesScroll_Increment()" ),
			newelement("Sim_PlayerStateModelPropertiesScroll_Decrement ", 			"SHIFT+ALT+DOWN",	"Sim_PlayerStateModelPropertiesScroll_Decrement()" ),		
			newelement("Entity/Squad Counts",		"CONTROL+ALT+E",	"toggle_unit_counts()" ),

			newseperator(),
			newelement("Sim_CheckRequrements",		"", 				"Sim_CheckRequrements()" ),
			newelement("Sim_DrawAttention",			"", 				"Sim_DrawAttention()" ),
			newelement("Sim_DrawConstructionSpots",	"",					"Sim_DrawConstructionSpots()" ),
			newelement("Sim_EntityDelay",			"CONTROL+ALT+D",	"Sim_EntityDelay()" ),
			newelement("Sim_DebugDrawSimTick",		"",					"Sim_DebugDrawSimTick()"),
			
			newseperator(),
		
			{
				name = "Destructible Cells",
				type = SubMenu,
				SubMenuItems = 
				{
					{
						name = "Visualize Cells",
						type = Variable,
						get = "Get_Destructible_Cell_Visuals_Enabled()",
						set = "Set_Destructible_Cell_Visuals_Enabled(%s)",
						var_type = Boolean,
					},	
					{
						name = "Show Cell Info",
						type = Variable,
						get = "Get_Destructible_Cell_Info_Enabled()",
						set = "Set_Destructible_Cell_Info_Enabled(%s)",
						var_type = Boolean,
					},	
					newelement("Open Mouseover Cell",		"",					"Open_Mouse_Over_Cell()" ),
					newelement("Close Mouseover Cell",		"",					"Close_Mouse_Over_Cell()" ),
				    newelement("Damage Mouseover Cell",		"",					"Damage_Mouse_Over_Cell()" ),
				},
			},


			newseperator(),


			newelement("HideMouseOverEntity",		"",					"HideMouseOverEntity()"),	
			newelement("Cursor_Info",				"CONTROL+SHIFT+I",	"Cursor_Info()"),	
			newelement("Cursor Measure Approximate Distance",	"CONTROL+ALT+N",	"Cursor_Distance()"),			
			newelement("Cursor_TerrainHeight", 		"", 				"Cursor_TerrainHeight()" ),

			newseperator(),
			newelement("Toggle Booby Trap Render",	"",					"Sim_ToggleDrawBoobyTraps()" ),
		}
end

function GetScarSubMenu()
	return
		{
			newelement( "Toggle profiling", "ALT+P", "RulesProfiler_Enable( true ); RulesProfiler_Activate(not RulesProfiler_IsActive())" ),
			newelement( "Toggle watcher", "ALT+T", toggle_scar_watcher ),
			newelement( "Toggle all vars", "ALT+V", toggle_all_vars ),
			newelement( "Toggle group display", "", "Scar_GroupInfo()" ),
			newelement( "Toggle group list", "", "Scar_GroupList()" ),
			newelement( "Toggle marker display", "", "Scar_DrawMarkers()" ),
			newseperator(),
			newelement( "Reload Scar scripts", "ALT+R", "Scar_DoString( \"Util_ReloadScript()\" )", NO_MP ),
			WaveManager = {
				name = "Wave Manager",
				type = SubMenu,
				SubMenuItems =
				{
				},
			},
		}
end

function GetPathingSubMenu()
	return

		{
			newelement( "Toggle Draw Formations", "CONTROL+ALT+F","Path_DrawFormation()"),
			newelement( "Designer mode", "","toggle_cool_designer_debug()", NO_MP), --HOTKEY Used to be CONTROL+SHIFT+D, now used for FOW_RevealAll
			newelement( "Toggle Decals", "CONTROL+ALT+F1","dirt_debugtoggle(\"nodecals\")"),
			newelement( "Toggle Terrain Overlay", "CONTROL+F5", "toggle_terrainoverlay()" ),
			newseperator(),
			newelement( "Draw Impass for Debug Pass Type", "CONTROL+SHIFT+F2", "Path_DrawImpass()" ),
			newelement( "Increment Debug Pass Type", "CONTROL+SHIFT+F3", "inc_debug_pass_type(); Path_DrawImpass()"),			
			newelement( "Toggle Draw Impass Shows Final", "", "Path_SetDrawGeneratedImpass(not Path_GetDrawGeneratedImpass()); Path_DrawImpass()" ),
			newelement( "Toggle Impass Final is Terrain Only", "", "Path_SetDrawGeneratedImpassTerrainOnly(not Path_GetDrawGeneratedImpassTerrainOnly()); Path_DrawImpass()" ),			
			newelement( "Toggle Draw Impass Shows Painted", "", "Path_SetDrawPaintedImpass(not Path_GetDrawPaintedImpass()); Path_DrawImpass()" ),
			newelement( "Toggle Draw Obstacle Grid", "ALT+3", "Path_DrawObstacleGridDebug()" ),
			newseperator(),
			newelement( "Draw Can Build", "CONTROL+SHIFT+F4", "Path_DrawCanBuild()" ),
			newseperator(),
			newelement( "Draw Precise Map Once", "CONTROL+SHIFT+F6", "Path_DrawPathMap(1)" ),
			newelement( "Draw Precise Map Repeatedly", "CONTROL+SHIFT+F7", "toggleupdateprecise()" ),
			newseperator(),
			newelement( "Toggle Draw SparseGrid", "CONTROL+ALT+F6", "Path_SparseOnly()" ),
			newelement( "Toggle Draw Prediction", "CONTROL+ALT+F7", "Path_Prediction()" ),
			newelement( "Draw Reservation Map", "CONTROL+SHIFT+F12", "Path_DrawResMap()" ),
			newseperator(),
			newelement( "Draw Mover Info", "CONTROL+SHIFT+F8", "Path_DrawMoverInfo()" ),
			{
				name = "Draw Mover Info Options",
				type = SubMenu,
				SubMenuItems = 
				{
					{
						name = "Draw High Path",
						type = Variable,
						get = "Get_Path_DrawMoverInfo_DrawHighPath_Enabled()",
						set = "Set_Path_DrawMoverInfo_DrawHighPath_Enabled(%s)",
						var_type = Boolean,
					},
					{
						name = "Draw Low Path",
						type = Variable,
						get = "Get_Path_DrawMoverInfo_DrawLowPath_Enabled()",
						set = "Set_Path_DrawMoverInfo_DrawLowPath_Enabled(%s)",
						var_type = Boolean,
					},
					{
						name = "Draw Pre Turn Low Path",
						type = Variable,
						get = "Get_Path_DrawMoverInfo_DrawPreTurnLowPath_Enabled()",
						set = "Set_Path_DrawMoverInfo_DrawPreTurnLowPath_Enabled(%s)",
						var_type = Boolean,
					},
					{
						name = "Draw Prediction",
						type = Variable,
						get = "Get_Path_DrawMoverInfo_DrawPrediction_Enabled()",
						set = "Set_Path_DrawMoverInfo_DrawPrediction_Enabled(%s)",
						var_type = Boolean,
					},
					{
						name = "Draw AStar",
						type = Variable,
						get = "Get_Path_DrawMoverInfo_DrawAStar_Enabled()",
						set = "Set_Path_DrawMoverInfo_DrawAStar_Enabled(%s)",
						var_type = Boolean,
					},
					{
						name = "Draw Sector AStar",
						type = Variable,
						get = "Get_Path_DrawMoverInfo_DrawAStarSector_Enabled()",
						set = "Set_Path_DrawMoverInfo_DrawAStarSector_Enabled(%s)",
						var_type = Boolean,
					},
					{
						name = "Draw Turn Plans (Requires Draw Low Path)",
						type = Variable,
						get = "Get_Path_DrawMoverInfo_DrawTurnPlans_Enabled()",
						set = "Set_Path_DrawMoverInfo_DrawTurnPlans_Enabled(%s)",
						var_type = Boolean,
					},
					{
						name = "Draw Towing",
						type = Variable,
						get = "Get_Path_DrawMoverInfo_DrawTowing_Enabled()",
						set = "Set_Path_DrawMoverInfo_DrawTowing_Enabled(%s)",
						var_type = Boolean,
					},
				},
			},
			{
				name = "Draw Path History",
				type = Variable,
				get = "Get_Path_DrawPathInfo_Enabled()",
				set = "Set_Path_DrawPathInfo_Enabled(%s)",
				var_type = Boolean,
			},
			newelement( "Draw Path Smoother", "", "Path_DrawPathSmooth()" ),
			newelement( "Toggle Path Rendering", "CONTROL+SHIFT+F9", "path_togglepathrendering()"),
			newelement( "Toggle Turn Output", "CONTROL+SHIFT+F10","path_toggleturnoutput()"),
			newelement( "Toggle A* Fill", "CONTROL+SHIFT+F11","toggle_astarfill()"),
			newelement( "mem usage", "CONTROL+SHIFT+ALT+P", "pf_memusage()"),
			newelement( "sector count", "", "pf_sectorcount()"),
			newelement( "Draw OOC Targets", "CONTROL+ALT+O", "Sim_EntityOOCTarget()"),
		}
end


function GetCameraSubMenu()
	return 

		{
			newelement( "Toggle Debug Camera", "CONTROL+C", "Camera_ToggleDebugCamera()" ),
			newelement( "Toggle Camera Interactivty Check", "CONTROL+SHIFT+C", "Camera_ToggleInteractivityCheck()" ),
			newelement( "Camera SwitchBoard Debug", "", "ToggleCameraSwitchboardDebugDraw()"),
			newboolean( "Toggle CameraMesh Display", "Camera_IsMeshShown()", "Camera_ToggleMeshShown(%s)" ),
			bind("ALT+SHIFT+I", "Scar_DoString( \"Camera_DebugFollowSquadStart(false)\" )"),
			newseperator(),
			{
				name = "CameraList",
				type = SubMenu,
				SubMenuItems = GetCameraListMenuTable("")
			},
		}
end

function GetRenderingSubMenu()
	return
		{
			newelement( "More rendering debug options.......CONTROL+EQUAL", "", ""),

			newelement( "Wireframe (world)", "CONTROL+W", "VIS_Wireframe()"),
			newelement( "Default Render  (world)", "CONTROL+SHIFT+ALT+Y", "VIS_SetDebugView(0)"),
			newelement( "Triplanar Render (world)", "CONTROL+SHIFT+ALT+H", "VIS_SetDebugView(16)"), -- paramters are int value of enum found in grDebugView.h
		
			newelement( "Overdraw (terrain)", "ALT+SHIFT+X", "dirt_debugtoggle(\"overdraw\")"),
			newelement( "Toggle Deferred Decal Debugging", "", "VIS_ToggleDeferredDecalDebugging()"),
			newelement( "LAO - Save Textures", "", "LAO_Dump()"),
			newelement( "LAO - Refresh Textures", "", "LAO_ForceRefresh()"),
			
			newelement( "Turn off render", "CONTROL+F9", "render_toggle()" ),
			
			newelement( "Increment Animator Debug Mode", "CONTROL+ALT+A", "animator_debug_increment()" ),
			
			newelement( "Disable Animator Debug", "CONTROL+ALT+0", "animator_debug_mask(0)" ), --formerly used "animator_debug_enable(false)", but this didn't seem to do anything
			newelement( "Show Skeleton", "CONTROL+ALT+S", "animator_debug_mask(8)" ),
			
			newelement( "Toggle Animator Debug Mode 1 : Playlist, DCAData, DCAContext", "CONTROL+ALT+1", "animator_toggle(7)" ),
			newelement( "Toggle Animator Debug Mode 2 : Mode 1 + Skeleton", "CONTROL+ALT+2", "animator_toggle(15)" ),
			newelement( "Toggle Animator Debug Mode 3 : Mode 2 + Markers", "CONTROL+ALT+3", "animator_toggle(31)" ),
			newelement( "Toggle Animator Debug Mode 4 : Mode 3 + BoneNames", "CONTROL+ALT+4", "animator_toggle(63)" ),
			newelement( "Toggle Animator Debug Mode 5 : MeshSelector, CullInfo", "CONTROL+ALT+5", "animator_toggle(192)" ),
			newelement( "Toggle Animator Debug Mode 6 : Attachments", "CONTROL+ALT+6", "animator_toggle(256)" ),
			newelement( "Toggle Animator Debug Mode 7 : BuildingQuadrants", "CONTROL+ALT+7", "animator_toggle(512)" ),
			
			newboolean( "Action Trigger Log (global)", "dca_get_actions_global()", "dca_set_actions_global(%s)" ),
			newboolean( "Action Trigger Log (mouse-over entity-type)", "DCA_GetMouseoverActionLogging()", "DCA_SetMouseoverActionLogging(%s)" ),
			newelement( "Toggle DCA Actions Tracing (mouse-over entity)", "", "DCA_ToggleActionsTracing()"),
			
			newelement( "Toggle Winter Skin on selected entity", "", "apply_skin_override(\"winter\")" ),
			newelement( "Toggle Battle-damaged Skin on selected entity", "", "apply_skin_override(\"battle_damaged\")" ),
			newelement( "FX Show Invisible Pixels", "", "VIS_ToggleShowInvisiblePixels()"),
		}
end

function GetSoundSubMenu()
	return
		{
			{
				name = "Listeners",
				type = SubMenu,
				SubMenuItems = 
				{
					newelement( "Previous Listener", "CONTROL+ALT+LBRACKET", "Sound_Debug_PrevListenerIndex()"),
					newelement( "Next Listener", "CONTROL+ALT+RBRACKET", "Sound_Debug_NextListenerIndex()"),
					{
						name = "Show Active Listener Info",
						type = Variable,
						get = "Sound_Debug_GetShowListenerInfoEnabled()",
						set = "Sound_Debug_SetShowListenerInfo(%s)",
						var_type = Boolean,
					},
					{
						name = "Set Listener Mode to Flat Earth",
						type = Variable,
						get = "Sound_Debug_GetListenerToFlatEarthEnabled()",
						set = "Sound_Debug_SetListenerToFlatEarth(%s)",
						var_type = Boolean,
					},	
					{
						name = "Set Listener Mode to Camera Position",
						type = Variable,
						get = "Sound_Debug_GetListenerPositionToCameraEnabled()",
						set = "Sound_Debug_SetListenerPositionToCamera(%s)",
						var_type = Boolean,
					},
					{
						name = "Set Listener Mode to Center Screen",
						type = Variable,
						get = "Sound_Debug_GetListenerToCenterScreenEnabled()",
						set = "Sound_Debug_SetListenerToCenterScreen(%s)",
						var_type = Boolean,
					},
				},
			},
			{
				name = "Speech",
				type = SubMenu,
				SubMenuItems = 
				{
					newboolean( "Enable Speech Debug", "Sound_GetSpeechDebugEnabled()", "Sound_SetSpeechDebugEnabled(%s)" ),
					newboolean( "Force Read All Speech Value", "Sound_GetForceFullSpeechCacheRead()", "Sound_SetForceFullSpeechCacheRead(%s)" ),
					newboolean( "Show Speech Combat Zones", "Sound_GetSpeechDebugModeEnabled(DEBUG_COMBATZONES)", "Sound_SetSpeechDebugModeEnabled(DEBUG_COMBATZONES, %s)" ),
					newboolean( "Show Squad Speech History", "Sound_GetSpeechDebugModeEnabled(DEBUG_SQUADSPEECHHISTORY)", "Sound_SetSpeechDebugModeEnabled(DEBUG_SQUADSPEECHHISTORY, %s)" ),
					newboolean( "Show Squad Speech Context", "Sound_GetSpeechDebugModeEnabled(DEBUG_SQUADSPEECHCONTEXT)", "Sound_SetSpeechDebugModeEnabled(DEBUG_SQUADSPEECHCONTEXT, %s)" ),
					newboolean( "Show Intel Speech History", "Sound_GetSpeechDebugModeEnabled(DEBUG_INTELSPEECHHISTORY)", "Sound_SetSpeechDebugModeEnabled(DEBUG_INTELSPEECHHISTORY, %s)" ),
					newboolean( "Show Squad Speech Timers", "Sound_GetSpeechDebugModeEnabled(DEBUG_SQUADSPEECHTIMERS)", "Sound_SetSpeechDebugModeEnabled(DEBUG_SQUADSPEECHTIMERS, %s)" ),
					newboolean( "Show Speaker Code Speech Timers", "Sound_GetSpeechDebugModeEnabled(DEBUG_SPEAKERCODESPEECHTIMERS)", "Sound_SetSpeechDebugModeEnabled(DEBUG_SPEAKERCODESPEECHTIMERS, %s)" ),
					newboolean( "Show Global Speech Timers", "Sound_GetSpeechDebugModeEnabled(DEBUG_GLOBALSPEECHTIMERS)", "Sound_SetSpeechDebugModeEnabled(DEBUG_GLOBALSPEECHTIMERS, %s)" ),
					newboolean( "Show Intel Speech Timers", "Sound_GetSpeechDebugModeEnabled(DEBUG_INTELSPEECHTIMERS)", "Sound_SetSpeechDebugModeEnabled(DEBUG_INTELSPEECHTIMERS, %s)" ),
					newboolean( "Show Speaker Squad", "Sound_GetSpeechDebugModeEnabled(DEBUG_SPEAKERSQUAD)", "Sound_SetSpeechDebugModeEnabled(DEBUG_SPEAKERSQUAD, %s)" ),
				},
			},
			{
				name = "Rivers",
				type = SubMenu,
				SubMenuItems = 
				{
					newboolean( "Enable Rivers Debug", "Sound_GetBoolVar(\"ShowRivers\")", "Sound_SetBoolVar(\"ShowRivers\", %s)" ),
					newboolean( "Show River Points", "Sound_GetBoolVar(\"ShowRiverPoints\")", "Sound_SetBoolVar(\"ShowRiverPoints\", %s)" ),
					newboolean( "Show River Banks", "Sound_GetBoolVar(\"ShowRiverBanks\")", "Sound_SetBoolVar(\"ShowRiverBanks\", %s)" ),
					newboolean( "Show River IDs", "Sound_GetBoolVar(\"ShowRiverIDs\")", "Sound_SetBoolVar(\"ShowRiverIDs\", %s)" ),
				},
			},
			newboolean( "Show Audio Regions", "Sound_Debug_ShowAudioRegionsEnabled()", "Sound_Debug_ShowAudioRegions(%s)" ),
			newboolean( "Show Audio Emitters", "Sound_Debug_ShowAudioEmittersEnabled()", "Sound_Debug_ShowAudioEmitters(%s)" ),
			newboolean( "Show Audio Reflectors", "Sound_Debug_ShowAudioReflectorsEnabled()", "Sound_Debug_ShowAudioReflectors(%s)" ),
			newboolean( "Show Culling Categories", "Sound_Debug_ShowCullingCategoriesEnabled()", "Sound_Debug_ShowCullingCategories(%s)" ),
			newboolean( "Show Music Debug", "Sound_MusicDebugEnabled()", "Sound_ShowMusicDebug(%s)" ),
			newboolean( "Show Combat Alert Zones", "Sound_Debug_ShowCombatAlertZonesEnabled()", "Sound_Debug_ShowCombatAlertZones(%s)" ),
			newboolean( "Show Audio Triggers", "Sound_Debug_ShowAudioTriggersEnabled()", "Sound_Debug_ShowAudioTriggers(%s)"),
			newboolean( "Show Group Movement", "Sound_Debug_ShowGroupMovementDebugInfoEnabled()", "Sound_Debug_ShowGroupMovementDebugInfo(%s)"),
			newboolean( "Show Entity Distance Info", "Sound_Debug_ShowEntityDistanceInfoEnabled()", "Sound_Debug_ShowEntityDistanceInfo(%s)" ),
			newboolean( "Show Audio Importance", "Sound_Debug_ShowAudioImportanceDebugInfoEnabled()", "Sound_Debug_ShowAudioImportanceDebugInfo(%s)"),
			newboolean( "Set Force Silence", "Sound_ForceSilenceEnabled()", "Sound_SetForceSilence(%s)" ),
			newboolean( "Set Force Music", "Sound_ForceMusicEnabled()", "Sound_SetForceMusic(%s)" ),
		}
end

function GetPostureSubMenu()
	return
		{
			newelement( "Selected Squads To Face Mouse", "CONTROL+ALT+SHIFT+C", "FaceSelectedSquads()"),
		}
end


function GetUISubMenu()
	return

		{
			newelement( "Show All UI", "", "gameshowallui()"),
			newelement( "Hide All UI", "", "gamehideallui()"),
			newelement( "Show UI Controls", "", "game_showui()" ),
			newelement( "Hide UI Controls", "", "game_hideui()"),
			newelement( "Show EntityColor", "", "game_showentitycolors()"),
			newelement( "Hide EntityColor", "", "game_hideentitycolors()"),
			newelement( "Show Damage Flashes", "", "game_showdamageflash()"),
			newelement( "Hide Damage Flashes", "", "game_hidedamageflash()"),
			newelement( "Show Taskbar", "", "taskbar_show()" ),
			newelement( "Hide Taskbar", "", "taskbar_hide()"),
			newelement( "Enable Player Colour", "", "PlayerColour_Enable()" ),
			newelement( "Disable Player Colour", "", "PlayerColour_Disable()"),
			newelement( "Show Visual Flags", "", "game_showvisualflags()" ),
			newelement( "Hide Visual Flags", "", "game_hidevisualflags()"),
			newelement( "Show Debug Challenge UI", "", "game_showchallengeui()"),
			newelement( "Hide Debug Challenge UI", "", "game_hidechallengeui()"),
		}
end

function GetStatGraphSubMenu()
	return
{
			{
				name = "Show Graph",
				type = Variable,
				get = "statgraph_get_visible()",
				set = "statgraph_set_visible(%s)",
				var_type = Boolean,
			},
			{
				name = "Show Stats",
				type = Variable,
				get = "statgraph_stats_get_visible()",
				set = "statgraph_stats_set_visible(%s)",
				var_type = Boolean,
			},
			{
				name = "Disable Value Normalization",
				type = Variable,
				get = "statgraph_is_value_normalization_enabled()",
				set = "statgraph_set_value_normalization_enabled(%s)",
				var_type = Boolean,
			},			
			statgraph_item("fps"),
			statgraph_item("aithink"),
			statgraph_item("ai_pathfinding_time"),
			statgraph_item("simRate"),
			statgraph_item("gameobj"),
			statgraph_item("gamevis"),
			statgraph_item("looprender"),
			statgraph_item("fx object count"),
			statgraph_item("viz_objects"),
			{
				name = "Memory",
				type = SubMenu,
			
				SubMenuItems = 
				{
					statgraph_item("mem_allocn_cur","Toggle Current Allocations"),
					statgraph_item("mem_size_cur","Toggle Current Size"),
					statgraph_item("mem_allocn_max","Toggle Max Allocations"),
					statgraph_item("mem_size_max","Toggle Max Size"),
				},
			},

			{
				name = "Physics",
				type = SubMenu,
			
				SubMenuItems = 
				{
					statgraph_item("phy/orphanmanager_total_debris_count","Toggle Total Debris Count"),
					statgraph_item("phy/orphanmanager_mobile_debris_count","Toggle Mobile Debris Count"),
					statgraph_item("phy/orphanmanager_total_ragdoll_count","Toggle Total Ragdoll Count"),
					statgraph_item("phy/orphanmanager_mobile_ragdoll_count","Toggle Mobile Ragdoll Count"),
					statgraph_item("gamephy/fxphyworldenv_numBodies","Toggle Num World Bodies"),
					statgraph_item("hkphy/worldimp_numislands","Toggle Num hk Islands"),
					statgraph_item("hkphy/worldimp_numbodies","Toggle Num hk Bodies"),
					statgraph_item("hkphy/worldimp_numactiveislands","Toggle Num Active Islands"),
					statgraph_item("hkphy/worldimp_numactivebodies","Toggle Num Active Bodies"),
					statgraph_item("hkphy/worldimp_numaabbsinbroadphase","Toggle Num AABB In BroadphaseBodies"),
				},
			},

			{
				name = "Network",
				type = SubMenu,
			
				SubMenuItems = 
				{
					statgraph_item("netCurrentPeriod"),
					statgraph_item("netTargetPeriod"),
					statgraph_item("netPerfectPeriod"),
					statgraph_item("netTargetQueue"),
					statgraph_item("netRemoteQueue"),
					statgraph_item("netLocalQueue"),
				},
			},

			{
				name = "Texture",
				type = SubMenu,
			
				SubMenuItems = 
				{
					statgraph_item("texture_change"),
					statgraph_item("texture_limit"),
					statgraph_item("texture_used"),
					statgraph_item("texture_memory"),
					statgraph_item("terraintexture_update"),
				},
			},
			
			{
				name = "FX",
				type = SubMenu,
			
				SubMenuItems = 
				{
					statgraph_item("fx_batchnum"),
					statgraph_item("fx_objectnum"),
					statgraph_item("fx_trinum"),
				},
			},

			{
				name = "Rendering",
				type = SubMenu,
			
				SubMenuItems = 
				{
					statgraph_item("sp/rendercalls","Render calls"),
					statgraph_item("sp/rendersimplecalls","Render simple calls"),
					statgraph_item("sp/devicerendercalls","Device render calls"),

					statgraph_item("sp/shaderchanges","shader changes"),

					statgraph_item("sp/tris","tris"),
					statgraph_item("sp/verts","verts"),
					statgraph_item("sp/dynamicverts","dynamic verts"),
					statgraph_item("sp/skinnedverts","skinned verts"),
					statgraph_item("sp/staticverts","static verts"),
					
					statgraph_item("sp/entitiesOnScreen","Entities On Screen"),
				},
			},

			{
				name = "Sound",
				type = SubMenu,
			
				SubMenuItems = 
				{
					statgraph_item("snd_total_cpu"),
					statgraph_item("snd_used_voices"),
				},
			},
			{
				name = "State Tree",
				type = SubMenu,
			
				SubMenuItems = 
				{
					statgraph_item("st_num_physical_islands"),
					statgraph_item("st_num_deferred_islands"),
					statgraph_item("st_max_physical_island_size"),
					statgraph_item("st_max_deferred_island_size"),				
					statgraph_item("st_num_physical_islands_as_percent"),
					statgraph_item("st_num_deferred_islands_as_percent"),
					statgraph_item("st_max_physical_island_size_as_percent"),
					statgraph_item("st_max_deferred_island_size_as_percent"),
				},
			},
			{
				name = "Entities",
				type = SubMenu,
			
				SubMenuItems = 
				{
					statgraph_item("entities_spawned"),
					statgraph_item("entities_despawned"),
					statgraph_item("entities_combat"),
				},
			},			
		}
end

function AddReloadSubMenu()
	return
		{
			newelement("PBG_ReloadMouseOverWeapon",		"",		"PBG_ReloadMouseOverWeapon()", NO_MP ),
			newelement("PBG_ReloadSquadAI",				"",		"PBG_ReloadSquadAI()", NO_MP ),	
		}
end

function AddMemorySubMenu()
	return
		{
			newelement("Toggle Pool Watcher", "", "poolwatch()" ),
			newelement("Dump Memory Budget File", "", "Game_DumpMemoryUsage()" ),
		}
end

function AddAbilitySubMenu()
	return
		{
			{
				name = "Spawn Enemy Ability",
				type = Variable,
				get = "cheatmenu_spawnenemyability",
				set = "cheatmenu_spawnenemyability = %s",
				var_type = Boolean,
			},
			{
				name = "List",
				type = SubMenu,
				SubMenuItems = GetAbilityMenuTable(),
			}
		}
end

function AddTestSubMenu()
	return
	
		{
			{
				name = "IntelEvent Debugging",
				type = SubMenu,
				SubMenuItems = {
					newelement( "Play Next IntelEvent", "", "Scar_DoString( \"_IntelDebugNext()\" )" ),
					newelement( "Play Previous IntelEvent", "", "Scar_DoString( \"_IntelDebugPrev()\" )" ),
					newelement( "Replay last IntelEvent", "", "Scar_DoString( \"_IntelDebugReplay()\" )" ),
				}
			},
			newelement( "Log World Objects", "", "LogWorldObjects()", NO_MP ),
			newelement( "Destroy all World Entities", "", [[DestroyWorldEntities()]], NO_MP ),
			newelement( "Dump 10 Profile Frames", "", "if not profile_dump_number then profile_dump_number=1 else profile_dump_number=profile_dump_number+1 end; Game_ProfileDumpFrames('cheatmenu_dump_' .. tostring(profile_dump_number), 10)" ),
			newelement( "Dump 100 Profile Frames", "", "if not profile_dump_number then profile_dump_number=1 else profile_dump_number=profile_dump_number+1 end; Game_ProfileDumpFrames('cheatmenu_dump_' .. tostring(profile_dump_number), 100)" ),
			newelement( "Dump 1000 Profile Frames", "", "if not profile_dump_number then profile_dump_number=1 else profile_dump_number=profile_dump_number+1 end; Game_ProfileDumpFrames('cheatmenu_dump_' .. tostring(profile_dump_number), 1000)" ),
		}
end

function AddSaveLoadSubMenu()
	return
		
		{
			newelement( "Game_SaveToFileDev(\"TestSaveGameName\")", "", "Game_SaveToFileDev([[TestSaveGameName]])"),	
			newelement( "Game_LoadFromFileDev(\"TestSaveGameName\")", "", "Game_LoadFromFileDev([[TestSaveGameName]])"),
			newelement( "Game_Quicksave()", "", "Game_Quicksave()")
		}
		
end


local phy_explosion_debug = false
function GetPhyExplosionDebug()
	return phy_explosion_debug
end

function TogglePhyExplosionDebug(val)
	if(val ~= phy_explosion_debug) then
		phy_explosion_debug = val
		phy_explosion_visuals_set_lines(val)
		if(val) then
			phy_explosion_visuals_set_display(EDV_All)
		else
			phy_explosion_visuals_set_display(EDV_None)
		end
	end
end

function AddPhysicsSubMenu()
	return
	{
		{
			name = "Toggle Physics Render Debug",
			type = Variable,
			get = "GetPhysicsDebug()",
			set = "TogglePhysicsDebug(%s)",
			var_type = Boolean,
		},
		{
			name = "Toggle Contacts Render Debug",
			type = Variable,
			get = "phy_get_contact_debug()",
			set = "phy_set_contact_debug(%s)",
			var_type = Boolean,
		},
		{
			name = "Toggle Shape Render Debug",
			type = Variable,
			get = "GetPhysicsShapeDebugRenderingEnabled()",
			set = "SetPhysicsShapeDebugRenderingEnabled(%s)",
			var_type = Boolean,
		},
		{
			name = "Toggle Raycast as Capsule Debug",
			type = Variable,
			get = "GetPhysicsRaycastAsCapsuleDebug()",
			set = "TogglePhysicsRaycastAsCapsuleDebug(%s)",
			var_type = Boolean,
		},
		newelement( "Trigger RagDoll mouse over entity", "CONTROL+H",	"RagDollMouseOverObject()", NO_MP),
		newelement( "Trigger VehiclePhysics Debug mouse over entity", "Control+Alt+V",	"ToggleVehiclePhysicsDebugMouseOverObject()", NO_MP),
		
		{
			name = "Toggle explosion Debug",
			type = Variable,
			get = "GetPhyExplosionDebug()",
			set = "TogglePhyExplosionDebug(%s)",
			var_type = Boolean,
		},
	}	
end

function AddPerfSubMenu()
	return
	{
		newboolean("Show Essence Profiler", "PerfStats_IsEnabled()", "PerfStats_Toggle()"),
		newelement( "Dump", "CONTROL+SHIFT+P", "PerfStats_Dump()"),
		newboolean("Show FX Profiler", "FXProfiler_IsEnabled()", "FXProfiler_Toggle()"),
		newboolean("Show Animation Profiler", "isAnimationProfilerEnabled()", "ToggleAnimationProfiler()"),
		{
			name = "State Tree Profiler",
			type = SubMenu,
			SubMenuItems = 
			{		
				{
					name = "Enable Producer Entity Tree Demographics Display",
					type = Variable,
					get = "statetreeprofiler_get_enable_producer_tree_demographic_display()",
					set = "statetreeprofiler_set_enable_producer_tree_demographic_display(%s)",
					var_type = Boolean,
				},				
				{
					name = "Enable Deferred Entity Tree Demographics Display",
					type = Variable,
					get = "statetreeprofiler_get_enable_deferred_tree_demographic_display()",
					set = "statetreeprofiler_set_enable_deferred_tree_demographic_display(%s)",
					var_type = Boolean,
				},
				{
					name = "Enable Physical Tree Demographics Display",
					type = Variable,
					get = "statetreeprofiler_get_enable_physical_tree_demographic_display()",
					set = "statetreeprofiler_set_enable_physical_tree_demographic_display(%s)",
					var_type = Boolean,
				},
				{
					name = "Number of worst offenders to display ",
					type = SubMenu,
					SubMenuItems = 
					{
						{
							name = "15",
							type = Variable,
							get = "statetreeprofiler_get_num_items_to_display(15)",
							set = "statetreeprofiler_set_num_items_to_display(15)",
							var_type = Boolean,
						},
						{
							name = "30",
							type = Variable,
							get = "statetreeprofiler_get_num_items_to_display(30)",
							set = "statetreeprofiler_set_num_items_to_display(30)",
							var_type = Boolean,
						},
						{
							name = "50",
							type = Variable,
							get = "statetreeprofiler_get_num_items_to_display(50)",
							set = "statetreeprofiler_set_num_items_to_display(50)",
							var_type = Boolean,
						},
						{
							name = "100",
							type = Variable,
							get = "statetreeprofiler_get_num_items_to_display(100)",
							set = "statetreeprofiler_set_num_items_to_display(100)",
							var_type = Boolean,
						},
					},
				},
				{
					name = "Enable State Tree Node Match Worst Offenders",
					type = Variable,
					get = "statetreeprofiler_get_enable_worst_node_match_costs_display()",
					set = "statetreeprofiler_set_enable_worst_node_match_costs_display(%s)",
					var_type = Boolean,
				},
				{
					name = "Enable State Tree Node Update Worst Offenders",
					type = Variable,
					get = "statetreeprofiler_get_enable_worst_node_update_costs_display()",
					set = "statetreeprofiler_set_enable_worst_node_update_costs_display(%s)",
					var_type = Boolean,
				},
				{
					name = "Enable State Tree Node Condition Worst Offenders",
					type = Variable,
					get = "statetreeprofiler_get_enable_worst_condition_costs_display()",
					set = "statetreeprofiler_set_enable_worst_condition_costs_display(%s)",
					var_type = Boolean,
				},
				{
					name = "Enable State Tree Track Worst Offenders",
					type = Variable,
					get = "statetreeprofiler_get_enable_worst_track_costs_display()",
					set = "statetreeprofiler_set_enable_worst_track_costs_display(%s)",
					var_type = Boolean,
				},
				{
					name = "Toggle State Tree Profiler",
					type = Variable,
					get = "statetreeprofiler_get_enable_profiler()",
					set = "statetreeprofiler_set_enable_profiler(%s)",
					var_type = Boolean,
				},
				newelement("Increment Sliding Average","","statetreeprofiler_increment_sliding_average()"),
				newelement("Decrement Sliding Average","","statetreeprofiler_decrement_sliding_average()"),
				newelement("Dump data to Log","","statetreeprofiler_dump_active_data_to_log()"),
				newelement("Reset Performance Profiler Data","","statetreeprofiler_reset_average_data()"),
			}
		},
	}
end

SubMenuItems =
{
	-----------------------------
	Basic = 
	{
		name = "Basic",
		type = SubMenu,
		index = 50,
		
		SubMenuItems = GetBasicSubMenu(),
	},
	
	Spawn = 
	{
		name = "Spawn",
		type = SubMenu,
		index = 100,

		SubMenuItems = 
		{
			newboolean( "Spawn as Enemy", "g_cheatmenu_spawn_as_enemy", "g_cheatmenu_spawn_as_enemy=%s" ),
			newboolean( "Spawn as Neutral", "g_cheatmenu_spawn_as_neutral", "g_cheatmenu_spawn_as_neutral=%s" ),
			newelement( "IncreaseSpawnOffset", "", "IncreaseSpawnOffset()", NO_MP ),
			newelement( "DecreaseSpawnOffset", "", "DecreaseSpawnOffset()", NO_MP ),
			newelement( "Recreate all Squads", "", "RecreatePlayerSquads()", NO_MP ),
			Squads = {
				name = "Squads",
				type = SubMenu,
				SubMenuItems = 
				{
					{
						name = "gameplay",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\gameplay\\", false)
					},
					{
						name = "dev",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\dev\\", false)
					},
					{
						name = "races",
						type = SubMenu,
						SubMenuItems = GetSpawnSquadMenuTable("sbps\\races\\", false)
					},
				}
			},
			Entities = {
				name = "Entities",
				type = SubMenu,
				SubMenuItems =
				{
					{
						name = "Gameplay",
						type = SubMenu,
						SubMenuItems = GetSpawnEBPMenu("ebps\\gameplay\\"),
					},
					{
						name = "Dev",
						type = SubMenu,
						SubMenuItems = GetSpawnEBPMenu("ebps\\dev\\"),
					},
					{
						name = "races",
						type = SubMenu,
						SubMenuItems = GetSpawnEBPMenu("ebps\\races\\"),
					},
				}
			},
			{
				name = "Environment Objects",
				type = SubMenu,
				SubMenuItems = GetSpawnEntityEnvironmentsMenuTable()
			},
		}
	},
	
	Cosmetics = 
	{
		name = "Cosmetics",
		type = SubMenu,
		index = 150,

		SubMenuItems = {}
	},
	
	Abilities =
	{
		name = "Abilities",
		type = SubMenu,
		index = 200,
		SubMenuItems = AddAbilitySubMenu();
	},
	
	-----------------------------
	Damage = 
	{
		name = "Damage",
		type = SubMenu,
		index = 300,
		SubMenuItems = GetDamageSubMenu();

	},
	
	-----------------------------
	Sim =
	{
		name = "Sim",
		type = SubMenu,
		index = 400,
		SubMenuItems = GetSimSubMenu();

	},
	
	Squads =
	{
		name = "Squads",
		type = SubMenu,
		index = 500,
		SubMenuItems  = {};
	},

	Upgrades =
	{
		name = "Upgrades",
		type = SubMenu,
		index = 600,
		SubMenuItems  = {};
	},
	
	-----------------------------
	Scar = 
	{
		name = "Scar",
		type = SubMenu,
		index = 700,
		SubMenuItems = GetScarSubMenu();
	},
	
	-----------------------------
	AI =
	{
		name = "AI",
		type = SubMenu,
		index = 800,
		SubMenuItems = CreateAIMenu(g_isMPGame);
	},

	-----------------------------
	Pathing = 
	{
		name = "Pathing",
		type = SubMenu,
		index = 900,		
		SubMenuItems = GetPathingSubMenu();
	},


	-----------------------------
	Camera = 
	{
		name = "Camera",
		type = SubMenu,
		index = 1000,		
		SubMenuItems = GetCameraSubMenu();
	},
			
	-----------------------------
	Rendering =
	{
		name = "Rendering",
		type = SubMenu,
		index = 1100,		
		SubMenuItems = GetRenderingSubMenu();
	},
	
	Sound =
	{
		name = "Sound",
		type = SubMenu,
		index = 1200,		
		SubMenuItems = GetSoundSubMenu();
	},
	
	Posture =
	{
		name = "Posture",
		type = SubMenu,
		index = 1300,		
		SubMenuItems = GetPostureSubMenu();
	},
	
	Reload =
	{
		name = "Reload",
		type = SubMenu,
		index = 1400,		
		SubMenuItems = AddReloadSubMenu();
	},
	
	UI =
	{
		name = "UI",
		type = SubMenu,
		index = 1500,		
		SubMenuItems = GetUISubMenu();
	},
	
	Memory =
	{
		name = "Memory",
		type = SubMenu,
		index = 1600,		
		SubMenuItems = AddMemorySubMenu();
	},
	
	StatGraph =
	{
		name = "Statgraph",
		type = SubMenu,
		index = 1700,		
		SubMenuItems = GetStatGraphSubMenu();
	},
	
	TestTeam = 
	{
		name = "Test Team",
		type = SubMenu,
		index = 1800,
		SubMenuItems = AddTestSubMenu();
	},
	
	MissionCheats = 
	{
		name = "Mission Cheats",
		type = SubMenu,
		index = 1900,
		SubMenuItems =
		{
			Events = {
				name = "Events",
				type = SubMenu,
				SubMenuItems =
				{
				
				},
			},
		},
	},
	
	SaveLoad =
	{
		name = "Save/Load",
		type = SubMenu,
		index = 2000,
		SubMenuItems = AddSaveLoadSubMenu(); 
	},
    
	Physics =
	{
		name = "Physics",
		type = SubMenu,
		index = 2100,
		SubMenuItems = AddPhysicsSubMenu(); 
	},

	Perf =
	{
		name = "Perf",
		type = SubMenu,
		index = 2200,
		SubMenuItems = AddPerfSubMenu();
	},
}

g_cheatmenu_spawn_as_enemy = false
g_cheatmenu_spawn_as_neutral = false

function IncreaseSpawnOffset()
	spawn_offset = spawn_offset + 1.0
	print("spawn_offset= " .. spawn_offset)
end

function DecreaseSpawnOffset()
	spawn_offset = spawn_offset - 1.0
	print("spawn_offset= " .. spawn_offset)
end

-- spawns an entity at the current mouse pos
-- only set at local player for buildings
function SpawnEntityAtMouse( ebp )

	local local_player_id = getlocalplayer()
	
	-- get mouse over position
	local pos = Misc_GetMouseOnTerrain()
	local snapToTerrain = true
	if(spawn_offset ~= 0.0) then
		pos.y = pos.y + spawn_offset
		snapToTerrain = false
	end
		
	-- get player from id
	local player = Player_FromId(local_player_id)
	if g_cheatmenu_spawn_as_enemy == true then
		player = Player_FindFirstEnemyPlayer( player )
	elseif g_cheatmenu_spawn_as_neutral == true then
		player = Player_FindFirstNeutralPlayer( player )

		if (player == nil) then		
			-- spawn as world entity if no neutral player
	  		entityID = Entity_CreateENVCheat( ebp, pos, snapToTerrain )
	  		Entity_ForceConstruct( entityID )
	  		Entity_Spawn( entityID )
		end
	end
	
	if ( player == nil ) then
		return
	end
  	
  	entityID = Entity_CreateCheat( ebp, player, pos, snapToTerrain )
  	if (Entity_IsEBPBuilding( ebp ) == 1) then
  		Entity_ForceConstruct( entityID )
  	end
  	Entity_Spawn( entityID )
	
end

-- spawns a squad for the local player at the current mouse pos
function SpawnSquadAtMouse( sbp )
	local local_player_id = getlocalplayer()
	
	-- get mouse over position
	local pos = Misc_GetMouseOnTerrain()
	pos.y = pos.y + spawn_offset
	
	-- get player from id
	local player = Player_FromId(local_player_id)
	if g_cheatmenu_spawn_as_enemy == true then
		player = Player_FindFirstEnemyPlayer( player )
	elseif g_cheatmenu_spawn_as_neutral == true then
		player = Player_FindFirstNeutralPlayer( player )
	
		if ( player == nil ) then
			Squad_CreateAndSpawnTowardENVCheat(sbp, 0, pos, pos)
		end	
	end
	
	if ( player == nil ) then
  		return
	end	
	-- create the squad ( 0 in the param means create the whole squad )
	Squad_CreateAndSpawnTowardCheat( sbp, player, 0, pos, pos )
end

function TeleportSelected (useDespawn)
	print("------------()")

	local sg_temp = SGroup_Create( "sg_temp_TeleportSelected" )
	SGroup_Clear(sg_temp)
	Misc_GetSelectedSquads( sg_temp, false )
		
	if( SGroup_CountSpawned( sg_temp ) > 0) then
		local squad = SGroup_GetSpawnedSquadAt( sg_temp, 1 )
		
		-- LocalCommand_Squad requires a valid player even though it's not used
		if (World_OwnsSquad(squad) == false) then
			LocalCommand_Squad(
			Squad_GetPlayerOwner(squad),
			sg_temp,
			SCMD_Stop,
			false
		)
		end
		
		local pos = Misc_GetMouseOnTerrain()
		
		local function _WarpMe(gid, idx, sid)
			if( useDespawn ) then
				Squad_DeSpawn(sid)
				Squad_Spawn(sid, pos)
			else
				Squad_SetPosition(sid, pos, pos)
			end
		end
		
		SGroup_ForEach(sg_temp, _WarpMe)
	end
	
	SGroup_Destroy(sg_temp)
end

function TeleportTagged()
	local taggedEntity = Entity_GetDebugEntity()
	if taggedEntity ~= nil then
		Entity_SetPosition(taggedEntity, Misc_GetMouseOnTerrain())
	end
end

function RecreatePlayerSquads()
	local player = Game_GetLocalPlayer()
	if g_cheatmenu_spawn_as_enemy == true then
		local enemyplayer = Player_FindFirstEnemyPlayer(localplayer)
		if enemyplayer ~= nil then
			player = enemyplayer
		end
	end
	Squad_RecreateAll(player)
end

-----------------------------------------------------------------
-- Territory Helpers

function ConvertMouseoverTerritory(playerName)
	
	local player = Game_GetLocalPlayer()
	if playerName == "enemy" then
		player = Player_FindFirstEnemyPlayer(player)
	elseif playerName == "neutral" then
		player = Player_FindFirstNeutralPlayer(player)
	end

	local pos = Misc_GetMouseOnTerrain()
	
	local sector = Territory_FindClosestSectorToPoint(pos)
	local creator = Territory_GetSectorCreatorEntity(sector)
	if (creator == nil) then
		return
	end
	
	if player == nil then
		Entity_SetWorldOwned(creator)
	else
		Entity_SetPlayerOwner(creator, player)
	end
end

-----------------------------------------------------------------
-- DCA data debugging

--~ function DCA_GetGlobalActionLogging()
--~ 	return dca_get_actions_global()
--~ end

function DCA_GetMouseoverActionLogging()
	if not ( Misc_IsMouseOverEntity() ) then
		return 0
	end
	
	return dca_get_actions_entity( Misc_GetMouseOverEntity() )
end

--~ function DCA_SetGlobalActionLogging(param)
--~ 	dca_set_actions_global(param)
--~ end

function DCA_SetMouseoverActionLogging(param)
	if not ( Misc_IsMouseOverEntity() ) then
		return
	end
	
	return dca_set_actions_entity( Misc_GetMouseOverEntity(), param )
end

function DCA_ToggleActionsTracing()
	if not ( Misc_IsMouseOverEntity() ) then
		return 0
	end
	
	return dca_toggle_actions_tracing(Misc_GetMouseOverEntity())
end

function ApplyHealthPercentChange(entity, percent)
	local health_max = Entity_GetHealthMax( entity )
	local health_change = (percent / 100) * health_max	
	Entity_ApplyHealthChange(entity, health_change)
end

function ApplyHealthPercentMousedEntity(percent)
	if( Misc_IsMouseOverEntity() ) then
		local entityID = Misc_GetMouseOverEntity()
		ApplyHealthPercentChange(entityID, percent)
	end
end

function BurnMouseOverEntity()
	if (Misc_IsMouseOverEntity()) then
		Entity_SetOnFire(Misc_GetMouseOverEntity())
	end
end
	
g_DoDamageOnWeaponHit = false
g_applySimPenetrateOrDeflectActionsOnWeaponHit = true
g_useHorizontalDirectionOnWeaponHit = true

function WeaponHitMousedEntity( weaponbp, penetrated )

	if ( Misc_IsMouseOverEntity() == false) then
		-- get mouse over position
		local pos = Misc_GetMouseOnTerrain()
		Misc_DoWeaponHitEffectOnPosition( pos, weaponbp, penetrated )
		
	else
		-- get mouse over entity
		local entityid = Misc_GetMouseOverEntity()
		local pos = Misc_GetMouseOnTerrain()
		
		if g_DoDamageOnWeaponHit then
			ApplyHealthPercentChange(entityid, -10)
		end
		
		Misc_DoWeaponHitEffectOnEntity( entityid, pos, weaponbp, penetrated, g_useHorizontalDirectionOnWeaponHit, g_applySimPenetrateOrDeflectActionsOnWeaponHit)
	end
	
end

local screenshotMode = false
function ToggleScreenshotMode( on )

	function turn_ui_off()
	
		turn_off_warnings()

		FOW_RevealAll()

		gamehideallui()
		taskbar_hide()

		showbuildnumber(false)
		dr_setdisplay("obsolete_objectivetext", false)
		statgraph_show_budgets(false)
		
		screenshotMode = true
	end

	function turn_ui_on()
	
		FOW_UnRevealAll()

		gameshowallui()
		taskbar_show()

		showbuildnumber(true)
		dr_setdisplay("obsolete_objectivetext", true)
		statgraph_show_budgets(true)

		screenshotMode = false
	end
	
	if ( on == nil ) then
		if ( screenshotMode == false ) then
			turn_ui_off()
		else
			turn_ui_on()
		end
	else 
		if ( on == true ) then
			turn_ui_on()
		elseif ( on == false ) then
			turn_ui_off()
		end
	end
end


function ChangeEntityOwnerToLocal()
	local local_player_id = getlocalplayer()
		
	-- get player from id
	local player = Player_FromId(local_player_id)
	
	if (Misc_IsMouseOverEntity()) then
		local entity = Misc_GetMouseOverEntity()
		if(entity ~= 0) then
			Entity_SetPlayerOwner(entity, player)
		end
	end
end

function ChangeEntityOwnerToWorld()
	
	if (Misc_IsMouseOverEntity()) then
		local entity = Misc_GetMouseOverEntity()
		if(entity ~= 0) then
			Entity_SetWorldOwned(entity)
		end
	end
end

function ChangeEntityOwnerToEnemy()
	local localplayer = Game_GetLocalPlayer()
	local enemyplayer = Player_FindFirstEnemyPlayer(localplayer)
	
	if (Misc_IsMouseOverEntity()) then
		local entity = Misc_GetMouseOverEntity()
		if(entity ~= 0) then
			Entity_SetPlayerOwner(entity, enemyplayer)
		end
	end
end

-- bind a key to the toggle function
bind( "Control+Shift+Slash", "ToggleScreenshotMode()" )

function CallSetCampaignPersonality(filename)
	-- strip the directory and .scar to just leave the filename
	local remove_path = string.gsub(filename, "[%w_]*:", "")
	remove_path = string.gsub(remove_path, "[%w_]*\\", "")
	remove_path = string.gsub(remove_path, "[%w_]*/", "")
	local remove_extension = string.gsub(remove_path, ".scar", "")
	
	local playerID = AI_GetDebugAIPlayerID()
	if not Player_IsValid(playerID) then
		AI_ToggleDebugAIPlayer()
		playerID = AI_GetDebugAIPlayerID()
	end
	
	Scar_DoString("MetaMap_SetCampaignAIPlayerPersonality("..playerID..", '".. remove_extension.."')") 
end

function GetCampaignAIPersonalitySubMenu()
	local names = Misc_QueryDataDirectory("scar/ai/campaign_personalities/*", false)
	
	local submenu = {}
	for i, name in ipairs(names) do
		table.insert(submenu, newelement(name, "", "CallSetCampaignPersonality([["..name.."]])" ))
	end
	
	return submenu	
end

function ResetActionPoints()
	local sg_temp = SGroup_Create( "sg_temp_ResetActionPoints" )
	SGroup_Clear(sg_temp)
	Misc_GetSelectedSquads( sg_temp, false )
		
	local count = SGroup_CountSpawned( sg_temp ) 
	if( count > 0) then
		for i = 1, count do
			local squad = SGroup_GetSpawnedSquadAt( sg_temp, i )
			Squad_ResetActionPoints(squad)
		end
	end
	SGroup_Destroy(sg_temp)
end

function ResetMovementPoints()
	local sg_temp = SGroup_Create( "sg_temp_ResetMovementPoints" )
	SGroup_Clear(sg_temp)
	Misc_GetSelectedSquads( sg_temp, false )
		
	local count = SGroup_CountSpawned( sg_temp ) 
	if( count > 0) then
		for i = 1, count do
			local squad = SGroup_GetSpawnedSquadAt( sg_temp, i )
			Squad_ResetMovementPoints(squad)
		end
	end
	SGroup_Destroy(sg_temp)
end


function Cheat_GiveSquadSkillPoints(numSkillPoints)
	if Misc_IsMouseOverSquad() then
		local squad = Misc_GetMouseOverSquad()
		Squad_SetResource(squad, RT_Requisition, Squad_GetResource(squad, RT_Requisition) + numSkillPoints)
	end
end

function ToggleDebugBackgroundOpacity()
	dr_toggleBackgroundOpacity()
end


function ReduceDebugFontScale()
	dr_reduceDebugFontScale()
end

function IncreaseDebugFontScale()
	dr_increaseDebugFontScale()
end
