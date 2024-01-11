extends PanelContainer

const Slot = preload("res://inventory_ui/slot.tscn")

@onready var orb_grid: GridContainer = $MarginContainer/OrbList

func _ready() -> void:
	var inv_data = preload("res://player/test_inventory.tres")
	populate_item_grid(inv_data.OrbList)
	
func populate_item_grid(slot_data: Array[Orb]) -> void:
	for child in orb_grid.get_children():
		child.queue_free()
		
	for sd in slot_data:
		var slot = Slot.instantiate()
		slot._set_slot_data(sd)
		orb_grid.add_child(slot)
