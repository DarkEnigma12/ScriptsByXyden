//Uses the x y coordinate of an object in the room to place it in the coorresponding coordinates in the gui layer
function gui_placement_w(xx){
	var ww = (xx / room_width) * display_get_gui_width();
	return floor(ww);
}

function gui_placement_h(yy){
	var hh = (yy / room_height) * display_get_gui_height();
	return floor(hh);
}