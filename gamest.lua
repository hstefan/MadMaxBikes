local level = require 'level'
local powerup = require 'powerup_ctrl'
local vector = require 'hump.vector'

require 'util.console'

local gamest = {}

local conf = { fuel_time = 120, fuel_restore = 20, bomb_damage = 15 }

local win_w, win_h = love.graphics.getDimensions()
local time_limit = 240

function gamest:load_background()
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

function gamest:draw_background(i, cam_left, cam_right, cam_top, cam_bottom)
	local lvl_w = level.width
	local lvl_h = level.height

	-- in world units
	local cam_w = cam_right - cam_left
	local cam_h = cam_bottom - cam_top

	local xt = unlerp((cam_left + cam_right)/2, cam_w/2, lvl_w - cam_w/2)
	local yt = unlerp((cam_top + cam_bottom)/2, cam_h/2, lvl_h - cam_h/2)

	local bg = self.bgs[i]
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

function gamest:create_player(p, x, y)
	local object = { objtype = "player", invincibility_timer = 0, score = 0 }
	if p == 1 then
		object.keys = { left = 'left', right = 'right', up = 'up', bomb = 'down' }
		object.spr_name = "data/images/wheel.png"
		object.color = { 255, 127, 127 }
	else
		object.keys = { left = 'a', right = 'd', up = 'w', bomb = 's' }
		object.spr_name = "data/images/wheel.png"
		object.color = { 127, 127, 255 }
	end
	object.body = love.physics.newBody(level.world, x, y, "dynamic")
	object.shape = love.physics.newCircleShape(32)
	object.fixture = love.physics.newFixture(object.body, object.shape)
	object.fixture:setFriction(40)
	object.fixture:setRestitution(0.2)
	object.fixture:setGroupIndex(-p)
	object.bikeImage = love.graphics.newImage(object.spr_name)
	
	object.pilotBody = love.physics.newBody(level.world, x, y, "dynamic")
	object.pilotBody:setAngularDamping(7.5)
	object.pilotImage = love.graphics.newImage("data/images/biker.png")
	object.pilotFixture = love.physics.newFixture(object.pilotBody, object.shape)
	object.pilotFixture:setFriction(0.01)

	object.joint = love.physics.newRevoluteJoint(object.body, object.pilotBody, x, y, false)
	object.jumpcd = 0
	object.fuel = conf.fuel_time
	self.spr_scale = 1

	function object:update(dt)
		if love.keyboard.isDown(self.keys.left) then
			self.body:applyTorque(-24000)
		end
		if love.keyboard.isDown(self.keys.right) then
			self.body:applyTorque(24000)
		end

		if love.keyboard.isDown(self.keys.up) and self.jumpcd <= 0 then
			self.jumpcd = 1.5
			self.body:applyLinearImpulse(0, -650)
			self.body:applyTorque(1000)
		else
			self.jumpcd = self.jumpcd - dt
		end

		if love.keyboard.isDown(self.keys.bomb) and self.powerup == 'bomb' then
			powerup:create_bomb(self.body:getX(), self.body:getY())
			self.powerup = nil
		end

		local angle = self.pilotBody:getAngle()
		local velx, vely = self.pilotBody:getLinearVelocity()
		if velx < 0.5 then
			self.spr_scale = -1
		else
			self.spr_scale = 1
		end

		if angle > math.rad(0.5) then
			self.pilotBody:applyTorque(-7500 * angle)
		end
		if angle < math.rad(-0.5) then
			self.pilotBody:applyTorque(-7500 * angle)
		end

		if self.invincibility_timer > 0 then
			self.invincibility_timer = math.max(0, self.invincibility_timer - dt)
		end
		self.fuel = self.fuel - dt
	end

	function object:draw()
		if self.invincibility_timer <= 0 then
			love.graphics.setColor(self.color)
		else
			love.graphics.setColor(255, 0, 0)
		end
		local b = object
		love.graphics.draw(b.bikeImage, b.body:getX(), b.body:getY(), b.body:getAngle(), 1, 1,
			b.bikeImage:getWidth()/2, b.bikeImage:getHeight()/2)
		love.graphics.draw(b.pilotImage, b.body:getX(), b.body:getY(), b.pilotBody:getAngle(), self.spr_scale, 1,
			b.pilotImage:getWidth()/2, b.pilotImage:getHeight()/2)
	end

	function object:setPowerup(id)
		self.powerup = id

		if self.powerup == 'fuel' then
			self.fuel = clamp(self.fuel + conf.fuel_restore, 0, conf.fuel_time)
		end
	end

	function object:contact(o, coll)
		local od = o:getUserData()
		if od ~= nil and od.objtype == 'spear' then
			if self.invincibility_timer <= 0 and od.parent.invincibility_timer <= 0 then
				self.invincibility_timer = 3
			end
		end
	end

	function object:bomb_damage()
		self.fuel = self.fuel - conf.bomb_damage
	end

	object.fixture:setUserData(object)
	return object
end

function gamest:init()
	level:load_map('level.lua')
	self:load_background()
	self.p1 = self:create_player(1, level.width/3, 30)
	self.p2 = self:create_player(2, level.width/3*2, 30)
	console.active = false
	self.music = love.audio.newSource("data/desert_grease.mp3")
	self.music:setLooping(true)
	self.music:play()
	self.time_start = love.timer.getTime()
	self.font = love.graphics.setNewFont("data/slkscre.ttf", 24)
end

function gamest:draw()
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
	if center_y - dist_y/2 < 0 then
		center_y = dist_y/2
	end
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

	function draw_bg(bg_i)
		self:draw_background(bg_i, center_x - dist_x/2, center_x + dist_x/2, center_y - dist_y/2, center_y + dist_y/2)
	end

	love.graphics.setColor(255, 255, 255)
	draw_bg(1)
	draw_bg(2)
	draw_bg(3)

	level:draw_layer(level.layers['BgObjects'])

	draw_bg(4)
	
	self.p1:draw()
	self.p2:draw()
	powerup:draw()

	love.graphics.setColor(255, 255, 255)
	level:draw_layer(level.layers['Objects'])
	
	love.graphics.origin()
	love.graphics.setColor(255, 255, 255)
	love.graphics.setFont(self.font)
	if self.p1.fuel > 0 and self.p2.fuel > 0 then
		love.graphics.print("P1 Fuel: " .. math.ceil(100 * self.p1.fuel/conf.fuel_time) .. "%", 8, 8, 0, 1, 1)
		love.graphics.print("P2 Fuel: " .. math.ceil(100 * self.p2.fuel/conf.fuel_time) .. "%", 8, 34, 0, 1, 1)
	else
		local font = love.graphics:getFont()
		local x, y = center_text(font, "GAME_OVER", 1, win_w/2, win_h/2)
		love.graphics.print("GAME OVER", x, y, 0, 1, 1)
		local str = nil
		if self.p1.fuel > self.p2.fuel then
			str = "Player Two Out of Fuel, Player One Wins!"
		elseif self.p2.fuel > self.p2.fuel then
			str = "Player One Out of Fuel, Player Two  Wins!"
		else
			str = "Both Players Out of Fuel! Draw!"
		end
		local x, y = center_text(font, str, 1, win_w/2, win_h/2 + 48)
		love.graphics.print(str, x, y, 0, 1, 1)
	end

	console:draw()
end

function center_text(font, str, scale, x, y)
	return x - font:getWidth(str) * scale / 2, y - font:getHeight(str) * scale / 2
end

function gamest:update(dt)
	local elapsed_time = love.timer.getTime() - self.time_start
	self.game_running = self.p1.fuel > 0 and self.p2.fuel > 0

	if self.game_running then
		level.world:update(dt)
		powerup:update(dt)
		self.p1:update(dt)
		self.p2:update(dt)
	end
end

return gamest
