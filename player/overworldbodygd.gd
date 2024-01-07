extends CharacterBody2D

@export var speed = 80 # Speed of the player (pixels/sec)
var screen_size
var anim_dir = 'down'
signal collision

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.animation = anim_dir
		
func _physics_process(delta):
	player_movement(delta)
	
func player_movement(delta):
	velocity = Vector2(0, 0)
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		anim_dir = 'right'
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
		anim_dir = 'left'
	if Input.is_action_pressed("move_down"):
		velocity.y = speed
		anim_dir = 'down'
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
		anim_dir = 'up'
	
	var collide = move_and_collide(velocity * delta)
	if collide:
		emit_signal("collision")
