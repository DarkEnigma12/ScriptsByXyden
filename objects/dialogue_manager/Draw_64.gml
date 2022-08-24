/// @description Draws dialogue

//waits for dialogue to be parsed
if(timeline_index == -1) {timeline_index = speaker.dialogue;}
if(dialogue_text == noone) {exit;}

//vars
var _dia_len = array_length(dialogue_text)-1;
var _dia_box_w = sprite_get_width(speaker.textbox.sprite)*speaker.textbox.xscale;
var _dia_box_h = sprite_get_height(speaker.textbox.sprite)*speaker.textbox.yscale;
var _dia_x = speaker.textbox.x + _dia_box_w/3;
var _dia_y = speaker.textbox.y + 10;
var _talking = (type_count < _dia_len)&&(page_break_position == page_break_new_position);

//draws nine slice text box sprite
draw_sprite_ext(
	speaker.textbox.sprite,
	speaker.textbox.subimage,
	speaker.textbox.x,
	speaker.textbox.y,
	speaker.textbox.xscale,
	speaker.textbox.yscale,
	0,
	speaker.textbox.color,
	speaker.textbox.alpha
);

//draw portrait
//testing
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
				_portrait_mouth_image = (type_count mod _syllable_test == 0) ? portaitMouth.CLOSED : portaitMouth.OPENED;
		}
	}
	
	//base portrait dimensions: 64 x 64; any perfect scale of that works too
	var _port_spr = speaker.expressions[speaker.current_emotion];
	var _port_scale = 64/sprite_get_width(_port_spr);
	var _outline_padding = 5;
	draw_sprite_ext(_port_spr,_portrait_mouth_image,speaker.textbox.x+_outline_padding,speaker.textbox.y+_outline_padding,_port_scale,_port_scale,0,c_white,1);
}
//changes dialogue origin if portrait is not drawn
else
{
	_dia_x = speaker.textbox.x + 30;
	_dia_y = speaker.textbox.y + 10;
}

//moves along dialogue
if(keyboard_check_pressed(confirm_button))
{	
	//moves to new page break
	if(page_break_position != page_break_new_position)	{page_break_position = page_break_new_position;}
	
	//jumps dialogue
	else if(type_count < _dia_len) {type_count = _dia_len;}
	
	//goes to next page
	else if(timeline_position <= timeline_max_moment(timeline_index)) 
	{
		++timeline_position; 
		page_break_position = 0; 
		page_break_new_position = 0; 
		type_count = 0; type_timer = 0;
	}
	
	//destroys dialogue box if dialogue is done
	else {instance_destroy(); exit;}
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

//sets font
font_set(speaker.font);

//draws dialogue
var _char,_char_w = 0,_char_h = 0;
var _fnt_h = string_height("ABCDEFGHIJKLMNOPQRSTUVWXYZ"), _line_gap = 5;
var _line_spacing = _fnt_h+_line_gap;
var i = page_break_position;
while(i < min(type_count,_dia_len)) //min prevents i from calling an index outside the dialogue array
{
	//increments i
	++i;
	
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
	}
	
	#region TEXT EFFECTS SYSTEM
	//vars
	var _txtfx_code = dialogue_text[i][text.EFFECT];
	var _xx = _dia_x+_char_w;
	var _yy = _dia_y+_char_h*_line_spacing;
	
	//color setter
	switch(string_letters(_txtfx_code))
	{
		//white, gray, black
		case("WHITE"): case(""): text_color = c_white; break;
		case("BLACK"): text_color = c_black; break;
		case("GRAY"): case("GREY"): text_color = c_gray; break;
		
		//basic colors
		case("RED"): text_color = c_red; break;
		case("ORANGE"): text_color = c_orange; break;
		case("YELLOW"): text_color = c_yellow; break;
		case("GREEN"): text_color = c_green; break;
		case("BLUE"): text_color = c_blue; break;
		case("PURPLE"): text_color = c_purple; break;
		
		//make color
		case("RGB"): 
			var _r = real(string_copy(_txtfx_code,5,3));
			var _g = real(string_copy(_txtfx_code,9,3));
			var _b = real(string_copy(_txtfx_code,13,3));
			text_color = make_color_rgb(_r,_g,_b);
		break;
	}
	
	//positional effects
	switch(string_letters(_txtfx_code))
	{
		default: draw_text_color(_xx,_yy,_char,text_color,text_color,text_color,text_color,1);
	}
	#endregion
	
	//draws asterisk
	if(show_asterisk)&&(_char_w == 0)&&
	(ord(_char)>=65)&&(ord(_char)<=90) //checks ascii code to see if char is an upper case letter
	{draw_text(_dia_x-20,_dia_y+_char_h*_line_spacing,"*");}
	
	//calculates the position of the next word
	var _word_w = 0, _ii = i;
	if(_ii+1 < _dia_len) {do{++_ii; _word_w += string_width(dialogue_text[_ii][text.CHARACTER]);} until((dialogue_text[_ii][text.CHARACTER] == " ")||(_ii+1>_dia_len));}
	if(_dia_x+_char_w+_word_w < _dia_box_w-10) {_char_w += string_width(_char);} else {_char_h+=1; _char_w = 0;}
	
	//breaks dialogue into blocks of three lines max
	if(_char_h >= 3) {type_count = i; page_break_new_position = i; break;}
}

//resets font
font_set();