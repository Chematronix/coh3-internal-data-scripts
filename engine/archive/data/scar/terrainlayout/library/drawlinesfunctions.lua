-- this script contains functions for placing lines of terrain types across the map

-- creates a line of designated terrain from the designated starting row and column on the coarse map to the edge
-- weighted to attempt to keep the map evenly divided
-- wieght power increases the weight bending the line up or down
-- edge limit is the how close (in squares) the line can get to the top or bottom of the map
function DrawLineToLeftEdge(theRow, theCol, terrainForSquare, coarseGridSize, weightPower, edgeLimit)
	
	-- error checking
	if (coarseGridSize < 1) then
		print("ERROR: Invalid grid size. Grid must be at least one square. Aborting function.")
		return
	end
	
	if (theRow < 1) then
		print("ERROR: Start row is less than one. Coarse grid rows start at 1. Start row will be set to 1")
		theRow = 1
	elseif (theRow > coarseGridSize) then
		print("ERROR: Start row is greater than the grid size value passed in and will fall outside the coarse grid. Setting row to grid size")
		theRow = coarseGridSize
	end
	
	if (theCol < 1) then
		print("ERROR: Start column is less than one. Coarse grid rows start at 1. Start row will be set to 1")
		theCol = 1
	elseif (theCol > coarseGridSize) then
		print("ERROR: Start column is greater than the grid size value passed in and will fall outside the coarse grid. Setting column to grid size")
		theCol = coarseGridSize
	end
	
	if (weightPower < 1) then
		print("ERROR: weight power must be greater than 0. Setting weight power to 1.")
	end
	
	if (edgeLimit < 0) then
		print("ERROR: edge limit must be 0 or greater. Setting edge limit to 0.")
		edgeLimit = 0
	elseif (edgeLimit > Round(coarseGridSize / 2, 0)) then
		print("ERROR: edge limit is greater than half the grid size (no room to place terrain). Edge Limit wil be set to grid size / 2 - 1.")
		edgeLimit = Round(coarseGridSize / 2, 0) - 1
	end
	
	-- draw the line
	adjustedRow = theRow
	weightUp = (theRow / Round(coarseGridSize/2, 0)) ^ weightPower / 2 * 0.5
	weightDown = weightUp + ((((coarseGridSize - theRow) + 1) / ((coarseGridSize - Round(coarseGridSize/2, 0)) + 1)) ^ weightPower / 2 * 0.5)
	print ("Weight up = " ..weightUp ..", WeightDown = " ..weightDown)
	
	while (theCol > 1) do
		theCol = theCol - 1
		
		if (theCol < 1) then
			theCol = 1
		end
		
		roll = worldGetRandom()
		
		if (roll < weightUp) then
			print("Left: Roll " ..roll .." = UP")
			adjustedRow = adjustedRow - 1
			
			if (adjustedRow < edgeLimit) then
				adjustedRow = adjustedRow + 1
			end
			
		elseif (roll > weightUp and roll < weightDown) then
			print("Left: Roll " ..roll .." = DOWN")
			adjustedRow = adjustedRow + 1
			
			if (adjustedRow > coarseGridSize - edgeLimit) then
				adjustedRow = adjustedRow - 1
			end
			
		else
			print("Left: Roll " ..roll .." = SAME")
			adjustedRow = adjustedRow
			
		end
		
		terrainLayoutResult[adjustedRow][theCol].terrainType = terrainForSquare
	end
end

-- creates a line of designated terrain from the designated starting row and column on the coarse map to the edge
-- weighted to attempt to keep the map evenly divided
-- wieght power increases the strength of the weighting to bend the line for evening play space.
-- edge limit is the how close (in squares) the line can get to the top or bottom of the map
function DrawLineToRightEdge(theRow, theCol, terrainForSquare, coarseGridSize, weightPower, edgeLimit)
	
	-- error checking
	if (coarseGridSize < 1) then
		print("ERROR: Invalid grid size. Grid must be at least one square. Aborting function.")
		return
	end
	
	if (theRow < 1) then
		print("ERROR: Start row is less than one. Coarse grid rows start at 1. Start row will be set to 1")
		theRow = 1
	elseif (theRow > coarseGridSize) then
		print("ERROR: Start row is greater than the grid size value passed in and will fall outside the coarse grid. Setting row to grid size")
		theRow = coarseGridSize
	end
	
	if (theCol < 1) then
		print("ERROR: Start column is less than one. Coarse grid rows start at 1. Start row will be set to 1")
		theCol = 1
	elseif (theCol > coarseGridSize) then
		print("ERROR: Start column is greater than the grid size value passed in and will fall outside the coarse grid. Setting column to grid size")
		theCol = coarseGridSize
	end
	
	if (weightPower < 1) then
		print("ERROR: weight power must be greater than 0. Setting weight power to 1.")
	end
	
	if (edgeLimit < 0) then
		print("ERROR: edge limit must be 0 or greater. Setting edge limit to 0.")
		edgeLimit = 0
	elseif (edgeLimit > Round(coarseGridSize / 2, 0)) then
		print("ERROR: edge limit is greater than half the grid size (no room to place terrain). Edge Limit wil be set to grid size / 2 - 1.")
		edgeLimit = Round(coarseGridSize / 2, 0) - 1
	end
	
	-- draw the line
	adjustedRow = theRow
	weightUp = (theRow / Round(coarseGridSize/2, 0)) ^ weightPower / 2 * 0.5
	weightDown = weightUp + ((((coarseGridSize - theRow) + 1) / ((coarseGridSize - Round(coarseGridSize/2, 0)) + 1)) ^ weightPower / 2 * 0.5)
	
	while (theCol < coarseGridSize) do
		theCol = theCol + 1
		if (theCol > coarseGridSize) then
			theCol = coarseGridSize
		end
		
		roll = worldGetRandom()
		
		if (roll < weightUp) then
			print("Right: Roll " ..roll .." = UP")
			adjustedRow = adjustedRow - 1
			
			if (adjustedRow < edgeLimit) then
				adjustedRow = adjustedRow + 1
			end
			
		elseif (roll > weightUp and roll < weightDown) then
			print("Right: Roll " ..roll .." = DOWN")
			adjustedRow = adjustedRow + 1
			
			if (adjustedRow > coarseGridSize - edgeLimit) then
				adjustedRow = adjustedRow - 1
			end
			
		else
			print("Right: Roll " ..roll .." = SAME")
			adjustedRow = adjustedRow
		end
		
		terrainLayoutResult[adjustedRow][theCol].terrainType = terrainForSquare
	end
end

-- creates a line of designated terrain between the two designated points
-- set meander to true for the line to deviate from a straight connection of the points
-- when set to meander, a mid point keeps the line from forming extreme "L" shapes
-- grid size is only used to ensure the start and end points are inside hte coarse map grid
function DrawLineOfTerrain(startRow, startColumn, endRow, endColumn, terrainForSquare, meander, gridSize)

	-- error checking
	if (startRow < 1) then
		print("ERROR: startRow is less than 1 and is off the coarse map. Setting startRow to 1.")
		startRow = 1
	elseif (startRow > gridSize) then
		print("ERROR: startRow is greater than gridSize and is off the coarse map. Setting startRow to gridSize.")
		startRow = gridSize
	end
	
	if (startColumn < 1) then
		print("ERROR: startColumn is less than 1 and is off the coarse map. Setting startColumn to 1.")
		startColumn = 1
	elseif (startColumn > gridSize) then
		print("ERROR: startColumn is greater than gridSize and is off the coarse map. Setting startColumn to gridSize.")
		startColumn = gridSize
	end
	
	if (endRow < 1) then
		print("ERROR: endRow is less than 1 and is off the coarse map. Setting endRow to 1.")
		endRow = 1
	elseif (endRow > gridSize) then
		print("ERROR: endRow is greater than gridSize and is off the coarse map. Setting endRow to gridSize.")
		endRow = gridSize
	end
	
	if (endColumn < 1) then
		print("ERROR: endColumn is less than 1 and is off the coarse map. Setting endColumn to 1.")
		endColumn = 1
	elseif (endColumn > gridSize) then
		print("ERROR: endColumn is greater than endColumn and is off the coarse map. Setting endColumn to gridSize.")
		endColumn = gridSize
	end
	
	if (terrainForSquare == nil) then
		print("ERROR: Invalid terrain type. Aborting DrawLineOfTerrainFunction.")
		return
	end
	
	currentRow = startRow
	currentColumn = startColumn
	
	midRow = startRow - Round((startRow - endRow) / 2, 0)
	midColumn = startColumn - Round((startColumn - endColumn) / 2, 0) 
	
	print(midRow, midColumn)
	
	meanderValue = 2
	
	if (meander) then
		meanderValue = 0.5
	end
	
	print("Start = " .. startRow .." Mid = " ..midRow .." End = " ..endRow)
	
	terrainLayoutResult[currentRow][currentColumn].terrainType = terrainForSquare
	
	targetRow = midRow
	targetColumn = midColumn
	
	for i = 0, 1 do
	
		while (currentRow ~= targetRow or currentColumn ~= targetColumn) do
		
			
			if (currentRow < targetRow) then
				
				if (worldGetRandom() < meanderValue) then
					currentRow = currentRow + 1
				end
				
			elseif (currentRow > targetRow) then
				
				if (worldGetRandom() < meanderValue) then
					currentRow = currentRow - 1
				end
				
			end
			
			if (currentColumn < targetColumn) then
				
				if (worldGetRandom() < meanderValue) then
					currentColumn = currentColumn + 1
				end
				
			elseif (currentColumn > targetColumn) then
				
				if (worldGetRandom() < meanderValue) then
					currentColumn = currentColumn - 1
				end
				
			end
			
			print("Inside while setting terrainLayoutResult square, row = " ..currentRow ..", column " ..currentColumn)
			if(IsInMap (currentRow, currentColumn, gridSize, gridSize)) then
				terrainLayoutResult[currentRow][currentColumn].terrainType = terrainForSquare
			else
				if(currentRow > gridSize) then
					currentRow = gridSize
				end
				
				if(currentColumn > gridSize) then
					currentColumn = gridSize
				end
				
				if(currentRow < 1) then
					currentRow = 1
				end
				
				if(currentColumn < 1) then
					currentColumn = 1
				end
				
				terrainLayoutResult[currentRow][currentColumn].terrainType = terrainForSquare
			end
		
		end
		
		targetRow = endRow
		targetColumn = endColumn
	
	end

end

-- identical to DrawLineOfTerrain but returns the points // used primarily for river tribs
function DrawLineOfTerrainReturn(startRow, startColumn, endRow, endColumn, terrainForSquare, meander, gridSize)
	
	linePointsTable = {}
	
	-- error checking
	if (startRow < 1) then
		print("ERROR: startRow is less than 1 and is off the coarse map. Setting startRow to 1.")
		startRow = 1
	elseif (startRow > gridSize) then
		print("ERROR: startRow is greater than gridSize and is off the coarse map. Setting startRow to gridSize.")
		startRow = gridSize
	end
	
	if (startColumn < 1) then
		print("ERROR: startColumn is less than 1 and is off the coarse map. Setting startColumn to 1.")
		startColumn = 1
	elseif (startColumn > gridSize) then
		print("ERROR: startColumn is greater than gridSize and is off the coarse map. Setting startColumn to gridSize.")
		startColumn = gridSize
	end
	
	if (endRow < 1) then
		print("ERROR: endRow is less than 1 and is off the coarse map. Setting endRow to 1.")
		endRow = 1
	elseif (endRow > gridSize) then
		print("ERROR: endRow is greater than gridSize and is off the coarse map. Setting endRow to gridSize.")
		endRow = gridSize
	end
	
	if (endColumn < 1) then
		print("ERROR: endColumn is less than 1 and is off the coarse map. Setting endColumn to 1.")
		endColumn = 1
	elseif (endColumn > gridSize) then
		print("ERROR: endColumn is greater than endColumn and is off the coarse map. Setting endColumn to gridSize.")
		endColumn = gridSize
	end
	
	if (terrainForSquare == nil) then
		print("ERROR: Invalid terrain type. Aborting DrawLineOfTerrainFunction.")
		return
	end
	
	currentRow = startRow
	currentColumn = startColumn
	
	midRow = startRow - Round((startRow - endRow) / 2, 0)
	midColumn = startColumn - Round((startColumn - endColumn) / 2, 0) 
	
	print(midRow, midColumn)
	
	meanderValue = 2
	
	if (meander) then
		meanderValue = 0.5
	end
	
	print("Start = " .. startRow .." Mid = " ..midRow .." End = " ..endRow)
	
	targetRow = midRow
	targetColumn = midColumn
	
	currentData = {}
	currentData = {currentRow, currentColumn}
	if(Table_ContainsCoordinateIndex(linePointsTable, currentData)) == false then
			table.insert(linePointsTable, currentData)
	end
	
	for i = 0, 1 do
	
		while (currentRow ~= targetRow or currentColumn ~= targetColumn) do
		
			
			if (currentRow < targetRow) then
				
				if (worldGetRandom() < meanderValue) then
					currentRow = currentRow + 1
				end
				
			elseif (currentRow > targetRow) then
				
				if (worldGetRandom() < meanderValue) then
					currentRow = currentRow - 1
				end
				
			end
			
			if (currentColumn < targetColumn) then
				
				if (worldGetRandom() < meanderValue) then
					currentColumn = currentColumn + 1
				end
				
			elseif (currentColumn > targetColumn) then
				
				if (worldGetRandom() < meanderValue) then
					currentColumn = currentColumn - 1
				end
				
			end
			
			print("Inside while setting terrainLayoutResult square, row = " ..currentRow ..", column " ..currentColumn)
			if(IsInMap (currentRow, currentColumn, gridSize, gridSize)) then
				terrainLayoutResult[currentRow][currentColumn].terrainType = terrainForSquare
				currentData = {}
				currentData = {currentRow, currentColumn}
				if(Table_ContainsCoordinateIndex(linePointsTable, currentData)) == false then
					table.insert(linePointsTable, currentData)
				end
			else
				if(currentRow > gridSize) then
					currentRow = gridSize
				end
				
				if(currentColumn > gridSize) then
					currentColumn = gridSize
				end
				
				if(currentRow < 1) then
					currentRow = 1
				end
				
				if(currentColumn < 1) then
					currentColumn = 1
				end
				
				terrainLayoutResult[currentRow][currentColumn].terrainType = terrainForSquare
				currentData = {}
				currentData = {currentRow, currentColumn}
				if(Table_ContainsCoordinateIndex(linePointsTable, currentData)) == false then
					table.insert(linePointsTable, currentData)
				end
			end
		
		end
		
		targetRow = endRow
		targetColumn = endColumn
	
	end
	
	return linePointsTable

end

-- creates a line of designated terrain between the two designated points while excluding designated terrain types
-- terrain exclusions is a list of terrain types to check when drawing 
-- if the square in question is in the list the line will continue, but not change the exluded square
-- set meander to true for the line to deviate from a straight connection of the points
-- when set to meander, a mid point keeps the line from forming extreme "L" shapes
-- grid size is only used to ensure the start and end points are inside hte coarse map grid
function DrawLineOfTerrainExlusive(startRow, startColumn, endRow, endColumn, terrainForSquare, terrainExclusions, meander, gridSize)
	
	-- error checking
	if (type(terrainExclusions) ~= "table") then
		print("ERROR: terrain exclusions must be a table")
	end
	if (startRow < 1) then
		print("ERROR: startRow is less than 1 and is off the coarse map. Setting startRow to 1.")
		startRow = 1
	elseif (startRow > gridSize) then
		print("ERROR: startRow is greater than gridSize and is off the coarse map. Setting startRow to gridSize.")
		startRow = gridSize
	end
	
	if (startColumn < 1) then
		print("ERROR: startColumn is less than 1 and is off the coarse map. Setting startColumn to 1.")
		startColumn = 1
	elseif (startColumn > gridSize) then
		print("ERROR: startColumn is greater than gridSize and is off the coarse map. Setting startColumn to gridSize.")
		startColumn = gridSize
	end
	
	if (endRow < 1) then
		print("ERROR: endRow is less than 1 and is off the coarse map. Setting endRow to 1.")
		endRow = 1
	elseif (startRow > gridSize) then
		print("ERROR: endRow is greater than gridSize and is off the coarse map. Setting endRow to gridSize.")
		endRow = gridSize
	end
	
	if (endColumn < 1) then
		print("ERROR: endColumn is less than 1 and is off the coarse map. Setting endColumn to 1.")
		endColumn = 1
	elseif (endColumn > gridSize) then
		print("ERROR: endColumn is greater than endColumn and is off the coarse map. Setting endColumn to gridSize.")
		endColumn = gridSize
	end
	
	if (terrainForSquare == nil) then
		print("ERROR: Invalid terrain type. Aborting DrawLineOfTerrainFunction.")
		return
	end
	
	linePoints = {}
	currentRow = startRow
	currentColumn = startColumn
	
	midRow = startRow - Round((startRow - endRow) / 2, 0)
	midColumn = startColumn - Round((startColumn - endColumn) / 2, 0) 
	
	print(midRow, midColumn)
	
	meanderValue = 2
	
	if (meander) then
		meanderValue = 0.5
	end
	
	print("Start = " .. startRow .." Mid = " ..midRow .." End = " ..endRow)
	
	placeTerrain = true
	for index = 1, #terrainExclusions do
		
		if(terrainLayoutResult[currentRow][currentColumn].terrainType == terrainExclusions[index]) then
			placeTerrain = false
		end

	end
	
	if(placeTerrain == true) then
		terrainLayoutResult[currentRow][currentColumn].terrainType = terrainForSquare
		-- add square to line list
		table.insert(linePoints, #linePoints + 1, {currentRow, currentColumn})
	end
	
	targetRow = midRow
	targetColumn = midColumn
	
	for i = 0, 1 do
	
		while (currentRow ~= targetRow or currentColumn ~= targetColumn) do
		
			
			if (currentRow < targetRow) then
				
				if (worldGetRandom() < meanderValue) then
					currentRow = currentRow + 1
				end
				
			elseif (currentRow > targetRow) then
				
				if (worldGetRandom() < meanderValue) then
					currentRow = currentRow - 1
				end
				
			end
			
			if (currentColumn < targetColumn) then
				
				if (worldGetRandom() < meanderValue) then
					currentColumn = currentColumn + 1
				end
				
			elseif (currentColumn > targetColumn) then
				
				if (worldGetRandom() < meanderValue) then
					currentColumn = currentColumn - 1
				end
				
			end
			
			print("Inside while setting terrainLayoutResult square, row = " ..currentRow ..", column " ..currentColumn)
			placeTerrain = true
			for index = 1, #terrainExclusions do
				
				if(terrainLayoutResult[currentRow][currentColumn].terrainType == terrainExclusions[index]) then
					placeTerrain = false
				end
	
			end
			
			if(placeTerrain == true) then
				-- add square to line list
				table.insert(linePoints, #linePoints + 1, {currentRow, currentColumn})
				terrainLayoutResult[currentRow][currentColumn].terrainType = terrainForSquare
			end
		
		end
		
		targetRow = endRow
		targetColumn = endColumn
	
	end

	-- return the table of line points (table ordered from start of line to end)
	return linePoints
	
end

--- Draw Line of Terrain No Neighbors
-- draws as direct a line as possible to the end coordinates while attempting to avoid more than one entry and exit square along the line
-- used primarily for rivers
function DrawLineOfTerrainNoNeighbors(startRow, startColumn, endRow, endColumn, placeTerrain, terrainForSquare, gridSize, terrainGrid)
	print("DRAW LINE OF TERRAIN NO NEIGHBORS")
	-- error checking
	if (startRow < 1) then
		print("ERROR: startRow is less than 1 and is off the coarse map. Setting startRow to 1.")
		startRow = 1
	elseif (startRow > gridSize) then
		print("ERROR: startRow is greater than gridSize and is off the coarse map. Setting startRow to gridSize.")
		startRow = gridSize
	end
	
	if (startColumn < 1) then
		print("ERROR: startColumn is less than 1 and is off the coarse map. Setting startColumn to 1.")
		startColumn = 1
	elseif (startColumn > gridSize) then
		print("ERROR: startColumn is greater than gridSize and is off the coarse map. Setting startColumn to gridSize.")
		startColumn = gridSize
	end
	
	if (endRow < 1) then
		print("ERROR: endRow is less than 1 and is off the coarse map. Setting endRow to 1.")
		endRow = 1
	elseif (startRow > gridSize) then
		print("ERROR: endRow is greater than gridSize and is off the coarse map. Setting endRow to gridSize.")
		endRow = gridSize
	end
	
	if (endColumn < 1) then
		print("ERROR: endColumn is less than 1 and is off the coarse map. Setting endColumn to 1.")
		endColumn = 1
	elseif (endColumn > gridSize) then
		print("ERROR: endColumn is greater than endColumn and is off the coarse map. Setting endColumn to gridSize.")
		endColumn = gridSize
	end
	
	if (terrainForSquare == nil) then
		print("ERROR: Invalid terrain type. Aborting DrawLineOfTerrainFunction.")
		return
	end
	-- end error checking

	linePoints = {}
	currentRow = startRow
	currentColumn = startColumn
	closestIndex = 0
	
	lineDistance = Round(math.sqrt((endRow - startRow)^2 + (endColumn - startColumn)^2),0)
	print("Total Line distance is " ..lineDistance)
	loopCount = 0

	table.insert(linePoints, 1, {startRow, startColumn})

	if (lineDistance > -1) then

		while ((currentRow ~= endRow or currentColumn ~= endColumn) and loopCount < 99) do		
			
			potentialSquares = {}
			potentialSquares = GetAllSquaresInRingAroundSquare(currentRow, currentColumn, 1, 1, terrainGrid)
			print("There are " ..#potentialSquares .." potential squares")
			closestDistance = 1000000			
			allowedNeighbors = 1
			closestSquareFound = false
			while(closestSquareFound == false and #potentialSquares > 0) do
				print(#potentialSquares .." potential squares remaining...")
				for index = 1, #potentialSquares do
					row = potentialSquares[index][1]
					column = potentialSquares[index][2]
					
					euclidianDistance = math.sqrt((endRow - row)^2 + (endColumn - column)^2)

					if (euclidianDistance < closestDistance) then
						closestDistance = euclidianDistance
						closestIndex = index
						print("Current closest square is at row " ..row .." column " ..column .." at distance of " ..euclidianDistance)
					else
						print("Square is at row " ..row .." column " ..column .." at distance of " ..euclidianDistance)
					end
					
				end
				
				terrain = {terrainForSquare}
				neighborSquares = GetAllSquaresOfTypeInRingAroundSquare(potentialSquares[closestIndex][1], potentialSquares[closestIndex][2], 1, 1, terrain, terrainGrid)
				
				distanceFromEnd = math.floor(math.sqrt((endRow - potentialSquares[closestIndex][1])^2 + (endColumn - potentialSquares[closestIndex][2])^2))
				
				if(math.floor(distanceFromEnd) <= 1) then
					print("One square from end point. Setting neighbors allowed to 2")
					allowedNeighbors = 2
				end
				
				if (#neighborSquares > allowedNeighbors) then
					print(#neighborSquares .." neighbours. Too many. Rejecting Square.")
					table.remove(potentialSquares, closestIndex)
					closestDistance = 1000000
					closestIndex = 0	
				else
					closestSquareFound = true
					print("No Neighbors. Square accepted.")
				end
				
			end
			
			if (closestIndex ~= 0) then				
				x = potentialSquares[closestIndex][1]
				y = potentialSquares[closestIndex][2] 
				if(placeTerrain == true) then
					terrainGrid[x][y].terrainType = terrainForSquare					
				end
				print("Setting square for line at row " ..x .." column " ..y)
				table.insert(linePoints, #linePoints + 1, {x, y})
				currentRow = x
				currentColumn = y
			end
			
			loopCount = loopCount + 1
			print("Loop Count: " ..loopCount)

		end
		
	end

	for index = 1, #linePoints do
		print("Line Point " ..index ..": Row " ..linePoints[index][1] .." Col " ..linePoints[index][2])
	end
	
	print("END OF DRAW LINE OF TERRAIN NO NEIGHBORS")
	return linePoints

end

-- creates a line of designated terrain between the two designated points
-- set meander to true for the line to deviate from a straight connection of the points
-- when set to meander, a mid point keeps the line from forming extreme "L" shapes
-- grid size is only used to ensure the start and end points are inside hte coarse map grid
function DrawLineOfTerrainNoDiagonal(startRow, startColumn, endRow, endColumn, placeTerrain, terrainForSquare, gridSize, terrainGrid)

	print("DRAW LINE OF TERRAIN NO NEIGHBORS")
	-- error checking
	if (startRow < 1) then
		print("ERROR: startRow is less than 1 and is off the coarse map. Setting startRow to 1.")
		startRow = 1
	elseif (startRow > gridSize) then
		print("ERROR: startRow is greater than gridSize and is off the coarse map. Setting startRow to gridSize.")
		startRow = gridSize
	end
	
	if (startColumn < 1) then
		print("ERROR: startColumn is less than 1 and is off the coarse map. Setting startColumn to 1.")
		startColumn = 1
	elseif (startColumn > gridSize) then
		print("ERROR: startColumn is greater than gridSize and is off the coarse map. Setting startColumn to gridSize.")
		startColumn = gridSize
	end
	
	if (endRow < 1) then
		print("ERROR: endRow is less than 1 and is off the coarse map. Setting endRow to 1.")
		endRow = 1
	elseif (startRow > gridSize) then
		print("ERROR: endRow is greater than gridSize and is off the coarse map. Setting endRow to gridSize.")
		endRow = gridSize
	end
	
	if (endColumn < 1) then
		print("ERROR: endColumn is less than 1 and is off the coarse map. Setting endColumn to 1.")
		endColumn = 1
	elseif (endColumn > gridSize) then
		print("ERROR: endColumn is greater than endColumn and is off the coarse map. Setting endColumn to gridSize.")
		endColumn = gridSize
	end
	
	if (terrainForSquare == nil) then
		print("ERROR: Invalid terrain type. Aborting DrawLineOfTerrainFunction.")
		return
	end
	-- end error checking

	linePoints = {}
	currentRow = startRow
	currentColumn = startColumn
	closestIndex = 0
	
	lineDistance = Round(math.sqrt((endRow - startRow)^2 + (endColumn - startColumn)^2),0)
	print("Total Line distance is " ..lineDistance)
	loopCount = 0

	table.insert(linePoints, 1, {startRow, startColumn})

	if (lineDistance > -1) then

		while ((currentRow ~= endRow or currentColumn ~= endColumn) and loopCount < 99) do		
			
			potentialSquares = {}
			potentialSquares = GetAllSquaresInRingAroundSquare(currentRow, currentColumn, 1, 1, terrainGrid)
			print("There are " ..#potentialSquares .." potential squares")
			closestDistance = 1000000			
			allowedNeighbors = 1
			closestSquareFound = false
			while(closestSquareFound == false and #potentialSquares > 0) do
--				print(#potentialSquares .." potential squares remaining...")
				for index = 1, #potentialSquares do
					row = potentialSquares[index][1]
					column = potentialSquares[index][2]
					
					euclidianDistance = math.sqrt((endRow - row)^2 + (endColumn - column)^2)

					if (euclidianDistance < closestDistance) then
						closestDistance = euclidianDistance
						closestIndex = index
--						print("Current closest square is at row " ..row .." column " ..column .." at distance of " ..euclidianDistance)
					else
--						print("Square is at row " ..row .." column " ..column .." at distance of " ..euclidianDistance)
					end
					
				end
				
				terrain = {terrainForSquare}
				neighborSquares = GetAllSquaresOfTypeInRingAroundSquare(potentialSquares[closestIndex][1], potentialSquares[closestIndex][2], 1, 1, terrain, terrainGrid)
				
				distanceFromEnd = math.floor(math.sqrt((endRow - potentialSquares[closestIndex][1])^2 + (endColumn - potentialSquares[closestIndex][2])^2))
				
				if(math.floor(distanceFromEnd) <= 1) then
					print("One square from end point. Setting neighbors allowed to 2")
					allowedNeighbors = 2
				end
				
				if (#neighborSquares > allowedNeighbors) then
					print(#neighborSquares .." neighbours. Too many. Rejecting Square.")
					table.remove(potentialSquares, closestIndex)
					closestDistance = 1000000
					closestIndex = 0	
				else
					closestSquareFound = true
					print("No Neighbors. Square accepted.")
				end
				
			end
			
			if (closestIndex ~= 0) then				
				x = potentialSquares[closestIndex][1]
				y = potentialSquares[closestIndex][2] 
				if(placeTerrain == true) then
					terrainGrid[x][y].terrainType = terrainForSquare					
				end
				print("Setting square for line at row " ..x .." column " ..y)
				table.insert(linePoints, #linePoints + 1, {x, y})
				currentRow = x
				currentColumn = y
			end
			
			loopCount = loopCount + 1
			print("Loop Count: " ..loopCount)

		end
		
	end

	for index = 1, #linePoints do
		print("Line Point " ..index ..": Row " ..linePoints[index][1] .." Col " ..linePoints[index][2])
	end
	
	
--	print("Pass 2: fill in diagonals")
	
	--get a copy of the line points
	lineCopy = DeepCopy(linePoints)
	copyIndex = 1
	
	for index = 1, #linePoints do
		--ensure we are not at the final point
		if(index + 1 <= #linePoints) then
			
			--save our current and next row and column to compare
			currentRow = linePoints[index][1]
			currentCol = linePoints[index][2]
			
			nextRow = linePoints[index+1][1]
			nextCol = linePoints[index+1][2]
			
			cardinalRow = nextRow
			cardinalCol = nextCol
			
			--check to see if there is a diagonal in the list from the current to next square
			if(currentRow ~= nextRow and currentCol ~= nextCol) then
				
				--both will have a difference on a diagonal, so pick one at random and insert the new coordinate
				rowDiff = nextRow - currentRow
				colDiff = nextCol - currentCol
				
				if(worldGetRandom() > 0.5) then
					cardinalRow = cardinalRow - rowDiff
				else
					cardinalCol = cardinalCol - colDiff
				end
				
				newCoord = {cardinalRow, cardinalCol}
				
				if(placeTerrain == true) then
					terrainGrid[cardinalRow][cardinalCol].terrainType = terrainForSquare					
				end
				
				table.insert(lineCopy, copyIndex+1, newCoord)
	--			print("inserted new coord at " .. cardinalRow .. ", " .. cardinalCol)
				copyIndex = copyIndex + 1
				
			end
			
		end
		
		copyIndex = copyIndex + 1
		
	end
	
--	print("line after inserting diagonals")
	
	for index = 1, #lineCopy do
	--	print("Line Point " ..index ..": Row " ..lineCopy[index][1] .." Col " ..lineCopy[index][2])
	end
	
	
	print("END OF DRAW LINE OF TERRAIN NO DIAGONAL")
	return lineCopy

end


function DrawLineOfTerrainNoDiagonalReturn(startRow, startColumn, endRow, endColumn, placeTerrain, terrainForSquare, gridSize, terrainGrid)
	
	-- error checking
	if (startRow < 1) then
		print("ERROR: startRow is less than 1 and is off the coarse map. Setting startRow to 1.")
		startRow = 1
	elseif (startRow > gridSize) then
		print("ERROR: startRow is greater than gridSize and is off the coarse map. Setting startRow to gridSize.")
		startRow = gridSize
	end
	
	if (startColumn < 1) then
		print("ERROR: startColumn is less than 1 and is off the coarse map. Setting startColumn to 1.")
		startColumn = 1
	elseif (startColumn > gridSize) then
		print("ERROR: startColumn is greater than gridSize and is off the coarse map. Setting startColumn to gridSize.")
		startColumn = gridSize
	end
	
	if (endRow < 1) then
		print("ERROR: endRow is less than 1 and is off the coarse map. Setting endRow to 1.")
		endRow = 1
	elseif (endRow > gridSize) then
		print("ERROR: endRow is greater than gridSize and is off the coarse map. Setting endRow to gridSize.")
		endRow = gridSize
	end
	
	if (endColumn < 1) then
		print("ERROR: endColumn is less than 1 and is off the coarse map. Setting endColumn to 1.")
		endColumn = 1
	elseif (endColumn > gridSize) then
		print("ERROR: endColumn is greater than endColumn and is off the coarse map. Setting endColumn to gridSize.")
		endColumn = gridSize
	end
	
	if (terrainForSquare == nil) then
		print("ERROR: Invalid terrain type. Aborting DrawLineOfTerrainFunction.")
		return
	end
	
	linePoints = {}
	
	currentRow = startRow
	currentColumn = startColumn
	
	midRow = startRow - Round((startRow - endRow) / 2, 0)
	midColumn = startColumn - Round((startColumn - endColumn) / 2, 0) 
	
--	print(midRow, midColumn)
	
	meanderValue = 2
	
	if (meander) then
		meanderValue = 0.5
	end
	
--	print("Start = " .. startRow .." Mid = " ..midRow .." End = " ..endRow)
	table.insert(linePoints, #linePoints + 1, {currentRow, currentColumn})
	if(placeTerrain == true) then
		terrainLayoutResult[currentRow][currentColumn].terrainType = terrainForSquare
	end
	targetRow = midRow
	targetColumn = midColumn
	
	for i = 0, 1 do
	
		while (currentRow ~= targetRow or currentColumn ~= targetColumn) do
		
			
			if (currentRow < targetRow) then
				
				if (worldGetRandom() < meanderValue) then
					currentRow = currentRow + 1
				end
				
			elseif (currentRow > targetRow) then
				
				if (worldGetRandom() < meanderValue) then
					currentRow = currentRow - 1
				end
				
			end
			
			if (currentColumn < targetColumn) then
				
				if (worldGetRandom() < meanderValue) then
					currentColumn = currentColumn + 1
				end
				
			elseif (currentColumn > targetColumn) then
				
				if (worldGetRandom() < meanderValue) then
					currentColumn = currentColumn - 1
				end
				
			end
			
--			print("Inside while setting terrainLayoutResult square, row = " ..currentRow ..", column " ..currentColumn)
			if(IsInMap (currentRow, currentColumn, gridSize, gridSize)) then
				if(placeTerrain == true) then
					terrainLayoutResult[currentRow][currentColumn].terrainType = terrainForSquare
				end
			else
				if(currentRow > gridSize) then
					currentRow = gridSize
				end
				
				if(currentColumn > gridSize) then
					currentColumn = gridSize
				end
				
				if(currentRow < 1) then
					currentRow = 1
				end
				
				if(currentColumn < 1) then
					currentColumn = 1
				end
				
				if(placeTerrain == true) then
					terrainLayoutResult[currentRow][currentColumn].terrainType = terrainForSquare
				end
			end
			
			table.insert(linePoints, #linePoints + 1, {currentRow, currentColumn})
		
		end
		
		targetRow = endRow
		targetColumn = endColumn
	
	end
	
	--	print("Pass 2: fill in diagonals")
	
	--get a copy of the line points
	lineCopy = DeepCopy(linePoints)
	copyIndex = 1
	
	for index = 1, #linePoints do
		--ensure we are not at the final point
		if(index + 1 <= #linePoints) then
			
			--save our current and next row and column to compare
			currentRow = linePoints[index][1]
			currentCol = linePoints[index][2]
			
			nextRow = linePoints[index+1][1]
			nextCol = linePoints[index+1][2]
			
			cardinalRow = nextRow
			cardinalCol = nextCol
			
			--check to see if there is a diagonal in the list from the current to next square
			if(currentRow ~= nextRow and currentCol ~= nextCol) then
				
				--both will have a difference on a diagonal, so pick one at random and insert the new coordinate
				rowDiff = nextRow - currentRow
				colDiff = nextCol - currentCol
				
				if(worldGetRandom() > 0.5) then
					cardinalRow = cardinalRow - rowDiff
				else
					cardinalCol = cardinalCol - colDiff
				end
				
				newCoord = {cardinalRow, cardinalCol}
				
				if(placeTerrain == true) then
					terrainGrid[cardinalRow][cardinalCol].terrainType = terrainForSquare					
				end
				
				table.insert(lineCopy, copyIndex+1, newCoord)
	--			print("inserted new coord at " .. cardinalRow .. ", " .. cardinalCol)
				copyIndex = copyIndex + 1
				
			end
			
		end
		
		copyIndex = copyIndex + 1
		
	end
	
--	print("line after inserting diagonals")
	
	for index = 1, #lineCopy do
	--	print("Line Point " ..index ..": Row " ..lineCopy[index][1] .." Col " ..lineCopy[index][2])
	end
	
	
--	print("END OF DRAW LINE OF TERRAIN NO DIAGONAL")
	return lineCopy
	
end


function DrawStraightLine(startRow, startCol, endRow, endCol, placeTerrain, terrainForSquare, gridSize, terrainGrid)
	
	-- error checking
	if (startRow < 1) then
		print("ERROR: startRow is less than 1 and is off the coarse map. Setting startRow to 1.")
		startRow = 1
	elseif (startRow > gridSize) then
		print("ERROR: startRow is greater than gridSize and is off the coarse map. Setting startRow to gridSize.")
		startRow = gridSize
	end
	
	if (startCol < 1) then
		print("ERROR: startColumn is less than 1 and is off the coarse map. Setting startColumn to 1.")
		startCol = 1
	elseif (startCol > gridSize) then
		print("ERROR: startColumn is greater than gridSize and is off the coarse map. Setting startColumn to gridSize.")
		startCol = gridSize
	end
	
	if (endRow < 1) then
		print("ERROR: endRow is less than 1 and is off the coarse map. Setting endRow to 1.")
		endRow = 1
	elseif (endRow > gridSize) then
		print("ERROR: endRow is greater than gridSize and is off the coarse map. Setting endRow to gridSize.")
		endRow = gridSize
	end
	
	if (endCol < 1) then
		print("ERROR: endColumn is less than 1 and is off the coarse map. Setting endColumn to 1.")
		endCol = 1
	elseif (endCol > gridSize) then
		print("ERROR: endColumn is greater than endColumn and is off the coarse map. Setting endColumn to gridSize.")
		endCol = gridSize
	end
	
	if (terrainForSquare == nil and placeTerrain == true) then
		print("ERROR: Invalid terrain type. Aborting DrawLineOfTerrainFunction.")
		return
	end
	
	print("starting line drawing from " .. startRow .. ", " .. startCol)
	rowDiff = endRow - startRow
	colDiff = endCol - startCol
	
	if(rowDiff > colDiff) then
		maxDiff = rowDiff
	else
		maxDiff = colDiff
	end
	
	print("row diff: " .. rowDiff .. ", colDiff: " .. colDiff .. ", maxDiff: " .. maxDiff)
	
    rowIncrement = rowDiff / maxDiff
	colIncrement = colDiff / maxDiff

	print("row increment: " .. rowIncrement .. ", colIncrement: " .. colIncrement)
	currentRow = startRow
	currentCol = startCol
	if(placeTerrain == true) then
		terrainGrid[currentRow][currentCol].terrainType = terrainForSquare
	end
	for iter = 1, maxDiff do
		
		currentRow = currentRow + rowIncrement
		currentCol = currentCol + colIncrement
		print("current row: " .. currentRow .. ", current col: " .. currentCol)
		if(placeTerrain == true) then
			terrainGrid[Round(currentRow, 0)][Round(currentCol, 0)].terrainType = terrainForSquare
		end
	end
	
end


function DrawStraightLineReturn(startRow, startCol, endRow, endCol, placeTerrain, terrainForSquare, gridSize, terrainGrid)
	
	-- error checking
	if (startRow < 1) then
		print("ERROR: startRow is less than 1 and is off the coarse map. Setting startRow to 1.")
		startRow = 1
	elseif (startRow > gridSize) then
		print("ERROR: startRow is greater than gridSize and is off the coarse map. Setting startRow to gridSize.")
		startRow = gridSize
	end
	
	if (startCol < 1) then
		print("ERROR: startColumn is less than 1 and is off the coarse map. Setting startColumn to 1.")
		startCol = 1
	elseif (startCol > gridSize) then
		print("ERROR: startColumn is greater than gridSize and is off the coarse map. Setting startColumn to gridSize.")
		startCol = gridSize
	end
	
	if (endRow < 1) then
		print("ERROR: endRow is less than 1 and is off the coarse map. Setting endRow to 1.")
		endRow = 1
	elseif (endRow > gridSize) then
		print("ERROR: endRow is greater than gridSize and is off the coarse map. Setting endRow to gridSize.")
		endRow = gridSize
	end
	
	if (endCol < 1) then
		print("ERROR: endColumn is less than 1 and is off the coarse map. Setting endColumn to 1.")
		endCol = 1
	elseif (endCol > gridSize) then
		print("ERROR: endColumn is greater than endColumn and is off the coarse map. Setting endColumn to gridSize.")
		endCol = gridSize
	end
	
	if (terrainForSquare == nil and placeTerrain == true) then
		print("ERROR: Invalid terrain type. Aborting DrawLineOfTerrainFunction.")
		return
	end
	
	print("starting line drawing from " .. startRow .. ", " .. startCol)
	rowDiff = endRow - startRow
	colDiff = endCol - startCol
	
	linePoints = {}
	
	if(rowDiff > colDiff) then
		maxDiff = rowDiff
	else
		maxDiff = colDiff
	end
	
	print("row diff: " .. rowDiff .. ", colDiff: " .. colDiff .. ", maxDiff: " .. maxDiff)
	
    rowIncrement = rowDiff / maxDiff
	colIncrement = colDiff / maxDiff

	print("row increment: " .. rowIncrement .. ", colIncrement: " .. colIncrement)
	currentRow = startRow
	currentCol = startCol
	--currentRow = Round(startRow, 0)
	--currentCol = Round(startCol, 0)	
	currentCoord = {currentRow, currentCol}
	
	table.insert(linePoints, 1, currentCoord)
	
	if(placeTerrain == true) then
		terrainGrid[currentRow][currentCol].terrainType = terrainForSquare
	end
	for iter = 1, maxDiff do
		currentRow = currentRow + rowIncrement
		currentCol = currentCol + colIncrement
		
		roundRow = Round(currentRow, 0)
		roundCol = Round(currentCol, 0)
		currentCoord = {roundRow, roundCol}
		table.insert(linePoints, #linePoints + 1, currentCoord)		
		print("current row: " .. currentRow .. ", current col: " .. currentCol)
		if(placeTerrain == true) then
			terrainGrid[Round(currentRow, 0)][Round(currentCol, 0)].terrainType = terrainForSquare
		end
	end
	
	return linePoints
end