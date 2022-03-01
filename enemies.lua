local enemies = {}
	enemies.list = {}
	enemies.tick = 0
	enemies.coolDown = 1
	enemies.spawnRate = 0.1
	enemies.radius = 15
	enemies.color = {0, 1, 0, 1}
	enemies.speed = 175

	function enemies.load()
	end


	function enemies.update(dt, axes)
		enemies.spawnRate = enemies.spawnRate + 0.1 * dt
		enemies.tick = enemies.tick + enemies.spawnRate * dt

		if enemies.tick	> enemies.coolDown then
			enemies.generate(axes)
			enemies.tick = 0
		end

		for i = #enemies.list, 1, -1 do
			local myEnemy = enemies.list[i]
			myEnemy.x = myEnemy.x + math.cos(myEnemy.angle) * myEnemy.speed * dt
			myEnemy.y = myEnemy.y + math.sin(myEnemy.angle) * myEnemy.speed * dt
		end
	end


	function enemies.draw()
		for i = 1, #enemies.list do
			love.graphics.setColor(enemies.color)
			love.graphics.circle("fill", enemies.list[i].x, enemies.list[i].y, enemies.radius)
			love.graphics.setColor(1, 1, 1, 1)
		end
	end


	function enemies.generate(axes)
		local myEnemy = {}
			myEnemy.angle = axes[math.random(1, #axes)].angle
			myEnemy.radius = enemies.radius
			myEnemy.speed = math.random(enemies.speed - 100, enemies.speed)
			myEnemy.x = math.cos(myEnemy.angle) * -550 + 400
			myEnemy.y = math.sin(myEnemy.angle) * -550 + 300
		table.insert(enemies.list, myEnemy)
	end
	

return enemies