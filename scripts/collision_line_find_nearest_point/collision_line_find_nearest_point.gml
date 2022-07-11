/// @function		collision_line_find_nearest_point(xstart,ystart,xend,yend,pix_accuracy,obj_id,precise)
/// @description	returns a coordinate array
/// @argument		x start
/// @argument		y start
/// @argument		x end
/// @argument		y end
/// @argument		pixel_accuracy	1 or greater
/// @argument		object_id		The id of objects to collide with
/// @argument		precise			Precise collision checking true or false
function collision_line_find_nearest_point(x1, y1, x2, y2, acc, obj, prec) {

	var direct = point_direction(x1, y1, x2, y2);
	var length = point_distance(x1, y1, x2, y2);
	var accuracy	= clamp(acc, 1, length);

	var collision = collision_line(x1, y1, x2, y2, obj, prec, true);

	if(collision != noone) //check if there is actually going to be a collision
	{
		while(length > accuracy)
		{
			length *= 0.5; //halve the segment length
		
			//search first half of segment
			x2 = x1 + lengthdir_x(length, direct);
			y2 = y1 + lengthdir_y(length, direct);
			collision = collision_line(x1, y1, x2, y2, obj, prec, true);
		
			if(collision == noone)
			{
				//search second half of segment
				x1 = x2;
				y1 = y2;
				x2 += lengthdir_x(length, direct);
				y2 += lengthdir_y(length, direct);
			}
		}
	}

	//return collision point as an array
	var point;

	point[0] = x2;
	point[1] = y2;

	return point;


}
