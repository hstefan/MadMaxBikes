local testst = {}

local ww, wh = love.graphics.getDimensions()

function testst:init()
	love.physics.setMeter(64)
	self.world = love.physics.newWorld(0, 9.81 * 64, true)

	self.ground = { }
	self.ground.body = love.physics.newBody(self.world, ww/2, wh - 30, "static")
	self.ground.shape = love.physics.newRectangleShape(ww, 60)
	self.ground.fixture = love.physics.newFixture(self.ground.body, self.ground.shape)

	self.object = { }
	self.object.body = love.physics.newBody(self.world, ww/2, 30, "dynamic")
	self.object.shape = love.physics.newRectangleShape(30, 60)
	self.object.fixture = love.physics.newFixture(self.object.body, self.object.shape)
	self.object.fixture:setRestitution(0.3)
end

function testst:draw()
	love.graphics.setColor(255, 120, 40)
	love.graphics.polygon('fill', self.ground.body:getWorldPoints(self.ground.shape:getPoints()))
	love.graphics.setColor(255, 255, 40)
	love.graphics.polygon('fill', self.object.body:getWorldPoints(self.object.shape:getPoints()))
end

function testst:update(dt)
	self.world:update(dt)

	if love.keyboard.isDown('up') then
		self.object.body:applyLinearImpulse(0, -60)
	end
end

return testst
