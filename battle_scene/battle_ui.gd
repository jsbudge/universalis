extends Control

signal atk_select

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
		
func writeInfo(s: String) -> void:
	$InfoPanel/InfoLabel.text = s


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
	# $AttackGrid/Atk1.grab_focus()


func _on_button_focus_entered(message: String):
	writeInfo(message)


func _on_atk_pressed(butt_num: int) -> void:
	$Select.visible = true
	$Select/AnimatedSprite2D.play()
