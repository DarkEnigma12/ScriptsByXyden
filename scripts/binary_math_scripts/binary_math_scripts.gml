/// @description counts how many bits in a number are set
/// @function binary_count_set_bits()
/// @param integer
function binary_count_set_bits(n)
{
	if(!is_real(n))
	{
		show_debug_message("function binary_count_set_bits() - argument is not a real number.");
		return false;
	}
	
	n = floor(abs(n));
	var _count = 0;
	while(n>0)
	{
		_count += n & 1;
		n = n>>1;
	}
	
	return _count;
}