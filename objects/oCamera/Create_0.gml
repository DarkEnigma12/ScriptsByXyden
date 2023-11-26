/// @description Set Up

//sets cam object as persistent
persistent = true;

//sets up draw event
application_surface_draw_enable(false);

//global camera struct
global.camera =
{
	id		: view_camera[0],		//this is the camera id
	holder	: other.id,				//this is the instance controlling the camera
	view	: 0,					//this is the view the camera uses
	aspect_ratio : GAME_RES_WIDTH/GAME_RES_HEIGHT,
	toggle :
	{
		fullscreen	: NO,					//set this to true to toggle fullscreen
		clamp_room	: NO,					//set this to true to keep camera within room
	},
	scale :	
	{
		window		: (display_get_width()>display_get_height()) ? floor(display_get_height()/GAME_RES_HEIGHT) : floor(display_get_width()/GAME_RES_WIDTH),
		fullscreen	: (display_get_width()>display_get_height()) ? (display_get_height()/GAME_RES_HEIGHT) : (display_get_width()/GAME_RES_WIDTH),
	},
	zoom	: 
	{
		level	: 1,
		max_lvl	: 4,
		min_lvl	: 1,
	},
}

//state machine
state = 
{
	#region VARS
	//holds state that is running
	run	: noone,
	
	//follow vars
	follow :
	{
		id		: obj_player,
		speed	: 0.1,
	},
	#endregion
	
	#region STATES
	following	: function()
	{
		if(instance_exists(follow.id))
		{
			other.x = lerp(other.x,follow.id.x,follow.speed);
			other.y = lerp(other.y,follow.id.y,follow.speed);
		}
	},
	#endregion
} state.run = state.following; //sets default state

#region CAMERA EFFECTS
//camera shake
shake =
{
	x			: 0,
	y			: 0,
	magnitude	: 0,	//how strong the shake will be
	decay		: 0,	//how fast the shake weakens
	weight		:		//what the shake prefers
	{
		x_axis	: 0,
		y_axis	: 0,
	}
}
#endregion

#region METHODS
//view enable method
view_activate = function(_view=global.camera.view)
{	
	//activates view for the room
	view_enabled = true;
	view_visible[_view] = true;
}

//fullscreen toggle method
camera_resize = function()
{
	//vars
	var _fullscreen = window_get_fullscreen();
	var _scale = _fullscreen ? global.camera.scale.fullscreen : global.camera.scale.window;

	//resizes window
	var _w_scaled = GAME_RES_WIDTH*_scale;
	var _h_scaled = GAME_RES_HEIGHT*_scale;
	window_set_size(_w_scaled,_h_scaled);
	
	//resizes application surface
	var _sub_pixel_offset = 2;
	var _appsurf_w = _fullscreen ? display_get_width() : _w_scaled;
	var _appsurf_h = _fullscreen ? display_get_height() : _h_scaled;
	surface_resize(application_surface,_appsurf_w+_sub_pixel_offset,_appsurf_h+_sub_pixel_offset);
	
	//resizes view
	var _view_w = _fullscreen ? display_get_width()/floor(_scale) : GAME_RES_WIDTH;
	var _view_h = _fullscreen ? display_get_height()/floor(_scale) : GAME_RES_HEIGHT;
	camera_set_view_size(view_camera[global.camera.view],_view_w,_view_h);
	
	//centers window
	alarm[0] = 10;	
	
	//debugging
	show_debug_message("\nDimensions\n Window: {0} x {1}\n App Surface: {2} by {3}\n View: {4} by {5}\n Target Res: {6} by {7}\n",window_get_width(),window_get_height(),surface_get_width(application_surface),surface_get_height(application_surface),camera_get_view_width(view_camera[global.camera.view]),camera_get_view_height(view_camera[global.camera.view]),GAME_RES_WIDTH,GAME_RES_HEIGHT);
} camera_resize();

#endregion

#region FUNCTIONS
//sets camera shake
/// @func camera_shake(camera controller,magnitude,decay,weight_x,weight_y)
function camera_shake(_cam,_mag,_decay,_weight_x=1,_weight_y=1)
{
	_cam.shake.magnitude	= _mag;
	_cam.shake.decay		= _decay;
	_cam.shake.weight.x_axis= _weight_x;
	_cam.shake.weight.y_axis= _weight_y;
	
}
#endregion
