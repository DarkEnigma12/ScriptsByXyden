/// @description Code

//Player stats
stats = 
{
	hp	: 100,
	atk : 1,
	def : 1,
	spd : 4
}
enum playerStates
{
	
	IDLE,
	MOVING,
	DYING
	
}
player_state = playerStates.IDLE;
player_sprites = []; //follows states

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
						shoot	: vk_space
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
