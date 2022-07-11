/// @description Alters depth
/*
//changes depth depending on player's y position
if (depth_tolerance != infinity) {

	if instance_exists(player_jade_obj) {
	
		depth = player_jade_obj.depth + sign(player_jade_obj.y-y+depth_tolerance);
	
	}

}