require("generalFunctions")

--[[
	--Loading Game and setting up variables
	]]
game = {}
	game.enemies = {}
	game.spawnCD = 0
	game.spawnRate = 5
	game.speed = 1
	game.background = nil
	game.numberOfStarAsset = 5
	game.starAssets = {}
	game.stars = {}
local ship = {}
	ship.x = nil
	ship.y = nil
	ship.shootSprite = nil
	ship.sprite = nil
	ship.radius = nil
	ship.angle = nil
	ship.scale = nil
	ship.shoots = {}
function game.load()
	--init background
	for i = 1, game.numberOfStarAsset do
		table.insert(game.starAssets, love.graphics.newImage("Ressources/star"..i..".png"))
	end
	for i = 1, 150 do
		local myStar = {}
		myStar.x = math.random(0, screen.width)
		myStar.y = math.random(0, screen.height)
		myStar.speed = math.random(50, 150)
		myStar.sprite = game.starAssets[math.random(1, #game.starAssets)]
		table.insert(game.stars, myStar)
	end

	ship.x = screen.width / 2
	ship.y = screen.height / 2
	ship.scale = 5
	ship.angle = 0
	ship.sprite = love.graphics.newImage("Ressources/ship.png")
	ship.shootSprite = love.graphics.newImage("Ressources/shoot.png")
	ship.width = ship.sprite:getWidth()
	ship.height = ship.sprite:getHeight()
end
--[[]]



function game.update(dt)
	game.speed = game.speed + 1 * dt

	--[[
		--Background Update
		]]
	while #game.stars < 150 do
		local myStar = {}
		myStar.x = math.random(0, screen.width)
		myStar.y = math.random(screen.height, screen.height + 50)
		myStar.sprite = game.starAssets[math.random(1, #game.starAssets)]
		myStar.speed = math.random(50, 150)
		table.insert(game.stars, myStar)
	end
	for i = #game.stars, 1, -1 do
		game.stars[i].y = game.stars[i].y - game.stars[i].speed * dt
		if game.stars[i].y < 0 - game.stars[i].sprite:getHeight() then
			table.remove(game.stars, i)
		end
	end
	--[[]]





	--[[
			--Ship Update]]
	--Ship Movement
	if love.keyboard.isDown("q") or love.keyboard.isDown("left") then
		ship.angle = ship.angle - math.pi * 1.5 * dt
	end
	if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
		ship.angle = ship.angle + math.pi * 1.5 * dt
	end
	if ship.angle > math.pi then
		ship.angle = ship.angle - math.pi * 2
	end
	if ship.angle < 0 - math.pi then
		ship.angle = ship.angle + math.pi * 2
	end
	--shoots update
	for i = #ship.shoots, 1, -1 do
		ship.shoots[i].x = ship.shoots[i].x + math.cos(ship.shoots[i].angle - math.pi / 2) * ship.shoots[i].speed * dt
		ship.shoots[i].y = ship.shoots[i].y + math.sin(ship.shoots[i].angle - math.pi / 2) * ship.shoots[i].speed * dt
		if ship.shoots[i].x > screen.width + 50 or ship.shoots[i].x < -50 or ship.shoots[i].y > screen.height + 50 or ship.shoots[i].y < -50 then
			table.remove(ship.shoots, i)
		end
	end
	--[[]]

	--[[
		--Enemy Update]]
	game.spawnCD = game.spawnCD + 1 * dt * game.speed
	if game.spawnCD > game.spawnRate then
		game.spawnCD = 0
		if math.random(0, 100) < 20 then
			game.generateEnemy()
		end
		game.generateEnemy()
	end
	for i = #game.enemies, 1, -1 do
		game.enemies[i].x = game.enemies[i].x + (game.enemies[i].speed) * (math.cos(game.enemies[i].angle)) * dt
		game.enemies[i].y = game.enemies[i].y + (game.enemies[i].speed) * (math.sin(game.enemies[i].angle)) * dt
	end
	--[[]]
end

function game.mousepressed(click)
	if click == 1 then
		ship.generateShoot()
	end
end

function game.keypressed(key) 
	if key == "space" then
		ship.generateShoot()
	end
end

function game.draw()
	--[[
	--Background draw]]
	for i = 1, #game.stars do
		love.graphics.draw(game.stars[i].sprite, game.stars[i].x, game.stars[i].y, 0)
	end
	--[[]]

	--[[
		--Ship Draw]]
	--Ship
	love.graphics.draw(ship.sprite, ship.x, ship.y, ship.angle, ship.scale, ship.scale, ship.width / 2, ship.height / 2)
	--Shoots
	for i = 1, #ship.shoots do
		love.graphics.draw(ship.shootSprite, ship.shoots[i].x, ship.shoots[i].y, ship.shoots[i].angle, ship.scale, ship.scale )
	end
	--[[]]

	--[[
		--enemy draw]]
		love.graphics.setColor(0, 1, 0, 1)
		for i = 1, #game.enemies do
			love.graphics.circle("fill", game.enemies[i].x, game.enemies[i].y, game.enemies[i].radius)
		end
		love.graphics.setColor(1, 1, 1, 1)


	--[[]]
end





--[[
		--Others Functions]]
function ship.generateShoot()
	local myShoot = {}
	myShoot.x = ship.x
	myShoot.y = ship.y
	myShoot.speed = 400
	myShoot.angle = ship.angle
	table.insert(ship.shoots, myShoot)
end
function game.generateEnemy()
	local myEnemy = {}
	myEnemy.x = math.random(0, 800)
	myEnemy.y = math.random(0, 600)
	if myEnemy.x > 400 then 
		myEnemy.x = myEnemy.x + 450 
	else 
		myEnemy.x = myEnemy.x - 450 
	end
	if myEnemy.y > 300 then 
		myEnemy.y = myEnemy.y + 350 
	else 
		myEnemy.y = myEnemy.y - 350 
	end
	myEnemy.angle = math.atan2(300 - myEnemy.y, 400 - myEnemy.x)
	myEnemy.speed = math.random(100, 250)
	myEnemy.radius = 20
	table.insert(game.enemies, myEnemy)
end
--[[]]



return game
