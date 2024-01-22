extends Area2D

signal detection
var detected: bool = false
var detected_body: PhysicsBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if detected:
		var bodies = get_overlapping_bodies()
		for b in bodies:
			if b == detected_body:
				emit_signal("body_entered", detected_body)
