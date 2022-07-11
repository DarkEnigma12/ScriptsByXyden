///@func roundto_nearest_x(number, nearest integer,round method)
///@param {real} number
///@param {real} nearest_integer
///@param {string} rounding_method
enum rounding_method {ROUND_UP,ROUND,ROUND_DOWN}
function roundto_nearest_x(num,roundto,rnd=rounding_method.ROUND) 
{
	
	var result;
	
	switch(string_lower(rnd)) {
		
		case(rounding_method.ROUND_UP):		result = ceil(num / roundto) * roundto; break;
		case(rounding_method.ROUND_DOWN):	result = floor(num / roundto) * roundto; break;
		default:							result = round(num / roundto) * roundto;
		
	}

	return result;

}

///@description	Converts a bollean into a direction (either 1 or -1)
///@param {real} boolean
function bool_to_vector(_bool)
{
	return 2*bool(_bool)-1;
}

///@description	Calculates if check succeeds or fails based on chances
///@func chance_check(chance, out_of)
///@param {real} chance
///@param {real} [out_of]
function chance_check(chance,total=(chance<1) ? 1 : 100) {
	
	//var to hold success
	var success;
	
	//returns guaranteed results
	if (chance <= 0) {success = false;}
	if (total  <= 0) {success = true;}
	
	//calculates success
	var check = random_range(total!=1,total);
	if (check <= chance) {success = true;}
	else success = false;
	
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
	
	//retruns a randomly chosen id based off weight
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