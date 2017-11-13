local Cell = require("Cell")




local gbOffsetX = display.contentCenterX - ( display.contentWidth * 0.5 ) 
local gbOffsetY = display.contentCenterY - ( display.contentHeight * 0.5 )

local function getActualCoordinates(grid, x, y)
	actX = (x - 1) * grid.cellWidth + (grid.cellWidth * 0.5) --+ gbOffsetX
	actY = (y - 1) * grid.cellHeight + (grid.cellHeight * 0.5) --+ gbOffsetY

	return actX, actY
end

local function distance(x1, y1, x2, y2)
	return math.sqrt(math.pow(x1 - x2, 2), math.pow(y1 - y2, 2))
end

local function getNeighbors(grid, x, y)

end


local function spawnPiece(grid, xPos, yPos, pieceType )
	if xPos < 1 or xPos > grid.width or yPos < 1 or yPos > grid.height then
		print( "Position out of range:", xPos, yPos )
		return nil
	end

	local piece = display.newImageRect( "cat"..pieceType.. ".png", grid.cellWidth, grid.cellHeight )
	--
	-- record the pieces logical position on the board
	--
	piece.xPos = xPos
	piece.yPos = yPos
	--
	-- Position the piece
	--
	piece.x = (xPos - 1) * grid.cellWidth + (grid.cellWidth * 0.5) + gbOffsetX
	piece.y = (yPos - 1) * grid.cellHeight + (grid.cellHeight * 0.5) + gbOffsetY

	return piece
end

local function movePiece(grid, piece, xPos, yPos )
	-- check to see if the position is occupied.  You can do either:
	-- 1. "Capture the piece".  This would involve removeing the piece 
	--    that is there before moving to the spot or
	-- 2. "Reject the move" because the spot is occupied.  For the purpose
	--    of this tutorial we will reject the move.
	--
	if xPos < 1 or xPos > grid.width or yPos < 1 or yPos > grid.height then
		return false
	end
	if grid[yPos][xPos] == nil then -- got an empty spot
		--
		-- get the screen x, y for where we are moving to
		--
		local x = (xPos - 1) * grid.cellWidth + (grid.cellWidth * 0.5) + gbOffsetX
		local y = (yPos - 1) * grid.cellHeight + (grid.cellHeight * 0.5) + gbOffsetY
		--
		-- save the old grid x, y
		--
		local oldXPos = piece.xPos
		local oldYPos = piece.yPos
		--
		-- Move the object in the table
		--
		grid[yPos][xPos] = piece
		grid[yPos][xPos].xPos = xPos
		grid[yPos][xPos].yPos = yPos
		grid[oldYPos][oldXPos] = nil
		--
		-- Now move the physical graphic
		--
		transition.to(grid[yPos][xPos], { time = 500, x = x, y = y})
		return true
	end
end


local function init(grid)
	local lastObject 

	for i = 1, 10 do
		local xPos = math.random( 1, grid.width )
		local yPos = math.random( 1, grid.height )
		local color = "red"
		if math.random(2) == 2 then
			color = "white"
		end
		grid[yPos][xPos] = grid:spawnPiece(xPos, yPos, color, background)
		lastObject = grid[yPos][xPos]
	end

	timer.performWithDelay(2000, function() grid:movePiece( lastObject, 4, 5); end, 400)
end


local function new(params)
	local grid = {}

	grid.height     = params.height
	grid.width      = params.width
	grid.cellWidth  = params.cellWidth
	grid.cellHeight = params.cellHeight


	grid.init = init

	for i = 1, grid.height do
		grid[i] = Cell.new()
	end

	grid.movePiece = movePiece
	grid.spawnPiece = spawnPiece
	grid.getActualCoordinates = getActualCoordinates

	return grid
end




local Grid = {}
Grid.new = new
return Grid