extends Control

signal atk_select
signal move_select
signal atk_chose
signal show_cursor

# get consts running for ease of reading
const INFO_MODE: int = 0
const OPTION_MODE: int = 1
const ATTACK_SELECT_MODE: int = 2
const MOVE_SELECT_MODE: int = 3
const SWAP_ORB_MODE: int = 4

# This shares all the battle data across nodes so we don't have to pingpong signals all over
@export var grid: Resource = preload("res://battle_scene/battledata.tres")
var selected_butt: int = -1
var selected_mode: int = INFO_MODE
var wait_animation: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var aorb = ActivePlayer.getActiveOrb()
	$ActiveOrbDisplay.texture = aorb.texture
	var idx = 0
	for child in $SwapGrid.get_children():
		child.text = ActivePlayer.player_data.ready_orbs[idx].name
		idx += 1
	idx = 0
	for child in $AttackGrid.get_children():
		if aorb.moves[idx]:
			child.text = aorb.moves[idx].name
			child.tooltip_text = aorb.moves[idx].description
		else:
			child.visible = false
		idx += 1
	setMode(OPTION_MODE)

func writeInfo(s: String) -> void:
	$InfoPanel/InfoLabel.text = s


func _on_swap_button_pressed():
	setMode(SWAP_ORB_MODE)
	$OptionGrid.visible = false
	$SwapGrid.visible = true
	$SwapGrid/Orb1.grab_focus()


func _on_swap_orb_pressed(butt_num: int):
	ActivePlayer.setActiveOrb(butt_num)
	_ready()


func _on_attack_button_pressed():
	$OptionGrid.visible = false
	$AttackGrid.visible = true
	selected_butt = -1
	setMode(ATTACK_SELECT_MODE)
	$AttackGrid/Atk1.grab_focus()


func _on_button_focus_entered(message: String):
	writeInfo(message)


func _on_atk_pressed(butt_num: int) -> void:
	emit_signal('atk_chose', ActivePlayer.getActiveOrb().moves[butt_num])
	emit_signal('show_cursor', true)
	get_viewport().gui_release_focus()
	selected_butt = butt_num


func _on_move_button_pressed():
	setMode(MOVE_SELECT_MODE)
	selected_butt = -1
	$OptionGrid.visible = false
	$MoveLabel.visible = true


func _on_game_scene_animation(toggle):
	wait_animation = toggle


func _on_game_scene_next_action():
	#Make sure everything is reset for the next action
	setMode(OPTION_MODE)


func _on_cursor_accept_pressed(cell):
	if selected_mode == INFO_MODE:
		if grid.get_player_grid_position(0) == cell:
			setMode(OPTION_MODE)
		else:
			$InfoPanel/InfoLabel.text = 'You have clicked on something.'
	elif selected_mode == ATTACK_SELECT_MODE and selected_butt != -1:
		# setMode(INFO_MODE)
		emit_signal('atk_select', selected_butt)
	elif selected_mode == MOVE_SELECT_MODE and selected_butt != -1:
		emit_signal('move_select')
		
func setMode(mode: int):
	# Set everything invisible at first, only see what mode we're in
	$OptionGrid.visible = false
	$SwapGrid.visible = false
	$AttackGrid.visible = false
	$MoveLabel.visible = false
	if mode == INFO_MODE:
		writeInfo("Move the cursor and get some info!")
		emit_signal('show_cursor', true)
	elif mode == OPTION_MODE:
		$OptionGrid.visible = true
		$OptionGrid/AttackButton.grab_focus()
		emit_signal('show_cursor', false)
	elif mode == ATTACK_SELECT_MODE:
		$AttackGrid.visible = true
		$AttackGrid/Atk1.grab_focus()
		emit_signal('show_cursor', false)
	elif mode == SWAP_ORB_MODE:
		$SwapGrid.visible = true
		$SwapGrid/Orb1.grab_focus()
		emit_signal('show_cursor', false)
	elif mode == MOVE_SELECT_MODE:
		$MoveLabel.visible = true
		emit_signal('show_cursor', true)
	selected_mode = mode


func _on_info_button_pressed():
	setMode(INFO_MODE)
