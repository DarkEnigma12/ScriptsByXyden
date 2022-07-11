/// @description gets the height of a font in pixels
/// @function font_get_pix_h(font)
/// @param font
function font_get_pix_h(){
	
	var f = argument[0];
	var f_size = 0;
	var test_string = " ";
	
	//Sets default font to new font, measures it then sets it back to default
	draw_set_font(f);
	f_size = string_height(test_string);
	draw_set_font(-1);
	
	return f_size;

}//end of function

/// @description gets the height of a string in pixels depending on provided font
/// @function string_get_pix_h()
///@param string
/// @param font
function string_get_pix_h(_str,_font)
{
	
	//vars ini
	var s_size = 0;
	var test_string = string(_str);
	
	//Sets default font to new font, measures string (line breaks and all) then sets font back to default
	draw_set_font(_font);
	s_size = string_height(test_string);
	draw_set_font(-1);
	
	return s_size;

}//end of function