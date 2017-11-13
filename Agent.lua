local Agent = {}

local gbOffsetX = display.contentCenterX - ( display.contentWidth * 0.5 ) 
local gbOffsetY = display.contentCenterY - ( display.contentHeight * 0.5 )

local function move(agent, grid)
	
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


local function init()
	
end

function Agent:new(x, y, team, grid)
	local agent = display.newImageRect( "cat" ..team.. ".png", grid.cellWidth, grid.cellHeight )

	agent.xPos = x
	agent.yPos = y
	--

	agent.x, agent.y = grid:getActualCoordinates(x, y)

	--agent.x = (x - 1) * grid.cellWidth + (grid.cellWidth * 0.5) + gbOffsetX
	--agent.y = (y - 1) * grid.cellHeight + (grid.cellHeight * 0.5) + gbOffsetY

	agent.objective = grid.objective

	agent.init = init

	return agent
end

return Agent