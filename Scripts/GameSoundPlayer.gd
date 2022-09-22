extends Node

var sound_click_player
var sound_click_ia
var sound_click_error
var sound_game_ends
var sound_game_ends_lose

func _ready():
	sound_click_player = get_node("SoundPlayerSelect")
	sound_click_ia = get_node("SoundIASelect")
	sound_click_error = get_node("SoundError")
	sound_game_ends = get_node("SoundGameEnds")
	sound_game_ends_lose = get_node("SoundGameEndsLose")

func play_sound_click_player():
	sound_click_player.play()
	pass
func play_sound_click_ia():
	sound_click_ia.play()
	pass
func play_sound_click_error():
	sound_click_error.play()
	pass
func play_sound_game_ends():
	sound_game_ends.play()
	pass
func play_sound_game_ends_lose():
	sound_game_ends_lose.play()
	pass
