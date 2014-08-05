local gamestate = require "hump.gamestate"
local gamest = require "gamest"

function table.contains(t, val)
	for _, v in ipairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

function love.draw()
end

function love.load()
	gamestate.registerEvents()
	gamestate.switch(gamest)
end

