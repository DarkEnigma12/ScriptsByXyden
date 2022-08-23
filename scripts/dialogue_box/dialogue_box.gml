/// @desc creates a struct that holds all info for the speaker
/// @func dialogue_box_create
/// @param dialogue
/// @param expression_array
/// @param font
/// @param voice_sound
/// @param text_box_sprite
function dialogue_box_create(_dia,_expr=noone,_fnt=-1,_v=noone,_txtbx_spr=spr_blackbox_whiteborder)
{
	with(instance_create_layer(0,0,layer,dialogue_manager))
	{
		speaker =
		{
			speaker_id : other.id,
			dialogue : _dia,
			expressions : _expr,
			current_emotion :  noone,
			voice : _v,
			font : _fnt,
			textbox :	{
							//todo: need to change room dimensions to view dimensions
							sprite : _txtbx_spr,
							subimage : 0,
							xscale : room_width/sprite_get_width(_txtbx_spr),
							yscale : room_height/3/sprite_get_height(_txtbx_spr),
							x : 0,
							y : room_height-sprite_get_height(_txtbx_spr)*(room_height/3/sprite_get_height(_txtbx_spr)),
							color : c_white,
							alpha : 1
						},
		}
	}
}