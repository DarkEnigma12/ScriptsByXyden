/// @description Spawns Instance


var _array =
[
    "apple",
    "banana",
    "coconut",
    "dragonfruit"
]

var _test="apple"

var _arr_func = function(_val,_index,_tst=_test)
{
	var _t = _tst;
    return _val == _tst;
}

var _contains_apple = array_any(_array, _arr_func);

show_debug_message(_contains_apple); // prints 1 (true)