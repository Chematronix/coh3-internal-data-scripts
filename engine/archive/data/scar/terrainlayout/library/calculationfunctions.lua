-- this script contains calculation functions for things not covered in the lua math library
-- or for complex calculations required for map generation

-- a basic rounding function
function Round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

-- randomly picks an element in the designated array
function GetRandomElement(array)

	-- Subtract small number to prevent access beyond end
	local randomIndexBase = Round((worldGetRandom() - 1E-10) * ((#array) - 1), 0)
	--print("Random element selected is " ..(randomIndexBase + 1))
	-- Add one for indices beginning at 1
	return array[randomIndexBase + 1]

end

--- Get random index
-- randomly selects an index from the designated array
function GetRandomIndex(array)

	-- Subtract small number to prevent access beyond end
	local randomIndexBase = Round((worldGetRandom() - 1E-10) * ((#array) - 1), 0)
	--print("Random element selected is " ..(randomIndexBase + 1))
	-- Add one for indices beginning at 1
	return randomIndexBase + 1

end

-- deep copy for tables
function DeepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[DeepCopy(orig_key)] = DeepCopy(orig_value)
        end
        setmetatable(copy, DeepCopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

--- Is in map
-- checks to sdee if a given row and column coordinate is inside the map grid
function IsInMap (row, column, gridheight, gridWidth)
	
	if (row > 0 and row <= gridHeight and column > 0 and column <= gridWidth) then
		print("Row " ..row .." and Column " ..column .." is in map.")
		return true
	else
		print("Row " ..row .." and Column " ..column .." is outside map.")
		return false
	end
	
end

--- Table contains elements
-- checks to see if one or more elements exist in a table
-- returns true only if all elements specified are found
function tableContainsAll( tbl, ... )
	arg = {...}
    local count = 0
    for i=1, #tbl do
        for c=1, #arg do
            if (tbl[i] == arg[c]) then
                count = count + 1
				break
            end
        end
    end
	
	--check to see if at least one of all elements are present
	if(count >= #arg) then
		print("found all elements specified in the list")
		return true
	else
		print("not all specified elements were found in the list")
    	return false
	end
end

--- Table contains elements
-- checks to see if one or more elements exist in a table
-- returns true only if even one of elements specified are found
function tableContainsAny( tbl, ... )
	arg = {...}
    local count = 0
    for i=1, #tbl do
        for c=1, #arg do
            if (tbl[i] == arg[c]) then
                count = count + 1
				break
            end
        end
    end
	
	--check to see if at least one of all elements are present
	if(count >= 1) then
		print("found at least one instance of the specified elements in the list")
		return true
	else
		print("no instances of specified elements found")
    	return false
	end
end

--normalize will return a value scaled between a min and a max value
function Normalize(value, min, max)
	
	return ((value * (max - min)) + min)
end

--function that returns a float normalized between a given min and max value.
--Deterministically safe for use 
function GetRandomInRange(min, max)
	
	rng = Normalize(worldGetRandom(), min, max)
	return rng
end