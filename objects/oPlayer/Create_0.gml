/// @description Code

//Player stats
stats = 
{
	hp	: 100,
	atk : 1,
	def : 1,
	spd : 4
}

#region Player inputs

inputs =
{
	//controller slot index
	game_pad : noone,
	//player key bindings
	keybindings : 	{
						right	: ord("D"),
						left	: ord("A"),
						up		: ord("W"),
						down	: ord("S"),
						//shoot	: vk_space,
					},
	
	//actions
	right	:	function(_pad=game_pad,_keys=keybindings)
				{
					return 
						gamepad_button_check(_pad,gp_padr)||
						gamepad_axis_value(_pad,gp_axislh)>0||
						keyboard_check(_keys.right);
				},
	left	:	function(_pad=game_pad,_keys=keybindings)
				{
					return 
						gamepad_button_check(_pad,gp_padl)||
						gamepad_axis_value(_pad,gp_axislh)<0||
						keyboard_check(_keys.left);
				},
	up		:	function(_pad=game_pad,_keys=keybindings)
				{
					return 
						gamepad_button_check(_pad,gp_padu)||
						gamepad_axis_value(_pad,gp_axislv)<0||
						keyboard_check(_keys.up);
				},
	down	:	function(_pad=game_pad,_keys=keybindings)
				{
					return 
						gamepad_button_check(_pad,gp_padd)||
						gamepad_axis_value(_pad,gp_axislv)>0||
						keyboard_check(_keys.down);
				}
		
}

#endregion

#region STATE MACHINE
state =
{
	#region IMPORTANT VARIABLES
	///Place all variable references here
	///Use the keyword 'other' to reference variables outside of struct state machine
	run		: noone,
	inputs	: other.inputs,
	stats	: other.stats,
	#endregion
	
	#region BOOLS
	ishurt : NO,		//used to determine if damage is lethal; usually damage will only take player to one shield point, when hurt, damage ignores that restriction
	#endregion
	
	#region TIMERS
	generic_timer	: function(_dur="")
	{
		static timer = 0;	//duration of countdown
		
		if(is_real(_dur)) {timer = _dur;}
		else if(timer > 0) {--timer;}
	
		return (timer == 0);
	},
	#endregion
	
	#region METHODS
	state_goto : function(_st) {run = _st;},
	#endregion
	
	//states
	moving_control : function()
	{
		#region Movement Code
		//controls
		var move_up		= inputs.up();
		var move_down	= inputs.down();
		var move_right	= inputs.right();
		var move_left	= inputs.left();
		
		var h_input = move_right - move_left;
		var v_input = move_down - move_up;
		
		//calculates movement
		var _dir = point_direction(0,0,h_input,v_input);
		var hspd = h_input!=0 ? lengthdir_x(stats.spd,_dir) : 0;
		var vspd = v_input!=0 ? lengthdir_y(stats.spd,_dir) : 0;
		
		//animates sprite
		
		
		#region Collision Code
		with(other)
		{
			//horizontal collision
			if place_meeting(x+hspd,y,WALL)
			{
				while(!place_meeting(x+sign(hspd),y,WALL)) {x+=sign(hspd);}
				hspd = 0;
			}
			x+=hspd;
			//vertical collision
			if place_meeting(x,y+vspd,WALL)
			{
				while(!place_meeting(x,y+sign(vspd),WALL)) {y+=sign(vspd);}
				vspd = 0;
			}
			y+=vspd;
		}
		#endregion
		
		#endregion
	},
	destroyed : function()
	{
		
	},
} state.run = state.moving_control; //sets initial state
#endregion


