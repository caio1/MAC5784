local constants = {}

--time

constants.freezeTime       = 3000
constants.spawnInterval    = 200
constants.transitionTime   = 120
constants.movementInterval = {
	["attack"] = 300,
	["defense"] = 200,
	["return"] = 300,
}

constants.cellWidth  = 25
constants.cellHeight = 25
constants.gridWidth  = 45
constants.gridHeight = 28

constants.objectives = {
	-- team 1 objective
	{
		x = constants.gridWidth - 1 ,
		y = math.floor(constants.gridHeight/2)
	},
	-- team 2 objective
	{
		x = 2 ,
		y = math.floor(constants.gridHeight/2)
	},
}

-- this is the influence map for one agent's neighbors --
constants.influenceMap = {
	{ 0,  0,  0,  1,  2,  3,  2,  1,  0,  0,  0},

	{ 0,  0,  1,  2,  3,  4,  3,  2,  1,  0,  0},

	{ 0,  1,  2,  3,  4,  9,  4,  3,  2,  1,  0},

	{ 1,  2,  3,  4,  6, 10,  6,  4,  3,  2,  0},

	{ 2,  3,  4,  6, 10, 12, 10,  6,  4,  3,  0},

	{ 3,  4,  6, 10, 12, 15, 12, 10,  6,  4,  3},

	{ 2,  3,  4,  6, 10, 12, 10,  6,  4,  3,  0},

	{ 1,  2,  3,  4,  6, 10,  6,  4,  3,  2,  0},

	{ 0,  1,  2,  3,  4,  6,  4,  3,  2,  1,  0},

	{ 0,  0,  1,  2,  3,  4,  3,  2,  1,  0,  0},

	{ 0,  0,  0,  1,  2,  3,  2,  1,  0,  0,  0},
}

-- Defense
constants.defAgents = {
	{x = 4, y = 8},
	{x = 4, y = 20},
	{x = 7, y = 10},
	{x = 7, y = 18},
	{x = 9, y = 14},
}
-- Attack
constants.atkAgents ={
	{x = 18, y = 5},
	{x = 18, y = 10},
	{x = 18, y = 14},
	{x = 18, y = 18},
	{x = 18, y = 23},
}


return constants