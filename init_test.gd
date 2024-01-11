extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("open_inventory"):
		var inv_scene = preload("res://assets/inventory_handler.tscn")
		inv_scene.add_child($Player)
		get_tree().change_scene_to_packed(inv_scene)
		
