local Entity = require "entity"
local Projectile = Entity:extend()
local speed = 100

function Projectile:new(x, y, xVel, yVel)
	Projectile.super.new(self, x, y, "projectile")
	self.xVel = xVel
	self.yVel = yVel
end

function Projectile:draw()
	love.graphics.setColor(0, 100, 0)
	love.graphics.circle("line", self:getX(), self:getY(), 1)
end

function Projectile:update(dt)
	self:left(self.xVel * speed * dt)
	self:up(self.yVel * speed * dt)
	if self:getX() < 0 or self:getX() > love.graphics.getWidth() then
		self:banish()
	elseif self:getY() < 0 or self:getY() > love.graphics.getHeight() then
		self:banish()
	end
end

return Projectile
