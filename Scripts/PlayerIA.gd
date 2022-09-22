extends Node2D

var board_manager

func _ready():
	board_manager = get_parent()
	
func plays(board_nodes, board_size_lines, board_size_columns, game_mode):
	match game_mode:
		'easy':
			if (randi() % 9) < 6:
				play_random_position(board_nodes, board_size_lines, board_size_columns)
			else:
				play_mini_max(board_nodes, board_size_lines, board_size_columns)
		'medium':
			if (randi() % 9) < 4:
				play_random_position(board_nodes, board_size_lines, board_size_columns)
			else:
				play_mini_max(board_nodes, board_size_lines, board_size_columns)
		_:
			play_mini_max(board_nodes, board_size_lines, board_size_columns)

func play_random_position(board_nodes, board_size_lines, board_size_columns):
	var free_spaces  = free_spaces(board_nodes, board_size_lines, board_size_columns)
	var rand_pos = free_spaces[(randi() % free_spaces.size())]
	board_nodes[rand_pos[0]][rand_pos[1]].set_player(2)
	
func play_mini_max(board_nodes, board_size_lines, board_size_columns):
	var free_spaces  = free_spaces(board_nodes, board_size_lines, board_size_columns)
	var bestScore = -999
	var bestMove = null

	for free_space in free_spaces:
		board_nodes[free_space[0]][free_space[1]].set_player(2)
		var score = minimax(board_nodes, board_size_lines, board_size_columns, free_spaces, false)
		board_nodes[free_space[0]][free_space[1]].set_player(0)
		
		if(score > bestScore):
			bestScore = score
			bestMove = board_nodes[free_space[0]][free_space[1]]
		elif(score == bestScore):
			if (randi() % 2):
				bestScore = score
				bestMove = board_nodes[free_space[0]][free_space[1]]
	bestMove.set_player(2)

func minimax(board_nodes, board_size_lines, board_size_columns, free_spaces, isMaximazing):
	var winning_player = board_manager.check_winner(board_nodes, board_size_lines, board_size_columns)
	if winning_player == 1 :
		return -1;
	elif winning_player == 2 :
		return 1;
	elif winning_player == 3 :
		return 0;
	
	if(isMaximazing):
		var bestScore = -999
		var i = free_spaces(board_nodes, board_size_lines, board_size_columns)
		for free_space in i:
			board_nodes[free_space[0]][free_space[1]].set_player(2)
			var score = minimax(board_nodes, board_size_lines, board_size_columns, i, false)
			board_nodes[free_space[0]][free_space[1]].set_player(0)

			if(score > bestScore):
				bestScore = score
		return bestScore
	else:
		var bestScore = 999
		var i = free_spaces(board_nodes, board_size_lines, board_size_columns)
		for free_space in i:
			board_nodes[free_space[0]][free_space[1]].set_player(1)
			var score = minimax(board_nodes, board_size_lines, board_size_columns, i, true)
			board_nodes[free_space[0]][free_space[1]].set_player(0)

			if(score < bestScore):
				bestScore = score
		return bestScore

func free_spaces(board_nodes, board_size_lines, board_size_columns):
	var free_spaces = []
	for line in range(board_size_lines):
		for column in range(board_size_columns):
			if(board_nodes[line][column].get_player() == 0):
				free_spaces.append([line, column])
	return free_spaces
