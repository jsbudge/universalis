extends CharacterBody2D

@export var speed = 80 # Speed of the player (pixels/sec)
var screen_size
var anim_dir = 'down'
signal enemy_collision

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
func _physics_process(delta):
	_movement(delta)
	
func _movement(delta):
	var collide = move_and_collide(velocity * delta)
	if collide:
		emit_signal("enemy_collision")


func _on_enemy_motion(vel):
	velocity = vel * speed
