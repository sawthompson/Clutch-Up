local Entity = require "entity"
local Projectile = require "projectile"
local SimpleEnemy = Entity:extend()
local speed = 100
local cooldown_length = 1

function SimpleEnemy:new(x, y, gm)
	SimpleEnemy.super.new(self, x, y, 10, "simple enemy", gm)
	self.x_vel = 0.25
	self.y_vel = 0.75
	self.cooldown = cooldown_length
	self.is_enemy = true
	self.hp = 5
end

function SimpleEnemy:draw()
	if self.hp > 2 then
		love.graphics.setColor(1, 0, 0)
	else
		love.graphics.setColor(0.7, 0, 0)
	end
	love.graphics.circle("line", self:getX(), self:getY(), 10)
end

function SimpleEnemy:take_damage(amt)
	self.hp = self.hp - amt
	if self.hp <= 0 then
		self:banish()
	end
end

function SimpleEnemy:update(dt)
	self.cooldown = self.cooldown - dt
	if self.cooldown <= 0 then
		local player_x = self:getGM():getPlayer():getX()
		local player_y = self:getGM():getPlayer():getY()

		local angle = math.atan2(player_y - self:getY(), player_x - self:getX())

		local cos = math.cos(angle)
		local sin = math.sin(angle)

		self.gm:addEntity(Projectile(self:getX(), self:getY(), cos * -2, sin * -2, self:getGM()))
		self.cooldown = cooldown_length
	end
	self:left(self.x_vel * speed * dt)
	self:up(self.y_vel * speed * dt)
	if self:getX() < 0 then
		self:setX(0)
		self.x_vel = -self.x_vel
	end
	if self:getY() < 0 then
		self:setY(0)
		self.y_vel = -self.y_vel
	end
	if self:getX() > love.graphics.getWidth() then
		self:setX(love.graphics.getWidth())
		self.x_vel = -self.x_vel
	end
	if self:getY() > love.graphics.getHeight() then
		self:setY(love.graphics.getHeight())
		self.y_vel = -self.y_vel
	end
end

return SimpleEnemy
