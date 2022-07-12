/// @description Code

//Handles bullet curve and acceleration
if(bullet_curve != 0) 
{
	direction += radtodeg(speed)/bullet_curve;
	bullet_curve += sign(bullet_curve)*curve_growth;
}
speed += acceleration;

//Collision
var _insta = instance_place(x,y,target);
if(_insta != noone)
{
	var trgt_push = function(_id)
	{
		//pushes id to array
		array_push(pierced_targets,_id);
	
		//bullet falloff
		if(stats.range>0)&&(point_distance(x,y,start_x,start_y)>stats.range)
		{
			stats.damage/=2;
			stats.pierce = floor(pierce/2);
		}
	
		//applies damage
		_id.hp -= stats.damage;
	
		//manages pierce
		if (pierce <= 0) {instance_destroy();}
		else {pierce--;}
	}

	if(array_length(pierced_targets) <= 0) {trgt_push(_insta);}
	else
	{
		for(var i = 0; i < array_length(pierced_targets); i++;)
		{
			if(_insta == pierced_targets[i]) {break;}
			else if(i == array_length(pierced_targets)-1) {trgt_push(_insta);}
		}
	}
}

//Destroys instance when a fair distance outside room
var offset = 200;
if(x < -offset)or(x > room_width + offset)or(y < -offset)or(y > room_height + offset) {instance_destroy();}