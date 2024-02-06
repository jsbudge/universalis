extends Control

signal atk_select
signal move_select
var grid_init: Vector2 = Vector2(116, 166)
var grid_spacing: Vector2 = Vector2(50, 50)
var player_position: Vector2 = Vector2(166, 216)
var selected_butt: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var aorb = ActivePlayer.getActiveOrb()
	$SwapGrid.visible = false
	$AttackGrid.visible = false
	$OptionGrid.visible = true
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
	$OptionGrid/AttackButton.grab_focus()
	
func _process(delta):
	if $Select.has_focus():
		var direction = Vector2(0, 0)
		if Input.is_action_just_pressed("move_down"):
			direction += Vector2(0, grid_spacing.y)
		elif Input.is_action_just_pressed("move_up"):
			direction -= Vector2(0, grid_spacing.y)
		elif Input.is_action_just_pressed("move_left"):
			direction -= Vector2(grid_spacing.x, 0)
		elif Input.is_action_just_pressed("move_right"):
			direction += Vector2(grid_spacing.x, 0)
		selectMotion(direction)
		if Input.is_action_just_pressed("overworld_interact"):
			processSelect()
		
func writeInfo(s: String) -> void:
	$InfoPanel/InfoLabel.text = s
	
func selectMotion(direction: Vector2):
	if $MoveLabel.visible:
		var mvec = (($Select.position + direction) - player_position) / grid_spacing
		if abs(mvec.x) > 1 or abs(mvec.y) > 1 or (abs(mvec.x) > 0 and abs(mvec.y) > 0):
			direction = Vector2(0, 0)
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create($Select.position, $Select.position + mvec * grid_spacing)
		var result = space_state.intersect_ray(query)
		if result:
			direction = Vector2(0, 0)
		$Select.position += direction
	
func processSelect():
	# Process the attack that is selected
	if $AttackGrid.visible:
		emit_signal('atk_select', selected_butt)
	elif $MoveLabel.visible:
		emit_signal('move_select', selected_butt)
	
	#Make sure everything is reset for the next action
	setSelect(false)
	$OptionGrid.visible = true
	$SwapGrid.visible = false
	$AttackGrid.visible = false
	$MoveLabel.visible = false
	$OptionGrid/AttackButton.grab_focus()
	


func _on_swap_button_pressed():
	$OptionGrid.visible = false
	$SwapGrid.visible = true
	$SwapGrid/Orb1.grab_focus()


func _on_swap_orb_pressed(butt_num: int):
	ActivePlayer.setActiveOrb(butt_num)
	_ready()


func _on_attack_button_pressed():
	$OptionGrid.visible = false
	$AttackGrid.visible = true
	$AttackGrid/Atk1.grab_focus()


func _on_button_focus_entered(message: String):
	writeInfo(message)


func _on_atk_pressed(butt_num: int) -> void:
	setSelect(true)
	selected_butt = butt_num
	


func _on_game_scene_init_ui(gi: Vector2, gs: Vector2, ppos: Vector2) -> void:
	grid_spacing = gs
	grid_init = gi
	player_position = ppos


func _on_move_button_pressed():
	$OptionGrid.visible = false
	$MoveLabel.visible = true
	setSelect(true)
	
func setSelect(yes: bool):
	if yes:
		$Select.visible = true
		$Select.position = player_position
		$Select.grab_focus()
		$Select/AnimatedSprite2D.play()
	else:
		$Select.visible = false
		$Select/AnimatedSprite2D.stop()
