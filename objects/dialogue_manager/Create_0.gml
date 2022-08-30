/// @description Code

#region sets up the use of timeline
timeline_running = true;
timeline_position = 1;
timeline_speed = 0;
timeline_loop = false;
#endregion

#region VARS
//general
dialogue_text = noone;
end_dialogue = NO;
show_asterisk = YES;
prompt = noone;

//page break vars
page_break_position = 0;
page_break_new_position = 0;

//typewriter vars
type_count = 0;
type_timer = 0;

//dialogue types
text_box_type = textBoxType.BUBBLE;
text_box_pos = textBoxPos.BOTTOM;

#endregion

//controls
dialogue_controls = 
{
	confirm		: function() {return keyboard_check_pressed(vk_enter);},
	selector	:
				{
					up		: function() {return keyboard_check_pressed(ord("W"));},
					down	: function() {return keyboard_check_pressed(ord("S"));},
					right	: function() {return keyboard_check_pressed(ord("D"));},
					left	: function() {return keyboard_check_pressed(ord("A"));},
				}
}

#region METHODS
//sets font
font_set = function(_fnt = -1)
{
	static prev_font = draw_get_font();
	if(_fnt != -1) {draw_set_font(_fnt);}
	else {draw_set_font(prev_font);}
}
//new page
new_page = function(_pg_num = -1)
{
if(_pg_num != -1) {timeline_position = _pg_num+1;} else {++timeline_position;}
page_break_position = 0; 
page_break_new_position = 0; 
type_count = 0; type_timer = 0;	
}
#endregion
