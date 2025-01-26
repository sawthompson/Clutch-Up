local gm

function love.load()
	local GameManager = require "core/game_manager"
	gm = GameManager()
end

function love.update(dt)
	gm:update()
	for index, entity in ipairs(gm:getEntities()) do
		entity:update(dt)
	end
end

-- function love.keypressed(key)
--     gm:keyPressed(key)
-- end

function love.draw()
	love.graphics.setColor(10, 10, 10)
	love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
	for index, value in ipairs(gm:getEntities()) do
		value:draw()
	end
end


