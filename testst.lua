local level = require 'level'
require 'util.console'

local testst = {}

local win_w, win_h = love.graphics.getDimensions()

function testst:load_background()
	self.bgs = {}
	for i = 1, 4 do
		self.bgs[i] = love.graphics.newImage('data/backgrounds/bg' .. i .. '.png')
		self.bgs[i]:setWrap('repeat', 'clamp')
	end
end

function testst:draw_background(scroll_x, scale_x)
	local rates = { 0, 0.33, 0.66, 1 }

	local distance_to_left = (0 + (win_w/2)) / scale_x - scroll_x
	local distance_to_right = (win_w + (win_w/2)) / scale_x - scroll_x
	for i, bg in ipairs(self.bgs) do
		local img_w = bg:getWidth()
		local bg_x = scroll_x * (1 - rates[i])
		local repeat_fixup = math.ceil((distance_to_left + bg_x) / img_w) * img_w

		local num_repeats = math.ceil((distance_to_right - distance_to_left) / img_w) + 1
		local quad = love.graphics.newQuad(0, 0, img_w * num_repeats, bg:getHeight(), img_w, bg:getHeight())
		love.graphics.draw(bg, quad, bg_x - repeat_fixup, 0)
	end
end

function testst:create_player(p, x, y)
	local object = {}
	if p == 1 then
		object.keys = { left = 'left', right = 'right', up = 'up' }
		object.spr_name = "data/images/chuchu-bike-1.png"
	else
		object.keys = { left = 'a', right = 's', up = 'w' }
		object.spr_name = "data/images/chuchu-bike-2.png"
	end
	object.body = love.physics.newBody(level.world, x, y, "dynamic")
	object.shape = love.physics.newCircleShape(30)
	object.fixture = love.physics.newFixture(object.body, object.shape)
	object.fixture:setFriction(40)
	object.fixture:setRestitution(0.3)
	object.bikeImage = love.graphics.newImage(object.spr_name)

	function object:update(dt)
		if love.keyboard.isDown(self.keys.left) then
			self.body:applyTorque(-12000)
		end
		if love.keyboard.isDown(self.keys.right) then
			self.body:applyTorque(12000)
		end

		if love.keyboard.isDown(self.keys.up) then
			self.body:applyForce(0, -300)
			self.body:applyTorque(1000)
		end
	end

	function object:draw()
		love.graphics.setColor(255, 255, 255)
		local b = object
		love.graphics.draw(b.bikeImage, b.body:getX(), b.body:getY(), b.body:getAngle(),  1, 1, b.bikeImage:getWidth()/2, b.bikeImage:getHeight()/2)
	end

	return object
end

function testst:init()
	level:load_map('map_placeholder.lua')
	self:load_background()
	self.p1 = self:create_player(1, win_w/3, 30)
	self.p2 = self:create_player(2, win_w/3*2, 30)
end

function testst:draw()
	local p1_x, p1_y = self.p1.body:getPosition()
	local p2_x, p2_y = self.p2.body:getPosition()
	local scroll_x = (p1_x + p2_x) / 2
	local scroll_y = (p1_y + p2_y) / 2
	local dist_x = (math.abs(p1_x - p2_x)) * 1.25
	local dist_y = (math.abs(p1_y - p2_y)) * 1.25
	local distance = math.max(dist_x, dist_y, 384) / math.min(win_w, win_h)
	local scale = 1 / distance

	love.graphics.origin()
	love.graphics.translate(win_w / 2, win_h / 2)
	love.graphics.scale(scale)
	love.graphics.translate(-scroll_x, -scroll_y)

	self:draw_background(scroll_x, scale)
	self.p1:draw()
	self.p2:draw()
	love.graphics.setColor(255, 255, 255)
	level:draw_layer(level.layers['Objects'])

	love.graphics.origin()
	console:draw()
end

function testst:update(dt)
	level.world:update(dt)
	self.p1:update(dt)
	self.p2:update(dt)
end

return testst
