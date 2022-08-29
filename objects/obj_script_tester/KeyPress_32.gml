/// @description Spawns Instance


if(!instance_exists(dialogue_manager))
{
	var _exp_arr = array_create(facialExpressions.TOTAL,noone);
	_exp_arr[facialExpressions.NORMAL] = spr_noone_talk_port;
	dialogue_box_create(dia_test1,determ_12pt_font,talkSpeed.NORM,_exp_arr,facialExpressions.NORMAL,snd_noone_voice);
}

exit;