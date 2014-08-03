local level = require 'level'
require 'util.console'

local testst = {}

local win_w, win_h = love.graphics.getDimensions()

function testst:load_background()
	self.bgs = {}
	for i = 1, 4 do
		self.bgs[i] = love.graphics.newImage('data/backgrounds/bg' .. i .. '.png')
	end
end

function unlerp(x, min_x, max_x)
	if min_x == max_x then
		return 0
	end
	return (x - min_x) / (max_x - min_x)
end

function lerp(t, min_x, max_x)
	return (1-t)*min_x + t*max_x
end

function clamp(t, min, max)
	if t < min then
		t = min
	end
	if t > max then
		t = max
	end
	return t
end

function testst:draw_background(scroll_x, scroll_y)
	local lvl_w = level.width
	local lvl_h = level.height

	local scroll_tx = unlerp(scroll_x, win_w/2, lvl_w - win_w/2)
	local scroll_ty = unlerp(scroll_y, win_h/2, lvl_h - win_h/2)
	scroll_tx = clamp(scroll_tx, 0, 1)
	scroll_ty = clamp(scroll_ty, 0, 1)

	console:log(scroll_tx)

	for i, bg in ipairs(self.bgs) do
		local bg_w = bg:getWidth()
		local bg_h = bg:getHeight()

		local bg_x = lerp(scroll_tx, 0, bg_w - win_w)
		local bg_y = lerp(scroll_ty, 0, bg_h - win_h)

		love.graphics.draw(bg, -bg_x, 0)
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
	local border = 384

	function limit_x(x)
		return clamp(x, win_w/2, level.width - win_w/2)
	end
	function limit_y(y)
		return clamp(y, win_h/2, level.height - win_h/2)
	end

	local p1_x, p1_y = self.p1.body:getPosition()
	local p2_x, p2_y = self.p2.body:getPosition()

	local center_x = (p1_x + p2_x) / 2
	local dist_x = math.abs(p1_x - p2_x)
	local center_y = (p1_y + p2_y) / 2
	local dist_y = math.abs(p1_y - p2_y)

	local scale_x = win_w / dist_x
	local scale_y = win_h / dist_y
	local min_scale_x = win_w / level.width
	local min_scale_y = win_h / level.height
	local scale = math.max(math.min(scale_x, scale_y), min_scale_x, min_scale_y)
	dist_x = win_w / scale
	dist_y = win_h / scale

	if center_x - dist_x/2 < 0 then
		center_x = dist_x/2
	end
	if center_y - dist_y/2 < 0 then
		center_y = dist_y/2
	end
	if center_x + dist_x/2 > level.width then
		center_x = level.width - dist_x/2
	end
	if center_y + dist_y/2 > level.height then
		center_y = level.height - dist_y/2
	end

	self:draw_background(center_x, center_y, scale)

	love.graphics.origin()
	love.graphics.translate(win_w / 2, win_h / 2)
	love.graphics.scale(scale)
	love.graphics.translate(-center_x, -center_y)

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
