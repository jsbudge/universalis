extends CharacterBody2D


@export var is_open: bool = false
@export var gold: int = 0
@export var shards: int = 0
@export var items: Array
var open_texture: AtlasTexture

# Called when the node enters the scene tree for the first time.
func _ready():
	var boxatlas = preload("res://assets/chests.tres")
	boxatlas.region = Rect2(0, 0, 16, 16)
	open_texture = boxatlas


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
func interact():
	if not is_open:
		is_open = true
		ActivePlayer.player_data.gold += gold
		ActivePlayer.player_data.shards += shards
		for i in items:
			ActivePlayer.addInventory(i)
		print("Interacted!")
		$Sprite2D.texture = open_texture
		set_collision_layer_value(3, 0)
