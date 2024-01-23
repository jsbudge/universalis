extends PanelContainer

@export var sdata: SlotData
signal swap_data

func set_slot_data(i: SlotData) -> void:
	sdata = i
	$PanelContainer/TextureRect.texture = i.texture
	tooltip_text = "%s\n%s" % [i.name, i.description]
	
	if i.is_stackable:
		$QuantityLabel.text = "x%i" % i.amount
		$QuantityLabel.show()
		
func highlight():
	$PanelContainer/ColorRect.visible = not $PanelContainer/ColorRect.visible
	
func _can_drop_data(at_position, data):
	return data is SlotData
	
func _drop_data(at_position, data):
	set_slot_data(data)
	

func _get_drag_data(at_position):
	var prev = TextureRect.new()
	prev.texture = sdata.texture
	set_drag_preview(prev)
	return sdata
