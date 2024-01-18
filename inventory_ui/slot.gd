extends PanelContainer

@onready var texture_rect = $PanelContainer/TextureRect
@onready var quantity_label = $QuantityLabel

func set_slot_data(i: SlotData) -> void:
	texture_rect = i.texture
	tooltip_text = "%s\n%s" % [i.name, i.description]
	
	if i.is_stackable:
		quantity_label.text = "x%i" % i.amount
		quantity_label.show()
