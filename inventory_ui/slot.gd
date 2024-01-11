extends PanelContainer

@onready var texture_rect: TextureRect = $PanelContainer/TextureRect
@onready var quantity_label: Label = $QuantityLabel

func _set_slot_data(i):
	texture_rect.texture = i.texture
	tooltip_text = "%s\n%s" % [i.name, i.description]
	
	if is_instance_of(i, Item):
		quantity_label.text = "x%i" % i.amount
		quantity_label.show()
