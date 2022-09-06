extends Area2D

export(Array, Texture) var player_textures

var player_marked: int
var sprite
var board
var pos_line
var pos_column

func _ready():
	sprite = get_node("Sprite");
	set_player(0)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		print(player_marked)
		board.node_clicked(pos_line, pos_column, player_marked)

func get_player():
	print('get_player')

func set_player(player):
	player_marked = player
	sprite.texture = player_textures[player]
	print(sprite.texture, player_textures[player])

func set_board(board, line, column):
	self.board = board
	pos_line = line
	pos_column = column
