-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local Grid = require("Grid")

local gridParams = {
	width      = 80,
	height     = 48,
	cellWidth  = 16,
	cellHeight = 16
}

local background = display.newImageRect("background.png", display.contentWidth, display.contentHeight)
background.x = display.contentCenterX
background.y = display.contentCenterY

local grid = Grid.new(gridParams)

--grid:init()

timer.performWithDelay(20, function() 
	
	local xPos = math.random( 1, grid.width )
	local yPos = math.random( 1, grid.height )
	local color = "red"
	if math.random(2) == 2 then
		color = "white"
	end
	grid[yPos][xPos] = grid:spawnPiece(xPos, yPos, math.random(2))

 end, 4000)


-- local background = display.newImageRect( "background.png", 360, 570 )
-- background.x = display.contentCenterX
-- background.y = display.contentCenterY