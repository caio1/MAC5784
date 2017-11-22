local constants = require("constants")

local maps = {}

local gridWidth  = constants.gridWidth
local gridHeight = constants.gridHeight

----------------------------------------
-------- first map construction --------
----------------------------------------

local map = {}
for i = 1, gridHeight do
	map[i] = {}
	for j = 1, gridWidth do
		map[i][j] = 0
	end
end

--------left wall ------
for i = 3, 8 do
	map[i][3] = 1
	map[i][2] = 1
	map[i][1] = 1
end

-- there's a door between those 2 sections

for i = 14, gridHeight-2 do
	map[i][3] = 1
	map[i][2] = 1
	map[i][1] = 1
end

for j = 1, 3 do
	map[8][j] = 1
	map[14][j] = 1
end

------right wall-----

for i = 3, gridHeight - 13 do
	map[i][gridWidth - 2] = 1
	map[i][gridWidth - 1] = 1
	map[i][gridWidth - 0] = 1
end

-- there's a door between these 2 sections

for i = gridHeight - 7, gridHeight - 2 do
	map[i][gridWidth - 2] = 1
	map[i][gridWidth - 1] = 1
	map[i][gridWidth] = 1
end

for j = gridWidth-2, gridWidth do
	map[gridHeight-13][j] = 1
	map[gridHeight-7][j] = 1
end

-------top and bottom wall-----

for j = 1, gridWidth do
	map[1][j] = 1
	map[2][j] = 1
	map[3][j] = 1
	map[gridHeight-2][j] = 1
	map[gridHeight-1][j] = 1
	map[gridHeight-0][j] = 1
end

-------------------------------------
-------------------------------------

maps["simulation1"] = map

-------------

return maps
