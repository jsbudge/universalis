extends Node2D

const BattleTile = preload("res://battle_scene/battle_tile.tscn")
const BattleChar = preload("res://battle_scene/battle_character.tscn")
@export var grid_init: Vector2 = Vector2(100, 100)
@export var grid_spacing: Vector2 = Vector2(50, 50)
@onready var players: Array
var mode = 0
signal init_ui

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(5):
		for y in range(4):
			var btile = BattleTile.instantiate()
			btile.position = Vector2(100 + x * 50, 150 + y * 50)
			add_child(btile)
	var ppos = grid_init + Vector2(16 + grid_spacing.x * 2, 16 + grid_spacing.y * 1)
	load_player(100, 100, ActivePlayer.player_data.stats, ActivePlayer.player_data.harmonics, 
	1, "Test Dude", 0, ppos)
	emit_signal("init_ui", grid_init, grid_spacing, ppos)


func load_grid(grid_data):
	pass
	
func load_player(max_hp, curr_hp, stats, curr_harmonics, curr_status, curr_name, curr_team, ppos):
	var player = BattleChar.instantiate()
	player.set_values(max_hp, curr_hp, stats, curr_harmonics, curr_status, curr_name, curr_team)
	player.position = ppos
	players.append(player)
	add_child(player)
