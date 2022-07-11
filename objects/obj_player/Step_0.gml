/// @description Movement Code

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
		
		#region Collision Code
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
		#endregion
		
		#endregion

