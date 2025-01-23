local Entity = require "entity"
local Projectile = Entity:extend()
local collision = require "collision"
local speed = 100

function Projectile:new(x, y, x_vel, y_vel, gm)
	Projectile.super.new(self, x, y, 1, "projectile", gm)
	self.x_vel = x_vel
	self.y_vel = y_vel
end

function Projectile:draw()
	love.graphics.setColor(0, 100, 0)
	love.graphics.circle("line", self:getX(), self:getY(), 1)
end

function Projectile:update(dt)
	self:left(self.x_vel * speed * dt)
	self:up(self.y_vel * speed * dt)
	self:checkBounds()
	self:checkCollision()
end

function Projectile:checkBounds()
	if self:getX() < 0 or self:getX() > love.graphics.getWidth() then
		self:banish()
		self.x_vel = -self.x_vel
	elseif self:getY() < 0 or self:getY() > love.graphics.getHeight() then
		self:banish()
		self.y_vel = -self.y_vel
	end
end

function Projectile:checkCollision()
	if collision.spheres(self:getGM():getPlayer(), self) then
		self:banish()
	end
end

return Projectile
