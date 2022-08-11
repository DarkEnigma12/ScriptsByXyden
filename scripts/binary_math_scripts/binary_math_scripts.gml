/// @func   count_set_bits()
///
/// @desc   Returns a count of how many bits in a number are set.
///
/// @param  {real}      integer		real, nondecimal, positive number
///
/// @return {real}      Total count of bits set
function count_set_bits(n)
{
	n = floor(abs(n));
	var _count = 0;
	while(n>0)
	{
		_count += n & 1;
		n = n>>1;
	}
	
	return _count;
}