/// @description Runs State Machine

state.run();

//Positions Camera on the Holder
var view_x, view_y;
if(global.camera.toggle.clamp_room)
{
	view_x = clamp(x - camera_get_view_width(view_camera[global.camera.view])/2, 0, room_width - camera_get_view_width(global.camera.id));
	view_y = clamp(y - camera_get_view_height(view_camera[global.camera.view])/2, 0, room_height - camera_get_view_height(global.camera.id));

}
else
{
	view_x = x - camera_get_view_width(view_camera[global.camera.view])/2;
	view_y = y - camera_get_view_height(view_camera[global.camera.view])/2
}
camera_set_view_pos(view_camera[global.camera.view],view_x,view_y);

//fullscreen toggle
if(global.camera.toggle.fullscreen)
{
	
	//toggles fullscreen
	window_set_fullscreen(!window_get_fullscreen());
	
	//screen resize
	fullscreen_toggle();
	
	//resets toggle trigger
	global.camera.toggle.fullscreen = false;
	
}