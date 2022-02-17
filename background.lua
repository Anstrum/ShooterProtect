require("generalFunctions")

local background = {}
	background.stars = {}
	background.sprites = {}
	background.targetStarCount = 400
	background.minStarSpeed = 100
	background.maxStarSpeed = 200


	function background.load()
		for i = 1, 5 do
			table.insert(background.sprites, love.graphics.newImage("Ressources/star"..i..".png"))
		end
		while #background.stars < background.targetStarCount do
			background.addStar(true)
		end
	end


	function background.update(dt)
		while #background.stars < background.targetStarCount do
			background.addStar(false)
		end
		for i = #background.stars, 1, -1 do
			local myStar = background.stars[i]
			myStar.y = myStar.y - myStar.speed * dt
			if myStar.y < -50 then
				table.remove(background.stars, i)
			end
		end
	end


	function background.draw()
		for i = 1, #background.stars do
			love.graphics.draw(background.sprites[background.stars[i].sprite], background.stars[i].x, background.stars[i].y)
		end
	end


	function background.addStar(isLoad)
		local myStar = {}
		myStar.x = math.random(0, screen.width)
		myStar.y = screen.height
		if isLoad then
			myStar.y = math.random(0, screen.height)
		end
		myStar.sprite = math.random(1, #background.sprites)
		myStar.speed = math.random(background.minStarSpeed, background.maxStarSpeed)
		table.insert(background.stars, myStar)
	end


return background