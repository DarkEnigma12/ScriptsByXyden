/// @description Code

#region sets up the use of timeline
timeline_loop = false;
timeline_speed = 0;
#endregion

//vars
dialogue_text = "";

//speaker info
speaker =
{
	id : noone,
	expressions : array_create(facialExpressions.TOTAL,noone),
	current_emotion : noone,
	voice : noone,
	font : -1,
	textbox :	{
					sprite : spr_blackbox_whiteborder,
					subimage : 0,
					x : room_width/2,
					y : room_height/2,
					xscale : room_width/sprite_get_width(spr_blackbox_whiteborder),
					yscale : room_height/sprite_get_height(spr_blackbox_whiteborder),
					color : c_white,
					alpha : 1
				},
}

#region METHODS
font_set = function(_reset = NO)
{
	
}
#endregion

