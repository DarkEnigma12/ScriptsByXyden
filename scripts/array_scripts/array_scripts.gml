/// @description returns a sorted array
/// @function array_sort_ext(array,sorting type)

function array_sort_ext(arr,sort="ABC") {

	if (!is_array(arr)) {show_debug_message("function array_sort_ext() - argument is not an array."); return arr;}

	sort = string_upper(sort);
	var arr_len = array_length(arr);
	var temp_array = [];
	var i = 0;
	
	repeat(arr_len) {
		
		var arr_value = arr[i];
		
		//switch holding all sorting techniques
		switch(sort) {
			
			//returns an empty array the same size as provided array
			//array will be filled with an empty string if the first index is a string
			//otherwise it will be filled with zeros
			case("CLEAR"):
			
				if (is_string(arr[0])) {array_push(temp_array,"");} else {array_push(temp_array,0);}
			
			break;
			
			//copies array
			case("COPY"):
			
				array_push(temp_array,arr_value);
			
			break;
			
			//pushes all empty strings or zeros to the end
			case("EMPTYLAST"):
			
				if (is_string(arr_value)) {
					
					if (string_length(arr_value)>0) {array_push(temp_array,arr_value);}
				
				} else if (is_real(arr_value)) {
					
					if (arr_value>0) {array_push(temp_array,arr_value);}
				
				}
			
			break;
			
			//shuffles array
			case("SHUFFLE"):
			
				var arr_index = (i==0) ? 0 : irandom(i);
				array_insert(temp_array,arr_index,arr_value);
			
			break;
			
			default: return arr;
			
		}
		
		//increments i
		i++;
		
	}
	
	//if temp array isn't the same size, it is resized and filled with local var
	var fill_array_w = "";
	if (array_length(temp_array)<array_length(arr)) {repeat(array_length(arr)-array_length(temp_array)) {array_push(temp_array,fill_array_w);}}
	
	//returns sorted array
	return temp_array;

}

/// @description returns if a value exists in provided array
/// @function array_find_value(array,value_to_find)

function array_find_value(arr,val) {
	
	var check = false;
	var arr_len = array_length(arr);
	for(var i = 0; i < arr_len; i++;) {
		
		if (is_string(val)) || (is_real(val)) {
			
			if (string(arr[i]) == string(val)) {check = true; break;}
			
		}
		
	}
	
	return check;
	
}

///@description returns a copy of a 1-d array
///@function array_create_copy()
///@param array
function array_create_copy(arr)
{
	if(!is_array(arr)) {show_debug_message(string("function array_create_copy() - argument is not an array")); return false;}
	
	var _arr_copy = [];
	array_copy(_arr_copy,0,arr,0,array_length(arr));
	return _arr_copy;
}