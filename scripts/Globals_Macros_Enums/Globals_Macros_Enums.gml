//Game Macros

//Meta Data Macros//
#macro GAMEVERSION			GM_version
#macro TITLE				game_display_name
#macro AUTHOR				"XydenKonos"
#macro CAPTIONS				["Made by Xyden"]
#macro GAME_RES_WIDTH		640
#macro GAME_RES_HEIGHT		480
#macro DEVELOPERBUILD		1 //to-do: set to false when releasing a build
#macro YES					true
#macro NO					false
#macro MinAlphaThresh		0.25
#macro RightDir				0
#macro LeftDir				180
#macro UpDir				90
#macro DownDir				270

//Music(Inlcuded Files)//
#macro MUSICPRIORITY		999
#macro MUSICDIRECTORY		"music/"

//Text Box Defaults
#macro TextBoxWidth			560
#macro TextBoxHeight		140
#macro TextBoxDefaultFont	-1
#macro GameDefaultFont		-1

//Constants//
//Object IDs
#macro PLAYER				obj_player
#macro WALL					obj_wall
#macro AlwaysActive			[PLAYER]

//Debug Grid Vars
#macro GRID_CELL_SIZE			32
//Menus Vars
#macro MenusOutlineWidth	5
#macro MenusBodyColor		c_black
#macro MenusOutlineColor	c_white
//Fade in/out Transition
#macro FadeIn				0
#macro FadeOut				1
#macro FadeColor			c_black
#macro FadeDecay			0.05


//Globals
///@description Sets all globals
gml_pragma("global","global_init()");

function global_init()
{
	//Sets windows caption
	var _caption_choices = CAPTIONS;
	var i = irandom_range(0,array_length(_caption_choices)-1);
	window_set_caption(_caption_choices[i]);
	
	//Debug var
	global.debug = false;
	
	//Camera vars
	global.fullscreen_button = vk_f4;
	global.master_camera = noone;
	global.master_view = 0;
	
	//game vars
	global.test = 1;
}
