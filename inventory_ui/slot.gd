extends PanelContainer

@export var item_type: int = 0
@export var item_slot: int = -1
var draggable: bool = false
signal swap_data

func set_slot_data(_type, _slot, is_draggable: bool = false) -> void:
	var sdata = ActivePlayer.getArray(_type)[_slot]
	draggable = is_draggable
	if is_draggable:
		item_slot = _slot
	if sdata:
		item_slot = _slot
		draggable = true
		$PanelContainer/TextureRect.texture = sdata.texture
		tooltip_text = "%s\n%s" % [sdata.name, sdata.description]
		
		if sdata.is_stackable:
			$QuantityLabel.text = "x%i" % sdata.amount
			$QuantityLabel.show()
	item_type = _type

func highlight(onoff: bool):
	$PanelContainer/ColorRect.visible = onoff
	
func _can_drop_data(at_position, data):
	return data is Array
	
func _drop_data(at_position, data):
	highlight(false)
	emit_signal("swap_data", data, [item_type, item_slot])
	

func _get_drag_data(at_position):
	if draggable:
		var prev = TextureRect.new()
		prev.texture = $PanelContainer/TextureRect.texture
		set_drag_preview(prev)
		highlight(true)
	return [item_type, item_slot]
