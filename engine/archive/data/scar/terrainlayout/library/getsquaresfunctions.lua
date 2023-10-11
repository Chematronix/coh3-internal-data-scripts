-- This script contains functions for randomly selecting squares within hte coarse map grid
-- ensure that you have correctly set your values to keep the selection area contained within the size of the coarse map

-- this function randomly selects a square in the coarse map based on the start and end row and column positions
-- enter the grid size to prevent errors
-- function returns a row and column value for the square
function GetSquareInBox (startRow, endRow, startCol, endCol, coarseGridSize)
	
	-- error checking
	if (startRow < 1) then
		print("ERROR: Start row is less than one. Coarse grid rows start at 1. Start row will be set to 1")
		startRow = 1
	elseif (startRow > coarseGridSize) then
		print("ERROR: Start row is greater than the grid size value passed in and will fall outside the coarse grid. Aborting function")
		return nil, nil
	end
	
	if (startCol < 1) then
		print("ERROR: Start column is less than one. Coarse grid rows start at 1. Start row will be set to 1")
		startCol = 1
	elseif (startCol > coarseGridSize) then
		print("ERROR: Start column is greater than the grid size value passed in and will fall outside the coarse grid. Aborting function")
		return nil, nil
	end
	
	if (endRow < startRow) then
		print("ERROR: end row is less than start row. Aborting function")
		return nil, nil
	end
	
	if (endCol < startCol) then
		print("ERROR: end row is less than start row. Aborting function")
		return nil, nil
	end
	
	-- generate random square in designated box
	theRow = worldGetRandom() * (endRow - startRow) + startRow
	theRow = Round(theRow, 0)
	theCol = worldGetRandom() * (endCol - startCol) + startCol
	theCol = Round(theCol, 0)
	print("Selecting square in box at " ..theRow ..", " ..theCol)
	return theRow, theCol
	
end

-- this function randomly selects a square from a ring around the edge of the map
-- ring row and column size determines how many squares thick the ring is (you can have uneven thickness if these are different)
-- enter the grid size to prevent errors
-- function returns a row and column value for the square
function GetSquareInRing (ringRowSize, ringColSize, coarseGridSize)
	
	-- error checking
	if (coarseGridSize < 1) then
		print("ERROR: Invalid grid size. Grid must be at least one square. Aborting function.")
		return nil,nil
	end
	
	if (ringRowSize < 0) then
		print("ERROR: ring row size is less than 0. Ring row size will be set to 0.")
		ringRowSize = 0
	elseif(ringRowSize > coarseGridSize) then
		print("ERROR: rong row size is greater than coarse grid size. Ring column size will be set to coarse grid size.")
		ringRowSize = coarseGridSize
	end
	
	if (ringColSize < 0) then
		print("ERROR: ring column size is less than 0. Ring row size will be set to 0.")
		ringRowSize = 0
	elseif(ringColSize > coarseGridSize) then
		print("ERROR: rong column size is greater than coarse grid size. Ring column size will be set to coarse grid size.")
		ringRowSize = coarseGridSize
	end
	
	-- generate random square in designated ring
	validSquare = false
	
	while (validSquare == false) do
	
		theRow = worldGetRandom() * (coarseGridSize -1)
		theRow = Round(theRow, 0) + 1
		print("Initial Ring Row try = " ..theRow)

		theCol = worldGetRandom() * (coarseGridSize -1)
		theCol = Round(theCol, 0) + 1
		print("Initial Ring Col try = " ..theCol)
		
		if (theRow > ringRowSize and theRow < (coarseGridSize - ringRowSize + 1)) then
			if (theCol > ringColSize and theCol < (coarseGridSize - ringColSize + 1)) then
				print("InvalidRow")
				theRow = -1
			end
		end
		
		if (theCol > ringColSize and theCol < (coarseGridSize - ringColSize + 1)) then
			if (theRow > ringRowSize and theRow < (coarseGridSize - ringRowSize + 1)) then
				print("Invalid column at " ..theCol)
				theCol = -1
			end
		end
		
		if (theRow > 0 and theCol > 0) then
			validSquare = true
		end
	
	end
	
	return theRow, theCol
	
end

-- this function randomly selects a square from a ring surrounding a designated square
-- in addtion to setting the center of the ring, the ring size and width can be set
-- optionally a list of terrain to exlude (i.e. terrain that will not be selected by the function)
-- function returns a row and column value for the square
function GetSquareInRingAroundSquare(squareRow, squareColumn, ringRadius, ringWidth, terrainExcluded, terrainLayout)

	print("GETTING SQUARE IN RING AROUND SQUARE " .. squareRow .. ", " .. squareColumn)
	
	coarseGridSize = (#terrainLayout)

	-- error checking
	if (coarseGridSize < 1) then
		print("ERROR: Invalid grid size. Grid must be at least one square. Aborting function.")
		return nil,nil
	end
	
	if (ringWidth > ringRadius) then
		print("ERROR: ring width is greater than radius. Setting width to radius.")
		ringWidth = ringRadius
	end
	
	-- set ring in which to select square
	startRow = squareRow - ringRadius
	endRow = squareRow + ringRadius
	
	if (startRow < 1) then
		startRow = 1
	end
	
	if (endRow > coarseGridSize) then
		endRow = coarseGridSize
	end
	
	startColumn = squareColumn - ringRadius
	endColumn = squareColumn + ringRadius
	
	if (startColumn < 1) then
		startColumn = 1
	end
	
	if (endColumn > coarseGridSize) then
		endColumn = coarseGridSize
	end
	
	-- select square
	validSquare = false
	
	-- setting up a variable to increment and break out of the loop in case the designated search 
	-- ring is filled with excluded terrain and thus no selection is possible (this would create an infinite loop)
	loopExit = 0 
	
	while (validSquare == false and loopExit < 400) do
		theRow = worldGetRandom() * (endRow - startRow) + startRow
		theRow = Round(theRow, 0)
		theCol = worldGetRandom() * (endColumn - startColumn) + startColumn
		theCol = Round(theCol, 0)
		print("Trying square in box at " ..theRow ..", " ..theCol)
		
		-- check to make sure this is a valid row
		if (theRow > startRow + ringWidth - 1 and theRow < endRow - ringWidth + 1) then
			if (theCol > startColumn + ringWidth - 1 and theCol < endColumn - ringWidth + 1) then
				print("InvalidRow")
				theRow = -1
			end
		end
		
		-- check to make sure this is a valid column
		if (theCol > startColumn + ringWidth - 1 and theCol < endColumn - ringWidth + 1) then
			if (theRow > startRow + ringWidth - 1 and theRow < endRow - ringWidth + 1) then
				print("Invalid Column")
				theCol = -1
			end
		end
		
		-- check to make sure this is not the center square
		if (theRow == squareRow and theCol == squareColumn) then
			theRow = -1
			theCol = -1
		end
		
		-- check to make sure the square chosen is not an excluded terrain type (rechoose if it is)
		if (theRow > 0 and theCol > 0) then
	
			for index = 1, (#terrainExcluded) do
			
				if (terrainExcluded[index] == terrainLayout[theRow][theCol].terrainType) then
					print("Square chosen is an exluded terrain. Selecting a different square...")
					theRow = -1
					theCol = -1
					break
				end
				
			end
			
		end
		
		-- if theRow and theColumn are greater than zero then we have a valid square
		if (theRow > 0 and theCol > 0) then
			validSquare = true
		end
		
		loopExit = loopExit + 1
	
	end
	
	if (loopExit >= 400) then
		print("ERROR: there is no valid square to select. Ensure ring size is correct and that it is not filled with excluded terrain.")
	else
		print("SQUARE SELECTED at " ..theRow ..", " ..theCol)
		return theRow, theCol
	end
	
end

-- generates a list of all squares (by row and column) in the coarse grid that match the designated terrain types and returns it
-- squareRow and squareColumn is the square position for the ring centre
-- ring radius is the distance in squares from the center
-- ringWidth is the thickness of the ring inwards towards the center
-- terrainTypes is a list of terrain types that can be selcted in the ring. If a potential ring square does not match one of the types it won't be selected
-- terrainLayout is the coarse grid layout (terrainLayoutResult)
function GetAllSquaresOfTypeInRingAroundSquare(squareRow, squareColumn, ringRadius, ringWidth, terrainTypes, terrainLayout)
	
	--print("GETTING ALL SQUARES IN RING AROUND SQUARE")
	
	coarseGridSize = (#terrainLayout)

	-- error checking
	if (coarseGridSize < 1) then
		print("ERROR: Invalid grid size. Grid must be at least one square. Aborting function.")
		return nil,nil
	end
	
	if (ringWidth > ringRadius) then
		print("ERROR: ring width is greater than radius. Setting width to radius.")
		ringWidth = ringRadius
	end

-- set ring in which to select square
	ringSquares = {}
	startRow = squareRow - ringRadius
	endRow = squareRow + ringRadius
	
	if (startRow < 1) then
		startRow = 1
	end
	
	if (endRow > coarseGridSize) then
		endRow = coarseGridSize
	end
	
	startColumn = squareColumn - ringRadius
	endColumn = squareColumn + ringRadius
	
	if (startColumn < 1) then
		startColumn = 1
	end
	
	if (endColumn > coarseGridSize) then
		endColumn = coarseGridSize
	end
	
	index = 1
	for iRow = startRow, endRow do
	
		for iCol = startColumn, endColumn do
			
			-- set up loop to check each terrain type allowed to be selected
			for tIndex = 1, (#terrainTypes) do
	--			print("Number of terrain types = " ..#terrainTypes)
				if (iRow >= startRow and iRow < startRow + ringWidth and terrainLayout[iRow][iCol].terrainType == terrainTypes[tIndex]) then
	--				print("Adding Square at " ..iRow ..", " ..iCol)
					table.insert(ringSquares, index, {iRow, iCol})
					index = index + 1
				elseif (iRow <= endRow and iRow > endRow - ringWidth and terrainLayout[iRow][iCol].terrainType == terrainTypes[tIndex]) then
	--				print("Adding Square at " ..iRow ..", " ..iCol)
					table.insert(ringSquares, index, {iRow, iCol})
					index = index + 1
				elseif (iCol >= startColumn and iCol < startColumn + ringWidth and terrainLayout[iRow][iCol].terrainType == terrainTypes[tIndex]) then
	--				print("Adding Square at " ..iRow ..", " ..iCol)
					table.insert(ringSquares, index, {iRow, iCol})
					index = index + 1
				elseif (iCol <= endColumn and iCol > endColumn - ringWidth and terrainLayout[iRow][iCol].terrainType == terrainTypes[tIndex]) then
	--				print("Adding Square at " ..iRow ..", " ..iCol)
					table.insert(ringSquares, index, {iRow, iCol})
					index = index + 1
				else
	--				print("Square at " ..iRow ..", " ..iCol .." is not in ring.")
				end
				
			end
		
		end
		
	end
	
	return ringSquares

end

function GetAllSquaresInRingAroundSquare(squareRow, squareColumn, ringRadius, ringWidth, terrainLayout)
	
	--print("GETTING ALL SQUARES IN RING AROUND SQUARE")
	
	coarseGridSize = (#terrainLayout)

	-- error checking
	if (coarseGridSize < 1) then
		print("ERROR: Invalid grid size. Grid must be at least one square. Aborting function.")
		return nil,nil
	end
	
	if (ringWidth > ringRadius) then
		print("ERROR: ring width is greater than radius. Setting width to radius.")
		ringWidth = ringRadius
	end

-- set ring in which to select square
	ringSquares = {}
	startRow = squareRow - ringRadius
	endRow = squareRow + ringRadius
	
	if (startRow < 1) then
		startRow = 1
	end
	
	if (endRow > coarseGridSize) then
		endRow = coarseGridSize
	end
	
	startColumn = squareColumn - ringRadius
	endColumn = squareColumn + ringRadius
	
	if (startColumn < 1) then
		startColumn = 1
	end
	
	if (endColumn > coarseGridSize) then
		endColumn = coarseGridSize
	end
	
	index = 1
	
	print("Start Row: " ..startRow .." Start Col: " ..startColumn .." End Row: " ..endRow .." End Col: " ..endColumn .." Center Square Row: " ..squareRow .." Center Square Col: " ..squareColumn)
	
	for iRow = startRow, endRow do
	
		for iCol = startColumn, endColumn do
			
			
			--if (iRow == startRow and iCol == startColumn) then
				--print("Square at " ..iRow ..", " ..iCol .." is the start square.")
			if (iRow >= startRow and iRow < startRow + ringWidth) then
				print("Adding Square at " ..iRow ..", " ..iCol)
				table.insert(ringSquares, index, {iRow, iCol})
				index = index + 1
			elseif (iRow <= endRow and iRow > endRow - ringWidth) then
				print("Adding Square at " ..iRow ..", " ..iCol)
				table.insert(ringSquares, index, {iRow, iCol})
				index = index + 1
			elseif (iCol >= startColumn and iCol < startColumn + ringWidth) then
				print("Adding Square at " ..iRow ..", " ..iCol)
				table.insert(ringSquares, index, {iRow, iCol})
				index = index + 1
			elseif (iCol <= endColumn and iCol > endColumn - ringWidth) then
				print("Adding Square at " ..iRow ..", " ..iCol)
				table.insert(ringSquares, index, {iRow, iCol})
				index = index + 1
			else
				print("Square at " ..iRow ..", " ..iCol .." is not in ring.")
			end

		end
		
	end
	
	return ringSquares

end

-- Generates a list of all squares (by row and column) in the coarse grid that match the designated terrain type and returns it
-- terrainType is the terrain type to be searched for
-- coarseGridSize is the size of the coarse grid
-- terrainLayout is the current table containing the terrain types in the coarse grid
function GetSquaresOfType(terrainType, coarseGridSize, terrainLayout)
	
	print("GET SQUARES OF TYPE...")
	
	-- check to ensure valid grid
	if (coarseGridSize < 1) then
		print("ERROR: Coarse grid smaller than 1. Aborting function")
		return nil
	end
	
	-- check to ensure valid layout
	if (terrainLayout == nil or (#terrainLayout) < 1) then
		print("ERROR: Missing terrain layout. Aborting function")
		return nil
	end
	
	terrainLocationsList = {}
	
	for row = 1, coarseGridSize do
	
		for col = 1, coarseGridSize do
		
			if (terrainLayout[row][col].terrainType == terrainType) then
				table.insert(terrainLocationsList, {row, col})
			--	print("Adding square at " ..row ..", " ..col)
			end
			
		end
		
	end
	
	return terrainLocationsList
	
end

--- Generates a list of all squares (by row and column) in the coarse grid that match any of the designated terrain types and returns it
-- terrainTypes is the list of terrain types to be searched for
-- coarseGridSize is the size of the coarse grid
-- terrainLayout is the current table containing the terrain types in the coarse grid
function GetSquaresOfTypes(terrainTypes, coarseGridSize, terrainLayout)
	
	print("GET SQUARES OF TYPES...")
	
	-- check to ensure valid grid
	if (coarseGridSize < 1) then
		print("ERROR: Coarse grid smaller than 1. Aborting function")
		return nil
	end
	
	-- check to ensure valid layout
	if (terrainLayout == nil or (#terrainLayout) < 1) then
		print("ERROR: Missing terrain layout. Aborting function")
		return nil
	end
	
	terrainLocationsList = {}
	
	for index = 1, (#terrainTypes) do
	
		for row = 1, coarseGridSize do
		
			for col = 1, coarseGridSize do
			
				if (terrainLayout[row][col].terrainType == terrainTypes[index]) then
					table.insert(terrainLocationsList, {row, col})
			--		print("Adding square at " ..row ..", " ..col)
				end
				
			end
			
		end
		
	end
	
	return terrainLocationsList
	
end



-- Generates a list of all squares (by row and column) within the designated square in the coarse grid that match the designated terrain type and returns it
-- terrainType is the terrain type to be searched for
-- coarseGridSize is the size of the coarse grid
-- terrainLayout is the current table containing the terrain types in the coarse grid
function GetSquaresOfTypeInBox(startRow, startCol, endRow, endCol, terrainType, coarseGridSize, terrainLayout)
	
	print("GET SQUARES OF TYPE...")
	
	-- check to ensure valid grid
	if (coarseGridSize < 1) then
		print("ERROR: Coarse grid smaller than 1. Aborting function")
		return nil
	end
	
	-- check to ensure valid layout
	if (terrainLayout == nil or (#terrainLayout) < 1) then
		print("ERROR: Missing terrain layout. Aborting function")
		return nil
	end
	
	terrainLocationsList = {}
	
	for row = startRow, endRow do
	
		for col = startCol, endCol do
		
			if (terrainLayout[row][col].terrainType == terrainType) then
				table.insert(terrainLocationsList, {row, col})
				print("Adding square at " ..row ..", " ..col)
			end
			
		end
		
	end
	
	return terrainLocationsList
	
end

-- gets the euclidian distance of two sets of squares to the desired significant figures
function GetDistance(row1, col1, row2, col2, sigFigs)
	distance = Round(math.sqrt((row1 - row2)^2 + (col1 - col2)^2), sigFigs)
	return distance
end


-- gets the euclidian distance of two sets of squares to the desired significant figures
function GetDistanceDecimal(row1, col1, row2, col2, sigFigs)
	distance = math.sqrt((row1 - row2)^2 + (col1 - col2)^2), sigFigs
	return distance
end

-- finds the square from a table of squares that is closest to the origin square to 4 significant figures
-- squaresTable must be formatted as table[index][row or col], e.g. the third square in the table would be at table[3][1] (row), table[3][2] (col)
function GetClosestSquare(originRow, originCol, squaresTable)
	
	local closestDistance = 10000
	
	for index = 1, #squaresTable do
	
			row = squaresTable[index][1]
			col = squaresTable[index][2]
			
			distance =  GetDistance(originRow, originCol, row, col, 4)
			
			if(distance < closestDistance) then
				closestDistance = distance
				closestRow = row
				closestCol = col
				closestIndex = index
			end

	end
	
	return closestRow, closestCol, closestIndex
	
end

-- finds the square from a table of squares that is furthest to the origin square to 4 significant figures
-- squaresTable must be formatted as table[index][row or col], e.g. the third square in the table would be at table[3][1] (row), table[3][2] (col)
function GetFurthestSquare(originRow, originCol, squaresTable)
	
	local furthestDistance = 0
	
	for index = 1, #squaresTable do
	
			row = squaresTable[index][1]
			col = squaresTable[index][2]
			
			distance =  GetDistance(originRow, originCol, row, col, 4)
			
			if(distance >= furthestDistance) then
				furthestDistance = distance
				furthestRow = row
				furthestCol = col
				furthestIndex = index
			end

	end
	--print("returning furthest row: " .. furthestRow .. ", furthest column: " .. furthestCol .. " at index " .. furthestIndex .. " which from the table is " .. squaresTable[furthestIndex][1] .. ", " .. squaresTable[furthestIndex][2])
	return furthestRow, furthestCol, furthestIndex
	
end

-- Finds the two closest squares from two separate tables of squares
-- squaresTable01 & squaresTable01 must be formatted as table[index][row or col], e.g. the third square in the table would be at table[3][1] (row), table[3][2] (col)
-- distance is calculated to 4 significant figures
function GetClosestPairOfSquares(squaresTable01, squaresTable02)
	local square01 = {}
	local square02 = {}
	
	local closestDistance = 10000
	
	for index01 = 1, #squaresTable01 do
		
		for index02 = 1, #squaresTable02 do
			
			row01 = squaresTable01[index01][1]
			col01 = squaresTable01[index01][2]
			
			row02 = squaresTable02[index02][1]
			col02 = squaresTable02[index02][2]
			
			distance =  GetDistance(row01, col01, row02, col02, 4)
			
			if(distance < closestDistance) then
				closestDistance = distance
				square01 = {row01, col01}
				square02 = {row02, col02}
			end
			
		end
		
	end
	
	return square01, square02
	
end

-- Finds the two furthest squares from two separate tables of squares
-- squaresTable01 & squaresTable01 must be formatted as table[index][row or col], e.g. the third square in the table would be at table[3][1] (row), table[3][2] (col)
-- distance is calculated to 4 significant figures
function GetFurthestPairOfSquares(squaresTable01, squaresTable02)
	local square01 = {}
	local square02 = {}
	
	local furthestDistance = 0
	
	for index01 = 1, #squaresTable01 do
		
		for index02 = 1, #squaresTable02 do
			
			row01 = squaresTable01[index01][1]
			col01 = squaresTable01[index01][2]
			
			row02 = squaresTable02[index02][1]
			col02 = squaresTable02[index02][2]
			
			distance =  GetDistance(row01, col01, row02, col02, 4)
			
			if(distance > furthestDistance) then
				furthestDistance = distance
				square01 = {row01, col01}
				square02 = {row02, col02}
			end
			
		end
		
	end
	
	return square01, square02
	
end

--returns the square from openSquares that is furthest away from the closedSquares
function GetFurthestSquareFromSquares(openSquares, closedSquares)
	
	farSquare = {}
	
	--loop through all squares in openSquares and record their closest distance to any square in closedSquares
	openSquaresDistances = {}
	
	overallMinIndex = 1
	overallMinDistance = 0
	for openIndex = 1, #openSquares do
		
		currentRow = openSquares[openIndex][1]
		currentCol = openSquares[openIndex][2]
		
		currentMinDistance = 100000
		
		--go through closed squares for this openSquare and find the smallest distance
		for closedIndex = 1, #closedSquares do
			if(closedSquares[closedIndex][1] == nil) then
				
				currentClosedRow = closedSquares[closedIndex].startRow
				currentClosedCol = closedSquares[closedIndex].startCol
			else
				currentClosedRow = closedSquares[closedIndex][1]
				currentClosedCol = closedSquares[closedIndex][2]
			end
			
			currentCoord = {}
			currentCoord = {currentRow, currentCol}
			
			--ensure the current open square is not in the clsoed square list
			if(Table_ContainsCoordinateIndex(closedSquares, currentCoord) == false) then
				
				currentDistance = GetDistance(currentRow, currentCol, currentClosedRow, currentClosedCol, 3)
				
				if(currentDistance < currentMinDistance) then
					print("new current min distance is " .. currentDistance)
					currentMinDistance = currentDistance
				end
			else
				currentMinDistance = 0.0
			end
			
		end
		
		if(currentMinDistance > overallMinDistance) then
			overallMinDistance = currentMinDistance
			overallMinIndex = openIndex
		end
	end
	
	print("the furthest min distance is " .. overallMinDistance)
	farSquare = openSquares[overallMinIndex]
	
	return farSquare, overallMinDistance
end

--this variation of the GetNeighbors function will get the regular ring of adjacent squares, plus two above, below and to each side
function Get12Neighbors(xLoc, yLoc, terrainGrid)
	
	gridSize = #terrainGrid
	neighbors = {}
	neighborData = {}
	
	
	--get neighbor above, if not on top row
	if(yLoc < gridSize and yLoc > 0) then
		neighborData = {
		x = xLoc,
		y = yLoc + 1, 
		terrainType = terrainGrid[xLoc][yLoc+1].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor to the right, if not in final column
	if(xLoc < gridSize and xLoc > 0) then
		neighborData = {
		x = xLoc + 1,
		y = yLoc, 
		terrainType = terrainGrid[xLoc+1][yLoc].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor below, if not on bottom row
	if(yLoc > 1 and yLoc <= gridSize) then
		neighborData = {
		x = xLoc,
		y = yLoc - 1, 
		terrainType = terrainGrid[xLoc][yLoc-1].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor to the left, if not in first column
	if(xLoc > 1 and xLoc <= gridSize) then
		neighborData = {
		x = xLoc - 1,
		y = yLoc, 
		terrainType = terrainGrid[xLoc-1][yLoc].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor above to the right, if not on top row or in final column
	if(yLoc < gridSize and yLoc > 0 and xLoc < gridSize and xLoc > 0) then
		neighborData = {
		x = xLoc + 1,
		y = yLoc + 1, 
		terrainType = terrainGrid[xLoc+1][yLoc+1].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor down to the right, if not in final column or bottom row
	if(xLoc < gridSize and xLoc > 0 and yLoc > 1 and yLoc <= gridSize) then
		neighborData = {
		x = xLoc + 1,
		y = yLoc - 1, 
		terrainType = terrainGrid[xLoc+1][yLoc-1].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor down to the left, if not on bottom row or first column
	if(yLoc > 1 and yLoc <= gridSize and xLoc > 1 and xLoc <= gridSize) then
		neighborData = {
		x = xLoc - 1,
		y = yLoc - 1, 
		terrainType = terrainGrid[xLoc-1][yLoc-1].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor up to the left, if not in first column or top row
	if(xLoc > 1 and xLoc <= gridSize and yLoc < gridSize and yLoc > 0) then
		neighborData = {
		x = xLoc - 1,
		y = yLoc + 1, 
		terrainType = terrainGrid[xLoc-1][yLoc+1].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor two to the left
	if(xLoc > 2 and xLoc <= gridSize and yLoc < gridSize and yLoc > 0) then
		neighborData = {
		x = xLoc - 2,
		y = yLoc, 
		terrainType = terrainGrid[xLoc-2][yLoc].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor two to the right
	if(xLoc > 0 and xLoc <= gridSize - 2 and yLoc < gridSize and yLoc > 0) then
		neighborData = {
		x = xLoc + 2,
		y = yLoc, 
		terrainType = terrainGrid[xLoc+2][yLoc].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor two up
	if(xLoc > 0 and xLoc <= gridSize and yLoc <= gridSize - 2 and yLoc > 0) then
		neighborData = {
		x = xLoc,
		y = yLoc + 2, 
		terrainType = terrainGrid[xLoc][yLoc+2].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor two down
	if(xLoc > 0 and xLoc <= gridSize and yLoc < gridSize and yLoc > 2) then
		neighborData = {
		x = xLoc,
		y = yLoc - 2, 
		terrainType = terrainGrid[xLoc][yLoc-2].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	return neighbors
end

function Get20Neighbors(xLoc, yLoc, terrainGrid)
	
	gridSize = #terrainGrid
	print("getting 20 neighbors on grid of size " .. gridSize)
	neighbors = {}
	neighborData = {}
	
	
	--get neighbor above, if not on top row
	if(yLoc < gridSize and yLoc > 0) then
		neighborData = {
		x = xLoc,
		y = yLoc + 1, 
		terrainType = terrainGrid[xLoc][yLoc+1].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor to the right, if not in final column
	if(xLoc < gridSize and xLoc > 0) then
		neighborData = {
		x = xLoc + 1,
		y = yLoc, 
		terrainType = terrainGrid[xLoc+1][yLoc].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor below, if not on bottom row
	if(yLoc > 1 and yLoc <= gridSize) then
		neighborData = {
		x = xLoc,
		y = yLoc - 1, 
		terrainType = terrainGrid[xLoc][yLoc-1].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor to the left, if not in first column
	if(xLoc > 1 and xLoc <= gridSize) then
		neighborData = {
		x = xLoc - 1,
		y = yLoc, 
		terrainType = terrainGrid[xLoc-1][yLoc].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor above to the right, if not on top row or in final column
	if(yLoc < gridSize and yLoc > 0 and xLoc < gridSize and xLoc > 0) then
		neighborData = {
		x = xLoc + 1,
		y = yLoc + 1, 
		terrainType = terrainGrid[xLoc+1][yLoc+1].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor down to the right, if not in final column or bottom row
	if(xLoc < gridSize and xLoc > 0 and yLoc > 1 and yLoc <= gridSize) then
		neighborData = {
		x = xLoc + 1,
		y = yLoc - 1, 
		terrainType = terrainGrid[xLoc+1][yLoc-1].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor down to the left, if not on bottom row or first column
	if(yLoc > 1 and yLoc <= gridSize and xLoc > 1 and xLoc <= gridSize) then
		neighborData = {
		x = xLoc - 1,
		y = yLoc - 1, 
		terrainType = terrainGrid[xLoc-1][yLoc-1].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor up to the left, if not in first column or top row
	if(xLoc > 1 and xLoc <= gridSize and yLoc < gridSize and yLoc > 0) then
		neighborData = {
		x = xLoc - 1,
		y = yLoc + 1, 
		terrainType = terrainGrid[xLoc-1][yLoc+1].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor two to the left
	if(xLoc > 2 and xLoc <= gridSize and yLoc < gridSize and yLoc > 0) then
		neighborData = {
		x = xLoc - 2,
		y = yLoc, 
		terrainType = terrainGrid[xLoc-2][yLoc].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor two to the right
	if(xLoc > 0 and xLoc <= Round(gridSize - 2, 0) and yLoc < gridSize and yLoc > 0) then
		neighborData = {
		x = xLoc + 2,
		y = yLoc, 
		terrainType = terrainGrid[xLoc+2][yLoc].terrainType
		}
		print("grabbing neighbor two to the right at " .. xLoc+2 .. ", " .. yLoc)
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor two up
	if(xLoc > 0 and xLoc <= gridSize and yLoc <= gridSize - 2 and yLoc > 0) then
		neighborData = {
		x = xLoc,
		y = yLoc + 2, 
		terrainType = terrainGrid[xLoc][yLoc+2].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	--get neighbor two down
	if(xLoc > 0 and xLoc <= gridSize and yLoc < gridSize and yLoc > 2) then
		neighborData = {
		x = xLoc,
		y = yLoc - 2, 
		terrainType = terrainGrid[xLoc][yLoc-2].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	if(xLoc > 1 and xLoc <= gridSize and yLoc <= gridSize - 2 and yLoc > 0) then
		neighborData = {
		x = xLoc - 1,
		y = yLoc + 2, 
		terrainType = terrainGrid[xLoc-1][yLoc+2].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	if(xLoc > 0 and xLoc <= gridSize - 1 and yLoc <= gridSize - 2 and yLoc > 0) then
		neighborData = {
		x = xLoc + 1,
		y = yLoc + 2, 
		terrainType = terrainGrid[xLoc+1][yLoc+2].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	if(xLoc > 0 and xLoc <= gridSize - 2 and yLoc <= gridSize - 1 and yLoc > 0) then
		neighborData = {
		x = xLoc + 2,
		y = yLoc + 1, 
		terrainType = terrainGrid[xLoc+2][yLoc+1].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	if(xLoc > 0 and xLoc <= gridSize - 2 and yLoc < gridSize and yLoc > 1) then
		neighborData = {
		x = xLoc + 2,
		y = yLoc - 1, 
		terrainType = terrainGrid[xLoc+2][yLoc-1].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	if(xLoc > 0 and xLoc <= gridSize - 1 and yLoc < gridSize and yLoc > 2) then
		neighborData = {
		x = xLoc + 1,
		y = yLoc - 2, 
		terrainType = terrainGrid[xLoc+1][yLoc-2].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	if(xLoc > 1 and xLoc <= gridSize and yLoc < gridSize and yLoc > 2) then
		neighborData = {
		x = xLoc - 1,
		y = yLoc - 2, 
		terrainType = terrainGrid[xLoc-1][yLoc-2].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	if(xLoc > 2 and xLoc <= gridSize and yLoc < gridSize and yLoc > 1) then
		neighborData = {
		x = xLoc - 2,
		y = yLoc - 1, 
		terrainType = terrainGrid[xLoc-2][yLoc-1].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	if(xLoc > 2 and xLoc <= gridSize and yLoc < gridSize - 1 and yLoc > 0) then
		neighborData = {
		x = xLoc - 2,
		y = yLoc + 1, 
		terrainType = terrainGrid[xLoc-2][yLoc+1].terrainType
		}
		table.insert(neighbors, neighborData)
	end
	
	
	
	return neighbors
end


function GetAllSquaresInRadius(row, col, radius, terrainGrid)
	
	foundSquares = {}
	
	--loop through and check for distance from the selected point to the current point
	for currentRow = 1, #terrainGrid do
		for currentCol = 1, #terrainGrid do
			
			currentDistance = GetDistance(row, col, currentRow, currentCol, 2)
			
			if(currentDistance <= radius) then
				currentInfo = {}
				currentInfo = {currentRow, currentCol}
				table.insert(foundSquares, currentInfo)
			end
		end
	end
	
	return foundSquares
end
