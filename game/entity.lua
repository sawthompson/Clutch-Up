local Object = require("classic")
local Entity = Object:extend()

function Entity:new(x, y, name)
	self.x = x
	self.y = y
	self.toRemove = false;
	self.name = name
end

function Entity:banish()
	self.toRemove = true
end

function Entity:shouldRemove()
	return self.toRemove
end

function Entity:draw()
	love.graphics.rectangle("line", self.x, self.y, 10, 10)
end

function Entity:getX()
	return self.x
end

function Entity:getY()
	return self.y
end

function Entity:right(amount)
	self.x = self.x + amount
end

function Entity:left(amount)
	self.x = self.x - amount
end

function Entity:up(amount)
	self.y = self.y - amount
end

function Entity:down(amount)
	self.y = self.y + amount
end

return Entity
