extends PanelContainer

@export var sdata: SlotData

func set_slot_data(i: SlotData) -> void:
	sdata = i
	$PanelContainer/TextureRect.texture = i.texture
	tooltip_text = "%s\n%s" % [i.name, i.description]
	
	if i.is_stackable:
		$QuantityLabel.text = "x%i" % i.amount
		$QuantityLabel.show()
		
func highlight():
	$PanelContainer/ColorRect.visible = not $PanelContainer/ColorRect.visible
