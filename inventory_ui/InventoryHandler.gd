extends Node

@onready var player_inventory = $UI/Inventory/PlayerInventory

# Called when the node enters the scene tree for the first time.
func _ready():
	player_inventory.populate_item_grid(ActivePlayer.player_data.inventory.OrbList)
	player_inventory.populate_info_panel(ActivePlayer.player_data.ready_orbs)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		var inv_scene = preload("res://init_test.tscn")
		get_tree().change_scene_to_packed(inv_scene)
