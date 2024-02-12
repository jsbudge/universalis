extends Control

signal atk_select
signal move_select

# This shares all the battle data across nodes so we don't have to pingpong signals all over
@export var grid: Resource = preload("res://battle_scene/battledata.tres")
var selected_butt: int = 0
var selected_mode: int = 0
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
	setMode(0)

func writeInfo(s: String) -> void:
	$InfoPanel/InfoLabel.text = s


func _on_swap_button_pressed():
	setMode(3)
	$OptionGrid.visible = false
	$SwapGrid.visible = true
	$SwapGrid/Orb1.grab_focus()


func _on_swap_orb_pressed(butt_num: int):
	ActivePlayer.setActiveOrb(butt_num)
	_ready()


func _on_attack_button_pressed():
	$OptionGrid.visible = false
	$AttackGrid.visible = true
	setMode(2)
	$AttackGrid/Atk1.grab_focus()


func _on_button_focus_entered(message: String):
	writeInfo(message)


func _on_atk_pressed(butt_num: int) -> void:
	selected_butt = butt_num


func _on_move_button_pressed():
	setMode(4)
	$OptionGrid.visible = false
	$MoveLabel.visible = true


func _on_game_scene_animation(toggle):
	wait_animation = toggle


func _on_game_scene_next_action():
	#Make sure everything is reset for the next action
	$OptionGrid.visible = true
	$SwapGrid.visible = false
	$AttackGrid.visible = false
	$MoveLabel.visible = false


func _on_cursor_accept_pressed(cell):
	if selected_mode == 0:
		if grid.get_player_grid_position(0) == cell:
			setMode(1)
		else:
			$InfoPanel/InfoLabel.text = 'You have clicked on something.'
	elif selected_mode == 2:
		emit_signal('atk_select', selected_butt)
	elif selected_mode == 4:
		emit_signal('move_select')
		
func setMode(mode: int):
	# Set everything invisible at first, only see what mode we're in
	$OptionGrid.visible = false
	$SwapGrid.visible = false
	$AttackGrid.visible = false
	$MoveLabel.visible = false
	if mode == 0:
		writeInfo("Move the cursor and get some info!")
	elif mode == 1:
		$OptionGrid.visible = true
		$OptionGrid/AttackButton.grab_focus()
	elif mode == 2:
		$AttackGrid.visible = true
		$AttackGrid/Atk1.grab_focus()
	elif mode == 3:
		$SwapGrid.visible = true
		$SwapGrid/Orb1.grab_focus()
	elif mode == 4:
		$MoveLabel.visible = true
