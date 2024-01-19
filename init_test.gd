extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameScene/Player.position = Vector2(500, 500)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("open_inventory"):
		$HUD/InventoryUI.visible = not $HUD/InventoryUI.visible
		$GameScene.process_mode = Node.PROCESS_MODE_DISABLED if $HUD/InventoryUI.visible else Node.PROCESS_MODE_ALWAYS
	elif Input.is_action_just_pressed("open_menu"):
		$HUD/MainMenu.visible = not $HUD/MainMenu.visible
		$GameScene.process_mode = Node.PROCESS_MODE_DISABLED if $HUD/MainMenu.visible else Node.PROCESS_MODE_ALWAYS
