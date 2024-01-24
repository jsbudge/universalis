extends PanelContainer

const Slot = preload("res://inventory_ui/slot.tscn")
const orb_tab: int = 0
const equip_tab: int = 1
const cons_tab: int = 2
@onready var orb_grid: GridContainer = $ItemContainer/ItemList
@onready var info_panel = $ItemContainer/InfoPanel
@onready var tab_bar: TabBar = $TabBar

func _ready():
	populate_item_grid(tab_bar.current_tab)
	populate_info_panel(tab_bar.current_tab)
	tab_bar.add_tab("Orbs")
	tab_bar.add_tab("Equipment")
	tab_bar.add_tab("Items")

func populate_item_grid(curr_tab) -> void:
	for child in orb_grid.get_children():
		child.queue_free()
	var item_data = ActivePlayer.getArray(curr_tab)
	for sd in range(25):
		var slot = Slot.instantiate()
		if len(item_data) > sd:
			slot.connect("swap_data", _swap_data)
			slot.set_slot_data(curr_tab, sd)
		orb_grid.add_child(slot)
			
func populate_info_panel(curr_tab) -> void:
	for child in info_panel.get_children():
		child.queue_free()
	var item_data = ActivePlayer.getArray(curr_tab + 3)
	for sd in range(5):
		var slot = Slot.instantiate()
		slot.connect("swap_data", _swap_data)
		slot.set_slot_data(curr_tab + 3, sd, true)
		info_panel.add_child(slot)
	info_panel.grab_focus()


func _on_tab_bar_tab_changed(tab):
	info_panel.visible = true
	populate_item_grid(tab)
	if tab != cons_tab:
		populate_info_panel(tab)
	else:
		for child in info_panel.get_children():
			child.queue_free()
		info_panel.visible = false
	info_panel.grab_focus()


func _on_mouse_entered():
	for child in get_children():
		if child.has_method("highlight"):
			if child.get_rect().has_point(get_local_mouse_position()):
				child.highlight()
				
func _swap_data(swap_from, swap_to):
	ActivePlayer.swapItems(swap_from, swap_to)
	_on_tab_bar_tab_changed(tab_bar.current_tab)
		
		
		
