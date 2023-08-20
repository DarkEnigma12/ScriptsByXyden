///@func roundto_nearest(number, nearest integer,round method)
///@param {real} number
///@param {real} nearest_integer
///@param {string} rounding_method
enum rounding_method {ROUND_UP,ROUND,ROUND_DOWN}
function roundto_nearest(num,roundto,rnd=rounding_method.ROUND) 
{
	
	var result;
	
	switch(string_lower(rnd)) {
		
		case(rounding_method.ROUND_UP):		result = ceil(num / roundto) * roundto; break;
		case(rounding_method.ROUND_DOWN):	result = floor(num / roundto) * roundto; break;
		default:							result = round(num / roundto) * roundto;
		
	}

	return result;

}

///@description	Converts a boolean into a direction (either 1 or -1)
///@param {real} boolean
function bool_to_vector(_bool)
{
	return 2*bool(_bool)-1;
}

///@description	Calculates if check succeeds or fails based on chances
///@func chance_check(chance, out_of)
///@param {real} chance
///@param {real} [out_of]
function chance_check(chance,total=(chance<1) ? 1 : 100) 
{
	//returns guaranteed results
	if (chance <= 0) {success = false;}
	if (total  <= 0) {success = true;}
	
	//calculates success
	var check = random_range(total!=1,total);
	var success = (check <= chance);
	show_debug_message("function chance_check() - check is a " + ((success) ? "SUCCESS" : "FAILURE") + " - check("+string(check)+((success) ? " < " : " > ")+string(chance)+" out of "+string(total)+")");
	return success;
	
}

///@discritpion Calculates the chance of an id being chosen based on the id's weight
///@func	choose_id()
///@param	array[struct(id,weight)]
function choose_id(itm_pool) {
	
	//error catcher
	if(!is_array(itm_pool)) {show_debug_message("function choose_id() - argument is NOt an array."); return false;}
	
	//grabs item count
	var itm_pool_total = array_length(itm_pool);
	
	//calculates the total weight
	var weight_total = 0;
	for(var i = 0; i < itm_pool_total; i++;) {
		
		weight_total += itm_pool[i].weight;
		
	}
	
	//returns a randomly chosen id based off weight
	var chance = random(weight_total);
	var cursor = 0;
	var itm = noone;
	for(var i = 0; i < itm_pool_total; i++;) {
		
		itm = itm_pool[i].id;
		cursor += itm_pool[i].weight;
		if(chance <= cursor) {break;}
		
	}
	
	return itm;
	
}

/// @desc returns a value within two limits as if it looped around
/// @func loop
/// @param val
/// @param delta
/// @param upper_limit
/// @param lower_limit
function loop(_val,_delta,_upper,_lower=0)
{
	while(_delta != 0)
	{
		_val += sign(_delta);
		_delta -= sign(_delta);
		if(_val>_upper) {_val = _lower;}
		if(_val<_lower) {_val = _upper;}
	}
	return _val;
}

/// @desc loops value within upper and lower limit and returns result
/// @func clamp_within_loop
/// @param val
/// @param upper_limit
/// @param lower_limit
function clamp_within_loop(_val,_upper,_lower=0)
{
	return ((sign(_val)==-1) ? _upper+1 : _lower) + _val mod (_upper-_lower+1);
}

/// @func   gauss(m, sd)
/// @desc   Returns a pseudo-random number with an exact Gaussian distribution.
/// @param  {real}      m           mean value of the distribution
/// @param  {real}      sd          standard deviation of distribution
/// @param	{real}		max_units	clamps curve at set number of standard deviation units
/// @param	{real}		extr		forces function to return extreme values (-1:lowest possible, 1:highest possible, 0:ignore)
/// @return {real}      random number with Gaussian distribution
/// GMLscripts.com/license		base code altered by XydenKonos

function gauss(m, sd, max_units=3, extr=0)
{
    var x1, x2, w, limit = clamp(extr,-1,1);
	
    do 
	{
        x1 = random(2) - 1;
        x2 = random(2) - 1;
        w = (x1 * x1) + (x2 * x2);
    } until (0 < w && w < 1);

    w = sqrt(-2 * ln(w) / w);
    return m + ((limit==0) ? (sd * clamp(x1 * w, max_units*-1, max_units)) : (sd * max_units * limit));
}