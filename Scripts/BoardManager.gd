extends Node2D

export var board_size_lines = 3
export var board_size_columns = 3

var board_nodes
var current_player
var game_ended
var player_ia
var status_label
var game_end_label
var game_end_message
var game_mode #multi/easy/medium/hard
var ia_is_playing = false

func start_game(mode):
	game_mode = mode
	player_ia = get_node("PlayerIA")
	status_label = get_node("StatusLabel")
	game_end_label = get_node("GameEndLabel")
	game_end_label.visible = false
	game_end_message = get_node("GameEndLabel/GameEndMessage")

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
	game_end_label.visible = false
	for line in range(board_size_lines):
		for column in range(board_size_columns):
			board_nodes[line][column].set_player(0);

func node_clicked(line, column, field_value):
	if !game_ended:
		if(field_value != 0):
			shows_message('Campo invalido')
		else:
			make_move(line, column, current_player)

func make_move(line, column, player):
	board_nodes[line][column].set_player(player)
	
	# Verifica se o jogo terminou
	var winning_player = check_winner()
	if(winning_player == 3):
		game_ended = true;
		shows_game_result(3)
		return
	elif(winning_player == 1):
		game_ended = true
		shows_game_result(1)
		return
	elif(winning_player == 2):
		game_ended = true
		shows_game_result(2)
		return
		
		
	if(current_player == 1):
		current_player = 2
		if game_mode != 'multi':
			ia_plays()
	else:
		current_player = 1

func shows_message(message):
	status_label.text = message
	yield(get_tree().create_timer(0.8), "timeout")
	status_label.text = ''

func shows_game_result(result):
	yield(get_tree().create_timer(0.8), "timeout")
	match result:
		1:
			if game_mode == 'multi':
				game_end_message.text = 'Player 1 X venceu! Parabens!'
			else:
				game_end_message.text = 'Voce ganhou, parabens!'				
		2:
			if game_mode == 'multi':
				game_end_message.text = 'Player 2 O venceu! Parabens!'
			else:
				game_end_message.text = 'Voce perdeu.' 
		3:
			game_end_message.text = 'Deu velha!'
	
	game_end_label.visible = true
	
	
func ia_plays():
	ia_is_playing = true
	status_label.text = 'Pensando...'
	yield(get_tree().create_timer(1), "timeout")
	player_ia.plays(board_nodes, board_size_lines, board_size_columns, game_mode)
	ia_is_playing = false
	status_label.text = ''
	current_player = 1
	
	#TODO: corrigir repetição de código
	# Verifica se o jogo terminou
	var winning_player = check_winner()
	if(winning_player == 3):
		game_ended = true;
		shows_game_result(3)
		return
	elif(winning_player == 1):
		game_ended = true
		shows_game_result(1)
		return
	elif(winning_player == 2):
		game_ended = true
		shows_game_result(2)
		return
	else:
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
	
	print('nenhum jogador ganhou ainda')
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

func check_line(line, player):
	for column in range(board_size_columns):
		if(board_nodes[line][column].get_player() != player):
			return false;
	return true;

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


func _on_RestartGameButton_pressed():
	reset_game()
