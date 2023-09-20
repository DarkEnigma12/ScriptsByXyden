///@desc toggle a between true and false at set steps
///@func	blink(blink_speed)
///@return	bool
function blink(_togspd)
{
	static blink_toggle = 0;
	static blink_timer = 0;
	
	if(blink_timer <= 0) {blink_toggle = !blink_toggle; blink_timer = _togspd;}
	--blink_timer;
	
	return blink_toggle;
}