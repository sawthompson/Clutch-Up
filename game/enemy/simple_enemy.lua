local BaseEnemy = require "enemy.base_enemy"
local Projectile = require "core.projectile"
local SimpleEnemy = BaseEnemy:extend()

function SimpleEnemy:new(x, y, gm)
	SimpleEnemy.super.new(self, 
	{
		x=x,
		y=y,
		radius=10,
		gm=gm,
		x_vel=0.25,
		y_vel=0.75,
		cooldown_length=1,
		max_hp=5,
		speed=100
	})
end

-- Default firing behavior. Fire in direction faced
function SimpleEnemy:fire()
	local player_x = self:getGM():getPlayer():getX()
		local player_y = self:getGM():getPlayer():getY()

		local angle = math.atan2(player_y - self:getY(), player_x - self:getX())

		local cos = math.cos(angle)
		local sin = math.sin(angle)

		self.gm:addEntity(Projectile(self:getX(), self:getY(), cos * -2, sin * -2, self:getGM()))
end

return SimpleEnemy
