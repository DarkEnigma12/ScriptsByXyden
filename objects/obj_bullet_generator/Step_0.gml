/// @description Generates bullets

//creates pattern if mouse button is held
if(mouse_check_button(mb_left)) {
	
	for(var i = 0; i < array_length(bullet_structure); i++;) {
		
		if(bullet_structure[i].alarm <= 0) {
			
			//Spawns bullets in a pattern
			var bllt_per_step = bullet_structure[i].cross_pattern;
			for(var b = 0; b < bllt_per_step; b++) {
	
				//calculates pattern
				var xx = (bullet_structure[i].bullet_spawn_xy[0] == -1) ? x : bullet_structure[i].bullet_spawn_xy[0];
				var yy = (bullet_structure[i].bullet_spawn_xy[1] == -1) ? y : bullet_structure[i].bullet_spawn_xy[1];
				var bllt_insta = instance_create_depth(xx,yy,depth,bullet_structure[i].bullet_id);
			
				bllt_insta.direction = (bullet_structure[i].start_dirc - (bullet_structure[i].cross_angle<360)*clamp(bullet_structure[i].cross_angle,0,360)/2) + (clamp(bullet_structure[i].cross_angle,0,360) / max(bullet_structure[i].cross_pattern-(bullet_structure[i].cross_angle<360),1)) * b;
				bllt_insta.speed = bullet_structure[i].bullet_spd;
				bllt_insta.bullet_curve = bullet_structure[i].bullet_curve;
				bllt_insta.curve_growth = bullet_structure[i].curve_growth;
				bllt_insta.acceleration = bullet_structure[i].acceleration;
				
				//mirrors pattern
				if bool(bullet_structure[i].mirror) {
	
					//calculates pattern
					var mirror_insta = instance_create_depth(xx,yy,depth,bullet_structure[i].bullet_id);
			
					mirror_insta.direction = bllt_insta.direction + 180;
					mirror_insta.speed = bullet_structure[i].bullet_spd;
					mirror_insta.bullet_curve = -bllt_insta.bullet_curve
					mirror_insta.curve_growth = bullet_structure[i].curve_growth;
					mirror_insta.acceleration = bullet_structure[i].acceleration;
	
				}
	
			}

			//moves spin
			bullet_structure[i].start_dirc += bullet_structure[i].spin;
				
			//resets alarm
			bullet_structure[i].alarm = bullet_structure[i].delay;
			
		} else {bullet_structure[i].alarm--;}
		
	}
	
} else if(mouse_check_button_released(mb_left)) {
	
	//resets alarms when not shooting
	for(var i = 0; i < array_length(bullet_structure); i++;) {bullet_structure[i].alarm = 0;}
	
}