-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local Grid = require("Grid")
local Agent = require("Agent")

local gridParams = {
	width      = 80,
	height     = 48,
	cellWidth  = 16,
	cellHeight = 16
}

local objectives = {
	{ x = 3,  y = 3 },
	{ x = 77, y = 44}
}

local background = display.newImageRect("background.png", display.contentWidth, display.contentHeight)
background.x = display.contentCenterX
background.y = display.contentCenterY

local grid = Grid.new(gridParams)
local agents = {}

timer.performWithDelay(5, function() 
	
	local xPos = math.random( 1, grid.width )
	local yPos = math.random( 1, grid.height )
	local team = math.random(2)

	local agent = Agent:new(xPos, yPos, team, grid)
	agent:init()


 end, 4000)


-- local background = display.newImageRect( "background.png", 360, 570 )
-- background.x = display.contentCenterX
-- background.y = display.contentCenterY