extends Node2D

var board_manager
var main_menu
var sub_menu
var sound_menu_hover
var sound_menu_click
var sound_menu_music
var sound_game_music

func _ready():
	board_manager = get_node("BoardManager")
	main_menu = get_node("MainMenu")
	sub_menu = get_node("SubMenu")
	sound_menu_hover = get_node('MainMenuSoundPlayer/SoundMenuHover')
	sound_menu_click = get_node('MainMenuSoundPlayer/SoundMenuClick')
	sound_menu_music = get_node('MainMenuSoundPlayer/SoundMenuMusic')
	sound_game_music = get_node('MainMenuSoundPlayer/SoundGameMusic')
	
	sound_menu_music.play()

#Sound Control
func playMenuHoverSound():
	sound_menu_hover.play()
	
func playMenuClickSound():
	sound_menu_click.play()
	
func playMenuSong():
	sound_game_music.stop()
	yield(get_tree().create_timer(0.3), "timeout")	
	sound_menu_music.play()
func playGameSong():
	sound_menu_music.stop()
	yield(get_tree().create_timer(0.3), "timeout")	
	sound_game_music.play()
#Events
func _on_QuitButton_pressed():
	playMenuClickSound()
	yield(get_tree().create_timer(0.4), "timeout")
	get_tree().quit()

func _on_MultiplayerButton_pressed():
	main_menu.visible = false
	board_manager.visible = true
	board_manager.start_game("multi")
	playMenuClickSound()
	playGameSong()

func _on_SinglePlayerButton_pressed():
	main_menu.visible = false
	sub_menu.visible = true
	playMenuClickSound()

func _on_EasyButton_pressed():
	sub_menu.visible = false
	board_manager.visible = true
	board_manager.start_game("easy")
	playMenuClickSound()
	playGameSong()

func _on_MediumButton_pressed():
	sub_menu.visible = false
	board_manager.visible = true
	board_manager.start_game("medium")
	playMenuClickSound()
	playGameSong()

func _on_HardButton_pressed():
	sub_menu.visible = false
	board_manager.visible = true
	board_manager.start_game("hard")
	playMenuClickSound()
	playGameSong()

func _on_MainMenuButton_pressed():
	main_menu.visible = true
	board_manager.visible = false
	playMenuClickSound()
	playMenuSong()	

func _on_SinglePlayerButton_mouse_entered():
	playMenuHoverSound()

func _on_MultiplayerButton_mouse_entered():
	playMenuHoverSound()

func _on_QuitButton_mouse_entered():
	playMenuHoverSound()

func _on_LabelDIfficulty_mouse_entered():
	playMenuHoverSound()

func _on_LabelEmpty_mouse_entered():
	playMenuHoverSound()

func _on_EasyButton_mouse_entered():
	playMenuHoverSound()

func _on_MediumButton_mouse_entered():
	playMenuHoverSound()

func _on_HardButton_mouse_entered():
	playMenuHoverSound()

func _on_RestartGameButton_mouse_entered():
	playMenuHoverSound()

func _on_MainMenuButton_mouse_entered():
	playMenuHoverSound()


func _on_RestartGameButton_pressed():
	playMenuClickSound()


func _on_BoardManager_game_ended():
	sound_game_music.stop()


func _on_BoardManager_game_started():
	sound_game_music.play()
