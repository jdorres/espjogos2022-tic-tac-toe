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
	
		# Verifica se o jogo terminou
	var winning_player = check_winner();
	if(winning_player == 3):
		game_ended = true;
		print("Deu Velha!");
		return;
	if(winning_player > 0 and winning_player < 3):
		game_ended = true;
		print("Jogador %d venceu!" % winning_player);
		return;

	if(current_player == 1):
		current_player = 2
		ia_plays()
		
		#TODO: corrigir repetição de código
		# Verifica se o jogo terminou
		winning_player = check_winner();
		if(winning_player == 3):
			game_ended = true;
			print("Deu Velha!")
			return
		if(winning_player > 0 and winning_player < 3):
			game_ended = true
			print("Jogador %d venceu!" % winning_player)
			return
		else:
			current_player = 1

func ia_plays():
	print('ia plays')
	player_ia.plays(board_nodes, board_size_lines, board_size_columns)
	current_player = 1


func check_winner():
	# Checa vitória para cada player
	for player in [1, 2]:
		# Verifica linhas
		for line in range(board_size_lines):
			if(check_line(line, player)):
				return player;
		
		# Verifica colunas
		for column in range(board_size_columns):
			if(check_column(column, player)):
				return player;
				
		# Verifica diagonais
		for diagonal in [0, 2]:
			if(check_diagonal(diagonal, player)):
				return player;
				
	# Até aqui, nenhum jogador ganhou.
	# Checa se todas as posições estão ocupadas
	var empty_positions = 0;
	for line in range(board_size_lines):
		for column in range(board_size_columns):
			if(board_nodes[line][column].get_player() == 0):
				empty_positions += 1;
				
	# Se todas estão ocupapdas, deu velha!
	if(empty_positions == 0):
		return 3;
		
	# Senão, o jogo ainda não terminou.
	return 0;
	
	
# Verifica se uma linha inteira está marcada como um certo player
func check_line(line, player):
	for column in range(board_size_columns):
		if(board_nodes[line][column].get_player() != player):
			return false;
	return true;
	
# Verifica se uma coluna inteira está marcada como um certo player
func check_column(column, player):
	for line in range(board_size_lines):
		if(board_nodes[line][column].get_player() != player):
			return false;
	return true;


func check_diagonal(diagonal, player):
	# Percorre as linhas
	for line in range(board_size_lines):
		var column;
		if(diagonal == 0):
			# Diagonal principal
			column = line;
		else:
			# Diagonal secundária, inverte a coluna
			column = board_size_columns - line - 1;
			
		if(board_nodes[line][column].get_player() != player):
			return false;
			
	return true;
