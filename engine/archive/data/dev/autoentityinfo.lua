

--------------------------------------------------------------------------------
 -- This file contains:
  
  -- AddSquadSelectionInfo()
    -- prints out info on the current squad selection and mouse over entity
--------------------------------------------------------------------------------

-- draws a line onto the screen - then increment the y-line cursor
function drawLine( text )
	dr_text2d( "temp_dr", 0.05, g_lasty, text, 255, 200, 255 )
	g_lasty = g_lasty + 0.05
end

-- show some info onscreen in regards to the given entity
function showEInfo( entityID )
	local health = Entity_GetHealth( entityID )
	local healthMax = Entity_GetHealthMax( entityID )
	local eID = Entity_GetID( entityID )
	
	local estr = "ID"..eID.." Hlt"..health.."/"..healthMax
	
	drawLine( estr )
	
end

rawset( _G, "IntersectionPoint", 0 )


function IntersectionPoint( origin, endPt )
	
	local dirVec = Vector_Normalize( World_Pos( endPt.x-origin.x, endPt.y-origin.y, endPt.z-origin.z ) )
	
	local intersectPt = World_Intersect( origin, dirVec )
	
	dr_terraincircle( intersectPt, 1, 200, 100, 200, 5, "temp_dr" )
	
	return intersectPt
	
end

-- draw a single spoke of the lamp shade
function lampshade_spoke( pos, topradius, bottomradius, topheight, bottomheight, angle )

	---------------------------------------------------
	-- draw line from center to top-side
	local center = World_Pos( pos.x, pos.y, pos.z )
	center.y = center.y + topheight

	local topside = World_Pos( pos.x, pos.y, pos.z )
	topside.x = topside.x + topradius*math.cos( angle )
	topside.z = topside.z + topradius*math.sin( angle )
	topside.y = topside.y + topheight
	dr_drawline( center, topside, 255,255,255 )
	
	-- from topside to bottomside
	local bottomside = World_Pos( pos.x, pos.y, pos.z )
	bottomside.x = bottomside.x + bottomradius*math.cos( angle )
	bottomside.z = bottomside.z + bottomradius*math.sin( angle )
	bottomside.y = bottomside.y + bottomheight
	local ipos = IntersectionPoint( topside, bottomside )
	dr_drawline( topside, ipos, 255,255,255 )
	dr_drawline( ipos, bottomside, 128,128,128 )

end

rawset( _G, "showSightPackage", 0 )

function showSightPackage( entityID )

	local pos = Entity_GetPosition( entityID )
	local innerradius = Entity_GetSightInnerRadius( entityID )
	local outerradius = Entity_GetSightOuterRadius( entityID )
	local innerheight = Entity_GetSightInnerHeight( entityID )
	local outerheight = Entity_GetSightOuterHeight( entityID )
	
	for i=0,7 do
		lampshade_spoke( pos, innerradius, outerradius, innerheight, outerheight, i/4*math.pi )
	end
	
	pos.y = pos.y + innerheight

	dr_terraincircle( pos, innerradius, 255, 255, 255, 6 )
	dr_terraincircle( pos, outerradius, 0, 0, 255, 16 )

end

rawset( _G, "showSInfo", 0 )

-- go through each entity in a squad and print out its info
function showSInfo( sgroupid, itemindex, squadID )
	
	dr_clear("test_draw")
	
	local eCount = Squad_Count( squadID )
	for i=0, eCount-1
	do
		local entityID = Squad_EntityAt( squadID, i )
		if (entityID) then
			showEInfo( entityID )
		end
		if (entityID and i==0) then
			showSightPackage( entityID )
		end
	end
	
	return 1
	
end

rawset( _G, "UpdateEntityInfo", 0 )

UpdateEntityInfo = function()
	
	dr_clear( "temp_dr" );
	dr_clear( "TerrainLine" );
	g_lasty = 0.1
	
	if (Misc_IsMouseOverEntity()) then
		local eID = Misc_GetMouseOverEntity()
		if (eID) then
			drawLine("-MouseOver-")
			showEInfo( eID );
		end
	end
	
	Misc_GetSelectedSquads( tempgroupID )
	
	if (SGroup_Count( tempgroupID ) > 0) then
		drawLine("-Selected-")
		SGroup_ForEach( tempgroupID, showSInfo )
	end
end

s_fowInfoMode = 0

rawset(_G,"toggle_fow_info",nil)

-- creates a temporary SGroup for holding onto the squads we select
function toggle_fow_info()

	if (s_fowInfoMode==0) then
		if (not SGroup_Exists("temp_shelby")) then
			print("creating temp squad group")
			tempgroupID = SGroup_Create("temp_shelby")
		end

		-- creates some frames to draw onto
		dr_setautoclear("temp_dr",0)
		dr_setdisplay("temp_dr",1)
		dr_setautoclear( "TerrainLine", 0 );
		
		-- delete first and then re-add
		timer_del("UpdateEntityInfo")
		timer_gameadd("UpdateEntityInfo", 0.5)
		
		s_fowInfoMode = 1
	else
		dr_clear( "temp_dr" );
		dr_clear( "TerrainLine" );
		timer_del("UpdateEntityInfo")
		s_fowInfoMode = 0
	end
	
	

end

