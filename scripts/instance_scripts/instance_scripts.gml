///@func instance_scale(scale)
///@description Scales instance by an integer
///@param scale
function instance_scale(scale) {

	var insta_scale = floor(scale);

	image_xscale = insta_scale;
	image_yscale = image_xscale;


}

///@description grabs all statics from an instance method and puts them in a struct
///@function instance_method_get_static(method,arguments)
function instance_method_get_static(_method,_arg=[])
{
	//excutes method once to set statics
	method_call(_method,_arg);
	
	return static_get(method_get_index(_method));
}