local gamestate = require "hump.gamestate"
local gamest = require "gamest"
local testst = require "testst"

function love.draw()
end

function love.load()
	gamestate.registerEvents()
	gamestate.switch(testst)
end

