/// @description Code

//sets mouse
window_set_cursor(cr_none);
x = mouse_x;
y = mouse_y;

/*
//blank bullet struct
bullet_test = {
	
	bullet_id		: noone,	//instance id
	bullet_spawn_xy : [-1,-1],	//where to spawn bullet
	start_dirc		: 0,		//initial directio
	bullet_spd		: 1,		//bullet speed
	acceleration	: 0,		//how fast a bullet accelerates
	bullet_curve	: 0,		//arc influence
	cross_pattern	: 1,		//number of bullets per step
	cross_angle		: 0,		//angle of shots
	mirror			: 0,		//mirror pattern boolean
	delay			: 1,		//interval between shots
	spin			: 1,		//pos: counter-clockwise, neg: clockwise, zero: no spin
	alarm			: 0			//used to count down to next bullet spawn
	
}
*/

//Set which bullets to test
bullet_structure[0] = {
	
	bullet_id		: par_bullet,
	bullet_spawn_xy : [-1,-1],
	start_dirc		: 0,
	bullet_spd		: 3,
	acceleration	: 0,
	bullet_curve	: 10,
	curve_growth	: 1,
	cross_pattern	: 4,
	cross_angle		: 360,
	mirror			: 1,
	delay			: 10,
	spin			: 2,
	alarm			: 0
	
}