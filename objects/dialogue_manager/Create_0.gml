/// @description Code

#region sets up the use of timeline
timeline_loop = false;
timeline_speed = 0;
#endregion

//vars
dialogue_text = "";
textbox_sprite = spr_blackbox_whiteborder;

//speaker info
speaker =
{
	id : noone,
	expressions : array_create(facialExpressions.TOTAL,noone),
	current_emotion : noone,
	voice : noone,
	font : -1,
	
}