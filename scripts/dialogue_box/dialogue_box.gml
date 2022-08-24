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
		//calculates textbox dimensions
		var _xscale = display_get_gui_width()/sprite_get_width(_txtbx_spr);
		var _yscale = (display_get_gui_height()/3)/sprite_get_height(_txtbx_spr);
		
		//sets up speaker struct
		speaker =
		{
			speaker_id : other.id,
			dialogue : _dia,
			expressions : _expr,
			current_emotion :  _emot,
			voice : _v,
			font : _fnt,
			talkspeed : _tlkspd,
			textbox :	{
							//todo: need to change room dimensions to view dimensions
							sprite : _txtbx_spr,
							subimage : 0,
							xscale : _xscale,
							yscale : _yscale,
							x : 0,
							y : display_get_gui_height()-sprite_get_height(_txtbx_spr)*_yscale,
							color : c_white,
							alpha : 1
						},
		}
	}
}