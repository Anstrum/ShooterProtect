require("generalFunctions")

local ship = {}

	ship.shoots = require("shoots")
	ship.sprite = nil
	ship.x = screen.width / 2
	ship.y = screen.height / 2
	ship.width = nil
	ship.height = nil
	ship.angle = nil
	ship.rotaSpeed = 0
	ship.actualAxe = 4 --Start to 4 if 4 axis, start to 7 if 8 axes
	ship.turnLeft = false
	ship.axes = {}


	function ship.load()
		ship.sprite = love.graphics.newImage("Ressources/ship.png")
		ship.width = ship.sprite:getWidth()
		ship.height = ship.sprite:getHeight()
		ship.addAxis(0)
		--ship.addAxis(math.pi / 4)
		ship.addAxis(math.pi / 2)
		--ship.addAxis(math.pi * ( 3 / 4 ))
		ship.addAxis(math.pi)
		--ship.addAxis( 0 - math.pi * ( 3 / 4 ))
		ship.addAxis( - math.pi / 2)
		--ship.addAxis( 0 - math.pi / 4)
		ship.shoots.load()
	end


	function ship.keyPressed(key)
		--[[
		if key == "q" or key == "left" then
			ship.actualAxe = ship.actualAxe - 1
			if ship.actualAxe < 1 then
				ship.actualAxe = ship.actualAxe + #ship.axes
				return
			end
		end
		if key == "d" or key == "right" then
			ship.actualAxe = ship.actualAxe + 1
			if ship.actualAxe > #ship.axes then
				ship.actualAxe = ship.actualAxe - #ship.axes
				return
			end
		end
		if key == "z" or key == "s" or key == "up" or key == "down" then
			ship.actualAxe = ship.actualAxe + #ship.axes / 2 
			if ship.actualAxe > #ship.axes then
				ship.actualAxe = ship.actualAxe - #ship.axes
				return6
			end
		end
		--]]
		--[[]]
		if key == "q" or key == "left" then
			ship.actualAxe = 3
		end
		if key == "s" or key == "down" then
			ship.actualAxe = 2
		end
		if key == "d" or key == "right" then
			ship.actualAxe = 1
		end
		if key == "z" or key == "up" then
			ship.actualAxe = 4
		end
		--]]
	end

	function ship.update(dt)
		ship.shoots.update(dt)
		ship.shoots.isDown(ship.axes[ship.actualAxe].angle)
	end
                

	function ship.mousePressed(click)
	end


	function ship.draw()
		for i = 1, # ship.axes do
			--love.graphics.line(ship.x, ship.y, ship.x + math.cos(ship.axes[i].angle) * 550, ship.y + math.sin(ship.axes[i].angle) * 550)
		end
		love.graphics.draw(ship.sprite, ship.x, ship.y, ship.axes[ship.actualAxe].angle, 4, 4, ship.width / 2, ship.height / 2)
		ship.shoots.draw()
	end


	function ship.addAxis(angle)
		local myAxis = {}
		myAxis.angle = angle
		myAxis.id = #ship.axes + 1
		table.insert(ship.axes, myAxis)
	end	


return ship