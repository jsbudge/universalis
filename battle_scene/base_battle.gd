extends Node2D

const BattleTile = preload("res://battle_scene/battle_tile.tscn")
const BattleChar = preload("res://battle_scene/battle_character.tscn")
const Explosion = preload("res://battle_scene/purple_explosion.tscn")

# This shares all the battle data across nodes so we don't have to pingpong signals all over
@export var grid: Resource = preload("res://battle_scene/battledata.tres")
var mode = 0
var wait_animation: bool = false
signal init_ui
signal pos_changed
signal animation
signal next_action

# Called when the node enters the scene tree for the first time.
func _ready():
	load_player(100, 100, ActivePlayer.player_data.stats, ActivePlayer.player_data.harmonics, 
	1, "Test Dude", 0, Vector2(3, 3))
	load_player(100, 100, ActivePlayer.player_data.stats, ActivePlayer.player_data.harmonics, 
	1, "Test Enemy", 1, Vector2(3, 4))
	$Cursor.set_cell(grid.get_player_grid_position(0))
	$Cursor.visible = false
	
func load_player(max_hp, curr_hp, stats, curr_harmonics, curr_status, curr_name, curr_team, ppos):
	var player = BattleChar.instantiate()
	player.set_values(max_hp, curr_hp, stats, curr_harmonics, curr_status, curr_name, curr_team)
	player.position = grid.calculate_map_position(ppos)
	grid.add_player(player)
	add_child(player)


func _on_battle_ui_atk_select(selected_move):
	var move = ActivePlayer.getActiveOrb().moves[selected_move]
	emit_signal("animation", true)
	var exp = Explosion.instantiate()
	exp.position = grid.calculate_map_position($Cursor.cell) - Vector2(32, 32)
	exp.get_node("Animation").connect("animation_finished", ignore_input)
	add_child(exp)
	await(exp.get_node("Animation").animation_finished)
	$Cursor.set_cell(grid.get_player_grid_position(0))
	emit_signal("next_action")
	
func ignore_input():
	emit_signal("animation", false)


func _on_battle_ui_move_select():
	grid.players[0].position = grid.calculate_map_position($Cursor.cell)
	$Cursor.set_cell(grid.get_player_grid_position(0))
	emit_signal("next_action")


func _on_battle_ui_show_cursor(toggle):
	$Cursor.visible = toggle
