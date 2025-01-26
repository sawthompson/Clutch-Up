local Object = require("libraries.classic")
local GameManager = Object:extend()
local nata = require 'libraries.nata'
local Projectile = require "core.projectile"

function GameManager:new()
	self.pool = nata.new {
		groups = {
		  enemies = {
			-- filter = function(entity)
			--   return entity.is_enemy
			-- end,
			filter = {'is_enemy'}
		  },
		}
	  }
	local Player = require "player.player"
	self.player = Player(self)
	self.pool:queue(self.player)
	local SimpleEnemy = require "enemy.simple_enemy"
	self.pool:queue(SimpleEnemy(550, 400, self))
	self.pool:queue(SimpleEnemy(400, 550, self))
	local Turret = require "enemy.turret"
	self.pool:queue(Turret(self, 20, love.graphics.getHeight() / 2, 0))
	self.pool:queue(Turret(self, love.graphics.getWidth() / 2, 20, math.pi / 2))
	self.pool:queue(Turret(self, love.graphics.getWidth() - 20, love.graphics.getHeight() / 2, math.pi))
	self.pool:queue(Turret(self, love.graphics.getWidth() / 2, love.graphics.getHeight() - 20, math.pi * 1.5))
end

function GameManager:update()
	self.pool:remove(function(entity)
		return entity:shouldRemove()
	end)
	self.pool:flush()
end

function GameManager:getEntities()
	return self.pool.entities
end

function GameManager:addEntity(e)
	self.pool:queue(e)
end

function GameManager:getPlayer()
	return self.player
end

function GameManager:getEnemies()
	return self.pool.groups.enemies.entities
end

return GameManager
