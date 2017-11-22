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

--------left and right wall ------
for i = 1, gridHeight do
	map[i][1] = 1
	map[i][gridWidth] = 1
end

-------top and bottom wall-----

for j = 1, gridWidth do
	map[1][j] = 1
	map[2][j] = 1
	map[gridHeight-1][j] = 1
	map[gridHeight-0][j] = 1
end

-- middle division --

for i = 3, gridHeight-2 do
	map[i][math.ceil(gridWidth/2)] = 2
end

-------------------------------------
-------------------------------------

maps["simulation2"] = map

-------------

return maps
