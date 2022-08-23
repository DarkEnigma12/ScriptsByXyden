/// @description Code

#region sets up the use of timeline
timeline_running = true;
timeline_position = 1;
timeline_speed = 0;
timeline_loop = false;
#endregion

//vars
dialogue_text = noone;

//typewriter vars
type_count = 0;
type_timer = 0;

//speaker info
speaker =
{
	id : noone,
	dialogue: dia_test1,
	expressions : array_create(facialExpressions.TOTAL,noone),
	current_emotion : noone,
	voice : noone,
	font : -1,
	textbox :	{
					sprite : spr_blackbox_whiteborder,
					subimage : 0,
					xscale : room_width/sprite_get_width(spr_blackbox_whiteborder),
					yscale : room_height/3/sprite_get_height(spr_blackbox_whiteborder),
					x : 0,
					y : room_height-sprite_get_height(spr_blackbox_whiteborder)*(room_height/3/sprite_get_height(spr_blackbox_whiteborder)),
					color : c_white,
					alpha : 1
				},
}

#region METHODS
//sets font
font_set = function(_fnt = -1)
{
	static prev_font = draw_get_font();
	if(_fnt != -1) {draw_set_font(_fnt);}
	else {draw_set_font(prev_font);}
}
#endregion

//testing
timeline_index = speaker.dialogue;