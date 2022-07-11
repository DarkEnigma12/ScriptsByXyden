/// @description Set Up

//Mode
enum numMode {CLOCK_12H,CLOCK_24H}
mode = numMode.CLOCK_12H;

//Clock Vars
clock_frame		= 0;
clock_second	= 0;
clock_minute	= 0;
clock_hour		= 0;
clock_day		= 0;
clock_running	= true;

//Time Conversions
clock_frames_per_second		= 1;
clock_seconds_per_minute	= 60;
clock_minutes_per_hour		= 60;
clock_hours_per_day			= 24;

//Image Vars
font = -1;
