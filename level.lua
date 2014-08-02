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

function mod:load_map(map_name)
	self.map = love.filesystem.load('data/' .. map_name)()
	self.tiles = {}
	self.layers = {}
	for i, tileset in ipairs(self.map.tilesets) do
		self:load_tileset(tileset)
	end
	for i, layer in ipairs(self.map.layers) do
		self.layers[layer.name] = layer
	end
end

return mod
