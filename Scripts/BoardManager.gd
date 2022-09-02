extends Node2D

export var board_size_lines = 1
export var board_size_columns = 1

var board_nodes;
var current_player;
var game_ended;


#NEW
#var ai_player_node

func _ready():
	print("ready")
	
	#TODO: popula matriz
	board_nodes = []
	for line in range(board_size_lines):
		board_nodes.append([])
		for column in range(board_size_columns):
			print("%d-%d" % [line,column])
			var node = get_node("%d-%d" % [line,column])
			node.set_board(self, line, column)
			board_nodes[line].append(node)
			
	print(board_nodes)	
	reset_game()

func reset_game():
	print("reset_game")
	current_player = 1
	game_ended = false
	#TODO: a entender

func node_clicked():
	print("node_clicked")
	#TODO: verificar se o jogo terminou
	#TODO: verifica se a casa já não está ocupada
	pass 	

func make_move(line, column, player):
	print("make_move", line, column, player)	

func check_winner():
	print("check_winner")
	
func check_line():
	print("check_line")

func check_column():
	print("check_column")

func check_diagonal():
	print("check_diagonal")
