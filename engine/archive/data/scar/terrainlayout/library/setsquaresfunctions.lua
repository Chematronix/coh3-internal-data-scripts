-- this script contains functions for setting squares in the coarse map

-- sets all squares in coarse map to tt_none based on the coarse grid resolution and fills it with the designated terrain type
function SetUpGrid(gridSize, terrainForSquare, coarseMapGrid)
	
	-- error checking
	if (gridSize < 1) then
		print("ERROR: Grid size less than 1. Setting grid size to 2.")
		gridSize = 2
	end
	
	if (terrainForSquare == nil) then
		print("ERROR: No terrain type specified. Setting terrain type to none.")
		terrainForSquare = -1
	end
	
	if (coarseMapGrid == nil) then
		print("ERROR: coarseMapGrid is nil. Setting coarseMapGrid to {}")
		coarseMapGrid = {}
	end
	
	-- setting up coarse map grid
	for row = 1,gridSize do
		coarseMapGrid[row] = {}
		
		for column = 1, gridSize do
			coarseMapGrid[row][column] = {}
			coarseMapGrid[row][column].terrainType = terrainForSquare
		end
		
	end
	
	return coarseMapGrid
	
end

-- this function will search each square in the terrain grid passed in and 
-- check if it is set to the terrain type designated as random (terrainToReplace)
-- when it finds a square designated as random it will change it to one of the terrain types from the 
-- list that is passed in (terrainTypes)
-- make sure the coarse map grid is set up correctly before running this
function RandomTerrainSwap(terrainTypesList, terrainToReplace, coarseGridLayout)
	
	coarseGridSize = (#coarseGridLayout)
	print("Coarse Grid Size is " ..coarseGridSize)
	print(" There are " ..(#terrainTypesList) .." terrain types")
	
	-- search through each square in the grid looking for the terrain type designated as random (terrain to replace)
	for row = 1, coarseGridSize do
		for column = 1, coarseGridSize do
			
			if (terrainLayoutResult[row][column].terrainType == terrainToReplace) then
				print("Found square set to random at " .. row ..", " ..column)
				terrainLayoutResult[row][column].terrainType = GetRandomElement(terrainTypesList)
			else
				print("Square " ..row ..", " ..column .." is not random")
			end
		
		end
		
	end
	
	return coarseGridLayout
	
end