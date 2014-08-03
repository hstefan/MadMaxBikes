local level = require 'level'
local powerup = require 'powerup_ctrl'
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

function testst:draw_background(cam_left, cam_right, cam_top, cam_bottom)
	local lvl_w = level.width
	local lvl_h = level.height

	-- in world units
	local cam_w = cam_right - cam_left
	local cam_h = cam_bottom - cam_top

	local xt = unlerp((cam_left + cam_right)/2, cam_w/2, lvl_w - cam_w/2)
	local yt = unlerp((cam_top + cam_bottom)/2, cam_h/2, lvl_h - cam_h/2)

	for i, bg in ipairs(self.bgs) do
		local bg_w = bg:getWidth()
		local bg_h = bg:getHeight()

		local scroll_factor_x = unlerp(bg_w, win_w, lvl_w)
		local scroll_factor_y = unlerp(bg_h, win_h, lvl_h)
		-- in level units
		local edge_w = lerp(scroll_factor_x, cam_w/2, lvl_w/2)
		local edge_h = lerp(scroll_factor_y, cam_h/2, lvl_h/2)

		-- in level units
		local local_pos_x = lerp(xt, 0, lvl_w - edge_w*2)
		local local_pos_y = lerp(yt, 0, lvl_h - edge_h*2)

		local scale = (edge_w*2)/bg_w
		love.graphics.draw(bg, local_pos_x, local_pos_y, 0, scale)
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
		love.graphics.draw(b.bikeImage, b.body:getX(), b.body:getY(), b.body:getAngle(), 1, 1,
			b.bikeImage:getWidth()/2, b.bikeImage:getHeight()/2)
	end

	function object:setPowerup(id)
		self.powerup = id
	end

	object.fixture:setUserData({ isPlayer = true, o = object })
	return object
end

function testst:init()
	level:load_map('level.lua')
	self:load_background()
	self.p1 = self:create_player(1, level.width/3, 30)
	self.p2 = self:create_player(2, level.width/3*2, 30)
	console.active = false
	self.music = love.audio.newSource("data/desert_grease.mp3")
	self.music:setLooping(true)
	self.music:play()
end

function testst:draw()
	local border = 384

	function limit_x(x)
		return clamp(x, 0, level.width)
	end
	function limit_y(y)
		return clamp(y, -1024, level.height)
	end

	local p1_x, p1_y = self.p1.body:getPosition()
	local p2_x, p2_y = self.p2.body:getPosition()
	p1_x = limit_x(p1_x); p1_y = limit_y(p1_y)
	p2_x = limit_x(p2_x); p2_y = limit_y(p2_y)

	local center_x = (p1_x + p2_x) / 2
	local dist_x = math.abs(p1_x - p2_x) + border
	local center_y = (p1_y + p2_y) / 2
	local dist_y = math.abs(p1_y - p2_y) + border

	local scale_x = win_w / dist_x
	local scale_y = win_h / dist_y
	local min_scale_x = win_w / level.width
	local min_scale_y = win_h / level.height
	local scale = math.max(math.min(scale_x, scale_y), min_scale_x)
	scale = math.min(2, scale)
	dist_x = win_w / scale
	dist_y = win_h / scale

	if center_x - dist_x/2 < 0 then
		center_x = dist_x/2
	end
	--if center_y - dist_y/2 < 0 then
	--	center_y = dist_y/2
	--end
	if center_x + dist_x/2 > level.width then
		center_x = level.width - dist_x/2
	end
	if center_y + dist_y/2 > level.height then
		center_y = level.height - dist_y/2
	end

	love.graphics.origin()
	love.graphics.translate(win_w / 2, win_h / 2)
	love.graphics.scale(scale)
	love.graphics.translate(-center_x, -center_y)

	self:draw_background(center_x - dist_x/2, center_x + dist_x/2, center_y - dist_y/2, center_y + dist_y/2)

	self.p1:draw()
	self.p2:draw()
	love.graphics.setColor(255, 255, 255)
	level:draw_layer(level.layers['Objects'])
	
	powerup:draw()
	love.graphics.origin()
	console:draw()
end

function testst:update(dt)
	level.world:update(dt)
	powerup:update(dt)
	self.p1:update(dt)
	self.p2:update(dt)
end

return testst
