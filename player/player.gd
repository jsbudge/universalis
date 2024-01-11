extends Node2D

signal hp_change
signal react


@export var inventory: InventoryDatabase
var hp = 100
var equipment: Array[Equipment]
var orbs: Array[Orb]
var stats: Array[int]
var modifiers: Array[float]

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("hp_change", 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_overworld_body_collision():
	emit_signal("hp_change", -1)
	emit_signal("react")
