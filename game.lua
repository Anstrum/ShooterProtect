require("generalFunctions")

game = {}
	game.background = require("background")
	game.ship = require("ship")

function game.load()
	game.background.load()
	game.ship.load()
end


function game.update(dt)
	game.background.update(dt)
end

function game.mousepressed(click)
end

function game.keypressed(key) 
	game.ship.keyPressed(key)
end

function game.draw()
	game.background.draw()
	game.ship.draw()
end


return game
