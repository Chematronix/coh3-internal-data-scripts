--function GetNeighbors returns a list of all directly adjacent cells in a 2D array-style table
function GetNeighbors(xLoc, yLoc, terrainGrid)

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
	
	return neighbors

end

--function GetNeighbors returns a list of all directly adjacent cells in a 2D array-style table
function GetNeighborsOfType(xLoc, yLoc, checkTerrainTypes, terrainGrid)

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
		matchesType = false
		for terrainIndex = 1, #checkTerrainTypes do
			if(terrainGrid[xLoc][yLoc+1].terrainType == checkTerrainTypes[terrainIndex]) then
				matchesType = true
				break
			end
		end
		if(matchesType == true) then
			table.insert(neighbors, neighborData)
		end
		
	end
	
	--get neighbor to the right, if not in final column
	if(xLoc < gridSize and xLoc > 0) then
		neighborData = {
		x = xLoc + 1,
		y = yLoc, 
		terrainType = terrainGrid[xLoc+1][yLoc].terrainType
		}
		matchesType = false
		for terrainIndex = 1, #checkTerrainTypes do
			if(terrainGrid[xLoc+1][yLoc].terrainType == checkTerrainTypes[terrainIndex]) then
				matchesType = true
				break
			end
		end
		if(matchesType == true) then
			table.insert(neighbors, neighborData)
		end
	end
	
	--get neighbor below, if not on bottom row
	if(yLoc > 1 and yLoc <= gridSize) then
		neighborData = {
		x = xLoc,
		y = yLoc - 1, 
		terrainType = terrainGrid[xLoc][yLoc-1].terrainType
		}
		matchesType = false
		for terrainIndex = 1, #checkTerrainTypes do
			if(terrainGrid[xLoc][yLoc-1].terrainType == checkTerrainTypes[terrainIndex]) then
				matchesType = true
				break
			end
		end
		if(matchesType == true) then
			table.insert(neighbors, neighborData)
		end
	end
	
	--get neighbor to the left, if not in first column
	if(xLoc > 1 and xLoc <= gridSize) then
		neighborData = {
		x = xLoc - 1,
		y = yLoc, 
		terrainType = terrainGrid[xLoc-1][yLoc].terrainType
		}
		matchesType = false
		for terrainIndex = 1, #checkTerrainTypes do
			if(terrainGrid[xLoc-1][yLoc].terrainType == checkTerrainTypes[terrainIndex]) then
				matchesType = true
				break
			end
		end
		if(matchesType == true) then
			table.insert(neighbors, neighborData)
		end
	end
	
	return neighbors

end

--returns the adjacent and diagonally adjacent points to the target point passed in
function Get8Neighbors(xLoc, yLoc, terrainGrid)
	
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
	
	return neighbors
end

--function GetNextRiverSquare takes a list of directly adjacent neighbors, the river index and the previous square,
--and finds the next square in the river
function GetNextRiverSquare(neighborList, rIndex, riverList, terrainGrid)
	
	nextSquare = nil
	
	--from neighbor list, find the next river square, ignoring the previous river square
	for index, neighbor in ipairs(neighborList) do
		
		--check for next river square with each neighbor
		if(terrainGrid[neighbor.x][neighbor.y] == rIndex) then
			print("square at " .. neighbor.x .. ", " .. neighbor.y .. " matches river index")
			--check to make sure this neighbor is not the previous square
			if(isPointOnRiver(riverList, neighbor.x, neighbor.y) == false) then
				print("square at " .. neighbor.x .. ", " .. neighbor.y .. " is not already in the river list")
				nextSquare = neighbor
				
			end
		end
	end
	
	return nextSquare
end

function isPointOnRiver(riverPoints, newRow, newCol)
	
	isOnRiver = false
	
	for index = 1, #riverPoints do
	
		currentRow = riverPoints[index][1]
		currentCol = riverPoints[index][2] 
		
		if(newRow == currentRow and newCol == currentCol) then
			isOnRiver = true		
		end
	end
	
	return isOnRiver
end
	

--function GetNextRiverSquare takes a list of directly adjacent neighbors, and the previous square,
--and finds the next square in the river
function GetNextRiverSquareNoIndex(neighborList, previousSquare)

	nextSquare = nil
	
	--from neighbor list, find the next river square, ignoring the previous river square
	for index, neighbor in ipairs(neighborList) do
		
		--check for next river square with each neighbor
		if(neighbor.terrainType == tt_river) then
		
			--check to make sure this neighbor is not the previous square
			if(neighbor.x ~= previousSquare.x or neighbor.y ~= previousSquare.y) then
			--Table_ContainsCoordinate(neighbor, previousSquare) == false)
		
				nextSquare = neighbor
			end
		end
	end
	
	return nextSquare
end

--function ChartRiver will find the specified river from the coarse grid and record its path
--for the map generation system. 
function ChartRiver(tributaryIndex, startingCoord, terrainTable)
	
	--define table to save river points
	riverPoints = {}
	
	startRow = startingCoord[1]
	startCol = startingCoord[2]
	
	--assign the first river square to the start of the river points list
	table.insert(riverPoints, {startRow, startCol})
	
	--start at first edge point, find neighbors
	startingNeighbors = GetNeighbors(startRow, startCol, terrainTable)
	
	currentRiverSquare = nil
	previousRiverSquare = {
	x = startRow, 
	y = startCol
	}
	
	--from neighbor list, find the next river square, ignoring the previous river square
	for index, neighbor in ipairs(startingNeighbors) do
		
		--check for next river square with each neighbor, ensuring that it is the river with the same index
		if(terrainTable[neighbor.x][neighbor.y] == tributaryIndex) then
			currentRiverSquare = neighbor
		end
	end
	
	--search diagonals if it doesn't find an adjacent river square
	if(currentRiverSquare == nil) then
		startingNeighbors = Get8Neighbors(startRow, startCol, terrainTable)
		
		for index, neighbor in ipairs(startingNeighbors) do
		
			--check for next river square with each neighbor, ensuring that it is the river with the same index
			if(terrainTable[neighbor.x][neighbor.y] == tributaryIndex) then
				currentRiverSquare = neighbor
			end
		end
	end
	
	tempCoord = {
	currentRiverSquare.x, 
	currentRiverSquare.y
	}
	table.insert(riverPoints, tempCoord)
	print("before main loop, previous square is set to " .. previousRiverSquare.x .. ", " .. previousRiverSquare.y)
	print("before main loop, first starting point away from map edge is " .. tempCoord[1] .. ", " .. tempCoord[2])
	
	--loop through rest of river until edge point or other river square is reached
	while(currentRiverSquare ~= nil) do
	
		--get neighbors from current square
		oldRiverSquare = {}
		oldRiverSquare.x = currentRiverSquare.x
		oldRiverSquare.y = currentRiverSquare.y
		currentNeighbors = GetNeighbors(currentRiverSquare.x, currentRiverSquare.y, terrainTable)
		
		--temporarily save the current square to be reassigned as previous later
		tempSquare = currentRiverSquare
		
		--set current to be the next square in the river
		currentRiverSquare = GetNextRiverSquare(currentNeighbors, tributaryIndex, riverPoints, terrainTable)
		
		
		--if you can't find a directly adjacent square, check the diagonals
		if(currentRiverSquare == nil) then
			print("no adjacent neighbor river squares, checking diagonals")
			diagonalNeighbors = Get8Neighbors(oldRiverSquare.x, oldRiverSquare.y, terrainTable)
			
			
			
			--set current to be the next square in the river
			currentRiverSquare = GetNextRiverSquare(diagonalNeighbors, tributaryIndex, riverPoints, terrainTable)
			
			if(currentRiverSquare ~= nil) then
				print("found diagonal river neighbor")
				--temporarily save the current square to be reassigned as previous later
				tempSquare = currentRiverSquare
			end
			
		end
		
		--if the indexed river has no next point, see if there is a square from another river to join with
		if(currentRiverSquare == nil) then
			print("current river square is nil")
			currentRiverSquare = GetNextRiverSquareNoIndex(currentNeighbors, previousRiverSquare)
			
			if(currentRiverSquare ~= nil) then
				print("found another river square on a different river")
				if( terrainTable[currentRiverSquare.x][currentRiverSquare.y] ~= tributaryIndex) then
					--put the coordinates of the current river square in the river point list
					tempCoord = {
					currentRiverSquare.x, 
					currentRiverSquare.y
					}
					table.insert(riverPoints, tempCoord)
					
					print("inserted final square river coord at " .. tempCoord[1] .. ", " .. tempCoord[2])
				end
				
			--check diagonals
			else
				currentRiverSquare = GetNextRiverSquareNoIndex(diagonalNeighbors, previousRiverSquare)
				
				if(currentRiverSquare ~= nil) then
					print("found another river square on a different river")
					if( terrainTable[currentRiverSquare.x][currentRiverSquare.y] ~= tributaryIndex) then
						--put the coordinates of the current river square in the river point list
						tempCoord = {
						currentRiverSquare.x, 
						currentRiverSquare.y
						}
						table.insert(riverPoints, tempCoord)
						
						print("inserted final square river coord at " .. tempCoord[1] .. ", " .. tempCoord[2])
					end
				end
			end
			break
		end
		
		
		--reassign previous square as old current
		previousRiverSquare = tempSquare
		if(previousRiverSquare ~= nil) then
			print("previous river square is now " .. previousRiverSquare.x .. ", " .. previousRiverSquare.y)
		end
		
		
		--make sure that the next square exists
		if(currentRiverSquare ~= nil) then
			--put the coordinates of the current river square in the river point list
			tempCoord = {
			currentRiverSquare.x, 
			currentRiverSquare.y
			}
			table.insert(riverPoints, tempCoord)
			
			print("inserted current square river coord at " .. tempCoord[1] .. ", " .. tempCoord[2])
		
		end
		
		if(currentRiverSquare ~= nil) then
		--check to see if the current river square is the end of the tributary (eg a point on another river)
			if(terrainTable[currentRiverSquare.x][currentRiverSquare.y] ~= tributaryIndex) then
				print("end of tributary found, joining another river")
				currentRiverSquare = nil
			end
		end
		
		
	end
	
	--add this river to the river table to be given to mapgen
	table.insert(riverResult, riverPoints)
	
end

--function CreateLake will find the largest open space on the map within a size constraint and create a lake there
function CreateLake(maxRadius, minRadius, impasseTypes, lakeTerrain, numOfLakes, terrainTable)
	
	gridSize = #terrainTable
	--lakeTable will hold the squares that the lake occupies
	lakeTable = {}
	
	--availableSquares is a list of every non-impasse square on the map
	availableSquares = {}
	
	--fill availableSquares
	for row = 1, gridSize do
		for col = 1, gridSize do
			
			--check if the current terrain square is a valid square (not impasse)
			isValidTerrain = true
			currentTerrainType = terrainTable[row][col].terrainType
			for terrainTypeIndex = 1, #impasseTypes do
				if(currentTerrainType == impasseTypes[terrainTypeIndex]) then
					isValidTerrain = false
					--				print("terrain invalid due to this square being impasse")
				end
			end
			
			--check for neighboring impasse
			testNeighbors = GetNeighbors(row, col, terrainTable)
			
			for testNeighborIndex, testNeighbor in ipairs(testNeighbors) do
				
				testNeighborRow = testNeighbor.x
				testNeighborCol = testNeighbor.y
				currentTerrainType = terrainTable[testNeighborRow][testNeighborCol].terrainType
				for terrainTypeIndex = 1, #impasseTypes do
					if(currentTerrainType == impasseTypes[terrainTypeIndex]) then
						isValidTerrain = false
						--					print("terrain invalid because this square's neighbors are impasse")
					end
				end
				
			end
			
			--if the current square is not impasse, add it to the list
			currentInfo = {}
			if(isValidTerrain == true) then
				currentInfo = {row, col}
				table.insert(availableSquares, currentInfo)
			end
		end
	end
	
	local function GetScore(row, col, radius)
		
		score = 0
		openList = {}
		closedList = {}
		
		--search grid, add to openList if distance to origin < maxRadius AND no impasse neighbors
		--score this square by inverse distance of all found points (or distance if long lakes wanted)
		currentInfo = {}
		currentInfo = {row, col}
		table.insert(openList, currentInfo)
		repeat
			
			currentSquare = openList[1]
			currentRow = currentSquare[1]
			currentCol = currentSquare[2]
			
			table.remove(openList, 1)
			table.insert(closedList, currentSquare)
			currentNeighbors = {}
			currentNeighbors = GetNeighbors(currentRow, currentCol, terrainTable)
			
			--loop through neighbors and assign any within radius and with no impasse neighbors to the openList
			for neighborIndex, neighbor in ipairs(currentNeighbors) do
				
				neighborRow = neighbor.x
				neighborCol = neighbor.y 
				
				--check for distance to origin
				currentDistance = GetDistance(row, col, neighborRow, neighborCol, 2)
				if(currentDistance <= radius) then
					
					--check for neighboring impasse
					testNeighbors = GetNeighbors(neighborRow, neighborCol, terrainTable)
					
					isValidTerrain = true
					for testNeighborIndex, testNeighbor in ipairs(testNeighbors) do
						
						testNeighborRow = testNeighbor.x
						testNeighborCol = testNeighbor.y
						currentTerrainType = terrainTable[testNeighborRow][testNeighborCol].terrainType
						for terrainTypeIndex = 1, #impasseTypes do
							if(currentTerrainType == impasseTypes[terrainTypeIndex]) then
								isValidTerrain = false
							end
						end
						
					end
					
					currentInfo = {}
					currentInfo = {neighborRow, neighborCol}
					
					if(isValidTerrain == true and Table_ContainsCoordinateIndex(closedList, currentInfo) == false and Table_ContainsCoordinateIndex(openList, currentInfo) == false) then
						
						table.insert(openList, currentInfo)
					end
					
				end
			end
			--		print("openList length: " .. #openList .. "\n ")
		until (#openList == 0)
		
		--loop through the closed list and add up the score
		--score will be larger when closer to the origin
		inverseThreshold = -2
		for closedIndex = 1, #closedList do
			
			currentRow = closedList[closedIndex][1]
			currentCol = closedList[closedIndex][2]
			currentDistance = GetDistance(row, col, currentRow, currentCol, 2)
			--score = score + (radius - currentDistance)
			score = score + (inverseThreshold + currentDistance)
		end
		
		return score
	end
	
	--need to shuffle the available squares table
	local function shuffleTable(table)
		
		for i = 1, #table do
			
			j = math.ceil(worldGetRandom() * #table)
			
			table[i], table[j] = table[j], table[i]
		end
		
	end
	
	--shuffle the table
	shuffleTable(availableSquares)
	
	--loop through the available squares and find the square with the highest score
	--this will be the most open place for a lake
	bestScore = 0
	bestIndex = 1
	
	scoreTable = {}
	
	for squareIndex = 1, #availableSquares do
		
		currentRow = availableSquares[squareIndex][1]
		currentCol = availableSquares[squareIndex][2]
		
		currentScore = GetScore(currentRow, currentCol, maxRadius)
		
		currentData = {}
		currentData = {
			score = currentScore,
			row = currentRow,
			col = currentCol
		}
		table.insert(scoreTable, currentData)
		if(currentScore > bestScore) then
			bestScore = currentScore
			bestIndex = squareIndex
		end
	end
	
	--sort the scoreTable for highest score
	table.sort(scoreTable, function(a,b) return a.score > b.score end)
	
	
	--	print("there are " .. #availableSquares .. " available squares")
	--	print(" the best square index is " .. bestIndex)
	for lakeIndex = 1, numOfLakes do
		
		bestRow = scoreTable[lakeIndex].row
		bestCol = scoreTable[lakeIndex].col
		--bestRow = availableSquares[bestIndex][1]
		--bestCol = availableSquares[bestIndex][2]
		
		--get lake radius for this specific iteration
		lakeRadius = minRadius + (math.ceil(worldGetRandom() * (maxRadius - minRadius)))
		
		openList = {}
		closedList = {}
		
		--now that we have the best location for the lake, repeat the operation, record squares and place lake terrain
		currentInfo = {}
		currentInfo = {bestRow, bestCol}
		table.insert(openList, currentInfo)
		repeat
			
			currentSquare = openList[1]
			currentRow = currentSquare[1]
			currentCol = currentSquare[2]
			
			table.remove(openList, 1)
			table.insert(closedList, currentSquare)
			currentNeighbors = {}
			currentNeighbors = GetNeighbors(currentRow, currentCol, terrainTable)
			
			--loop through neighbors and assign any within radius and with no impasse neighbors to the openList
			for neighborIndex, neighbor in ipairs(currentNeighbors) do
				
				neighborRow = neighbor.x
				neighborCol = neighbor.y 
				
				--check for distance to origin
				currentDistance = GetDistance(bestRow, bestCol, neighborRow, neighborCol, 2)
				--		print("currentDistance: " .. currentDistance .. ", while the radius is " .. maxRadius)
				if(currentDistance <= lakeRadius) then
					
					--check for neighboring impasse
					testNeighbors = GetNeighbors(neighborRow, neighborCol, terrainTable)
					
					isValidTerrain = true
					for testNeighborIndex, testNeighbor in ipairs(testNeighbors) do
						
						testNeighborRow = testNeighbor.x
						testNeighborCol = testNeighbor.y
						currentTerrainType = terrainTable[testNeighborRow][testNeighborCol].terrainType
						for terrainTypeIndex = 1, #impasseTypes do
							if(currentTerrainType == impasseTypes[terrainTypeIndex]) then
								isValidTerrain = false
							end
						end
						
					end
					
					
					currentInfo = {}
					currentInfo = {neighborRow, neighborCol}
					if(isValidTerrain == true and Table_ContainsCoordinateIndex(closedList, currentInfo) == false) then
						
						table.insert(openList, currentInfo)
					end
					
				end
			end
			
		until (#openList == 0)
		
		--go through closed list, set to lake terrain
		for closedIndex = 1, #closedList do
			
			currentRow = closedList[closedIndex][1]
			currentCol = closedList[closedIndex][2]
			terrainTable[currentRow][currentCol].terrainType = lakeTerrain
		end
	end
end