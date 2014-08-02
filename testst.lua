local level = require 'level'

local testst = {}

local win_w, win_h = love.graphics.getDimensions()

function testst:init()
	level:load_map('map_placeholder.lua')
	self.world = level.world
	self.object = { }
	self.object.body = love.physics.newBody(self.world, win_w/2, 30, "dynamic")
	self.object.shape = love.physics.newRectangleShape(30, 60)
	self.object.fixture = love.physics.newFixture(self.object.body, self.object.shape)
	self.object.fixture:setRestitution(0.3)
end

function testst:draw()
	scroll_x, scroll_y = self.object.body:getPosition()
	scroll_x = scroll_x - win_w / 2
	scroll_y = scroll_y - win_h / 2
	love.graphics.origin()
	love.graphics.translate(-scroll_x, -scroll_y)

	love.graphics.setColor(255, 255, 40)
	love.graphics.polygon('fill', self.object.body:getWorldPoints(self.object.shape:getPoints()))
	love.graphics.setColor(255, 255, 255)
	level:draw_layer(level.layers['Objects'])
end

function testst:update(dt)
	self.world:update(dt)
	if love.keyboard.isDown('left') then
		self.object.body:applyLinearImpulse(-15, 0)
	end
	if love.keyboard.isDown('right') then
		self.object.body:applyLinearImpulse(15, 0)
	end
	if love.keyboard.isDown('up') then
		self.object.body:applyLinearImpulse(0, -10)
	end
end

return testst
