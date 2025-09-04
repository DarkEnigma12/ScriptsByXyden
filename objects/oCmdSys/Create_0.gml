///@desc Set Up for Command System

//Cmd Sys key macro
#macro CMDSYS_KEYS	[vk_up, vk_left, vk_down, vk_right, vk_left, ord("X"), ord("D")] //todo: convert all into their number

//Color Macros Used
#macro C_ROYALBLUE			#4169E1
#macro C_ERROR_RED			#EE4B2B
#macro C_COOLYELLOW			#FFE338

//Alarm tags
enum cmdsys_alarm_tag
{
	cursor_timer = 0,
	misc
}

//origin of debug command window
#macro CMD_X	10
#macro CMD_Y	10

#region VARS
//sets if command system is active
cmd_active = NO;
//key to exit command system
cmd_esc_key = vk_escape;
#endregion