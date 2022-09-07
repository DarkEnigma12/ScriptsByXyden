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
		//vars todo: change these to view height and width
		var _xscale = room_width/sprite_get_width(_txtbx_spr);
		var _yscale = (room_height/3)/sprite_get_height(_txtbx_spr);
		var _xx = 0;
		var _yy = room_height-sprite_get_height(_txtbx_spr)*_yscale;
		
		//sets up speaker struct
		speaker =
		{
			id : other.id,
			dialogue : _dia,
			expressions : _expr,
			current_emotion :  _emot,
			draw_face : YES,
			voice : _v,
			font : _fnt,
			talkspeed : _tlkspd,
			textbox :	{
							sprite : _txtbx_spr,
							subimage : 0,
							xx : _xx,
							yy : _yy,
							xscale : _xscale,
							yscale : _yscale,
							outline_padding :	function(_txtbx_spr_ref=sprite) 
												{
													switch(_txtbx_spr_ref)
													{
														case(spr_blackbox_whiteborder): return 5; break;
														default: return 0;
													}
												}
						},
		}
	}
}

/// @desc manually sets the position and size of the dialogue box
/// @func dialogue_box_set_pos
/// @param x
/// @param y
/// @param width
/// @param height
function dialogue_box_set_pos()
{
	with(speaker.textbox)
	{
		xx = argument[0];
		yy = argument[1];
		xscale = argument[2]/sprite_get_width(sprite);
		yscale = argument[3]/sprite_get_height(sprite);
	}
}

/// @desc sets up dialogue box for a prompt
/// @func create_prompt
/// @param response_array
/// @param reaction_array
function create_prompt(_respond,_react,_color=c_white)
{
	if(is_array(_respond))&&(is_array(_react))
	{
		prompt =
		{
			responses : _respond,
			reactions : _react,
			choice : -1,
			selector : spr_menu_selector,
			col : _color
		}
	} else {prompt = noone;}
}

/// @desc tells system not to draw the protrait
/// @func dialogue_box_show_portrait
/// @param bool
function dialogue_box_show_portrait(_bool) {speaker.draw_face = bool(_bool);}

/// @desc tells system whoch text box type to use
/// @func dialogue_box_textbox_type
/// @param text_box_enum
function dialogue_box_textbox_type(_txtbx_type) {text_box_type = _txtbx_type;}