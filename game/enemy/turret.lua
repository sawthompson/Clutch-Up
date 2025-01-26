local BaseEnemy = require "enemy.base_enemy"
local Projectile = require "core.projectile"
local Turret = BaseEnemy:extend()

function Turret:new(gm, x, y, angle)
	Turret.super.new(self,
	{
		x=x,
		y=y,
		radius=20,
		gm=gm,
		x_vel=0,
		y_vel=0,
		cooldown_length=1,
		max_hp=10,
		speed=0
	})
	self.angle = angle
end

function Turret:fire()
	local cos = math.cos(self.angle)
	local sin = math.sin(self.angle)
	self.gm:addEntity(Projectile(self:getX(), self:getY(), cos * -2, sin * -2, self:getGM()))
end

function Turret:draw_healthy()
	love.graphics.setColor(1, 1, 0)
	love.graphics.circle("line", self:getX(), self:getY(), self.rad)
end

function Turret:draw_wounded()
	love.graphics.setColor(0.7, 0.7, 0)
	love.graphics.circle("line", self:getX(), self:getY(), self.rad)
end

return Turret
