/// @description Draws dialogue

//waits for dialogue to be parsed
if(timeline_index == -1) {timeline_index = speaker.dialogue;}
if(dialogue_text == noone) {exit;}

//vars
var _dia_len = array_length(dialogue_text)-1;
var _dia_x = speaker.textbox.x;
var _dia_y = speaker.textbox.y;
var _dia_box_w = sprite_get_width(speaker.textbox.sprite)*speaker.textbox.xscale;
var _dia_box_h = sprite_get_height(speaker.textbox.sprite)*speaker.textbox.yscale;

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

//sets font
font_set(speaker.font);

//manages typing speed
if(type_count < _dia_len)
{
	if(type_timer <= 0) {type_count += 1; type_timer = 0;} else {type_timer -= 1;}
}

//draws dialogue
var _char,_char_w = 0,_char_h = 0;
var _fnt_h = string_height("ABCDEFGHIJKLMNOPQRSTUVWXYZ");
var i = 0;
while(i < type_count)
{
	//increments i
	++i;
	
	//grabs character info
	_char = dialogue_text[i][text.CHARACTER];
	
	//draws dialogue with text effects
	switch(dialogue_text[i][text.EFFECT])
	{
		default: draw_text_color(_dia_x+_char_w,_dia_y+_char_h*_fnt_h,_char,c_white,c_white,c_white,c_white,1);
	}
	
	//calculates the position of the next character
	var _word_w = 0, _ii = i;
	if(_ii+1 < _dia_len) {do{++_ii; _word_w += string_width(dialogue_text[_ii][text.CHARACTER]);} until((dialogue_text[_ii][text.CHARACTER] == " ")||(_ii+1>_dia_len));}
	if(_char_w+_word_w < _dia_box_w) {_char_w += string_width(_char);} else {_char_h+=1; _char_w = 0;}
}





//resets font
font_set();