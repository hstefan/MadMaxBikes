require 'util.console'

local mod = {}

function mod:load_tileset(tileset)
	local gid = tileset.firstgid

	if tileset.image ~= nil then
		local image = love.graphics.newImage('data/' .. tileset.image)
		local x = 0
		local y = 0
		while y + tileset.tileheight <= tileset.imageheight do
			while x + tileset.tilewidth <= tileset.imagewidth do
				self.tiles[gid] = {
					quad = love.graphics.newQuad(x, y, tileset.tilewidth, tileset.tileheight,
						tileset.imagewidth, tileset.imageheight),
					image = image,
					origin_x = 0,
					origin_y = tileset.tileheight,
				}
				gid = gid + 1
				x = x + tileset.tilewidth
			end
			x = 0
			y = y + tileset.tileheight
		end
	else
		for i, tile in ipairs(tileset.tiles) do
			local image = love.graphics.newImage('data/' .. tile.image)
			self.tiles[gid + tile.id] = {
				quad = love.graphics.newQuad(0, 0, tile.width, tile.height, tile.width, tile.height),
				image = image,
				origin_x = 0,
				origin_y = tile.height,
			}
		end
	end
end

--[[
function convert_gid(gid)
	local hflip_mask = 0x80000000
	local vflip_mask = 0x40000000
	local hflip = 1
	local vflip = 1
	if gid >= hflip_mask then
		hflip = -1
		gid = gid - hflip_mask
	end
	if gid >= vflip_mask then
		vflip = -1
		gid = gid - vflip_mask
	end
	return gid, hflip, vflip
end
--]]

function mod:draw_object(object)
	local tile = self.tiles[object.gid]
	local angle = object.rotation * math.pi / 180
	love.graphics.draw(tile.image, tile.quad,
		object.x, object.y,
		angle, 1, 1, tile.origin_x, tile.origin_y)
end

function mod:draw_layer(layer)
	for i, object in ipairs(layer.objects) do
		self:draw_object(object)
	end
end

function beginContact(a, b, coll)
	local ad = a:getUserData()
	local bd = b:getUserData()
	if ad ~= nil and ad.contact ~= nil then
		ad:contact(b, coll)
	end
	if bd ~= nil and bd.contact ~= nil then
		bd:contact(a, coll)
	end
end

function mod:load_world()
	love.physics.setMeter(64)
	self.world = love.physics.newWorld(0, 9.81 * 64, true)
	self.world:setCallbacks(beginContact, nil, nil, nil)
	self.physics_objects = {}
	for k, v in pairs(self.physicsLayer.objects) do
		if v.polygon ~= nil then
			local i = #self.physics_objects + 1
			self.physics_objects[i] = {}
			self.physics_objects[i].body = love.physics.newBody(self.world, v.x, v.y, 'static')
			
			local flattenPolygon = {}
			for _, vertex in pairs(v.polygon) do
				flattenPolygon[#flattenPolygon + 1]  = vertex.x
				flattenPolygon[#flattenPolygon + 1]  = vertex.y
			end

			local tris = love.math.triangulate(flattenPolygon)

			for _, tri in ipairs(tris) do
				self.physics_objects[i].shape = love.physics.newPolygonShape(unpack(tri))
				self.physics_objects[i].fixture = love.physics.newFixture(self.physics_objects[i].body,
					self.physics_objects[i].shape)
				self.physics_objects[i].fixture:setCategory(2)
				if v.properties ~= nil then
					for prop, val in pairs(v.properties) do
						if prop == "friction" then
							self.physics_objects[i].fixture:setFriction(tonumber(val))
						end
					end
				end
			end
		end
	end
end

function mod:load_powerups()
	self.powerupSpawns = {}
	for k, v in pairs(self.powerUpsLayer.objects) do
		self.powerupSpawns[#self.powerupSpawns + 1 ] = { x = v.x, y = v.y, occupied = false }
		if v.properties.initial_spawn then
			self.initialSpawn = #self.powerupSpawns
		end
	end
end

function mod:load_map(map_name)
	math.randomseed(os.time())
	self.map = love.filesystem.load('data/' .. map_name)()
	self.width = self.map.width * self.map.tilewidth
	self.height = self.map.height * self.map.tileheight
	self.tiles = {}
	self.layers = {}
	for i, tileset in ipairs(self.map.tilesets) do
		self:load_tileset(tileset)
	end
	for i, layer in ipairs(self.map.layers) do
		self.layers[layer.name] = layer
	end

	self.physicsLayer = self.layers['Physics']
	if self.physicsLayer ~= nil then
		self:load_world()
	end

	self.powerUpsLayer = self.layers['PowerUps']
	if self.powerUpsLayer ~= nil then
		self:load_powerups()	
	end
end

return mod
