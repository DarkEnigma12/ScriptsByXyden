#region Game Macros

//Meta Data Macros//
#macro GAMEVERSION			GM_version
#macro TITLE				game_display_name
#macro AUTHOR				"XydenKonos"
#macro CAPTIONS				["Made by Xyden"]
#macro DEVELOPERBUILD		1				//set to false when releasing a build
#macro DEBUGKEY				"xydenkonos"	//password to activate debug mode
#macro SAVEFILENAME			"game_file.sav"
#macro ERROR_LOG			"error_log.txt"
#macro LOG_TIME				date_datetime_string(date_current_datetime())
#macro HASH_KEYWORD			"xyks_hsh#"
#macro ALPHA_UPPER			"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#macro ALPHA_LOWER			"abcdefghijklmnopqrstuvwxyz"
#macro YES					true
#macro NO					false
#macro ALPHA_THRESHOLD		0.25
#macro RIGHT				0
#macro LEFT					180
#macro UP					90
#macro DOWN					270

//Camera//
#macro NO_CAMERA_ASSIGNED	-1
#macro GAME_RES_WIDTH		640
#macro GAME_RES_HEIGHT		480

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
#macro WALL					oWall
#macro AlwaysActive			[PLAYER]

//Debug Grid Vars
#macro GRID_CELL_SIZE		32
//Menus Vars
#macro MenusOutlineWidth	5
#macro MenusBodyColor		c_black
#macro MenusOutlineColor	c_white
//Fade in/out Transition
#macro FadeIn				0
#macro FadeOut				1
#macro FadeColor			c_black
#macro FadeDecay			0.05

#endregion
