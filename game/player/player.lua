local Entity = require "core.entity"
local Player = Entity:extend()
local speed = 100
local shot_cooldown_start = 0.5
local shot_cooldown = shot_cooldown_start
local PlayerProjectile = require "player.player_projectile"

function Player:new(gm)
	Player.super.new(self, 100, 100, 10, "player", gm)
end

function Player:draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.circle("line", self:getX(), self:getY(), 10)
end

function Player:update(dt)
	shot_cooldown = shot_cooldown - dt
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
	if love.keyboard.isDown("space") and shot_cooldown <= 0 then
		self:shoot()
		shot_cooldown = shot_cooldown_start
	end
end

function Player:shouldRemove()
	return false
end

function Player:shoot()
	local target_x, target_y = love.mouse.getPosition()

	local angle = math.atan2(target_y - self:getY(), target_x - self:getX())

	local cos = math.cos(angle)
	local sin = math.sin(angle)

	self.gm:addEntity(PlayerProjectile(self:getX(), self:getY(), cos * -2, sin * -2, self:getGM()))
end

return Player
