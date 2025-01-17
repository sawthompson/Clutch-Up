local Entity = require "entity"
local Player = Entity:extend()
local speed = 100

function Player:new(gm)
	Player.super.new(self, 100, 100, 10, "player", gm)
end

function Player:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.circle("line", self:getX(), self:getY(), 10)
end

function Player:update(dt)
	if love.keyboard.isDown("d") then
		self:right(dt * speed)
	end
	if love.keyboard.isDown("a") then
		self:left(dt * speed)
	end
	if love.keyboard.isDown("w") then
		self:up(dt * speed)
	end
	if love.keyboard.isDown("s") then
		self:down(dt * speed)
	end
end

function Player:shouldRemove()
	return false
end

return Player
