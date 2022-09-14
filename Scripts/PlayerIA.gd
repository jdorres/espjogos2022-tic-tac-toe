extends Node2D

func _ready():
	pass # Replace with function body.


func plays(board_nodes, board_size_lines, board_size_columns):
	#play_first_free_position(board_nodes, board_size_lines, board_size_columns)
	play_mini_max(board_nodes, board_size_lines, board_size_columns)
	
func play_first_free_position(board_nodes, board_size_lines, board_size_columns):
	for line in range(board_size_lines):
		for column in range(board_size_columns):
			if(board_nodes[line][column].get_player() == 0):
				board_nodes[line][column].set_player(2)
				return

func play_mini_max(board_nodes, board_size_lines, board_size_columns):
	var free_spaces  = free_spaces(board_nodes, board_size_lines, board_size_columns)
	var bestScore = -999
	var bestMove = null
	var board_nodes_copy =  board_nodes.duplicate()
	
	for free_space in free_spaces:
		board_nodes_copy[free_space[0]][free_space[1]].set_player(2)
		var score = minimax(board_nodes, board_size_lines, board_size_columns, free_spaces, false)
		if(score > bestScore):
			bestScore = score
			bestMove = board_nodes[free_space[0]][free_space[1]]
	bestMove.set_player(2)

func minimax(board_nodes, board_size_lines, board_size_columns, free_spaces, isMaximazing):
	var winning_player = check_winner(board_nodes, board_size_lines, board_size_columns)
	if(winning_player != 0):
		return winning_player
		
	if(isMaximazing):
		return 1		
	else:
		return 1

func free_spaces(board_nodes, board_size_lines, board_size_columns):
	var free_spaces = []
	for line in range(board_size_lines):
		for column in range(board_size_columns):
			if(board_nodes[line][column].get_player() == 0):
				free_spaces.append([line, column])
	return free_spaces

func check_winner(board_nodes, board_size_lines, board_size_columns):
	# Checa vitória para cada player
	for player in [1, 2]:
		# Verifica linhas
		for line in range(board_size_lines):
			if(check_line(board_nodes, board_size_lines, board_size_columns, line, player)):
				return player;
		
		# Verifica colunas
		for column in range(board_size_columns):
			if(check_column(board_nodes, board_size_lines, board_size_columns, column, player)):
				return player;
				
		# Verifica diagonais
		for diagonal in [0, 2]:
			if(check_diagonal(board_nodes, board_size_lines, board_size_columns, diagonal, player)):
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
	
func check_line(board_nodes, board_size_lines, board_size_columns, line, player):
	for column in range(board_size_columns):
		if(board_nodes[line][column].get_player() != player):
			return false;
	return true;
	
func check_column(board_nodes, board_size_lines, board_size_columns, column, player):
	for line in range(board_size_lines):
		if(board_nodes[line][column].get_player() != player):
			return false;
	return true;

func check_diagonal(board_nodes, board_size_lines, board_size_columns, diagonal, player):
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
