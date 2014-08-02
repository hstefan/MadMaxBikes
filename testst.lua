local level = require 'level'

local testst = {}

local ww, wh = love.graphics.getDimensions()

function testst:init()
	level:load_map('map_placeholder.lua')
	self.world = level.world
	self.object = { }
	self.object.body = love.physics.newBody(self.world, ww/2, 30, "dynamic")
	self.object.shape = love.physics.newRectangleShape(30, 60)
	self.object.fixture = love.physics.newFixture(self.object.body, self.object.shape)
	self.object.fixture:setRestitution(0.3)
end

function testst:draw()
	love.graphics.setColor(255, 255, 40)
	love.graphics.polygon('fill', self.object.body:getWorldPoints(self.object.shape:getPoints()))
	love.graphics.setColor(255, 255, 255)
	level:draw_layer(level.layers['Objects'])
end

function testst:update(dt)
	self.world:update(dt)
	if love.keyboard.isDown('up') then
		self.object.body:applyLinearImpulse(0, -60)
	end
end

return testst
