io.stdout:setvbuf("no")
love.graphics.setDefaultFilter("nearest")

require("generalFunctions")
game = require("game")

function love.load()
	game.load()
end

function love.update(dt)
	game.update(dt)
end

function love.keypressed(key)
	game.keypressed(key)
end

function love.mousepressed(x, y, click)
	game.mousepressed(click)
end

function love.draw()
	game.draw()
end
