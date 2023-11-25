/*
/// @description sets up camera
/// @function camera_setup()
/// @param viewport
/// @param full_screen
/// @param pixel_perfect
function camera_setup(view_port = 0, _full_screen = false, _pix_perf = true)
{
	//makes sure camera is persistent
	if(!persistent) {persistent = true;}
	
	//sets screen
	window_set_fullscreen(_full_screen);
	
	//Finds proper scale
	view_scale = floor(display_get_height() / GAME_RES_HEIGHT);
	view_w = GAME_RES_WIDTH * view_scale;
	view_h = GAME_RES_HEIGHT * view_scale;
	view_full_scale = (display_get_height() / GAME_RES_HEIGHT);
	view_full_w = GAME_RES_WIDTH * view_full_scale;
	view_full_h = GAME_RES_HEIGHT * view_full_scale;
	
	//finds pixel perfect zoom
	var pix_perf_zoom = 1.0 + ((view_full_scale - floor(view_full_scale))/2)*_pix_perf;
	
	//finds pixel perfect dimensions
	var pix_perf_w = window_get_fullscreen() ? GAME_RES_WIDTH*pix_perf_zoom : GAME_RES_WIDTH;
	var pix_perf_h = window_get_fullscreen() ? GAME_RES_HEIGHT*pix_perf_zoom : GAME_RES_HEIGHT;
	
	//finds draw size
	var appsurf_draw_size_w = window_get_fullscreen() ? view_full_w : view_w;
	var appsurf_draw_size_h = window_get_fullscreen() ? view_full_h : view_h;
	
	//record view camera id
	view = view_camera[view_port];
	//view_set_camera(view_port,view);
	
	//resizes dimensions
	camera_set_view_size(view,pix_perf_w*view_zoom,pix_perf_h*view_zoom);
	display_set_gui_size(pix_perf_w, pix_perf_h);
	surface_resize(application_surface, appsurf_draw_size_w, appsurf_draw_size_h);
	window_set_size(appsurf_draw_size_w, appsurf_draw_size_h);
	
	//recenters window when getting out of fullscreen mode
	if (!window_get_fullscreen()) {alarm[0] = 10;}

}

/// @description toggles full screen mode
/// @function fullscreen_toggle()
/// @param pixel_perfect
function fullscreen_toggle(_pix_perf = true)
{
	//toggles full screen
	window_set_fullscreen(!window_get_fullscreen());
	
	//finds pixel perfect zoom
	var pix_perf_zoom = 1.0 + ((view_full_scale - floor(view_full_scale))/2)*_pix_perf;
	
	//finds pixel perfect dimensions
	var pix_perf_w = window_get_fullscreen() ? GAME_RES_WIDTH*pix_perf_zoom : GAME_RES_WIDTH;
	var pix_perf_h = window_get_fullscreen() ? GAME_RES_HEIGHT*pix_perf_zoom : GAME_RES_HEIGHT;
	
	//sets draw size
	var appsurf_draw_size_w = window_get_fullscreen() ? view_full_w : view_w;
	var appsurf_draw_size_h = window_get_fullscreen() ? view_full_h : view_h;
	
	//resizes dimensions
	camera_set_view_size(view,pix_perf_w*view_zoom,pix_perf_h*view_zoom);
	display_set_gui_size(pix_perf_w, pix_perf_h);
	surface_resize(application_surface, appsurf_draw_size_w, appsurf_draw_size_h);
	window_set_size(appsurf_draw_size_w, appsurf_draw_size_h);
	
	//recenters window when getting out of fullscreen mode
	if (!window_get_fullscreen()) {alarm[0] = 10;}
	
	//returns full screen state
	return window_get_fullscreen();

}

/// @descruption manages camera zoom
/// @function camera_set_zoom()
function camera_set_zoom()
{
	//gets zoom inputs
	var zoom_input = mouse_wheel_up() - mouse_wheel_down();
	view_zoom = clamp(view_zoom+(zoom_speed*zoom_input),view_min_zoom,view_max_zoom);
	
	//finds pixel perfect zoom
	var pix_perf_zoom = 1.0 + ((view_full_scale - floor(view_full_scale))/2);
	
	//finds pixel perfect dimensions
	var pix_perf_w = window_get_fullscreen() ? GAME_RES_WIDTH*pix_perf_zoom : GAME_RES_WIDTH;
	var pix_perf_h = window_get_fullscreen() ? GAME_RES_HEIGHT*pix_perf_zoom : GAME_RES_HEIGHT;
	
	//sets view
	camera_set_view_size(view,pix_perf_w*view_zoom,pix_perf_h*view_zoom);
	camera_set_view_pos(view, x - camera_get_view_width(view)/2, y - camera_get_view_height(view)/2);
}

/// @description manages camera position
/// @function camera_set_position()
function camera_set_position()
{
	
	//Positions Camera on the Controller
	var view_x = clamp(x - camera_get_view_width(view)/2, 0, room_width - camera_get_view_width(view));
	var view_y = clamp(y - camera_get_view_height(view)/2, 0, room_height - camera_get_view_height(view));

	//Calculates screen shake
	var shake_x = 0;
	var shake_y = 0;
	if(shake)
	{
		
		//substracts from timer
		shake_time--;
		
		//sets shake offset
		shake_x = choose(-shake_magnitude,shake_magnitude);
		shake_y = choose(-shake_magnitude,shake_magnitude);
		
		//starts decay once timer is done counting down
		if(shake_time <= 0) {
			
			//decays shake magnitude
			shake_magnitude -= shake_decay;
			
			//turns off shake effect
			if(shake_magnitude <= 0) {shake = NO;}
			
		}
			
	}

	//Sets view position
	camera_set_view_pos(view,view_x+shake_x,view_y+shake_y);
	
}

/// @description links player and camera (call from player's create event)
/// @function player_link_to_camera()
/// @param player_id
function player_link_to_camera(_p_id = id)
{
	//disables master camera
	if(instance_exists(global.master_camera)) {global.master_camera.camera_state = cameraStates.DISABLE;}
	
	//creates player camera
	var cam_id = instance_create_layer(x,y,layer,obj_player_camera);
	var _p_num = instance_number(PLAYER);
	
	//links camera and player
	//player vars
	camera_id = cam_id;
	//camera vars
	cam_id.player_id = _p_id;
	cam_id.player_number = _p_num;
	cam_id.following = _p_id;
	
	//enables view
	view_enabled = true;
	view_visible[_p_num] = true;
	
	//sets up view
	with(cam_id) {camera_setup(player_number);}
}
