extends Node2D

signal motion


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_view_area_body_entered(body):
	print("Body entered")
	var space_state = get_world_2d().direct_space_state
	var point_vec = Vector2(body.position - position).normalized()
	var query = PhysicsRayQueryParameters2D.create(position, body.position + point_vec * 10)
	query.exclude = [self]
	var result = space_state.intersect_ray(query)
	if result:
		if result.collider == body:
			print("FOUND YOU!")
			emit_signal("motion", point_vec)
			$ViewArea.detected = true
			$ViewArea.detected_body = body


func _on_view_area_body_exited(body):
	emit_signal("motion", Vector2(0, 0))
	$ViewArea.detected = false
