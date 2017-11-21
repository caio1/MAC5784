local Cell      = require("Cell")
local maps      = require("maps")
local constants = require("constants")

local function new(params)
	local grid = {}

	local gridHeight = constants.gridHeight
	local gridWidth  = constants.gridWidth

	for i = 1, gridHeight do
		grid[i] = {}
		for j = 1, gridWidth do
			grid[i][j] = Cell.new(j, i, maps["simulation1"][i][j] == 1)
		end
	end

	return grid
end

local Grid = {}
Grid.new = new
return Grid