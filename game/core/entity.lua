local Object = require("libraries.classic")
local Entity = Object:extend()

function Entity:new(x, y, hitbox_rad, name, gm)
	self.x = x
	self.y = y
	self.to_remove = false;
	self.name = name
	self.gm = gm
	self.rad = hitbox_rad
end

function Entity:banish()
	self.to_remove = true
end

function Entity:getGM()
	return self.gm
end

function Entity:getRad()
	return self.rad
end

function Entity:shouldRemove()
	return self.to_remove
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

function Entity:setX(x)
	self.x = x
end

function Entity:setY(y)
	self.y = y
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
