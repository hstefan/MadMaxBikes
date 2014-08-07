local gamestate = require "hump.gamestate"
local mod = {}

function mod:init()
	mod.sprite = love.graphics.newImage('data/images/tutorial.png')
end

function mod:draw()
	love.graphics.draw(mod.sprite)
end

function mod:mousereleased(x, y, m)
	gamestate.switch(mod.nextState)
end

return mod
