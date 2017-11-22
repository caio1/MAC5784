local Agent = {}

local constants = require("constants")


local function compare(agent, cell1, cell2)
	if cell1 and cell2 then

		local influence1
		local influence2

		if agent.type == "attack" then
			influence1 = cell1.influenceAtk[agent.team]
			influence2 = cell2.influenceAtk[agent.team]
		elseif agent.type == "defense" then
			influence1 = cell1.influenceDef[agent.team]
			influence2 = cell2.influenceDef[agent.team]
		else
			influence1 = cell1.influenceRet[agent.team]
			influence2 = cell2.influenceRet[agent.team]
		end

		return influence1 > influence2 or 
			(agent.type == "defense" and 
				influence1 == influence2 and 
					agent.cell == cell1)
	else
		return false
	end
end


-- adds a negative influence to the agent's 
-- influence map
local function addInfluence(agent, cell, team, signal)

	local y = cell.yPos
	local x = cell.xPos

	for i=-4, 4 do
		for j=-4, 4 do
			if grid[y + i] and grid[y + i][x + j] and not grid[y + i][x + j].isWall then
				local cell = grid[y + i][x + j]
				local influence = signal*constants.influenceMap[i + 5][j + 5]/1000
				
				cell.influenceAtk[team] = cell.influenceAtk[team] - influence
				cell.influenceRet[team] = cell.influenceRet[team] - influence
				cell.influenceDef[team] = cell.influenceDef[team] + influence
			end
		end
	end
end

local function reachedObjective(agent)
	return agent.cell.isObjective[agent.type][agent.team]
end

local function move(agent)

	local neighbors = agent.cell:getNeighbors()

	table.sort(neighbors, function(cell1, cell2) 
		return compare(agent, cell1, cell2) 
	end)


	for i, neighbor in ipairs(neighbors) do
		if (neighbor.isEmpty or neighbor == agent.cell) and not neighbor.isWall then

			agent.cell.isEmpty = true
			neighbor.isEmpty = false

			agent:addInfluence(agent.cell, math.fmod(agent.team, 2) + 1, -1)

			agent.xPos = neighbor.xPos
			agent.yPos = neighbor.yPos

			agent.cell = neighbor


			local x, y = getPixelCoordinates(neighbor.xPos, neighbor.yPos)
			-- agent.x, agent.y = getPixelCoordinates(neighbor.x, neighbor.y)
			-- if reachedObjective(agent) then
			-- 	removeInfluence(agent.cell, math.fmod(agent.team, 2) + 1)
			-- 	grid[agent.yPos][agent.xPos].isEmpty = true
			-- 	timer.cancel(agent.timer)
			-- 	display.remove(agent)
			-- 	agent = nil
			-- end

			transition.to(agent, { 
				time = constants.transitionTime, 
				x = x, 
				y = y, 
				onComplete = function ()
					if reachedObjective(agent) then
						if agent.type == "attack" then
							agent.type = "return"
							agent.xScale = -1
							agent:addInfluence(neighbor, math.fmod(agent.team, 2) + 1, 1)
						end
						-- agent.cell.isEmpty = true
						-- timer.cancel(agent.timer)
						-- display.remove(agent)
						-- agent = nil
					else
						agent:addInfluence(neighbor, math.fmod(agent.team, 2) + 1, 1)
					end
				end
			})
			break
		end
	end

end


local function init(agent)
	agent.timer = timer.performWithDelay(constants.movementInterval, function() 
		agent:move()
 	end, -1)
end

function Agent:new(x, y, team, agentType)
	local agent = display.newImageRect( "cat" ..team.. ".png", cellWidth, cellHeight )
	if agentType == "defense" then
		agent:setFillColor(0, 0, team-1, 1)
	end
	agent.xPos = x
	agent.yPos = y
	agent.team = team
	agent.type = agentType

	agent.cell = grid[agent.yPos][agent.xPos]
	agent.cell.isEmpty = false
	--

	agent.x, agent.y = getPixelCoordinates(x, y)


	agent.objective = objectives[team]

	agent.init = init
	agent.move = function() move(agent, grid) end
	agent.addInfluence = addInfluence

	agent:addInfluence(agent.cell, math.fmod(agent.team, 2) + 1, 1)

	return agent
end

return Agent