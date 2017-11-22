-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local Grid      = require("Grid")
local Agent     = require("Agent")
local constants = require("constants")
local widget    = require( "widget" )


cellWidth  = constants.cellWidth
cellHeight = constants.cellHeight
gridWidth  = constants.gridWidth
gridHeight = constants.gridHeight

objectives = constants.objectives

local agents = {}
local mainTimer 

----------------------
-- HELPER FUNCTIONS --
----------------------

-- calculates distance between two points
function distance(x1, y1, x2, y2)
	local dist = math.ceil(math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2)))
	return dist--math.min(math.abs(x1 - x2), math.abs(y1 - y2))
end

-- converts grid coordinates to pixel coordinates
function getPixelCoordinates(x, y)
	actX = (x - 1) * cellWidth + (cellWidth * 0.5)
	actY = (y - 1) * cellHeight + (cellHeight * 0.5)

	return actX, actY
end

-- shuffles table
function shuffle(table)
  size = #table
  for i = size, 1, -1 do
    local rand = math.random(size)
    table[i], table[rand] = table[rand], table[i]
  end
  return table
end

----------------
----- MAIN -----
----------------

local function setup()
	-- Create Grid --

	grid = Grid.new(gridParams)

	-- Add objective marks to cells --
	for i=1,2 do
		local objective = grid[objectives[i].y][objectives[i].x]

		for _,cell in ipairs(grid[objectives[i].y][objectives[i].x]:getNeighbors()) do
			cell.isObjective[i] = true
			cell.rect:setFillColor(1, 0, 0, 0.5)
		end
		objective.rect:setFillColor(1, 0, 0, 1)
	end

end

local function start()
    -- create 50 agents --
	if mainTimer then
		timer.cancel(mainTimer)
		mainTimer = nil
	end
	mainTimer = timer.performWithDelay(constants.spawnInterval, function() 

		local objective1 = shuffle(grid[objectives[2].y][objectives[2].x]:getNeighbors())
		local objective2 = shuffle(grid[objectives[1].y][objectives[1].x]:getNeighbors())

		for i,cell in ipairs(objective1) do
			if cell.isEmpty and not cell.isWall then
				local agent = Agent:new(cell.xPos, cell.yPos, 1)
				agent:init()
				table.insert(agents, agent)
				break
			end
		end

		for i,cell in ipairs(objective2) do
			if cell.isEmpty then
				local agent = Agent:new(cell.xPos, cell.yPos, 2)
				agent:init()
				table.insert(agents, agent)
				break
			end
		end
	 end, 70)

end

 
-- Function to handle button events
local function reset( event )
    if ( "ended" == event.phase ) then

        -- remove agents
        for _,agent in ipairs(agents) do
        	if agent then
				timer.cancel(agent.timer)
				display.remove(agent)
				agent = nil	
        	end 
        end
        agents = {}
        --reset cells
	    for i = 1, gridHeight do
			for j = 1, gridWidth do
				display.remove(grid[i][j])
				grid[i][j] = nil
			end
			grid[i] = nil
		end
		grid = nil
		setup()
        start()

    end

end
 
-- Draw background and button and start simulation

local background = display.newImageRect("grass.png", display.contentWidth, display.contentHeight)
background.x = display.contentCenterX
background.y = display.contentCenterY

-- Create the widget
local button1 = widget.newButton(
    {
		label        = "Reset\nSimulation",
		labelAlign   = "center",
		emboss       = false,
		-- Properties for a rounded rectangle button
		shape        = "roundedRect",
		width        = 130,
		fontSize     = 28,
		height       = 70,
		cornerRadius = 6,
		labelColor   = { default={ 1, 1,  1, 1}, over={ 0, 0, 0, 0.5 } },
		fillColor    = { default={ 1, 0,  0, 1}, over={1,0.1,0.7,0.4} },
		strokeColor  = { default={ 1, 0.4,0, 1}, over={0.8,0.8,1,1} },
		strokeWidth  = 4,
		onEvent      = reset,
    }
)
button1.x = display.contentWidth - button1.width*0.5 - 5
button1.y = 80


setup()
start()
