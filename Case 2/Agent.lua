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
local function addInfluence(baseCell, team, agentType, signal)

	local y = baseCell.yPos
	local x = baseCell.xPos
	local otherTeam = math.fmod(team, 2) + 1

	local size = math.floor(#constants.influenceMap/2)

	for i=-size, size do
		for j=-size, size do
			if grid[y + i] and grid[y + i][x + j] and not grid[y + i][x + j].isWall then
				local cell = grid[y + i][x + j]
				local influence = signal*constants.influenceMap[i + size + 1][j + size + 1]

				if agentType == "defense" then
					cell.influenceAtk[team] = cell.influenceAtk[team] - influence
					cell.influenceRet[team] = cell.influenceRet[team] - influence
				elseif  agentType == "return" then
					cell.influenceAtk[team] = cell.influenceAtk[team] - influence/100
					cell.influenceRet[team] = cell.influenceRet[team] - influence/100
					cell.influenceDef[team] = cell.influenceDef[team] + influence/10
					cell.influenceDef[otherTeam] = cell.influenceDef[otherTeam] - influence/10
				elseif  agentType == "attack" then
					cell.influenceAtk[team] = cell.influenceAtk[team] - influence/200
					cell.influenceRet[team] = cell.influenceRet[team] - influence/100
					cell.influenceDef[team] = cell.influenceDef[team] + influence/10
				end

			end
		end
	end
end

local function reachedObjective(agent)
	return agent.cell.isObjective[agent.type][agent.team]
end

local function freeze(agent)
	agent.frozen = true
	addInfluence(agent.cell, math.fmod(agent.team, 2) + 1, agent.type, -1)
	agent.alpha = 0.5
	timer.performWithDelay(constants.freezeTime, function()
		agent.frozen = false
		agent.alpha = 1
		addInfluence(agent.cell, math.fmod(agent.team, 2) + 1, agent.type, 1)
	end)
end

local function canFreeze(agent1, agent2)
	return agent1.team ~= agent2.type and
			agent1.type == "defense" and
			agent2.team == math.fmod(agent1.team, 2) + 1
end

local function move(agent)

	local neighbors = agent.cell:getNeighbors()

	table.sort(neighbors, function(cell1, cell2)
		return compare(agent, cell1, cell2)
	end)


	for i, neighbor in ipairs(neighbors) do
		if not neighbor.isEmpty and canFreeze(agent, neighbor.agentInCell) then

			neighbor.agentInCell:freeze()

		elseif (neighbor.isEmpty or neighbor == agent.cell) and not neighbor.isWall then

			agent.cell.isEmpty = true
			agent.cell.agentInCell = nil
			neighbor.isEmpty = false
			neighbor.agentInCell = agent

			addInfluence(agent.cell, math.fmod(agent.team, 2) + 1, agent.type, -1)

			agent.xPos = neighbor.xPos
			agent.yPos = neighbor.yPos

			agent.cell = neighbor


			local x, y = getPixelCoordinates(neighbor.xPos, neighbor.yPos)

			transition.to(agent, {
				time = constants.transitionTime,
				x = x,
				y = y,
				onComplete = function ()
					if reachedObjective(agent) then
						if agent.type == "attack" then
							agent.type = "return"
							agent.xScale = -1
							addInfluence(neighbor, math.fmod(agent.team, 2) + 1, agent.type, 1)
						else
							agent.cell.isEmpty = true
							agent.cell.agentInCell = nil
							atkAgents[agent.team] = atkAgents[agent.team] - 1
							if atkAgents[agent.team] == 0 then
								endSimulation(agent.team)
							end
							timer.cancel(agent.timer)
							display.remove(agent)
							agent = nil
						end
					else
						addInfluence(neighbor, math.fmod(agent.team, 2) + 1, agent.type, 1)
					end
				end
			})
			break
		end
	end

end


local function init(agent)
	agent.timer = timer.performWithDelay(constants.movementInterval[agent.type], function()
		if not agent.frozen then
			agent:move()
		end
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
	agent.cell.agentInCell = agent
	--

	agent.x, agent.y = getPixelCoordinates(x, y)


	agent.objective = objectives[team]
	agent.frozen = false

	agent.init         = init
	agent.freeze       = freeze
	agent.move         = function() move(agent, grid) end

	addInfluence(agent.cell, math.fmod(agent.team, 2) + 1, agent.type, 1)

	return agent
end

return Agent