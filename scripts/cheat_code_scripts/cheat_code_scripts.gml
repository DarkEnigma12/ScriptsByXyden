/// @description checks if an input of keys matches a cheat code
/// @function cheat_code_check()
/// @param keys	{array}
/*
NOTES
-Do not run more than one check at the same time
*/
function cheat_code_check(keys)
{
	//var to check the right index of the keys
	static index = 0;
	
	//checks if keys are in an array
	if(is_array(keys) and bool(array_length(keys)))
	{
		//checks for correct key inputs
		if(index < array_length(keys))
		{
			if keyboard_check_pressed(vk_anykey)
			{
				if keyboard_check_pressed(keys[index]) {index++;} else {index = 0;}
			}
		} 
		else
		{
			//runs if input matches keys
			index = 0;
			return true;
		}
	}
	
	//runs if check fails
	return false;
}