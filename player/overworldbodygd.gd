extends CharacterBody2D

@export var speed = 100 # Speed of the player (pixels/sec)
var screen_size
var look_dir: Vector2 = Vector2(0, 1)
var anim_dir = 'down'
signal collision
signal react
signal interactable

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	connect("collision", ActivePlayer._on_overworld_body_collision)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.animation = anim_dir
	
func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, 
	global_position + look_dir * 30, 0b100, [self])
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	if result:
		emit_signal("interactable", true)
		if Input.is_action_pressed("overworld_interact"):
			result.collider.interact()
	else:
		emit_signal("interactable", false)
		
	player_movement(delta)
	
func player_movement(delta):
	velocity = Vector2(0, 0)
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		anim_dir = 'right'
	elif Input.is_action_pressed("move_left"):
		velocity.x = -speed
		anim_dir = 'left'
	elif Input.is_action_pressed("move_down"):
		velocity.y = speed
		anim_dir = 'down'
	elif Input.is_action_pressed("move_up"):
		velocity.y = -speed
		anim_dir = 'up'
	if not velocity.is_zero_approx():
		look_dir = velocity.normalized()
	
	var collide = move_and_collide(velocity * delta)
	
	if collide:
		emit_signal("collision")
