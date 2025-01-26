local collision = {
	rects = function(a, b)
		local a_left = a.x
		local a_right = a.x + a.width
		local a_top = a.y
		local a_bottom = a.y + a.height
	
		local b_left = b.x
		local b_right = b.x + b.width
		local b_top = b.y
		local b_bottom = b.y + b.height
	
		return  a_right > b_left
			and a_left < b_right
			and a_bottom > b_top
			and a_top < b_bottom
	end,
	spheres = function(a, b)
		local min_dist = a:getRad() + b:getRad()
		return math.abs(a:getX() - b:getX()) ^ 2 + math.abs(a:getY() - b:getY()) ^ 2 < min_dist ^ 2
	end
}

return collision
