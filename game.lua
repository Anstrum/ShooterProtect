require("generalFunctions")

game = {}
	game.background = require("background")
	game.ship = require("ship")
	game.enemies = require("enemies")
	game.collider = require("collider")

function game.load()
	game.background.load()
	game.ship.load()
	game.enemies.load()
end


function game.update(dt)
	game.background.update(dt)
	game.ship.update(dt)
	game.enemies.update(dt, game.ship.axes)
	if #game.ship.shoots.list > 0 and #game.enemies.list >  0 then
		for i = #game.ship.shoots.list, 1, -1 do
			for j = #game.enemies.list, 1, -1 do
				if game.collider.checkColision(game.ship.shoots.list[i], game.enemies.list[j]) then
					table.remove(game.ship.shoots.list, i)
					table.remove(game.enemies.list, j)
					break
				end
			end
		end
	end
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
