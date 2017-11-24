local Cell      = require("Cell")
local maps      = require("maps")
local constants = require("constants")

local function new()
	local grid = {}

	local gridHeight = constants.gridHeight
	local gridWidth  = constants.gridWidth

	for i = 1, gridHeight do
		grid[i] = {}
		for j = 1, gridWidth do
			grid[i][j] = Cell.new(j, i, maps["simulation2"][i][j])
		end
	end

	return grid
end

local Grid = {}
Grid.new = new
return Grid