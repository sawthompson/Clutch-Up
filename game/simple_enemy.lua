local Entity = require "entity"
local Projectile = require "projectile"
local SimpleEnemy = Entity:extend()
local speed = 100
local cooldown_length = 1

function SimpleEnemy:new(x, y, gm)
	SimpleEnemy.super.new(self, x, y, "simple enemy")
	self.gm = gm
	self.xVel = 0.25
	self.yVel = 0.75
	self.cooldown = cooldown_length
end

function SimpleEnemy:draw()
	love.graphics.setColor(100, 0, 0)
	love.graphics.circle("line", self:getX(), self:getY(), 10)
end

function SimpleEnemy:update(dt)
	self.cooldown = self.cooldown - dt
	if self.cooldown <= 0 then
		local player_x = self.gm:getPlayer():getX()
		local player_y = self.gm:getPlayer():getY()

		local angle = math.atan2(player_y - self:getY(), player_x - self:getX())

		local cos = math.cos(angle)
		local sin = math.sin(angle)

		self.gm:addEntity(Projectile(self:getX(), self:getY(), cos * -2, sin * -2))
		self.cooldown = cooldown_length
	end
	self:left(self.xVel * speed * dt)
	self:up(self.yVel * speed * dt)
	if self:getX() < 0 or self:getX() > love.graphics.getWidth() then
		self.xVel = -self.xVel
	end
	if self:getY() < 0 or self:getY() > love.graphics.getHeight() then
		self.yVel = -self.yVel
	end
end

return SimpleEnemy
