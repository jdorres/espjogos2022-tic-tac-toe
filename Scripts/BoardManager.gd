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
var sound_click_player
var sound_click_ia
var sound_click_error
var sound_game_ends
var sound_game_ends_lose
var game_mode #multi/easy/medium/hard
var ia_is_playing = false

signal game_started
signal game_ended


func start_game(mode):
	game_mode = mode
	player_ia = get_node("PlayerIA")
	status_label = get_node("StatusLabel")
	game_end_label = get_node("GameEndPanel")
	game_end_label.visible = false
	game_end_message = get_node("GameEndPanel/GameEndMessage")
	
	sound_click_player = get_node("GameSoundPlayer/SoundPlayerSelect")
	sound_click_ia = get_node("GameSoundPlayer/SoundIASelect")
	sound_click_error = get_node("GameSoundPlayer/SoundError")
	sound_game_ends = get_node("GameSoundPlayer/SoundGameEnds")
	sound_game_ends_lose = get_node("GameSoundPlayer/SoundGameEndsLose")

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
	emit_signal("game_started")
	
	#randomiza quem começa jogando mas se rodar  minimax na primeira rodada trava
#	if(game_mode != 'multi'):
#		current_player = (randi() % 2+1)
#		if(current_player == 2):
#			ia_plays()

func node_clicked(line, column, field_value):
	if !game_ended:
		if(field_value != 0):
			sound_click_error.play()
			shows_message('Campo ocupado!')
		else:
			sound_click_player.play()
			make_move(line, column, current_player)

func make_move(line, column, player):
	board_nodes[line][column].set_player(player)
	
	# Verifica se o jogo terminou
	var winning_player = check_winner(board_nodes, board_size_lines, board_size_columns)
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
	emit_signal("game_ended")
	match result:
		1:
			if game_mode == 'multi':
				game_end_message.text = 'Player 1 X venceu! Parabens!'
			else:
				game_end_message.text = 'Voce ganhou, parabens!'
			sound_game_ends.play()
		2:
			if game_mode == 'multi':
				game_end_message.text = 'Player 2 O venceu! Parabens!'
				sound_game_ends.play()
			else:
				game_end_message.text = 'Voce perdeu.'
				sound_game_ends_lose.play()
		3:
			game_end_message.text = 'Deu velha!'
			sound_game_ends_lose.play()
	
	game_end_label.visible = true

func ia_plays():
	ia_is_playing = true
	status_label.text = 'Pensando...'
	yield(get_tree().create_timer(0.7), "timeout")
	player_ia.plays(board_nodes, board_size_lines, board_size_columns, game_mode)
	sound_click_ia.play()
	ia_is_playing = false
	status_label.text = ''
	current_player = 1
	
	#TODO: corrigir repetição de código
	# Verifica se o jogo terminou
	var winning_player = check_winner(board_nodes, board_size_lines, board_size_columns)
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

	var empty_positions = 0;
	for line in range(board_size_lines):
		for column in range(board_size_columns):
			if(board_nodes[line][column].get_player() == 0):
				empty_positions += 1;
				
	if(empty_positions == 0):
		return 3;

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
