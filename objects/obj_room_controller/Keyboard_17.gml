/// @description Toggles debug info
if(keyboard_check_pressed(vk_enter))
{
	if(DEVELOPERBUILD) {global.debug = !global.debug;}
	else {global.debug = false;}
}
