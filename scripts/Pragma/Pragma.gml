#region Globals
///@description Sets all globals
gml_pragma("global","global_init()");

function global_init()
{
	//Sets windows caption
	var _caption_choices = CAPTIONS;
	var i = irandom_range(0,array_length(_caption_choices)-1);
	window_set_caption(_caption_choices[i]);
	
	//Debug var
	global.debug = false; //use DEBUGKEY to toggle var
	
}
#endregion