/// @description Spawns bullets in a pattern
/*
for(var i = 0; i < array_length(bullet_structure); i++;) {

	var bllt_per_step = bullet_structure[i].cross_pattern;
	for(var b = 0; b < bllt_per_step; b++) {
	
		//calculates pattern
		var xx = (bullet_structure[i].bullet_spawn_xy[0] == -1) ? x : bullet_structure[i].bullet_spawn_xy[0];
		var yy = (bullet_structure[i].bullet_spawn_xy[1] == -1) ? y : bullet_structure[i].bullet_spawn_xy[1];
		var insta = instance_create_depth(xx,yy,depth,bullet_structure[i].bullet_id);
			
		insta.direction = (bullet_structure[i].start_dirc - (bullet_structure[i].cross_angle<360)*clamp(bullet_structure[i].cross_angle,0,360)/2) + (clamp(bullet_structure[i].cross_angle,0,360) / max(bullet_structure[i].cross_pattern-(bullet_structure[i].cross_angle<360),1)) * b;
		insta.speed = bullet_structure[i].bullet_spd;
		insta.bullet_curve = bullet_structure[i].bullet_curve;
		insta.curve_growth = bullet_structure[i].curve_growth;
		insta.acceleration = bullet_structure[i].acceleration;
	
	}

	//moves spin
	bullet_structure[i].start_dirc += bullet_structure[i].spin;

}