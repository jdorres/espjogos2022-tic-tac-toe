extends Node2D

export var board_size_lines = 3
export var board_size_columns = 3

var board_nodes
var current_player
var game_ended
var player_ia

#NEW
#var ai_player_node

#ao iniciar: carrega o jogo
func _ready():
	player_ia = get_node("PlayerIA")
	#preenche as posições
	board_nodes = []
	for line in range(board_size_lines):
		board_nodes.append([])
		for column in range(board_size_columns):
			var node = get_node("%d-%d" % [line,column])
			node.set_board(self, line, column)
			board_nodes[line].append(node)
	reset_game()

func reset_game():
	current_player = 1
	game_ended = false
	#zera as marcações nas peças
	for line in range(board_size_lines):
		for column in range(board_size_columns):
			board_nodes[line][column].set_player(0);

func node_clicked(line, column, field_value):
	print("node_clicked")
	
	#TODO: verificar se o jogo terminou
	#check_winner()
	
	#verifica se a casa já não está ocupada
	if(field_value != 0):
		print("Este campo já foi selecionado. Tente outro.")
		return
	make_move(line, column, current_player)

func make_move(line, column, player):
	board_nodes[line][column].set_player(player)
	if(current_player == 1):
		current_player = 2
		ia_plays()
	else:
		current_player = 1

func ia_plays():
	print('ia plays')
	pass


#check winner
func check_winner():
	print("check_winner")
	
func check_line():
	print("check_line")

func check_column():
	print("check_column")

func check_diagonal():
	print("check_diagonal")
