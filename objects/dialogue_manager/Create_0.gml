/// @description Code

#region sets up the use of timeline
timeline_running = true;
timeline_position = 1;
timeline_speed = 0;
timeline_loop = false;
#endregion

//vars
dialogue_text = noone;
page_break_position = 0;
page_break_new_position = 0;
confirm_button = vk_enter;
show_asterisk = YES;
prompt =
{
	question : noone,
	responses : []
}

//typewriter vars
type_count = 0;
type_timer = 0;

#region METHODS
//sets font
font_set = function(_fnt = -1)
{
	static prev_font = draw_get_font();
	if(_fnt != -1) {draw_set_font(_fnt);}
	else {draw_set_font(prev_font);}
}
#endregion
