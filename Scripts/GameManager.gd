extends Node2D

var board_manager
var main_menu
var sub_menu

func _ready():
	board_manager = get_node("BoardManager")
	main_menu = get_node("MainMenu")
	sub_menu = get_node("SubMenu")


func _on_QuitButton_pressed():
	playMenuClickSound()
	get_tree().quit()

func _on_MultiplayerButton_pressed():
	main_menu.visible = false
	board_manager.visible = true
	board_manager.start_game("multi")
	playMenuClickSound()

func _on_SinglePlayerButton_pressed():
	main_menu.visible = false
	sub_menu.visible = true
	playMenuClickSound()

func _on_EasyButton_pressed():
	sub_menu.visible = false
	board_manager.visible = true
	board_manager.start_game("easy")
	playMenuClickSound()


func _on_MediumButton_pressed():
	sub_menu.visible = false
	board_manager.visible = true
	board_manager.start_game("medium")
	playMenuClickSound()

func _on_HardButton_pressed():
	sub_menu.visible = false
	board_manager.visible = true
	board_manager.start_game("hard")
	playMenuClickSound()

func _on_MainMenuButton_pressed():
	main_menu.visible = true
	board_manager.visible = false
	playMenuClickSound()

#sound control
func playMenuHoverSound():
	var sound = get_node('ButtonSoundPlayer/SoundMenuHover')
	sound.play()
	
func playMenuClickSound():
	var sound = get_node('ButtonSoundPlayer/SoundMenuClick')
	sound.play()

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
