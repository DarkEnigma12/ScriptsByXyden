/// @description Sets up master camera

//Sets necessary vars
#region

//Sets master camera global
if(object_index == obj_master_camera) {global.master_camera = id;}

enum cameraStates {
	
	SETUP,
	HOLD,
	CENTER,
	FOLLOW,
	DISABLE
	
}
//Sets states for camera
camera_state = cameraStates.HOLD;

//Player vars
player_id = noone;
player_number = 0;

//Instance to follow
following = noone;

//Zoom vars
view_zoom = 1;
view_min_zoom = 0.5;
view_max_zoom = 2;
zoom_speed = 0.2;

//Hold vars
hold_x = 0;
hold_y = 0;

//Follow Vars
follow_dist = 50;			//follow distance for camera controller
follow_lerp_speed = 0.025;	//var to ease camera towards target

//Screen Shake Vars
shake = 0;				//shake effect bool
shake_time = 0;			//duration of screen shake
shake_magnitude = 0;	//how far screen shakes
shake_decay = 0;		//how fast shake decays

#endregion
