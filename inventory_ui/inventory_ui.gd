extends PanelContainer

const Slot = preload("res://inventory_ui/slot.tscn")
const orb_tab: int = 0
const equip_tab: int = 1
const cons_tab: int = 2
@onready var orb_grid: GridContainer = $ItemContainer/ItemList
@onready var info_panel = $ItemContainer/InfoPanel
@onready var tab_bar: TabBar = $TabBar

func _ready():
	populate_item_grid(ActivePlayer.player_data.inventory.OrbList)
	populate_info_panel(ActivePlayer.player_data.ready_orbs)
	tab_bar.add_tab("Orbs")
	tab_bar.add_tab("Equipment")
	tab_bar.add_tab("Items")

func populate_item_grid(slot_data: Array[SlotData]) -> void:
	for child in orb_grid.get_children():
		child.queue_free()
		
	for sd in slot_data:
		var slot = Slot.instantiate()
		if sd:
			slot.set_slot_data(sd)
			# slot.connect("swap_data", )
		orb_grid.add_child(slot)
			
func populate_info_panel(slot_data: Array) -> void:
	for child in info_panel.get_children():
		child.queue_free()
		
	for sd in slot_data:
		var slot = Slot.instantiate()
		if sd:
			slot.set_slot_data(sd)
		info_panel.add_child(slot)
	info_panel.grab_focus()


func _on_tab_bar_tab_changed(tab):
	info_panel.visible = true
	if tab == orb_tab:
		populate_item_grid(ActivePlayer.player_data.inventory.OrbList)
		populate_info_panel(ActivePlayer.player_data.ready_orbs)
	elif tab == equip_tab:
		populate_item_grid(ActivePlayer.player_data.inventory.EquipList)
		populate_info_panel(ActivePlayer.player_data.equipped)
	elif tab == cons_tab:
		populate_item_grid(ActivePlayer.player_data.inventory.ConsumableList)
		for child in info_panel.get_children():
			child.queue_free()
		info_panel.visible = false
	info_panel.grab_focus()


func _on_mouse_entered():
	for child in get_children():
		if child.has_method("highlight"):
			if child.get_rect().has_point(get_local_mouse_position()):
				child.highlight()
