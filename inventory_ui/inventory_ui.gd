extends PanelContainer

const Slot = preload("res://inventory_ui/slot.tscn")

@onready var orb_grid: GridContainer = $ItemContainer/ItemList
@onready var info_panel = $ItemContainer/InfoPanel

func _ready():
	populate_item_grid(ActivePlayer.player_data.inventory.OrbList)
	populate_info_panel(ActivePlayer.player_data.ready_orbs)

func populate_item_grid(slot_data: Array[SlotData]) -> void:
	for child in orb_grid.get_children():
		child.queue_free()
		
	for sd in slot_data:
		var slot = Slot.instantiate()
		if sd:
			slot.set_slot_data(sd)
		orb_grid.add_child(slot)
			
func populate_info_panel(slot_data: Array) -> void:
	for child in info_panel.get_children():
		child.queue_free()
		
	for sd in slot_data:
		var slot = Slot.instantiate()
		if sd:
			slot.set_slot_data(sd)
		info_panel.add_child(slot)
