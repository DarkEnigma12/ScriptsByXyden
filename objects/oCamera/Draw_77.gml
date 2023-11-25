/// @description Draws application surface

gpu_set_blendenable(false);

draw_surface_ext(
application_surface, 
(window_get_fullscreen() ? floor((display_get_width()-surface_get_width(application_surface))/2) : 0), 
(window_get_fullscreen() ? floor((display_get_height()-surface_get_height(application_surface))/2) : 0), 
1, 1, 0, c_white, 1);

gpu_set_blendenable(true);
