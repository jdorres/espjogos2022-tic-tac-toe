extends Node2D

var board_manager
var main_menu
var sub_menu

func _ready():
	board_manager = get_node("BoardManager")
	main_menu = get_node("MainMenu")
	sub_menu = get_node("SubMenu")


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_MultiplayerButton_pressed():
	main_menu.visible = false
	board_manager.visible = true
	board_manager.start_game("multi")


func _on_SinglePlayerButton_pressed():
	main_menu.visible = false
	sub_menu.visible = true


func _on_EasyButton_pressed():
	sub_menu.visible = false
	board_manager.visible = true
	board_manager.start_game("easy")
		


func _on_MediumButton_pressed():
	sub_menu.visible = false
	board_manager.visible = true
	board_manager.start_game("medium")


func _on_HardButton_pressed():
	sub_menu.visible = false
	board_manager.visible = true
	board_manager.start_game("hard")


func _on_MainMenuButton_pressed():
	main_menu.visible = true
	board_manager.visible = false
