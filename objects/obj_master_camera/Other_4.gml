/// @description Enables Views at the Start of Every Room

if(camera_state != cameraStates.DISABLE)
{
	//enables views
	view_enabled = true;
	view_visible[global.master_view] = true;

	//sets up camera for room
	camera_setup(global.master_view);
}