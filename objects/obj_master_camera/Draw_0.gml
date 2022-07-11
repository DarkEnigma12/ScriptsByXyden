/// @description Draws a representation when debugging

if global.debug 
{
	//draws grid
	draw_grid(GRID_CELL_SIZE);
	
	//draws camera position
	draw_camera(c_ltgray);
	
	//draws view positions
	draw_view(global.master_view);
}
