/// @description Draws timer

//calculates and draws time
clock_frame += clock_running;
		
if(clock_frame >= clock_frames_per_second)		{clock_second++; clock_frame = 0;}
if(clock_second >= clock_seconds_per_minute)	{clock_minute++; clock_second = 0;}
if(clock_minute >= clock_minutes_per_hour)		{clock_hour++; clock_minute = 0;}
if(clock_hour >= clock_hours_per_day)			{clock_day++; clock_hour = 0;}
		
var spacer = ":";
var hour12_bool = (clock_hour>12);
var midnite_bool = (clock_hour == 0);
var str =			"DAY " + string(clock_day) + " " + 
					string_replace_all(string_format((mode==numMode.CLOCK_12H) ? clock_hour-(hour12_bool*12)+(midnite_bool*12) : clock_hour,2,0)," ","0") + spacer +
					string_replace_all(string_format(clock_minute,2,0)," ","0") + spacer +
					string_replace_all(string_format(clock_second,2,0)," ","0") + " " +
					((mode==numMode.CLOCK_12H) ? (clock_hour<12 ? "AM" : "PM") : "")
					;
							
draw_text_outlined_ext(x,y,-1,-1,c_white,c_black,1,1,1,string(str),font,fa_center,fa_middle);