extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameScene/Player.position = Vector2(500, 500)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("open_inventory"):
		$HUD/InventoryUI.visible = not $HUD/InventoryUI.visible
	elif Input.is_action_just_pressed("open_menu"):
		$HUD/MainMenu.visible = not $HUD/MainMenu.visible
		


func _on_main_menu_inventory_start():
	var inv_scene = preload("res://assets/inventory_handler.tscn")
	get_tree().change_scene_to_packed(inv_scene)
