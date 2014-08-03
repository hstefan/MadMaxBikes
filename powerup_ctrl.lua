local level = require 'level'
local mod = {}

local tspawn = 5 --time to create new powerup
local tacc = 0
local ids = { 'shield-passive', 'shield-aggresive', 'spear-long', 'spear-short' }
local spawnedPowerups = { }

function mod:get_powerup_spawn()
	local choices = {}
	for k, v in pairs(level.powerupSpawns) do
		if not v.occupied then
			table.insert(choices, v)
		end
	end

	if table.getn(choices) > 0 then
		local i = math.random(table.getn(choices))
		return choices[i]
	else
		return nil
	end
end

function mod:rand_powerup()
	local p = {}

	local pos = self:get_powerup_spawn()
	if pos == nil then
		return
	end

	pos.occupied = true
	p.base = love.physics.newBody(level.world, pos.x, pos.y - 50, "kinematic")
	p.body = love.physics.newBody(level.world, pos.x, pos.y, "dynamic")
	p.shape = love.physics.newCircleShape(16)
	p.joint = love.physics.newDistanceJoint(p.body, p.base, p.body:getX(), p.body:getY(), p.base:getX(), p.base:getY(), false)
	p.fixture = love.physics.newFixture(p.body, p.shape)
	p.fixture:setRestitution(1)
	p.id = ids[math.random(1, #ids)]
	p.image = love.graphics.newImage('data/images/powerup-' .. p.id .. '.png')
	p.body:setMass(0.01)
	
	function p:update(dt)
		if self.timetodie ~= nil then
			if self.timetodie <= 0 then
				pos.occupied = false
				self.base:destroy()
				self.body:destroy()
				spawnedPowerups[self.index] = spawnedPowerups[#spawnedPowerups]
				spawnedPowerups[self.index].index = self.index
				spawnedPowerups[#spawnedPowerups] = nil
			else
				self.timetodie = self.timetodie - dt
			end
		end
	end

	function p:contact(other, coll)
		local od = other:getUserData()
		if od ~= nil and od.isPlayer then
			od.o:setPowerup(self.id)
			self.joint:destroy()
			self.fixture:setUserData(nil)
			self.timetodie = 1
		end
	end

	function p:draw()
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(p.image, p.body:getX(), p.body:getY(), p.body:getAngle(),  1, 1,
			p.image:getWidth()/2, p.image:getHeight()/2)
	end
	
	p.fixture:setUserData(p)
	return p
end

function mod:update(dt)
	tacc = tacc + dt
	if tacc > tspawn then
		local powerup = self:rand_powerup()
		if powerup ~= nil then
			spawnedPowerups[#spawnedPowerups + 1] = powerup
			spawnedPowerups[#spawnedPowerups].index = #spawnedPowerups
		end
		tacc = tacc - tspawn
	end
	for _, v in ipairs(spawnedPowerups) do
		v:update(dt)
	end
end

function mod:draw()
	for _, v in ipairs(spawnedPowerups) do
		v:draw(dt)
	end
end

return mod
