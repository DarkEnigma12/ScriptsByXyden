///@func	invert_color
///@param	color
///@return	inverted_color
function invert_color(_col)
{
	var _base	= 255;
	var _red	= color_get_red(_col);
	var _blue	= color_get_blue(_col);
	var _green	= color_get_green(_col);
	
	return make_color_rgb(_base-_red,_base-_green,_base-_blue);
}