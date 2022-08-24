/// @func   hex_string_to_dec
/// @desc   Returns an integer converted from an hexadecimal string.
/// @param  {string}    hex_string
/// @return {real}      positive integer
//My version
function hex_string_to_dec(_hex_str)
{
	var _hex_ref = "123456789ABCDEF";
	var _result = 0, _hex_chr, _chr_pos, _hex_conv = 1;
	for (var i = 6; i > 0; --i) 
	{
		_hex_chr = string_char_at(_hex_str,i);
		_chr_pos = string_pos(_hex_chr,_hex_ref);
	    _result += _chr_pos * _hex_conv;
		_hex_conv = _hex_conv<<4;
	}
	return _result;
}

/// @func   hex_to_dec(hex)
/// @desc   Returns an integer converted from an hexadecimal string.
/// @param  {string}    hex_string
/// @return {real}      positive integer
///
/// GMLscripts.com/license

function hex_to_dec(hex) 
{
    var dec = 0;
    var hex_ref = "123456789ABCDEF";
    var len = string_length(hex);
    for (var pos = 1; pos <= len; ++pos) {dec = dec << 4 | (string_pos(string_char_at(hex, pos), hex_ref));}

    return dec;
}