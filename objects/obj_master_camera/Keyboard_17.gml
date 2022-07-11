/// @description Toggles debug info
if(keyboard_check_pressed(vk_enter)&&(object_index == obj_master_camera))
{
	if(DEVELOPERBUILD) {global.debug = !global.debug;}
	else {global.debug = false;}
}
