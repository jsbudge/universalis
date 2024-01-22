extends Control

const Slot = preload("res://inventory_ui/slot.tscn")

func _ready():
	$InventoryUI/ItemContainer.grab_focus()
	set_drag_forwarding(_get_drag_data, _can_drop_data, _drop_data)

func _can_drop_data(at_position, data):
	return true
	
func _drop_data(at_position, data):
	for sd in $InventoryUI/ItemContainer/ItemList.get_children():
		if sd.get_rect().contains(get_global_mouse_position()):
			var old_slot_data = sd.sdata
			sd.set_slot_data(data.sdata)
			data.set_slot_data(old_slot_data)
			
func _get_drag_data(at_position):
	for sd in $InventoryUI/ItemContainer/ItemList.get_children():
		if sd.get_rect().contains(get_global_mouse_position()):
			var drag_sd = Slot.instantiate()
			drag_sd.set_slot_data(sd.sdata)
			set_drag_preview(drag_sd)
			return sd
