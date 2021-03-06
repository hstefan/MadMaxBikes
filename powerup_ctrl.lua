local level = require 'level'
local mod = {}

local tspawn = 8 --time to create new powerup
local tacc = 0
local ids = { 'fuel', 'bomb' }
local spawnedPowerups = { }
local bombs = {}

function shuffled(tab)
	local n, order, res = #tab, {}, {}
	for i=1,n do order[i] = { rnd = math.random(), idx = i } end
	table.sort(order, function(a,b) return a.rnd < b.rnd end)
	for i=1,n do res[i] = tab[order[i].idx] end
return res

end
function mod:get_powerup_spawn()
	--[[
	local choices = {}
	for k, v in pairs(level.powerupSpawns) do
		if not v.occupied then
			table.insert(choices, v)
		end
	end
	--]]

	local choices = shuffled(level.powerupSpawns)

	for _, c in ipairs(choices) do
		if not c.occupied then
			return c
		end
	end
	return nil
end

function mod:create_powerup()
	local p = { objtype = "powerup" }

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

				mod:create_powerup()
			else
				self.timetodie = self.timetodie - dt
			end
		end
	end

	function p:contact(other, coll)
		local od = other:getUserData()
		if od ~= nil and od.objtype == 'player' then
			od:setPowerup(self.id)
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

	spawnedPowerups[#spawnedPowerups + 1] = p
	spawnedPowerups[#spawnedPowerups].index = #spawnedPowerups

	return p
end

function mod:update(dt)
	tacc = tacc + dt
	if tacc > tspawn then
		local powerup = self:create_powerup()
		tacc = 0
	end
	--if level.initialSpawn ~= nil then
	--	mod:create_powerup()
	--end
	for _, v in ipairs(spawnedPowerups) do
		v:update(dt)
	end
	for _, v in ipairs(bombs) do
		v:update(dt)
	end
end

function mod:draw()
	for _, v in ipairs(spawnedPowerups) do
		v:draw(dt)
	end
	for _, v in ipairs(bombs) do
		v:draw()
	end
end

function mod:create_bomb(x, y)
	local bomb = {}
	bomb.body = love.physics.newBody(level.world, x, y, "dynamic")
	bomb.image = love.graphics.newImage("data/images/bomb.png")
	bomb.shape = love.physics.newRectangleShape(32, 16)
	bomb.fixture = love.physics.newFixture(bomb.body, bomb.shape)
	bomb.fixture:setFriction(30)
	bomb.body:setMass(30)
	bomb.timeAlive = 0
	
	function bomb:draw()
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(bomb.image, bomb.body:getX(), bomb.body:getY(), bomb.body:getAngle(),  1, 1,
			bomb.image:getWidth()/2, bomb.image:getHeight()/2)
	end

	function bomb:update(dt)
		self.timeAlive = self.timeAlive + dt
	end

	function bomb:contact(b, coll)
		local bd = b:getUserData()
		if bd ~= nil and bd.objtype == 'player' then
			if self.timeAlive > 3 then
				bomb.body:destroy()
				local l = #bombs
				if bomb.index > l then
					bombs[bomb.index] = bombs[l]
					bombs[l] = nil
				else
					bombs[bomb.index] = nil
				end
				bd:bomb_damage()
			end
		end
	end

	bomb.fixture:setUserData(bomb)
	bomb.index = #bombs + 1
	bombs[bomb.index] = bomb
	return bomb
end

return mod
