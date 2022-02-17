require("generalFunctions")


game = {}
	game.background = require("background")
function game.load()
	game.background.load()
end


function game.update(dt)
	game.background.update(dt)
end

function game.mousepressed(click)
end

function game.keypressed(key) 
end

function game.draw()
	game.background.draw()
end


return game
