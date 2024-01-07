extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _update_healthbar(change):
	print("Started to %f" % $PlayerHealth.value)
	$PlayerHealth.value += change
