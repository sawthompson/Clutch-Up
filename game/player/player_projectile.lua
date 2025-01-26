local Projectile = require "core.projectile"
local PlayerProjectile = Projectile:extend()
local collision = require "libraries.collision"

function PlayerProjectile:new(x, y, x_vel, y_vel, gm)
	PlayerProjectile.super.new(self, x, y, x_vel, y_vel, gm)
end

function PlayerProjectile:draw()
	love.graphics.setColor(0, 100, 100)
	love.graphics.circle("line", self:getX(), self:getY(), 2)
end

function PlayerProjectile:checkCollision()
	for index, enemy in ipairs(self:getGM():getEnemies()) do
		if collision.spheres(enemy, self) then
			enemy:take_damage(1)
			self:banish()
		end
	end
	
end

return PlayerProjectile
