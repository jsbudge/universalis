extends Node2D

const BattleTile = preload("res://battle_scene/battle_tile.tscn")
const BattleChar = preload("res://battle_scene/battle_character.tscn")
@onready var grid: Array[Array] = [[], [], [], [], [], []]
@onready var players: Array
var mode = 0

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
			
func load_grid(grid_data):
	pass
	
func _process(delta):
	if mode == 1:
		if Input.is_action_just_pressed("move_down"):
			$Select.position = players[0].position + Vector2(0, 50)
		elif Input.is_action_just_pressed("move_up"):
			$Select.position = players[0].position - Vector2(0, 50)
		elif Input.is_action_just_pressed("move_left"):
			$Select.position = players[0].position + Vector2(50, 0)
		elif Input.is_action_just_pressed("move_right"):
			$Select.position = players[0].position - Vector2(50, 0)
	
func load_player(max_hp, curr_hp, stats, curr_harmonics, curr_status, curr_name, curr_team, ppos):
	var player = BattleChar.instantiate()
	player.set_values(max_hp, curr_hp, stats, curr_harmonics, curr_status, curr_name, curr_team)
	player.position = ppos
	players.append(player)
	add_child(player)


func _on_battle_ui_atk_select(atk_num):
	$Select.position = players[0].position + Vector2(50, 0)
	$Select.visible = true
	$Select.play()
	mode = 1
