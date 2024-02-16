extends Node2D

const BattleTile = preload("res://battle_scene/battle_tile.tscn")
const BattleChar = preload("res://battle_scene/battle_character.tscn")
const Explosion = preload("res://battle_scene/purple_explosion.tscn")

# This shares all the battle data across nodes so we don't have to pingpong signals all over
@export var grid: Resource = preload("res://battle_scene/battledata.tres")

# Set all the phases for battle
const SELECT_ACTION_PHASE: int = 0
const EXECUTE_ACTION_PHASE: int = 1
const RESULT_ACTION_PHASE: int = 2
const ENEMY_EXECUTE_PHASE: int = 3
var phase: int = 0

# Set all the modes
const MOVE_SELECT: int = 0
const ATTACK_SELECT: int = 1
const SWAP_ORB_SELECT: int = 2
var actions: int = 2
var wait_animation: bool = false
var enemies_damaged: Array
signal init_ui
signal pos_changed
signal phase_change(p)
signal next_action

# Called when the node enters the scene tree for the first time.
func _ready():
	load_player(100, 100, ActivePlayer.player_data.stats, ActivePlayer.player_data.harmonics, 
	1, "Test Dude", 0, Vector2(3, 3))
	load_player(100, 100, ActivePlayer.player_data.stats, ActivePlayer.player_data.harmonics, 
	1, "Test Enemy", 1, Vector2(3, 4))
	$Cursor.set_cell(grid.get_player_grid_position(0))
	
func load_player(max_hp, curr_hp, stats, curr_harmonics, curr_status, curr_name, curr_team, ppos):
	var player = BattleChar.instantiate()
	player.set_values(max_hp, curr_hp, stats, curr_harmonics, curr_status, curr_name, curr_team)
	player.position = grid.calculate_map_position(ppos)
	grid.add_player(player)
	add_child(player)


func _on_battle_ui_atk_select(selected_move):
	var move = ActivePlayer.getActiveOrb().moves[selected_move]
	set_next_phase(ATTACK_SELECT)


func _on_battle_ui_move_select():
	grid.players[0].position = grid.calculate_map_position($Cursor.cell)
	set_next_phase(MOVE_SELECT)
	
func set_next_phase(selected_action):
	phase += 1
	emit_signal('phase_change', phase)
	if phase == EXECUTE_ACTION_PHASE:
		if selected_action == MOVE_SELECT:
			set_next_phase(MOVE_SELECT)
		if selected_action == ATTACK_SELECT:
			var exp = Explosion.instantiate()
			exp.position = grid.calculate_map_position($Cursor.cell) - Vector2(32, 32)
			exp.get_node("Animation").connect("animation_finished", set_next_phase)
			add_child(exp)
	elif phase == RESULT_ACTION_PHASE:
		# Do results of action, if any
		# Move to the next action, be it player or CPU
		set_next_action()
	elif phase == ENEMY_EXECUTE_PHASE:
		# Do enemy AI stuff
		# Reset the phase for player interaction
		phase = SELECT_ACTION_PHASE

func set_next_action():
	$Cursor.set_cell(grid.get_player_grid_position(0))
	$Cursor.visible = false
	actions -= 1
	if actions <= 0:
		actions = 3
		set_next_phase(ENEMY_EXECUTE_PHASE)
	else:
		phase = SELECT_ACTION_PHASE
		emit_signal('next_action')
