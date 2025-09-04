/// @description Set Up
/*
//Color Macros Used
#macro C_ROYALBLUE			#4169E1
#macro C_ERROR_RED			#EE4B2B
#macro C_COOLYELLOW			#FFE338
*/
//origin of command window
//#macro CMD_X	10
//#macro CMD_Y	10

//state machine
debug_stm =
{
	#region VARS
	run 				: noone,
	cmd_string			: "",		//holds the command code to be parsed
	cmd_extra			: "",		//used to draw anything extra at the end of the command string
	parsed_command		: [],		//holds the parsed code, delimiter - "|"
	delimiter			: "|",		//char used to parse code
	code_exe			: NO,		//bool to flag successful code
	code_error			: NO,		//bool to flag a code as wrong
	info				: "",		//holds string of info to show
	idle_hold_state		: noone,	//holds which state is idling
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
			set_state((idle_hold_state == noone) ? command_prompt : idle_hold_state);
		}
	},
	//closes command
	close_command	: function()
	{
		if(keyboard_check_released(vk_f12)) {idle_hold_state = run; run = idle;}
	},
	reset_to_cmd	: function()
	{
		if(keyboard_check_pressed(vk_backspace) or keyboard_check_pressed(vk_enter))
		{
			clear_cmd();
			clear_parser();
			set_state(command_prompt);
		}
		
		close_command();			//press f12 to idle cmd instead
	},
	//clears parser
	clear_parser	: function()
	{
		info = "";
		parsed_command = [];
	},
	//sets the state
	set_state	: function(_st)
	{
		idle_hold_state = _st;
		run = _st;
	},
	//sets error
	set_error	: function(_err_mssg="ERROR")
	{
		set_cmd_str(_err_mssg); 
		code_error = YES; 
		clear_parser();
		set_state(command_prompt);
	},
	//sets successful code messgage
	set_exe_done: function(_st,_mssg="COMMAND COMPLETE")
	{
		set_cmd_str(_mssg); 
		code_exe = YES;
		clear_parser();
		set_state(_st);
	},
	//used to check if command has enough arguments
	argu_count_check	: function(_count)
	{
		return (array_length(parsed_command)>_count);
	},
	//sets cmd string to new string
	set_cmd_str	: function(_new_cmd_str,_xtra_str="")
	{
		cmd_string = _new_cmd_str;
		cmd_extra = _xtra_str;
	},
	//clears cmd string
	clear_cmd	: function()
	{
		keyboard_string = "";
		cmd_string = "";
		cmd_extra = "";
		code_exe = NO;
		code_error = NO;
	},
	#endregion
	
	#region TIMERS
	count1	: 0,
	timer1	: function(_dur,_reset=NO)
	{
		static timer = 0;	//duration of countdown
		static duration = _dur;
		
		//resets timer
		if(_reset) {timer = 0; return false;}
		
		
		//counts down timer
		if(timer <= 0) {timer = duration;}
		--timer;
	
		return (timer == 0);
	},
	//processes using timer1
	ellipsis_count	: function()
	{
		//draws dots at the end of cmd_string as feedback that state is running
		if(timer1()) 
		{
			count1 = loop(count1,1,3);
			var _dots = "";
			repeat(count1) {_dots += ".";}
			cmd_extra = _dots;
		}
	},
	count2	: 0,
	timer2	: function(_dur,_reset=NO)
	{
	
		static timer = 0;
		static duration = _dur;
	
		if(_reset) {timer = 0; count2 = 0; return false;}
	
		if(timer <= 0) {timer = duration;}
		--timer;
	
		return (timer == 0);
	},
	count3	: 0,
	timer3	: function(_dur,_reset=NO)
	{
	
		static timer = 0;
		static duration = _dur;
	
		if(_reset) {timer = 0; count3 = 0; return false;}
	
		if(timer <= 0) {timer = duration;}
		--timer;
	
		return (timer == 0);
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
			if(code_exe) {code_exe = NO; cmd_string = "";}		//clears code exe
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
			if(code_exe) {code_exe = NO; cmd_string = "";}		//clears code exe
			
			if(bksp_held == NO) {bksp_timer = _bk_delay; bksp_held = YES;}
			else {bksp_timer = _bk_spd;}
			
			cmd_string = string_delete(cmd_string,string_length(cmd_string),1);
		}
		//clears command
		if(keyboard_check_released(vk_delete)) {clear_cmd();}
		
		//enters command to parse
		if(keyboard_check_pressed(vk_enter) and (string_length(cmd_string)>0))
		{
			//error catcher
			if(code_error or code_exe) {clear_cmd();}
			else
			{
				//parses string
				//first index is the code, all else are arguments
				//removes spaces
				parsed_command = string_split(string_replace_all(cmd_string," ",""),delimiter);
			
				//changes state
				set_state(command_execute);
			}
		}
		
		//closes command prompt
		close_command();
	},
	//parses command string
	command_execute	: function()
	{
		switch(parsed_command[0])
		{
			//enters debug mode
			case("DEBUG"): 
				global.debug = !global.debug;
				set_exe_done(command_prompt,string("DEGUG MODE {0}", global.debug ? "ON" : "OFF"));
			break;
			
			//exits game
			case("ESCAPE"):
			case("EXIT"):
			case("CLOSE"):
				if(os_type == os_windows) or (os_type == os_macosx) or (os_type == os_linux) {set_exe_done(exit_game,"BYE");}
				else {set_error(string("WRONG OS TYPE, {0} FAILED.",parsed_command[0]));}
			break;
			
			//code error
			default: set_error();
		}
	},
	exit_game	: function() {game_end();},
	#endregion
} debug_stm.run = debug_stm.idle; //sets initial state

#region METHODS
insertion_point_blink = function()
{
	var _blink_speed = 30;
	static blink_toggle = 0;
	static blink_timer = 0;
	
	--blink_timer;
	if(blink_timer <= 0) {blink_toggle = !blink_toggle; blink_timer = _blink_speed;}
	
	return blink_toggle;
	
}

#endregion