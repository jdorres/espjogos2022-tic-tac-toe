extends Area2D

export(Array, Texture) var player_textures

var player_marked: int
var sprite
var board
var pos_line
var pos_column

func _ready():
	print('ready')

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		print('clicked', player_marked, pos_line, pos_column)

func get_player():
	print('get_player')

func set_player():
	print('set_player')

func set_board(board, line, column):
	print('set_board')
	self.board = board
	pos_line = line
	pos_column = column
