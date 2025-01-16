local Object = require("classic")
local GameManager = Object:extend()
local nata = require 'nata'

function GameManager:new()
	self.pool = nata.new()
	local Player = require "player"
	self.player = Player()
	self.pool:queue(self.player)
	local SimpleEnemy = require "simple_enemy"
	self.pool:queue(SimpleEnemy(500, 500, self))
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


return GameManager
