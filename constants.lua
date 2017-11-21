local constants = {}

--time

constants.spawnInterval    = 200
constants.movementInterval = 150
constants.transitionTime   = 80

constants.cellWidth  = 27
constants.cellHeight = 27
constants.gridWidth  = 42
constants.gridHeight = 28

constants.objectives = {
	-- team 1 objective
	{ 
		x = constants.gridWidth, 
		y = constants.gridHeight - 10
	},
	-- team 2 objective
	{ 
		x = 1,  
		y = 11 
	},
}

-- influence map for one agent --
constants.influenceMap = {
	{0, 0, 0,  0,  0,  0, 0, 0, 0},

	{0, 0, 0,  0,  0,  0, 0, 0, 0},

	{0, 1, 1,  2,  3,  2, 1, 1, 0},

	{1, 1, 2,  4,  9,  4, 2, 1, 1},

	{2, 3, 5, 12, 15, 12, 5, 3, 2},

	{1, 1, 2,  4,  9,  4, 2, 1, 1},

	{0, 1, 1,  2,  3,  2, 1, 1, 0},

	{0, 0, 0,  0,  0,  0, 0, 0, 0},

	{0, 0, 0,  0,  0,  0, 0, 0, 0},
}

-- constants.influenceMap = {
-- 	{0, 0,  0,  0,  0,  0, 0, 0, 0},

-- 	{0, 0,  0,  0,  5,  0, 0, 0, 0},

-- 	{0, 0,  5, 18, 32, 18,  5, 0, 0},

-- 	{0, 0, 18, 64, 99, 64, 18, 0, 0},

-- 	{0, 0, 32, 99, 99, 99, 32, 0, 0},

-- 	{0, 0, 18, 64, 99, 64, 18, 0, 0},

-- 	{0, 0,  5, 18, 32, 18,  5, 0, 0},

-- 	{0, 0,  0,  0,  5,  0,  0, 0, 0},

-- 	{0, 0,  0,  0,  0,  0,  0, 0, 0},
-- }

return constants