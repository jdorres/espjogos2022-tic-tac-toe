extends Node2D


var boar_manager

func _ready():
	pass # Replace with function body.


func get_ai_player(player):
	#play_first_free_position
	#play_random_position
	#
	pass;
	
func play_first_free_position(board_nodes, board_size_lines, board_size_columns):
	for line in range(board_size_lines):
		for column in range(board_size_columns):
			if(board_nodes[line][column].get_player()):
				return board_nodes[line][column];
	
func play_random_position():
	pass
