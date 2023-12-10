/// @description 


#region DRAWS DEBUG INFO
if(debug_stm.run == debug_stm.idle) {exit;}

//prev draw vars
var _prev_col = draw_get_color();
var _prev_font = draw_get_font();

draw_set_font(-1);

//draws command window
var _xx = CMD_X;
var _yy = CMD_Y;
var _win_space = 10;
var _min_win_w = 300;
var _min_str_len = 30;
var _win_w = max(_min_win_w,_min_win_w+string_width(string_delete(debug_stm.cmd_string,1,_min_str_len)));
var _win_h = 40;
var _win_outline = 5;
var _win_out_col = c_white;
var _win_col = invert_color(_win_out_col);
draw_rectangle_color(_xx,_yy,_xx+_win_w+_win_outline,_yy+_win_h+_win_outline,_win_out_col,_win_out_col,_win_out_col,_win_out_col,false);
draw_rectangle_color(_xx+_win_outline,_yy+_win_outline,_xx+_win_w,_yy+_win_h,_win_col,_win_col,_win_col,_win_col,false);

//draws word prompt
var _str = debug_stm.cmd_string+debug_stm.cmd_extra;
var _str_x = _xx + 10;
var _str_y = _yy + 10;
var _ins_pt_len = string_height(ALPHA_UPPER);
draw_set_color(invert_color(_win_col));
if(insertion_point_blink() and (debug_stm.run == debug_stm.command_prompt)) {draw_line(_str_x+string_width(_str),_str_y,_str_x+string_width(_str),_str_y+_ins_pt_len);}
var _err_col = C_ERROR_RED;
var _exe_col = C_COOLYELLOW;
var _resp_col = debug_stm.code_exe ? _exe_col : (debug_stm.code_error ? _err_col : invert_color(_win_col));
draw_set_color(_resp_col);
draw_text(_str_x,_str_y,_str);

//draws various things based on state
//switch(debug_stm.run)

//draws game version number
var _ver_str = string("{0}   Build v {1}   runtime {2}",TITLE,GAMEVERSION,GM_runtime_version);
draw_set_color(C_ROYALBLUE);
draw_text(display_get_gui_width()-string_width(_ver_str),display_get_gui_height()-string_height(_ver_str),_ver_str);

//resets draw vars
draw_set_color(_prev_col);
draw_set_font(_prev_font);

#endregion