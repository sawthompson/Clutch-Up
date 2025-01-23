local Object = require("classic")
local GameManager = Object:extend()
local nata = require 'nata'
local Projectile = require "projectile"

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
	local Player = require "player"
	self.player = Player(self)
	self.pool:queue(self.player)
	local SimpleEnemy = require "simple_enemy"
	self.pool:queue(SimpleEnemy(550, 400, self))
	local SimpleEnemy = require "simple_enemy"
	self.pool:queue(SimpleEnemy(400, 550, self))
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
