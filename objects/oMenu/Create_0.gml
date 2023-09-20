/// @description Set Up

enum MainOptions
{
	ITEMS,
	MAP,
	PARTY,
	CLOSE,
	TOTAL
}

menu =
{
	viewing		: noone,
	
	#region CONTROLS
	controls	:
	{
		//pressed
		up_pressed		: function() {return keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"));},
		down_pressed	: function() {return keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"));},
		left_pressed	: function() {return keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A"));},
		right_pressed	: function() {return keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D"));},
		//held
		up		: function() {return keyboard_check(vk_up) or keyboard_check(ord("W"));},
		down	: function() {return keyboard_check(vk_down) or keyboard_check(ord("S"));},
		left	: function() {return keyboard_check(vk_left) or keyboard_check(ord("A"));},
		right	: function() {return keyboard_check(vk_right) or keyboard_check(ord("D"));},
		//released
		up_released		: function() {return keyboard_check_released(vk_up) or keyboard_check_released(ord("W"));},
		down_released	: function() {return keyboard_check_released(vk_down) or keyboard_check_released(ord("S"));},
		left_released	: function() {return keyboard_check_released(vk_left) or keyboard_check_released(ord("A"));},
		right_released	: function() {return keyboard_check_released(vk_right) or keyboard_check_released(ord("D"));},
	
		scroll	:
		{
			active	: NO,
			timer	: 0,
			delay	: 30,
			speed	: 15,
		},
	},
	#endregion	
	
	#region MENU TREE
	list			:
	{
		main		: 
		{
			options		: ["Items","Map","Party","Close"],
			font		: -1,
			selection	: 0,
		},
	},
	#endregion
	
	#region STATES
	main_menu		: function()
	{
		//scrolls through list
		list.main.selection = loop(list.main.selection,(controls.up()-controls.down())*(controls.scroll.timer == 0),MainOptions.TOTAL-1);
		
		//sets scroll
		if(controls.up() or controls.down()) and (controls.scroll.timer == 0)
		{
			if(controls.scroll.active) {controls.scroll.timer = controls.scroll.speed;}
			else {controls.scroll.timer = controls.scroll.delay; controls.scroll.active = YES;}
		}
		
		//resets timer if button is released
		if(controls.up_released() or controls.down_released()) {controls.scroll.timer = 0; controls.scroll.active = NO;}
		
		//counts down scroll timer
		controls.scroll.timer = max(--controls.scroll.timer,0);
	},
	#endregion
	
}menu.viewing = menu.main_menu;
