local shoots = {}

	shoots.list = {}
	shoots.baseSpeed = 250
	shoots.isReady = false
	shoots.tick = 0
	shoots.coolDown = 0.5
	shoots.sprite = nil
	shoots.rechargeBar = {}
		shoots.rechargeBar.width = nil
		shoots.rechargeBar.height = nil
		shoots.rechargeBar.x = nil
		shoots.rechargeBar.y = nil


	function shoots.load()
		shoots.rechargeBar.width = 15
		shoots.rechargeBar.height = 50
		shoots.rechargeBar.x = screen.width - 10 - shoots.rechargeBar.width
		shoots.rechargeBar.y = 10
		shoots.sprite = love.graphics.newImage("Ressources/shoot.png")
	end


	function shoots.update(dt)
		if not shoots.isReady then
			shoots.tick = shoots.tick + 1 * dt
		end
		if shoots.tick > shoots.coolDown then
			shoots.tick = 0
			shoots.isReady = true
		end

		for i = #shoots.list, 1, -1 do
			shoots.list[i].x = shoots.list[i].x + math.cos(shoots.list[i].angle) * shoots.list[i].speed * dt
			shoots.list[i].y = shoots.list[i].y + math.sin(shoots.list[i].angle) * shoots.list[i].speed * dt

			if shoots.list[i].x < -20 or shoots.list[i].x > screen.width + 20 or shoots.list[i].y < -20 or shoots.list[i].y > screen.height + 20 then
				table.remove(shoots.list, i)
			end
		end
	end


	function shoots.keyPressed(key, angle)
		if key == "space" then
			if shoots.isReady then
				shoots.createShoot(angle)
				isReady = false
			end
		end
	end


	function shoots.mousePressed(click, angle)
		if click == 1 then
			if shoots.isReady then
				shoots.createShoot(angle)
				shoots.isReady = false
			end
		end
	end

	
	function shoots.isDown(angle)
		if love.mouse.isDown(1) or love.keyboard.isDown("space") then
			if shoots.isReady then
				shoots.createShoot(angle)
				shoots.isReady = false
			end
		end
	end


	function shoots.draw()
		for i = 1, #shoots.list do
			print(i)
			love.graphics.draw(shoots.list[i].sprite, shoots.list[i].x, shoots.list[i].y, shoots.list[i].angle, 4, 4, shoots.sprite:getWidth() / 2, shoots.sprite:getHeight() / 2)
		end

		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.rectangle("fill", shoots.rechargeBar.x - 1, shoots.rechargeBar.y - 1, shoots.rechargeBar.width + 2, shoots.rechargeBar.height + 2)
		love.graphics.setColor(1, 0, 0, 1)
		percentage = (shoots.tick * 100) / shoots.coolDown
		if shoots.isReady then
			love.graphics.setColor(0, 1, 0, 1)
			percentage = 100
		end
		love.graphics.rectangle("fill", shoots.rechargeBar.x, shoots.rechargeBar.y + shoots.rechargeBar.height - (shoots.rechargeBar.height / 100) * percentage, shoots.rechargeBar.width, shoots.rechargeBar.height / 100 * percentage)
		love.graphics.setColor(1, 1, 1, 1)
	end


	function shoots.createShoot(angle)
		local myShoot = {}
			myShoot.angle = angle
			myShoot.speed = shoots.baseSpeed
			myShoot.x = screen.width / 2 + math.cos(myShoot.angle) * 10
			myShoot.y = screen.height / 2 + math.sin(myShoot.angle) * 10
			myShoot.sprite = shoots.sprite
		table.insert(shoots.list, myShoot)
	end


return shoots