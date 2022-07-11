/// @description returns the index of the music assigned to the room
/// @function music_return_ambience()
function music_return_ambience(){
	
	var muse;
	
	switch(room) {
		
		case(rm_debug):
			muse = MUSICWATERQUIET;
		break;
		
		default: muse = noone;
		
	}
	
	return muse;

}

/// @description returns the battle music of the opponent
/// @function music_return_battlemusic(opponent id)
function music_return_battlemusic(oppo_id) {
	
	var muse;
	
	switch(oppo_id) {
		
		//for three or hard mode opponents
		case(-1): 
			muse = MUSICBATTLEHARD;
		break;
		
		default: muse = MUSICBATTLE;
		
	}
	
	return muse;
	
}

/// @description sets the fade in of a sound
/// @function music_fade()
/// @param music_id
/// @param fade_direction [bool] in or out
/// @param fade_duration
function music_fade(mus_id,fade_dir,fade_dur) {
	
	var fade_dur_milli = fade_dur * 1000; //converted to milliseconds for audio_sound_gain function
	
	if(fade_dir) {
		
		//fade out
		audio_sound_gain(mus_id, 1, 0);
		audio_sound_gain(mus_id, 0, fade_dur_milli);
	
	} else {
		
		//fade in
		audio_sound_gain(mus_id, 0, 0);
		audio_sound_gain(mus_id, 1, fade_dur_milli);
		
	}
	
}