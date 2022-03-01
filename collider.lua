local collider = {}

	function collider.checkColision(myShoot, myEnemy)
 		local dist = (myShoot.x - myEnemy.x) * (myShoot.x - myEnemy.x) + (myShoot.y - myEnemy.y) * (myShoot.y - myEnemy.y)
 		if dist < myEnemy.radius * myEnemy.radius then
 			return true
 		end
	end




return collider