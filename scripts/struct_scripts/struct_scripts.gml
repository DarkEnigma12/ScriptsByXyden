/// @description copies over a struct into a new struct
/// @function struct_copy(struct_ref)
/// @param struct_ref the reference to the struct to be copied
function struct_copy(ref){

	if (is_struct(ref)) {
		
		 //shows struct to be copied in debug output window
		show_debug_message("function struct_copy() - original struct:"); show_debug_message(ref);
		
        var base = instanceof(ref);
		var ref_new;
        
        switch (base) {
            case("struct"):
            case("weakref"):
                ref_new = {};
            break;
                
            default:
                var constr = method(undefined, asset_get_index(base));
                ref_new = new constr();
        }
        
        var names = variable_struct_get_names(ref);
        var length = variable_struct_names_count(ref);
        
        for (var i = 0; i < length; i++) {
            var name = names[i];
            
            variable_struct_set(ref_new, name, variable_struct_get(ref, name));
        }
        
		//shows new struct in debug output window
		show_debug_message("function struct_copy() - new struct:"); show_debug_message(ref_new);
        return ref_new;
		
    } else {
		
		show_debug_message("function struct_copy() - argument is NOt a struct. It canNOt be copied.")
		var empty_struct = {};
		return empty_struct;
		
	}

}