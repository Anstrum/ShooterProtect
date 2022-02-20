require("generalFunctions")

game = {}
	game.background = require("background")
	game.ship = require("ship")
	game.enemies = require("enemies")

function game.load()
	game.background.load()
	game.ship.load()
	game.enemies.load()
end


function game.update(dt)
	game.background.update(dt)
	game.ship.update(dt)
	game.enemies.update(dt, game.ship.axes)
end

function game.mousepressed(click)
	game.ship.mousePressed(click)
end

function game.keypressed(key) 
	game.ship.keyPressed(key)
end

function game.draw()
	game.background.draw()
	game.ship.draw()
	game.enemies.draw()
end


return game
