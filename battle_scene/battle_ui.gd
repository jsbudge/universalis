extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$SwapGrid.visible = false
	$AttackGrid.visible = false
	$OptionGrid.visible = true
	$ActiveOrbDisplay.texture = ActivePlayer.getActiveOrb().texture
	var idx = 0
	for child in $SwapGrid.get_children():
		child.text = ActivePlayer.player_data.ready_orbs[idx].name
		idx += 1
	'''
	idx = 0
	for child in $AttackGrid.get_children():
		child.text = ActivePlayer.getActiveOrb().moves[idx]
		idx += 1'''


func _on_swap_button_pressed():
	$OptionGrid.visible = false
	$SwapGrid.visible = true
	$SwapGrid/Orb1.grab_focus()


func _on_swap_orb_pressed(butt_num: int):
	ActivePlayer.setActiveOrb(butt_num)
	_ready()
