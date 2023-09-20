/// @description Set Up

//state machine
debug_stm =
{
	#region VARS
	running				: noone,
	cmd_string			: "",		//holds the command code to be parsed
	parsed_command		: [],		//holds the parsed code, delimiter - "|"
	delimiter			: "|",		//char used to parse code
	code_error			: NO,		//bool to flag a code as wrong
	#endregion
	
	#region STATE METHODS
	//opens command
	open_command	: function()
	{
		if(DEVELOPERBUILD and keyboard_check_released(vk_f12)) 
		{
			//clears keyboard string
			keyboard_string = "";
			
			//changes states
			running = command_prompt;
		}
	},
	//closes command
	close_command	: function()
	{
		if(keyboard_check_released(vk_f12)) {running = idle;}
	},
	//clears parser
	clear_parser	: function()
	{
		parsed_command = [];
		running = command_prompt;
	},
	#endregion
	
	#region STATES
	//idle
	idle	: function() 
	{
		//opens command prompt
		open_command();
	},
	//command window
	command_prompt	: function()
	{	
		//types to command string
		if(string_length(keyboard_string)>0)
		{
			if(code_error) {code_error = NO; cmd_string = "";}	//clears code error
			var _cmmd_str_len = 64;
			if(string_length(cmd_string)<_cmmd_str_len) {cmd_string += keyboard_string;}
			keyboard_string = "";
		}
		
		//formats string
		//forces uppercase
		cmd_string = string_upper(cmd_string);
		
		//backspace
			//timer
			var _bk_spd = 3;
			var _bk_delay = 30;
			static bksp_timer = 0;
			static bksp_held = NO;
			bksp_timer = max(--bksp_timer,0);
			if(keyboard_check_released(vk_backspace)) {bksp_timer = 0; bksp_held = NO;}
		if(keyboard_check(vk_backspace) and (bksp_timer == 0))
		{
			if(code_error) {code_error = NO; cmd_string = "";}	//clears code error
			
			if(bksp_held == NO) {bksp_timer = _bk_delay; bksp_held = YES;}
			else {bksp_timer = _bk_spd;}
			
			cmd_string = string_delete(cmd_string,string_length(cmd_string),1);
		}
		//clears command
		if(keyboard_check_released(vk_delete)) {cmd_string = ""; keyboard_string = ""; code_error = NO;}
		
		//enters command to parse
		if(keyboard_check_pressed(vk_enter) and (string_length(cmd_string)>0))
		{
			//parses string
			//first index is the code, all else are arguments
			//removes spaces
			parsed_command = string_split(string_replace_all(cmd_string," ",""),delimiter);
			
			//changes state
			running = command_execute;
		}
		
		//closes command prompt
		close_command();
	},
	//parses command string
	command_execute	: function()
	{
		switch(parsed_command[0])
		{
			case("ESCAPE"):
			case("EXIT"):
			case("CLOSE"):
				if(os_type == os_windows) or (os_type == os_macosx) or (os_type == os_linux) {game_end();}
				else 
				{
					cmd_string = string("WRONG OS TYPE, {0} FAILED.",parsed_command[0]);
					code_error = YES;
					clear_parser();
				}
			break;
			
			//code error
			default: 
				cmd_string = "ERROR"; 
				code_error = YES; 
				clear_parser();
		}
		
		//closes command prompt
		close_command();
	},
	
	
	#endregion
} debug_stm.running = debug_stm.idle; //sets initial state

#region METHODS
toggle_debug = function()
{
	if(debug_stm.running == debug_stm.idle) {global.debug = false;}
	else {global.debug = true;}
}

insertion_point_blink = function()
{
	var _blink_speed = 30;
	static blink_toggle = 0;
	static blink_timer = 0;
	
	if(blink_timer <= 0) {blink_toggle = !blink_toggle; blink_timer = _blink_speed;}
	--blink_timer;
	
	return blink_toggle;
	
}
#endregion