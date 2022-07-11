/// @description Draws a grid to any size
/// @function draw_grid()
/// @param cell_size
/// @param grid_color
/// @param alpha

function draw_grid(gridcell_size,c_grid=c_white,grid_alpha=0.25)
{
	//sets alpha
	var alpha = draw_get_alpha()
	draw_set_alpha(grid_alpha);
	
	//draws vertical line
	for(var i = 1; i < room_width/gridcell_size; i++)
	{

		//draws lines
		var x_offset = i * gridcell_size;
		draw_line_color(x_offset,0,x_offset,room_height,c_grid,c_grid);
		
	}
	
	//draws horizontal line
	for(var i = 1; i < room_height/gridcell_size; i++)
	{
		
		//draws lines
		var y_offset = i * gridcell_size;
		draw_line_color(0,y_offset,room_width,y_offset,c_grid,c_grid);
		
	}
	
	//resets alpha
	draw_set_alpha(alpha);

}

/// @description Draws camera representation
/// @function draw_camera()
/// @param camera_color
function draw_camera(c_cam=c_white)
{
	draw_circle_color(x,y,7,c_cam,c_cam,false);
}

/// @description Draws view representation
/// @function draw_view()
/// @param view_index
function draw_view(view_index)
{
	var view_xx = camera_get_view_x(view_camera[view_index]);
	var view_yy = camera_get_view_y(view_camera[view_index]);
	var view_ww = camera_get_view_width(view_camera[view_index]);
	var view_hh = camera_get_view_height(view_camera[view_index]);
	var view_center_x = view_xx + view_ww/2;
	var view_center_y = view_yy + view_hh/2;
	var dot_r = 2;
	var line_len = 30;
	var line_w = 2;
	var view_color = c_red;
		//center
	draw_circle_color(view_center_x,view_center_y,dot_r,view_color,view_color,false);
		//up
	draw_line_width_color(view_center_x-line_len,view_yy,view_center_x+line_len,view_yy,line_w,view_color,view_color);
		//down
	draw_line_width_color(view_center_x-line_len,view_yy+view_hh-line_w,view_center_x+line_len,view_yy+view_hh-line_w,line_w,view_color,view_color);
		//left
	draw_line_width_color(view_xx,view_center_y+line_len,view_xx,view_center_y-line_len,line_w,view_color,view_color);
		//right
	draw_line_width_color(view_xx+view_ww-line_w,view_center_y+line_len,view_xx+view_ww-line_w,view_center_y-line_len,line_w,view_color,view_color);
}
