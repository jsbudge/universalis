extends Node2D

signal motion


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_view_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print('entered')
	emit_signal("motion", (area.position - position).normalized())


func _on_view_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	emit_signal("motion", Vector2(0, 0))
