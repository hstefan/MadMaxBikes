local level = require 'level'

local testst = {}

local win_w, win_h = love.graphics.getDimensions()

function testst:create_player(p, x, y)
	local object = {}
	if p == 1 then
		object.color = { 255, 255, 40 }
		object.keys = { left = 'left', right = 'right', up = 'up' }
	else
		object.color = { 255, 40, 255 }
		object.keys = { left = 'a', right = 's', up = 'w' }
	end
	object.body = love.physics.newBody(level.world, x, y, "dynamic")
	object.shape = love.physics.newRectangleShape(30, 60)
	object.fixture = love.physics.newFixture(object.body, object.shape)
	object.fixture:setRestitution(0.3)

	function object:update(dt)
		if love.keyboard.isDown(self.keys.left) then
			self.body:applyLinearImpulse(-15, 0)
		end
		if love.keyboard.isDown(self.keys.right) then
			self.body:applyLinearImpulse(15, 0)
		end
		if love.keyboard.isDown(self.keys.up) then
			self.body:applyLinearImpulse(0, -10)
		end
	end

	function object:draw()
		love.graphics.setColor(self.color)
		love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
	end

	return object
end

function testst:init()
	level:load_map('map_placeholder.lua')
	self.p1 = self:create_player(1, win_w/3, 30)
	self.p2 = self:create_player(2, win_w/3*2, 30)
end

function testst:draw()
	p1_x, p1_y = self.p1.body:getPosition()
	p2_x, p2_y = self.p2.body:getPosition()
	scroll_x = (p1_x + p2_x) / 2
	scroll_y = (p1_y + p2_y) / 2
	dist_x = (math.abs(p1_x - p2_x)) * 1.25
	dist_y = (math.abs(p1_y - p2_y)) * 1.25
	distance = math.max(dist_x, dist_y, 384) / math.min(win_w, win_h)
	love.graphics.origin()
	love.graphics.translate(win_w / 2, win_h / 2)
	love.graphics.scale(1 / distance)
	love.graphics.translate(-scroll_x, -scroll_y)

	self.p1:draw()
	self.p2:draw()
	love.graphics.setColor(255, 255, 255)
	level:draw_layer(level.layers['Objects'])
end

function testst:update(dt)
	level.world:update(dt)
	self.p1:update(dt)
	self.p2:update(dt)
end

return testst
