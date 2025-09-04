///@desc Runs state machine

//destroys instance and exits if not a developer build
if(!DEVELOPERBUILD) {instance_destroy(id, false); exit;}

//activates and deactivates cmd sys
if(!cmd_active)
{
	//activates cmd sys
	if(cheat_code_check(CMDSYS_KEYS)) {cmd_active = YES;}
}
else
{
	//runs cmd sys state machine
	
	
	//deactivates cmd sys
	if(keyboard_check_pressed(cmd_esc_key)) {cmd_active = NO;}
}
