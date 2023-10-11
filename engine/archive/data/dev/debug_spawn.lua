
function DeleteWorldObjects()
	
	local count = World_GetNumEntities()
	
	print(count)
	
	for i=0,(count-1) do
		local entityid = World_GetEntity( i )
		
		if (World_OwnsEntity( entityid ) == true) then
			Entity_Destroy( entityid )
		end
		
	end
end

function DeleteAllObjects()
	
	local count = World_GetNumEntities()
	
	print(count)
	
	for i=0,(count-1) do
		local entityid = World_GetEntity( i )
		
		Entity_Destroy( entityid )
	end
end

g_xoffset = 45
g_zoffset = 45

function CreateENVObjects( filter )
	
	print( "CreateENVObjects") 
	
	filter = string.lower(filter)
	
	-- delete all previous world objects on map first
	DeleteWorldObjects()
	
	local count = World_GetEnviroCount()-1
	local pos = World_Pos(0, 0, 0)
	local z_extents = World_GetLength()/2
	local x_extents = World_GetWidth()/2
	print("xmax:"..x_extents.." zmax:"..z_extents)
	pos.z = -z_extents + g_zoffset
	pos.x = -x_extents + g_xoffset
	
	print("posx:"..pos.x.." posz:"..pos.z)
	
	for i = 0, count do
		local blueprint = World_GetEnviroName(i)
		
		
		
		blueprint = string.lower(blueprint)
		
		local a,b = string.find( blueprint, filter )
		
		-- only allow certain types of entities on the list
		if ( b ~= nil ) then
			
			local ebp = BP_GetEntityBlueprint( blueprint )
			local pEntity = Entity_CreateENV( ebp, pos, World_Pos(0, 0, 0) )
			pos.z = pos.z + g_zoffset;
			if (pos.z > z_extents or pos.z < -z_extents) then
				-- move in x direction
				pos.x = pos.x + g_xoffset
				-- reset z
				pos.z = -z_extents + g_zoffset
				
				print("spawning...".. blueprint.." at "..pos.x..","..pos.z)
			end
		end
		
		
	end
	
end



function LogWorldObjects()

	-- get all the VP points
	local count = World_GetNumEntities()
	
	local ebps = {}
		
	for i=0,(count-1) do
		local entityid = World_GetEntity( i )
		
		table.insert( ebps, BP_GetName( Entity_GetBlueprint( entityid ) ) )
	end

	table.sort( ebps )	
	
	local file = io.open( "worldobjects.txt", "wt" )
	local laststr = ""
	
	for i=1, (# ebps ) do
		
		if (laststr ~= ebps[i]) then
			file:write( ebps[i] .. "\n" )
			laststr = ebps[i]
		end
	end

end