extends Node2D

const BattleTile = preload("res://battle_scene/battle_tile.tscn")
const BattleChar = preload("res://battle_scene/battle_character.tscn")
@onready var grid: Array[Array] = [[], [], [], [], [], []]
@onready var players: Array
var mode = 0
signal init_ui

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(5):
		for y in range(4):
			var btile = BattleTile.instantiate()
			btile.position = Vector2(100 + x * 50, 150 + y * 50)
			grid[x].append(btile)
			add_child(btile)
	load_player(100, 100, ActivePlayer.player_data.stats, ActivePlayer.player_data.harmonics, 
	1, "Test Dude", 0, grid[2][1].position + Vector2(16, 16))
	$Select.visible = false
	$Select.stop()
	emit_signal("init_ui", [[2, 1]])


func load_grid(grid_data):
	pass
	
func load_player(max_hp, curr_hp, stats, curr_harmonics, curr_status, curr_name, curr_team, ppos):
	var player = BattleChar.instantiate()
	player.set_values(max_hp, curr_hp, stats, curr_harmonics, curr_status, curr_name, curr_team)
	player.position = ppos
	players.append(player)
	add_child(player)
