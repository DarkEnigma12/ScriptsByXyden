/// @description Camera Movement

//State Machine for Camera
switch(camera_state) 
{
	
	case(cameraStates.SETUP):
		
		camera_set_position();
		
	break;
	
	case(cameraStates.HOLD):
		//Holds camera in place
		x = hold_x;
		y = hold_y;
		
	break;
	
	case(cameraStates.FOLLOW):
		
		//positions camera controller
		if instance_exists(following) 
		{
			
			//Follows player
			if point_distance(x,y,following.x,following.y) > follow_dist 
			{
	
			x = lerp(x,following.x, follow_lerp_speed);
			y = lerp(y,following.y, follow_lerp_speed);

			}
			
		}
		
		//positions view
		camera_set_position();
	
	break;
	
	case(cameraStates.CENTER):
	
		//Keeps view centered on camera
		camera_set_view_pos(view, x - camera_get_view_width(view)/2, y - camera_get_view_height(view)/2);
	
		//Keeps camera centered in room
		x = room_width/2;
		y = room_height/2;
	
	break;
	
	case(cameraStates.DISABLE):
	
		view_visible[(object_index == obj_master_camera) ? global.master_view : player_number] = false;
	
	break;
	
}

//Manages Zoom
if(mouse_wheel_up()||mouse_wheel_down()) {camera_set_zoom();}

//Toggles full screen
if keyboard_check_pressed(global.fullscreen_button)&&(object_index == obj_master_camera) {fullscreen_toggle(true);}