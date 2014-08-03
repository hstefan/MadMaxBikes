local level = require 'level'
local mod = {}

local tspawn = 5 --time to create new powerup
local tacc = 0
local ids = { 'shield-passive', 'shield-aggresive', 'spear-long', 'spear-short' }
local spawnedPowerups = { }

function mod:rand_powerup()
	local p = {}

	local pos = level.powerupSpawns[math.random(1, #level.powerupSpawns)]
	p.base = love.physics.newBody(level.world, pos.x, pos.y - 50, "kinematic")
	p.body = love.physics.newBody(level.world, pos.x, pos.y, "dynamic")
	p.shape = love.physics.newCircleShape(16)
	p.joint = love.physics.newDistanceJoint(p.body, p.base, p.body:getX(), p.body:getY(), p.base:getX(), p.base:getY(), false)
	p.fixture = love.physics.newFixture(p.body, p.shape)
	p.fixture:setRestitution(1)
	p.image = love.graphics.newImage('data/images/powerup-' .. ids[math.random(1, #ids)] .. '.png')
	
	function p:update(dt)
		if self.timetodie ~= nil then
			if self.timetodie <= 0 then
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
		spawnedPowerups[#spawnedPowerups + 1] = self:rand_powerup()
		spawnedPowerups[#spawnedPowerups].index = #spawnedPowerups
		tacc = 0
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
