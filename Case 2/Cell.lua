-- Returns a table containing for each objective, 
-- the distance from this cell to that objective
local function distanceToObjectives(cell)
	local distToObjectives = {}

	for i, obj in ipairs(objectives) do
		--local dist = {}
		--for _,neighbor in ipairs(grid[obj.y][obj.x]:getNeighbors()) do
		-- 	dist.insert(distance(cell.xPos, cell.yPos, obj.x, obj.y))
		-- end
		-- table.insert(distToObjectives, math.min(unpack(dist)))
		table.insert(distToObjectives, distance(cell.xPos, cell.yPos, obj.x, obj.y))
	end

	return distToObjectives
end

-- Returns the cell and its neighbors

local function getNeighbors(cell)
	local x = cell.xPos
	local y = cell.yPos

	local neighbors = {}
	for i=-1, 1 do
		for j=-1, 1 do
			if grid[y + i] and grid[y + i][x + j] and not grid[y + i][x + j]. isWall then
				table.insert(neighbors, grid[y + i][x + j])
			end
		end
	end

	return neighbors

end

---------------------------------------
local function drawRect(cell, x, y, cellType)
	local actX, actY = getPixelCoordinates(x, y)

	local rect = display.newRect(actX, actY, cellWidth, cellHeight )
	rect.strokeWidth = 1
	rect:setStrokeColor( 0, 0, 0, 0.1 )
	rect:setFillColor(1, 1, 1, 0)

	if cellType == 1 then
		rect:setFillColor( 0.5 )
	elseif cellType == 2 then
		rect:setFillColor(0.5, 0, 0.5, 0.2)	
	end
	cell:insert(rect)
	cell.rect = rect
end

local function deleteRect(cell)
	display.remove(cell.rect)
	cell.rect = nil
end

local function new(x, y, cellType)
	local cell = display.newGroup()

	cell.xPos = x
	cell.yPos = y
	cell.isWall = cellType == 1

	drawRect(cell, x, y, cellType)
	cell.isEmpty = true
	cell.agentInCell = nil

	cell.distToObjectives = distanceToObjectives(cell)

	cell.isObjective = {}

	cell.isObjective["attack"]  = {false, false}
	cell.isObjective["defense"] = {false, false}
	cell.isObjective["return"]  = {false, false}
	

	if cell.isWall then
		cell.influenceAtk = {-1, -1}
		cell.influenceDef = {0, 0}
		cell.influenceRet = {-1, -1}
	else
		if cellType == 2 then
			cell.influenceDef = {-1000, -1000}
		else
			cell.influenceDef = {0, 0}
		end
		cell.influenceRet = {10/math.log(cell.distToObjectives[2] + 1.5), 10/math.log(cell.distToObjectives[1] + 1.5)}
		cell.influenceAtk = {10/math.log(cell.distToObjectives[1] + 1.5), 10/math.log(cell.distToObjectives[2] + 1.5)}
	end

	cell.getNeighbors = getNeighbors
	cell.deleteRect = deleteRect

	return cell
end

local Cell = {}
Cell.new = new
return Cell