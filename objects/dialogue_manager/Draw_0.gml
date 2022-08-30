/// @description Draws dialogue

//waits for dialogue to be parsed
if(timeline_index == -1) {timeline_index = speaker.dialogue;}
if(dialogue_text == noone) {exit;}

//sets font
font_set(speaker.font);

#region Vars
//dimensions
var _xscale = room_width/sprite_get_width(speaker.textbox.sprite);
var _yscale = (room_height/3)/sprite_get_height(speaker.textbox.sprite);
var _xx = 0;
var _yy = (room_height-sprite_get_height(speaker.textbox.sprite)*_yscale)*text_box_pos;
var _dia_len = array_length(dialogue_text)-1;
var _dia_box_w = sprite_get_width(speaker.textbox.sprite)*_xscale;
var _dia_box_h = sprite_get_height(speaker.textbox.sprite)*_yscale;
var _port_space = _dia_box_w/3;
var _dia_x = _xx + _port_space;
var _dia_y = _yy + 10;
var _outline_padding = 5;
var _talking = (type_count < _dia_len)&&(page_break_position == page_break_new_position);

//drawing fx
var _char,_char_w = 0,_char_h = 0, _max_lines = 3;
var _fnt_h = string_height("ABCDEFGHIJKLMNOPQRSTUVWXYZ"), _line_gap = 5, _line_spacing = _fnt_h+_line_gap;
var time_offset = 0, wave_level = 0; //for sine wave function
#endregion

#region TEXT BOX
switch(text_box_type)
{
	case(textBoxType.TEXTBOX):
		//draws nine slice text box sprite
		draw_sprite_ext(
			speaker.textbox.sprite,
			speaker.textbox.subimage,
			_xx, _yy, _xscale, _yscale, 0, c_white, 1
		);
	break;
	
	case(textBoxType.BUBBLE):
		var _tri_base_w = 10;
		var _speaker_x =speaker.id.x;
		var _speaker_y =speaker.id.y;
		var _bubb_x = _xx + _dia_box_w/2;
		var _bubb_y = _yy + _dia_box_h/2;
		var _base_point1_x = _bubb_x + lengthdir_x(_tri_base_w, point_direction(_bubb_x,_bubb_y,_speaker_x,_speaker_y)+90);
		var _base_point1_y = _bubb_y + lengthdir_y(_tri_base_w, point_direction(_bubb_x,_bubb_y,_speaker_x,_speaker_y)+90);
		var _base_point2_x = _bubb_x + lengthdir_x(_tri_base_w, point_direction(_bubb_x,_bubb_y,_speaker_x,_speaker_y)-90);
		var _base_point2_y = _bubb_y + lengthdir_y(_tri_base_w, point_direction(_bubb_x,_bubb_y,_speaker_x,_speaker_y)-90);
		draw_primitive_begin(pr_trianglelist);
		draw_vertex(_speaker_x,_speaker_y);
		draw_vertex(_base_point1_x,_base_point1_y);
		draw_vertex(_base_point2_x,_base_point2_y);
		draw_primitive_end();
		draw_roundrect(_xx,_yy,_xx+_dia_box_w-1,_yy+_dia_box_h-1,0);
		if(dialogue_text[type_count][text.COLOR] == c_white) {dialogue_text[type_count][text.COLOR] = c_black;}
		if(prompt != noone) {if(prompt.col == c_white) {prompt.col = c_black;}}
		
	break;
}
 
#endregion

//draw portrait
if(speaker.current_emotion != noone)&&(speaker.expressions[speaker.current_emotion] != noone)
{
	//animates mouth and voice
	var _syllable_test = 4;
	var _test_chr = dialogue_text[min(type_count,_dia_len)][text.CHARACTER];
	var _portrait_mouth_image = portaitMouth.CLOSED;
	if(_talking)
	{
		switch(string_upper(_test_chr))
		{
			case("#"):
			case(" "):
			case("."):
			case("?"):
			case("!"):
			case(""):
				_portrait_mouth_image = portaitMouth.CLOSED;
			break;
			
			default: 
				if(type_timer <= 0) {audio_play_sound(speaker.voice,1,false);}
				_portrait_mouth_image = !(type_count mod _syllable_test) ? portaitMouth.CLOSED : portaitMouth.OPENED;
		}
	}
	
	//base portrait dimensions: 64 x 64; any perfect scale of that works too
	var _port_spr = speaker.expressions[speaker.current_emotion];
	var _port_scale = 64/sprite_get_width(_port_spr);
	draw_sprite_ext(_port_spr,_portrait_mouth_image,_xx+_outline_padding,_yy+_outline_padding,_port_scale,_port_scale,0,c_white,1);
}
//changes dialogue origin if portrait is not drawn
else
{
	_dia_x = _xx + 30;
	_dia_y = _yy + 10;
}

#region PROMPT SYSTEM
if((prompt != noone)&&(type_count >= _dia_len))
{
	//draws options
	var _selector_spr = prompt.selector;
	var _selector_w = sprite_get_width(_selector_spr);
	switch(array_length(prompt.responses))
	{
		case(2):
			//draws options
			var _prev_col = draw_get_color(); draw_set_color(prompt.col);
			var _opt1 = 0, _opt2 = 1;
			var _spacing = 5;
			var _re_line = _dia_y+(_max_lines-1)*_line_spacing;
			var _opt_x1 = _dia_x + _selector_w + _spacing;
			var _opt_x2 = _dia_box_w-2*_outline_padding-string_width(prompt.responses[1]) - (_selector_w + _spacing);
			//first option
			draw_sprite_ext(_selector_spr,0,_opt_x1-(_selector_w + _spacing),_re_line+_fnt_h/2,1,1,0,c_white,(prompt.choice == _opt1));
			draw_text(_opt_x1,_re_line,prompt.responses[_opt1]);
			//second option
			draw_sprite_ext(_selector_spr,0,_opt_x2-(_selector_w + _spacing),_re_line+_fnt_h/2,1,1,0,c_white,(prompt.choice == _opt2));
			draw_text(_opt_x2,_re_line,prompt.responses[_opt2]);
			draw_set_color(_prev_col);
			
			//manages selection
			if
			dialogue_controls.selector.up()||
			dialogue_controls.selector.down()||
			dialogue_controls.selector.left()||
			dialogue_controls.selector.right()
			{
				//sets choice
				if(prompt.choice == -1) {prompt.choice = dialogue_controls.selector.down()||dialogue_controls.selector.right();}
				else {prompt.choice = !prompt.choice;}
				//plays sound
				
			}
			else if(dialogue_controls.confirm())&&(prompt.choice != -1)
			{new_page(prompt.reactions[@ prompt.choice]); prompt = noone;}
		break;
		
		case(4):
		
		break;
	}
}
#endregion

//moves along dialogue
else if(dialogue_controls.confirm())
{
	//ends dialogue if called for
	if(end_dialogue) {instance_destroy();}
	
	//moves to new page break
	else if(page_break_position != page_break_new_position)	{page_break_position = page_break_new_position;}
	
	//jumps dialogue
	else if(type_count < _dia_len) {type_count = _dia_len;}
	
	//goes to next page
	else if(timeline_position <= timeline_max_moment(timeline_index)) {new_page();}
	
	//destroys dialogue box if dialogue is done
	else {instance_destroy();}
}

//manages typing speed
if(_talking)
{
	if(type_timer <= 0) 
	{
		//calculates natural pauses in speech
		var _delay = 0;
		var _test_chr = dialogue_text[type_count][text.CHARACTER];
		var _next_chr = (type_count+1 < _dia_len) ? dialogue_text[type_count+1][text.CHARACTER] : "";
		switch(_test_chr)
		{
				
			case("#"): _delay = 20; break;
			case(","): _delay = 10; break;
			case("."):
			case("!"):
			case("?"): if (_next_chr == " ") {_delay = 20;} else _delay = 0; break;
				
		}
		
		type_count += (sign(speaker.talkspeed) == -1) ? abs(speaker.talkspeed) : 1;	//if talk speed is negative, add the absolute value of talk speed to type count;
		type_timer = max(speaker.talkspeed,0) + _delay;								//prevents timer from being assigned a negative number then adds delay
	} else {type_timer -= 1;}
}

//draws dialogue
var i = page_break_position;
while(i < min(type_count,_dia_len))
{
	//increments i
	++i;
	
	//calculates time offset for sine wave function
	time_offset += wave_level;
	
	//grabs character info
	_char = dialogue_text[i][text.CHARACTER];
	
	//special characters
	switch(_char)
	{
		//ignore list
		case("#"):
		case("|"):
			continue;
		break;
		
		//line break
		case("\n"):
			_char_h += 1;
			_char_w  = 0;
		break;
		
		//end dialogue
		case("\\"):
			end_dialogue = YES;
			continue;
		break;
	}
	
	#region TEXT EFFECTS SYSTEM
	//vars
	var _txtfx_code = dialogue_text[i][text.EFFECT];
	var _txt_col	= dialogue_text[i][text.COLOR];
	var _xx = _dia_x+_char_w;
	var _yy = _dia_y+_char_h*_line_spacing;
	
	//draws text with effect
	switch(string_letters(_txtfx_code))
	{
		case("JITTER"):
			var _fx_factor = ((string_digits(_txtfx_code) == 0)||(string_digits(_txtfx_code) == "")) ? 0.25 : string_digits(_txtfx_code);
			draw_text_color(_xx+random_range(-_fx_factor,_fx_factor),_yy+random_range(-_fx_factor,_fx_factor),_char,_txt_col,_txt_col,_txt_col,_txt_col,1);
		break;
		
		case("TWITCH"):
			var _fx_factor = ((string_digits(_txtfx_code) == 0)||(string_digits(_txtfx_code) == "")) ? 1 : string_digits(_txtfx_code);
			var _fx_chance = 2*(irandom_range(1,power(10,_fx_factor))==1);
			draw_text_color(_xx+random_range(-_fx_chance,_fx_chance),_yy+random_range(-_fx_chance,_fx_chance),_char,_txt_col,_txt_col,_txt_col,_txt_col,1);
		break;
		
		case("WAVE"):
			wave_level = clamp(((string_digits(_txtfx_code) == "")) ? 0 : string_digits(_txtfx_code),0,100);
			var wave_low = -2;
			var wave_high = 2;
			var frequency = 0.5;
			var _time = current_time + time_offset;
			var wave_midpoint = (wave_high - wave_low) * 0.5;
			var wave_shift = wave_low + wave_midpoint + sin((((_time*0.001) + frequency) / frequency) * (pi*2)) * wave_midpoint;
			draw_text_color(_xx,_yy-wave_shift,_char,_txt_col,_txt_col,_txt_col,_txt_col,1);
		break;
		
		default: draw_text_color(_xx,_yy,_char,_txt_col,_txt_col,_txt_col,_txt_col,1);
	}
	#endregion
	
	//draws asterisk
	if(show_asterisk)&&(_char_w == 0)&&
	(ord(_char)>=65)&&(ord(_char)<=90) //checks ascii code to see if char is an upper case letter
	{draw_text(_dia_x-20,_dia_y+_char_h*_line_spacing,"*");}
	
	//calculates the position of the next word
	var _word_w = 0, _ii = i;
	if(_ii+1 < _dia_len) {do{++_ii; _word_w += string_width(dialogue_text[_ii][text.CHARACTER]);} until((dialogue_text[_ii][text.CHARACTER] == " ")||(_ii+1>_dia_len));}
	if(_dia_x+_char_w+_word_w < _dia_box_w-2*_outline_padding) {_char_w += string_width(_char);} else {_char_h+=1; _char_w = 0;}
	
	//breaks dialogue into blocks of three lines max
	if(_char_h >= _max_lines) {type_count = i; page_break_new_position = i; break;}
}

//resets font
font_set();