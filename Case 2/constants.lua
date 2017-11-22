local constants = {}

--time

constants.spawnInterval    = 200
constants.movementInterval = 150
constants.transitionTime   = 80

constants.cellWidth  = 25
constants.cellHeight = 25
constants.gridWidth  = 45
constants.gridHeight = 28

constants.objectives = {
	-- team 1 objective
	{ 
		x = constants.gridWidth - 2 , 
		y = math.floor(constants.gridHeight/2)
	},
	-- team 2 objective
	{ 
		x = 3 , 
		y = math.floor(constants.gridHeight/2)
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

constants.agentPos = {
	{x = 12, y = 12}
}


return constants