extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_react():
	visible = true
	play()
	
func _on_animation_finished():
	visible = false
