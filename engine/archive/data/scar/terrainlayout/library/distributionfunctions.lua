-- these functions are used to check proximity of squares in the coarse grid 


-- for times when certain terrain types need to be a minimum distance apart
-- row and column represent the position of the square you are checking
-- minDistance is the minimum distance in coarse grid squares the square you are checking must be from 
-- the list of positions
-- gridPositions must be a table of row,column values e.g. gridPositions = {{2,7}, {4,3}}
-- coarseGridSize is the size of the map. It is used for error checking
-- the function returns true if the designated grid square is far enough away from each position in the gridPositions table
function SquaresFarEnoughApart(row, column, minDistance, gridPositions, coarseGridSize)
	
	if (minDistance > coarseGridSize / 3) then
		print("ERROR: minimum distance too large for this size of map.")
	end
	
	if ((#gridPositions) < 1) then
		print("ERROR: List of grid positions is empty. No coordinates to check distance against")
	end
	
	if (row > coarseGridSize) then
		print("ERROR: row value entered is large than grid size. Aborting function.")
		return
	end
	
	if (column > coarseGridSize) then
		print("ERROR: row value entered is large than grid size. Aborting function.")
		return
	end
	
	farEnoughFromPositions = false	
	print("CHECKING DISTANCE FROM DESIGNATED LOCATIONS...")
		
	for index, value in ipairs(gridPositions) do
		rowDistance = row - value[1]
		colDistance = column - value[2]
		print("ROW: " .. row .." ROW DISTANCE: " ..math.abs(rowDistance) .. " COL: " ..column .." COL DISTANCE: " ..math.abs(colDistance))
		
		if (math.abs(rowDistance) >= minDistance or math.abs(colDistance) >= minDistance) then
			print("VALID PLACEMENT DISTANCE")
			farEnoughFromPositions = true
		else
			print("TOO CLOSE TO DESIGNATED LOCATION " ..index)
			farEnoughFromPositions = false
			break
		end
		
	end
	
	return farEnoughFromPositions
	
end

-- for times when certain terrain types need to be a minimum distance apart. Uses euclidian distance
-- row and column represent the position of the square you are checking
-- minDistance is the minimum distance in coarse grid squares the square you are checking must be from 
-- the list of positions
-- gridPositions must be a table of row,column positions in either row, col format e.g. (gridPositions = {{2,7}, {4,3}}) or formatted as player start locations 
-- coarseGridSize is the size of the map. It is used for error checking
-- the function returns true if the designated grid square is far enough away from each position in the gridPositions table
function SquaresFarEnoughApartEuclidian(row, column, minDistance, gridPositions, coarseGridSize)
	
	-- error checking
	if ((#gridPositions) < 1) then
		print("ERROR: List of grid positions is empty. No coordinates to check distance against.")
	end
	
	if (row > coarseGridSize) then
		print("ERROR: row value entered is large than grid size. Aborting function.")
		return
	end
	
	if (column > coarseGridSize) then
		print("ERROR: row value entered is large than grid size. Aborting function.")
		return
	end
	
	farEnoughFromPositions = false	
	print("CHECKING EUCLIDIAN DISTANCE FROM DESIGNATED LOCATIONS...")
	
	--for index, value in ipairs(gridPositions) do
	for index = 1, #gridPositions do	
		if (gridPositions[index].startRow ~= nil and gridPositions[index].startCol ~= nil) then
			print("Grid Positions is a player start locations table")
			rowCheck = gridPositions[index].startRow
			colCheck = gridPositions[index].startCol
		else
			print("Grid Positions is a row, col table")
			rowCheck = gridPositions[index][1]
			colCheck = gridPositions[index][2]
		end
		print("checking distance from position " .. index .. " at " .. rowCheck .. ", " .. colCheck)
		euclidianDistance = Round(math.sqrt((rowCheck - row)^2 + (colCheck - column)^2), 0)
		print("Distance from position " ..index .." is " ..euclidianDistance)
		
		if (euclidianDistance > minDistance) then
			farEnoughFromPositions = true
		else
			farEnoughFromPositions = false
			break
		end
		
	end
	
	if (farEnoughFromPositions == true) then
		print("VALID PLACEMENT DISTANCE AT " ..row ..", " ..column)
	else
		print("TOO CLOSE TO DESIGNATED LOCATION AT " ..row ..", " ..column)
	end
	
	return farEnoughFromPositions

end

-- for times when certain terrain types need within a minimum distance from each other. Uses euclidian distance
-- row and column represent the position of the square you are checking
-- maxDistance is the maximum distance in coarse grid squares the square you are checking must be within 
-- to the list of positions
-- gridPositions must be a table of row,column values e.g. gridPositions = {{2,7}, {4,3}}
-- coarseGridSize is the size of the map. It is used for error checking
-- the function returns true if the designated grid square is close enough together to each position in the gridPositions table
function SquaresCloseEnoughTogetherEuclidian(row, column, maxDistance, gridPositions, coarseGridSize)
	
	-- error checking
	if ((#gridPositions) < 1) then
		print("ERROR: List of grid positions is empty. No coordinates to check distance against.")
	end
	
	if (row > coarseGridSize) then
		print("ERROR: row value entered is large than grid size. Aborting function.")
		return
	end
	
	if (column > coarseGridSize) then
		print("ERROR: row value entered is large than grid size. Aborting function.")
		return
	end
	
	closeEnoughToPositions = false	
	print("CHECKING EUCLIDIAN DISTANCE FROM DESIGNATED LOCATIONS...")
	
	for index, value in ipairs(gridPositions) do
		rowCheck = value[1]
		colCheck = value[2]
		
		euclidianDistance = Round(math.sqrt((rowCheck - row)^2 + (colCheck - column)^2), 0)
		print("Distance from position " ..index .." is " ..euclidianDistance)
		
		if (euclidianDistance < maxDistance) then
			closeEnoughToPositions = true
		else
			closeEnoughToPositions = false
			break
		end
		
	end
	
	if (closeEnoughToPositions == true) then
		print("VALID PLACEMENT DISTANCE AT " ..row ..", " ..column)
	else
		print("TOO FAR FROM DESIGNATED LOCATION AT " ..row ..", " ..column)
	end
	
	return closeEnoughToPositions

end
	