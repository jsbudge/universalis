extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ActivePlayer.player_data.hp != $HUDDisplay/PlayerHealth.value:
		$HUDDisplay/PlayerHealth.value = ActivePlayer.player_data.hp


func _on_player_interactable(run: bool):
	if run:
		$InteractionPossible.visible = true
		$InteractionPossible/AnimatedSprite2D.play()
	else:
		$InteractionPossible.visible = false
		$InteractionPossible/AnimatedSprite2D.stop()
