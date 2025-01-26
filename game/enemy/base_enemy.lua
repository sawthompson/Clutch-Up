local Entity = require "core.entity"
local Projectile = require "core.projectile"
local BaseEnemy = Entity:extend()

function BaseEnemy:new(args)
	BaseEnemy.super.new(self, args.x, args.y, args.radius, "enemy", args.gm)
	self.x_vel = args.x_vel
	self.y_vel = args.y_vel
	self.cooldown_length = args.cooldown_length
	self.cooldown = args.cooldown_length
	self.is_enemy = true
	self.max_hp = args.max_hp
	self.hp = args.max_hp
	self.speed = args.speed
end

function BaseEnemy:draw()
	if self.hp >= self.max_hp * 0.4 then
		self:draw_healthy()
	else
		self:draw_wounded()
	end
end

function BaseEnemy:draw_healthy()
	love.graphics.setColor(1, 0, 0)
	love.graphics.circle("line", self:getX(), self:getY(), self.rad)
end

function BaseEnemy:draw_wounded()
	love.graphics.setColor(0.7, 0, 0)
	love.graphics.circle("line", self:getX(), self:getY(), self.rad)
end

function BaseEnemy:take_damage(amt)
	self.hp = self.hp - amt
	if self.hp <= 0 then
		self:banish()
	end
end

-- Default firing behavior. Fire in direction faced
function BaseEnemy:fire()
	local angle = math.atan2(self.y_vel, self.x_vel)

	local cos = math.cos(angle)
	local sin = math.sin(angle)

	self.gm:addEntity(Projectile(self:getX(), self:getY(), cos * -2, sin * -2, self:getGM()))
end

function BaseEnemy:update(dt)
	self:left(self.x_vel * self.speed * dt)
	self:up(self.y_vel * self.speed * dt)

	-- Handle wall collisions
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

	self.cooldown = self.cooldown - dt
	if self.cooldown <= 0 then
		self:fire()
		self.cooldown = self.cooldown_length
	end
end

return BaseEnemy
