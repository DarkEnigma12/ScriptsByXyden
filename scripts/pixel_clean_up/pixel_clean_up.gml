/// @function alpha_test_enable(test_enable, alpha_test_value)
/// @param test_enable
/// @param alpha_test_value
function alpha_test_enable(enable, test_value = 0.25) {

	//toggles the alpha test and sets the test value
	gpu_set_alphatestenable(bool(enable));
	gpu_set_alphatestref(clamp(test_value, 0, 255));


}
