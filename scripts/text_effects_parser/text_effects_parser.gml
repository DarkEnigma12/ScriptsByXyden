/// @desc		parses dialogue to set what text effect goes with what character
/// @func		textfx_parser
/// @param		{string} text
/// @returns	{array} returns a 2d array holding each character with their text effect
/*
				Anything in between two "|" is considered text effect code. 
				The code itself is a specific string capitalized.
				The text effect will be applied to each character until "|" is detected again.
				"||" resets everything to default.
*/
//used to call the position in the 2d array
enum text {CHARACTER, EFFECT, COLOR}

function textfx_parser(_text)
{
	//debug error codes
	if(!is_string(_text)) {show_debug_message("function text_parser() - argument is not a string."); return false;}
	
	//initializes parsed text array
	var _parsed_text = [];
	
	//loops through text and parses out the text effect code for each character
	var _txtfx_code = "";
	var _fxreader_active = NO;
	var _txt_col = c_white;
	for(var i = 0; i <= string_length(_text); ++i;)
	{
		//stores the raw text string in the first index of the array
		if(i == 0) {array_push(_parsed_text,[_text,"RAW TEXT",_txt_col]); continue;}
		
		//parser
		var _cur_char = string_char_at(_text,i);
		switch(_cur_char)
		{
			case("|"):
				if(_fxreader_active) 
				{
					_fxreader_active = NO; 
					if(_txtfx_code == "") {_txt_col = c_white;}
				}
				else {_fxreader_active = YES; _txtfx_code = "";}
				
				#region COLOR SETTER
				switch(string_letters(_txtfx_code))
				{
					//white, gray, black
					case("WHITE"):	_txt_col = c_white; break;
					case("BLACK"):	_txt_col = c_black; break;
					case("GRAY"):	_txt_col = c_gray; break;
		
					//basic colors
					case("RED"):	_txt_col = c_red; break;
					case("ORANGE"):	_txt_col = c_orange; break;
					case("YELLOW"):	_txt_col = c_yellow; break;
					case("GREEN"):	_txt_col = c_green; break;
					case("BLUE"):	_txt_col = c_blue; break;
					case("PURPLE"):	_txt_col = c_purple; break;
		
					//make color from rgb value
					case("RGB"): //format: |RGB(000,000,000)|
						var _r = real(string_copy(_txtfx_code,5,3));
						var _g = real(string_copy(_txtfx_code,9,3));
						var _b = real(string_copy(_txtfx_code,13,3));
						_txt_col = make_color_rgb(_r,_g,_b);
					break;
		
					//make color from hex code 
					//(REMEMBER: GameMaker switches the blue component and red component |0xBBGGRR|)
					default: if(string_length(_txtfx_code)==8)&&(string_copy(_txtfx_code,1,2)=="0X") {_txt_col = real(_txtfx_code);}
				}
				#endregion
			break;
			
			default:
				//saves text effect
				if(_fxreader_active) {_txtfx_code += string_upper(_cur_char);}
				else {array_push(_parsed_text,[_cur_char,_txtfx_code,_txt_col]);}
		}
	}
	
	//returns the full array holding each character with their respective text effect code
	return _parsed_text;
}