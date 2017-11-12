local Agent = {}

local function init()
	-- body
end

function Agent:new(x, y, team, grid)
	local agent = {}
	agent = display.newImage("balloon.png")

	agent.objective = {}

	return agent
end

return Agent