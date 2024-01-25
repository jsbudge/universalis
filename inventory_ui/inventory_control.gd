extends Control

const Slot = preload("res://inventory_ui/slot.tscn")

func _on_visibility_changed() -> void:
	if visible:
		grab_click_focus()


func _on_inventory_ui_update_displays():
	$PlayerInfoDisplay.updateItemDisplay($InventoryUI/TabBar.current_tab)
	$PlayerInfoDisplay.updateStatDisplay()
