extends Node2D

@export var anima: int = 0
var is_occupied: bool = false
signal occupied


func _on_area_2d_body_entered(body):
	is_occupied = true
	emit_signal("occupied", body)


func _on_area_2d_body_exited(body):
	is_occupied = false
