/// @desc creates a struct that holds all info for the speaker
/// @func dialogue_box_create
/// @param dialogue
/// @param font
/// @param talk_speed
/// @param expression_array
/// @param starting_emotion
/// @param voice_sound
/// @param text_box_sprite
function dialogue_box_create(_dia,_fnt=-1,_tlkspd=talkSpeed.NORM,_expr=noone,_emot=noone,_v=snd_text_box,_txtbx_spr=spr_blackbox_whiteborder)
{
	with(instance_create_layer(0,0,layer,dialogue_manager))
	{	
		//sets up speaker struct
		speaker =
		{
			id : other.id,
			dialogue : _dia,
			expressions : _expr,
			current_emotion :  _emot,
			voice : _v,
			font : _fnt,
			talkspeed : _tlkspd,
			textbox :	{
							sprite : _txtbx_spr,
							subimage : 0
						},
		}
	}
}

/// @desc sets up dialogue box for a prompt
/// @func create_prompt
/// @param response_array
/// @param reaction_array
function create_prompt(_respond,_react,_col=c_white)
{
	if(is_array(_respond))&&(is_array(_react))
	{
		prompt =
		{
			responses : _respond,
			reactions : _react,
			choice : -1,
			selector : spr_menu_selector,
			col : _col
		}
	} else {prompt = noone;}
}