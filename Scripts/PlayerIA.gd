extends Node2D


var boar_manager
var rand = RandomNumberGenerator.new()

func _ready():
	pass # Replace with function body.


func plays(board_nodes, board_size_lines, board_size_columns):
	play_first_free_position(board_nodes, board_size_lines, board_size_columns)
	#play_mini_max(board_nodes, board_size_lines, board_size_columns)
	
func play_first_free_position(board_nodes, board_size_lines, board_size_columns):
	for line in range(board_size_lines):
		for column in range(board_size_columns):
			if(board_nodes[line][column].get_player() == 0):
				board_nodes[line][column].set_player(2)
				return

func play_mini_max(board_nodes, board_size_lines, board_size_columns):
	print("minimax")
	
	
