local mod = {}

function mod:load_tileset(tileset)
	local gid = tileset.firstgid

	if tileset.image ~= nil then
		local image = love.graphics.newImage(tileset.image)
		local x = 0
		local y = 0
		while y + tileset.tileheight <= tileset.imageheight do
			while x + tileset.tilewidth <= tileset.imagewidth do
				self.tiles[gid] = {
					quad = love.graphics.newQuad(x, y, tileset.tilewidth, tileset.tileheight,
						tileset.imagewidth, tileset.imageheight),
					image = image
				}
				gid = gid + 1
				x = x + tileset.tilewidth
			end
			x = 0
			y = y + tileset.tileheight
		end
	else
		for i, tile in ipairs(tileset.tiles) do
			local image = love.graphics.newImage(tile.image)
			self.tiles[gid + tile.id] = {
				quad = love.graphics.newQuad(0, 0, tile.width, tile.height, tile.width, tile.height),
				image = image
			}
		end
	end
end

function mod:draw_layer(layer)
	for i, object in ipairs(layer.objects) do
		local tile = self.tiles[object.gid]
		love.graphics.draw(tile.image, tile.quad, object.x, object.y)
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
