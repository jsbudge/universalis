extends Control

signal inventory_start
@onready var buttons_v_box = $MarginContainer/VBoxContainer/ButtonsVBox


func _on_inventory_button_pressed() -> void:
	emit_signal("inventory_start")
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
func _on_visibility_changed() -> void:
	if visible:
		focus_button()
		
func focus_button() -> void:
	if buttons_v_box:
		var button: Button = buttons_v_box.get_pressed()
		if button is Button:
			button.grab_focus()


func _on_continue_button_pressed():
	visible = false
