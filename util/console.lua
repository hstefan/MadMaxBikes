local LINE_HEIGHT 	= 10
local MAX_LINES 	= 15

local INFO 				= "[INFO]\t\t\t"
local WARNING 		= "[WARNING]\t "
local ERROR 			= "[ERROR]\t\t "

--------------------------------------------------------------
-- LOCAL
--------------------------------------------------------------
local function addLine(list, line)
	local lines = #list
	
	if lines >= MAX_LINES then
		list[1] = nil
		
		for i = 2, MAX_LINES do 
			list[i - 1], list[i] = list[i], list[i - 1]
		end
	end
	
	list[#list + 1] = line
end

--------------------------------------------------------------
-- CONSOLE
--------------------------------------------------------------
console = {}
local vector = require "hump.vector"

function console:init()
	self.lines 			= {}
	self.padding		= 10
	self.active			= true
	self.position 		= vector(0, love.graphics.getHeight() - (LINE_HEIGHT * MAX_LINES) - (self.padding * 2))
end

function console:log(message)
	local line = { txt = message, level = INFO }
	addLine(self.lines, line)
end

function console:logError(message)
	local line = { txt = message, level = ERROR }
	addLine(self.lines, line)
end

function console:logWarning(message)
	local line = { txt = message, level = WARNING }
	addLine(self.lines, line)
end

function love.keypressed(key, isRepeat)
	if key == "f10" then
		console.active = not console.active
	end
end

function console:draw()
	if not self.active then return end
	
	-- remember graphics color state
	local r, g, b, a = love.graphics.getColor()
	
	love.graphics.setColor(7, 68, 18, 190)
	love.graphics.rectangle("fill", self.position.x, self.position.y, love.graphics.getWidth(), (LINE_HEIGHT * MAX_LINES) + (self.padding * 2))
	
	local finalPos = { x =self.position.x, y = self.position.y + self.padding }
	
	for key, value in pairs(self.lines) do
		local message 	= value.txt
		local level 		= value.level
		
		if level == ERROR then
			love.graphics.setColor(255, 90, 90)
		elseif level == WARNING then
			love.graphics.setColor(220, 220, 90)
		else
			love.graphics.setColor(255, 255, 255)
		end
		
		love.graphics.print(level .. message, finalPos.x + self.padding, finalPos.y)
		
		finalPos.y = finalPos.y + LINE_HEIGHT
	end
	
	-- reverts graphics color state
	love.graphics.setColor(r, g, b, a)
end

function console:setPadding(padding)
	self.padding = padding
end

--------------------------------------------------------------
console:init()
return console