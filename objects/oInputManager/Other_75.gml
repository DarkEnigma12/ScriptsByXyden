/// @description Handles game pad
show_debug_message("Event = " + async_load[? "event_type"]);        // Debug code so you can see which event has been
show_debug_message("Pad = " + string(async_load[? "pad_index"]));   // triggered and the pad associated with it.

switch(async_load[? "event_type"])				// Parse the async_load map to see which event has been triggered
{												
case ("gamepad discovered"):						// A game pad has been discovered
												
    var pad = async_load[? "pad_index"];		// Get the pad index value from the async_load map
    gamepad_set_axis_deadzone(pad, 0.3);		// Set the "deadzone" for the axis
    gamepad_set_button_threshold(pad, 0.1);		// Set the "threshold" for the triggers
	
	//loops through all instances of PLAYER and assigns the controller
	for (var i = 0; i < instance_number(PLAYER); i++;)
	{
		var insta = instance_find(PLAYER,i);
	    if(insta.inputs.game_pad == noone) {insta.inputs.game_pad = pad; break;}
	}
    
break;

case ("gamepad lost"):							// Gamepad has been removed or otherwise disabled
	
    with(PLAYER) {if !gamepad_is_connected(inputs.game_pad) {inputs.game_pad = noone;}}
	
break;
}
