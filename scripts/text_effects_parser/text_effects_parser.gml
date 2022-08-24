/// @desc		parses dialogue to set what text effect goes with what character
/// @func		textfx_parser
/// @param		{string} text
/// @returns	{array} returns a 2d array holding each character with their text effect
/*
				The parse looks for the character "|", anything after that and before a space 
				will be considered text effect code. 
				The code itself is a specific string capitalized.
				The text effect will be applied to each character until "|" is detected again.
*/
//used to call the position in the 2d array
enum text {CHARACTER, EFFECT}

function textfx_parser(_text)
{
	//debug error codes
	if(!is_string(_text)) {show_debug_message("function text_parser() - argument is not a string."); return false;}
	
	//initializes parsed text array
	var _parsed_text = [];
	
	//loops through text and parses out the text effect code for each character
	var _txtfx = "";
	var _fxreader_active = NO;
	for(var i = 0; i <= string_length(_text); ++i;)
	{
		//stores the raw text string in the first index of the array
		if(i == 0) {array_push(_parsed_text,[_text,"RAW TEXT"]); continue;}
		
		//parser
		var _cur_char = string_char_at(_text,i);
		switch(_cur_char)
		{
			case("|"):
				if(_fxreader_active) {_fxreader_active = NO;}
				else {_fxreader_active = YES; _txtfx = "";}
			break;
			
			default:
				if(_fxreader_active) {_txtfx += string_upper(_cur_char);}
				else {array_push(_parsed_text,[_cur_char,_txtfx]);}
		}
	}
	
	//returns the full array holding each character with their respective text effect code
	return _parsed_text;
}