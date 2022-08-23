/// @description Draws dialogue

//waits for dialogue to be parsed
if(dialogue_text == noone) exit;

//vars
var _dia_x = speaker.textbox.x;
var _dia_y = speaker.textbox.y;

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
if(type_timer <= 0)
{
	type_count += 1;
} else {type_timer = 5;}
type_timer -= 1;

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
}





//resets font
font_set();