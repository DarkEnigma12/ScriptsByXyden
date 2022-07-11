/// @description Debug info

//Exits if build is not a developer build
if(!DEVELOPERBUILD) {exit;}

//Draws various debug info if global.debug macro is set to true
//debug string
var text_string = "Press [CTRL+ENTER] for Debug info";

//alters debug string
if global.debug {
	
	//Draws game meta data and debug info
	text_string =	"FPS  " + string(fps) + "\n" +
					"Instances Active  " + string(instance_count) + "\n" +
					"Camera Coordinates  " + string(x) + " , " + string(y) + "\n" +
					"Screen Scaling  x" + string_format(window_get_fullscreen() ? view_full_scale : view_scale,2,2) + "\n" +
					"View Dimensions  " + string(window_get_fullscreen() ? view_full_w : view_w) + " x " + string(window_get_fullscreen() ? view_full_h : view_h) + "\n" +
					TITLE + " v " + GAMEVERSION + " by " + AUTHOR
					;
	
}

//debug draw vars
var debug_font = -1;
var debug_text_padding = 10;
var debug_font_scaling = 1;
var debug_x = debug_text_padding;
var debug_y = display_get_gui_height() - (string_get_pix_h(text_string,debug_font)*debug_font_scaling) - debug_text_padding;

//draws debug text
draw_text_outlined_ext(debug_x,debug_y,-1,-1,c_black,c_white,debug_font_scaling,debug_font_scaling,1,text_string,debug_font,fa_left,fa_top);
